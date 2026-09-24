# REST 表现层（Serverpod 4 Web Server）

> 分支：`feature/web-server-rest-api`
> 代码：`flutter_web_server/lib/src/web/routes/api/`
> 挂载端口：**8082**（`config/development.yaml` 的 `webServer.port`）
> 状态：**REST 化改造已全部完成**。路由是「团队式」6 条字面子路径
> （`getList` / `getDetail` / `add` / `update` / `delete` / `deleteBatch`）—— 见 §4.1、§10.1。
> 验证：离线断言 105 条 + **真实 HTTP 冒烟 62 条（2026-09-24）**，见 §5。
> ⚠️ **原生 REST 那 8 条（`GET /`、`GET /:id`、`PUT|PATCH /:id`、`DELETE /:id`、`DELETE /`）
> 早已移除** —— 本文若见到它们，都是过期内容。

> **本文是这块代码的「现状 + 坑」文档。** 改 `web/routes/api/**` 或
> `serverpod_crud` 的 REST 层之前请通读 §2（分层）、§4（接口清单与约定）、
> §6（踩坑实测）；§8 是**已知缺口 / 刻意搁置**清单。

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

### 2.2 只有一套基类（已收口）

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

### 2.3 Service 收敛层

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

🔴 **查询审计（`QueryAuditLogPlugin`）已被删除，不是「还没生效」**：唯一把它挂进
`CrudRuntime` 的地方是 `crud/crud_runtime_factory.dart`，而那个文件**只被已退役的
`base_endpoint.dart` 引用**。S5 一并删除后，引擎用的是默认空 `CrudRuntime()`，
所以查询审计 / 分页校验插件 / `contains` 操作符**确定不在链路里**。
要恢复得重新写一份 runtime 装配（见 §2.4）。

收敛当时发现的 5 类行为变更（回归时必须盯，代码里都标了 ⚠️）：

| # | 变更 | 影响 |
|---|---|---|
| 1 | **租户过滤变严** | 旧实现基本只在入参给了 `tenantId` 时才拼条件（单条 `findFirstRow` 更是一个租户条件都没有）；引擎一律按 `session.tenantId`。方向更正确，但要比对 `total`。⚠️ `dict.getDictData` 是 `@unauthenticatedClientCall`（登录前要用、拿不到 session），**刻意保留**按入参过滤 |
| 2 | **`delete` 必须两步走** | `BaseService.delete` 只收 `id`、拿不到实体，**不维护** `updater`/`updateTime`；且 `CrudService.update` 里有 `setDeleted(data, false)` → 必须先 `update()` 落审计字段、再 `delete()` 软删，**顺序不可颠倒** |
| 3 | **`deleteBatch` 同样不维护审计字段** | 原 role/dept 的批量删会写 `updater`/`updateTime`，收敛后不写了 |
| 4 | **`QueryEngine` 在 `sort` 为空时不排序** | 旧实现都有 `orderByList`，收敛时必须显式传 `sortAsc('id')` |
| 5 | **`QueryEngine` 的 `safePageSize` 是 200/20，旧代码是 100/10** | 由 `buildCrudQuery(defaultPageSize: 10, maxPageSize: 100)` 先收敛，否则上限被放大 |

另有 2 个 `dart analyze` 抓不到的陷阱：`BaseEntityService` 虽无抽象成员但声明成 `abstract` → 必须写 6 个具体子类才能实例化；`EntityDescriptor.fromServerpod()` 会读 `Serverpod.instance.serializationManager` → 引擎**必须 lazy**。

回归基线（typed 侧单侧验证，22 条断言全绿；期望值来自 DB `count(*)`）：`user` 无 deptId → total=15、`deptId=1` → 12、`pageSize=999→100`、`=0→10`；`dept` 树 45 / `role` 11（含 `disabled`）/ `menu` 树 121 / `dict_code` 9 / `dict_data` 24。`numQueries`：`user.getUserList` 无 deptId=**2**、带 deptId=**3**；`dept/role/menu.getList`=**1**。

### 2.4 typed 侧退役清单

目标「**所有接口只由 REST 提供一份实现**」。退役掉的是 typed 侧那些
「与 REST 等价」或「为兼容 typed 线格式而生」的东西：

| 退役物 | 原位置 | 退役后由谁提供 |
|---|---|---|
| `addByJsonParams` / `updateByJsonParams` | `endpoints/system/base_endpoint.dart` | REST 侧 `POST /api/user/add` / `POST /api/user/update`（`jsonObjectBody()` 直接吃普通 JSON） |
| `endpoints/system/base_endpoint.dart`（业务版基类） | 同上 | —— 整份删除。它从未被除 `UserEndpoint` / `ProductEndpoint` 之外的东西继承 |
| `endpoints/utils/json_param_codec.dart` | —— | —— 只服务上面两个方法的 JSON 文本解码 |
| `crud/crud_runtime_factory.dart` | —— | —— 只被已删的基类引用（连带 `crud/plugins/query_audit_log_plugin.dart`） |
| `mappers/query_request_mapper.dart` | —— | —— 同上，只被已删的基类引用 |
| `UserEndpoint extends BaseEndpoint<SysUser, SysUserTable>` | `user_endpoint.dart` | **退成裸 `Endpoint`**，保留 7 个业务方法。继承来的 6 条 typed 路由全部消失 |
| `ProductEndpoint extends BaseEndpoint<Book, BookTable>` | `product_endpoint.dart` | 退成裸 `Endpoint`（类型参数原是复制粘贴写错的 `Book`） |

⚠️ **前端必须同步改**，否则这几个调用会 404 —— `baseAPI('/user')` 打的就是
`GET /api/user/getList`、`POST /api/user/delete`、`POST /api/user/deleteBatch`
（见 §4.2 与 `gi_demo_admin/src/apis/base.ts`）。

保留的 typed 方法（业务特定、套不进 CRUD 模板）：`user` 7 个（`add` / `getUserList` /
`getUserInfo` / `getUserRoutes` / `userUpdate` / `getDetail` / `resetPassword`）、
`product` 2 个、`book` 5 个、`airtable` 5 个 Endpoint、`system` 2 个 ——
它们与 REST 侧**共用同一份 Service**，所以在行为上不会漂移。

### 2.5 `apispec.json` 已删除（别再找）

它**不是** `serverpod generate` 的产物，而是第三方包 `serverpod_openapi@0.0.3` 一次性导出的
Swagger 快照 —— 只能覆盖 typed Endpoint，**原理上看不到 `/api/**` 这些裸路由**。
随 Serverpod 4 升级移除了依赖与 `/openapi` 路由，文件已 `git rm`（零消费者）。

## 3. 对外契约

### 3.1 状态码

**口径：业务失败一律 `200`，成败只由 body 里的 `code` 表达。**（2026-09-24 拍板，理由见下）

| 场景 | HTTP | 信封 code |
|---|---|---|
| 成功（查询/更新/删除） | 200 | 20000 |
| 创建成功 | **201** | 20000 |
| 未登录 / token 失效 | **401** | 40100 |
| 业务规则拒绝（用户名已存在、内置用户不可删…） | 200 | 50000 |
| 入参不合法（`id` 非正整数、body 不是 JSON 对象…） | 200 | 40400 |
| 资源不存在 | 200 | 40400 |
| 未预期异常（未捕获异常） | **500** | 50000 |
| 路径 / 方法未注册（`PathMiss`、`enableCreate:false`） | **404 / 405** | **空 body**（框架层，不经信封） |

⚠️ **只有三种情况会给非 2xx：401（未登录）、500（未预期异常）、404/405（路由根本没注册）。**
「记录不存在」也是 200 —— 用 `code 40400` 表达。

**为什么选 200 而不是真实 4xx**（三个理由，按重要性排）：
1. **前端拦截器是按 HTTP 状态码分流的，非 2xx 那一支会丢弃 body。**
   `gi_demo_admin/src/utils/http.ts` 里 2xx 走成功分支（读 body `code`、
   `Message.error(message)` 显示**服务端原文**），非 2xx 走失败分支
   （`Message.error(StatusCodeMessage[status])`，只有 `400: '请求错误(400)'` 这种通用文案）。
   所以一旦用 400/404 回业务失败，「昵称不能为空」这种提示**永远到不了用户眼前**。
2. **与 typed(8080) 侧口径一致**：typed 侧业务失败本来就是 `200 + code 50000`，
   客户端只需要一套判断逻辑。
3. **`/api/auth/*` 早就这么做了**，统一到 200 等于「扩展现有做法」而不是「推翻它」。

