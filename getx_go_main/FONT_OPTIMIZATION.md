# 字体加载优化说明

## 问题诊断

### 原始问题
1. **字体重复加载**：
   - `pubspec.yaml` 中定义字体 → 打包到 `build/web/assets/assets/fonts/`
   - `web/index.html` 中通过 `@font-face` 加载 → 从 `web/fonts/` 复制到 `build/web/fonts/`
   - 导致每个字体被加载两次

2. **字体文件过大**：
   - NotoSansSC-Regular.ttf: **2.17 MB** (中文字体)
   - Roboto-Regular.ttf: 169 KB
   - Roboto-Bold.ttf: 168 KB

3. **加载时间过长**：
   - NotoSansSC 加载时间 18-26 秒
   - 阻塞页面渲染

## 优化方案

### 1. 移除重复定义
- **注释掉** `pubspec.yaml` 中的 `fonts` 配置
- **仅使用** `web/index.html` 中的 `@font-face` 定义
- 字体文件保留在 `web/fonts/` 目录

### 2. 优化加载策略

#### Roboto 字体 (英文)
```css
@font-face {
  font-family: 'Roboto';
  src: url('fonts/Roboto-Regular.ttf') format('truetype');
  font-weight: 400;
  font-display: swap; /* 立即显示后备字体 */
}
```
- 使用 `font-display: swap` 快速显示
- 使用 `<link rel="preload">` 预加载

#### NotoSansSC 字体 (中文)
```css
@font-face {
  font-family: 'NotoSansSC';
  src: url('fonts/NotoSansSC-Regular.ttf') format('truetype');
  font-weight: 400;
  font-display: optional; /* 延迟加载，不阻塞渲染 */
}
```
- 使用 `font-display: optional` 避免阻塞
- **不预加载**，让浏览器后台加载

### 3. 预加载策略
```html
<!-- 只预加载关键字体 -->
<link rel="preload" href="fonts/Roboto-Regular.ttf" as="font" type="font/ttf" crossorigin>
<!-- NotoSansSC 不预加载，避免阻塞首屏 -->
```

### 4. CSP 安全策略
```html
<meta http-equiv="Content-Security-Policy" content="font-src 'self' data: blob:;">
```
- 阻止 Google Fonts 等外部字体请求
- 强制使用本地字体

## font-display 属性说明

| 值 | 行为 | 适用场景 |
|---|---|---|
| `swap` | 立即显示后备字体，加载完成后切换 | 小字体文件、关键字体 |
| `optional` | 极短时间内可用则显示，否则用系统字体 | 大字体文件、非关键字体 |
| `block` | 阻塞显示，等待字体加载 | **不推荐** (会阻塞渲染) |

## 预期效果

### 优化前
- NotoSansSC 加载两次
- 总字体加载时间: ~20-30 秒
- 阻塞页面渲染

### 优化后
- 每个字体只加载一次
- Roboto 快速显示 (swap)
- NotoSansSC 后台加载 (optional)
- 不阻塞首屏渲染
- **预计加载时间减少 50%+**

## 构建验证

### 重新构建
```bash
flutter build web --release
```

### 验证字体位置
```bash
# 应该只存在于一个位置
ls -lh build/web/fonts/
# 应该为空或不存在
ls -lh build/web/assets/assets/fonts/ 2>/dev/null || echo "不存在 ✓"
```

### 浏览器测试
1. 打开开发者工具 → Network
2. 过滤 "font"
3. 刷新页面
4. 检查：
   - 每个字体只加载一次 ✓
   - NotoSansSC 优先级较低 ✓
   - Roboto 优先级较高 ✓

## 进一步优化建议

### 1. 字体子集化 (推荐)
如果只使用部分中文字符，可以生成字体子集：
```bash
# 使用 fonttools 生成子集
pip install fonttools
pyftsubset NotoSansSC-Regular.ttf \
  --text-file=常用字.txt \
  --output-file=NotoSansSC-Subset.ttf
```
- 可将 2.17 MB 减少到 200-500 KB

### 2. 使用 woff2 格式
```bash
# 转换为 woff2 (压缩率更高)
woff2_compress NotoSansSC-Regular.ttf
```
- woff2 比 ttf 小 30-50%
- 所有现代浏览器都支持

### 3. 使用系统字体栈
```css
font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 
             'PingFang SC', 'Microsoft YaHei', sans-serif;
```
- 无需下载字体
- 加载速度最快

## 文件清理

可以考虑删除 `assets/fonts/` 目录：
```bash
rm -rf assets/fonts/
```
因为现在只使用 `web/fonts/` 中的字体。

---

**最后更新**: 2025-10-10


