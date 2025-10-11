/**
 * 自定义 Service Worker 配置
 * 专门优化 CanvasKit 和 CDN 资源的缓存策略
 */

// 缓存版本 - 更新此版本号会清除旧缓存
const CACHE_VERSION = 'v1.0.0';
const CACHE_NAMES = {
  // 应用核心资源缓存（Flutter 生成的文件）
  app: `app-cache-${CACHE_VERSION}`,
  
  // CanvasKit 缓存（长期缓存，1年）
  canvaskit: `canvaskit-cache-${CACHE_VERSION}`,
  
  // CDN 资源缓存（字体、图片等静态资源）
  cdn: `cdn-cache-${CACHE_VERSION}`,
  
  // API 响应缓存（可选，用于离线支持）
  api: `api-cache-${CACHE_VERSION}`,
};

// CanvasKit 相关资源的 URL 模式
const CANVASKIT_PATTERNS = [
  /canvaskit.*\.wasm$/,
  /canvaskit.*\.js$/,
  /skwasm.*\.wasm$/,
  /skwasm.*\.js$/,
  /canvaskit\.js\.symbols$/,
];

// CDN 资源的 URL 模式
const CDN_PATTERNS = [
  /cdn\.jsdelivr\.net/,
  /unpkg\.com/,
  /fonts\.googleapis\.com/,
  /fonts\.gstatic\.com/,
];

// 需要网络优先的资源（实时性要求高）
const NETWORK_FIRST_PATTERNS = [
  /\/api\//,
  /index\.html$/,
  /manifest\.json$/,
];

// 缓存策略配置
const CACHE_STRATEGIES = {
  // CanvasKit: 缓存优先，1年有效期
  canvaskit: {
    cacheName: CACHE_NAMES.canvaskit,
    maxAge: 365 * 24 * 60 * 60 * 1000, // 1年
    strategy: 'cache-first',
  },
  
  // CDN 资源: 缓存优先，30天有效期
  cdn: {
    cacheName: CACHE_NAMES.cdn,
    maxAge: 30 * 24 * 60 * 60 * 1000, // 30天
    strategy: 'cache-first',
  },
  
  // 应用资源: 网络优先，回退到缓存
  app: {
    cacheName: CACHE_NAMES.app,
    maxAge: 7 * 24 * 60 * 60 * 1000, // 7天
    strategy: 'network-first',
  },
  
  // API 响应: 网络优先，短期缓存
  api: {
    cacheName: CACHE_NAMES.api,
    maxAge: 5 * 60 * 1000, // 5分钟
    strategy: 'network-first',
  },
};

/**
 * 判断请求是否匹配某个模式
 */
function matchesPattern(url, patterns) {
  return patterns.some(pattern => pattern.test(url));
}

/**
 * 获取请求对应的缓存策略
 */
function getCacheStrategy(request) {
  const url = request.url;
  
  // CanvasKit 资源
  if (matchesPattern(url, CANVASKIT_PATTERNS)) {
    return CACHE_STRATEGIES.canvaskit;
  }
  
  // CDN 资源
  if (matchesPattern(url, CDN_PATTERNS)) {
    return CACHE_STRATEGIES.cdn;
  }
  
  // 网络优先资源
  if (matchesPattern(url, NETWORK_FIRST_PATTERNS)) {
    return CACHE_STRATEGIES.app;
  }
  
  // API 请求
  if (url.includes('/api/')) {
    return CACHE_STRATEGIES.api;
  }
  
  // 默认使用应用缓存策略
  return CACHE_STRATEGIES.app;
}

/**
 * 检查缓存是否过期
 */
function isCacheExpired(cachedResponse, maxAge) {
  if (!cachedResponse) return true;
  
  const cachedTime = cachedResponse.headers.get('sw-cached-time');
  if (!cachedTime) return false; // 如果没有缓存时间，认为未过期
  
  const age = Date.now() - parseInt(cachedTime, 10);
  return age > maxAge;
}

/**
 * 为响应添加缓存时间戳
 */
function addCacheTimestamp(response) {
  const clonedResponse = response.clone();
  const headers = new Headers(clonedResponse.headers);
  headers.append('sw-cached-time', Date.now().toString());
  
  return clonedResponse.arrayBuffer().then(buffer => {
    return new Response(buffer, {
      status: clonedResponse.status,
      statusText: clonedResponse.statusText,
      headers: headers,
    });
  });
}

/**
 * 缓存优先策略（适用于 CanvasKit 和 CDN 资源）
 */
async function cacheFirst(request, cacheName, maxAge) {
  const cache = await caches.open(cacheName);
  const cachedResponse = await cache.match(request);
  
  // 如果有缓存且未过期，直接返回
  if (cachedResponse && !isCacheExpired(cachedResponse, maxAge)) {
    return cachedResponse;
  }
  
  // 尝试从网络获取
  try {
    const networkResponse = await fetch(request);
    
    // 只缓存成功的响应
    if (networkResponse && networkResponse.status === 200) {
      const responseToCache = await addCacheTimestamp(networkResponse);
      cache.put(request, responseToCache);
      return networkResponse;
    }
    
    return networkResponse;
  } catch (error) {
    // 网络失败，返回过期的缓存（如果有）
    if (cachedResponse) {
      console.log('[SW] 网络失败，使用过期缓存:', request.url);
      return cachedResponse;
    }
    throw error;
  }
}

