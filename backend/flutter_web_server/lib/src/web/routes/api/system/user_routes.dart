import 'package:flutter_web_server/src/common/common.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/services/system/permission_service.dart';
import 'package:flutter_web_server/src/services/system/user_service.dart';
import 'package:flutter_web_server/src/web/routes/api/delegate_utils.dart';
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

  static Future<Object?> _getList(Session session, Request request) async {
    await _guard(session);
    return ensureOk(
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
  }

  static Future<Object?> _getDetail(Session session, Request request) async {
    await _guard(session);
    final result = await _service.getDetail(session, request.queryId());
    if (result.isFailed) throw RestException.notFound(result.message ?? '用户不存在');
    return result;
  }

  static Future<Object?> _add(Session session, Request request) async {
    await _guard(session);
    final body = await request.jsonObjectBody();
    await _guardRoleIds(session, body);
    return ensureOk(await _service.add(session, buildUserRequest(body)));
  }

  static Future<Object?> _update(Session session, Request request) async {
    await _guard(session);
    final body = await request.jsonObjectBody();
    final id = asIntOrNull(body['id']);
    if (id == null || id <= 0) throw const RestException.badRequest('请求体缺少合法的 id');
    if (body.containsKey('roleIds')) await _guardRoleChange(session, id, body);
    final baseline = await _service.getDetail(session, id);
    if (baseline.isFailed) throw RestException.notFound(baseline.message ?? '用户不存在');
    final merged = <String, dynamic>{...Map<String, dynamic>.from(baseline.data as Map), ...body, 'id': id};
    return ensureOk(await _service.update(session, buildUserRequest(merged)));
  }

  static Future<Object?> _delete(Session session, Request request) async {
    await _guard(session);
    final body = await request.jsonObjectBody();
    final id = extractSingleId(body);
    final existing = await _service.getDetail(session, id);
    if (existing.isFailed) throw RestException.notFound(existing.message ?? '用户不存在');
    return ensureOk(await _service.delete(session, id));
  }

  static Future<Object?> _deleteBatch(Session session, Request request) async {
    await _guard(session);
    return batchOf(await _service.deleteBatch(session, extractIds(await request.jsonObjectBody())));
  }

  static Future<Object?> _info(Session session, Request request) async => ensureOk(await _service.getUserInfo(session));

  static Future<Object?> _routes(Session session, Request request) async =>
      ensureOk(await _service.getUserRoutes(session));

  static Future<Object?> _resetPassword(Session session, Request request) async {
    await _guard(session);
    final body = await request.jsonObjectBody();
    final ids = requiredIntList(body, 'ids', aliases: const ['id']);
    if (!await PermissionService.isSuperuser(session)) {
      final targets = await SysUser.db.find(
        session,
        where: (t) => t.id.inSet(ids.toSet()) & t.isSuperuser.equals(true) & t.deleted.equals(false),
      );
      if (targets.isNotEmpty) throw const RestException.forbidden('只有超管可以重置超管密码');
    }
    return ensureOk(await _service.resetPassword(session, ids));
  }

  static Future<void> _guard(Session session) => PermissionService.require(session, 'menu:system:user');

  // 分配角色等于分配权限，避免只拿到用户管理就能自我提权
  static Future<void> _guardRoleIds(Session session, Map<String, dynamic> body) async {
    final roleIds = asIntListOrNull(body['roleIds']);
    if (roleIds != null && roleIds.isNotEmpty) {
      await PermissionService.require(session, 'menu:system:role');
    }
  }

  /// 编辑时只有角色确实变化才要求角色权限，否则改昵称也会被拦。
  static Future<void> _guardRoleChange(Session session, int userId, Map<String, dynamic> body) async {
    final roleIds = asIntListOrNull(body['roleIds']);
    if (roleIds == null) return;
    final current = await SysUserRole.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.deleted.equals(false),
    );
    final before = current.map((e) => e.roleId).toSet();
    final after = roleIds.toSet();
    if (before.length == after.length && before.containsAll(after)) return;
    await PermissionService.require(session, 'menu:system:role');
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
