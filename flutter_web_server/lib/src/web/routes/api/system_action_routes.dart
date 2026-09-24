import 'package:flutter_web_server/src/services/system/system_service.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 系统信息的**业务动作**路由（B 档）。
///
/// | typed 方法 | REST |
/// |---|---|
/// | `health()` | `GET /api/system/health` |
/// | `version()` | `GET /api/system/version` |
///
/// 两条都**不碰数据库、不碰业务表**，只是把环境变量与 `Platform.version`
/// 读出来 —— 用于探活（k8s / 负载均衡 / 监控）与前端关于页。
///
/// ## 路径为什么放在 `/api/system` 而不是 `/api/system-info`
///
/// 这两条是典型的**探活接口**：路径要短、要稳定、要能被运维直接写进探针配置。
/// 与 `/healthz`、`/actuator/health` 是同一类惯例。
///
/// 单独起一个挂载点（而不是复用 A 档资源）是因为系统信息根本没有 CRUD 语义 ——
/// 没有列表、没有详情、不能改也不能删。
Map<String, RestActionRoute> systemActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    // GET /api/system/health —— 健康检查。
    // data 里含 status / timestamp / version / environment / service / database。
    //
    // ⚠️ 匿名可访问：探活方（k8s、负载均衡、监控）不会先登录换 token。
    // 与 typed 侧的 `@unauthenticatedClientCall` 对齐。
    '/api/system/health': RestActionRoute(
      methods: const {Method.get},
      requireAuth: false,
      envelope: envelope,
      handler: (session, request) => SystemService.health(session),
    ),

    // GET /api/system/version —— 版本信息。
    // data 里含 version / app_title / project_name / build / commit / dart_version。
    //
    // 同样匿名可访问，理由同 health：前端「关于」页与线上排障要在登录前就能看。
    '/api/system/version': RestActionRoute(
      methods: const {Method.get},
      requireAuth: false,
      envelope: envelope,
      handler: (session, request) => SystemService.version(session),
    ),
  };
}

/// 把 [systemActionRoutes] 挂到 Web Server 上。
void registerSystemActionRoutes(Serverpod pod) => systemActionRoutes().forEach(
  (path, route) => pod.webServer.addRoute(route, path),
);
