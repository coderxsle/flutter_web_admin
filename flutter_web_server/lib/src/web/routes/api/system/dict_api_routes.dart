import 'package:flutter_web_server/src/services/system/dict_service.dart';
import 'package:flutter_web_server/src/web/routes/api/rest_delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';


void registerDictActionRoutes(Serverpod pod) => dictActionRoutes().forEach(
  (path, route) => pod.webServer.addRoute(route, path),
);

Map<String, ActionRoute> dictActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    '/api/dict/options': ActionRoute(
      methods: const {Method.get},
      requireAuth: false,
      envelope: envelope,
      handler: (session, request) async => ensureOk(
        await DictService.getDictData(session, tenantId: request.queryInt('tenantId')),
      ),
    ),
  };
}
