import 'package:flutter_web_server/src/services/person_json_service.dart';
import 'package:flutter_web_server/src/web/routes/api/delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 把人员 JSON CRUD 接口挂到 Web Server 上。
void registerPersonRoutes(Serverpod pod) =>
    personActionRoutes().forEach((path, route) => pod.webServer.addRoute(route, path));

/// 人员资源 `/api/person` 的 REST 路由。
Map<String, ActionRoute> personActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    '/api/person/getList': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) => PersonJsonService.getList(
        page: request.queryInt('page') ?? 1,
        size: request.queryInt('size') ?? request.queryInt('pageSize') ?? 10,
        name: request.queryString('name'),
        status: request.queryString('status'),
        categoryId: request.queryString('categoryId'),
      ),
    ),
    '/api/person/getDetail': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async {
        final id = request.queryInt('id');
        if (id == null) throw const RestException.badRequest('id 必须是整数');
        return ensureOk(await PersonJsonService.getDetail(id));
      },
    ),
    '/api/person/add': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async => ensureOk(await PersonJsonService.add(await request.jsonObjectBody())),
    ),
    '/api/person/update': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async => ensureOk(await PersonJsonService.update(await request.jsonObjectBody())),
    ),
    '/api/person/delete': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async {
        final id = requiredInt(await request.jsonObjectBody(), 'id');
        return ensureOk(await PersonJsonService.delete(id));
      },
    ),
    '/api/person/deleteBatch': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async {
        final ids = requiredIntList(await request.jsonObjectBody(), 'ids');
        return ensureOk(await PersonJsonService.deleteBatch(ids));
      },
    ),
    '/api/person/category/tree': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async => ensureOk(await PersonJsonService.getCategoryTree()),
    ),
    '/api/person/options': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async => ensureOk(await PersonJsonService.getOptions()),
    ),
  };
}
