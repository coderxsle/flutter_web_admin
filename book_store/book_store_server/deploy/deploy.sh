 #!/bin/bash

# 设置工作目录
cd "$(dirname "$0")"

# 加载配置文件
if [ -f "config.env" ]; then
    source config.env
else
    echo "错误: 配置文件 config.env 不存在"
    exit 1
fi

# 日志函数
LOG_FILE="deploy_history.log"
function log() {
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[${timestamp}] $1" | tee -a ${LOG_FILE}
}

# 颜色输出函数
function echo_color() {
    case $1 in
        "green") echo -e "\033[32m$2\033[0m" ;;
        "red") echo -e "\033[31m$2\033[0m" ;;
        "yellow") echo -e "\033[33m$2\033[0m" ;;
        *) echo "$2";;
    esac
    log "$2"
}

# 健康检查函数
function check_health() {
    local retries=30
    local wait_time=10
    local counter=0
    echo_color yellow "开始健康检查..."
    
    while [ $counter -lt $retries ]; do
        if ssh -p ${SERVER_PORT} ${SERVER_USER}@${SERVER_IP} "curl -sf http://localhost:8080/health"; then
            echo_color green "服务健康检查通过！"
            return 0
        fi
        let counter++
        echo_color yellow "等待服务启动... (${counter}/${retries})"
        sleep $wait_time
    done
    echo_color red "健康检查失败！"
    return 1
}

# 回滚函数
function rollback() {
    echo_color red "开始执行回滚操作..."
    ssh -p ${SERVER_PORT} ${SERVER_USER}@${SERVER_IP} "cd ${DEPLOY_PATH} && \
        docker-compose down && \
        docker tag ${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:previous ${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${VERSION} && \
        docker-compose up -d"
    
    if [ $? -eq 0 ]; then
        echo_color green "回滚成功！"
    else
        echo_color red "回滚失败！请手动检查服务状态"
        exit 1
    fi
}

# 错误处理
set -e
trap 'echo_color red "部署失败: 第 $LINENO 行出现错误"; rollback' ERR

# 检查必要的命令
for cmd in docker docker-compose ssh scp curl; do
    if ! command -v $cmd &> /dev/null; then
        echo_color red "错误: 命令 '$cmd' 未安装"
        exit 1
    fi
done

# 开始部署流程
echo_color green "=== 开始部署流程 ==="
log "开始新的部署任务"

# 1. 备份当前版本
echo_color green "备份当前版本..."
ssh -p ${SERVER_PORT} ${SERVER_USER}@${SERVER_IP} "cd ${DEPLOY_PATH} && \
    docker tag ${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${VERSION} ${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:previous || true"

# 2. 构建镜像
echo_color green "构建 Docker 镜像..."
docker build -t $IMAGE_NAME:$VERSION . --no-cache



# 3. 标记镜像
echo_color green "标记镜像..."
docker tag $IMAGE_NAME:$VERSION $REGISTRY/$NAMESPACE/$IMAGE_NAME:$VERSION

# 4. 推送镜像
echo_color green "推送镜像到仓库..."
docker push $REGISTRY/$NAMESPACE/$IMAGE_NAME:$VERSION

# 5. 准备部署文件
echo_color green "准备部署文件..."
cat > docker-compose.yml <<EOF
version: '3'
services:
  ${IMAGE_NAME}:
    image: ${REGISTRY}/${NAMESPACE}/${IMAGE_NAME}:${VERSION}
    container_name: ${IMAGE_NAME}
    restart: always
    labels:
      - "com.docker.compose.project=${IMAGE_NAME}"
      - "com.docker.compose.service=app"
      - "maintainer=${MAINTAINER}"
      - "version=${VERSION}"
      - "portainer.group=production"
      - "portainer.notes=生产环境应用"
    ports:
      - "${PORT}:8080"
    environment:
      - POSTGRES_DB=${POSTGRES_DB}
      - POSTGRES_USER=${POSTGRES_USER}
      - POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
      - REDIS_PASSWORD=${REDIS_PASSWORD}
      - TZ=Asia/Shanghai
    volumes:
      - ${DEPLOY_PATH}/logs:/app/logs
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost:8080/health"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 40s
    networks:
      - app-network
    deploy:
      resources:
        limits:
          cpus: '${CPU_LIMIT}'
          memory: ${MEMORY_LIMIT}
        reservations:
          cpus: '${CPU_RESERVATION}'
          memory: ${MEMORY_RESERVATION}

networks:
  app-network:
    external: true
EOF

# 6. 传输配置文件
echo_color green "传输配置文件到服务器..."
scp -P ${SERVER_PORT} docker-compose.yml ${SERVER_USER}@${SERVER_IP}:${DEPLOY_PATH}/

# 7. 执行远程部署
echo_color green "在服务器上执行部署..."
ssh -p ${SERVER_PORT} ${SERVER_USER}@${SERVER_IP} "cd ${DEPLOY_PATH} && \
    docker login ${REGISTRY} -u ${REGISTRY_USER} -p ${REGISTRY_PASSWORD} && \
    docker-compose pull && \
    docker-compose down && \
    docker-compose up -d && \
    docker image prune -f"

# 8. 健康检查
if ! check_health; then
    echo_color red "部署可能存在问题，开始回滚..."
    rollback
    exit 1
fi

# 9. 检查部署状态
echo_color green "检查最终部署状态..."
ssh -p ${SERVER_PORT} ${SERVER_USER}@${SERVER_IP} "docker ps | grep ${IMAGE_NAME}"

# 10. 清理本地临时文件
rm -f docker-compose.yml

echo_color green "=== 部署完成 ==="
log "部署任务完成"