⚠️ **401 是硬约束，必须保留真实状态码。** 前端靠它触发 refresh token
（`http.ts` 的 401 分支在「非 2xx」那一侧），压成 200 会让登录态无法续期。
`PlainEnvelopeBuilder` 这类**框架默认实现仍是「HTTP 语义优先」**（原样透出
`RestApiException.httpStatus`）—— 是否压成 200 由业务项目的信封决定。

⚠️ **`code` 与 HTTP 状态码的对应关系**由 `ServerpodEnvelopeBuilder._mapCode` 固定：
`401→40100`、`403→40300`、`404→40400`、`400→40400`、`500→50000`，其余（含 `null` 兜底）原样或落 `50000`。
注意 `validateFailed` 与 not-found **共用 `40400`** —— 业务码层面区分不出来，
只能看 `message`（这是刻意保留的既有形状，见 §6.4）。

### 3.2 响应体

统一 `{code, message, data}`，与 typed Endpoint 完全一致 —— 因为直接复用
`CommonResponse.toJson()`，它内部经过 `JsonCleaner`，已经去掉了
`__className__` 和 `password`，可直接交给第三方。

**分页接口（S6 起）的 `data` 是定形对象**，分页元信息**全部收在 `data` 里**：

```json
{
  "code": 20000,
  "message": "",
  "data": {
    "records": [ /* … */ ],
    "total": 15,
    "page": 1,
    "pageSize": 10,
    "totalPage": 2
  }
}
```

⚠️ **这里与 typed（8080）刻意不一致**：typed 侧 `PageResponse.toJson()` 把元信息
**摊在顶层**（`{code, message, page, pageSize, totalPage, total, data:[…]}`）。
分歧只发生在 REST 侧，由 `ServerpodEnvelopeBuilder`（`web/routes/api/serverpod_envelope.dart`）
一家收口；`flutter_web_shared` 的 `PageResponse` 与 typed 基线**完全不改**。

达成这个形状有两处必须注意：

* **两条分页支路要折成同一形状**。`envelope.page(RestPage)`（通用 delegate：
  dictCode / dictData / dept / menu）与 `envelope.success(PageResponse)`
  （user / role 的 Service 直接返 `PageResponse`）最终都走私有 `_paged()`。
* ⚠️ `serverpod_envelope.dart` 的 `success()` 里，`data is PageResponse` 的守卫
  **必须放在 `data is CommonResponse` 之前** —— `PageResponse extends CommonResponse`，
  顺序反了就会走「防双层信封」那条分支，形状退化成「`data` 是一个数组」。
  单测 `serverpod_envelope_test.dart` 把两种入参同形这件事钉住了。

响应体不能直接 `jsonEncode`（`DateTime` 会 500），必须走 `encodeForProtocol` —— 见 §6.6。

### 3.3 鉴权

`Authorization: Bearer <accessToken>`（与 typed API 同一套 JWT）。
`ApiRoute.requireAuth` 默认为 true，基类在进入 `dispatch` 之前先判
`session.authenticated`，失败直接 401 —— **这是全站唯一保留真实非 2xx 的「业务相关」场景**
（原因：前端靠它触发 refresh token，见 §3.1、§6.9）。

当前**匿名可访问的恰好 6 条**：`/api/auth/*`（3 条，登录前用）、
`/api/dict/options`（登录页的字典下拉）、`/api/system/health`、
`/api/system/version`（探活）。其余全部要求登录。这 6 条有单测钉住
（`api_action_routes_test.dart` 的「匿名可访问的恰好 6 条」）——
漏写 `requireAuth: false` 会让登录/探活 401，多写一个就是越权开放，两种都要能拦。

## 4. 接口清单

前缀 `/api/<资源名>` —— **单数**（`dict-*` 用连字符），与 typed Endpoint 的资源名一致
（开工时拍板：直接沿用既有资源名，不另起一套 URL 命名）。当前挂了 **6 个 A 档资源 + 1 个认证资源
+ 14 条业务动作路由**：

`/api/user`、`/api/dept`、`/api/role`、`/api/menu`、`/api/dictCode`、
`/api/dictData`、`/api/auth/*`、`/api/dict/options`、`/api/system/*`。

### 4.1 泛型层一次产出的 6 条路由（团队式）

`BaseRestRoute<T>` 挂载一次即产出下列全部路由，**不需要逐条手写**。
**六个子路径全部是字面量段**，资源挂载点下不再有任何 `:id` 参数段：

| # | 方法 | 路径 | 说明 | HTTP | 落到 |
|---|---|---|---|---|---|
| 1 | GET | `/api/user/getList` | 列表（分页/过滤走 query） | 200 | `delegate.list` |
| 2 | GET | `/api/user/getDetail?id=123` | 详情（**id 走 query，不是路径参数**） | 200（读不到 → 200 + `code 40400`） | `delegate.detail` |
| 3 | POST | `/api/user/add` | 新增（body 平铺） | **201** | `delegate.create` |
| 4 | POST | `/api/user/update` | 更新（body 平铺且**自带 `id`**，PATCH 语义） | 200 | `delegate.update` |
| 5 | POST | `/api/user/delete` | 单条删（body `{"id":1}`） | 200（不存在 → 200 + `code 40400`） | `delegate.remove` |
| 6 | POST | `/api/user/deleteBatch` | 批量删（body `{"ids":[1,2]}`） | 200 | `delegate.removeBatch` |

> 除第 3 条（201）外**全部 200** —— 包括「读不到 / 不存在」。
> 状态码口径见 §3.1；「不存在」靠 `code 40400` 表达。

开关与返回值语义：

* 第 3 条由 `enableCreate` 控制，第 6 条由 `enableBatchDelete` 控制，**两个默认都开**。
  现状只有 `/api/role` 关 `enableCreate`。
* ⚠️ 关掉 `enableCreate` 后，`POST /api/role/add` 是 **404**（`PathMiss`），
  **不是 405** —— `/add` 是一条独立路由，没注册就是「路径不存在」。
  ⚠️ 这条 404 是**框架层直接返回的，响应体是空 body 而不是 JSON 信封**（实测），
  与业务失败的 `200 + code 40400` 完全不是一回事，别混。
  （形状变化源自 S6：旧版 `POST /` 关掉是 405，因为路径还挂着 `GET /`、`DELETE /`。）
* **`delete` 与 `deleteBatch` 刻意分开**：前者返 `boolean`，只接受**恰好一个** id，
  body 给多个返 `200 + code 40400`（「多条请用 POST /deleteBatch」）；后者返
  `{total, successCount, notFoundCount, successIds, failedIds}`。

**为什么不是原生 REST 那套（S6 拍板）**：本项目「**基本上只使用 GET、POST**」，
旧版为了 HTTP 语义正确额外造了 `PUT|PATCH /:id`、`DELETE /:id`、`DELETE /` 三条，
再加上两条 POST 兼容别名，共 8 条（其中 3 条功能重叠）。换成 6 条同形子路径后：

| 收益 | 说明 |
|---|---|
| 客户端只剩 GET/POST | 与团队既有前端写法（`http.get` / `http.post`）零摩擦 |
| 路径全字面量 | `PathTrie` 的「同层参数名必须一致」约束自然消失（§6.7 只对动作路由仍有效） |
| 一资源一路径族 | 6 个资源的路由表**完全同形**，离线断言可以用同一张表遍历 |

> ⚠️ 该约束对**嵌套在资源挂载点下的动作路由**依然有效 —— `/api/role/:id/menus`
> 这些仍在用 `:id`，见 §4.5 与 §6.7。

`/api/user/getList` 的载荷按资源不同（user 返 `PageResponse`、dept/menu 返树、
dict×2 返全表、role 返平铺），见 §4.2。

### 4.2 A 档 6 个资源

每个资源一次 `registerResource<T>`，业务差异**全部**收敛在一个 delegate 里：

| 资源 | delegate | `GET /getList` 的形态 | 特殊点 |
|---|---|---|---|
| `/api/user` | `UserRestDelegate` | 分页列表（9 个专用 query） | RSA 密码、`roleIds` 关联表 |
| `/api/dept` | `DeptRestDelegate` | **部门树**（非分页） | 服务层建树、批量删 |
| `/api/menu` | `MenuRestDelegate` | **菜单树**（非分页） | 更新是「全量覆盖 + 默认值」 |
| `/api/dictCode` | `DictCodeRestDelegate` | 全量列表（非分页） | `code` 不可改（§4.2.1） |
| `/api/dictData` | `DictDataRestDelegate` | 全量列表（非分页） | 详情只按 id（§4.2.1） |
| `/api/role` | `RoleRestDelegate` | 平铺 + `disabled` | **没有 `POST /add`** → 404 |

三个「非分页列表」是刻意的：typed 侧本来就是全表返回（dict_code 现网 9 条、
dict_data 24 条、dept 树 45 节点、menu 树 121 节点），换成分页会把数据**悄悄截断**。
`RestCrudDelegate.list` 允许返回非 `RestPage` 载荷，正好用在这。

