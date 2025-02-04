#!/bin/bash

# 设置环境变量
ENV=${1:-prod}  # 默认为生产环境
DEPLOY_DIR="./$ENV"

# 检查环境参数
if [[ ! "$ENV" =~ ^(dev|test|prod)$ ]]; then
    echo "错误: 环境参数必须是 dev、test 或 prod"
    exit 1
fi

# 进入部署目录
cd $DEPLOY_DIR || exit 1

# 停止并删除旧容器
docker compose down

# 构建并启动所有服务
# ✅ 作用：
# 	--build：强制重新构建镜像（即使已有缓存）。
# 	--detach（或 -d）：以 后台模式 运行容器，不会占用当前终端。

# ✅ 适用场景：
# 	•	当你修改了 Dockerfile 或 docker-compose.yml 后，需要重新构建镜像并启动容器。
# 	•	希望在后台运行，而不让终端被占用。
docker compose up --build --detach

echo "服务端部署完成！环境：$ENV"
