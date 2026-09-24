import 'package:flutter_web_server/src/services/system/auth_service.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod/serverpod.dart';

import 'api_route.dart';

/// 认证资源 `/api/auth` 的 REST 路由集合（迁移路线 S1）。
///
/// 和 `/api/user` 一样，这里**只做 HTTP 翻译**：解析 body → 调一次
/// [AuthService] 的静态方法 → 把 `CommonResponse` 包成 HTTP 响应。
/// 业务实现与 typed `AuthEndpoint`（8080）共用同一份 `AuthService`，
/// 所以不存在「两套登录逻辑要保持同步」的问题。
///
/// 路径为什么带连字符（`public-key` / `refresh-token`）而不是照抄 Endpoint
/// 方法名：typed 侧是 `/auth/refreshToken` 这种驼峰（Endpoint 名 + 方法名拼
/// 出来的），REST 侧按惯例用连字符的小写路径。这是迁移方案 §5 里
/// 「S3 路径要重新设计成扁平资源 URL」的起点。
///
/// ⚠️ **三条路由全部 `requireAuth => false`**：登录前本来就没有
/// accessToken，而 [ApiRoute.requireAuth] 默认是 `true` —— 不覆写的话基类会
/// 在进入 `dispatch` 之前就返回 401，连「取公钥」这一步都走不到。
///
/// 对外契约（与 typed 侧逐字段一致）：
/// * **业务失败仍是 `code 50000` → HTTP 400**（如「用户或密码错误」）。
///   没有映射成 401，是为了保持「typed 与 REST 响应体逐字节一致」这个
///   验收基线 —— Service 层只有一个失败粒度，语义化 code 是
///   `docs/rest-api-layer.md` §8 待办 1 的事，不在这里单独打补丁。
/// * 未带 / 带了失效的 token 访问**其他**受保护接口才是 401/40100。

/// `GET /api/auth/public-key` —— 取登录用 RSA 公钥（PEM 字符串）。
///
/// 第三方对接的第一步：拿公钥 → 用 `RSA-OAEP(SHA-256)` 加密密码 →
/// Base64 编码 → 再调 `POST /api/auth/login`。
class AuthPublicKeyRoute extends ApiRoute {
  AuthPublicKeyRoute() : super(methods: {Method.get}, path: '/public-key');

  @override
  bool get requireAuth => false;

  @override
  Future<CommonResponse> dispatch(Session session, Request request) =>
      AuthService.publicKey(session);
}

/// `POST /api/auth/login` —— 登录换取 accessToken / refreshToken。
///
/// 请求体：
/// ```json
/// {
///   "username": "admin",
///   "password": "<RSA-OAEP(SHA-256) 加密后的 Base64 密文>"
/// }
/// ```
///
/// ⚠️ `password` 必须是**密文**。`AuthService.login` 会先用服务端私钥解密、
/// 再做 PBKDF2 校验，直接传明文会解密失败。这条约定与 typed `auth.login`
/// 完全一致（明文版方案见 `docs/rest-api-layer.md` §8 待办 2）。
///
/// 成功时 `data` 是 `LoginResponse`：`userId` / `username` / `expiresIn` /
/// `tokenType` / `accessToken` / `refreshToken`。
class AuthLoginRoute extends ApiRoute {
  AuthLoginRoute() : super(methods: {Method.post}, path: '/login');

  @override
  bool get requireAuth => false;

  @override
  Future<CommonResponse> dispatch(Session session, Request request) async {
    final body = await request.jsonObjectBody();
    final username = _requiredString(body, 'username');
    final password = _requiredString(body, 'password');
    return AuthService.login(session, username, password);
  }
}

/// `POST /api/auth/refresh-token` —— 用 refreshToken 换新的 accessToken。
///
/// 请求体：`{ "refreshToken": "..." }`
/// （同时兼容下划线写法 `refresh_token`，方便非 JS 客户端）。
///
/// 成功时 `data` 是 `{accessToken, refreshToken, tokenType, expiresIn}`
/// —— 注意 refreshToken 会**轮换**，客户端要拿新的这个。
class AuthRefreshTokenRoute extends ApiRoute {
  AuthRefreshTokenRoute()
    : super(methods: {Method.post}, path: '/refresh-token');

  @override
  bool get requireAuth => false;

  @override
  Future<CommonResponse> dispatch(Session session, Request request) async {
    final body = await request.jsonObjectBody();
    final refreshToken =
        _optionalString(body['refreshToken']) ??
        _optionalString(body['refresh_token']);
    if (refreshToken == null) {
      throw const ApiException(400, 'refreshToken 不能为空');
    }
    return AuthService.refreshToken(session, refreshToken);
  }
}

/// 读必填字符串字段；缺失或空白直接抛 400。
///
/// 为什么在这里校验而不是交给 Service：`AuthService.login` 的入参是
/// **非空 `String`**，传 null 进去会在最外层 `catch` 里变成
/// `登录失败：...` 的 50000 —— 对调用方来说「你没传 username」应该是 400，
/// 不是「服务端炸了」。
String _requiredString(Map<String, dynamic> body, String key) {
  final value = _optionalString(body[key]);
  if (value == null) {
    throw ApiException(400, '$key 不能为空');
  }
  return value;
}

String? _optionalString(dynamic value) {
  if (value == null) return null;
  final text = value.toString().trim();
  return text.isEmpty ? null : text;
}