#### 4.2.1 两处刻意的「不比 typed 更宽松」

* **`/api/dictCode` 的 `code` 不可修改**。两个理由叠在一起：①
  `DictService.updateDictCode` 是**按 `req.code` 反查记录**的（不是按 id），
  传一个不存在的 code 会得到「字典类型不存在或已删除」这种误导性失败；
  ② `sys_dict_data.code` 引用它，改了会让底下所有字典数据变孤儿。
  → 请求体带了与当前值不同的 `code` 直接失败（`code 40400`）。
  （`/api/dictData` 的 `code` 反而**允许改**：那边 Service 是「按 id 找基线 +
  按新 code 查重」，改挂到另一个字典类型下是被显式支持的。）
* **`GET /api/dictData/getDetail?id=` 只按 id**，用的是 S2 新增的
  `DictService.getDictDataDetailById`。typed 的 `getDictDataDetail(id, code)`
  要求两个条件**同时命中**（前端编辑表单手里正好有 code，所以一直够用），
  而且它是裸 `db.findFirstRow`、**没有租户条件**；新方法走引擎，带租户 + 软删过滤。

#### 4.2.2 PATCH 语义是 delegate 的责任（最容易写错的一处）

本项目的 Service 更新方法普遍是**全量覆盖**，而且有**两种更坏**的形态：

| 形态 | 例子 | 后果 |
|---|---|---|
| 直接赋值 | `existing.code = req.code`（`DictService`） | 缺字段 → 写 null |
| `?? 默认值` | `existing.sort = req.sort ?? 0`（`MenuService.update`） | 缺字段 → **被重置成默认值**，比写 null 更隐蔽 |

所以 `POST /update` 必须**先读基线、逐字段补齐、再整体交出去**。
判断「字段有没有出现」只能用 `Map.containsKey` —— 用 `?? fallback` 会让客户端
**显式传 null**（想把 `description` 清空）被静默忽略。公共实现在
`rest_delegate_utils.dart` 的 `patchText` / `patchInt` / `patchBool` / `patchIntList`。
（S6 之前更新还有 `PUT|PATCH /:id` 这一路，语义相同；现在只剩 `POST /update`。）

⚠️ 几个容易漏的基数字段：
* `SysRole.menus` / `apis` 是 `sys_role` 上的 **JSON 列**（`ColumnSerializable`），
  `RoleService.update` 会 `existing.menus = req.menus` —— 不从基线带过去就等于
  **把角色的菜单/接口清空**。
* `MenuRequest.type` / `DictDataRequest.sort` 在生成模型里是 `required`
  （没有默认值），新增时缺了会让构造函数直接抛 → 500，所以 delegate 先挡成
  `code 40400` 的失败（HTTP 仍是 200，§3.1）。

### 4.3 请求约定

各资源的列表 query 参数与 typed 参数一一对应。**分页参数名认两个**：

* `pageSize` —— 框架自己的写法，**优先**；
* `size` —— 团队前端惯用的写法（`{ page, size }`），**兜底**。

（`AutoRestCrudDelegate.list` 与自定义分页的 `UserRestDelegate.list` 都补了这份兼容。
两者都不传时用默认 10，上限 100。）

| 资源 | query |
|---|---|
| `/api/user` | `tenantId` / `deptId`（自动展开子孙部门）/ `username` / `nickname` / `phone` / `email` / `status` / `page` / `pageSize`\|`size`（上限 100） |
| `/api/dept` | `name`（模糊）/ `status` |
| `/api/menu` | `name`（模糊 title）/ `status` |
| `/api/role` | 无（typed `role.getList` 也不收参数） |
| `/api/dictCode` | `tenantId` / `name`（模糊）/ `code`（模糊）/ `status` |
| `/api/dictData` | `tenantId` / `code`（精确）/ `name`（模糊）/ `value`（模糊）/ `status` |

详情走 `GET /getDetail?id=<正整数>`；`id` 缺失或非正整数 → 失败
（`code 40400`，`extractSingleId` / `queryId` 负责，错误信息里带实际值）。

`POST` 的 `password` 必须是**登录公钥 RSA-OAEP(SHA-256) 加密后的 Base64 密文**
（`UserService.add` 会先解密再 PBKDF2 哈希），第三方接入需先取 `POST /api/auth/public-key`。
这是 Service 层隐含的约定被 REST 层原样继承 —— 见 §8.1 第 2 条。

### 4.4 认证资源 `/api/auth`

**挂载点 `/api/auth`**，三条路由**全部匿名可访问**（`requireAuth => false`）。

| 方法 | 路径 | 请求 | 转发到 | 成功返回 |
|---|---|---|---|---|
| GET | `/api/auth/public-key` | — | `AuthService.publicKey` | `data` 是 PEM 字符串 |
| POST | `/api/auth/login` | body `{username, password}` | `AuthService.login` | `data` 是 `LoginResponse` |
| POST | `/api/auth/refresh-token` | body `{refreshToken}`（兼容 `refresh_token`） | `AuthService.refreshToken` | `data` 是 `{accessToken, refreshToken, tokenType, expiresIn}` |

⚠️ **为什么必须显式覆写 `requireAuth`**：`ApiRoute` 默认 `true`，不覆写的话基类会在
`dispatch` 之前直接 401 —— 连「取公钥」这一步都走不到，整条登录链路死掉。

⚠️ **`password` 必须是密文**（RSA-OAEP(SHA-256) + Base64），与 typed 侧同一约定；
第三方对接顺序是 `public-key → 本地加密 → login`。明文版见 §8.1 第 2 条。

⚠️ **业务失败是 `200` + `code 50000`**（**没有**映射成 401）。这既是「与 typed 逐字节一致」
这条验收基线的要求，也是 2026-09-24 定下的**全站统一口径**（§3.1）——
三条 auth 路由不再特殊，它们本来就是这个口径的样板。
「把 `code` 语义化下沉到 Service」见 §8.2 第 7 条。

> 注：`RestActionRoute.handleCall` 在 handler 正常返回时**一律给 200**；抛
> `RestApiException` 时给什么状态码由信封的 `httpStatusFor` 决定（本项目压成 200，
> 只放行 401 —— 见 §3.1）；未预期异常 500。所以「业务失败给 200」这件事**不需要**
> handler 自己做什么，反倒是**想让失败真的失败**才要额外写代码。

### 4.5 B 档 12 个业务动作

套不进 CRUD 模板的单点接口，全部用 `RestActionRoute`（与 `BaseRestRoute<T>` 共用
鉴权 / 信封 / 状态码 / 异常兜底）。**路由表写在每个域的 `*_action_routes.dart` 里，
以 `Map<String, RestActionRoute>` 的形式同时供给「注册」和「测试」**——
测试不必手抄路径清单，也就不会出现「改了代码忘了改测试」的假绿。

| 资源 | REST | typed 方法 | 认证 |
|---|---|---|---|
| user | `GET /api/user/info` | `getUserInfo` | 登录 |
| user | `GET /api/user/routes` | `getUserRoutes` | 登录 |
| user | `POST /api/user/reset-password` | `resetPassword(ids)` | 登录 |
| role | `GET /api/role/:id/menu-ids` | `getRoleMenuIds` | 登录 |
| role | `GET /api/role/:id/users` | `getRoleUsers` | 登录 |
| role | `POST /api/role/:id/users/remove` | `cancelUserRoles` | 登录 |
| role | `PUT \| POST /api/role/:id/menus` | `saveRolePermissions` | 登录 |
| menu | `GET /api/menu/options` | `getMenuOptions` | 登录 |
| dict | `GET /api/dict/options` | `getDictData` | **匿名** |
| dict | *复用* `GET /api/dictData/getDetail?id=` | `getDictDataDetail(id, code)` | 登录 |
| system | `GET /api/system/health` | `health` | **匿名** |
| system | `GET /api/system/version` | `version` | **匿名** |

12 个 typed 方法对应 **11 条新路由** —— 少的那条是 `getDictDataDetail(id, code)`：
它要求 `id` 与 `code` **同时命中**，是 typed 端的历史签名；REST 侧的
`GET /api/dictData/getDetail?id=` 只按 id（走带租户 + 软删过滤的 `getDictDataDetailById`），
读的是同一行、只是**更宽松**（少一个校验条件），再挂一条 `?code=` 的重复路由没有意义。
（同理，`/api/auth/*` 那 3 条在 S1 已完成，是 B 档里的另外 3 条。）

#### 4.5.1 两个「只在运行期爆」的路径约束

