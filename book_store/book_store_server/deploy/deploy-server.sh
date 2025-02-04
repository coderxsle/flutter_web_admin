#!/bin/bash

# 检查参数
if [ "$#" -lt 1 ] || [ "$#" -gt 2 ]; then
    echo "Usage: $0 [prod|test|staging] [-c|--clean]"
    exit 1
fi

ENV=$1
CLEAN=false

# 检查是否有清理标志
if [ "$#" -eq 2 ] && { [ "$2" = "-c" ] || [ "$2" = "--clean" ]; }; then
    CLEAN=true
fi

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
