import 'package:flutter_web_server/src/services/system/user_service.dart';
import 'package:flutter_web_server/src/common/common.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

import 'rest_delegate_utils.dart';

/// 用户资源 `/api/user` 的 REST delegate。
///
/// 这里是「REST 只是表现层」这句话的落点：本类**只做 HTTP ↔ Service 的翻译**，
/// 业务实现全部复用 [UserService]（含 `disabled` 注入、部门子树展开、服务端分页），
/// 全仓只有这一段 CRUD 逻辑，不存在「两套实现要保持同步」的问题。
///
/// 失败一律抛 [RestException]（带业务码语义），成功把 Service 返回的
/// [CommonResponse] **原样**交出去 —— `ServerpodEnvelopeBuilder.success`
/// 认得它，会直接采用它的信封，不再包一层。
class UserRestDelegate extends RestCrudDelegate<SysUser> {
  UserRestDelegate({UserService? service})
    : _service = service ?? UserService();

  final UserService _service;

  /// `GET /api/user/getList` —— 分页列表。
  ///
  /// query 参数与 `UserListRequest` 字段一一对应：
  /// `tenantId` / `deptId`（自动展开子孙部门）/ `keyword`（OR 命中
  /// username/nickname/phone）/ `username` / `nickname` /
  /// `phone` / `email` / `status` / `page` / `pageSize`（服务端收敛上限 100）。
  ///
  /// ⚠️ 这里刻意**不走** [RestCrudDelegate] 的通用查询：用户列表有 10 个专用
  /// 过滤字段，通用的 `page/pageSize/keyword` 盖不住。
  ///
  /// 分页参数名与框架通用分页保持一致：`pageSize` 优先，兼容团队前端的 `size`。
  @override
  Future<Object?> list(Session session, Request request) async => ensureOk(
    await _service.getUserList(
      session,
      UserListRequest(
        tenantId: request.queryInt('tenantId'),
        deptId: request.queryInt('deptId'),
        // 前端单个搜索框走 keyword（OR 命中 username/nickname/phone）
        keyword: request.queryString('keyword'),
        username: request.queryString('username'),
        nickname: request.queryString('nickname'),
        phone: request.queryString('phone'),
        email: request.queryString('email'),
        status: request.queryString('status'),
        page: request.queryInt('page'),
        // `pageSize` 优先，兼容团队前端的 `size`（与通用分页同口径）。
        pageSize: request.queryInt('pageSize') ?? request.queryInt('size'),
      ),
    ),
  );

  /// `GET /api/user/getDetail?id=` —— 详情（含 `roleIds` 与 `roles`）。
  @override
  Future<Object?> detail(Session session, int id) async {
    final res = await _service.getDetail(session, id);
    if (res.isFailed) {
      // 基类的前置 requireAuth 已经挡掉了「未登录」，`pathId()` 已经挡掉了
      // 非法 id，所以走到这里失败只剩一种原因：记录不存在 → 404。
      // （Service 层用统一的业务码 50000 表达所有失败，无法在更早的层次区分，
      //   这一点记在 docs/rest-api-layer.md 的「已知缺口」里。）
      throw RestException.notFound(res.message ?? '用户不存在');
    }
    return res;
  }

  /// `POST /api/user/add` —— 新增用户，成功返回 201。
  ///
  /// ⚠️ `password` 必须是**前端登录公钥 RSA-OAEP(SHA-256) 加密后的 Base64 密文**
  /// （`UserService.add` 会先解密再 PBKDF2 哈希）。第三方对接要先取
  /// `GET /api/auth/publicKey` 再自行加密，不能直接传明文。
  @override
  Future<Object?> create(Session session, Map<String, dynamic> body) async =>
      ensureOk(await _service.add(session, buildUserRequest(body)));

  /// `POST /api/user/update` —— 更新用户（`id` 在 body 里）。
  ///
  /// 请求体里只需要给**要改的字段**：先读出当前记录做基线，再让请求体覆盖它。
  /// 缺省字段（尤其是生成代码里非空的 `username` / `nickname`，以及由关联表
  /// 维护的 `roleIds`）不会被写成空值。
  @override
  Future<Object?> update(
    Session session,
    int id,
    Map<String, dynamic> body,
  ) async {
    final baseline = await _service.getDetail(session, id);
    if (baseline.isFailed) {
      throw RestException.notFound(baseline.message ?? '用户不存在');
    }

    final merged = <String, dynamic>{
      ...Map<String, dynamic>.from(baseline.data as Map),
      ...body,
      'id': id,
    };
    return ensureOk(await _service.update(session, buildUserRequest(merged)));
  }

  /// `POST /api/user/delete` —— 软删除单条（`deleted = true`）。
  ///
  /// 系统内置用户（`isSuperuser`）会被 Service 拒绝，返回 400 而不是 403 ——
  /// 对调用方来说这是「这条记录不允许删」，而不是「你没有这个权限」。
  @override
  Future<void> remove(Session session, int id) async {
    // 删除的失败有两种原因：「记录不存在」和「系统内置用户不允许删」。
    // Service 只返回「失败」一个粒度，所以这里先确认资源存在，把「不存在」
    // 判成 404，剩下的失败就是业务规则拒绝 → 400（`ensureOk` 的默认 400）。
    // 多一次查询换「不存在」这个 code 判得准；删除不是热路径，可以接受。
    final existing = await _service.getDetail(session, id);
    if (existing.isFailed) {
      throw RestException.notFound(existing.message ?? '用户不存在');
    }
    ensureOk(await _service.delete(session, id));
  }
}

/// 把 HTTP 请求体翻译成 Service 层的 [UserRequest]。
///
/// [UserRequest] 的 `username` / `nickname` 在生成代码里是**非空** `String`，
/// 缺失时构造函数会直接抛，所以这里先显式校验一次，让客户端拿到 400 而不是 500。
UserRequest buildUserRequest(Map<String, dynamic> body) {
  final username = trimmedString(body['username']);
  final nickname = trimmedString(body['nickname']);

  if (username == null || username.isEmpty) {
    throw const RestException.badRequest('username 不能为空');
  }
  if (nickname == null || nickname.isEmpty) {
    throw const RestException.badRequest('nickname 不能为空');
  }

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
