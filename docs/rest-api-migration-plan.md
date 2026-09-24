# 后端接口全面 REST 化 + CRUD 自动产生（方案 v2）

> 分支：`feature/web-server-rest-api` ｜ 2026-09-23
> v1 把重点放在「关掉 8080」上，**方向偏了**。本版按修正后的目标重写。

---

## 0. 目标（修正后）

1. **所有接口代码改用 Serverpod 的 REST Route 实现**（`/api/**`）
2. **CRUD 由框架自动产生**，不再手写 —— 这是本方案的核心诉求
3. **前端等后端重构完成后再动手**，届时放弃为兼容后端而生的那套调用方式

**明确不在目标内**：关闭 8080。`apiServer` 在 Serverpod 4 里关不掉（`features.dart` 没有
`enableApiServer`），**但也不需要关** —— 它不是负担，只是另一个入口。

> 换句话说：这是一次**后端接口实现方式的重构**，不是一次部署形态的调整。

---

## 1. 现状盘点（方案的事实基础）

### 1.1 接口全清单：15 个 Endpoint，78 个公开方法

| Endpoint | 路径前缀 | 继承 | 方法数 |
|---|---|---|---|
| `SystemEndpoint` | `system` | `Endpoint` | 2 |
| `AuthEndpoint` | `auth` | `Endpoint` | 3 |
| `UserEndpoint` | `user` | **`BaseEndpoint<SysUser, SysUserTable>`** | 7 |
| `DeptEndpoint` | `dept` | `Endpoint` | 5 |
| `RoleEndpoint` | `role` | `Endpoint` | 8 |
| `MenuEndpoint` | `menu` | `Endpoint` | 6 |
| `DictEndpoint` | `system/dict` | `Endpoint` | 11 |
| `ProductEndpoint` | `product` | **`BaseEndpoint<Book, BookTable>`** ⚠️ | 2 |
| `BookEndpoint` | `book` | `Endpoint` | 5 |
| `TablesEndpoint` | airtable | `Endpoint` | 6 |
| `AirTableFieldsEndpoint` | airtable | `Endpoint` | 4 |
| `TableRowsEndpoint` | airtable | `Endpoint` | 5 |
| `TableItemsEndpoint` | airtable | `Endpoint` | 2 |
| `TableItemRelationsEndpoint` | airtable | `Endpoint` | 4 |

⚠️ `ProductEndpoint extends BaseEndpoint<Book, BookTable>` —— **类型参数是 `Book`，不是 `Product`**，
显然是复制粘贴留下的。这类问题在重构时会一并暴露。

### 1.2 按「能否自动产生 CRUD」分三档

**A 档 · 标准 CRUD 资源（6 个）—— `registerCrud` 的受益者**

| 资源 | 模型 | 现状特殊点 |
|---|---|---|
| 用户 | `SysUser` | 5 处特殊逻辑（见 §3.2） |
| 部门 | `SysDept` | 列表返回**树**；批量删 |
| 角色 | `SysRole` | **没有 add**；批量删；权限关联表 |
| 菜单 | `SysMenu` | **没有 `tenantId` 列**；批量删；返回树 |
| 字典类型 | `SysDictCode` | 与 dictData 挤在同一个 Endpoint |
| 字典数据 | `SysDictData` | 同上；`update` 与 `add` 的入参类型还不一致 |

**B 档 · 业务动作接口（12 个）—— 本来就是手写，REST 化只是换表现层**

`auth`: login / publicKey / refreshToken
`user`: getUserInfo / getUserRoutes / resetPassword
`role`: getRoleMenuIds / saveRolePermissions / getRoleUsers / cancelUserRoles
`menu`: getMenuOptions
`dict`: getDictData / getDictDataDetail
`system`: health / version

**C 档 · 子系统与示例（不套 CRUD）**

- `airtable/*`（4 个 Endpoint，17 个方法）：是「表格 / 行列 / 关系」的低代码子系统，
  `upsertItem`、`searchTableItems`、`getTableRelations` 都不是单表 CRUD，**不要硬套**