| 约束 | 表现 | 依据 |
|---|---|---|
| **嵌套在资源挂载点下的动作路径，参数名必须沿用 `:id`** | 起 `:roleId` 会在注册阶段抛 `Conflicting parameter names at the same level`，**服务根本起不来** | `PathTrie._build` 走同一个参数节点时校验名字 |
| **字面量段优先于参数段** | `GET /api/user/info` 命中字面量节点；若参数段优先，`info` 会被当成 id → 运行期失败「路径参数必须是正整数」（`code 40400`） | `PathTrie.lookup` 的匹配顺序 |

两条都有单测钉住（`api_action_routes_test.dart`：「字面量段优先于参数段」那组用
`RouterMatch.parameters` **是否为空**来区分命中的是字面量还是 `:id`；
「路径参数名不能另起」那条断言 `:roleId` 必抛 `ArgumentError`）。详见 §6.7。

#### 4.5.2 为什么 `/api/dict/options` 另起挂载点，而不是塞进 `/api/dictData`

它返回的不是「字典数据的行」，而是一张**按类型分组的聚合视图**：
`{"TYPE_A": [{"label":…,"value":…,"tagProps":{…}}], …}`。服务的是「一次拿全所有
下拉框候选项」，而且**登录前就要能调**。所以它是个独立的只读视图，与 A 档两个资源平级。

⚠️ 也正因为匿名可读且租户过滤走**入参** `tenantId`（登录前没有 session），
**不传 `tenantId` 会返回全部租户的字典项** —— 这是 `DictService.getDictData` 里
刻意保留的行为（它不是漏改），对接时注意别把它当成越权漏洞。

#### 4.5.3 批量动作的失败语义

* `POST /api/user/reset-password` 与 `POST /api/role/:id/users/remove` 的 id 集合是
  **必填**：缺失 / 空数组 / 全非法 → 失败（`code 40400`）。理由是本项目这两个 Service
  对空数组的处理是「返回 `successCount: 0` 的**成功**响应」，对调用方来说
  「我压根没传 ids」应该是失败，而不是「操作成功但一个都没处理」。实现在 `requiredIntList`。
* 反过来，`PUT /api/role/:id/menus` 的 `menuIds` **允许空数组** —— 菜单集是
  **全量替换**语义，`[]` 是合法且有意义的值（清空该角色全部菜单权限）。
  所以它用的是 `normalizedIntList` 而不是 `requiredIntList`。
* `resetPassword` 在「一个都没命中」时仍是成功（`successCount: 0`）
  ——批量接口里「部分命中」是正常结果，逐条判失败反而不好用。


路径**用连字符**（`public-key` / `refresh-token`），不照抄 typed 的驼峰
`/auth/refreshToken` —— 那个名字是「Endpoint 名 + 方法名」拼出来的，不该带进 REST。
这是「路径重新设计成扁平资源 URL」这条原则的起点，S3 的 14 条动作路由都照此办理。

### 4.6 C 档 airtable 子系统

**5 个 typed Endpoint / 21 个方法 → 13 条路径**。全部手写 `RestActionRoute`，
**没有**套泛型 `BaseRestRoute`。

| 层 | 路径 | 方法 | typed 方法 |
|---|---|---|---|
| 表 | `/api/airtable/tables` | GET / POST | `getTables` / `createTable` |
| 表 | `/api/airtable/tables/:id` | GET / PUT\|POST / DELETE | `tableDetail` / `updateTable` / `deleteTable` |
| 字段 | `/api/airtable/tables/:id/fields` | GET / POST | `getAirTableFields` / `createField` |
| 字段 | `/api/airtable/fields/:id` | PUT\|POST / DELETE | `updateField` / `deleteField` |
| 行 | `/api/airtable/tables/:id/rows` | GET / POST | `getTableRows` / `createRow` |
| 行 | `/api/airtable/rows/:id` | PUT\|POST / DELETE | `updateRow` / `deleteRow` |
| 行 | `/api/airtable/rows/delete` | POST | `batchDeleteRows` |
| 单元格 | `/api/airtable/items` | POST | `upsertItem` |
| 单元格 | `/api/airtable/items/:id` | DELETE | `deleteItem` |
| 关联 | `/api/airtable/items/:id/relations` | GET | `getItemRelations` |
| 关联 | `/api/airtable/tables/:id/searchable-items` | GET | `searchTableItems` |
| 关联 | `/api/airtable/relations/tables` | GET | `getAvailableTables` |
| 关联 | `/api/airtable/relations/tables/:id/fields` | GET | `getTableFieldsForRelation` |

**21 → 13 的原因**：同一路径的多种方法合并成一条路由；`PUT` 与 `POST`
两种写法共用同一个 handler；`getTables2` 与 `getTables` 逐行等价，**已删除**。

#### 4.6.1 为什么没套泛型 `BaseRestRoute`

airtable 不是「一张主表 + 一套固定 CRUD」，而是**四层嵌套子系统**：

* `fields` / `rows` 是「某张表下」的**子资源**，泛型层 `GET /` 的语义
  （按租户分页全表）在这里是错的；
* 删除是**级联物理删**（删表要连带清字段 / 行 / 单元格），与泛型的软删 `delete` 相反；
* 写操作的返回值不统一 —— 新建表返回 **id**、建行返回 **`true`**、
  建字段返回**整行**、改表返回**详情 DTO**。

所以 S4 的选择是：**给四张 `air_*` 表补上 `tenantId` / `deleted` 两列让结构与
A 档对齐，路由全部手写**。补列的价值是「租户隔离 + 过滤口径统一 + 字段结构一致」，
不是「必须套泛型」。

#### 4.6.2 与 A 档的两处**有意不一致**

1. **路径用复数 + 完整层级**（`/api/airtable/tables/:id/fields`），
   而 A 档（决策 1）是单数资源名（`/api/user`）。因为 airtable 里
   「表下面挂的列」与「一个列本身」是两个不同层级的东西，复数能一眼区分。
2. **`tables/:id/...` 这一层的 `:id` 指的是表格 id**，靠**位置**而不是名字表达语义。
   原因是 relic 的 `PathTrie` 要求同层参数名一致 —— 写 `:tableId` 会在
   **注册阶段**抛 `Conflicting parameter names at the same level`，服务起不来（§6.7）。

#### 4.6.3 业务逻辑位置：`services/airtable/`

改造前 `lib/src/services/airtable/` 是个**空目录**，21 个方法的逻辑全写在
Endpoint 里。S4 全部搬到 `AirtableService`，5 个 typed Endpoint 变成**薄壳**
（只搬运参数），REST 路由与 typed Endpoint **共用同一份实现**。

#### 4.6.4 S4 顺带修掉的既有 bug

| 位置 | 原来的 bug | 影响 |
|---|---|---|
| `updateField` | `field[0].field = fieldName.trim()` —— 赋的是**原值**（应为 `newName`） | 「改字段名」是个**静默空操作**，永远不生效 |
| `updateField` 的重名校验 | 拿 **旧名** `fieldName` 去查重（应为新名） | 「改成另一个已存在的名字」永远拦不住 |
| `searchTableItems` | 在 `AirTableRows` 上写 `where: (t) => t.id.equals(tableId)`（拿 row.id 比 tableId） | `rowIds` 恒空 → 接口**恒返回空页** |
| `getItemRelations` | `tiedItem` 取的是 `item.id`（**它自己**）而不是外键 `item.itemId` | 「关联的单元格」永远指向本行 |

另有两处**签名修正**：`updateField` / `deleteField` 的第一参数从
`String fieldName` 改为 `int id`（既符合 `/fields/:id` 惯例，也修掉了上面的 bug）。
前端 `gi_demo_admin` 完全不引用 airtable（已核对），无兼容成本。

#### 4.6.5 沿用的历史形状（刻意没有"顺手修好"）

* `GET /tables/:id/rows` 返回 **`PageResponse`**（airtable 里唯一这样做的），
  且 typed 的 `keyword` 参数**从未被使用** —— REST 侧干脆不挂这个 query；
* `POST /tables/:id/rows` 成功返回 **`true`**，不是新行 id；
* `POST /rows/delete` 返回 `{'deletedCount': n}`，**一条都没命中时仍是成功信封**，
  所以这条路由用 `countOf` 显式判「不存在」（公共工具，见 `rest_delegate_utils.dart`）。

#### 4.6.6 `tenantId` / `deleted` 补列的迁移与**一处刻意取舍**

迁移 `20260924070853559`：四张表各加 `tenantId bigint NOT NULL DEFAULT 0`、
`deleted boolean NOT NULL DEFAULT false`、一个 `(tenantId, deleted)` 索引；
`air_tables` 的唯一索引从 `(name)` 改成 **`(tenantId, name)`**（不同租户可同名表格）。

