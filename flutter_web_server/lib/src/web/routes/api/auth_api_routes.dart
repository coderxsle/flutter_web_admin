import 'package:flutter_web_server/src/services/system/auth_service.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 认证资源 `/api/auth` 的 REST 路由（迁移路线 S1）。
///
/// 登录、取公钥、刷 token 都是**单点动作**，套不进 CRUD 模板，所以用
/// [RestActionRoute] —— 它与泛型的 `BaseRestRoute<T>` **共用同一套**
/// 鉴权 / 信封 / 状态码 / 异常兜底，只是没有固定的子路由表。
/// （S1.5 之前这里用的是项目自己手写的 `ApiRoute`，与本包基类并存 —— 现已合一。）
///
/// 业务实现复用 [AuthService]，和 typed `AuthEndpoint`（8080）是同一份代码。
///
/// ## 路径为什么带连字符、又为什么是完整路径
///
/// * typed 侧是 `/auth/refreshToken` 这种驼峰 —— 那是「Endpoint 名 + 方法名」
///   拼出来的，REST 侧按惯例用连字符小写路径，不再沿用。
/// * `addRoute` 内部是 `injectAt`（一个挂载点只能挂一次），所以这里直接给
///   **完整路径**（`/api/auth/login`），不写「挂 `/api/auth` + 子路径」。
void registerAuthRoutes(Serverpod pod) {
  const envelope = ServerpodEnvelopeBuilder();

  // GET /api/auth/public-key —— 取登录用 RSA 公钥（PEM 字符串）。
  //
  // 第三方对接的第一步：拿公钥 → RSA-OAEP(SHA-256) 加密密码 → Base64 →
  // 再调 POST /api/auth/login。
  pod.webServer.addRoute(
    RestActionRoute(
      methods: const {Method.get},
      // ⚠️ 三条都必须匿名可访问：登录前本来就没有 accessToken，
      // 保持默认的 requireAuth=true 会在进入 handler 之前直接 401，
      // 连「取公钥」这一步都走不到，整条登录链路死掉。
      requireAuth: false,
      envelope: envelope,
      handler: (session, request) => AuthService.publicKey(session),
    ),
    '/api/auth/public-key',
  );

  // POST /api/auth/login —— 登录换取 accessToken / refreshToken。
  //
  // 请求体：{"username": "admin", "password": "<RSA-OAEP(SHA-256) 加密后的 Base64 密文>"}
  //
  // ⚠️ password 必须是**密文**：AuthService.login 会用服务端私钥先解密再做
  // PBKDF2 校验。明文版方案见 docs/rest-api-layer.md §8 待办 2。
  //
  // 成功返回 data = LoginResponse（userId / username / expiresIn / tokenType /
  // accessToken / refreshToken）。
  //
  // ⚠️ 业务失败仍是 code 50000 → HTTP 400（如「用户或密码错误」），**没有**
  // 映射成 401 —— 要保持「typed 与 REST 响应体逐字节一致」这条验收基线。
  // 语义化 code 是 docs/rest-api-layer.md §8 待办 1 的事。
  pod.webServer.addRoute(
    RestActionRoute(
      methods: const {Method.post},
      requireAuth: false,
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        final username = _requiredString(body, 'username');
        final password = _requiredString(body, 'password');
        return AuthService.login(session, username, password);
      },
    ),
    '/api/auth/login',
  );

  // POST /api/auth/refresh-token —— 用 refreshToken 换新的 accessToken。
  //
  // 请求体：{"refreshToken": "..."}（兼容下划线写法 refresh_token）。
  // 成功返回 data = {accessToken, refreshToken, tokenType, expiresIn}
  // —— refreshToken 会**轮换**，客户端要拿新的这个。
  pod.webServer.addRoute(
    RestActionRoute(
      methods: const {Method.post},
      requireAuth: false,
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        final refreshToken =
            _optionalString(body['refreshToken']) ??
            _optionalString(body['refresh_token']);
        if (refreshToken == null) {
          throw const RestApiException.badRequest('refreshToken 不能为空');
        }
        return AuthService.refreshToken(session, refreshToken);
      },
    ),
    '/api/auth/refresh-token',
  );
}

/// 读必填字符串字段；缺失或空白直接抛 400。
///
/// 为什么在表现层校验而不是交给 Service：`AuthService.login` 的入参是
/// **非空 `String`**，传 null 进去会在它最外层的 `catch` 里变成
/// `登录失败：…` 的 50000 —— 对调用方来说「你没传 username」应该是 400，
/// 不是「服务端炸了」。
String _requiredString(Map<String, dynamic> body, String key) {
  final value = _optionalString(body[key]);
  if (value == null) {
    throw RestApiException.badRequest('$key 不能为空');
  }
  return value;
}

String? _optionalString(dynamic value) {
  if (value == null) return null;
  final text = value.toString().trim();
  return text.isEmpty ? null : text;
}
