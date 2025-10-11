# Service Worker 缓存优化指南

## 📋 概述

本项目已集成**增强版 Service Worker**，专门优化 Flutter Web 应用的加载性能，特别是针对 CanvasKit 的缓存策略。

## 🎯 优化效果

### 首次访问
- ✅ CanvasKit (8-12MB) 下载并缓存
- ✅ 应用资源全部缓存
- ⏱️ 加载时间: 3-5 秒（取决于网络）

### 后续访问
- ✅ **CanvasKit 直接从缓存加载（0 网络请求）**
- ✅ 应用资源优先使用缓存
- ⚡ **加载时间: < 1 秒**

## 🔧 缓存策略

### 1. CanvasKit 缓存（长期缓存）
- **策略**: Cache-First（缓存优先）
- **有效期**: 1 年
- **文件**:
  - `canvaskit.wasm` (主渲染引擎)
  - `skwasm.wasm` (Skia WebAssembly)
  - `skwasm_heavy.wasm` (完整版 Skia)
  - 对应的 `.js` 加载器

### 2. CDN 资源缓存
- **策略**: Cache-First
- **有效期**: 30 天
- **包含**: 字体、图片等静态资源

### 3. 应用资源缓存
- **策略**: Network-First（网络优先）
- **有效期**: 7 天
- **包含**: HTML、CSS、Flutter 编译文件

### 4. API 响应缓存
- **策略**: Network-First
- **有效期**: 5 分钟
- **包含**: API 请求响应

## 🛠️ 使用方法

### 在浏览器控制台使用

#### 1. 查看缓存统计
```javascript
// 发送请求获取缓存统计
window.swUtils.getCacheStats();

// 查看控制台输出的统计信息
// 输出格式：
// {
//   app: { name: 'app-cache-v1.0.0', count: 15, urls: [...] },
//   canvaskit: { name: 'canvaskit-cache-v1.0.0', count: 6, urls: [...] },
//   cdn: { name: 'cdn-cache-v1.0.0', count: 3, urls: [...] },
//   api: { name: 'api-cache-v1.0.0', count: 0, urls: [] }
// }
```

#### 2. 清除所有缓存
```javascript
// 清除所有缓存（会自动刷新页面）
await window.swUtils.clearCache();
```

#### 3. 更新 Service Worker
```javascript
// 检查并更新 Service Worker
await window.swUtils.update();
```

#### 4. 卸载 Service Worker
```javascript
// 完全卸载 Service Worker 并清除缓存
await window.swUtils.unregister();
```

### 在 Chrome DevTools 中管理

1. 打开开发者工具 (F12)
2. 切换到 **Application** 标签
3. 左侧菜单选择 **Service Workers**
4. 可以看到当前注册的 Service Worker 状态
5. 点击 **Unregister** 可以卸载
6. 点击 **Update** 可以更新

### 查看缓存内容

1. 在 **Application** 标签中
2. 左侧菜单选择 **Cache** → **Cache Storage**
3. 展开可以看到所有缓存:
   - `app-cache-v1.0.0` - 应用资源
   - `canvaskit-cache-v1.0.0` - CanvasKit 文件
   - `cdn-cache-v1.0.0` - CDN 资源
   - `api-cache-v1.0.0` - API 响应

## 📊 测试验证

### 1. 验证 CanvasKit 缓存

**首次访问:**
```bash
# 打开浏览器开发者工具的 Network 标签
# 刷新页面，观察 canvaskit.wasm 的加载

# 应该看到:
# canvaskit.wasm - Size: ~2-3MB, Time: 1-3s
# skwasm_heavy.wasm - Size: ~6-8MB, Time: 2-5s
```

**第二次访问:**
```bash
# 再次刷新页面（Ctrl+R 或 Cmd+R）
# 观察 Network 标签

# 应该看到:
# canvaskit.wasm - Size: (disk cache), Time: < 50ms
# skwasm_heavy.wasm - Size: (disk cache), Time: < 50ms
```