> ⚠️ 创建迁移时 Serverpod 报了一条 `Unique index "table_name_unique" is added …
> If there are existing rows with duplicate values, this migration will fail` 的
> 警告，用 `--force` 过了。这条警告在这里是**假警报**：旧索引本来就在 `name` 上唯一，
> 而 `tenantId` 由 `ALTER … DEFAULT 0` 补成全表常量 0，`(0, name)` 唯一 ⟺ `name` 唯一 ——
> 新约束只会更宽松，不可能因重复而失败。

**刻意取舍：删除仍然是物理删 + 级联，没有改成软删。** 读路径确实在按
`deleted = false` 过滤，但那一列现在恒为 false。理由写在
`AirtableService.deleteTable` 的注释里，核心是两条：
① 级联链是「表 → 行 / 字段 → 单元格」，单元格同时挂在行和字段下，四层标记在
同一事务里保持一致很容易漏；
② 改成软删后，**被删掉的表会永久占住 `(tenantId, name)` 的唯一索引**，
用户删掉表格后无法用同名重建（同一类问题在 `sys_menu.permission` 上当过一次）。
要不要整体切软删是一个**独立决策**，切之前要先定唯一索引怎么处理。

## 5. 验证

### 5.1 离线断言（105 条，不需要 DB / 不需要起服务）

| 文件 | 条数 |
|---|---|
| `serverpod_crud/test/rest_crud_route_test.dart` | 34 |
| `flutter_web_server/test/web/api_action_routes_test.dart` | 14 |
| `flutter_web_server/test/web/airtable_action_routes_test.dart` | 17 |
| `flutter_web_server/test/web/rest_delegate_utils_test.dart` | 16 |
| `flutter_web_server/test/web/serverpod_envelope_test.dart` | 14 |
| `flutter_web_server/test/web/api_rest_routes_test.dart` | 10 |

价值 = 把「只在启动期 / 运行期才爆」的坑提前到单测阶段（机理见 §6）：同一挂载点只能挂一次、
OPTIONS 漏注册 → 预检 405 且 CORS 中间件不跑、手搓树里的 `DateTime` 会让 `jsonEncode` 抛 500、
嵌套动作路径被 `:id` 吃掉、同路径多方法写成两条 `addRoute`、`Map` 重复键静默覆盖导致方法凭空 404。

⚠️ 这些断言的**挂载点是测试自己 `injectAt` 的**，不跟随 `registerApiRoutes` 里的真实字符串
→ **改了真实挂载点后它们照样全绿**，必须靠 §5.2 的真实冒烟兜底。

### 5.2 真实 HTTP 冒烟（2026-09-24 通过）

需两层绕沙箱：Bash `dangerouslyDisableSandbox: true` + `--noproxy '*'`。
**改 Route 后必须重启进程**（`run()` 只执行一次，否则跑的是旧路由表）。
脚本按用户要求**不提交**，当时放在 `/tmp/smoke_team_crud.mjs`。

覆盖：`/api/auth` 3 条 + 鉴权边界、A 档 6 资源 × 6 条子路径、B 档动作、负向状态码、
CORS/OPTIONS 预检、`user` 与 `dict*` 的写入全链路（含级联软删）。

回归期望值（**从 DB `count(*)` 取，不要从代码推**）：

| 接口 | 期望 |
|---|---|
| `GET /user/getList` | `total=15`（是 `status=1` 的行数，**不是** `deleted=false` 的 16）、`page=1`、`pageSize=10`、`totalPage=2` |
| `GET /user/getList?deptId=1` | `total=12`（dept1 子树 13 人 − 1 个 `status=0`） |
| `pageSize=999` / `pageSize=0` | 收敛到上限 **100** / 回落默认 **10**（`buildCrudQuery` 的 10/100，不是 `QueryEngine` 的 20/200） |
| `GET /dept/getList` | **树**，45 节点 |
| `GET /menu/getList` | **树**，121 节点 |
| `GET /role/getList` | 11 条、含 `disabled` 注入 |
| `GET /dictCode/getList` / `GET /dictData/getList` | 9 / 24 条（**全表、非分页**，返回裸数组） |
| `POST /role/add` | **404**（`enableCreate:false`，不是 405）、**响应体是空 body 而不是 JSON 信封**（`PathMiss` 在信封层之前就返回了） |
| `GET /system/health` / `GET /system/version` | 是 **GET**（启动横幅那句「健康检查(POST)」是 Serverpod 的通用文案，会误导）、匿名 200 |
| `POST /user/delete` 给多个 id | 失败 `code 40400`（多条要走 `deleteBatch`），HTTP 仍是 **200** |

> `numQueries` 期望（改查询必比）：`user.getUserList` 无 `deptId`=**2**、带 `deptId`=**3**；
> `dept/role/menu.getList`=**1**。看到 4x = 内存建树被回退。
> 两个「看着像回归、其实不是」：`user.getDetail`=3 次（用户 + `sys_user_role` + `sys_role`）、
> `dict.getDictCodeList`=2 次（列表 + 昵称反查）。

🔴 **已知缺陷（冒烟发现，未修）：`POST /api/dictCode/add` 返回 201 但 `data` 里没有 `id`。**
`dict_service.dart:193-195` 插入成功后把**整行**转成了 `DictCodeRequest`（请求 DTO，没有 `id`）
再返回 → `id` / `creator` / `createTime` 全丢，客户端拿不到新 id。
`/api/dictData/add` 正常带 id，只有 dictCode 有这个洞（typed 侧共用同一个 Service，同样如此）。
前端字典弹窗还没接接口（见 §8.3 第 12 条），所以尚未暴露。

✅ **冒烟撞出的另一处缺陷：删部门 / 删菜单不检查子节点 —— 已修**（详见 §8.3 第 14 条）。
当时 `POST /api/dept/delete` 删一个挂 10 个子部门的父级会返回 `200 {"code":20000,"data":true}`，
父节点软删、子节点被建树逻辑**提升成顶级节点**（层级被拉平）。
现在会返回 `业务失败 code 50000`「部门「X」存在下级部门，请先删除下级部门」。
（探针误伤的 `sys_dept.id=1` / `sys_menu.id=1` 当时已用 SQL 还原，API 复核树节点仍是 121 / 45。）
同批补上的两处相邻缺口（`dept` 的「部门下有用户」检查、`menu` 的 `sys_role_menu` 级联）见 §8.3 第 14 条末尾。
⚠️ 本轮改动（状态码口径 `httpStatusFor` + 两条新守卫）**尚未在真实 HTTP 上跑过** —— 需重启 8082 进程，离线断言 109/109 已绿。

### 5.3 审计落库与跨租户过滤（2026-09-24 补验，都通过）

**审计落库 ✅**：`sys_operate_log` 按 `type` = 资源名落行，实测 `user` 的
`create` / `update` / `delete`、`dict_code` 的 `create` / `delete`、`dict_data` 的 `create`
都落了，`bizId` 与操作对象一致。airtable 不落（刻意，见 §8.2 第 4 条）。
旁证：`type = 'query'` 的行**最后一条停在 2026-09-19** —— 正好印证 §2.3 那句
「查询审计插件已不在链路里」。

**跨租户过滤 ✅**：用 `flutter_web_server/lib/src/sql/tenant_1_seed.sql` 造一个
`tenantId = 1` 的账号（`t1.admin` / `asdf1234`）。注意 tenantId 的传递链路是
**`sys_user.tenantId` → JWT 的 `tenantId:<n>` scope → `session.tenantId`**
（`auth_service.dart:45-48` + `serverpod_crud` 的 `SessionExtension`），
所以必须让**登录账号自己**的 `tenantId > 0`，光改别的表没用。

| 接口 | `t1.admin`（tenantId=1） | `admin`（tenantId=0） |
|---|---|---|
| `GET /user/getList` | `total=1`（只有自己） | `total=15` |
| `GET /dept/getList` | 树 **1** 节点 | 树 **45** 节点 |
| `GET /menu/getList` | **0** | 树 **121** 节点 |
| `GET /role/getList` | **0** | **11** 条 |

两边数字不同 → 过滤确实按 `session.tenantId` 收窄了。
⚠️ `/api/dict/options` 是 `@unauthenticatedClientCall`（登录前用、拿不到 session），
**刻意**保留「按入参过滤」，不参与上面这张表。

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

### 6.1.1 同一路径的多种方法，必须合并成**一条**路由

紧跟着 6.1 的一个直接推论，S4 才第一次撞上：

**「`GET /x` 与 `POST /x` 做不同的事」不能写成两次 `addRoute`** —— 那是同一个
挂载点，第二次 `injectAt` 立刻抛 `Conflicting values`。

三种解法，按可读性排序：

