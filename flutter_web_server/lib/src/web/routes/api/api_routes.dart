import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

import 'auth_api_routes.dart';
import 'cors_middleware.dart';
import 'serverpod_envelope.dart';
import 'user_rest_delegate.dart';

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
/// ## 只有一套基类（S1.5 收口）
///
/// 全部 Route 都来自 `serverpod_crud`：
/// * 资源型（固定那套 CRUD 路由）→ [BaseRestRoute]，业务体写在 `RestCrudDelegate` 里；
/// * 动作型（登录、取公钥…）→ [RestActionRoute]，业务体写在 `handler` 里。
///
/// 两者共用同一份鉴权 / 信封 / HTTP 状态码 / 异常兜底实现，信封由
/// [ServerpodEnvelopeBuilder] 统一产出。**不要再引入第三种写法** ——
/// 混用两套基类是运行期才崩、`dart analyze` 抓不到的坑。
///
/// ⚠️ 一个挂载点只能 `addRoute` 一次（relic 的 `PathTrie` 会抛
/// `Conflicting values`），所以：
/// * `/api/user` 这类资源把整套子路由塞进 <b>一次</b> `addRoute`（见
///   [BaseRestRoute.injectIn]）；
/// * `/api/auth/login` 这类动作用**完整路径**各挂一次。
void registerApiRoutes(Serverpod pod) {
  // 浏览器跨域（Vite dev server → 8082）需要的 CORS 头。
  // Serverpod 的 `cors:` 配置只管 API server，Web Server 这条链路得自己补。
  // 来源白名单默认是本地开发端口，可用环境变量 `REST_CORS_ORIGINS` 覆盖。
  pod.webServer.addMiddleware(CorsMiddleware().asMiddleware, '/api');

  // ── 认证资源（S1）───────────────────────────────────────────────
  // 三条动作路由，全部匿名可访问。
  registerAuthRoutes(pod);

  // ── 用户资源（A 档）────────────────────────────────────────────
  // 一次挂载，自动产出整套路由：
  //   GET  /                 列表        GET    /:id        详情
  //   POST /                 新增(201)   PUT|PATCH /:id     更新
  //   DELETE /:id            删除        DELETE /           批量删除
  //   POST /update           更新(POST 兼容形式)
  //   POST /delete           删除(POST 兼容形式)
  // 业务差异全部收敛在 [UserRestDelegate] 里。
  pod.webServer.addRoute(
    BaseRestRoute<SysUser>(
      delegate: UserRestDelegate(),
      envelope: const ServerpodEnvelopeBuilder(),
    ),
    '/api/user',
  );
}
