#!/bin/bash

# 构建前端镜像
docker build -t book_store_admin:latest .

# 停止旧容器
docker stop book_store_admin || true
docker rm book_store_admin || true

# 启动新容器
docker run -d \
  --name book_store_admin \
  -p 80:80 \
  book_store_admin:latest