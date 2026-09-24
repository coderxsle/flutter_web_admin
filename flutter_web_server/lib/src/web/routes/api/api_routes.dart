import 'package:serverpod/serverpod.dart';

import 'api_route.dart';
import 'auth_api_routes.dart';
import 'cors_middleware.dart';
import 'user_api_routes.dart';

/// 注册全部 REST 路由（挂载在 `webServer`，开发环境是 8082 端口）。
///
/// 和 typed Endpoint 的分工：
///
/// | | typed Endpoint（8080） | REST Route（8082 `/api/**`） |
/// |---|---|---|
/// | 消费者 | Flutter / Vue 客户端（serverpod 生成的 client） | 浏览器、Webhook、第三方服务、脚本 |
/// | 入参 | 具名参数 + 类型标签线格式 | URL path / query / 普通 JSON body |
/// | 出参 | 协议序列化（含 `__className__`） | 纯 JSON（`CommonResponse` 信封） |
/// | 业务实现 | `services/system/*_service.dart` | **同一个 Service** |
///
/// 也就是说 REST 层是「再加一层表现层」，不是「再写一套 CRUD」。
///
/// ⚠️ 一个资源只能 `addRoute` 一次（挂载点唯一），所以要用 [ApiMount] 把
/// 该资源下的多条「方法 + 子路径」一次性挂上去。详见 [ApiMount] 的注释。
void registerApiRoutes(Serverpod pod) {
  // 浏览器跨域（Vite dev server → 8082）需要的 CORS 头。
  // Serverpod 的 `cors:` 配置只管 API server，Web Server 这条链路得自己补。
  // 来源白名单默认是本地开发端口，可用环境变量 `REST_CORS_ORIGINS` 覆盖。
  pod.webServer.addMiddleware(CorsMiddleware().asMiddleware, '/api');

  // 认证资源（S1）—— 三条路由全部匿名可访问（登录前没有 token）。
  // 必须先挂 /api/auth 再挂 /api/user 没有顺序要求，挂载点不同即可。
  pod.webServer.addRoute(
    ApiMount([
      AuthPublicKeyRoute(), // GET  /api/auth/public-key
      AuthLoginRoute(), // POST /api/auth/login
      AuthRefreshTokenRoute(), // POST /api/auth/refresh-token
    ]),
    '/api/auth',
  );

  pod.webServer.addRoute(
    ApiMount([
      UserListRoute(), // GET    /api/user
      UserCreateRoute(), // POST   /api/user
      UserDetailRoute(), // GET    /api/user/:id
      UserUpdateRoute(), // PUT|PATCH /api/user/:id
      UserDeleteRoute(), // DELETE /api/user/:id
    ]),
    '/api/user',
  );
}
