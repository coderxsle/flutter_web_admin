import 'package:flutter_web_server/src/services/system/user_service.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod/serverpod.dart';

import 'api_route.dart';

/// 用户资源 `/api/user` 的 REST 路由集合。
///
/// 每个类只对应「一种 HTTP 方法 + 一个 URL」，类体内**不出现任何 ORM 调用**；
/// 查询与写入全部委托给 [UserService] —— 也就是 Flutter 客户端调用的
/// `UserEndpoint` 背后同一个 Service。
///
/// 这是本分支要验证的核心命题：**REST 只是表现层**。
/// 同一个 `GET /api/user?deptId=1` 与 typed API `user.getUserList`，
/// 在服务端走的是同一段代码（含 `disabled` 注入、部门子树展开、服务端分页），
/// 因此不存在「两套 CRUD 逻辑要保持同步」的问题。
///
/// 对外契约：
/// * 状态码：200/201 成功，400 业务或参数失败，401 未登录，403 无权限，404 资源不存在，500 未预期异常
/// * 响应体：项目统一的 `{code, message, data}` 信封（`CommonResponse.toJson()`），
///   已由 `JsonCleaner` 去掉 `__className__` / `password`，可直接给第三方消费

/// `GET /api/user` —— 分页列表。
///
/// 支持的 query 参数与 `UserListRequest` 字段一一对应：
/// `tenantId` / `deptId`（自动展开子树）/ `username` / `nickname` /
/// `phone` / `email` / `status` / `page` / `pageSize`（服务端收敛上限 100）。
class UserListRoute extends ApiRoute {
  UserListRoute() : super(methods: {Method.get});

  final UserService _service = UserService();

  @override
  Future<CommonResponse> dispatch(Session session, Request request) {
    return _service.getUserList(
      session,
      UserListRequest(
        tenantId: request.queryInt('tenantId'),
        deptId: request.queryInt('deptId'),
        username: request.queryString('username'),
        nickname: request.queryString('nickname'),
        phone: request.queryString('phone'),
        email: request.queryString('email'),
        status: request.queryString('status'),
        page: request.queryInt('page'),
        pageSize: request.queryInt('pageSize'),
      ),
    );
  }
}

/// `POST /api/user` —— 新增用户，成功返回 201。
///
/// ⚠️ `password` 必须是**前端登录公钥 RSA-OAEP(SHA-256) 加密后的 Base64 密文**
/// （见 `UserService.add` 的实现：它会先解密再 PBKDF2 哈希后落库）。
/// 这是 Service 层隐含的约定被 REST 层原样继承 —— 第三方对接时需要先取
/// `POST /auth/publicKey` 再自行加密，不能直接传明文。
class UserCreateRoute extends ApiRoute {
  UserCreateRoute() : super(methods: {Method.post});

  final UserService _service = UserService();

  @override
  bool get createdOnSuccess => true;

  @override
  Future<CommonResponse> dispatch(Session session, Request request) async {
    final body = await request.jsonObjectBody();
    return _service.add(session, buildUserRequest(body));
  }
}

/// `GET /api/user/:id` —— 详情（含 `roleIds` 与 `roles`）。
class UserDetailRoute extends ApiRoute {
  UserDetailRoute() : super(methods: {Method.get}, path: '/:id');

  final UserService _service = UserService();

  @override
  Future<CommonResponse> dispatch(Session session, Request request) async {
    final res = await _service.getDetail(session, request.pathId());
    if (res.isFailed) {
      // 前置的 requireAuth 已经挡掉了「未登录」，pathId() 已经挡掉了非法 id，
      // 所以走到这里失败只剩一种原因：记录不存在 → 404。
      // （Service 层用统一的业务码 50000 表达所有失败，无法在更早的层次区分，
      //   这一点记在 docs/rest-api-layer.md 的「已知缺口」里。）
      throw ApiException(404, res.message ?? '用户不存在');
    }
    return res;
  }
}

