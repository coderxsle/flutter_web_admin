import 'package:flutter_web_server/src/services/system/auth_service.dart';
import 'package:flutter_web_server/src/web/routes/api/rest_delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';


/// 把 [authActionRoutes] 挂到 Web Server 上。
///
/// 「注册」与「测试」共用同一个 map —— 测试不必手抄一份路径清单，
/// 也就不会出现「改了代码忘了改测试」的假绿。
void registerAuthRoutes(Serverpod pod) => authActionRoutes().forEach(
  (path, route) => pod.webServer.addRoute(route, path),
);


/// 认证资源 `/api/auth` 的 REST 路由。
///
/// 登录、取公钥、刷 token 都是**单点动作**，套不进 CRUD 模板，所以用
/// [ActionRoute] —— 它与泛型的 `BaseRoute<T>` **共用同一套**
Map<String, ActionRoute> authActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    // GET /api/auth/publicKey —— 取登录用 RSA 公钥（PEM 字符串）。
    '/api/auth/publicKey': ActionRoute(
      methods: const {Method.get},
      requireAuth: false,
      envelope: envelope,
      handler: (session, request) => AuthService.publicKey(session),
    ),

    // POST /api/auth/login —— 登录换取 accessToken / refreshToken。
    //
    // 请求体：{"username": "admin", "password": "<RSA-OAEP(SHA-256) 加密后的 Base64 密文>"}
    //
    // 成功返回 data = LoginResponse（userId / username / expiresIn / tokenType /
    // accessToken / refreshToken）。
    '/api/auth/login': ActionRoute(
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

    // POST /api/auth/refreshToken —— 用 refreshToken 换新的 accessToken。
    //
    // 请求体：{"refreshToken": "..."}
    // 成功返回 data = {accessToken, refreshToken, tokenType, expiresIn}
    // —— refreshToken 会**轮换**，客户端要拿新的这个。
    '/api/auth/refreshToken': ActionRoute(
      methods: const {Method.post},
      requireAuth: false,
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        final refreshToken = trimmedString(body['refreshToken']);
        if (refreshToken == null) {
          throw const RestException.badRequest('refreshToken 不能为空');
        }
        return AuthService.refreshToken(session, refreshToken);
      },
    ),
  };
}
