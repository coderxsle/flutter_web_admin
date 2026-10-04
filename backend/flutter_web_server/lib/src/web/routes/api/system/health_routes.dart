import 'package:flutter_web_server/src/services/system/system_service.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

Map<String, ActionRoute> systemActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    // 健康检查。
    // ⚠️ 匿名可访问：探活方（k8s、负载均衡、监控）不会先登录换 token，
    // 前端「关于」页也要在登录前就能看。
    '/api/system/health': ActionRoute(
      methods: const {Method.get},
      requireAuth: false,
      envelope: envelope,
      handler: (session, request) => SystemService.health(session),
    ),

    // 版本信息。
    '/api/system/version': ActionRoute(
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
