# REST 表现层（Serverpod 4 Web Server）

> 分支：`feature/web-server-rest-api`
> 代码：`flutter_web_server/lib/src/web/routes/api/`
> 挂载端口：**8082**（`config/development.yaml` 的 `webServer.port`）

## 1. 定位

Serverpod 4 把 HTTP 入口分成两层，本层是第二层：

| | typed Endpoint（8080） | REST Route（8082 `/api/**`） |
|---|---|---|
| 消费者 | Flutter / Vue（serverpod 生成的 client） | 浏览器、Webhook、第三方服务、脚本 |
| 入参 | 具名参数 + 带类型标签的线格式 | URL path / query / 普通 JSON body |
| 出参 | 协议序列化 | 纯 JSON（`CommonResponse` 信封） |
| 业务实现 | `services/system/*_service.dart` | **同一个 Service** |

关键点：**REST 只是换了一种表现层，不是再写一套 CRUD**。Route 层不出现任何
`SysUser.db.find(...)`，ORM 调用全部留在 Service 层。

## 2. 分层与文件

```
HTTP
 │
 ├─ cors_middleware.dart              CORS（横切，挂在 /api 前缀上）
 │
 └─ api_routes.dart                   注册表：一个资源 = 一行
      │
      ├─ registerCrud<T>('/api/user')     ← 写法 A（一行）
      └─ class UserRestRoute
           extends BaseRestRoute<SysUser> ← 写法 B（需要自定义时）
           │
           └─ BaseRestRoute<T>      一次挂载，自动注册整套子路由
                │                   + 每条子路径的 OPTIONS
                │                   + 统一 JSON 输出 / 状态码映射 / 异常兜底 / 鉴权前置
                │
                └─ RestCrudDelegate<T>    接缝：list / detail / create / update / remove
                     │                    （省略则用 AutoCrudDelegate<T> 自动装配）
                     │
                     └─ UserService    ← 与 UserEndpoint 共用的同一份业务实现
                          │
                          └─ Serverpod ORM → PostgreSQL
```

### 2.1 库的归属

`BaseRestRoute` / `RestCrudDelegate` / `AutoCrudDelegate` 定义在**独立的 pub 包**
`serverpod_crud`（`serverpod_crud/lib/src/web/rest_crud.dart`），不在
`flutter_web_server` 里。这是刻意的：REST 层与 CRUD 框架同源，别的 Serverpod 项目
直接依赖 `serverpod_crud` 就能拿到同一套能力。

### 2.2 两套基类并存（S1.5 收口）

早期手写形态留下的 `api_route.dart`（`ApiRoute` + `ApiMount`）和
`user_api_routes.dart`（5 个薄 Route）**仍在树里且仍挂在 `/api/user` 上**，
但已不是新代码的写法。两套并存是 `base_endpoint.dart` 那个老陷阱的翻版：
混用会在运行期崩，而 `dart analyze` 抓不到。S1.5 会把前者并入后者，见 §8 待办 6。

## 3. 对外契约

### 3.1 状态码

| 场景 | HTTP | 信封 code |
|---|---|---|
| 成功（查询/更新/删除） | 200 | 20000 |
| 创建成功 | **201** | 20000 |
| 未登录 / token 失效 | 401 | 40100 |
| 业务规则拒绝（用户名已存在、内置用户不可删…） | 400 | 50000 |
| 入参不合法（路径参数非正整数、body 不是 JSON 对象…） | 400 | 40400 |
| 资源不存在 | **404** | 40400 |
| 未预期异常 | 500 | 50000 |

### 3.2 响应体

统一 `{code, message, data}`，与 typed Endpoint 完全一致 —— 因为直接复用
`CommonResponse.toJson()`，它内部经过 `JsonCleaner`，已经去掉了
`__className__` 和 `password`，可直接交给第三方。

### 3.3 鉴权

`Authorization: Bearer <accessToken>`（与 typed API 同一套 JWT）。
`ApiRoute.requireAuth` 默认为 true，基类在进入 `dispatch` 之前先判
`session.authenticated`，失败直接 401 —— 这样 HTTP 语义才准确（见 §6.4）。

