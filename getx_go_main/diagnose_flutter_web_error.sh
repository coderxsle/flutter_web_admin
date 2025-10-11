#!/bin/bash

# Flutter Web 错误诊断脚本
# 用于快速诊断 async_patch.dart 和 initialization.dart 相关错误

# 不要在检查失败时退出
# set -e

echo "=================================================="
echo "  Flutter Web 错误诊断工具"
echo "=================================================="
echo ""

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 检查项计数
TOTAL_CHECKS=0
PASSED_CHECKS=0
FAILED_CHECKS=0
WARNING_CHECKS=0

function check_pass() {
    echo -e "${GREEN}✅ $1${NC}"
    ((PASSED_CHECKS++))
    ((TOTAL_CHECKS++))
}

function check_fail() {
    echo -e "${RED}❌ $1${NC}"
    ((FAILED_CHECKS++))
    ((TOTAL_CHECKS++))
}

function check_warn() {
    echo -e "${YELLOW}⚠️  $1${NC}"
    ((WARNING_CHECKS++))
    ((TOTAL_CHECKS++))
}

function info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

echo "📋 开始诊断..."
echo ""

# ============================================
# 1. 检查 Flutter 环境
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "1️⃣  检查 Flutter 环境"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if command -v flutter &> /dev/null; then
    FLUTTER_VERSION=$(flutter --version | head -1)
    check_pass "Flutter 已安装: $FLUTTER_VERSION"
else
    check_fail "Flutter 未安装"
    exit 1
fi
echo ""

# ============================================
# 2. 检查项目构建状态
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "2️⃣  检查项目构建状态"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ -d "build/web" ]; then
    check_pass "build/web 目录存在"
    
    # 检查关键文件
    if [ -f "build/web/main.dart.js" ]; then
        SIZE=$(ls -lh build/web/main.dart.js | awk '{print $5}')
        check_pass "main.dart.js 存在 (大小: $SIZE)"
    else
        check_fail "main.dart.js 不存在，需要重新构建"
    fi
    
    if [ -f "build/web/flutter.js" ]; then
        check_pass "flutter.js 存在"
    else
        check_fail "flutter.js 不存在"
    fi
    
    if [ -f "build/web/index.html" ]; then
        check_pass "index.html 存在"
    else
        check_fail "index.html 不存在"
    fi
else
    check_fail "build/web 目录不存在，需要运行 'flutter build web'"
fi
echo ""

# ============================================
# 3. 检查 CanvasKit 文件
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "3️⃣  检查 CanvasKit 文件"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ -d "build/web/canvaskit" ]; then
    check_pass "canvaskit 目录存在"
    
    # 检查关键 CanvasKit 文件
    CANVASKIT_FILES=(
        "canvaskit.wasm"
        "canvaskit.js"
        "skwasm.wasm"
        "skwasm_heavy.wasm"
    )
    
    for file in "${CANVASKIT_FILES[@]}"; do
        if [ -f "build/web/canvaskit/$file" ]; then
            SIZE=$(ls -lh "build/web/canvaskit/$file" | awk '{print $5}')
            check_pass "$file 存在 (大小: $SIZE)"
        else
            check_fail "$file 不存在"
        fi
    done
else
    check_warn "canvaskit 目录不存在（可能使用了 HTML 渲染器）"
fi
echo ""

# ============================================
# 4. 检查 Service Worker 配置
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "4️⃣  检查 Service Worker 配置"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ -f "web/sw-config.js" ]; then
    check_pass "web/sw-config.js 存在"
    
    # 检查是否复制到构建目录
    if [ -f "build/web/sw-config.js" ]; then
        check_pass "build/web/sw-config.js 已复制"
    else
        check_warn "build/web/sw-config.js 未复制，需要运行: cp web/sw-config.js build/web/"
    fi
    
    # 检查版本号
    if grep -q "CACHE_VERSION" web/sw-config.js; then
        VERSION=$(grep "CACHE_VERSION" web/sw-config.js | head -1)
        info "Service Worker 版本: $VERSION"
    fi
else
    check_warn "web/sw-config.js 不存在（可能未启用 Service Worker）"
fi

# 检查 index.html 中的 Service Worker 注册
if grep -q "navigator.serviceWorker.register" web/index.html; then
    check_pass "index.html 中已注册 Service Worker"
else
    check_warn "index.html 中未找到 Service Worker 注册代码"
fi
echo ""

# ============================================
# 5. 检查 CanvasKit CDN 配置
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "5️⃣  检查 CanvasKit CDN 配置"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if grep -q "canvasKitBaseUrl" web/index.html; then
    CDN_URL=$(grep -A1 "canvasKitBaseUrl" web/index.html | grep "http" | sed 's/.*"\(.*\)".*/\1/')
    check_pass "CanvasKit CDN 已配置"
    info "CDN 地址: $CDN_URL"
    
    # 测试 CDN 可访问性
    echo "   测试 CDN 连接..."
    if curl -s --head --max-time 5 "${CDN_URL}canvaskit.wasm" | grep "200 OK" > /dev/null; then
        check_pass "CDN 可访问"
    else
        check_fail "CDN 无法访问，可能导致 CanvasKit 加载失败"
        info "建议尝试其他 CDN:"
        echo "     - https://unpkg.com/canvaskit-wasm@0.40.0/bin/"
        echo "     - https://cdn.jsdelivr.net/npm/canvaskit-wasm@0.40.0/bin/"
    fi
