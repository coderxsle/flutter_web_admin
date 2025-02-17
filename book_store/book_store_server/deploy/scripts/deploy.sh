#!/bin/bash

# 设置脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# 加载必要的工具脚本
source "${SCRIPT_DIR}/env_utils.sh"
source "${SCRIPT_DIR}/log_utils.sh"
source "${SCRIPT_DIR}/ssh.sh"
source "${SCRIPT_DIR}/system_utils.sh"


# 处理镜像上传选项
handle_image_upload_option() {
    log_info "是否需要上传镜像到服务器？(y/n，10秒后默认上传)"
    read -t 10 -n 1 answer
    echo
    
    if [ "$?" -gt 128 ]; then
        log_info "未收到输入，将执行默认操作：上传镜像"
        return 0
    elif [[ "${answer}" =~ ^[Nn]$ ]]; then
        log_info "已选择不上传镜像"
        return 1
    else
        log_info "已选择上传镜像"
        return 0
    fi
}

# 创建部署目录
create_deploy_dir() {
    log_info "确保部署目录存在..."
    if ! ssh_execute "sudo mkdir -p ${DEPLOY_PATH} && sudo chown -R ${SERVER_USER}:${SERVER_USER} ${DEPLOY_PATH}"; then
        log_error "创建部署目录失败"
        return 1
    fi
    log_info "部署目录已就绪: ${DEPLOY_PATH}"
    return 0
}

# 上传配置文件
upload_config_files() {
    local env=$1
    
    # 先确保部署目录存在
    create_deploy_dir || return 1
    
    log_info "上传配置文件到云端服务器..."
    for config_file in "docker-compose.yaml" "nginx.conf"; do
        log_info "上传配置文件 ${config_file}..."
        if ! scp_transfer \
            "${PROJECT_ROOT}/deploy/${env}/${config_file}" \
            "${SERVER_USER}@${SERVER_IP}:${DEPLOY_PATH}/"; then
            log_error "配置文件 ${config_file} 上传失败"
            return 1
        fi
    done

    # 上传环境变量文件
    log_info "上传环境变量文件到云端服务器..."
    local env_file_name
    env_file_name=$(get_env_file_name "$env") || return 1
    if ! scp_transfer \
        "${PROJECT_ROOT}/env/${env_file_name}" \
        "${SERVER_USER}@${SERVER_IP}:${DEPLOY_PATH}/${env_file_name}"; then
        log_error "环境变量文件上传失败"
        return 1
    fi
}

# 处理镜像文件清理
handle_image_cleanup() {
    local image_path=$1
    
    log_info "是否需要删除镜像文件？(y/n，10秒后默认保留)"
    read -t 10 -n 1 delete_tar
    echo

    if [[ "${delete_tar}" =~ ^[Yy]$ ]]; then
        log_info "删除服务器上的镜像文件..."
        if ! ssh_execute "rm -f ${image_path}"; then
            log_warn "删除镜像文件失败，但不影响部署过程"
        fi
    else
        if [ "$?" -gt 128 ]; then
            log_info "等待超时，默认保留镜像文件: ${image_path}"
        else
            log_info "保留镜像文件: ${image_path}"
        fi
    fi
}

# 上传并处理Docker镜像
handle_docker_image() {
    local env=$1
    local version=$2
    local image_name=$3
    
    local image_tar="${image_name}-${env}-${version}.tar"
    log_info "上传 Docker 镜像到云端服务器..."
    log_info "本地镜像文件路径: ${PWD}/${image_tar}"
    log_info "目标服务器路径: ${SERVER_USER}@${SERVER_IP}:${DEPLOY_PATH}/"
    
    if ! scp_transfer \
        "${image_tar}" \
        "${SERVER_USER}@${SERVER_IP}:${DEPLOY_PATH}/"; then
        log_error "镜像文件上传失败"
        return 1
    fi
    handle_image_cleanup "${DEPLOY_PATH}/${image_tar}"
}

# 配置Docker环境
setup_docker_environment() {
    log_info "检查 Docker 配置文件..."
    if ! ssh_execute "test -f /etc/docker/daemon.json"; then
        configure_docker_daemon
    fi
    verify_docker_service && verify_docker_hub_connection
}

# 配置Docker守护进程
configure_docker_daemon() {
    log_info "Docker 配置文件不存在，准备上传配置文件..."
    if ! ssh_execute "sudo mkdir -p /etc/docker && sudo chown ${SERVER_USER}: /etc/docker"; then
        log_error "创建Docker配置目录或设置权限失败"
        return 1
    fi
    
    if ! scp_transfer \
        "${SCRIPT_DIR}/../daemon.json" \
        "${SERVER_USER}@${SERVER_IP}:/etc/docker/daemon.json"; then
        log_error "Docker配置文件上传失败"
        return 1
    fi
    restart_docker_service
}

