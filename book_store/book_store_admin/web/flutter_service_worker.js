'use strict';
// 缓存版本号，每次发布新版本时更新
const CACHE_VERSION = '1.0.0';
const CACHE_NAME = 'book-store-admin-cache-v' + CACHE_VERSION;

// 需要缓存的资源列表
const RESOURCES = {
  "assets/AssetManifest.json": "assets-manifest",
  "assets/FontManifest.json": "font-manifest",
  "assets/NOTICES": "notices",
  "assets/fonts/MaterialIcons-Regular.otf": "material-icons",
  "assets/fonts/NotoSansSC-Regular.woff2": "noto-sans-sc-regular",
  "assets/fonts/NotoSansSC-Medium.woff2": "noto-sans-sc-medium",
  "assets/fonts/NotoSansSC-Bold.woff2": "noto-sans-sc-bold",
  "assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "cupertino-icons",
  "canvaskit/canvaskit.js": "canvaskit-js",
  "canvaskit/canvaskit.wasm": "canvaskit-wasm",
  "canvaskit/profiling/canvaskit.js": "canvaskit-profiling-js",
  "canvaskit/profiling/canvaskit.wasm": "canvaskit-profiling-wasm",
  "favicon.png": "favicon",
  "flutter.js": "flutter-js",
  "icons/Icon-192.png": "icon-192",
  "icons/Icon-512.png": "icon-512",
  "icons/Icon-maskable-192.png": "icon-maskable-192",
  "icons/Icon-maskable-512.png": "icon-maskable-512",
  "index.html": "index-html",
  "main.dart.js": "main-dart-js",
  "manifest.json": "manifest",
  "version.json": "version"
};

// 安装Service Worker
self.addEventListener('install', function(event) {
  self.skipWaiting();
  
  event.waitUntil(
    caches.open(CACHE_NAME).then(function(cache) {
      // 预缓存关键资源
      return cache.addAll(Object.keys(RESOURCES).map(function(key) {
        return key;
      }));
    })
  );
});

// 激活Service Worker
self.addEventListener('activate', function(event) {
  event.waitUntil(
    caches.keys().then(function(cacheNames) {
      return Promise.all(
        cacheNames.filter(function(cacheName) {
          // 删除旧版本缓存
          return cacheName.startsWith('book-store-admin-cache-') && 
                 cacheName !== CACHE_NAME;
        }).map(function(cacheName) {
          return caches.delete(cacheName);
        })
      );
    }).then(function() {
      return self.clients.claim();
    })
  );
});

// 处理资源请求
self.addEventListener('fetch', function(event) {
  // 跳过不支持缓存的请求
  if (!event.request.url.startsWith('http')) {
    return;
  }
  
  // 跳过POST请求
  if (event.request.method !== 'GET') {
    return;
  }
  
  // 处理API请求 - 网络优先策略
  if (event.request.url.includes('/api/')) {
    event.respondWith(
      fetch(event.request).catch(function() {
        return caches.match(event.request);
      })
    );
    return;
  }
  
  // 处理静态资源 - 缓存优先策略
  event.respondWith(
    caches.match(event.request).then(function(response) {
      if (response) {
        return response;
      }
      
      return fetch(event.request).then(function(response) {
        // 检查是否是有效响应
        if (!response || response.status !== 200 || response.type !== 'basic') {
          return response;
        }
        
        // 克隆响应，因为响应是流，只能使用一次
        var responseToCache = response.clone();
        
        caches.open(CACHE_NAME).then(function(cache) {
          cache.put(event.request, responseToCache);
        });
        
        return response;
      }).catch(function() {
        // 离线时提供基本离线页面
        if (event.request.url.includes('index.html')) {
          return caches.match('index.html');
        }
      });
    })
  );
});

// 后台同步
self.addEventListener('sync', function(event) {
  if (event.tag === 'sync-data') {
    event.waitUntil(syncData());
  }
});

// 推送通知
self.addEventListener('push', function(event) {
  if (event.data) {
    const data = event.data.json();
    
    const options = {
      body: data.body,
      icon: 'icons/Icon-192.png',
      badge: 'icons/Icon-192.png',
      data: {
        url: data.url
      }
    };
    
    event.waitUntil(
      self.registration.showNotification(data.title, options)
    );
  }
});

// 点击通知
self.addEventListener('notificationclick', function(event) {
  event.notification.close();
  
  if (event.notification.data && event.notification.data.url) {
    event.waitUntil(
      clients.openWindow(event.notification.data.url)
    );
  }
});

// 同步数据函数
function syncData() {
  return new Promise(function(resolve, reject) {
    // 实现离线数据同步逻辑
    resolve();
  });
} 