- `book`（5 个方法）：Serverpod 示例代码
- `product`（2 个方法）：半成品，只有 `getDetail` / `getPriceList`

### 1.3 前端真正在调的接口（决定优先级）

扫了 `gi_demo_admin/src/apis/**` 的全部 `http.*` 调用：

```
user   → POST /auth/login  POST /auth/refreshToken  GET /user/getUserInfo  GET /user/getUserRoutes
system → POST /user/userUpdate  POST /user/getUserList  POST /user/resetPassword  POST /user/userAdd ⚠️
         POST /role/getRoleMenuIds  POST /role/getRoleUsers  POST /role/cancelUserRoles
         POST /role/saveRolePermissions
         GET  /menu/getMenuOptions
         GET  /system/dict/getDictData  GET /system/dict/getDictDataList  GET /system/dict/getDictDataDetail
area / cate / file / test → 调的是 /area/*, /cate/*, /file/*, /test/*, /v1/base/logout
```

两点结论：
1. **真正的迁移范围只有 `system` + `user` 两个模块**，front-end 没有在用 dept / menu 的 CRUD、也没有用 airtable
2. `area` / `cate` / `file` / `test` / `/v1/base/logout` 这些路径**在后端没有任何对应 Endpoint** ——
   是 gi-demo 上游模板的遗留代码，需确认是否还能删
3. ⚠️ `POST /user/userAdd` 也不存在（后端只有 `add`）→ 该调用可能已经是坏的

### 1.4 要退役的东西（用户明确点名的「为兼容而生的方式」）

| 目标 | 位置 | 为什么退役 |
|---|---|---|
| `addByJsonParams` / `updateByJsonParams` | `endpoints/system/base_endpoint.dart:162/275` | 纯粹是为「`dynamic` 形参收不了普通 JSON」打的补丁；REST 层用 `jsonObjectBody()` 后不需要 |
| `endpoints/system/base_endpoint.dart`（业务版） | 同上 | 与 `serverpod_crud` 的 `BaseCrudEndpoint` **两套基类并存**，混用会运行时崩且 `dart analyze` 抓不到 |
| `UserEndpoint extends BaseEndpoint` | `user_endpoint.dart:9` | 退回裸 `Endpoint`，业务方法改由 REST Route + Service 承担 |
| 前端的 `{ params: JSON.stringify(...) }` 调用形态 | `gi_demo_admin/src/apis/base.ts` | 等后端完成后再改 |

---

## 2. REST 层能力（S0）—— ✅ 已完成 2026-09-23

原有的 `RestCrudDelegate` 缺两个能力，不补的话 A 档有 4 个资源落不下去。
**两项都已补上并测试通过**（`serverpod_crud`，17 个断言全绿）：

| # | 缺口 | 状态 |
|---|---|---|
| 1 | `list` 只能返回 `RestPage<T>`，盖不住**返回树的**部门 / 菜单 | ✅ 改成返回 `Object?`：是 `RestPage` 走分页信封，否则走普通成功信封 |
| 2 | 没有批量删除，而 **6 个 A 档资源里 4 个是批量删** | ✅ 加 `removeBatch`（默认实现逐个删，子类可覆写成一次 `deleteBatch`） |
| 3 | 信封还没接上项目 | ⏳ 待做：`ServerpodEnvelopeBuilder`（`{code, message, data}` + `JsonCleaner`），在 P1 收口时一起做 |
| 4 | 「项目只用 GET/POST」的习惯 | ✅ 加 `POST /update`、`POST /delete` 兼容形式（`enablePostAliases`，默认开） |

批量删形态按你的决策定成 `DELETE /` + body `{"ids":[…]}`，同时提供
`POST /delete`（body 给 `id` 删单条、给 `ids` 删多条）。

### 2.1 这一层最终长成什么样

```dart
class UserRestRoute extends BaseRestRoute<SysUser> {}   // 空类体
// 或
pod.registerCrud<SysUser>('/api/user');                 // 一行
```

自动产出 8 条路由（用户点名的 5 条 + 批量删 + 两条 POST 兼容形式）：