## 4. 接口清单

前缀 `/api/user` —— **单数**，与 typed Endpoint 的资源名一致
（`base.ts` 里就是 `/api/user/...`；决策依据见迁移方案 §6 决策 1）。

### 4.1 泛型层一次产出的 8 条路由

`BaseRestRoute<T>` 挂载一次即产出下列全部路由，**不需要逐条手写**：

| # | 方法 | 路径 | 说明 | 状态码 | 落到 |
|---|---|---|---|---|---|
| 1 | GET | `/api/user` | 分页列表 | 200 | `delegate.list` |
| 2 | GET | `/api/user/:id` | 详情 | 200 / 404 | `delegate.detail` |
| 3 | POST | `/api/user` | 新增 | **201** | `delegate.create` |
| 4 | PUT \| PATCH | `/api/user/:id` | 更新（PATCH 语义：只覆盖 body 里出现过的 key） | 200 | `delegate.update` |
| 5 | DELETE | `/api/user/:id` | 删除 | 200 | `delegate.remove` |
| 6 | DELETE | `/api/user` | **批量删除**（body `{"ids":[…]}`） | 200 | `delegate.removeBatch` |
| 7 | POST | `/api/user/update` | 更新（POST 兼容形式，body 带 `id`） | 200 | 同 4 |
| 8 | POST | `/api/user/delete` | 删除（POST 兼容形式，body 给 `id` 删单条、给 `ids` 删多条） | 200 | 同 5 / 6 |

第 6 条由 `enableBatchDelete` 控制、第 7–8 条由 `enablePostAliases` 控制，
**默认都开**（依据迁移方案 §6 决策 2：项目基本上只用 GET / POST）。

### 4.2 用户资源当前真正生效的是 5 条手写路由

⚠️ **上面那套泛型路由还没挂到 `/api/user` 上** —— `user_rest_route.dart` 目前只是
「单类型参数能编译通过」的证明，未注册。真实生效的是早期手写的 5 条：

| 方法 | 路径 | 说明 | 对应 Service |
|---|---|---|---|
| GET | `/api/user` | 分页列表 | `UserService.getUserList` |
| POST | `/api/user` | 新增（成功 201） | `UserService.add` |
| GET | `/api/user/:id` | 详情（含 `roleIds` / `roles`） | `UserService.getDetail` |
| PUT \| PATCH | `/api/user/:id` | 更新（部分字段） | `UserService.update` |
| DELETE | `/api/user/:id` | 软删除 | `UserService.delete` ← 本次新增 |

两套的差异恰恰是 S0 要补的能力：批量删（6）、POST 别名（7/8）、以及列表返回树。
切换时用「逐字段一致」回归（§7）兜底。

### 4.3 请求约定

列表的 query 参数与 `UserListRequest` 字段一一对应：
`tenantId` / `deptId`（自动展开子孙部门）/ `username` / `nickname` /
`phone` / `email` / `status` / `page` / `pageSize`（服务端收敛上限 100）。

`POST` 的 `password` 必须是**登录公钥 RSA-OAEP(SHA-256) 加密后的 Base64 密文**
（`UserService.add` 会先解密再 PBKDF2 哈希），第三方接入需先取 `POST /auth/publicKey`。
这是 Service 层隐含的约定被 REST 层原样继承 —— 见 §8「待办」2。

## 5. 已验证到哪一步

### 5.1 手写 5 条路由 —— 已用 curl 实测（2026-09-23）

> ⚠️ 这批实测做的时候挂载点还是 `/api/users`（复数）。现已按决策 1 统一为单数
> `/api/user`，实现与响应体未变，下表按**新路径**列出。

