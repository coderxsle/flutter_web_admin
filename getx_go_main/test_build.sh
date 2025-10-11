#!/bin/bash

# 字体优化与性能测试脚本
# 用于验证字体加载优化是否生效，并分析资源加载性能

echo "🚀 开始测试字体优化与性能分析..."
echo ""

# 1. 清理旧的构建
echo "📦 清理旧的构建文件..."
flutter clean
echo "✅ 清理完成"
echo ""

# 2. 获取依赖
echo "📥 获取依赖..."
flutter pub get
echo "✅ 依赖获取完成"
echo ""

# 3. 构建 Web 版本
echo "🔨 构建 Web 版本..."
flutter build web --release --wasm
echo "✅ 构建完成"
echo ""

# 4. 检查构建产物
echo "🔍 检查构建产物..."
echo ""

# 5. 检查并清理端口占用
PORT=8888
if lsof -ti:$PORT > /dev/null 2>&1; then
    echo "⚠️  端口 $PORT 已被占用，正在清理..."
    lsof -ti:$PORT | xargs kill -9 2>/dev/null
    echo "✅ 端口清理完成"
    echo ""
fi

# 6. 启动本地服务器
echo "🌐 启动本地服务器..."
echo ""
echo "访问地址："
echo "  📱 应用地址: http://localhost:$PORT"
echo ""

cd build/web && python3 -m http.server $PORT

