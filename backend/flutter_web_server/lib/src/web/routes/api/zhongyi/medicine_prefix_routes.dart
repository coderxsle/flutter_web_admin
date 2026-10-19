import 'package:flutter_web_server/src/services/zhongyi/zhongyi_prefix_service.dart';
import 'package:flutter_web_server/src/web/routes/api/delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 炮制前缀字典接口，数据落在 data/zhongyi_prefixes.json。
Map<String, ActionRoute> zhongyiMedicinePrefixRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    '/api/lxs_zhongyi/medicine/prefixes': ActionRoute.byMethod(
      envelope: envelope,
      requireAuth: true,
      handlers: {
        Method.get: (session, request) => ZhongyiPrefixService.list(session),
        Method.post: (session, request) async =>
            ensureOk(await ZhongyiPrefixService.create(session, await request.jsonObjectBody())),
      },
    ),
  };
}
