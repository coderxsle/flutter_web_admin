#!/bin/bash

# 爱自然书店管理系统 - Web优化构建脚本
# 此脚本用于构建优化的Flutter Web应用

echo "===== 开始构建优化的Flutter Web应用 ====="

# 确保Flutter环境正常
echo "检查Flutter环境..."
flutter doctor -v

# 清理旧的构建文件
echo "清理旧的构建文件..."
flutter clean

# 获取依赖
echo "获取依赖..."
flutter pub get

# 构建优化的Web应用 - 自适应渲染器
echo "构建Web应用..."
flutter build web \
  --release \
  --dart-define=Dart2jsOptimization=O4 \
  --pwa-strategy offline-first \
  --tree-shake-icons \
  --no-source-maps

# 优化图片资源
echo "优化图片资源..."
if command -v optipng &> /dev/null && command -v jpegoptim &> /dev/null; then
  find build/web -name "*.png" -exec echo "优化: {}" \; -exec optipng -o5 {} \;
  find build/web -name "*.jpg" -exec echo "优化: {}" \; -exec jpegoptim --strip-all --max=85 {} \;
else
  echo "警告: 未找到图片优化工具 (optipng/jpegoptim)，跳过图片优化"
  echo "可以通过以下命令安装这些工具:"
  echo "  brew install optipng jpegoptim"
fi

# 创建gzip和brotli压缩版本
echo "创建压缩版本..."
if command -v gzip &> /dev/null; then
  find build/web -type f -name "*.js" -exec gzip -9 -k {} \;
  find build/web -type f -name "*.css" -exec gzip -9 -k {} \;
  find build/web -type f -name "*.html" -exec gzip -9 -k {} \;
else
  echo "警告: 未找到gzip，跳过gzip压缩"
fi

if command -v brotli &> /dev/null; then
  find build/web -type f -name "*.js" -exec brotli -q 11 -k {} \;
  find build/web -type f -name "*.css" -exec brotli -q 11 -k {} \;
  find build/web -type f -name "*.html" -exec brotli -q 11 -k {} \;
else
  echo "警告: 未找到brotli，跳过brotli压缩"
  echo "可以通过以下命令安装brotli:"
  echo "  brew install brotli"
fi

# 添加缓存控制配置
echo "添加缓存控制配置..."
cat > build/web/.htaccess << EOL
# 启用Gzip和Brotli压缩
<IfModule mod_deflate.c>
  AddOutputFilterByType DEFLATE text/html text/plain text/xml text/css text/javascript application/javascript application/json
</IfModule>

# 启用Brotli压缩（如果服务器支持）
<IfModule mod_brotli.c>
  AddOutputFilterByType BROTLI_COMPRESS text/html text/plain text/xml text/css text/javascript application/javascript application/json
</IfModule>

# 缓存控制
<IfModule mod_expires.c>
  ExpiresActive On
  
  # 缓存HTML和数据文件1小时
  ExpiresByType text/html "access plus 1 hour"
  ExpiresByType application/json "access plus 1 hour"
  
  # 缓存CSS和JavaScript文件1周
  ExpiresByType text/css "access plus 1 week"
  ExpiresByType application/javascript "access plus 1 week"
  
  # 缓存图片和字体文件1个月
  ExpiresByType image/jpeg "access plus 1 month"
  ExpiresByType image/png "access plus 1 month"
  ExpiresByType image/svg+xml "access plus 1 month"
  ExpiresByType font/woff "access plus 1 month"
  ExpiresByType font/woff2 "access plus 1 month"
  ExpiresByType application/font-woff "access plus 1 month"
  ExpiresByType application/font-woff2 "access plus 1 month"
</IfModule>

# 添加正确的MIME类型
<IfModule mod_mime.c>
  AddType application/font-woff2 .woff2
  AddType application/javascript .js
  AddType text/css .css
</IfModule>

# 启用HTTP/2服务器推送（如果服务器支持）
<IfModule mod_http2.c>
  H2PushResource add /flutter.js
  H2PushResource add /main.dart.js
</IfModule>
EOL

# 为Nginx创建配置示例
cat > build/web/nginx.conf.example << EOL
# Nginx配置示例 - 将此配置添加到您的Nginx服务器配置中

server {
    listen 80;
    server_name your-domain.com;
    
    # 重定向到HTTPS
    return 301 https://\$host\$request_uri;
}

server {
    listen 443 ssl http2;
    server_name your-domain.com;
    
    # SSL配置
    ssl_certificate /path/to/cert.pem;
    ssl_certificate_key /path/to/key.pem;
    
    # 启用OCSP Stapling
    ssl_stapling on;
    ssl_stapling_verify on;
    
    # 启用TLS 1.3和安全密码
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_prefer_server_ciphers on;
    ssl_ciphers 'ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384';
    
    # 启用HSTS
    add_header Strict-Transport-Security "max-age=31536000; includeSubDomains" always;
    
    # 安全头
    add_header X-Content-Type-Options "nosniff" always;
    add_header X-Frame-Options "SAMEORIGIN" always;
    add_header X-XSS-Protection "1; mode=block" always;
    
    # 根目录
    root /path/to/build/web;
    index index.html;
    
    # 启用gzip
    gzip on;
    gzip_comp_level 6;
    gzip_min_length 256;
    gzip_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript application/vnd.ms-fontobject application/x-font-ttf font/opentype image/svg+xml image/x-icon;
    gzip_vary on;
    
    # 启用brotli（如果模块已安装）
    brotli on;
    brotli_comp_level 6;
    brotli_types text/plain text/css application/json application/javascript text/xml application/xml application/xml+rss text/javascript application/vnd.ms-fontobject application/x-font-ttf font/opentype image/svg+xml image/x-icon;
    
    # 启用静态gzip/brotli文件服务
    gzip_static on;
    brotli_static on;
    
    # 缓存控制
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg)$ {
        expires 30d;
        add_header Cache-Control "public, no-transform";
    }
    
    location ~* \.(woff|woff2)$ {
        expires 30d;
        add_header Cache-Control "public, no-transform";
        types {
            application/font-woff woff;
            application/font-woff2 woff2;
        }
    }
    
    # 主应用路由
    location / {
        try_files \$uri \$uri/ /index.html;
    }
}
EOL

echo "===== Web应用构建完成 ====="
echo "构建输出位于: $(pwd)/build/web"
echo "部署提示: "
echo "  - Apache服务器: 已创建.htaccess文件"
echo "  - Nginx服务器: 请参考build/web/nginx.conf.example"
echo "  - 其他服务器: 请确保配置了正确的MIME类型和压缩支持"

# 显示构建大小统计
echo "===== 构建大小统计 ====="
du -sh build/web
du -sh build/web/main.dart.js
if [ -f "build/web/main.dart.js.gz" ]; then
  du -sh build/web/main.dart.js.gz
fi
if [ -f "build/web/main.dart.js.br" ]; then
  du -sh build/web/main.dart.js.br
fi
echo "===== 构建完成 =====" 