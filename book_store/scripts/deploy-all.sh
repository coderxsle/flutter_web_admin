#!/bin/bash

# 设置环境变量
ENV=${1:-prod}  # 默认为生产环境

# 检查环境参数
if [[ ! "$ENV" =~ ^(dev|test|prod)$ ]]; then
    echo "错误: 环境参数必须是 dev、test 或 prod"
    exit 1
fi

# 添加执行权限
chmod +x deploy-server.sh
chmod +x deploy-admin.sh

# 部署服务端
./deploy-server.sh $ENV

# 等待服务端启动
echo "等待服务端启动..."
sleep 10

# 部署管理后台
./deploy-admin.sh $ENV

echo "所有服务部署完成！环境：$ENV"
