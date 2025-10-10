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
flutter build web --release
echo "✅ 构建完成"
echo ""

# 4. 检查构建产物
echo "🔍 检查构建产物..."
echo ""

# 检查字体文件是否存在
echo "检查字体文件："
if [ -f "build/web/assets/fonts/NotoSansSC-Regular.ttf" ]; then
    echo "  ✅ NotoSansSC-Regular.ttf 存在"
    ls -lh build/web/assets/fonts/NotoSansSC-Regular.ttf | awk '{print "     大小: " $5}'
else
    echo "  ❌ NotoSansSC-Regular.ttf 不存在"
fi

if [ -f "build/web/assets/fonts/Roboto-Regular.ttf" ]; then
    echo "  ✅ Roboto-Regular.ttf 存在"
    ls -lh build/web/assets/fonts/Roboto-Regular.ttf | awk '{print "     大小: " $5}'
else
    echo "  ❌ Roboto-Regular.ttf 不存在"
fi

if [ -f "build/web/assets/fonts/Roboto-Bold.ttf" ]; then
    echo "  ✅ Roboto-Bold.ttf 存在"
    ls -lh build/web/assets/fonts/Roboto-Bold.ttf | awk '{print "     大小: " $5}'
else
    echo "  ❌ Roboto-Bold.ttf 不存在"
fi

echo ""

# 检查 index.html 中的字体配置
echo "检查 index.html 配置："
if grep -q "font-src 'self'" build/web/index.html; then
    echo "  ✅ CSP 策略已配置"
else
    echo "  ⚠️  CSP 策略未配置"
fi

if grep -q "preload.*fonts.*ttf" build/web/index.html; then
    echo "  ✅ 字体预加载已配置"
else
    echo "  ⚠️  字体预加载未配置"
fi

if grep -q "@font-face" build/web/index.html; then
    echo "  ✅ @font-face 定义存在"
else
    echo "  ⚠️  @font-face 定义不存在"
fi

if grep -q "Google Fonts 拦截器" build/web/index.html; then
    echo "  ✅ Google Fonts 拦截器已配置"
else
    echo "  ⚠️  Google Fonts 拦截器未配置"
fi

echo ""

