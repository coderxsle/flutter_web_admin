#!/bin/bash
set -e # 任何命令失败则立即终止脚本

# 步骤1: Maven 打包
echo "🔨 正在执行 Maven 打包..."
mvn clean package
if [ $? -ne 0 ]; then
    echo "❌ Maven 打包失败，请检查错误信息"
    exit 1
fi
echo "✅ Maven 打包成功"

# 步骤2: 复制文件
SOURCE_DIR="./continew-webapi/target/app"
DEST_DIR="./docker/continew-admin"

echo "📂 正在复制文件: $SOURCE_DIR -> $DEST_DIR"
if [ ! -d "$SOURCE_DIR" ]; then
    echo "❌ 源目录不存在: $SOURCE_DIR"
    exit 1
fi

mkdir -p "$DEST_DIR" # 自动创建目标目录
cp -rfv "$SOURCE_DIR"/* "$DEST_DIR"/
echo "✅ continew-webapi 文件复制完成"


# 步骤2.1: 复制定时任务服务JAR文件（保持原文件名）
SCHEDULE_JAR="./continew-extension/continew-extension-schedule-server/target/continew-extension-schedule-server.jar"
SCHEDULE_DEST_DIR="./docker/schedule-server"

read -p "❓ 是否复制定时任务服务JAR文件？(y/n): " choice
if [[ "$choice" =~ ^[Yy]$ ]]; then
    echo "📂 正在复制定时任务服务JAR文件（保留原文件名）: $SCHEDULE_JAR -> $SCHEDULE_DEST_DIR"
    if [ ! -f "$SCHEDULE_JAR" ]; then
        echo "❌ 定时任务服务JAR文件不存在: $SCHEDULE_JAR"
        exit 1
    fi

    mkdir -p "$SCHEDULE_DEST_DIR"  # 自动创建目标目录
    cp -fv "$SCHEDULE_JAR" "$SCHEDULE_DEST_DIR/"  # 关键修改：目标路径改为目录路径
    echo "✅ 定时任务服务JAR文件复制完成（保留原文件名）"
else
    echo "🚫 跳过定时任务服务JAR文件复制"
fi


# 步骤3: 构建 Docker
# echo "🐳 正在启动 Docker 容器..."
# cd docker && docker compose up --build -d
# if [ $? -ne 0 ]; then
#     echo "❌ Docker 启动失败"
#     exit 1
# fi
# echo "✅ 容器已启动，可使用以下命令查看日志: docker compose logs -f"

# echo "🎉 部署完成"
