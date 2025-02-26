# syntax=docker/dockerfile:1.4

# 🛠️ **构建阶段**
# 🔥 使用默认平台，但在 `buildx` 运行时正确解析
# 本地构建时，BUILDPLATFORM 为空，默认用 linux/amd64（适配 buildx）。
# 远程 buildx 运行时，Docker 会自动替换 BUILDPLATFORM，确保正确的架构。
# FROM dart:3.3.0 AS build
# FROM --platform=$BUILDPLATFORM dart:3.3.0 AS build
ARG BUILDPLATFORM
FROM --platform=${BUILDPLATFORM:-linux/amd64} dart:3.3.0 AS build

# 设置工作目录
WORKDIR /app

# 复制源码
COPY . book_store_server book_store_server/
COPY . book_store_shared book_store_shared/

# 进入服务器目录
WORKDIR /app/book_store_server


# 获取依赖
RUN dart pub get

# 🚀 编译成 Linux 可执行文件
RUN dart compile exe bin/main.dart -o bin/server --target-os=linux

# 🏗️ **运行时阶段**
FROM --platform=$TARGETPLATFORM alpine:3.19

# 安装运行时依赖
RUN --mount=type=cache,target=/var/cache/apk \
    apk add --no-cache \
    ca-certificates \
    curl

# 设置环境变量
ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

# 复制 Dart 运行时（如果有）
COPY --from=build /runtime/ /

# 复制编译后的 `server` 可执行文件， 复制配置、静态文件、数据库迁移
COPY --from=build /app/book_store_server/bin/server /app/server
# COPY --from=build /app/book_store_server/config/ /app/config/
# COPY --from=build /app/book_store_server/web/ /app/web/
# COPY --from=build /app/book_store_server/migrations/ /app/migrations/
COPY --from=build /app/book_store_server/confi[g]/ config/
COPY --from=build /app/book_store_server/we[b]/ web/
COPY --from=build /app/book_store_server/migration[s]/ migrations/

# 设置工作目录
WORKDIR /app

# 暴露端口
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

# 入口命令，应用数据库迁移并启动服务器
ENTRYPOINT /app/server \
  --apply-migrations \
  --mode=${runmode} \
  --server-id=${serverid} \
  --logging=${logging} \
  --role=${role}



