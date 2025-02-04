# 基础镜像
FROM dart:3.3.0 AS build

# 设置工作目录
WORKDIR /app

# 复制整个项目目录
COPY . .

# 获取依赖
RUN dart pub get

# 编译
RUN dart compile exe bin/main.dart -o bin/server

# 基础镜像
FROM alpine:latest

# 设置环境变量
ENV runmode=production
ENV serverid=default
ENV logging=normal
ENV role=monolith

# 复制运行时
COPY --from=build /runtime/ /
# 复制服务器
COPY --from=build /app/bin/server server
# 复制配置
COPY --from=build /app/confi[g]/ config/
# 复制静态文件
COPY --from=build /app/we[b]]/ web/
# 复制迁移
COPY --from=build /app/migration[s]/ migrations/


# 暴露端口
EXPOSE 8080
EXPOSE 8081
EXPOSE 8082

# 启动服务器 并应用数据库迁移
ENTRYPOINT ./server --mode=$runmode --server-id=$serverid --logging=$logging --role=$role --apply-migrations