1. **`RestActionRoute.byMethod`**（S4 新增，airtable 用的就是这条）——
   一条路由一个路径，`methods` 自动取 `handlers` 的键集合，handler 里按
   `request.method` 分派；
2. 两条路径（`POST /x` 与 `POST /x/create`）—— 项目里已有先例：A 档的
   `/update` / `/delete` 子路径、airtable 的 `POST /rows/delete`；
3. 一个 handler 里自己 `switch (request.method)` —— 能跑，但把「路由表」
   这件声明式的东西写成了命令式，不推荐。

⚠️ **还有一个更阴的变体**：把路由表写成 `Map<String, RestActionRoute>` 时，
同一个路径出现两次键会**静默覆盖**（Dart map 字面量后者赢），结果是一个方法
凭空 404 —— 代码跑得起来、`dart analyze` 只在字面量重复时告警。
`airtableActionRoutes()` 里专门有一条断言兜这个，单测里也有一条从外面再验一遍。

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

### 6.4 Service 的失败只有一个粒度，「不存在 / 不合法」要靠表现层补

`UserService` 里所有失败都返回 `CommonResponse.failed(...)`（code 50000），
「未登录」「用户名已存在」「记录不存在」它**分不出来**。处理方式：

* **未登录**：在基类前置判断，不落到 Service —— 唯一给真实 401 的场景
  （`RestActionRoute(requireAuth:)` / `BaseRestRoute(requireAuth: true)`）；
* **记录不存在**：在 delegate 里先确认基线（`getDetail`），失败即抛
  `RestApiException.notFound` → 业务码 `40400`；公共实现是
  `rest_delegate_utils.dart` 的 `requireFound` / `ensureDeleted`；
* 其余失败走 `ensureOk` → 业务码原样透传 Service 的 `50000`。

⚠️ 这三条**只影响 body 里的 `code`，不影响 HTTP 状态码** —— 后者一律 200（§3.1）。

⚠️ 一个容易漏的分支：**批量删在「一条都没命中」时仍然返回成功**
（data 里 `successCount: 0`），不会 `isFailed` —— 所以单条删除的「不存在」
必须看计数（`ensureDeleted`），不能只看 `isFailed`。

⚠️ **由此产生一处业务码层面的信息损失**：`validateFailed`（入参不合法）与
not-found **共用 `40400`**，客户端只能靠 `message` 区分。
根因是 Service 没有语义化 code，**根治方案是把码下沉到 Service** —— 记在 §8.2 第 7 条。
在那之前，`ensureOk` 的 `code` 透传是「尽可能保留」而不是「能保留」。

### 6.5 `config/development.yaml` 的 `cors:` 只管 API server

```text
OPTIONS 8080/user/getUserList     → 200 + access-control-allow-origin: *
OPTIONS 8082/api/user/<未注册路径> → 404，一个 access-control-* 都没有
```

> S5 实测时第二行写的是 `OPTIONS 8082/api/user/2 → 405`（当时 A 档还挂着 `GET /:id`，
> 路径存在、只是没人注册 OPTIONS）。S6 换掉 `:id` 后该路径变成 404，
> **结论不变**：`cors:` 这段配置对 Web Server 完全无效。

Serverpod 把 CORS 做在 typed API 的处理链上，Web Server 这条链路完全不看
那段配置。必须自己加中间件（`cors_middleware.dart`）。

### 6.6 响应体不能用 `dart:convert` 的 `jsonEncode`

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

### 6.7 嵌套在资源挂载点下的路径，有两条硬约束

动作路由（`/api/user/info`、`/api/role/:id/menus` …）都**嵌在 A 档已被占用的
挂载点下面**，共用同一棵 `PathTrie`。读 `PathTrie` 的实现后有两条必须遵守：

**① 参数名必须沿用 `:id`。** `PathTrie._build` 在走到某个节点时，如果该层已有
参数段、名字却不同，直接抛异常：

```text
ArgumentError: ... Segment no 3: ":roleId" is invalid.
  Conflicting parameter names at the same level: Existing: ":id", New: ":roleId"
```

这是**注册期**抛的 —— 服务根本起不来。而且报错信息（「第 3 段的 `:roleId` 不合法」）
离真正的原因（「和同层另一个参数段撞名了」）很远，很容易查错方向。
→ 所有 `/api/<资源>/...` 的子路径统一用 `:id`，读参数用 `request.pathId()`。

> ⚠️ **S6 之后这条约束的作用域变小了**：A 档 CRUD 的 6 条子路径**全是字面量段**，
> 资源挂载点下已经没有任何 `:id` 参数段（`GET /api/user/5` 现在是 404）。
> 所以撞名只可能发生在**两条动作路由之间** —— 例如 `/api/role/:id/menus` 与
> `/api/role/:roleId/users`。测试里的 `:roleId` 冲突用例已按这个新场景改写。

**② 字面量段优先于参数段。** `PathTrie.lookup` 的匹配顺序是「先字面量、再参数」，
所以 `GET /api/user/info` 命中 `info` 字面节点；同理 A 档的 `/getList`、`/add`
等字面量段也不会被任何参数段抢走。
反过来说，**如果哪天把 `info` 改成 `:tab` 这种参数名，它可能被同层的另一个参数段抢走**，
表现为运行期失败「路径参数必须是正整数」（`code 40400`）——而不是 404，很容易误判成别的问题。

⚠️ 这两条都是「代码看起来完全正常、只在注册时抛异常或真发请求时才出错」的类型，
所以 `api_action_routes_test.dart` 把它们提成了单测：
「字面量段优先于参数段」那组用 `RouterMatch.parameters` **是否为空**判断命中的是字面量
还是 `:id`；参数名冲突那条改成断言**两条动作路由之间**撞名必抛 `ArgumentError`。

> 顺带一条实操结论：`PathTrie.attach` 是**合并**子路由（不是嵌套 router），
> 所以 `/api/role/:id/menu-ids`（两段）与 `/api/role/:id/menus`（两段）不会互相匹配，
> 也不会触发 `Conflicting values` —— 嵌套本身是安全的，问题只在**参数名**上。

### 6.8 团队式路由踩到的四件事

**① 「routed 子路径」不能靠 `analyze` 发现写漏。** `RestActionRoute` 与子路由表里
用的是 `Map<String, Method>`，**重复键会静默覆盖**（后写赢），表现为某个方法凭空 404，
而 `dart analyze` 完全不报。所以离线断言必须**逐条列出方法 + 路径**，不能只断言条数。

**② `enableCreate: false` 的失败码是 404（不是 405）。** 旧版 `POST /` 关掉是
`MethodMiss`（405，路径还在）；现在 `/add` 是独立路由，不注册就是 `PathMiss`（404），
且**响应体是空 body、不经信封**。验收基线里凡是断言 405 的，都要跟着改；
凡是想断言「业务失败」的，别用这一条 —— 它是路由层错误。

**③ `removeBatch` 的返回值不能只抄一半。** `CrudBatchResult` 有 5 个字段
（`total` / `successCount` / `notFoundCount` / `successIds` / `failedIds`）。
delegate 侧若只 `CommonResponse.success({'total':…, 'successCount':…})`，
`successIds` / `failedIds` 会**恒为空数组** —— 前端「N 条不存在」的提示就是这么没的。
5 个 Service 的批量删返回体已统一改为**直接交 `CrudBatchResult`**
（它 `implements SerializableModel`，`toJson()` 会保留全部字段）。

**④ 单条删与批量删刻意分成两个动作。** `POST /delete` 返 `boolean`、
`POST /deleteBatch` 返 `CrudBatchResult`。`extractSingleId` 只接受**恰好一个** id，
给多个直接失败（`code 40400`）提示改用 `/deleteBatch` —— 因为两者返回类型不同，
混成一个「有 id 就单删、有 ids 就批删」的入口会让返回类型摇摆。

### 6.9 业务失败**不要**给真实 4xx —— 前端会把 `message` 丢掉

这是 2026-09-24 拍板「统一到 `200 + code`」（§3.1）的直接起因，也是最容易
「修好了后端、坏了体验」的一处。**任何想把业务失败映射成 400/404 的想法，先读这一节。**

`gi_demo_admin/src/utils/http.ts` 把响应按 **HTTP 状态码**拆进两个拦截器，
**不是**按 body 里的 `code`：

| 分支 | 行 | 行为 |
|---|---|---|
| 成功（HTTP 2xx） | L154-193 | 读 body `code`；非 `200/20000` 时 `Message.error(message)` —— **显示服务端原文** |
| 失败（HTTP 非 2xx） | L194-221 | `Message.error(StatusCodeMessage[status])` —— **完全丢弃 body，从不读 `message`** |

而 `StatusCodeMessage`（L18-33）只有通用文案：`400: '请求错误(400)'`、
`404: '请求出错(404)'`、`500: '服务器错误(500)'`。