/// `PUT|PATCH /api/user/:id` —— 更新用户。
///
/// 请求体里只需要给**要改的字段**：先在 Service 层读出当前记录做基线，
/// 再让请求体覆盖它。缺省字段（尤其是生成代码里为非空的 `username` /
/// `nickname`，以及关联表维护的 `roleIds`）不会被写成空值。
///
/// 之所以选 `PUT` 作主路径而不是 `PATCH`：当前 `config/development.yaml`
/// 的 CORS 白名单是 `GET/POST/PUT/DELETE`，浏览器跨域预检不会放行 PATCH。
/// 两个方法都注册只是为了 curl / 服务端调用方便。
class UserUpdateRoute extends ApiRoute {
  UserUpdateRoute()
    : super(methods: {Method.put, Method.patch}, path: '/:id');

  final UserService _service = UserService();

  @override
  Future<CommonResponse> dispatch(Session session, Request request) async {
    final id = request.pathId();
    final body = await request.jsonObjectBody();

    final baseline = await _service.getDetail(session, id);
    if (baseline.isFailed) {
      // 能走到这里说明已经通过了基类的 requireAuth 前置检查，
      // 所以失败只可能是「记录不存在」这类资源级问题 → 404。
      throw ApiException(404, baseline.message ?? '用户不存在');
    }

    final merged = <String, dynamic>{
      ...Map<String, dynamic>.from(baseline.data as Map),
      ...body,
      'id': id,
    };
    return _service.update(session, buildUserRequest(merged));
  }
}

/// `DELETE /api/user/:id` —— 软删除（`deleted = true`）。
///
/// 系统内置用户（`isSuperuser`）会被 Service 拒绝，返回 400 而不是 403 ——
/// 因为对调用方来说这是「这条记录不允许删」，而不是「你没有这个权限」。
class UserDeleteRoute extends ApiRoute {
  UserDeleteRoute() : super(methods: {Method.delete}, path: '/:id');

  final UserService _service = UserService();

  @override
  Future<CommonResponse> dispatch(Session session, Request request) async {
    final id = request.pathId();

    // 删除的失败有两种原因：「记录不存在」和「系统内置用户不允许删」。
    // Service 只返回「失败」一个粒度，所以这里先确认资源存在，
    // 把「不存在」判成 404，剩下的失败就是业务规则拒绝 → 400。
    // 多一次查询换 HTTP 语义正确；删除不是热路径，可以接受。
    final existing = await _service.getDetail(session, id);
    if (existing.isFailed) {
      throw ApiException(404, existing.message ?? '用户不存在');
    }

    return _service.delete(session, id);
  }
}

/// 把 HTTP 请求体翻译成 Service 层的 [UserRequest]。
///
/// [UserRequest] 的 `username` / `nickname` 在生成代码里是**非空** `String`，
/// 缺失时构造函数会直接抛，所以这里先显式校验一次，让客户端拿到 400 而不是 500。
UserRequest buildUserRequest(Map<String, dynamic> body) {
  final username = _asString(body['username']);
  final nickname = _asString(body['nickname']);

  if (username == null || username.isEmpty) {
    throw const ApiException(400, 'username 不能为空');
  }
  if (nickname == null || nickname.isEmpty) {
    throw const ApiException(400, 'nickname 不能为空');
  }

  return UserRequest(
    id: asIntOrNull(body['id']),
    username: username,
    nickname: nickname,
    password: _asString(body['password']),
    email: _asString(body['email']),
    status: asIntOrNull(body['status']),
    roleIds: switch (body['roleIds']) {
      final List<dynamic> ids => ids.map(asIntOrNull).whereType<int>().toList(),
      _ => null,
    },
    deptId: asIntOrNull(body['deptId']),
    phone: _asString(body['phone']),
    gender: asIntOrNull(body['gender']),
    description: _asString(body['description']),
  );
}

String? _asString(dynamic value) {
  if (value == null) return null;
  final text = value.toString().trim();
  return text.isEmpty ? null : text;
}
