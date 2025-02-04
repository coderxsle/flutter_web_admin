#!/bin/bash

# 检查参数
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [prod|test|staging]"
    exit 1
fi

ENV=$1

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
set -a
source "$ENV_FILE"
set +a

# 进入服务器目录
cd ..

# 运行数据库迁移
dart run serverpod generate --run-migrations 