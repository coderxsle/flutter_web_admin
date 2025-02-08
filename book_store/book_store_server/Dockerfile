# 基础镜像
FROM --platform=$BUILDPLATFORM dart:3.3.0 AS build

# 设置工作目录
WORKDIR /app

# 复制所需的目录
COPY book_store_server book_store_server/
COPY book_store_shared book_store_shared/

# 进入服务器目录
WORKDIR /app/book_store_server

# 获取依赖
RUN dart pub get

# 编译
RUN dart compile exe bin/main.dart -o bin/server

# # 使用 Alpine 作为基础镜像
FROM alpine:3.19

# 安装必要的运行时依赖
RUN apk add --no-cache \
    ca-certificates \
    curl

# 设置环境变量
ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

# 复制运行时
COPY --from=build /runtime/ /
# 复制服务器
COPY --from=build /app/book_store_server/bin/server server
# 复制配置
COPY --from=build /app/book_store_server/confi[g]/ config/
# 复制静态文件
COPY --from=build /app/book_store_server/we[b]/ web/
# 复制迁移
COPY --from=build /app/book_store_server/migration[s]/ migrations/

WORKDIR /app

# 暴露端口
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

# 启动服务器 并应用数据库迁移
ENTRYPOINT ["/app/server", "--apply-migrations", "--mode=${runmode}", "--server-id=${serverid}", "--logging=${logging}", "--role=${role}"]


