# 构建阶段
FROM debian:latest AS build

# 安装 Flutter SDK
RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"
RUN flutter doctor
RUN flutter config --enable-web

# 复制项目文件
WORKDIR /app
COPY . .

# 获取依赖并构建
RUN flutter pub get
RUN flutter build web --release

# 运行阶段
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html 