```
GET  /api/user                               无 token            → 401 {"code":40100}
GET  /api/user?deptId=1&pageSize=3           带 token            → 200 total=12 page=1 totalPage=4
                                                                   字段无 password / __className__
GET  /api/user/2                                                  → 200 含 roleIds/roles
GET  /api/user/99999                                              → 404
GET  /api/user/abc                                                → 400 路径参数必须是正整数
PUT  /api/user/2  {"description":"..."}                           → 200 其他字段未被清空
POST /api/user    {"username":"chenyu",...}                       → 400 用户名已存在
POST /api/user    新用户名 + RSA 密文密码                           → 201
DELETE /api/user/1        （admin，isSuperuser）                    → 400 系统内置用户不允许删除
DELETE /api/user/99999                                            → 404
DELETE /api/user/<新建的>                                          → 200 再 GET 该 id → 404
```

**最关键的对照**：同一份业务数据，两个入口逐字段一致。

```bash
# typed Endpoint
POST 8080/user/getUserList  {"query":{"deptId":1,"pageSize":3}}   → total=12, ids=[1,2,3]
# REST
GET  8082/api/user?deptId=1&pageSize=3                            → total=12, ids=[1,2,3]

字段集一致: true | typed 独有字段: [] | REST 独有字段: []
disabled 注入: 两边都有
```

### 5.2 泛型层 —— 只验证到单测，未做真实 HTTP

`serverpod_crud/test/rest_crud_route_test.dart`，**17 个断言全绿**，覆盖：

* 8 条路由的「方法 + 路径」签名与 §4.1 的表完全一致（含你点名的 5 条）
* `enablePostAliases: false` → 剩 6 条；`enableBatchDelete: false` → 剩 7 条；
  `updateMethods` 可裁剪
* `extractIds` 吃 `{"id":n}` / `{"ids":[…]}` / `"1"` 字符串数字，去重、丢非法、空则 400
* 信封 3 例、`RestPage.totalPage` / `toPayload`、`restJsonify`
* **整套子路由注入同一个 relic 路由器不冲突** —— 把「同一挂载点只能挂一次」
  这个原本只在启动时才爆的坑，提前到了单测阶段

⚠️ 但 `BaseRestRoute<SysUser>` 只验证到**编译通过**：`user_rest_route.dart` 没有注册进
`api_routes.dart`，所以还没有任何一条泛型路由经过真实 HTTP。这一步等 S1.5。

## 6. 踩过的坑（改这块代码前先读）

### 6.1 `addRoute` 同一个挂载点只能挂一次

`WebServer.addRoute(route, path)` 内部是 `_app.injectAt('*/$path', route)`，
relic 的 `PathTrie` 不允许在同一挂载点注入第二个 handler，第二次直接抛
`Invalid argument(s): Conflicting values`。

所以「UserListRoute + UserCreateRoute 都挂 `/api/user`」这种写法会崩。

解法是「**一次挂载 + N 条子路由**」：占住挂载点一次，然后在该挂载点**内部的
router** 上按「方法 + 子路径」把 N 条子路由注册进去（这正是 `Route.injectIn`
的默认写法）。早期用 `ApiMount` 手写这件事；泛型形态把它内置进
`BaseRestRoute.injectIn`，调用方不用再关心。

### 6.2 CORS 中间件是「路由级」的，不是全局的

relic 的中间件只在**请求先匹配到某条路由**之后才执行。浏览器预检发的是
OPTIONS，而子路由里没人注册 OPTIONS → 在路由匹配阶段就 405 了，中间件根本
没机会跑，CORS 头也就加不上（实测确认）。

所以挂载层会给每个子路径**补注册一条 OPTIONS**，交给 `CorsMiddleware` 统一加头。
早期是 `ApiMount.injectIn` 做，泛型形态由 `BaseRestRoute.injectIn` 做：

```dart
final paths = <String>{};
for (final route in _subRoutes) {
  router.anyOf(route.methods, route.path, route.asHandler);
  paths.add(route.path);
}
for (final path in paths) {
  router.anyOf({Method.options}, path, _preflight);   // ← 补 OPTIONS
}
```

### 6.3 relic 2.0 的 `Headers` 不是普通 Map

