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
docker compose down admin

# 构建并启动新容器
docker compose up -d admin

echo "管理后台部署完成！环境：$ENV"
