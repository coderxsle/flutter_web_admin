import 'package:flutter_web_server/src/common/common.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/services/system/user_service.dart';
import 'package:flutter_web_server/src/web/routes/api/rest_delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

class UserRoute extends BaseRoute<SysUser> {
  UserRoute()
    : super(
        envelope: const ServerpodEnvelopeBuilder(),
        actionList: [
          get('/getList', _getList),
          get('/getDetail', _getDetail),
          post('/add', _add, successStatus: 201),
          post('/update', _update),
          post('/delete', _delete),
          post('/deleteBatch', _deleteBatch),
          get('/info', _info),
          get('/routes', _routes),
          post('/reset-password', _resetPassword),
        ],
      );

  static final UserService _service = UserService();

  static Future<Object?> _getList(Session session, Request request) async => ensureOk(
    await _service.getUserList(
      session,
      UserListRequest(
        tenantId: request.queryInt('tenantId'),
        deptId: request.queryInt('deptId'),
        keyword: request.queryString('keyword'),
        username: request.queryString('username'),
        nickname: request.queryString('nickname'),
        phone: request.queryString('phone'),
        email: request.queryString('email'),
        status: request.queryString('status'),
        page: request.queryInt('page'),
        pageSize: request.queryInt('pageSize') ?? request.queryInt('size'),
      ),
    ),
  );

  static Future<Object?> _getDetail(Session session, Request request) async {
    final result = await _service.getDetail(session, request.queryId());
    if (result.isFailed) throw RestException.notFound(result.message ?? '用户不存在');
    return result;
  }

  static Future<Object?> _add(Session session, Request request) async =>
      ensureOk(await _service.add(session, buildUserRequest(await request.jsonObjectBody())));

  static Future<Object?> _update(Session session, Request request) async {
    final body = await request.jsonObjectBody();
    final id = asIntOrNull(body['id']);
    if (id == null || id <= 0) throw const RestException.badRequest('请求体缺少合法的 id');
    final baseline = await _service.getDetail(session, id);
    if (baseline.isFailed) throw RestException.notFound(baseline.message ?? '用户不存在');
    final merged = <String, dynamic>{...Map<String, dynamic>.from(baseline.data as Map), ...body, 'id': id};
    return ensureOk(await _service.update(session, buildUserRequest(merged)));
  }

  static Future<Object?> _delete(Session session, Request request) async {
    final body = await request.jsonObjectBody();
    final id = extractSingleId(body);
    final existing = await _service.getDetail(session, id);
    if (existing.isFailed) throw RestException.notFound(existing.message ?? '用户不存在');
    return ensureOk(await _service.delete(session, id));
  }

  static Future<Object?> _deleteBatch(Session session, Request request) async =>
      batchOf(await _service.deleteBatch(session, extractIds(await request.jsonObjectBody())));

  static Future<Object?> _info(Session session, Request request) async => ensureOk(await _service.getUserInfo(session));

  static Future<Object?> _routes(Session session, Request request) async =>
      ensureOk(await _service.getUserRoutes(session));

  static Future<Object?> _resetPassword(Session session, Request request) async {
    final body = await request.jsonObjectBody();
    final ids = requiredIntList(body, 'ids', aliases: const ['id']);
    return ensureOk(await _service.resetPassword(session, ids));
  }
}

UserRequest buildUserRequest(Map<String, dynamic> body) {
  final username = trimmedString(body['username']);
  final nickname = trimmedString(body['nickname']);
  if (username == null || username.isEmpty) throw const RestException.badRequest('username 不能为空');
  if (nickname == null || nickname.isEmpty) throw const RestException.badRequest('nickname 不能为空');
  return UserRequest(
    id: asIntOrNull(body['id']),
    username: username,
    nickname: nickname,
    password: trimmedString(body['password']),
    email: trimmedString(body['email']),
    status: asIntOrNull(body['status']),
    roleIds: asIntListOrNull(body['roleIds']),
    deptId: asIntOrNull(body['deptId']),
    phone: trimmedString(body['phone']),
    gender: asIntOrNull(body['gender']),
    description: trimmedString(body['description']),
  );
}
