import 'dart:convert';

import 'package:flutter_web_server/src/common/common.dart';
import 'package:flutter_web_server/src/services/zhouyi/arts_record_service.dart';
import 'package:flutter_web_server/src/web/routes/api/delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 术数排盘记录的 REST 动作路由表。
///
/// 移动端在排盘时调用 `save`（按 client_key 幂等），列表/详情给记录页与后台
/// 查询用。挂载由 `RoutesManager` 统一处理。
Map<String, ActionRoute> artsRecordActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();
  return {
    '/api/lxs_arts/record/list': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async => ensureOk(
        await ArtsRecordService.list(
          session,
          page: request.queryInt('page') ?? 1,
          pageSize: request.queryInt('pageSize') ?? 20,
          artsType: request.queryString('artsType'),
          keyword: request.queryString('keyword'),
          startTime: _queryDate(request, 'startTime'),
          endTime: _queryDate(request, 'endTime'),
          userId: request.queryInt('userId'),
        ),
      ),
    ),
    '/api/lxs_arts/record/detail/:id': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async =>
          ensureOk(CommonResponse.success(await ArtsRecordService.detail(session, request.pathId()))),
    ),
    '/api/lxs_arts/record/save': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      successStatus: 201,
      handler: (session, request) async =>
          ensureOk(CommonResponse.success(await ArtsRecordService.save(session, await request.jsonObjectBody()))),
    ),
    '/api/lxs_arts/record/update/:id': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async => ensureOk(
        CommonResponse.success(
          await ArtsRecordService.update(session, request.pathId(), await request.jsonObjectBody()),
        ),
      ),
    ),
    '/api/lxs_arts/record/delete': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async =>
          ensureOk(CommonResponse.success(await ArtsRecordService.delete(session, await _idsBody(request)))),
    ),
    '/api/lxs_arts/record/status': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async =>
          ensureOk(CommonResponse.success(await ArtsRecordService.setStatus(session, await request.jsonObjectBody()))),
    ),
  };
}

/// 注册术数排盘记录的全部接口。
void registerArtsRecordRoutes(Serverpod pod) =>
    artsRecordActionRoutes().forEach((path, route) => pod.webServer.addRoute(route, path));

DateTime? _queryDate(Request request, String key) {
  final raw = request.queryString(key);
  if (raw == null || raw.trim().isEmpty) return null;
  final parsed = DateTime.tryParse(raw.trim());
  if (parsed == null) throw RestException.badRequest('查询参数 $key 必须是 ISO8601 时间');
  return parsed;
}

Future<List<int>> _idsBody(Request request) async {
  final raw = await request.readAsString();
  dynamic decoded;
  try {
    decoded = jsonDecode(raw);
  } on FormatException catch (error) {
    throw RestException.badRequest('请求体不是合法 JSON：${error.message}');
  }

  final rawIds = switch (decoded) {
    final List<dynamic> ids => ids,
    final Map<dynamic, dynamic> body => body['ids'] ?? body['id'],
    _ => null,
  };
  final ids = asIntListOrNull(rawIds);
  if (ids == null || ids.isEmpty) throw RestException.badRequest('ids 必须是非空整数数组');
  return ids;
}
