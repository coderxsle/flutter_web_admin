# Serverpod 后端镜像
# 构建上下文：backend/（Dart pub workspace 根目录）
# 构建命令：./build_image.sh
# APT_MIRROR 可传镜像站域名（如 mirrors.aliyun.com）加速 apt 下载，默认官方源。

ARG DART_IMAGE=dart:stable

# ---------- 构建阶段 ----------
FROM ${DART_IMAGE} AS build

ARG APT_MIRROR=""
ARG PUB_HOSTED_URL="https://pub.dev"
ENV PUB_HOSTED_URL=${PUB_HOSTED_URL}

# native assets（serverpod_argon2 / sqlite3）需要 C 工具链，只需要 cc + ar
RUN set -eux; \
    if [ -n "${APT_MIRROR}" ]; then \
      for f in /etc/apt/sources.list /etc/apt/sources.list.d/debian.sources; do \
        [ -f "$f" ] && sed -i "s|deb.debian.org|${APT_MIRROR}|g" "$f"; \
      done; \
    fi; \
    apt-get update; \
    apt-get install -y --no-install-recommends gcc libc6-dev make; \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 先复制各成员包的 pubspec，单独跑 pub get，让依赖层可缓存
COPY pubspec.yaml pubspec.lock ./
COPY flutter_web_server/pubspec.yaml flutter_web_server/
COPY flutter_web_client/pubspec.yaml flutter_web_client/
COPY serverpod_crud/pubspec.yaml serverpod_crud/
# serverpod_flutter 是 Flutter 客户端包，纯 dart 镜像里无 Flutter SDK，无法参与版本求解。
# 后端不依赖它，只在 override 里声明，构建期剔除该行；COPY . . 会还原原始 pubspec。
RUN sed -i '/^[[:space:]]*serverpod_flutter:/d' pubspec.yaml \
    && dart pub get

# 复制源码后编译 AOT 产物（含 native assets，输出 bundle/bin + bundle/lib）
COPY . .
# sqlite3 的 build hook 默认从 GitHub 下载预编译库，国内构建会 TLS 失败。
# 这里只在镜像构建期注入 user_defines，改用系统 libsqlite3，不改动仓库里的 pubspec。
RUN printf '\nhooks:\n  user_defines:\n    sqlite3:\n      source: system\n' >> pubspec.yaml \
    && dart build cli --target=flutter_web_server/bin/main.dart --output=/app/out

# ---------- 运行阶段 ----------
# Dart AOT 产物依赖 glibc，不能用 alpine（musl）
FROM debian:bookworm-slim

ARG APT_MIRROR=""

RUN set -eux; \
    if [ -n "${APT_MIRROR}" ]; then \
      for f in /etc/apt/sources.list /etc/apt/sources.list.d/debian.sources; do \
        [ -f "$f" ] && sed -i "s|deb.debian.org|${APT_MIRROR}|g" "$f"; \
      done; \
    fi; \
    apt-get update; \
    apt-get install -y --no-install-recommends ca-certificates curl tzdata libsqlite3-0; \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY --from=build /app/out/bundle /app/bundle
COPY --from=build /app/flutter_web_server/config /app/config
COPY --from=build /app/flutter_web_server/web /app/web
COPY --from=build /app/flutter_web_server/migrations /app/migrations

# Serverpod 4 启动参数，可用 docker run -e 覆盖
ENV runmode=production \
    serverid=default \
    logging=normal \
    role=monolith \
    LD_LIBRARY_PATH=/app/bundle/lib

EXPOSE 8080 8082

# 每次启动补齐未执行的迁移，空库首启才有表可查
ENTRYPOINT ["/app/bundle/bin/main"]
CMD ["--mode=production", "--server-id=default", "--logging=normal", "--role=monolith", "--apply-migrations"]