else
    check_warn "未配置自定义 CanvasKit CDN（将使用默认源）"
fi
echo ""

# ============================================
# 6. 检查常见配置问题
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "6️⃣  检查常见配置问题"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

# 检查 pubspec.yaml
if [ -f "pubspec.yaml" ]; then
    check_pass "pubspec.yaml 存在"
else
    check_fail "pubspec.yaml 不存在"
fi

# 检查 .packages
if [ -f ".dart_tool/package_config.json" ]; then
    check_pass "依赖已安装"
else
    check_warn "依赖可能未安装，运行: flutter pub get"
fi

# 检查是否有编译错误
if [ -f "build/web/main.dart.js" ]; then
    if grep -q "Error" build/web/main.dart.js 2>/dev/null; then
        check_warn "main.dart.js 中可能包含错误"
    fi
fi
echo ""

# ============================================
# 7. 生成诊断报告
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "📊 诊断结果汇总"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo -e "总检查项: ${TOTAL_CHECKS}"
echo -e "${GREEN}通过: ${PASSED_CHECKS}${NC}"
echo -e "${RED}失败: ${FAILED_CHECKS}${NC}"
echo -e "${YELLOW}警告: ${WARNING_CHECKS}${NC}"
echo ""

# ============================================
# 8. 提供修复建议
# ============================================
if [ $FAILED_CHECKS -gt 0 ] || [ $WARNING_CHECKS -gt 0 ]; then
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "🔧 修复建议"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    
    if [ ! -d "build/web" ] || [ $FAILED_CHECKS -gt 0 ]; then
        echo -e "${YELLOW}建议 1: 清理并重新构建${NC}"
        echo "   flutter clean"
        echo "   flutter pub get"
        echo "   flutter build web"
        echo "   cp web/sw-config.js build/web/sw-config.js"
        echo ""
    fi
    
    if [ -f "web/sw-config.js" ] && [ ! -f "build/web/sw-config.js" ]; then
        echo -e "${YELLOW}建议 2: 复制 Service Worker 文件${NC}"
        echo "   cp web/sw-config.js build/web/sw-config.js"
        echo ""
    fi
    
    echo -e "${YELLOW}建议 3: 在浏览器中排查${NC}"
    echo "   1. 打开 Chrome DevTools (F12)"
    echo "   2. 切换到 Console 标签，查看完整错误信息"
    echo "   3. 切换到 Network 标签，查看哪些资源加载失败"
    echo "   4. 切换到 Application → Service Workers，检查 SW 状态"
    echo ""
    
    echo -e "${YELLOW}建议 4: 临时禁用 Service Worker（用于排查）${NC}"
    echo "   在浏览器控制台执行:"
    echo "   await window.swUtils.unregister();"
    echo "   window.location.reload();"
    echo ""
    
    echo -e "${YELLOW}建议 5: 检查网络连接${NC}"
    echo "   确保可以访问 CanvasKit CDN"
    echo "   curl -I https://cdn.jsdelivr.net/npm/canvaskit-wasm@0.40.0/bin/canvaskit.wasm"
    echo ""
fi

# ============================================
# 9. 针对 async_patch.dart 错误的特定建议
# ============================================
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "🎯 针对 async_patch.dart:582 错误的特定建议"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "这个错误通常与以下情况有关："
echo ""
echo "1️⃣  CanvasKit 加载失败"
echo "   → 检查 Network 标签中 canvaskit.wasm 是否成功加载"
echo "   → 尝试更换 CDN 或使用本地 CanvasKit"
echo ""
echo "2️⃣  Service Worker 缓存冲突"
echo "   → 在控制台执行: await window.swUtils.clearCache()"
echo "   → 或完全卸载: await window.swUtils.unregister()"
echo ""
echo "3️⃣  Flutter 引擎初始化超时"
echo "   → 检查网络速度，CanvasKit 文件较大（8-12MB）"
echo "   → 在开发环境可以临时禁用 Service Worker"
echo ""
echo "4️⃣  浏览器兼容性问题"
echo "   → 确保使用最新版 Chrome/Edge/Safari"
echo "   → 清除浏览器缓存后重试"
echo ""
echo "5️⃣  CORS 跨域问题"
echo "   → 确保 sw-config.js 与 index.html 在同一域名下"
echo "   → 检查服务器的 CORS 配置"
echo ""

echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "✅ 诊断完成！"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "如果问题仍未解决，请:"
echo "1. 复制浏览器控制台的完整错误信息"
echo "2. 截图 Network 标签（显示所有请求）"
echo "3. 查看 SERVICE_WORKER_GUIDE.md 的故障排查章节"
echo ""