所以**只要业务失败走真实 4xx，服务端精心写的 `message`（「昵称不能为空」
「用户不存在或已删除」）就永远到不了用户眼前**，全被替换成 `请求错误(400)`。

实测两套做法在改造前的差别（`ensureOk` 是 `throw RestApiException(400, res.message, code: res.code)`
—— **`code` 原样透传**，所以两条链路的 **body 业务码其实是同一个数**）：

| | HTTP | body `code` | 前端走哪个分支 | 用户看到 |
|---|---|---|---|---|
| `/api/auth/*`（没调 `ensureOk`） | 200 | 50000 | 成功分支 | 「用户不存在」 |
| A 档 CRUD（调了 `ensureOk`） | 400 | 50000 | 失败分支 | 「请求错误(400)」 |

⚠️ **另外两条容易踩的**：

* 前端 L168 有个 `code === 401` 的分支，但 REST 的未登录返的是 `40100` →
  **它永远不命中**；实际靠 L201 的 `status === 401`，那条能工作。所以**未登录
  必须保持真实 401**，压成 `200 + 40100` 会让 refresh token 流程整条失效。
* 404 / 405 若来自**路由未注册**（`PathMiss` / `MethodMiss`），响应体是**空 body**，
  连信封都没有 —— 这类 404 与「业务上的资源不存在」是两回事，别混着断言。

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

> 只列**仍然存在**的。已修 / 已验的（`UserService.delete` 级联、`apispec.json`、团队式路径真实冒烟、
> 审计落库、跨租户过滤）写进 §5 或提交信息，本节不留归档。
>
> ⚠️ **编号在 §8 全节连续，已关闭的条目保留空号**（如第 1 条已于 2026-09-24 关闭，
> 取证搬去了 §6.9）。引用别的章节时请带上「第 N 条」而不是位置。

### 8.1 待决策（要拍板）

1. ~~「业务失败给什么状态码」有两套做法~~ ✅ **2026-09-24 已关闭** ——
   统一到 **`200` + body `code`**（含 401 例外）。决定与理由见 §3.1，
   完整取证（前端拦截器为什么会把 `message` 吞掉）搬到了 **§6.9**，不要再当待办读。
2. **`POST` 的密码必须是密文**（RSA-OAEP + Base64），第三方接入体验差。
   可在 Service 加 `addWithPlainPassword`（内部直接 PBKDF2 哈希），REST 层按来源选择。

### 8.2 刻意搁置（已决定不做，别顺手捡）

3. **airtable 的删除仍是级联物理删**：`deleted` 列已加但没参与删除（§4.6.6），
   读路径按 `deleted = false` 过滤。要切软删得先定「`(tenantId, name)` 唯一索引怎么处理」——
   否则删掉的表格会永久占住名字。**独立决策。**
4. **`AirtableService` 不接审计**：它直接调 `AirTableXxx.db.*`、没走 `BaseService`，
   所以 airtable 的增删改**不落 `sys_operate_log`**（A 档 6 个资源会落）。
   即「airtable 不在审计范围内」，与上一条一起搁置。
5. **Rate limiting / API Key 中间件未加**：官方也把这两项列为 Middleware 的典型用途，
   需要时在同一层加。
6. **role 的 3 处子资源不补**：`/api/role/:id/menus` 只覆盖「保存权限」，
   读单个角色下的**菜单明细**仍要绕 `GET /api/role/:id/menu-ids` + 再查菜单树；
   角色**新增**（typed 本来就没有）也缺位。**前端没用这三处 → 不补。**
7. **Service 语义化 code 未下沉**：把「不存在 → 40400」下沉到 Service 后，Route 就不用靠
   「先查基线」猜「不存在」（§6.4）；同时还能把 `validateFailed` 与 not-found
   从共用的 `40400` 里**拆开**。在那之前，REST 的单条读 / 改 / 删都会**多一次基线查询** ——
   多一次查询换来更准确的 `code`，当前可接受。
   （注：`update` 那次基线查询**无论如何都要** —— PATCH 语义必须拿到旧值补齐，见 §4.2.2。）

### 8.3 其他已知缺口

8. **A 档 6 个资源的 per-resource 逻辑仍是手工活**：`registerCrud` 解决的是「**路由**不手写」，
   不是「**业务**不手写」。6 个 delegate 各 100–200 行，且**没有一个能零覆写**：
   user 5 处特殊逻辑、dept/menu 返树、role 无 add、dict×2 入参类型不一致（§4.2、§10.4）。
9. **`enableCreate: false` 目前只有 role 用**，且它是「不注册路由」而非「注册后 405」→
   响应是 **404**（§4.1）。以后出现「只读资源」这是现成开关。
10. **dictCode / role 的级联是手写的**：删 dictCode 会级联软删该类型下所有 dict_data；
    删 role 会级联 `sys_role_menu` + `sys_user_role` 两张表。跨资源的关联清理 `BaseRestRoute` 盖不住。
11. **airtable 的 `tenantId` 过滤会改变数据量口径**：改造前它**完全不按租户过滤**，
    现在一律按 `session.tenantId`（解析不到就是 0）—— 有租户 > 0 的账号访问时会看到 0 条。
    这是刻意的收紧，只是与改造前不可比（跨租户验证见 §5.2）。
12. **前端 4 个表单弹窗是「模拟保存」，不落库**（**已单独立项，不在本文范围内**）：
    `dict/DictDataFormModal.vue:149`、`dict/DictFormModal.vue:101`、
    `role/RoleFormModal.vue:102`、`menu/MenuFormModal.vue:275` ——
    保存动作是 `setTimeout(300)` + `Message.success('模拟保存成功')`，**完全没调接口**。
    上游模板遗留（不是 REST 化的遗漏），但是真实功能缺口：这几个页面的「新增 / 编辑」点了等于没保存。
13. **前端 `vue-tsc` 有 60 条既有类型错误**（S6 实测 0 新增 / -1，全部来自上游模板，与 REST 化无关）：
    * `dict/LeftDictList.vue` 3 条 `TS2367`、`role/index.vue:403` 1 条 `TS2339`；
    * **契约口径不一致**：全局 `Pagination = { page, size }`（`src/types/global.d.ts`）与部分页面
      实际传的 `{ page, pageSize }` 对不上（`dict/index.vue`、`role/index.vue`）——
      后端两个都认（§4.3），所以运行时没问题，纯粹是类型层没对齐。
14. ✅ **删部门 / 删菜单不检查子节点 —— 2026-09-24 已修**（原记录保留在下面，供回溯）。
    * **原缺陷**：`POST /api/dept/delete` 与 `POST /api/menu/delete` 收了 id 就直接
      `SystemCrudEngines.<x>.deleteBatch(session, ids)`，**没有任何「有没有 children」的前置查询**。
      实测删 `sys_dept.id=1`（其下挂 10 个子部门）返回
      `200 {"code":20000,"message":"删除成功","data":true}`。
    * ⚠️ **症状是「层级被悄悄拉平」，不是「子树消失」**（早先记录写错过，特此更正）：
      子节点的 `parentId` 指向一个已软删、因而查不到的行，而 `getList` 建树走的是
      `!nodeMap.containsKey(parentId) → roots.add(node)`（`dept_service.dart:71`、
      `menu_service.dart:385`）—— **子节点被提升成顶级节点**，前端只看到树变平，一声不响。
    * **修法**（`DeptService.delete` / `MenuService.delete` 各加约 20 行）：
      删之前先按 `parentId inSet(待删 ids)` 查一遍，命中就整体拒绝
      （`CommonResponse.failed('部门「X」存在下级部门，请先删除下级部门')`，业务码 50000、HTTP 200）。
      受影响的是 `POST /delete` 与 `POST /deleteBatch` **两条路由** —— 单条删也走同一个
      `Service.delete([id])`，所以只改 Service 就够了。
    * ⚠️ **两个刻意的判定细节**（都有真实数据验证）：
      ① 走 `findAllByEngine`，所以**其他租户**与**已软删**的下级都不会挡住删除；
      ② **同一批里一起删的子孙不算孤儿** —— `dept/index.vue` 与 `menu/index.vue` 都是
      从 `selectedKeys` 批量删的，「父 + 子一起选中」是合法操作，不能把自己挡住。
      实测：删 `{1}` 挡（10 个下级）、删 `{1..11}` 挡（22 个下级落在集外）、
      删「1 + 全部 45 个子孙」放行、删叶子 `{90001}` / menu `{121}` 放行。
    * ✅ **两处相邻缺口 —— 2026-09-24 一并补上**（同一类引用完整性问题）：
      ① `sys_user.deptId` 指向被删部门 → `DeptService.delete` 再加一道「部门下还有用户」前置检查，
      **整批拒绝**（`'部门「X」下还有 N 个用户，请先移出这些用户'`，业务码 50000、HTTP 200），
      否则用户会从部门树里变得不可达；
      ② `sys_role_menu.menuId` 指向被删菜单 → `MenuService.delete` 在 `deleteBatch` 之后按
      `batch.successIds` 级联软删 `sys_role_menu`（写 `deleted/updater/updateTime`），
      与 `RoleService.delete:365-380` 的先例同构。
    * ⚠️ ② **不是功能性漏洞**（`getMenusByRoleId` / `getRoleIdsByMenuId` 都过滤 `deleted = false`），
      但会留垃圾行、并在「恢复菜单」时变成幽灵授权 ——
      `sys_role_menu_unique (roleId, menuId)` **不含 `deleted`**，软删行会挡住重新插入。
      真实数据核对：`sys_role_menu` 活跃 391 行、既有孤儿 **0** 行、121 个活跃菜单**全部**被至少一个角色引用。
    * ⚠️ ① 的影响面偏大：库里 **13 个部门有 12 个挂着用户**（其中 8 个是「仅 1 个用户」的叶子），
      加检查后这些部门必须先移出用户才能删。这是刻意的；前端不用改 ——
      它靠 2xx 分支读 body `message` 展示（§6.9），服务端文案直达用户。

