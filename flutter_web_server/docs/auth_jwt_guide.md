## Serverpod 认证与 JWT 使用说明

这篇文档用通俗一点的语言，解释：

- **`serverpod_auth_server` 是什么**
- **`serverpod_auth_idp_server` 是什么**
- **它们的区别**
- **在实际项目里应该怎么用 JWT 做认证**

---

## 一、几个核心概念先搞清楚

- **Session（会话）**
  - 服务器记住「你是谁」的一种方式。
  - 往往配合 cookie / sessionId 实现。
  - 缺点是：**通常只适合单个服务，跨服务、跨系统就麻烦**。

- **JWT（JSON Web Token）**
  - 一串 **签过名的字符串**，里面写着：用户是谁、什么时候过期、有什么权限等信息。
  - 服务器拿到 JWT 后，只要用密钥验证签名，就能确认是否有效，**不一定需要查数据库**。
  - 非常适合 **前后端分离、多端、多服务调用** 的场景。

- **Bearer Token（`Authorization: Bearer xxx`）**
  - 一种传 token 的标准写法。
  - 浏览器 / 客户端请求时，在 Header 里加：
    - `Authorization: Bearer <access_token>`
  - 服务端在 Header 中提取出 `<access_token>`，再用密钥验证即可。

---

## 二、`serverpod_auth_server` 是什么？

可以把 `serverpod_auth_server` 理解成：

> Serverpod 自带的一套「应用内部登录模块」  
> 主要面向 **使用 Serverpod 官方 Dart Client 的 App**。

特点：

- 提供常见登录方式（邮箱登录、第三方登录等）。
- 侧重使用 **Serverpod 自己的 session / token 管理**：
  - Server 通过自己的机制，把「这个连接是谁」记在会话里。
  - 通常配合 Serverpod 生成的 Dart 客户端使用，客户端和服务器之间的认证细节对开发者是半透明的。
- 典型使用场景：
  - 你写一个 Flutter App；
  - 用 Serverpod 官方生成的 Dart Client 调用后端；
  - 不太关心 HTTP 头里具体怎么传 token。

局限：

- 更偏向「**单 App 使用**」的思路。
- 如果你有多个前端（Flutter Web、第三方服务、脚本等）都要访问同一个后端，或者要走标准的 JWT + Bearer 协议，就会有点不够通用。

---

## 三、`serverpod_auth_idp_server` 是什么？

`idp` 是 **Identity Provider（身份提供方）** 的缩写。

`serverpod_auth_idp_server` 的定位更像是：

> 一个可以给多个系统 / 服务共用的 **统一认证中心**  
> 专门负责「登录、发 token、刷新 token、验证 token」。

它的核心能力是：

- 集成 **Token Manager** 系统，支持：
  - `JwtTokenManager`（JWT Token 管理）
  - 以及其它 token 管理实现。
- 你可以用官方推荐的配置：

```dart
await pod.initializeAuthServices(
  tokenManagerBuilders: [
    JwtConfig(
      refreshTokenHashPepper: pod.getPassword('jwtRefreshTokenHashPepper')!,
      algorithm: JwtAlgorithm.hmacSha512(
        SecretKey(pod.getPassword('jwtHmacSha512PrivateKey')!),
      ),
    ),
  ],
);
```

- 这段配置的含义：
  - 告诉 Serverpod：「我想用 **JWT** 来管理访问令牌 / 刷新令牌」。
  - `jwtRefreshTokenHashPepper`：加在刷新 token 哈希上的「佐料」，增强安全性。
  - `jwtHmacSha512PrivateKey`：JWT 签名使用的私钥（HMAC-SHA512）。

进一步，你还可以：

- 继承 `RefreshJwtTokensEndpoint`，快速提供一个「刷新 JWT 的接口」：

```dart
import 'package:serverpod_auth_idp_server/core.dart' as core;

class RefreshJwtTokensEndpoint extends core.RefreshJwtTokensEndpoint {}
```

- 这样客户端就可以通过：
  - **登录** → 拿到 `accessToken` + `refreshToken`
  - **调用刷新接口** → 用 `refreshToken` 换一对新的 token

---

## 四、两者的差异：怎么选？

