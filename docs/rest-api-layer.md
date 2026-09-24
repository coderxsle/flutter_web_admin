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
`SysUser.db.find(...)`，ORM 调用全部留在 Service 层（S0.5 之后更进一步，
连 Service 也不再直接调 `.db.*`，而是走 `SystemCrudEngines`，见 §2.3）。

> 更新：2026-09-24 —— 补 §2.3（Service 收敛层）、§4.4（认证资源 `/api/auth`）、§5.3（typed 侧回归）；§8 待办 3 / 5 状态刷新。

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
                          └─ SystemCrudEngines.user   ← 收敛后的统一引擎（决策 4）
                               │                        BaseService<SysUser, SysUserTable>
                               │                        租户隔离 / 软删 / 审计 / 校验 / 分页
                               └─ Serverpod ORM → PostgreSQL
```

⚠️ 末两层是 **S0.5（决策 4）新增**的：Service 内部不再直接调 `SysUser.db.*`，
而是走 `services/system/crud_engines.dart` 暴露的 `BaseService<T,TTable>`。
REST 侧的 delegate 之后可以**复用同一个引擎**，不必再各写一份。

### 2.1 库的归属

`BaseRestRoute` / `RestCrudDelegate` / `AutoCrudDelegate` 定义在**独立的 pub 包**
`serverpod_crud`（`serverpod_crud/lib/src/web/rest_crud.dart`），不在
`flutter_web_server` 里。这是刻意的：REST 层与 CRUD 框架同源，别的 Serverpod 项目
直接依赖 `serverpod_crud` 就能拿到同一套能力。

### 2.2 只有一套基类（S1.5 已收口，2026-09-24）

全部 Route 都来自 `serverpod_crud`，**两条腿**：

- **资源型** → `BaseRestRoute<T>`，业务体写在 `RestCrudDelegate<T>` 里（§4.2 的 6 个资源）；
- **动作型** → `RestActionRoute`，业务体写在 `handler` 里（`/api/auth/*`）。

两者共用同一份鉴权 / 信封 / HTTP 状态码 / 异常兜底实现，信封只由
`ServerpodEnvelopeBuilder` 产出。**不要再引入第三种写法** ——
早期手写形态留下的 `api_route.dart`（`ApiRoute` + `ApiMount`）、
`user_api_routes.dart`、`user_rest_route.dart` 已**全部删除**（−501 行）。

> 历史上的「两套基类并存」是 `base_endpoint.dart` 那个老陷阱的翻版：
> 混用会在运行期崩，而 `dart analyze` 抓不到。现在两套已合一。

⚠️ `serverpod_crud` 现在**同时导出 `asIntOrNull` 与 `RestRequestExtension`**，
而早期手写文件里也有同名符号 —— 那个歧义随 `api_route.dart` 的删除一并消失。
新增文件只 import `serverpod_crud`，不要再定义同名 extension。

### 2.3 Service 收敛层（S0.5，2026-09-24 完成）

`services/system/crud_engines.dart` 是 **6 个 A 档业务 Service 与 `serverpod_crud`
之间唯一的接缝**。它提供：

- `SystemCrudEngines.{user,dept,role,menu,dictCode,dictData}`
  —— 6 个 **lazy** 引擎入口。⚠️ 必须 lazy（`??=` getter）：引擎的构造函数会执行
  `EntityDescriptor.fromServerpod()`，它会读 `Serverpod.instance.serializationManager`，
  写成 `static final` 会类加载即崩。
- `findAllByEngine(...)` —— 「全表 + 租户 + 软删」查询。**为什么不复用
  `BaseService.getList`**：那是分页语义，而 role/dept/menu/dict 的列表历来返回全表，
  硬套会**悄悄截断**。
- `buildCrudQuery(...)` —— 分页收敛。⚠️ 默认 10 / 上限 100 是**与被替换的旧代码逐字对齐**的，
  因为 `QueryEngine` 自身是 20 / 200，不先收敛就会被放大。
- `condEq` / `condLike` / `condIn` / `condBetween` / `sortAsc` / `sortDesc`、
  `crudPageResponse`、`crudFailure`。

⚠️ **`condLike` 只传裸值**：`QueryEngine._buildCondition` 内部会拼 `LIKE '%value%'`。

⚠️ **`QueryEngine` 在 `sort` 为空时不做任何排序** —— 需要默认排序必须显式传
`sortAsc('id')`（旧实现都有 `orderByList`）。

⚠️ **`delete` 必须两步走**：`BaseService.delete` 只收 `id`、拿不到实体，
不维护 `updater`/`updateTime`；且 `CrudService.update` 里有 `setDeleted(data, false)`。
所以「软删 + 记审计字段」必须先 `update()` 落字段、再 `delete()`，**顺序不可颠倒**。

✅ **审计已接上**：6 个引擎各注入了 `DbAuditService(type: '<资源名>')`，
`create` / `update` / `delete` / `deleteBatch` 都会往 `sys_operate_log` 落行。
`type` 取名沿历史先例（`937d3e4` 的 `user_endpoint.dart` 曾用 `type:'user'`）：
`user` / `dept` / `role` / `menu` / `dict_code` / `dict_data`。
⚠️ 写审计失败不影响业务 —— `OperateLogWriter.write` 内部整段 `try/catch`。

⚠️ 但 **`CrudRuntime` 仍未注入**：`crud/crud_runtime_factory.dart` 目前**没有任何引用**，
引擎用的是默认空 `CrudRuntime()`，所以查询审计（`QueryAuditLogPlugin`）、
分页校验插件、`contains` 操作符都没生效。

详细的行为变更清单与回归结果见 `docs/rest-api-migration-plan.md` §6.2 与 §7.1。

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

前缀 `/api/<资源名>` —— **单数**（`dict-*` 用连字符），与 typed Endpoint 的资源名一致
（决策依据见迁移方案 §6 决策 1）。当前挂了 **6 个 A 档资源 + 1 个认证资源**：

`/api/user`、`/api/dept`、`/api/role`、`/api/menu`、`/api/dict-code`、
`/api/dict-data`、`/api/auth/*`。

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

第 6 条由 `enableBatchDelete`、第 7–8 条由 `enablePostAliases`、第 3 条由
`enableCreate` 控制，**三个默认都开**（依据迁移方案 §6 决策 2：项目基本上只用
GET / POST）。`enableCreate` 只在「资源不支持新增」时才关 —— 现状只有 `/api/role`。

⚠️ 关掉 `enableCreate` 后，`POST /<资源>` 的响应是 **405**（不是 404）：
该路径上还挂着 `GET /` 与 `DELETE /`，relic 能匹配到路径、只是方法不允许
（`MethodMiss` → 405 + `allow` 头）。

### 4.2 A 档 6 个资源（S2，2026-09-24 落地）

每个资源一次 `registerResource<T>`，业务差异**全部**收敛在一个 delegate 里：

| 资源 | delegate | `GET /` 的形态 | 特殊点 |
|---|---|---|---|
| `/api/user` | `UserRestDelegate` | 分页列表（9 个专用 query） | RSA 密码、`roleIds` 关联表 |
| `/api/dept` | `DeptRestDelegate` | **部门树**（非分页） | 服务层建树、批量删 |
| `/api/menu` | `MenuRestDelegate` | **菜单树**（非分页） | 更新是「全量覆盖 + 默认值」 |
| `/api/dict-code` | `DictCodeRestDelegate` | 全量列表（非分页） | `code` 不可改（§4.2.1） |
| `/api/dict-data` | `DictDataRestDelegate` | 全量列表（非分页） | 详情只按 id（§4.2.1） |
| `/api/role` | `RoleRestDelegate` | 平铺 + `disabled` | **没有 `POST /`** → 405 |

三个「非分页列表」是刻意的：typed 侧本来就是全表返回（dict_code 现网 9 条、
dict_data 24 条、dept 树 45 节点、menu 树 121 节点），换成分页会把数据**悄悄截断**。
`RestCrudDelegate.list` 允许返回非 `RestPage` 载荷，正好用在这。

#### 4.2.1 两处刻意的「不比 typed 更宽松」

* **`/api/dict-code` 的 `code` 不可修改**。两个理由叠在一起：①
  `DictService.updateDictCode` 是**按 `req.code` 反查记录**的（不是按 id），
  传一个不存在的 code 会得到「字典类型不存在或已删除」这种误导性 400；
  ② `sys_dict_data.code` 引用它，改了会让底下所有字典数据变孤儿。
  → 请求体带了与当前值不同的 `code` 直接 400。
  （`/api/dict-data` 的 `code` 反而**允许改**：那边 Service 是「按 id 找基线 +
  按新 code 查重」，改挂到另一个字典类型下是被显式支持的。）
* **`/api/dict-data/:id` 只按 id**，用的是 S2 新增的
  `DictService.getDictDataDetailById`。typed 的 `getDictDataDetail(id, code)`
  要求两个条件**同时命中**（前端编辑表单手里正好有 code，所以一直够用），
  而且它是裸 `db.findFirstRow`、**没有租户条件**；新方法走引擎，带租户 + 软删过滤。

#### 4.2.2 PATCH 语义是 delegate 的责任（最容易写错的一处）

本项目的 Service 更新方法普遍是**全量覆盖**，而且有**两种更坏**的形态：

| 形态 | 例子 | 后果 |
|---|---|---|
| 直接赋值 | `existing.code = req.code`（`DictService`） | 缺字段 → 写 null |
| `?? 默认值` | `existing.sort = req.sort ?? 0`（`MenuService.update`） | 缺字段 → **被重置成默认值**，比写 null 更隐蔽 |

所以 `PUT|PATCH /:id` 都必须**先读基线、逐字段补齐、再整体交出去**。
判断「字段有没有出现」只能用 `Map.containsKey` —— 用 `?? fallback` 会让客户端
**显式传 null**（想把 `description` 清空）被静默忽略。公共实现在
`rest_delegate_utils.dart` 的 `patchText` / `patchInt` / `patchBool` / `patchIntList`。

⚠️ 几个容易漏的基数字段：
* `SysRole.menus` / `apis` 是 `sys_role` 上的 **JSON 列**（`ColumnSerializable`），
  `RoleService.update` 会 `existing.menus = req.menus` —— 不从基线带过去就等于
  **把角色的菜单/接口清空**。
* `MenuRequest.type` / `DictDataRequest.sort` 在生成模型里是 `required`
  （没有默认值），新增时缺了会让构造函数直接抛 → 500，所以 delegate 先挡成 400。

### 4.3 请求约定

各资源的列表 query 参数与 typed 参数一一对应：

| 资源 | query |
|---|---|
| `/api/user` | `tenantId` / `deptId`（自动展开子孙部门）/ `username` / `nickname` / `phone` / `email` / `status` / `page` / `pageSize`（上限 100） |
| `/api/dept` | `name`（模糊）/ `status` |
| `/api/menu` | `name`（模糊 title）/ `status` |
| `/api/role` | 无（typed `role.getList` 也不收参数） |
| `/api/dict-code` | `tenantId` / `name`（模糊）/ `code`（模糊）/ `status` |
| `/api/dict-data` | `tenantId` / `code`（精确）/ `name`（模糊）/ `value`（模糊）/ `status` |

`POST` 的 `password` 必须是**登录公钥 RSA-OAEP(SHA-256) 加密后的 Base64 密文**
（`UserService.add` 会先解密再 PBKDF2 哈希），第三方接入需先取 `POST /api/auth/public-key`。
这是 Service 层隐含的约定被 REST 层原样继承 —— 见 §8「待办」2。

### 4.4 认证资源 `/api/auth`（S1，2026-09-24）

**挂载点 `/api/auth`**，三条路由**全部匿名可访问**（`requireAuth => false`）。

| 方法 | 路径 | 请求 | 转发到 | 成功返回 |
|---|---|---|---|---|
| GET | `/api/auth/public-key` | — | `AuthService.publicKey` | `data` 是 PEM 字符串 |
| POST | `/api/auth/login` | body `{username, password}` | `AuthService.login` | `data` 是 `LoginResponse` |
| POST | `/api/auth/refresh-token` | body `{refreshToken}`（兼容 `refresh_token`） | `AuthService.refreshToken` | `data` 是 `{accessToken, refreshToken, tokenType, expiresIn}` |

⚠️ **为什么必须显式覆写 `requireAuth`**：`ApiRoute` 默认 `true`，不覆写的话基类会在
`dispatch` 之前直接 401 —— 连「取公钥」这一步都走不到，整条登录链路死掉。

⚠️ **`password` 必须是密文**（RSA-OAEP(SHA-256) + Base64），与 typed 侧同一约定；
第三方对接顺序是 `public-key → 本地加密 → login`。明文版见 §8 待办 2。

⚠️ **业务失败仍是 `code 50000 → HTTP 400`**，**没有**映射成 401。这是刻意的：要维持
「typed 与 REST 响应体逐字节一致」这条验收基线 —— 把登录失败改成 401 就必须同时把信封
`code` 改成 40100，基线随即失效。语义化 code 见 §8 待办 1。

路径**用连字符**（`public-key` / `refresh-token`），不照抄 typed 的驼峰
`/auth/refreshToken` —— 那个名字是「Endpoint 名 + 方法名」拼出来的，不该带进 REST。
这是迁移方案 §5「S3 路径重新设计成扁平资源 URL」的起点。

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

### 5.2 离线验证到哪一步（2026-09-24 S1.5 + S2）

三个测试文件，**共 62 条断言**，全部不需要数据库、不需要起服务：

| 文件 | 条数 | 覆盖 |
|---|---|---|
| `serverpod_crud/test/rest_crud_route_test.dart` | 28 | 8 条路由签名；`enablePostAliases` / `enableBatchDelete` / **`enableCreate`** 三个开关；`RestActionRoute` 的 OPTIONS 守门测试；`extractIds`；信封；`RestPage`；`restJsonify`；**`encodeEnvelope`（为什么不能用 `jsonEncode`）** |
| `flutter_web_server/test/web/api_rest_routes_test.dart` | 10 | A 档 6 个资源的路由表；`role` 少一条 `POST /`；用真实的 `injectAt` 复现挂载 → 6 个挂载点互不冲突、子路径都能命中、`POST /api/role` 确实是 405 |
| `flutter_web_server/test/web/rest_delegate_utils_test.dart` | 13 | PATCH 语义（`containsKey` vs `??`）、取值校验、失败分档（400/404） |
| `flutter_web_server/test/web/serverpod_envelope_test.dart` | 11 | 信封形状、与 `PageResponse` 逐字节一致、兜底码映射 |

**哪些坑因此被提前到单测阶段**：

* 「同一挂载点只能挂一次」——原本只在进程启动时才抛 `Conflicting values`；
* 「OPTIONS 没注册 → 预检 405、CORS 中间件不跑」——同理；
* **「手搓树里的 `DateTime` 会让 `jsonEncode` 抛」**——这个最值：部门树 / 菜单树
  一调就 500，而 typed 路径看不出问题（它用的是 Serverpod 的编码器）。

⚠️ 仍未做真实 HTTP。`BaseRestRoute` 全部路由（6 个资源 + 认证 3 条）都还没有
经过一次真实请求 —— 等 HTTP 冒烟（迁移方案 §7 的回归脚本）。

### 5.3 typed 侧的回归 —— 6 个 A 档资源（2026-09-24 S0.5）

决策 4 的收敛刻意**不动对外签名**，所以这一轮不需要 typed↔REST 对比，
只要证明 **typed 侧行为不变**。做法与结果：

* 真实发请求到 `127.0.0.1:8080`（Bearer token，种子密码 `asdf1234`），
  期望值来自 DB 的 `count(*)`。
* **22 条断言全绿**：6 个资源的 list / detail、分页边界（`pageSize=999→100`、`=0→10`、
  第 2 页）、顺序（`id ASC` / `sort ASC,id ASC`）、`disabled` 注入、树节点数（dept 45 / menu 121）、
  `password` 不泄漏。
* `numQueries` 也对齐了 B1/B2 基线：`user.getUserList` 无 deptId = **2**、带 deptId = **3**；
  `dept/role/menu.getList` = **1**（全表 + 内存建树）。

明细见 `docs/rest-api-migration-plan.md` §7.1。

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
  （`RestActionRoute(requireAuth:)` / `BaseRestRoute(requireAuth: true)`）；
* **记录不存在**：在 delegate 里先确认基线（`getDetail`），失败即 404；
  公共实现是 `rest_delegate_utils.dart` 的 `requireFound` / `ensureDeleted`；
* 其余失败统一 400（`ensureOk`），业务码原样透传 Service 的 50000。

⚠️ 一个容易漏的分支：**批量删在「一条都没命中」时仍然返回成功**
（data 里 `successCount: 0`），不会 `isFailed` —— 所以单条删除的 404 必须
看计数（`ensureDeleted`），不能只看 `isFailed`。

⚠️ 由此产生一处**刻意与 typed 不一致**：typed `GET /user/:id` 传不存在的 id 返回
**HTTP 200 + code 50000**，REST 返回 **HTTP 404 + code 40400**。这是 HTTP 语义的
改善（前端 axios 拦截器按 404 处理更自然），不是缺陷；但「typed↔REST 逐字节一致」
的验收基线要为此**排除掉 not-found 场景**。

之所以不去改 Service 的返回码：Vue 前端已经在按 `code === 50000` 判断业务失败，
动它等于改公共契约。**这条缺口记在 §8 待办 2，Service 层返回语义化 code 才是根治方案。**

### 6.5 `config/development.yaml` 的 `cors:` 只管 API server

```text
OPTIONS 8080/user/getUserList  → 200 + access-control-allow-origin: *
OPTIONS 8082/api/user/2       → 405，一个 access-control-* 都没有
```

Serverpod 把 CORS 做在 typed API 的处理链上，Web Server 这条链路完全不看
那段配置。必须自己加中间件（`cors_middleware.dart`）。

### 6.6 响应体不能用 `dart:convert` 的 `jsonEncode`（S2 踩到）

typed Endpoint 的响应体是 `SerializationManager.encodeForProtocol(result)`
（`serverpod/lib/src/server/server.dart:595`），它会顺手把
`DateTime` 转成 ISO 串、把 `SerializableModel` 转成 `toJson()`。

早期的 REST Route 直接写 `jsonEncode(json)`，于是：

```text
GET /api/dept  → 500
Converting object to an encodable object failed: Instance of 'DateTime'
```

因为 `DeptService.getList` / `MenuService.getList` 返回的是**服务层手搓的树**
（`List<Map<String, dynamic>>`），里面的 `createTime` 是 `DateTime` **对象**：
`CommonResponse.toJson()` 只把顶层/一层的 `SerializableModel` 转成 Map，
**穿不过手搓 Map 里的 DateTime**，`JsonCleaner` 也只会对 String 做时间格式化。

修法：框架侧统一走 `encodeEnvelope(json)`（= `SerializationManager.encodeForProtocol`），
见 `serverpod_crud/lib/src/web/rest_crud.dart`。这也让「typed 与 REST 逐字节一致」
变成天然的，而不是靠人肉对齐。单测
`encodeEnvelope（为什么必须用 Serverpod 的编码器）` 把它钉住了。

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

1. **真实 HTTP 冒烟一次都没跑**（当前最大的一条）。`/api/auth` 3 条 + A 档 6 个资源
   的路由全部只验证到单测与路由表（§5.2），**没有任何一条经过真实请求**。
   需要做的：`/api/auth` 三条链路走通拿 token；6 个资源各跑
   `GET /` + `GET /:id` 与 typed 对比（回归脚本见迁移方案 §7）；再验一次审计落库。
   → 迁移方案 **#14 HTTP 冒烟（验完不提交）**
2. **Service 返回语义化 code**：把「未登录 → 40100、不存在 → 40400」下沉到
   Service，Route 就不需要靠「先查基线」来猜 404（§6.4）。目前 REST 侧的单条读 /
   改 / 删都会**多一次基线查询**换 HTTP 语义 —— 见 §4.2 与 `requireFound`。
3. **`POST` 的密码必须是密文**：第三方接入体验差。可在 Service 加
   `addWithPlainPassword`（内部直接 PBKDF2 哈希），REST 层按来源选择。
4. **`UserService.delete` 没有级联清理 `sys_user_role`** —— role 的删除已用
   `batch.successIds` 做级联，user 的还没有；删用户会留下孤儿关联行。
   （审计已不再是缺口：6 个引擎都已注入 `DbAuditService`，见 §2.3。）
5. **`dict-code.delete` 的入参是 `ids`、`dict-data.delete` 也是**，但 `/api/dict-code`
   的批量删之后会**级联软删该类型下的所有 dict_data** —— 这是跨资源的关联清理，
   在 Service 里手写，`BaseRestRoute` 盖不住。同类还有 `role.delete`（级联两张关联表）。
6. **A 档 6 个资源的 per-resource 逻辑仍是手工活**：`registerCrud` 解决的是
   「**路由**不手写」，不是「**业务**不手写」。现状是 6 个 delegate 各约 100–200 行，
   且**没有一个能零覆写**：user 5 处特殊逻辑、dept/menu 返树、role 无 add、
   dict×2 入参类型不一致。详见 §4.2 与迁移方案 §3.2。
7. **`enableCreate: false` 目前只有 role 用**，且它是「不注册路由」而非「注册后 405」——
   响应是 405 而不是 404（§4.1）。如果以后出现「只读资源」，这是现成的开关。
8. **未加 Rate limiting / API Key 中间件**：官方把这两项也列为 Middleware 的
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

