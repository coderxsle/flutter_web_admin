import 'package:flutter_web_server/src/services/system/auth_service.dart';
import 'package:flutter_web_server/src/web/routes/api/rest_delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 认证资源 `/api/auth` 的 REST 路由。
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
Map<String, RestActionRoute> authActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    // GET /api/auth/public-key —— 取登录用 RSA 公钥（PEM 字符串）。
    //
    // 第三方对接的第一步：拿公钥 → RSA-OAEP(SHA-256) 加密密码 → Base64 →
    // 再调 POST /api/auth/login。
    '/api/auth/public-key': RestActionRoute(
      methods: const {Method.get},
      // ⚠️ 三条都必须匿名可访问：登录前本来就没有 accessToken，
      // 保持默认的 requireAuth=true 会在进入 handler 之前直接 401，
      // 连「取公钥」这一步都走不到，整条登录链路死掉。
      requireAuth: false,
      envelope: envelope,
      handler: (session, request) => AuthService.publicKey(session),
    ),

    // POST /api/auth/login —— 登录换取 accessToken / refreshToken。
    //
    // 请求体：{"username": "admin", "password": "<RSA-OAEP(SHA-256) 加密后的 Base64 密文>"}
    //
    // ⚠️ password 必须是**密文**：AuthService.login 会用服务端私钥先解密再做
    // PBKDF2 校验。明文版方案见 docs/rest-api-layer.md §8.1 第 2 条。
    //
    // 成功返回 data = LoginResponse（userId / username / expiresIn / tokenType /
    // accessToken / refreshToken）。
    //
    // ⚠️ 业务失败（「用户或密码错误」）是 **200 + `{code:50000}`** —— 这是 2026-09-24
    // 定下的全站统一口径（业务失败一律 200，只放行 401），不是本条路由的特殊处理。
    // 原因（前端拦截器在非 2xx 分支会丢弃 body 的 message）见
    // docs/rest-api-layer.md §3.1 与 §6.9。
    // 顺带：这里显式用了 `requiredText` 做入参校验，它抛的也是业务失败 → 同样落 200。
    '/api/auth/login': RestActionRoute(
      methods: const {Method.post},
      requireAuth: false,
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        final username = requiredText(body, 'username');
        final password = requiredText(body, 'password');
        return AuthService.login(session, username, password);
      },
    ),

    // POST /api/auth/refresh-token —— 用 refreshToken 换新的 accessToken。
    //
    // 请求体：{"refreshToken": "..."}（兼容下划线写法 refresh_token）。
    // 成功返回 data = {accessToken, refreshToken, tokenType, expiresIn}
    // —— refreshToken 会**轮换**，客户端要拿新的这个。
    '/api/auth/refresh-token': RestActionRoute(
      methods: const {Method.post},
      requireAuth: false,
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        final refreshToken =
            trimmedString(body['refreshToken']) ??
            trimmedString(body['refresh_token']);
        if (refreshToken == null) {
          throw const RestApiException.badRequest('refreshToken 不能为空');
        }
        return AuthService.refreshToken(session, refreshToken);
      },
    ),
  };
}

/// 把 [authActionRoutes] 挂到 Web Server 上。
///
/// 「注册」与「测试」共用同一个 map —— 测试不必手抄一份路径清单，
/// 也就不会出现「改了代码忘了改测试」的假绿。
void registerAuthRoutes(Serverpod pod) => authActionRoutes().forEach(
  (path, route) => pod.webServer.addRoute(route, path),
);