```
GET     /               列表                GET   /:id           详情
POST    /               新增（201）         PUT|PATCH /:id       更新
DELETE  /:id            删除                DELETE /             批量删除
POST    /update         更新（POST 兼容）   POST  /delete        删除（POST 兼容）
```

**单类型参数**能成立的依据：`Table` 是 `Table<T_ID>` 泛型类，而
`serverpod_crud` 取列 / 取表**都是反射式的**（`_crudFindColumn` 遍历
`table.columns`；`getTableForType(T)`），不依赖静态类型 —— 所以 `TTable`
可以直接填裸 `Table`，运行期反查。

已用**真实模型**验证编译通过：
`flutter_web_server/lib/src/web/routes/api/user_rest_route.dart`
（目前只做编译证明、未注册）。

---

## 3. 「自动产生 CRUD」的真实边界（**这一段最需要你先看**）

### 3.1 能自动产生的部分

用 `pod.registerCrud<T>(path, delegate)` 或 `pod.registerAutoCrud<T, TTable>(path)`，
**5 条路由零手写**：

```
GET  /            GET  /:id         POST /          PUT|PATCH /:id      DELETE /:id        DELETE /
```

省掉的是：5 个 Route 类的样板、query/path/body 解析、HTTP 语义映射（201/400/401/404/500）、
OPTIONS 预检注册、CORS 头。这部分是**真收益**，已经在 `users` 上验证过（typed 与 REST 逐字节一致）。

### 3.2 不能自动产生的部分 —— 每个资源仍要写一个 delegate

这不是设计缺陷，是业务本身的差异。以 6 个 A 档资源为例：

| 资源 | 能否 `registerAutoCrud` 零覆写 | 阻塞点 |
|---|---|---|
| 用户 | ❌ | ① 列表注入 `disabled` ② `deptId` 展开子树 ③ 9 个专用过滤字段 ④ `password` 必须 RSA 密文 ⑤ `roleIds` 在关联表 `sys_user_role` |
| 部门 | ❌ | ① 列表返回**树** ② 批量删 ③ 入参是 `DeptRequest`（带业务字段） |
| 角色 | ❌ | ① **没有 add** ② 批量删 ③ 权限在 `sys_role_menu` 关联表 ④ 更新直接收 `SysRole` |
| 菜单 | ❌ ❌ | ① **表里没有 `tenantId` 列** —— `registerAutoCrud` 会直接抛 `ArgumentError`（已核实：`base_service.dart:27-40` 的 `_crudFindIntColumn` 找不到列就抛） ② 列表返回树 ③ 批量删 |
| 字典类型 | ⚠️ 待验证 | 关联到 `sys_dict_data`，且与 dictData 挤在一个 Endpoint |
| 字典数据 | ⚠️ 待验证 | `add` 收 `DictDataRequest`、`update` 收 `SysDictData`，**两者类型不一致** |

**结论（诚实的版本）**：
> 「自动产生 CRUD」在本项目能达到的程度是 **「5 条路由 + HTTP 语义全自动，数据映射按资源写一个 delegate」**。
> 纯零覆写只对**新建的、单表的、无关联的**资源成立。
> 这个收益依然很大 —— 但如果你期待的是「一个资源 = 一个空类」，那要先把 Service 层收敛到
> `BaseService<T, TTable>`（见 §6 决策 4），而那是另一次独立重构。

---

## 4. 目标形态

```
Vue 后台 ──┐
Webhook ───┼── REST /api/**  →  BaseRestRoute<T>  ──┐
第三方 ────┘                      （5 条路由自动产生） │
                                                     ├→ services/system/*_service.dart → ORM → PostgreSQL
Flutter（可选）── typed /api 8080 → Endpoint ────────┘
```

**A 档资源**：一行 `registerCrud` + 一个 delegate
**B 档业务动作**：一个薄 Route（本来就没有可自动化的规律）
**C 档 airtable**：单独设计，不套 CRUD

---

## 5. 分阶段实施