# 5. 搜索 Google Fonts 引用
echo "🔍 搜索 Google Fonts 引用..."
if grep -r "fonts.googleapis.com\|fonts.gstatic.com" build/web/*.html 2>/dev/null; then
    echo "  ⚠️  在 HTML 文件中发现 Google Fonts 引用"
else
    echo "  ✅ HTML 文件中没有 Google Fonts 引用"
fi

# 注意：main.dart.js 中可能有硬编码的 URL，但会被拦截器阻止
if grep -q "fonts.googleapis.com\|fonts.gstatic.com" build/web/main.dart.js 2>/dev/null; then
    echo "  ℹ️  main.dart.js 中存在 Google Fonts URL（会被拦截器阻止）"
fi

echo ""

# 6. 检查并清理端口占用
PORT=8888
if lsof -ti:$PORT > /dev/null 2>&1; then
    echo "⚠️  端口 $PORT 已被占用，正在清理..."
    lsof -ti:$PORT | xargs kill -9 2>/dev/null
    echo "✅ 端口清理完成"
    echo ""
fi

# 7. 创建性能分析 HTML 页面
echo "📊 创建性能分析工具..."
cat > build/web/performance_test.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>资源加载性能分析</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Arial, sans-serif;
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      padding: 20px;
      min-height: 100vh;
    }
    .container {
      max-width: 1400px;
      margin: 0 auto;
      background: white;
      border-radius: 12px;
      box-shadow: 0 20px 60px rgba(0,0,0,0.3);
      overflow: hidden;
    }
    .header {
      background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
      color: white;
      padding: 30px;
      text-align: center;
    }
    .header h1 { font-size: 28px; margin-bottom: 10px; }
    .header p { opacity: 0.9; }
    .controls {
      padding: 20px;
      background: #f8f9fa;
      border-bottom: 1px solid #e9ecef;
      display: flex;
      gap: 10px;
      align-items: center;
    }
    .btn {
      padding: 10px 20px;
      border: none;
      border-radius: 6px;
      font-size: 14px;
      cursor: pointer;
      font-weight: 600;
      transition: all 0.3s;
    }
    .btn-primary {
      background: #667eea;
      color: white;
    }
    .btn-primary:hover { background: #5568d3; }
    .btn-success {
      background: #10b981;
      color: white;
    }
    .btn-success:hover { background: #059669; }
    .stats {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 20px;
      padding: 20px;
      background: #f8f9fa;
    }
    .stat-card {
      background: white;
      padding: 20px;
      border-radius: 8px;
      border-left: 4px solid #667eea;
    }
    .stat-label {
      color: #6c757d;
      font-size: 12px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
      margin-bottom: 8px;
    }
    .stat-value {
      font-size: 24px;
      font-weight: 700;
      color: #212529;
    }
    .resources {
      padding: 20px;
    }
    .resource-item {
      display: grid;
      grid-template-columns: 40px 1fr 120px 100px 80px;
      gap: 15px;
      padding: 15px;
      border-bottom: 1px solid #e9ecef;
      align-items: center;
      transition: background 0.2s;
    }
    .resource-item:hover {
      background: #f8f9fa;
    }
    .resource-type {
      width: 35px;
      height: 35px;
      border-radius: 6px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-weight: 700;
      font-size: 12px;
      color: white;
    }
    .type-font { background: #667eea; }
    .type-script { background: #f59e0b; }
    .type-image { background: #10b981; }
    .type-other { background: #6c757d; }
    .resource-name {
      font-size: 14px;
      color: #212529;
      overflow: hidden;
      text-overflow: ellipsis;
      white-space: nowrap;
    }
    .resource-size {
      font-size: 13px;
      color: #6c757d;
      text-align: right;
    }
    .resource-duration {
      font-size: 13px;
      font-weight: 600;
      text-align: right;
    }
    .duration-bar {
      height: 6px;
      background: #e9ecef;
      border-radius: 3px;
      overflow: hidden;
    }
    .duration-fill {
      height: 100%;
      background: linear-gradient(90deg, #667eea, #764ba2);
      transition: width 0.3s;
    }
    .slow { color: #dc3545; }
    .medium { color: #f59e0b; }
    .fast { color: #10b981; }
    .loading {
      text-align: center;
      padding: 60px 20px;
      color: #6c757d;
    }
    .loading-spinner {
      width: 50px;
      height: 50px;
      border: 4px solid #e9ecef;
      border-top-color: #667eea;
      border-radius: 50%;
      animation: spin 1s linear infinite;
      margin: 0 auto 20px;
    }
    @keyframes spin {
      to { transform: rotate(360deg); }
    }
    .chart-container {
      padding: 20px;
      background: #f8f9fa;
    }
    .chart-title {
      font-size: 16px;
      font-weight: 600;
      margin-bottom: 15px;
      color: #212529;
    }
    .timeline {
      background: white;
      padding: 20px;
      border-radius: 8px;
      overflow-x: auto;
    }
    .timeline-bar {
      display: flex;
      height: 30px;
      margin-bottom: 8px;
      position: relative;
      background: #f8f9fa;
      border-radius: 4px;
      overflow: hidden;
    }
    .timeline-segment {
      height: 100%;
      display: flex;
      align-items: center;
      justify-content: center;
      color: white;
      font-size: 11px;
      font-weight: 600;
      transition: all 0.3s;
    }
    .timeline-segment:hover {
      filter: brightness(1.1);
      z-index: 1;
    }
    .segment-dns { background: #667eea; }
    .segment-connect { background: #10b981; }
    .segment-wait { background: #f59e0b; }
    .segment-download { background: #8b5cf6; }
    .recommendations {
      padding: 20px;
      background: #fff3cd;
      border-left: 4px solid #f59e0b;
      margin: 20px;
      border-radius: 8px;
    }
    .recommendations h3 {
      color: #856404;
      margin-bottom: 10px;
    }
    .recommendations ul {
      margin-left: 20px;
      color: #856404;
    }
    .recommendations li {
      margin: 5px 0;
    }
  </style>
</head>
<body>
  <div class="container">
    <div class="header">
      <h1>🚀 资源加载性能分析</h1>
      <p>实时监测 Flutter Web 应用的资源加载性能</p>
    </div>
    
    <div class="controls">
      <button class="btn btn-primary" onclick="openApp()">🌐 打开应用</button>
      <button class="btn btn-success" onclick="analyzePerformance()">📊 分析性能</button>
      <span style="margin-left: auto; color: #6c757d;">提示: 打开应用后，刷新页面以捕获完整加载数据</span>
    </div>

    <div class="stats" id="stats" style="display: none;">
      <div class="stat-card">
        <div class="stat-label">总资源数</div>
        <div class="stat-value" id="total-resources">0</div>
      </div>
      <div class="stat-card">
        <div class="stat-label">总大小</div>
        <div class="stat-value" id="total-size">0 KB</div>
      </div>
      <div class="stat-card">
        <div class="stat-label">总加载时间</div>
        <div class="stat-value" id="total-time">0 ms</div>
      </div>
      <div class="stat-card">
        <div class="stat-label">最慢资源</div>
        <div class="stat-value" id="slowest-resource" style="font-size: 14px;">-</div>
      </div>
    </div>

    <div id="loading" class="loading">
      <div class="loading-spinner"></div>
      <p>等待性能数据...</p>
      <p style="font-size: 14px; margin-top: 10px;">请打开应用并刷新页面以捕获加载数据</p>
    </div>

    <div class="chart-container" id="timeline-container" style="display: none;">
      <div class="chart-title">⏱️ 加载时间线</div>
      <div class="timeline" id="timeline"></div>
    </div>

    <div class="resources" id="resources" style="display: none;">
      <h3 style="margin-bottom: 15px; color: #212529;">📦 资源详情</h3>
      <div id="resource-list"></div>
    </div>

    <div id="recommendations" style="display: none;"></div>
  </div>

  <script>
    let appWindow = null;

    function openApp() {
      if (appWindow && !appWindow.closed) {
        appWindow.focus();
      } else {
        appWindow = window.open('/index.html', 'FlutterApp', 'width=1200,height=800');
      }
    }

    function formatBytes(bytes) {
      if (bytes === 0) return '0 B';
      const k = 1024;
      const sizes = ['B', 'KB', 'MB', 'GB'];
      const i = Math.floor(Math.log(bytes) / Math.log(k));
      return Math.round(bytes / Math.pow(k, i) * 100) / 100 + ' ' + sizes[i];
    }

    function formatDuration(ms) {
      if (ms < 1000) return Math.round(ms) + ' ms';
      return (ms / 1000).toFixed(2) + ' s';
    }

    function getResourceType(url) {
      if (url.includes('.ttf') || url.includes('.otf') || url.includes('.woff')) return 'font';
      if (url.includes('.js')) return 'script';
      if (url.includes('.png') || url.includes('.jpg') || url.includes('.webp') || url.includes('.svg')) return 'image';
      return 'other';
    }

    function getDurationClass(duration) {
      if (duration > 500) return 'slow';
      if (duration > 200) return 'medium';
      return 'fast';
    }

    function analyzePerformance() {
      const resources = performance.getEntriesByType('resource');
      
      if (resources.length === 0) {
        alert('⚠️ 未检测到资源加载数据！\n\n请:\n1. 点击"打开应用"按钮\n2. 在新窗口中刷新页面\n3. 返回此页面点击"分析性能"');
        return;
      }

      document.getElementById('loading').style.display = 'none';
      document.getElementById('stats').style.display = 'grid';
      document.getElementById('timeline-container').style.display = 'block';
      document.getElementById('resources').style.display = 'block';

      const resourceData = resources.map(r => ({
        name: r.name.split('/').pop() || r.name,
        fullUrl: r.name,
        type: getResourceType(r.name),
        size: r.transferSize || 0,
        duration: r.responseEnd - r.startTime,
        dns: r.domainLookupEnd - r.domainLookupStart,
        connect: r.connectEnd - r.connectStart,
        wait: r.responseStart - r.requestStart,
        download: r.responseEnd - r.responseStart,
        startTime: r.startTime
      })).sort((a, b) => b.duration - a.duration);

      const totalSize = resourceData.reduce((sum, r) => sum + r.size, 0);
      const totalTime = Math.max(...resourceData.map(r => r.startTime + r.duration));
      const slowest = resourceData[0];

      document.getElementById('total-resources').textContent = resourceData.length;
      document.getElementById('total-size').textContent = formatBytes(totalSize);
      document.getElementById('total-time').textContent = formatDuration(totalTime);
      document.getElementById('slowest-resource').textContent = slowest.name.substring(0, 30);

      // 渲染资源列表
      const maxDuration = resourceData[0].duration;
      const resourceList = document.getElementById('resource-list');
      resourceList.innerHTML = resourceData.map(r => `
        <div class="resource-item">
          <div class="resource-type type-${r.type}">${r.type[0].toUpperCase()}</div>
          <div class="resource-name" title="${r.fullUrl}">${r.name}</div>
          <div class="resource-size">${formatBytes(r.size)}</div>
          <div class="resource-duration ${getDurationClass(r.duration)}">${formatDuration(r.duration)}</div>
          <div class="duration-bar">
            <div class="duration-fill" style="width: ${(r.duration / maxDuration * 100)}%"></div>
          </div>
        </div>
      `).join('');

      // 渲染时间线（前10个最慢的资源）
      const timeline = document.getElementById('timeline');
      timeline.innerHTML = resourceData.slice(0, 10).map(r => `
        <div style="margin-bottom: 15px;">
          <div style="font-size: 12px; color: #6c757d; margin-bottom: 5px;">${r.name} (${formatDuration(r.duration)})</div>
          <div class="timeline-bar">
            ${r.dns > 0 ? `<div class="timeline-segment segment-dns" style="width: ${r.dns/r.duration*100}%" title="DNS: ${formatDuration(r.dns)}">DNS</div>` : ''}
            ${r.connect > 0 ? `<div class="timeline-segment segment-connect" style="width: ${r.connect/r.duration*100}%" title="连接: ${formatDuration(r.connect)}">连接</div>` : ''}
            ${r.wait > 0 ? `<div class="timeline-segment segment-wait" style="width: ${r.wait/r.duration*100}%" title="等待: ${formatDuration(r.wait)}">等待</div>` : ''}
            ${r.download > 0 ? `<div class="timeline-segment segment-download" style="width: ${r.download/r.duration*100}%" title="下载: ${formatDuration(r.download)}">下载</div>` : ''}
          </div>
        </div>
      `).join('');

      // 生成优化建议
      generateRecommendations(resourceData, totalSize, slowest);
    }

    function generateRecommendations(resources, totalSize, slowest) {
      const recommendations = [];
      
      // 检查大文件
      const largeFiles = resources.filter(r => r.size > 500000); // > 500KB
      if (largeFiles.length > 0) {
        recommendations.push(`发现 ${largeFiles.length} 个大文件 (>500KB): ${largeFiles.map(f => f.name).join(', ')}。建议压缩或延迟加载。`);
      }

      // 检查慢资源
      const slowResources = resources.filter(r => r.duration > 1000); // > 1s
      if (slowResources.length > 0) {
        recommendations.push(`发现 ${slowResources.length} 个加载缓慢的资源 (>1s): ${slowResources.map(f => f.name).join(', ')}。`);
      }

      // 检查字体
      const fonts = resources.filter(r => r.type === 'font');
      if (fonts.length > 3) {
        recommendations.push(`加载了 ${fonts.length} 个字体文件。建议减少字体数量或使用字体子集。`);
      }

      // 检查总大小
      if (totalSize > 5000000) { // > 5MB
        recommendations.push(`总资源大小 ${formatBytes(totalSize)} 较大。建议启用 gzip 压缩和资源缓存。`);
      }

      // 检查 Google Fonts
      const googleFonts = resources.filter(r => r.fullUrl.includes('fonts.googleapis.com') || r.fullUrl.includes('fonts.gstatic.com'));
      if (googleFonts.length > 0) {
        recommendations.push(`⚠️ 检测到 ${googleFonts.length} 个 Google Fonts 请求！建议使用本地字体。`);
      } else {
        recommendations.push(`✅ 未检测到 Google Fonts 请求，字体优化成功！`);
      }

      const recDiv = document.getElementById('recommendations');
      if (recommendations.length > 0) {
        recDiv.style.display = 'block';
        recDiv.innerHTML = `
          <h3>💡 优化建议</h3>
          <ul>
            ${recommendations.map(r => `<li>${r}</li>`).join('')}
          </ul>
        `;
      }
    }

    // 定期检查性能数据
    setInterval(() => {
      const resources = performance.getEntriesByType('resource');
      if (resources.length > 0 && document.getElementById('loading').style.display !== 'none') {
        document.getElementById('loading').innerHTML = `
          <div class="loading-spinner"></div>
          <p>检测到 ${resources.length} 个资源</p>
          <p style="font-size: 14px; margin-top: 10px;">点击"分析性能"按钮查看详情</p>
        `;
      }
    }, 1000);
  </script>
</body>
</html>
EOF

echo "✅ 性能分析工具创建完成"
echo ""

# 8. 启动本地服务器
echo "🌐 启动本地服务器..."
echo ""
echo "访问地址："
echo "  📱 应用地址: http://localhost:$PORT"
echo "  📊 性能分析: http://localhost:$PORT/performance_test.html"
echo ""
echo "使用方法："
echo "  1. 打开性能分析页面: http://localhost:$PORT/performance_test.html"
echo "  2. 点击 '打开应用' 按钮"
echo "  3. 在新窗口中刷新页面（捕获完整加载数据）"
echo "  4. 返回性能分析页面，点击 '分析性能'"
echo "  5. 查看资源加载详情和优化建议"
echo ""
echo "传统测试方法："
echo "  1. 打开浏览器访问: http://localhost:$PORT"
echo "  2. 打开开发者工具 (F12)"
echo "  3. 切换到 Network 标签页"
echo "  4. 刷新页面"
echo "  5. 检查是否有 fonts.googleapis.com 或 fonts.gstatic.com 的请求"
echo ""
echo "⚠️  测试完成后，请按 Ctrl+C 停止服务器！"
echo ""

cd build/web && python3 -m http.server $PORT

