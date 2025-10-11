#!/bin/bash

# 字体优化验证脚本

echo "🔍 字体优化验证"
echo "================================"
echo ""

# 1. 检查 pubspec.yaml 中的字体配置
echo "✅ 1. 检查 pubspec.yaml 字体配置"
if grep -q "^  fonts:" pubspec.yaml; then
    echo "   ❌ pubspec.yaml 中仍有 fonts 配置（未注释）"
    echo "   建议：注释掉以避免重复打包"
else
    echo "   ✓ pubspec.yaml 中已注释 fonts 配置"
fi
echo ""

# 2. 检查 web/fonts 目录
echo "✅ 2. 检查 web/fonts 目录"
if [ -d "web/fonts" ]; then
    echo "   ✓ web/fonts 目录存在"
    ls -lh web/fonts/ | awk '{if(NR>1) printf "   - %s (%s)\n", $9, $5}'
else
    echo "   ❌ web/fonts 目录不存在"
fi
echo ""

# 3. 检查 web/index.html 中的字体定义
echo "✅ 3. 检查 web/index.html 字体定义"
if grep -q "@font-face" web/index.html; then
    echo "   ✓ index.html 中有 @font-face 定义"
    echo "   字体列表："
    grep -A 3 "font-family:" web/index.html | grep "font-family:" | sed "s/.*font-family: '\(.*\)'.*/   - \1/"
else
    echo "   ❌ index.html 中没有 @font-face 定义"
fi
echo ""

# 4. 检查预加载配置
echo "✅ 4. 检查字体预加载配置"
if grep -q 'rel="preload".*font' web/index.html; then
    echo "   ✓ 有预加载配置"
    grep 'rel="preload".*font' web/index.html | sed 's/.*href="\([^"]*\)".*/   - \1/'
else
    echo "   ⚠️  没有预加载配置（可选）"
fi
echo ""

# 5. 构建并检查输出
echo "✅ 5. 开始构建项目..."
flutter build web --release > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "   ✓ 构建成功"
    echo ""
    
    echo "✅ 6. 检查构建输出的字体位置"
    
    # 检查 build/web/fonts
    if [ -d "build/web/fonts" ]; then
        echo "   ✓ build/web/fonts 存在"
        ls -lh build/web/fonts/ | awk '{if(NR>1) printf "   - %s (%s)\n", $9, $5}'
    else
        echo "   ❌ build/web/fonts 不存在"
    fi
    echo ""
    
    # 检查 build/web/assets/assets/fonts
    if [ -d "build/web/assets/assets/fonts" ]; then
        echo "   ❌ build/web/assets/assets/fonts 存在（重复打包）"
        ls -lh build/web/assets/assets/fonts/ | awk '{if(NR>1) printf "   - %s (%s)\n", $9, $5}'
        echo "   建议：确保 pubspec.yaml 中的 fonts 配置已注释"
    else
        echo "   ✓ build/web/assets/assets/fonts 不存在（无重复）"
    fi
    echo ""
    
    # 统计字体总大小
    echo "✅ 7. 字体文件大小统计"
    if [ -d "build/web/fonts" ]; then
        total_size=$(du -sh build/web/fonts 2>/dev/null | awk '{print $1}')
        echo "   总大小: $total_size"
    fi
    echo ""
    
    # 检查 index.html 中的 font-display
    echo "✅ 8. 检查 font-display 优化"
    if grep -q "font-display:" build/web/index.html; then
        echo "   ✓ 使用了 font-display 优化"
        grep "font-display:" build/web/index.html | sed 's/.*font-display: \([^;]*\);.*/   - \1/' | sort -u
    else
        echo "   ❌ 未使用 font-display 优化"
    fi
    
else
    echo "   ❌ 构建失败"
fi

echo ""
echo "================================"
echo "✨ 优化建议："
echo ""
echo "1. 如果 build/web/assets/assets/fonts 仍存在："
echo "   → 确保 pubspec.yaml 中的 fonts 配置已完全注释"
echo ""
echo "2. 如果 NotoSansSC 加载仍然很慢："
echo "   → 考虑使用字体子集化（pyftsubset）"
echo "   → 或转换为 woff2 格式"
echo ""
echo "3. 测试字体加载："
echo "   → 打开 build/web/index.html"
echo "   → F12 → Network → Font"
echo "   → 刷新页面，检查每个字体只加载一次"
echo ""


