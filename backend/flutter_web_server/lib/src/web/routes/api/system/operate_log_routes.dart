import 'package:flutter_web_server/src/services/system/operate_log_service.dart';
import 'package:flutter_web_server/src/web/routes/api/delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 操作日志只有读接口：`/add`、`/update`、`/delete` 一律不挂。
Map<String, ActionRoute> operateLogActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    '/api/operateLog/getList': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) => OperateLogService.getList(
        session,
        page: request.queryInt('page'),
        pageSize: request.queryInt('pageSize'),
        type: request.queryString('type'),
        success: request.queryString('success'),
        keyword: request.queryString('keyword'),
        startTime: request.queryString('startTime'),
        endTime: request.queryString('endTime'),
      ),
    ),
    '/api/operateLog/getDetail': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async => ensureOk(await OperateLogService.getDetail(session, request.queryId())),
    ),
  };
}

/// 把 [operateLogActionRoutes] 挂到 Web Server 上。
void registerOperateLogRoutes(Serverpod pod) => operateLogActionRoutes().forEach(
  (path, route) => pod.webServer.addRoute(route, path),
);
