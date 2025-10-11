# WASM 加载白屏问题修复

## 问题描述

在 Flutter Web WASM 应用启动时，发现以下问题：
- `main.dart.wasm` 文件 (1.2MB) 需要 6-7 秒才能加载完成
- 但加载动画在 5 秒时就被隐藏，导致白屏
- 用户需要等待额外的 1-2 秒白屏时间才能看到界面

## 根本原因

原有的加载逻辑只监控了两个条件：
1. **字体加载完成** - 通常 1 秒内完成（有 1 秒超时保护）
2. **Flutter 首帧渲染** - 有 5 秒超时保护

问题在于：
- WASM 文件可能需要 6-7 秒才能下载完成
- 但超时保护在 5 秒时就会触发，强制隐藏加载器
- 此时 WASM 还在加载中，导致白屏等待

## 解决方案

### 1. 新增 WASM 加载监控

使用 `PerformanceObserver` 实时监控 `main.dart.wasm` 和 `main.dart.mjs` 的加载状态：

```javascript
// 监控 WASM 文件加载
const wasmObserver = new PerformanceObserver((list) => {
  for (const entry of list.getEntries()) {
    if (entry.name.includes('main.dart.wasm') || entry.name.includes('main.dart.mjs')) {
      console.log(`[WASM] 📦 检测到文件加载`);
      console.log(`[WASM] 📊 大小: ${(entry.transferSize / 1024 / 1024).toFixed(2)} MB`);
      console.log(`[WASM] ⏱️  耗时: ${(entry.duration / 1000).toFixed(2)}s`);
      
      if (entry.responseEnd > 0) {
        wasmLoaded = true;
        console.log('[WASM] ✅ WASM 文件加载完成');
        updateProgress(70, 'WASM 引擎加载完成');
        checkAndHideLoader();
      }
    }
  }
});
```

### 2. 修改加载器隐藏条件

现在需要满足**三个条件**才会隐藏加载器：

```javascript
function checkAndHideLoader() {
  // 三个条件都必须满足：
  // 1. WASM 文件加载完成
  // 2. 字体加载完成  
  // 3. Flutter 首帧渲染完成
  
  if (wasmLoaded && flutterReady && fontsLoaded) {
    // 隐藏加载器
    updateProgress(100, '加载完成！');
    // ... 淡出动画
  }
}
```

### 3. 调整超时保护时间

- **WASM 超时保护**：从无 → 15 秒
  - 1.2MB 文件即使在慢速网络下也能在 15 秒内加载完成
  
- **Flutter 超时保护**：从 5 秒 → 20 秒
  - 必须给 WASM 足够的加载时间，避免过早隐藏
  
- **字体超时保护**：从 1 秒 → 2 秒
  - 稍微放宽，提高可靠性

## 修复效果

### 修复前
```
0-1s:  显示加载动画
1s:    字体加载完成 ✓
5s:    Flutter 超时触发 ✓
5s:    加载器隐藏 ❌ (WASM 还在加载)
5-7s:  白屏等待
7s:    WASM 加载完成，界面显示
```

### 修复后
```
0-1s:  显示加载动画
2s:    字体加载完成 ✓
7s:    WASM 加载完成 ✓
7s:    Flutter 首帧渲染 ✓
7s:    加载器隐藏 ✓
7s:    界面立即显示 ✓ (无白屏)
```

## 技术细节

### 进度条更新策略

- **0-30%**: 初始化、加载引擎、加载核心模块（定时器）
- **30-60%**: 资源加载实时监控（PerformanceObserver）
- **60-70%**: 准备渲染、WASM 加载完成
- **70-90%**: 初始化框架、渲染界面
- **90-95%**: Flutter 初始化完成、字体加载完成
- **95-100%**: 所有条件满足，加载完成

### 并行监控机制

1. **资源加载监控** - 实时监控所有 script/fetch 请求
2. **保底定时器** - 防止进度卡住（只有当实际进度低于目标时才更新）
3. **WASM 加载监控** - 专门监控 WASM 文件的加载状态
4. **字体加载监控** - 使用 `document.fonts.ready` API
5. **Flutter 就绪事件** - 监听 `flutter-first-frame` 事件

所有监控机制完全并行执行，互不阻塞。

## 测试建议

1. **首次访问测试**（无缓存）
   - 清除浏览器缓存
   - 刷新页面
   - 观察控制台日志，确认 WASM 加载完成后才隐藏加载器

2. **慢速网络测试**
   - 使用 Chrome DevTools 模拟慢速 3G
   - 验证加载器持续显示直到 WASM 加载完成
   - 确认无白屏

3. **正常网络测试**
   - 正常网络下刷新
   - 验证加载流畅，无明显卡顿

## 控制台日志示例

修复后，您应该在控制台看到类似这样的日志：

```
[WASM] 📦 检测到文件加载: main.dart.wasm
[WASM] 📊 大小: 1.21 MB
[WASM] ⏱️  耗时: 6.92s
[WASM] ✅ WASM 文件加载完成
[加载器] 检查隐藏条件 - WASM加载: true, Flutter就绪: true, 字体加载: true
[加载器] ✅ 所有条件满足，开始隐藏加载器
[加载器] 🎉 加载器淡出动画开始
[加载器] 🎉 加载器已完全隐藏，应用启动完成！
```

## 文件修改

- **修改文件**: `web/index.html`
- **修改位置**: 第 752-887 行（加载进度监控脚本）
- **新增代码**: 约 50 行（WASM 监控逻辑）
- **修改代码**: 约 30 行（超时时间调整、隐藏条件修改）

## 注意事项

1. 此修复不影响应用的实际加载时间，只是确保加载器显示到真正加载完成
2. WASM 文件的加载时间取决于网络速度和文件大小，无法避免
3. 对于生产环境，建议：
   - 使用 CDN 加速 WASM 文件分发
   - 启用 HTTP/2 或 HTTP/3 提高传输速度
   - 考虑代码分割（Code Splitting）减小初始包体积
   - 启用 Service Worker 缓存，提升二次访问速度

## 相关问题

- 如果应用启动仍然较慢，可以考虑：
  - 使用 `flutter build web --web-renderer canvaskit --release` 确保生产构建
  - 检查 WASM 文件是否被正确压缩（gzip/brotli）
  - 使用 `flutter build web --split-debug-info` 移除调试信息
  - 考虑使用 HTML 渲染器（体积更小但功能受限）

---

**修复日期**: 2025-10-11  
**修复版本**: 1.0  
**影响范围**: Flutter Web WASM 加载流程