可以用一个类比来理解：

- **`serverpod_auth_server`**：
  - 就像「**某家小饭馆自己做的会员卡系统**」。
  - 你只在这家店吃饭，用它自己的会员逻辑就够了。
  - 典型特征：主要配合 **Serverpod 自己的 Dart Client** 使用。

- **`serverpod_auth_idp_server`**：
  - 更像「**小区统一的门禁 / 认可的物业认证中心**」。
  - 整个小区里的不同楼栋、不同公司，都认它发的卡。
  - 典型特征：发的是 **标准 JWT**，所有服务 / 前端只要会发 HTTP 请求，就能统一用 `Authorization: Bearer <token>` 来访问。

因此，在项目中可以这样选择：

- **只做一个小 Demo，前端全部用 Serverpod Dart Client：**
  - `serverpod_auth_server` 就够。
- **前后端分离、多前端、多服务，想用 JWT 标准方案（比如你现在的 Flutter Web Admin）：**
  - 优先使用 **`serverpod_auth_idp_server` + `JwtTokenManager`**。

目前官方推荐的现代实践也是：  
**优先走 `serverpod_auth_idp_server` + JWT 的这条路**。

---

## 五、JWT 在 HTTP 请求里的传递方式

Serverpod 遵循标准的 HTTP `Authorization` 头规范。

- 标准格式：

```http
Authorization: <scheme> <credentials>
```

- 使用 JWT（Bearer Token）时，推荐写法：

```http
Authorization: Bearer <access_token>
```

在这个项目中：

- **客户端（例如 Flutter Web Admin）**
  - 登录成功后拿到 `accessToken`。
  - 之后每个请求在 Header 里自动带上：
    - `Authorization: Bearer <access_token>`
  - 如果遇到 401 且判断是 token 过期，再用 `refreshToken` 去调刷新接口获取新 token。

- **服务端（Serverpod）**
  - 在 HTTP 层解析出 `Authorization` 头。
  - 如果是 `Bearer` 方案，就从中取出 `<access_token>`。
  - 使用同一个 HMAC 密钥验证签名、检查过期时间等。
  - 验证通过后，把当前用户信息放进 `Session`，业务 endpoint 里就可以通过 `session.authenticated` 等方式拿到。

例如，在你当前的 `auth_endpoint.dart` 中看到的：

```dart
final authData = session.authenticated;
```

可以理解为：

- 前面 Serverpod 已经根据 `Authorization` 头里的 Token，把当前登录用户的信息验证好；
- 在 endpoint 里直接用 `session.authenticated` 拿到「这是哪个用户」，就可以继续做业务逻辑了。

---

## 六、整条 JWT 认证流程（结合本项目）

从「没登录」到「拿着 JWT 调接口」再到「刷新 token」，整体流程可以理解为：

1. **用户登录**
   - 前端（Flutter Web Admin）把用户名 / 密码发给登录接口（由 `serverpod_auth_idp_server` 或你自己包装的 endpoint 处理）。
   - 服务端验证成功后，使用 `JwtTokenManager` 生成：
     - `accessToken`（短期，有效期例如 15 分钟）
     - `refreshToken`（长期，有效期例如 7 天）
   - 把这两个 token 返回给前端。

2. **前端保存 token**
   - 一般做法：
     - `accessToken`：只放在内存（避免被 XSS 轻易窃取）。
     - `refreshToken`：可以存在更持久的位置（根据安全策略选择，例如 httpOnly cookie / localStorage 等）。

3. **前端请求受保护接口**
   - 每次发请求前，自动在 Header 加上：
     - `Authorization: Bearer <accessToken>`
   - 服务端解析 Bearer 头，验证 JWT：
     - 签名是否正确；
     - 是否过期；
     - 权限是否足够。
   - 通过后，Serverpod 在 `Session` 中记录当前用户信息，在 endpoint 里直接通过 `session` 获取。

4. **Access Token 过期**
   - 服务端会返回 401 或指定错误信息。
   - 前端判断为「access token 已过期」：
     - 用当前的 `refreshToken` 调 `RefreshJwtTokensEndpoint`（就是你继承的那个 endpoint）。
     - 如果刷新成功，获得一对新的 `accessToken` + `refreshToken`，更新本地保存。
     - 重试刚刚失败的请求（带上新的 `Authorization: Bearer ...`）。