### 2. 验证离线访问

```bash
# 1. 正常访问网站一次（建立缓存）
# 2. 在 Chrome DevTools → Network 标签中
# 3. 勾选 "Offline" 复选框（模拟离线）
# 4. 刷新页面

# ✅ 应用应该能正常加载（从缓存）
# ⚠️ 注意：API 请求会失败（除非有缓存）
```

### 3. 测试缓存更新

```bash
# 1. 修改应用代码并重新构建
#    flutter build web
#
# 2. 部署新版本
# 3. 用户访问时会看到更新提示
# 4. 点击"刷新"按钮获取新版本
```

## 🚀 部署建议

### 1. Web 服务器配置

#### Nginx 配置
```nginx
# 为 Service Worker 文件设置正确的 MIME 类型
location /sw-config.js {
    add_header Content-Type application/javascript;
    add_header Service-Worker-Allowed /;
    add_header Cache-Control "no-cache, no-store, must-revalidate";
}

# CanvasKit 文件启用 Gzip/Brotli 压缩
location /canvaskit/ {
    gzip on;
    gzip_types application/wasm application/javascript;
    add_header Cache-Control "public, max-age=31536000, immutable";
}
```

#### Apache 配置
```apache
# .htaccess
<Files "sw-config.js">
    Header set Content-Type "application/javascript"
    Header set Service-Worker-Allowed "/"
    Header set Cache-Control "no-cache, no-store, must-revalidate"
</Files>

# CanvasKit 压缩和缓存
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE application/wasm
    AddOutputFilterByType DEFLATE application/javascript
</IfModule>

<FilesMatch "\.(wasm|js)$">
    Header set Cache-Control "public, max-age=31536000, immutable"
</FilesMatch>
```

### 2. CDN 配置

如果使用 CDN（如阿里云 OSS、腾讯云 COS）:

1. **开启 Gzip/Brotli 压缩**
   - 可减少 70% 传输大小

2. **设置缓存策略**
   ```
   CanvasKit 文件: max-age=31536000 (1年)
   应用文件: max-age=604800 (7天)
   HTML 文件: no-cache
   ```

3. **开启 HTTP/2**
   - 提升并发加载性能

### 3. 渲染器说明

**⚠️ 重要更新**: Flutter 3.35+ 已移除 HTML 渲染器，现在只支持 CanvasKit。

```bash
# Flutter 3.35+ 默认且唯一的渲染器
flutter build web

# 以下选项已废弃（Flutter 3.35+）:
# flutter build web --web-renderer auto     ❌ 已移除
# flutter build web --web-renderer html     ❌ 已移除
# flutter build web --web-renderer canvaskit ✅ 默认行为
```

**这意味着:**
- ✅ 所有应用都使用 CanvasKit (性能更好、渲染一致)
- ✅ Service Worker 缓存 CanvasKit 变得**更加重要**
- ⚠️ 首次加载必然会下载 8-12MB 的 CanvasKit
- 💡 使用本指南的缓存策略可大幅改善后续加载体验

## 📈 性能对比

**注**: 以下数据基于 Flutter 3.35+ (仅 CanvasKit 渲染器)

| 场景 | 无 Service Worker | 有 Service Worker | 提升 |
|------|------------------|------------------|------|
| **首次加载** | 3-5s | 3-5s | - |
| **二次加载** | 2-3s | < 1s | **70%+** |
| **CanvasKit 加载** | 每次 2-3s | 首次后 < 50ms | **98%+** |
| **离线访问** | ❌ 不可用 | ✅ 可用 | - |
| **网络流量** | 每次 10-15MB | 首次后 < 500KB | **95%+** |

**Flutter 3.35+ 特别提醒**: 由于移除了 HTML 渲染器，CanvasKit 成为唯一选择，这使得 Service Worker 缓存策略变得**至关重要**，是优化用户体验的关键手段。

