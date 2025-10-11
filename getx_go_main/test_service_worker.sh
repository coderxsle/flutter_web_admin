#!/bin/bash

# Service Worker 测试脚本
# 用于验证 Service Worker 是否正确配置和工作

set -e

echo "=================================================="
echo "  Flutter Web Service Worker 测试脚本"
echo "=================================================="
echo ""

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# 检查是否已构建
if [ ! -d "build/web" ]; then
    echo -e "${YELLOW}⚠️  build/web 目录不存在，正在构建...${NC}"
    flutter build web --web-renderer auto
    echo ""
fi

# 检查 sw-config.js 是否存在
echo "1️⃣  检查 Service Worker 配置文件..."
if [ -f "web/sw-config.js" ]; then
    echo -e "${GREEN}✅ sw-config.js 存在${NC}"
    FILE_SIZE=$(ls -lh web/sw-config.js | awk '{print $5}')
    echo "   文件大小: $FILE_SIZE"
else
    echo -e "${RED}❌ sw-config.js 不存在${NC}"
    exit 1
fi
echo ""

# 检查 index.html 中是否包含 Service Worker 注册代码
echo "2️⃣  检查 index.html 集成..."
if grep -q "navigator.serviceWorker.register('/sw-config.js')" web/index.html; then
    echo -e "${GREEN}✅ Service Worker 注册代码已添加${NC}"
else
    echo -e "${RED}❌ index.html 中未找到 Service Worker 注册代码${NC}"
    exit 1
fi
echo ""

# 检查 CanvasKit CDN 配置
echo "3️⃣  检查 CanvasKit CDN 配置..."
if grep -q "canvasKitBaseUrl" web/index.html; then
    CDN_URL=$(grep -o 'canvasKitBaseUrl.*' web/index.html | head -1)
    echo -e "${GREEN}✅ CanvasKit CDN 已配置${NC}"
    echo "   $CDN_URL"
else
    echo -e "${YELLOW}⚠️  未找到 CanvasKit CDN 配置，将使用默认源${NC}"
fi
echo ""

# 构建项目（如果需要）
echo "4️⃣  构建 Flutter Web 应用..."
echo -e "${YELLOW}   Flutter 3.35+ 默认使用 CanvasKit 渲染器${NC}"
flutter build web
echo -e "${GREEN}✅ 构建完成${NC}"
echo ""

# 复制 sw-config.js 到 build 目录
echo "5️⃣  部署 Service Worker 文件..."
cp web/sw-config.js build/web/sw-config.js
echo -e "${GREEN}✅ sw-config.js 已复制到 build/web/${NC}"
echo ""

# 检查 build 目录中的 CanvasKit 文件
echo "6️⃣  检查 CanvasKit 文件..."
if [ -d "build/web/canvaskit" ]; then
    echo -e "${GREEN}✅ CanvasKit 目录存在${NC}"
    
    # 统计文件和大小
    CANVASKIT_COUNT=$(find build/web/canvaskit -type f | wc -l | tr -d ' ')
    CANVASKIT_SIZE=$(du -sh build/web/canvaskit | awk '{print $1}')
    
    echo "   文件数量: $CANVASKIT_COUNT"
    echo "   总大小: $CANVASKIT_SIZE"
    
    # 列出关键文件
    echo "   关键文件:"
    if [ -f "build/web/canvaskit/canvaskit.wasm" ]; then
        SIZE=$(ls -lh build/web/canvaskit/canvaskit.wasm | awk '{print $5}')
        echo "     - canvaskit.wasm ($SIZE)"
    fi
    if [ -f "build/web/canvaskit/skwasm_heavy.wasm" ]; then
        SIZE=$(ls -lh build/web/canvaskit/skwasm_heavy.wasm | awk '{print $5}')
        echo "     - skwasm_heavy.wasm ($SIZE)"
    fi
else
    echo -e "${YELLOW}⚠️  CanvasKit 目录不存在（可能使用了 HTML 渲染器）${NC}"
fi
echo ""

# 启动本地服务器进行测试
echo "7️⃣  启动本地测试服务器..."
echo -e "${YELLOW}   访问 http://localhost:8080 进行测试${NC}"
echo ""
echo "测试步骤:"
echo "1. 打开浏览器访问 http://localhost:8080"
echo "2. 打开浏览器开发者工具 (F12)"
echo "3. 切换到 Application → Service Workers 标签"
echo "4. 应该能看到 sw-config.js 已注册"
echo "5. 切换到 Console 标签，应该能看到:"
echo "   - [SW] Service Worker 脚本已加载"
echo "   - [SW] Service Worker 安装中..."
echo "   - [SW] Service Worker 激活中..."
echo "   - [App] Service Worker 注册成功"
echo "6. 刷新页面，检查 Network 标签中的 canvaskit.wasm 是否显示 (disk cache)"
echo "7. 在 Console 中运行: window.swUtils.getCacheStats()"
echo ""
echo "缓存管理命令（在浏览器 Console 中执行）:"
echo "  - window.swUtils.getCacheStats()  // 查看缓存统计"
echo "  - window.swUtils.clearCache()     // 清除所有缓存"
echo "  - window.swUtils.update()         // 更新 Service Worker"
echo "  - window.swUtils.unregister()     // 卸载 Service Worker"
echo ""
echo -e "${YELLOW}按 Ctrl+C 停止服务器${NC}"
echo ""
echo "=================================================="

# 检查是否安装了 http-server
if command -v python3 &> /dev/null; then
    # 使用 Python 的简单 HTTP 服务器
    cd build/web && python3 -m http.server 8080
elif command -v python &> /dev/null; then
    cd build/web && python -m SimpleHTTPServer 8080
elif command -v php &> /dev/null; then
    # 使用 PHP 内置服务器
    cd build/web && php -S localhost:8080
else
    echo -e "${RED}❌ 未找到可用的 HTTP 服务器${NC}"
    echo "请安装以下任一工具:"
    echo "  - Python 3: python3 -m http.server"
    echo "  - Python 2: python -m SimpleHTTPServer"
    echo "  - PHP: php -S localhost:8080"
    echo "  - Node.js: npm install -g http-server && http-server"
    echo ""
    echo "或手动部署 build/web 目录到你的 Web 服务器"
    exit 1
fi

