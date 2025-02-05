#!/bin/bash

# 检查参数
if [ "$#" -lt 1 ] || [ "$#" -gt 3 ]; then
    echo "Usage: $0 [prod|test|staging] [-c|--clean] [--remote]"
    exit 1
fi

ENV=$1
CLEAN=false
REMOTE=false
REMOTE_HOST="116.205.108.41"  # 替换为您的华为云服务器IP
REMOTE_USER="root"  # 替换为您的SSH用户名

# 检查参数
for arg in "$@"; do
    case $arg in
        -c|--clean)
            CLEAN=true
            ;;
        --remote)
            REMOTE=true
            ;;
    esac
done

# 验证环境参数
if [ "$ENV" != "prod" ] && [ "$ENV" != "test" ] && [ "$ENV" != "staging" ]; then
    echo "Invalid environment. Use 'prod', 'test', or 'staging'"
    exit 1
fi

# 设置环境变量文件路径
case "$ENV" in
    "prod")
        ENV_FILE="../env/.env.production"
        ;;
    "test")
        ENV_FILE="../env/.env.test"
        ;;
    "staging")
        ENV_FILE="../env/.env.staging"
        ;;
esac

# 检查环境变量文件是否存在
if [ ! -f "$ENV_FILE" ]; then
    echo "Error: Environment file $ENV_FILE not found"
    exit 1
fi

# 加载环境变量
set -a  # 自动导出所有变量
source "$ENV_FILE"
set +a

# 进入对应的部署目录
cd "$ENV"

# 停止并删除旧容器
docker compose down

# 如果需要清理，删除数据卷
if [ "$CLEAN" = true ]; then
    echo "Cleaning up data volumes..."
    docker volume rm "${ENV}_book_store_data" || true
fi

# 构建并启动所有服务
# 构建并启动所有服务
# ✅ 作用：
# 	--build：强制重新构建镜像（即使已有缓存）。
# 	--detach（或 -d）：以 后台模式 运行容器，不会占用当前终端。
#
# ✅ 适用场景：
# 	•	当你修改了 Dockerfile 或 docker-compose.yml 后，需要重新构建镜像并启动容器。
# 	•	希望在后台运行，而不让终端被占用。
docker compose up --build --detach

# 等待数据库启动
echo "Waiting for database to start..."
sleep 10

# 运行数据库迁移
echo "Running database migrations..."
cd ..
dart run serverpod generate --run-migrations
cd "$ENV"

echo "服务端部署完成！环境：$ENV"

if [ "$REMOTE" = true ]; then
    echo "准备远程部署到华为云服务器..."
    
    # 创建远程部署目录
    ssh $REMOTE_USER@$REMOTE_HOST "mkdir -p /opt/book_store"
    
    # 复制必要文件到远程服务器
    scp -r ../$ENV/docker-compose.yaml $REMOTE_USER@$REMOTE_HOST:/opt/book_store/
    scp -r ../Dockerfile $REMOTE_USER@$REMOTE_HOST:/opt/book_store/
    scp -r ../$ENV/nginx.conf $REMOTE_USER@$REMOTE_HOST:/opt/book_store/
    scp -r ../$ENV/logs $REMOTE_USER@$REMOTE_HOST:/opt/book_store/
    scp -r $ENV_FILE $REMOTE_USER@$REMOTE_HOST:/opt/book_store/env/
    scp -r ../config $REMOTE_USER@$REMOTE_HOST:/opt/book_store/
    
    # 在远程服务器上执行部署命令
    ssh $REMOTE_USER@$REMOTE_HOST "cd /opt/book_store && \
        docker compose -f docker-compose.yaml down && \
        [ "$CLEAN" = true ] && docker volume rm ${ENV}_book_store_data || true && \
        docker compose -f docker-compose.yaml up --build -d"
    
    echo "远程部署完成！环境：$ENV"
else
    # 本地部署逻辑保持不变
    # ... 原有的本地部署代码 ...
fi