| 阶段 | 内容 | 验收 |
|---|---|---|
| **S0** 补 REST 层能力 | ✅ **已完成**：`list` 支持非分页载荷、`removeBatch`、POST 兼容形式、`BaseRestRoute<T>` 单类型参数（空类体可用）。⏳ 剩 `ServerpodEnvelopeBuilder` + 两套基类收口，并入 P1 | `dart analyze` 干净 + **17 个单测全绿** |
| **S1** 认证 REST 化 | `POST /api/auth/login`、`GET /api/auth/public-key`、`POST /api/auth/refresh-token`，复用 `AuthService`，`requireAuth: false` | 用 curl 能登录拿 token；与 typed `/auth/login` 返回逐字节一致 |
| **S1.5** 信封收口 + 两套基类合一 | 加 `ServerpodEnvelopeBuilder`；`api_route.dart` 的 5 个手写 Route 改继承 `serverpod_crud` 的基类 | `GET /api/user` 与现状逐字节一致 |
| **S2** A 档 6 个资源的 CRUD | 顺序建议 `dict-data → dict-code → menu → dept → role → user`（按特殊逻辑从少到多） | 每个资源：typed 与 REST **逐字段一致**（回归方法见 §7） |
| **S3** B 档业务动作 | 12 个接口手写薄 Route；⚠️ 路径要重新设计成扁平资源 URL（现有 `/system/dict/getDictDataList` 这种是 Endpoint 名拼出来的，不该带进 REST） | 同上 |
| **S4** C 档 airtable | 单独设计资源模型（表 / 字段 / 行 / 关联），不套 `registerCrud` | 逐接口对比 |
| **S5** 退役 + 收尾 | 删 `addByJsonParams` / `updateByJsonParams`；`UserEndpoint` / `ProductEndpoint` 退回裸 `Endpoint`；清理无人调用的 typed 方法 | 前端能跑通（前端改造在此阶段开始时并行） |

⚠️ 每阶段都要重启进程后才能验证（`run()` 只在启动时执行一次，`addRoute` 不随热重载重跑）。

---

## 6. 决策记录（2026-09-23 已定）

| # | 决策 | **已定** | 说明 |
|---|---|---|---|
| 1 | URL 命名 | **沿用** 现有资源名 | 即 `/api/user`、`/api/dept`…（**单数**，与 typed Endpoint 名一致）。⚠️ 已核查：早期手写 Route 曾误用复数 `/api/users`，2026-09-23 已连同文档统一改回单数。路径由 `registerCrud` 的调用方传，实现上无约束 |
| 2 | 批量删形态 | **走 POST**（项目基本上只用 GET、POST） | 定成 `POST /delete`（body 给 `id` 删单条、给 `ids` 删多条）；标准的 `DELETE /` 一并保留 |
| 3 | A 档 6 个资源 | **全做** | 即使 dept/menu 的 CRUD 现在前端没在用，也一并 REST 化 |
| 4 | Service 层 | **先收敛到 `BaseService<T, TTable>`** | 这是最大的一项：把 6 个（乃至 9 个）业务 Service 收敛成统一的 `BaseService<T, TTable>`，之后 `registerAutoCrud` 才可能接近零覆写。见下方 §6.1 |
| 5 | airtable | **最后再改** | 先做 system 模块，airtable 排到 S4 |

### 6.1 关于决策 4（先收敛 `BaseService<T, TTable>`）要提前说清的两件事

**(a) 收敛的粒度**。`BaseService<T, TTable>` 已经存在且能力完整
（`create` / `update` / `delete` / `deleteBatch` / `get` / `getList`，含多租户、
软删、审计、校验、插件），业务 Service 只是**没继承它**。收敛的做法是让
`UserService` 等改成 `extends BaseService<...>` 或组合它，把现有手写逻辑搬到
钩子里（`beforeCreate` / `beforeUpdate` / 覆写 `getList`）。

**(b) 收敛 ≠ 零覆写**。即使 Service 统一了，下面这些仍然要按资源写：