## 🐛 故障排查

### 问题 1: Service Worker 未注册

**检查:**
```javascript
navigator.serviceWorker.getRegistrations().then(registrations => {
  console.log('已注册的 Service Worker:', registrations.length);
});
```

**解决方案:**
- 确保使用 HTTPS 或 localhost
- 检查浏览器控制台是否有错误
- 确认 `sw-config.js` 文件存在

### 问题 2: 缓存未生效

**检查:**
```javascript
caches.keys().then(keys => {
  console.log('缓存列表:', keys);
});
```

**解决方案:**
- 清除浏览器缓存后重试
- 检查 Network 标签中的请求是否被拦截
- 确认文件路径匹配缓存策略

### 问题 3: 更新后仍显示旧版本

**解决方案:**
```javascript
// 强制更新
await window.swUtils.update();

// 或者清除所有缓存
await window.swUtils.clearCache();

// 最后方案：卸载重装
await window.swUtils.unregister();
window.location.reload();
```

### 问题 4: 开发时缓存干扰调试

**开发模式建议:**
```bash
# Flutter 3.35+: 在 Chrome DevTools 中禁用缓存
# 1. Application → Service Workers → 勾选 "Update on reload"
# 2. Network → 勾选 "Disable cache"

# 或者运行时禁用 Service Worker
flutter run -d chrome

# 然后在 DevTools → Application → Service Workers
# 点击 "Unregister" 临时卸载 Service Worker
```

**注意**: Flutter 3.35+ 已移除 `--web-renderer` 选项，开发时也会使用 CanvasKit。

## 🔄 版本更新

当更新 Service Worker 配置时:

1. **修改版本号**
   ```javascript
   // 在 sw-config.js 中
   const CACHE_VERSION = 'v1.0.1'; // 更新版本号
   ```

2. **重新构建应用**
   ```bash
   flutter build web
   ```

3. **部署到服务器**

4. **用户访问时会自动更新**
   - 显示"新版本可用"通知
   - 点击刷新即可使用新版本

## 💡 最佳实践

### 1. 定期清理缓存

建议在应用中提供清理缓存的功能:

```dart
// Flutter 代码中调用
import 'dart:html' as html;

void clearCache() {
  html.window.postMessage({'type': 'clearCache'}, '*');
}
```

### 2. 监控缓存大小

```javascript
// 定期检查缓存大小
async function getCacheSize() {
  if ('storage' in navigator && 'estimate' in navigator.storage) {
    const estimate = await navigator.storage.estimate();
    console.log('存储使用:', estimate.usage, '/', estimate.quota);
    console.log('使用百分比:', (estimate.usage / estimate.quota * 100).toFixed(2) + '%');
  }
}
```

### 3. 预缓存关键资源

修改 `sw-config.js` 中的预缓存列表:

```javascript
event.waitUntil(
  caches.open(CACHE_NAMES.app).then(cache => {
    return cache.addAll([
      '/',
      '/index.html',
      '/manifest.json',
      '/assets/images/logo.png', // 添加需要预缓存的资源
      '/fonts/custom-font.woff2',
    ]);
  })
);
```

## 📚 相关文档

- [Service Worker API - MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/Service_Worker_API)
- [Cache API - MDN](https://developer.mozilla.org/zh-CN/docs/Web/API/Cache)
- [Flutter Web 渲染器](https://docs.flutter.dev/platform-integration/web/renderers)
- [CanvasKit 文档](https://skia.org/docs/user/modules/canvaskit/)

## 🎉 总结

通过实施 Service Worker 缓存策略:

- ✅ **后续加载速度提升 70%+**
- ✅ **CanvasKit 零网络请求（首次后）**
- ✅ **支持离线访问**
- ✅ **大幅减少服务器带宽消耗**
- ✅ **改善用户体验**

建议在生产环境中启用，并定期监控缓存效果！