# 重启Docker服务
restart_docker_service() {
    if ! ssh_execute "sudo systemctl daemon-reload && sudo systemctl restart docker"; then
        log_error "重启Docker服务失败"
        return 1
    fi
    verify_docker_service && verify_docker_hub_connection
}

# 验证Docker服务状态
verify_docker_service() {
    log_info "验证 Docker 服务状态..."
    for i in {1..30}; do
        if ssh_execute "docker info > /dev/null 2>&1" >/dev/null 2>&1; then
            log_info "Docker 服务正常!"
            return 0
        fi
        if [ $i -eq 30 ]; then
            log_error "Docker 服务异常!"
            return 1
        fi
        printf "\r\033[K[INFO] 等待 Docker 服务就绪...（%d/30）" $i
        sleep 2
    done
}

# 等待Docker服务就绪
verify_docker_hub_connection() {
    log_info "验证镜像仓库连接..."
    for i in {1..30}; do
        if ssh_execute "docker pull hello-world > /dev/null 2>&1" >/dev/null 2>&1; then
            echo  # 换行
            log_info "镜像仓库连接正常！"
            return 0
        fi
        if [ $i -eq 30 ]; then
            echo  # 换行
            log_error "Docker 镜像仓库连接超时!"
            return 1
        fi
        printf "\r\033[K[INFO] 等待 Docker 镜像仓库连接...（%d/30）" $i
        sleep 2
    done
}

# 部署服务
deploy_service() {
    local env=$1
    local version=$2
    local image_name=$3
    stop_and_cleanup_containers
    load_and_start_containers "$env" "$version" "$image_name"
}

# 停止并清理容器
stop_and_cleanup_containers() {
    log_info "停止并删除旧容器..."
    # 只停止与当前项目相关的容器
    if ! ssh_execute "cd ${DEPLOY_PATH} && \
        containers=\$(docker ps -q --filter 'name=book_store') && \
        if [ ! -z \"\$containers\" ]; then \
            docker stop --time 10 \$containers || docker kill \$containers; \
        fi"; then
        log_warn "停止容器过程中出现警告，但将继续执行..."
    fi
    
    wait_for_containers_stop
    
    # 清理停止的容器和未使用的镜像
    ssh_execute "docker container prune -f" || true  # 清理所有停止的容器
    ssh_execute "docker images 'book_store*' -q | xargs -r docker rmi -f" || true  # 清理相关镜像
}

# 加载并启动容器
load_and_start_containers() {
    local env=$1
    local version=$2
    local image_name=$3
    local local_image_name="${image_name}-${env}-${version}.tar"
    
    log_info "在云端服务器上加载 Docker 镜像..."
    if ! ssh_execute "docker load -i ${DEPLOY_PATH}/${local_image_name}"; then
        log_error "镜像加载失败!"
        return 1
    fi
    
    start_containers "$env" "$version" "$image_name"
}

# 主部署函数
deploy_to_server() {
    local env=$1
    local version=${2:-$VERSION}
    local image_name=${3:-$IMAGE_NAME}
    local should_upload_image
    
    handle_image_upload_option
    should_upload_image=$?
    
    upload_config_files "$env" || return 1
    
    if [ $should_upload_image -eq 0 ]; then
        handle_docker_image "$env" "$version" "$image_name" || return 1
    else
        log_info "跳过镜像上传步骤"
    fi
    
    setup_docker_environment || return 1
    deploy_service "$env" "$version" "$image_name" || return 1
    
    log_info "服务部署成功"
    return 0
}



# 显示部署完成信息
show_deployment_done_info() {
    local image_name=$1
    local env=$2
    local version=$3
    
    log_info "部署完成！"
    log_info "--------------------------------------------------"
    show_deployment_info "$image_name" "$env" "$version"
    log_info "--------------------------------------------------"
    
    # 获取容器运行状态
    log_info "容器状态:"
    docker ps --filter "name=book-store-${env}" --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
}

# 显示部署信息
show_deployment_info() {
    local image_name=$1
    local env=$2
    local version=$3
    
    log_info "部署信息:"
    log_info "  镜像: ${image_name}"
    log_info "  环境: ${env}"
    log_info "  版本: ${version}"
    log_info "  部署路径: ${DEPLOY_PATH}"
    log_info "  服务器: ${SERVER_USER}@${SERVER_IP}"
}

