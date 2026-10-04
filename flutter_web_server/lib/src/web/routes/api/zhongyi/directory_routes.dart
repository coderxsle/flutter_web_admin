import 'dart:convert';

import 'package:flutter_web_server/src/services/zhongyi/zhongyi_directory_service.dart';
import 'package:flutter_web_server/src/web/routes/api/delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 科室和员工目录的 REST 动作路由表。
///
/// [RoutesManager] 应将返回的完整路径逐条传给 `pod.webServer.addRoute`。
Map<String, ActionRoute> zhongyiDirectoryActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();
  return {
    '/api/lxs_zhongyi/department/list': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async => ensureOk(
        await ZhongyiDirectoryService.listDepartments(
          session,
          pageNo: _pageNumber(request),
          pageSize: _pageSize(request),
          name: request.queryString('name'),
          code: request.queryString('code'),
          isActive: _queryBool(request, 'is_active'),
        ),
      ),
    ),
    '/api/lxs_zhongyi/department/tree': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async => ensureOk(
        await ZhongyiDirectoryService.departmentTree(
          session,
          name: request.queryString('name'),
          code: request.queryString('code'),
          isActive: _queryBool(request, 'is_active'),
        ),
      ),
    ),
    '/api/lxs_zhongyi/department/detail/:id': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async =>
          ensureOk(await ZhongyiDirectoryService.departmentDetail(session, request.pathId())),
    ),
    '/api/lxs_zhongyi/department/create': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      successStatus: 201,
      handler: (session, request) async =>
          ensureOk(await ZhongyiDirectoryService.createDepartment(session, await request.jsonObjectBody())),
    ),
    '/api/lxs_zhongyi/department/update/:id': ActionRoute(
      methods: const {Method.put},
      envelope: envelope,
      handler: (session, request) async => ensureOk(
        await ZhongyiDirectoryService.updateDepartment(session, request.pathId(), await request.jsonObjectBody()),
      ),
    ),
    '/api/lxs_zhongyi/department/delete': ActionRoute(
      methods: const {Method.delete},
      envelope: envelope,
      handler: (session, request) async =>
          ensureOk(await ZhongyiDirectoryService.deleteDepartments(session, await _idsBody(request))),
    ),
    '/api/lxs_zhongyi/staff/list': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async => ensureOk(
        await ZhongyiDirectoryService.listStaff(
          session,
          pageNo: _pageNumber(request),
          pageSize: _pageSize(request),
          employeeCode: request.queryString('employee_code'),
          departmentId: request.queryInt('department_id'),
          isDoctor: _queryBool(request, 'is_doctor'),
          isPharmacist: _queryBool(request, 'is_pharmacist'),
          professionalTitle: request.queryString('professional_title'),
        ),
      ),
    ),
    '/api/lxs_zhongyi/staff/detail/:id': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async =>
          ensureOk(await ZhongyiDirectoryService.staffDetail(session, request.pathId())),
    ),
    '/api/lxs_zhongyi/staff/create': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      successStatus: 201,
      handler: (session, request) async =>
          ensureOk(await ZhongyiDirectoryService.createStaff(session, await request.jsonObjectBody())),
    ),
    '/api/lxs_zhongyi/staff/update/:id': ActionRoute(
      methods: const {Method.put},
      envelope: envelope,
      handler: (session, request) async => ensureOk(
        await ZhongyiDirectoryService.updateStaff(session, request.pathId(), await request.jsonObjectBody()),
      ),
    ),
    '/api/lxs_zhongyi/staff/delete': ActionRoute(
      methods: const {Method.delete},
      envelope: envelope,
      handler: (session, request) async =>
          ensureOk(await ZhongyiDirectoryService.deleteStaff(session, await _idsBody(request))),
    ),
  };
}

/// 注册科室与员工全路径动作接口。
void registerZhongyiDirectoryRoutes(Serverpod pod) =>
    zhongyiDirectoryActionRoutes().forEach((path, route) => pod.webServer.addRoute(route, path));

int? _pageNumber(Request request) => request.queryInt('page_no') ?? request.queryInt('page');

int? _pageSize(Request request) => request.queryInt('page_size') ?? request.queryInt('pageSize');

bool? _queryBool(Request request, String key) {
  final raw = request.queryString(key);
  if (raw == null) return null;
  final value = asBoolOrNull(raw);
  if (value == null) throw RestException.badRequest('查询参数 $key 必须是布尔值');
  return value;
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
  final ids = normalizedIntList(rawIds);
  if (ids.isEmpty) throw const RestException.badRequest('请求体必须包含非空的正整数ID数组');
  return ids;
}