```dart
// ❌ 编译不过：值必须是 Iterable<String>，不是 String
Response.ok(headers: {'Access-Control-Allow-Origin': '*'});

// ✅ 两种可行写法
Response.ok(headers: Headers.build((mh) => mh['x-origin'] = ['*']));
response.copyWith(headers: response.headers.transform((mh) => mh['x'] = ['y']));
```

另外 `Response.copyWith(headers:)` 是**整体替换**而不是合并，要保留原响应头
就得自己按顺序拼一份（`Headers.transform` 天然基于原 headers，是安全的）。

### 6.4 Service 的失败只有一个粒度，HTTP 语义要在表现层补

`UserService` 里所有失败都返回 `CommonResponse.failed(...)`（code 50000），
「未登录」「用户名已存在」「记录不存在」在 HTTP 上应该是 401 / 400 / 404 —— 
但 Service 分不出来。处理方式：

* **未登录**：在基类前置判断，不落到 Service
  （`ApiRoute.requireAuth` / `BaseRestRoute(requireAuth: true)`）；
* **记录不存在**：在 Route 里先确认基线（`getDetail`），失败即 404；
* 其余失败统一 400。

之所以不去改 Service 的返回码：Vue 前端已经在按 `code === 50000` 判断业务失败，
动它等于改公共契约。**这条缺口记在 §8 待办 1，Service 层返回语义化 code 才是根治方案。**

### 6.5 `config/development.yaml` 的 `cors:` 只管 API server

```text
OPTIONS 8080/user/getUserList  → 200 + access-control-allow-origin: *
OPTIONS 8082/api/user/2       → 405，一个 access-control-* 都没有
```

Serverpod 把 CORS 做在 typed API 的处理链上，Web Server 这条链路完全不看
那段配置。必须自己加中间件（`cors_middleware.dart`）。

## 7. CORS 策略

不用 `Access-Control-Allow-Origin: *`：

* 通配符 = 对所有站点开放，任何恶意页面都能读走接口数据；
* 带 Cookie（`withCredentials: true`）时浏览器**明确禁止**通配符 —— 必须回显具体来源。

所以按白名单逐请求判定，命中就回显该来源并带上 `Vary: Origin`
（否则共享缓存可能把 A 站的响应喂给 B 站）。

```dart
// 默认白名单：本地开发端口（5173 / 8082）
Set<String> resolveAllowedOrigins();          // 可用 REST_CORS_ORIGINS 环境变量覆盖
CorsMiddleware({
  Set<String>? allowedOrigins,
  bool allowCredentials = false,              // 开启后会回 allow-credentials: true
  bool rejectUnknownOrigin = false,           // 默认只「不加 CORS 头」，不返回 403
});
```

`rejectUnknownOrigin` 默认关的原因：CORS 是浏览器自己的安全机制，不是服务端的
访问控制。用 `Origin` 做鉴权既拦不住 curl / 服务端调用（没有 Origin，或者可以
伪造），又会误伤带了无关 Origin 头的内部调用。「不加头」已经足够让浏览器拦掉。

`allowCredentials` 与通配符互斥，同时开会直接在构造时抛 `ArgumentError`。

实测（白名单 = 默认开发端口）：

```
① OPTIONS  Origin: http://localhost:5173  → 200 + allow-origin 回显 + vary: Origin
② OPTIONS  Origin: http://evil.example.com → 200，无任何 access-control-* 头
③ GET      Origin: http://localhost:5173  → 200 + allow-origin 回显 + vary: Origin
④ GET      Origin: http://evil.example.com → 200（业务体照常返回，只是浏览器侧会拦）
⑤ GET      无 Origin（curl）                → 200，无 CORS 头
```

## 8. 待办 / 已知缺口

1. **Service 返回语义化 code**：把「未登录 → 40100、不存在 → 40400」下沉到
   Service，Route 就不需要靠「先查基线」来猜 404（§6.4）。
2. **`POST` 的密码必须是密文**：第三方接入体验差。可在 Service 加
   `addWithPlainPassword`（内部直接 PBKDF2 哈希），REST 层按来源选择。