/**
 * 网络优先策略（适用于 HTML、API 等动态内容）
 */
async function networkFirst(request, cacheName, maxAge) {
  const cache = await caches.open(cacheName);
  
  try {
    // 尝试从网络获取
    const networkResponse = await fetch(request);
    
    // 只缓存成功的响应
    if (networkResponse && networkResponse.status === 200) {
      const responseToCache = await addCacheTimestamp(networkResponse);
      cache.put(request, responseToCache);
    }
    
    return networkResponse;
  } catch (error) {
    // 网络失败，回退到缓存
    const cachedResponse = await cache.match(request);
    
    if (cachedResponse) {
      console.log('[SW] 网络失败，使用缓存:', request.url);
      return cachedResponse;
    }
    
    throw error;
  }
}

/**
 * Service Worker 安装事件
 */
self.addEventListener('install', (event) => {
  console.log('[SW] Service Worker 安装中...');
  
  // 跳过等待，立即激活
  self.skipWaiting();
  
  // 预缓存核心资源（可选）
  event.waitUntil(
    caches.open(CACHE_NAMES.app).then(cache => {
      console.log('[SW] 预缓存核心资源');
      return cache.addAll([
        '/',
        '/index.html',
        '/manifest.json',
      ]).catch(error => {
        console.warn('[SW] 预缓存失败:', error);
        // 预缓存失败不阻止 Service Worker 安装
      });
    })
  );
});

/**
 * Service Worker 激活事件
 */
self.addEventListener('activate', (event) => {
  console.log('[SW] Service Worker 激活中...');
  
  event.waitUntil(
    (async () => {
      // 清理旧版本缓存
      const cacheNames = await caches.keys();
      const validCacheNames = Object.values(CACHE_NAMES);
      
      await Promise.all(
        cacheNames.map(cacheName => {
          if (!validCacheNames.includes(cacheName)) {
            console.log('[SW] 删除旧缓存:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
      
      // 立即接管所有页面
      await self.clients.claim();
      console.log('[SW] Service Worker 已激活并接管页面');
    })()
  );
});

/**
 * Service Worker 请求拦截
 */
self.addEventListener('fetch', (event) => {
  const { request } = event;
  
  // 只处理 GET 请求
  if (request.method !== 'GET') {
    return;
  }
  
  // 跨域请求使用 no-cors 模式
  const requestToCache = request.mode === 'navigate' 
    ? new Request(request.url, { ...request, mode: 'same-origin' })
    : request;
  
  // 获取缓存策略
  const strategy = getCacheStrategy(requestToCache);
  
  // 根据策略处理请求
  if (strategy.strategy === 'cache-first') {
    event.respondWith(
      cacheFirst(requestToCache, strategy.cacheName, strategy.maxAge)
    );
  } else if (strategy.strategy === 'network-first') {
    event.respondWith(
      networkFirst(requestToCache, strategy.cacheName, strategy.maxAge)
    );
  }
});

/**
 * 消息事件处理
 */
self.addEventListener('message', (event) => {
  console.log('[SW] 收到消息:', event.data);
  
  // 跳过等待，立即激活新 Service Worker
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  
  // 清除所有缓存
  if (event.data === 'clearCache') {
    event.waitUntil(
      caches.keys().then(cacheNames => {
        return Promise.all(
          cacheNames.map(cacheName => caches.delete(cacheName))
        );
      }).then(() => {
        console.log('[SW] 所有缓存已清除');
        // 通知客户端缓存已清除
        self.clients.matchAll().then(clients => {
          clients.forEach(client => {
            client.postMessage({ type: 'cache-cleared' });
          });
        });
      })
    );
    return;
  }
  
  // 获取缓存统计信息
  if (event.data === 'getCacheStats') {
    event.waitUntil(
      (async () => {
        const stats = {};
        
        for (const [key, cacheName] of Object.entries(CACHE_NAMES)) {
          const cache = await caches.open(cacheName);
          const keys = await cache.keys();
          stats[key] = {
            name: cacheName,
            count: keys.length,
            urls: keys.map(req => req.url),
          };
        }
        
        // 发送统计信息回客户端
        const client = await self.clients.get(event.source.id);
        if (client) {
          client.postMessage({ type: 'cache-stats', data: stats });
        }
      })()
    );
    return;
  }
});

// 错误处理
self.addEventListener('error', (error) => {
  console.error('[SW] Service Worker 错误:', error);
});

self.addEventListener('unhandledrejection', (event) => {
  console.error('[SW] Service Worker 未处理的 Promise 拒绝:', event.reason);
});

console.log('[SW] Service Worker 脚本已加载');