## 9. 本地验证

```bash
# 1) 起服务（项目用 fvm 3.44.4 = Dart 3.12.2）
cd flutter_web_server
PATH="$HOME/fvm/versions/3.44.4/bin:$PATH" dart run bin/main.dart

# 2) 拿 token（REST 侧）：GET /api/auth/public-key → RSA-OAEP(SHA-256) 加密密码
#    → POST /api/auth/login；种子用户密码统一 asdf1234
#    （⚠️ 业务失败一律 HTTP 200，看 body 的 code —— 见 §3.1）

# 3) 调 REST（子路径是团队式的，注意 /getList）
curl --noproxy '*' -H "Authorization: Bearer $TOKEN" \
  "http://127.0.0.1:8082/api/user/getList?deptId=1&pageSize=3"

# 4) 要验跨租户过滤时：造一个 tenantId=1 的账号（幂等，可重复执行）
docker exec -i development-postgres-1 psql -U postgres -d flutter_web_admin \
  < flutter_web_server/lib/src/sql/tenant_1_seed.sql
# 然后用 t1.admin / asdf1234 登录，期望 user total=1 / dept 1 节点 / menu 0 / role 0（见 §5.3）
```

> 需要发真实请求验证后端时，用 skill **`serverpod-local-api-verify`**（含绕沙箱与
> `--noproxy '*'` 的完整套路）。

⚠️ 新增 / 重命名 Route 后**必须重启进程** —— `run()` 只在启动时执行一次，
`pod.webServer.addRoute(...)` 不会随热重载重跑（这点和「改 Service 方法体自动生效」
不一样）。`registerCrud<T>(...)` / `BaseRestRoute<T>` 同理，因为它们最终都落到
`addRoute`。**同理，改挂载点字符串（如 `/api/user` → `/api/users`）也必须重启才生效。**

⚠️ **从 Agent 会话里起服务别用 `nohup … &`** —— 父进程一被回收，`dartvm` 会变成**孤儿**
继续占着 8080/8081/8082，而 `pgrep -f bin/main.dart` **查不到它**（命令行不一样），
下一次启动就报 `Failed to bind socket, port 8080 may already be in use`。
查真实占用者要用 `lsof -nP -iTCP:8080 -sTCP:LISTEN`，再按 PID 清掉。

## 10. 泛型层（`rest_crud.dart`）的组成与三条硬约束

代码在 `serverpod_crud/lib/src/web/rest_crud.dart`，测试在同包
`test/rest_crud_route_test.dart`（34 条，见 §5.1）。改这个文件前先读本节。

### 10.1 组成

| 类型 | 职责 |
|---|---|
| `RestCrudDelegate<T>` | 一个资源被 REST 化所需的动作（list / detail / create / update / remove / removeBatch）。**协议无关**，这是接缝。⚠️ 实现时用 `extends`：`removeBatch` 有默认实现 |
| `AutoRestCrudDelegate<T, TTable>` | 直接包 `BaseService<T, TTable>` 的标准实现（显式表类型） |
| `AutoCrudDelegate<T>` | **单类型参数**版本，表类型由 `getTableForType(T)` 运行期反查 |
| `BaseRestRoute<T extends TableRow>` | 一次挂载，自动注册整套子路由 + 每个子路径的 OPTIONS。delegate 可省 → **空类体即可用** |
| `RestEnvelopeBuilder` | 信封接缝。CRUD Core 不认识业务项目的 `{code, message, data}`，由业务项目实现；默认 `PlainEnvelopeBuilder` |
| `RestPage<T>` / `restJsonify` | 分页结果与 JSON 归一化（模型 / Map / List / DateTime 混合） |
| `ServerpodRestCrud` | `pod.registerCrud<T>(path)` |

自动产生的路由表（**已用测试断言，不是推测**；S6 团队式）：

```
GET     /getList        列表（分页/过滤走 query）
GET     /getDetail      详情（id 走 query：?id=123）
POST    /add            新增（201）
POST    /update         更新（body 平铺且自带 id，PATCH 语义）
POST    /delete         单条删（body {"id":1}）→ 返回 boolean
POST    /deleteBatch    批量删（body {"ids":[1,2]}）→ 返回 CrudBatchResult
```

**六条子路径全是字面量段**，所以资源挂载点下没有 `:id` 参数段，
`PathTrie` 的「同层参数名一致」约束在这里无从触发（§6.7）。
`enableBatchDelete` 控制第 6 条、`enableCreate` 控制第 3 条，默认都开。
每个子路径都会**单独补一条 `OPTIONS`**（relic 的 CORS 中间件是路由级的，§6.2）。

> S6 之前这里是 8 条原生 REST（`GET /`、`GET /:id`、`PUT|PATCH /:id`、`DELETE /:id`、
> `DELETE /` + 两条 POST 别名）。换掉的动机与收益见 §4.1。

### 10.2 为什么只需要一个类型参数

1. **Dart 不允许通过类型参数访问静态成员** → `T` 不能写 `T.db.find()`，所以本层
   **彻底不碰 ORM**，DB 操作全部交给 delegate。
2. **`TTable` 无法从 `T` 静态推导，但也不必推导** —— 可以直接填**裸 `Table`**。

第 2 点的依据（读源码 + 编译验证确认）：

| 事实 | 位置 |
|---|---|
| `Table` 是 `Table<T_ID>` 泛型类，`id` 类型是 `ColumnComparable<T_ID>` 而非 `ColumnInt` | `serverpod_database/src/concepts/table.dart:50,68` |
| 生成的表类（如 `SysUserTable extends Table<int?>`）因**协变**而 `is Table` 成立 | Dart 语言规则 |
| 取列是**反射式**的：`_crudFindColumn` 遍历 `table.columns` 按 `fieldName`/`columnName` 匹配 | `base_service.dart:14-25` |
| 取表也是运行期：`serializationManager.getTableForType(T)` | `base_service.dart:197` |
| `TableRow<T_ID>` 只有 3 个成员（`id` / `table` / `toJson`） | `table.dart:9-18` |

顺带确认：`deserialize<T>(body, T)` **接受浏览器发来的普通 JSON**（命中生成的
`T.fromJson`），只有 `deserializeDynamicFieldValue` 才要求「每个字段值再包一层
`{className, data}`」的线格式（见 §6.3）。所以自动 delegate 不需要客户端做额外包装。

### 10.3 自动装配为什么是 lazy 的

`BaseRestRoute` 的默认 delegate 用 `late final` 延迟到**首次请求**才装配。
原因：路由注册发生在 `pod.start()` **之前**，那时 `Serverpod.instance` 虽已就绪，
但数据库尚未连接，而 `CrudEntityMeta.auto()` 会立刻去读 `SerializationManager`
和表列信息。推到首次请求最稳。

### 10.4 为什么必须留 `RestCrudDelegate` 这一层（通用化的边界）

不是「设计得不够好」——是**现有 Service 有四类结构性不一致**：实例 vs 静态、
单条删 vs 批量删、列表返回树 / 分页 / 全表三种、每家一个专用 Request 模型。
所以 `create` / `update` 刻意收 `Map<String, dynamic> body` 而不是模型，
把「怎么变成模型」的自由度留给 delegate。

`BaseRestRoute<T>` 是**模板方法**，不是零覆写：默认全自动，需要时覆写单个 hook。
6 个 A 档资源各自兜不住什么，逐条列在 §8.3 第 8 条。