3. **`UserService.delete` 只做了软删**：没走 `AutoCrudService` 的审计链路，
   也没有级联清理 `sys_user_role`。若要与 Endpoint 的删除行为完全对齐，应改用
   框架的 `AutoCrudService.delete`。
4. **泛型路由还没真正挂上去**：`BaseRestRoute<SysUser>` 只验证到编译通过
   （§5.2）。挂载进 `api_routes.dart` 后要跑 §7 的「逐字段一致」回归。
5. **A 档 6 个资源的 per-resource 逻辑仍是手工活**：`registerCrud` 解决的是
   「**路由**不手写」，不是「**业务**不手写」。dept / menu 返回树、role 没有 add、
   menu 表缺 `tenantId` 列、dict 的 add 与 update 入参不一致 —— 详见迁移方案
   §6.1(b) 的逐资源清单。
6. **两套 REST 基类并存**：`api_route.dart`（`ApiRoute` + `ApiMount`）与
   `serverpod_crud` 的 `rest_crud.dart`（`BaseRestRoute` + `RestCrudDelegate`）。
   **混用会运行期崩，`dart analyze` 抓不到** —— 这是 `base_endpoint.dart` 那个
   老陷阱的翻版。收口做法：`flutter_web_server` 只保留一个
   `ServerpodEnvelopeBuilder`（把 `{code, message, data}` + `JsonCleaner` 装进
   `RestEnvelopeBuilder`），Route 全部继承 `serverpod_crud` 的基类。
   → 迁移方案 **S1.5**
7. **未加 Rate limiting / API Key 中间件**：官方把这两项也列为 Middleware 的
   典型用途，需要时在同一层加。

## 9. 本地验证

```bash
# 1) 起服务（项目用 fvm 3.44.4 = Dart 3.12.2）
cd flutter_web_server
PATH="$HOME/fvm/versions/3.44.4/bin:$PATH" dart run bin/main.dart

# 2) 拿 token：POST /auth/publicKey → RSA-OAEP(SHA-256) 加密密码 → POST /auth/login
#    种子用户密码统一 asdf1234

# 3) 调 REST
curl --noproxy '*' -H "Authorization: Bearer $TOKEN" \
  "http://127.0.0.1:8082/api/user?deptId=1&pageSize=3"
```

⚠️ 新增 / 重命名 Route 后**必须重启进程** —— `run()` 只在启动时执行一次，
`pod.webServer.addRoute(...)` 不会随热重载重跑（这点和「改 Service 方法体自动生效」
不一样）。`registerCrud<T>(...)` / `BaseRestRoute<T>` 同理，因为它们最终都落到
`addRoute`。**同理，改挂载点字符串（如 `/api/users` → `/api/user`）也必须重启才生效。**

## 10. 泛型层的实现细节与依据（2026-09-23 落地）

§1–§5 讲的是**现在长什么样、怎么用**；本节是它的**依据** —— 为什么最终只需要一个
类型参数、为什么默认 delegate 要 lazy 装配、哪些地方的通用化一定盖不住。
改 `rest_crud.dart` 之前先读这节。

代码在 `serverpod_crud/lib/src/web/rest_crud.dart`（新增，已 export），
测试在 `serverpod_crud/test/rest_crud_route_test.dart`（**17 个断言全绿**，见 §5.2）。

### 10.1 结论先说

**技术上完全可行**，而且 Serverpod 这边有个天然优势：`pod.webServer.addRoute()` 是
**运行时** API，不像 typed Endpoint 必须在 `serverpod generate` 时静态枚举路由 ——
所以「批量/循环注册资源」在这层是原生的，不需要改代码生成器。

**但真正的拦路虎不在 Serverpod，在 Service 层没有统一契约。**
`BaseRestRoute<T>` 绑定的是 `RestCrudDelegate<T>`，而项目现有 9 个 Service
**一个都不能直接当 delegate 用**（形态对照见 10.3）。

### 10.2 组成