| 资源 | 统一 Service 之后仍无法自动化的部分 |
|---|---|
| 用户 | `disabled` 注入、`deptId` 子树、9 个专用过滤字段、RSA 密码、`roleIds` 关联表 |
| 部门 | 列表返回**树**（`getList` 必须覆写） |
| 角色 | **没有 add**（要么补上要么不暴露 POST）、权限关联表 |
| 菜单 | **表里没有 `tenantId` 列** → `BaseService` 的 `tenantIdColumn` 会 `ArgumentError`，需要绕过租户隔离 |
| 字典×2 | `add` 与 `update` 的入参类型不一致 |

**(c) 顺序建议**：收敛是一项**可独立验证**的重构（typed 侧行为不变），
建议**先做用户 + 字典这两个**，跑通后再推其余 —— 不要一次动 9 个 Service。
菜单的 `tenantId` 缺列问题需要在收敛前先定方案（改表加列 / 或让
`BaseService` 支持「无租户列」模式）。

---

## 7. 回归验收方法（已在 users 上验证过）

「同一资源，typed 与 REST 逐字节一致」是本次重构最可靠的护栏：

```bash
TOKEN=$(...登录拿 token...)

curl -s --noproxy '*' -X POST http://127.0.0.1:8080/user/getUserList \
  -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" \
  -d '{"query":{"deptId":1,"pageSize":3}}' -o /tmp/typed.json

curl -s --noproxy '*' "http://127.0.0.1:8082/api/user?deptId=1&pageSize=3" \
  -H "Authorization: Bearer $TOKEN" -o /tmp/rest.json

node -e "
const a=JSON.parse(require('fs').readFileSync('/tmp/typed.json','utf8'));
const b=JSON.parse(require('fs').readFileSync('/tmp/rest.json','utf8'));
console.log('字段集一致 =', Object.keys(a.data[0]).sort().join()===Object.keys(b.data[0]).sort().join());
console.log('首行逐字节一致 =', JSON.stringify(a.data[0])===JSON.stringify(b.data[0]));
console.log('total 一致 =', a.total===b.total);
"
```

---

## 8. 风险清单

| # | 风险 | 说明 | 处置 |
|---|---|---|---|
| 1 | **同一挂载点只能挂一次** | relic `PathTrie` 注入第二个 handler 抛 `Conflicting values` | 必须走 `BaseRestRoute` 的「一次挂载 + N 条子路由」结构 |
| 2 | **relic 中间件是路由级的** | OPTIONS 未注册路由会在匹配阶段 405，中间件不跑 → CORS 头加不上 | `BaseRestRoute.injectIn` 已给每个子路径补注册 OPTIONS |
| 3 | **两套 REST 基类并存** | `api_route.dart` 与 `rest_crud.dart`，混用会运行时崩且 `dart analyze` 抓不到 | S0 收口 |
| 4 | **公开方法即路由** | Endpoint 子类的公开方法自动成为 HTTP 路由；加辅助逻辑必须下划线私有 | S5 清理时注意，删方法=删路由 |
| 5 | **`sys_menu` 没有 `tenantId`** | `registerAutoCrud` 会在构造期抛 `ArgumentError` | menu 必须走自定义 delegate |
| 6 | **`update` 整行覆盖陷阱** | merge 基线要用 `toJson()`（含 `serverOnly`），用 `toJsonForProtocol()` 会把 `password` 清空 | 已固化在 `AutoRestCrudDelegate.update` |
| 7 | **新增 Route 必须重启** | 与 Service 热重载行为不同 | 写进每阶段验收清单 |
| 8 | **`Features.enableWebServer()` 反向陷阱** | `!server.hasApp` 时 webServer **根本不启动**（不是 404）；调试时把路由全注释掉会让 REST 层消失 | 别把路由全注释掉 |
| 9 | 现存 CORS 配置 bug | `config/development.yaml` 的 `origin: '*'` + `credentials: true` 互斥（只管 8080） | 前端改造阶段一起修 |

---

## 9. 与其它文档的关系

- `docs/rest-api-layer.md` —— REST 层的**当前形态与实现细节**（§1–§9：分层 / 对外契约 /
  接口清单 / 踩坑实测 / CORS / 待办；§10：泛型层的设计依据）
- 本文 —— **重构路线**（做什么、按什么顺序、边界在哪）