# 记录部署历史
log_deployment_history() {
    local env=$1
    local version=$2
    local status=$3
    local timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    log_info "${timestamp} ${env} ${version} ${status}" >> "${BASE_DIR}/deploy/deploy_history.log"
}

# 发送部署通知
send_deployment_notification() {
    local env=$1
    local version=$2
    local status=$3
    local message="环境: ${env}\n版本: ${version}\n状态: ${status}\n时间: $(date '+%Y-%m-%d %H:%M:%S')"
    
    # 如果配置了通知 URL，发送通知
    if [ ! -z "${NOTIFICATION_URL}" ]; then
        curl -X POST "${NOTIFICATION_URL}" \
            -H "Content-Type: application/json" \
            -d "{\"text\":\"${message}\"}"
    fi
}




# 等待容器停止
wait_for_containers_stop() {
    log_info "等待容器完全停止..."
    local wait_count=0
    local max_wait=10  # 最多等待10秒
    while ssh_execute "docker ps -q --filter 'name=book_store_server' | grep -q ." >/dev/null 2>&1; do
        sleep 1
        wait_count=$((wait_count + 1))
        printf "\r\033[K[INFO] 等待容器停止中... (%d/%d秒)" $wait_count $max_wait
        
        if [ $wait_count -eq $max_wait ]; then
            echo  # 换行
            log_warn "等待容器停止超时，将强制继续..."
            return
        fi
    done
    
    echo  # 换行
    log_info "所有相关容器已停止!"
}

# 启动容器
start_containers() {
    local env=$1
    local version=$2
    local image_name=$3
    local env_file_name
    env_file_name=$(get_env_file_name "$env") || return 1
    
    log_info "启动新容器..."
    
    if ! ssh_execute "cd ${DEPLOY_PATH} && \
        set -a && source ${env_file_name} && set +a && \
        export IMAGE_NAME=${image_name}:${version} \
               VERSION=${version} && \
        docker compose up -d"; then
        log_error "服务部署失败"
        return 1
    fi
    verify_deployment
}

# 验证部署结果
verify_deployment() {
    log_info "验证部署结果..."
    
    # 等待容器启动
    log_info "等待容器启动..."
    sleep 5  # 给容器一些启动时间
    
    # 检查容器状态
    log_info "检查容器状态..."
    if ! ssh_execute "cd ${DEPLOY_PATH} && \
        set -a && source ${env_file_name} && set +a && \
        export IMAGE_NAME=${image_name}:${version} \
               VERSION=${version} && \
        docker compose ps"; then
        log_error "无法获取容器状态"
        return 1
    fi
    
    # 检查每个服务的状态
    log_info "检查各服务状态..."
    local services=("server" "postgres" "redis" "nginx")
    for service in "${services[@]}"; do
        log_info "检查 ${service} 服务状态..."
        if ! ssh_execute "cd ${DEPLOY_PATH} && \
            set -a && source ${env_file_name} && set +a && \
            export IMAGE_NAME=${image_name}:${version} \
                   VERSION=${version} && \
            docker compose ps ${service} | grep -q 'running'"; then
            log_error "${service} 服务未正常运行"
            log_info "获取 ${service} 服务日志..."
            ssh_execute "cd ${DEPLOY_PATH} && \
                set -a && source ${env_file_name} && set +a && \
                export IMAGE_NAME=${image_name}:${version} \
                       VERSION=${version} && \
                docker compose logs ${service}"
            return 1
        fi
    done
    
    # 显示所有容器的最新日志
    log_info "部署成功！显示各服务最新日志..."
    for service in "${services[@]}"; do
        log_info "=== ${service} 服务最新日志 ==="
        ssh_execute "cd ${DEPLOY_PATH} && \
            set -a && source ${env_file_name} && set +a && \
            export IMAGE_NAME=${image_name}:${version} \
                   VERSION=${version} && \
            docker compose logs --tail 20 ${service}"
        echo "----------------------------------------"
    done
    
    return 0
}

# 如果是直接运行此脚本
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    # 显示使用方法
    show_usage() {
        echo "使用方法: $0 <环境> <版本>"
        echo "示例: $0 prod 1.0.0"
        exit 1
    }
    
    # 检查参数
    if [ "$#" -lt 2 ]; then
        show_usage
    fi
    
    # 获取参数
    ENV=$1
    VERSION=$2
    
    # 加载环境变量
    load_env "$ENV" || exit 1
    
    # 使用环境变量中的配置
    deploy_to_server "$ENV" "$VERSION"
fi