| 类型 | 职责 |
|---|---|
| `RestCrudDelegate<T>` | 一个资源被 REST 化所需的动作（list / detail / create / update / remove / removeBatch）。**协议无关**，这是接缝。⚠️ 实现时用 `extends`：`removeBatch` 有默认实现 |
| `AutoRestCrudDelegate<T, TTable>` | 直接包 `BaseService<T, TTable>` 的标准实现（显式表类型） |
| `AutoCrudDelegate<T>` | **单类型参数**版本，表类型由 `getTableForType(T)` 运行期反查 |
| `BaseRestRoute<T extends TableRow>` | 一次挂载，自动注册整套子路由 + 每个子路径的 OPTIONS。delegate 可省 → **空类体即可用** |
| `RestEnvelopeBuilder` | 信封接缝。CRUD Core 不认识业务项目的 `{code, message, data}`，由业务项目实现；默认 `PlainEnvelopeBuilder` |
| `RestPage<T>` / `restJsonify` | 分页结果与 JSON 归一化（模型 / Map / List / DateTime 混合） |
| `ServerpodRestCrud` | `pod.registerCrud<T>(path)` |

自动产生的路由表（**已用测试断言，不是推测**）：

```
GET     /               列表
GET     /:id            详情
POST    /               新增（201）
PUT|PATCH /:id          更新
DELETE  /:id            删除
DELETE  /               批量删除（body {"ids":[…]})
POST    /update         更新（POST 兼容形式，body 带 id）
POST    /delete         删除（POST 兼容形式，body 带 id 或 ids）
```

后三条由 `enableBatchDelete` / `enablePostAliases` 开关控制（默认开）。
加 POST 兼容形式是因为**本项目「基本上只使用 GET、POST 接口」** ——
标准动词都在，但只用 GET/POST 的客户端也能完成全部操作。

### 10.2.1 目标形态（一句抽象）

```dart
class UserRestRoute extends BaseRestRoute<SysUser> {}   // 空类体
// 或
pod.registerCrud<SysUser>('/api/user');                 // 一行
```

已在真实模型上验证编译通过（`flutter_web_server/lib/src/web/routes/api/user_rest_route.dart`，
目前只做编译证明、未注册）。

### 10.3 为什么现有资源塞不进去（形态对照表）

| Service | 实例/静态 | 列表 | 新增入参 | 更新入参 | 删除 | 分页 |
|---|---|---|---|---|---|---|
| `UserService` | 实例 | `getUserList(UserListRequest)` | `UserRequest` | `UserRequest` | `delete(int)` **单条** | ✅ 服务端真分页 |
| `DeptService` | **静态** | `getList({status,name})` → **返回树** | `DeptRequest` | `DeptRequest` | `delete(List<int>)` 批量 | ❌ 全表 |
| `RoleService` | **静态** | `getList()` 无参 | ❌ **没有 add** | `SysRole` | `delete(List<int>)` 批量 | ❌ |
| `MenuService` | **静态** | `getList([name,status])` 位置参数 | `MenuRequest` | `MenuRequest` | `delete(List<int>)` 批量 | ❌ |
| `DictService` | **静态** | `getDictCodeList` / `getDictDataList` **一个类两个资源** | `DictCodeRequest` | `SysDictData`（与 add 类型不一致） | `deleteDictCode/Data(List<int>)` | ❌ |

四类不一致：① 实例 vs 静态；② 单条 vs 批量删除；③ 列表返回树 / 分页 / 全表三种；
④ 每家一个专用 Request 模型。所以 `RestCrudDelegate` 的 `create/update` 刻意收
`Map<String, dynamic> body` 而不是模型 —— 让 delegate 自己决定怎么变成模型，
这一层必须留出自由度。

### 10.4 Dart 的两个泛型约束，以及怎么绕开

1. **`T` 不能直接 `T.db.find()`** —— Dart 不允许通过类型参数访问静态成员。
   → 本层不碰 ORM，把 DB 操作全部交给 delegate。