5. **Refresh Token 也过期或无效**
   - 刷新接口返回失败。
   - 前端清除本地 token，跳回登录页，让用户重新登录。

---

## 七、本项目中推荐的实践总结

- **服务端**
  - 使用 `serverpod_auth_idp_server` 提供身份认证能力。
  - 在 `server.dart` 中调用 `initializeAuthServices`，配置 `JwtConfig`，开启 JWT Token 管理。
  - 定义 `RefreshJwtTokensEndpoint`，对外暴露刷新 token 的能力。
  - 在业务 endpoint（例如用户管理相关）上开启登录保护（如 `requireLogin = true`），内部通过 `session` 获取当前用户。

- **前端（Flutter Web Admin）**
  - 登录成功后，保存 `accessToken` / `refreshToken`。
  - 使用 HTTP 客户端（如 `dio`）的拦截器，在每个请求里自动加入 `Authorization: Bearer <accessToken>`。
  - 捕获 401 时，自动尝试调用刷新接口，用 `refreshToken` 换新 token，然后重试请求。

这样一来：

- 你有了一套 **标准、可扩展、可多端共享** 的认证方案；
- 不管是 Web Admin、未来的移动 App、还是其他后端服务，只要会发 HTTP 请求并带上 Bearer Token，就可以统一接入这一套认证中心。

---

## 八、Flutter Web Admin 侧调用示例（Dio 拦截器）

下面是一个简化版的 Flutter Web Admin 侧调用约定，用 `dio` 作为 HTTP 客户端：

- **登录接口**
  - URL：`/auth/login`
  - 方法：`POST`（或 Serverpod client 调用 `client.auth.login(...)`）
  - 返回字段：
    - `accessToken` / `refreshToken`
    - `tokenType`：固定为 `Bearer`
    - `expiresIn`：秒

- **刷新接口**
  - URL：`/auth/refreshToken`
  - 方法：`POST`
  - 参数：`refreshToken`（字符串）
  - 返回字段结构同登录接口（新的 accessToken / refreshToken）。

在前端可以用一个简单的 TokenStore 管理当前 token，然后用拦截器自动注入和刷新：

```dart
class TokenStore {
  String? accessToken;
  String? refreshToken;

  bool get isLoggedIn => accessToken != null && refreshToken != null;
}

final tokenStore = TokenStore();
final dio = Dio(BaseOptions(baseUrl: 'https://your-serverpod-host'));

void setupDio() {
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = tokenStore.accessToken;
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (e, handler) async {
        // 如果是 401，尝试用 refreshToken 刷新
        if (e.response?.statusCode == 401 && tokenStore.refreshToken != null) {
          try {
            final refreshResp = await dio.post(
              '/auth/refreshToken',
              data: {'refreshToken': tokenStore.refreshToken},
            );
            final data = refreshResp.data['data'] ?? refreshResp.data;
            tokenStore.accessToken = data['accessToken'] as String?;
            tokenStore.refreshToken = data['refreshToken'] as String?;

            // 使用新的 token 重试原始请求
            final requestOptions = e.requestOptions;
            requestOptions.headers['Authorization'] = 'Bearer ${tokenStore.accessToken}';
            final cloneResp = await dio.fetch(requestOptions);
            return handler.resolve(cloneResp);
          } catch (_) {
            // 刷新失败，清空本地 token，交给上层跳转登录
            tokenStore.accessToken = null;
            tokenStore.refreshToken = null;
          }
        }
        return handler.next(e);
      },
    ),
  );
}
```

登录成功后，只需要：

```dart
final resp = await dio.post('/auth/login', data: {'username': user, 'password': pass});
final data = resp.data['data'] ?? resp.data;
tokenStore.accessToken = data['accessToken'];
tokenStore.refreshToken = data['refreshToken'];
```

之后所有经由 `dio` 发出的请求都会自动带上 `Authorization: Bearer <accessToken>`，当 accessToken 过期返回 401 时，拦截器会自动调用 `/auth/refreshToken` 刷新并重试一次原请求。
