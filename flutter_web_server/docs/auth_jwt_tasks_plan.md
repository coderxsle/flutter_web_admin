## 认证系统改造任务总览（JWT + serverpod_auth_idp_server）

本计划围绕以下目标展开：在保留现有业务逻辑前提下，将认证体系升级为基于 `serverpod_auth_idp_server` + JWT 的标准方案，并为 Flutter Web Admin 提供清晰的一致接入方式。

---

## 一、服务端配置层

- **1.1 引入并初始化 JwtTokenManager**
  - 在 `pubspec.yaml` 中使用 `serverpod_auth_idp_server` 依赖（已完成）。
  - 在 `passwords.yaml` 中新增：
    - `jwtRefreshTokenHashPepper`
    - `jwtHmacSha512PrivateKey`
  - 在 `server.dart` 中调用：
    - `await pod.initializeAuthServices(tokenManagerBuilders: [JwtConfig(...)]);`
  - 明确与现有自定义 `_authHandler` 的关系：
    - 逐步迁移到 Serverpod 官方 JWT 认证流程；
    - 或在过渡期同时兼容老的 `admin_xxx` token。

- **1.2 定义并暴露刷新 JWT 的 Endpoint**
  - 新建 `RefreshJwtTokensEndpoint`，继承自 `core.RefreshJwtTokensEndpoint`。
  - 在 `protocol.yaml` 中注册该 endpoint：
    - 确定命名空间（如 `auth` 或 `authJwt`）。
    - 运行 `serverpod generate` 生成对应代码。

---

## 二、服务端业务逻辑层

- **2.1 登录逻辑改造（AuthEndpoint.login 系列）**
  - 保留现有用户名密码校验逻辑（查询 `SysUser`、验证密码）。
  - 登录成功后，不再手动拼接字符串 token（`admin_...`），改为：
    - 使用 JWT Token Manager 生成：
      - `accessToken`
      - `refreshToken`
      - 以及过期时间等信息。
  - 统一返回标准认证响应结构：
    - `accessToken`
    - `refreshToken`
    - `tokenType`（固定为 `Bearer`）
    - `expiresIn`
    - 额外的用户基本信息（如 `username`、`roles` 等）。

- **2.2 刷新 token 逻辑**
  - 优先使用 `RefreshJwtTokensEndpoint` 提供的刷新能力。
  - 如有额外业务要求（区分管理员 / 客户等），可在单独的接口中：
    - 基于 `session.authenticated` 二次校验用户状态（禁用 / 删除等）。
    - 并在需要时包装/转发到 JWT 刷新逻辑。

- **2.3 统一保护需要登录的业务接口**
  - 为涉及敏感数据或用户操作的 endpoints 设置登录要求：
    - 覆盖 `requireLogin` 或使用 Serverpod 提供的权限控制方式。
  - 在 endpoint 中通过：
    - `session.authenticated` / `session.auth` 访问当前登录用户。
  - 至少梳理并处理以下模块：
    - `user` 相关接口（`getUserInfo` 等）。
    - 与业务数据强关联的操作接口（如表、菜单、书籍管理等）。

---

## 三、HTTP 协议与客户端对接层

- **3.1 HTTP 头约定**
  - 所有受保护接口统一要求：
    - `Authorization: Bearer <accessToken>`
  - 保留对 `"Bearer xxx"` 和纯 token 的兼容仅作为过渡策略，目标是最终全部收敛到 Bearer 方案。

- **3.2 Flutter Web Admin 调用规范**
  - 登录成功后前端保存：
    - `accessToken`
    - `refreshToken`
  - 通过 HTTP 客户端拦截器自动注入 Header：
    - `Authorization: Bearer <accessToken>`
  - 当收到 401（且判断为 token 过期）时：
    - 使用当前 `refreshToken` 调用刷新接口。
    - 刷新成功后更新本地 token 并重试原请求。
    - 刷新失败则清除本地 token，跳转到登录页。

- **3.3 文档与示例代码**
  - 在本项目中提供简明示例：
    - Flutter Web 侧 `Dio`/`http` 拦截器示例。
    - 登录 / 刷新 / 自动重试的伪代码流程。
  - 将关键约定（Header 规范、错误码、返回结构）写入文档，方便前后端协作。

---

## 四、实施顺序建议

1. 完成服务端 JwtTokenManager 初始化与刷新 endpoint 注册。
2. 改造 `AuthEndpoint` 登录接口，切换为 JWT 发行。
3. 为关键业务 endpoints 开启登录保护并验证 `session` 中的用户信息。
4. 更新 Flutter Web Admin 的 token 管理与请求拦截逻辑。
5. 补充与验证相关的集成测试 / 手工测试用例（登录成功 / 失败、访问受保护接口、token 过期与刷新等）。


