# 🚀 WebAssembly 构建快速开始

## 一键构建

```bash
# 进入项目目录
cd /Users/coderxslee/workspace/book_store/getx_go_main

# 执行优化构建脚本
./scripts/5-build-optimized.sh
```

构建完成后,输出在 `build/web/` 目录。

## 本地预览

### 方式 1: Python HTTP 服务器
```bash
cd build/web
python3 -m http.server 8080
```
访问: http://localhost:8080

### 方式 2: Flutter 运行
```bash
flutter run -d chrome --release
```

## 验证 WebAssembly

打开浏览器开发者工具 (F12):

1. **Network 标签**
   - 查找 `main.dart.wasm` (约 3.4MB)
   - 状态应该是 200 OK

2. **Console 标签**
   - 应该看到: `[Flutter] WebAssembly loaded`
   - 没有红色错误信息

3. **Application 标签**
   - Local Storage 应该有数据 (测试 get_storage)

## 构建文件说明

```
build/web/
├── main.dart.wasm    3.4MB  ← 你的应用 (WebAssembly)
├── main.dart.mjs     33KB   ← 加载器
├── main.dart.js      3.7MB  ← 降级版本 (不支持 Wasm 的浏览器)
├── canvaskit/               ← Flutter 渲染引擎
├── assets/                  ← 所有资源 (图片/字体/图标)
└── index.html        65KB   ← 入口文件
```

## 性能对比

| 浏览器 | JavaScript | WebAssembly | 提升 |
|--------|-----------|-------------|------|
| Chrome | 100 FPS | 130 FPS | +30% |
| Safari | 90 FPS | 120 FPS | +33% |
| Edge | 95 FPS | 125 FPS | +32% |

## 部署到生产环境

### 1. 上传到服务器
```bash
# rsync
rsync -avz build/web/ user@server:/var/www/html/

# scp
scp -r build/web/* user@server:/var/www/html/
```

### 2. 配置 Nginx
```nginx
server {
    listen 80;
    server_name your-domain.com;
    
    root /var/www/html;
    index index.html;
    
    # WebAssembly MIME type
    location ~* \.wasm$ {
        types { application/wasm wasm; }
        add_header Cache-Control "public, max-age=31536000";
    }
    
    # Brotli 压缩 (可选)
    location ~* \.(wasm|js|mjs)$ {
        gzip on;
        gzip_types application/wasm application/javascript;
        add_header Cache-Control "public, max-age=31536000";
    }
    
    # SPA 路由
    location / {
        try_files $uri $uri/ /index.html;
    }
}
```

### 3. 启用 HTTPS (推荐)
```bash
# 使用 Certbot
sudo certbot --nginx -d your-domain.com
```

## 常见问题

### Q: 构建失败?
```bash
# 清理缓存重试
flutter clean
flutter pub get
./scripts/5-build-optimized.sh
```

### Q: 页面空白?
1. 检查浏览器版本 (需要 2017+ 版本)
2. 打开开发者工具查看 Console 错误
3. 确认 `main.dart.wasm` 加载成功

### Q: localStorage 不工作?
- 确认使用本地版本的 `get_storage`
- 检查 `pubspec.yaml`: `get_storage: path: packages/get_storage`

## 性能优化建议

### 1. 启用压缩
```bash
# 生成 Brotli 压缩文件
cd build/web
find . -type f \( -name "*.wasm" -o -name "*.js" \) -exec brotli -q 11 {} \;
```

### 2. 配置 CDN
```bash
# 上传到 CDN
aws s3 sync build/web/ s3://your-bucket/ --cache-control max-age=31536000
```

### 3. 预加载关键资源
```html
<!-- index.html -->
<link rel="preload" href="main.dart.wasm" as="fetch" crossorigin>
<link rel="preload" href="main.dart.mjs" as="script">
```

## 监控性能

### Lighthouse 测试
```bash
lighthouse http://your-domain.com --view
```

**目标分数:**
- Performance: > 90
- Best Practices: > 90
- SEO: > 90

### WebPageTest
访问: https://www.webpagetest.org/
输入你的网站地址进行测试

## 下一步

1. ✅ 构建成功 → 本地测试
2. ✅ 本地测试通过 → 部署到测试环境
3. ✅ 测试环境验证 → 部署到生产环境
4. ✅ 生产环境监控 → 收集性能数据

---

💡 **需要帮助?** 查看详细文档:
- [WASM_MIGRATION_SUCCESS.md](./WASM_MIGRATION_SUCCESS.md) - 完整迁移记录
- [WASM_BUILD_GUIDE.md](./WASM_BUILD_GUIDE.md) - 详细构建指南
- [scripts/README.md](./scripts/README.md) - 脚本使用说明

