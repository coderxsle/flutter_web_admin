#!/bin/bash

# 简单的时区验证脚本

echo "=== 验证PostgreSQL时区设置 ==="

# 检查容器是否运行
if ! docker ps | grep -q development-postgres-1; then
    echo "PostgreSQL容器未运行，请先启动容器"
    exit 1
fi

echo "1. 检查PostgreSQL时区设置："
docker exec development-postgres-1 psql -U postgres -d book_store -c "SHOW timezone;"

echo ""
echo "2. 检查当前时间："
docker exec development-postgres-1 psql -U postgres -d book_store -c "SELECT now();"

echo ""
echo "3. 检查系统时区："
docker exec development-postgres-1 date

echo ""
echo "4. 检查时区是否持久（重启PostgreSQL容器）："
echo "重启中..."
docker restart development-postgres-1
sleep 10

echo "重启后检查时区："
docker exec development-postgres-1 psql -U postgres -d book_store -c "SHOW timezone;"

echo ""
echo "=== 验证完成 ==="
echo "如果时区显示为 'Asia/Shanghai'，说明配置正确"
echo "如果时区显示为 'UTC'，说明配置不够持久"