2. **`TTable` 无法从 `T` 静态推导** —— 一开始的解法是让 `AutoRestCrudDelegate`
   显式带两个类型参数。**现已不需要**：`TTable` 可以直接填**裸 `Table`**。

第 2 点的依据（都是读源码 + 编译验证确认的）：

| 事实 | 位置 |
|---|---|
| `Table` 是 `Table<T_ID>` 泛型类，`id` 类型是 `ColumnComparable<T_ID>` 而非 `ColumnInt` | `serverpod_database/src/concepts/table.dart:50,68` |
| 生成的表类（如 `SysUserTable extends Table<int?>`）因**协变**而 `is Table` 成立 | Dart 语言规则 |
| 取列是**反射式**的：`_crudFindColumn` 遍历 `table.columns` 按 `fieldName`/`columnName` 匹配 | `base_service.dart:14-25` |
| 取表也是运行期：`serializationManager.getTableForType(T)` | `base_service.dart:197` |
| `TableRow<T_ID>` 只有 3 个成员（`id` / `table` / 继承来的 `toJson`） | `table.dart:9-18` |

→ 所以 `BaseRestRoute<T>` 只需要**一个类型参数**，`TTable` 在运行期反查。

顺带确认的一个事实：`deserialize<T>(body, T)` **接受浏览器发来的普通 JSON** ——
它命中生成的 `T.fromJson` 分支；只有 `deserializeDynamicFieldValue` 才要求
「每个字段值再包一层 `{className, data}`」的线格式（见第 6 节）。所以自动 delegate
不需要客户端做任何额外包装。

### 10.4.1 自动装配为什么是 lazy 的

`BaseRestRoute` 的默认 delegate 用 `late final` 延迟到**首次请求**才装配。
原因：路由注册发生在 `pod.start()` **之前**，那时 `Serverpod.instance` 虽已就绪，
但数据库尚未连接，而 `CrudEntityMeta.auto()` 会立刻去读 `SerializationManager`
和表列信息。推到首次请求最稳。

### 10.5 更新语义：PATCH，不是整行覆盖

`AutoRestCrudDelegate.update` 先读当前行做基线，再让 body 覆盖：

```dart
final merged = <String, dynamic>{...current.toJson(), ...body, 'id': id};
```

基线必须用 `toJson()` 而**不是** `toJsonForProtocol()` —— 前者含 `serverOnly`
字段（如 `SysUser.password`），后者不含。用错就会把密码写成 NULL。

### 10.6 仍然只能覆盖「标准资源」

`BaseRestRoute<T>` 是**模板方法**，不是「什么都不用写」。以本项目的用户资源为例，
它有 5 处 per-resource 逻辑，任何通用化都盖不住：

1. 列表要注入 `disabled`（「系统内置不可编辑」标记）
2. `deptId` 要展开部门子树
3. `UserListRequest` 有 9 个专用过滤字段，通用 `page/pageSize/keyword` 不够
4. `password` 必须是前端公钥 RSA 加密后的密文
5. `roleIds` 存在 `sys_user_role` 关联表，update 走 `UserRequest` 而非 `SysUser`

所以正确用法是：默认全自动，需要时覆写单个 hook。

### 10.7 未决事项

> 📌 这些已**全部纳入迁移路线**，见 **`docs/rest-api-migration-plan.md`**
> （阶段编号是 **S0–S5**，不是早期的 P0–P4）。

- [ ] **两套基类合一** —— 同上 §8 待办 6。→ 迁移方案 **S1.5**
- [ ] **把泛型路由真正挂上 `/api/user`**，与现有 5 条手写 Route A/B 对比
      （应逐字节一致）。自定义 delegate 时用
      `extends RestCrudDelegate<SysUser>`，**不要 `implements`** ——
      否则要被迫实现有默认实现的 `removeBatch`（`non_abstract_class_inherits_abstract_member`）。
      → 迁移方案 **S2**
- [ ] 存量资源逐个决定「改造成标准形态」还是「保留自定义 delegate」。→ **S2 / S3**

