# 后端接口全面 REST 化 + CRUD 自动产生（方案 v2）

> 分支：`feature/web-server-rest-api` ｜ 2026-09-23 起草，2026-09-24 更新
> v1 把重点放在「关掉 8080」上，**方向偏了**。本版按修正后的目标重写。

**当前进度**：✅ S0 REST 层能力 ｜ ✅ S0.5 决策 4 Service 收敛（6 个 A 档资源，2026-09-24，22 条回归断言全绿）
｜ 🟡 **S1 认证 REST 化（代码已实现、`dart analyze` 全项目干净；HTTP 冒烟待服务启动后补跑）**
｜ ⏳ 之后进 S1.5 信封收口。

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
| 菜单 | `SysMenu` | ~~**没有 `tenantId` 列**~~ → ✅ 已加列；批量删；返回树 |
| 字典类型 | `SysDictCode` | 与 dictData 挤在同一个 Endpoint |
| 字典数据 | `SysDictData` | 同上；`update` 与 `add` 的入参类型还不一致 |

> ✅ **6 个 A 档资源的 Service 收敛已于 2026-09-24 完成**（决策 4），见 §6.2。

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
| 菜单 | ❌（租户阻塞已解除，其余仍在） | ~~① **表里没有 `tenantId` 列**~~ → ✅ 2026-09-24 已加列，`registerAutoCrud` 不再抛 `ArgumentError`（`base_service.dart:27-40` 的 `_crudFindIntColumn` 现已能找到列）② 列表返回树 ③ 批量删 |
| 字典类型 | ⚠️ 待验证 | 关联到 `sys_dict_data`，且与 dictData 挤在一个 Endpoint |
| 字典数据 | ⚠️ 待验证 | `add` 收 `DictDataRequest`、`update` 收 `SysDictData`，**两者类型不一致** |

**结论（诚实的版本）**：
> 「自动产生 CRUD」在本项目能达到的程度是 **「5 条路由 + HTTP 语义全自动，数据映射按资源写一个 delegate」**。
> 纯零覆写只对**新建的、单表的、无关联的**资源成立。
> 这个收益依然很大 —— 但如果你期待的是「一个资源 = 一个空类」，那要先把 Service 层收敛到
> `BaseService<T, TTable>`（见 §6 决策 4）。
>
> ✅ **收敛已于 2026-09-24 完成**（§6.2）。上面那张表的③④⑤这类「业务特有的查询/映射」
> 仍然要写在 delegate 里 —— 收敛解决的是**租户隔离/软删/审计/分页这层骨架的重复**，
> 不是消除业务差异。这符合 §3.2 的结论，没有意外。

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
| **S0.5** 决策 4：Service 收敛 | ✅ **已完成 2026-09-24**：新增 `services/system/crud_engines.dart`，6 个 A 档资源（user/dept/role/menu/dictCode/dictData）的 Service 内部改走 `BaseService<T,TTable>`，**对外签名零改动**。含 `sys_menu` 加 `tenantId` 列迁移 | `dart analyze` 全项目干净 + **6 个资源 22 条 typed 回归断言全绿**（见 §7.1） |
| **S1** 认证 REST 化 | 🟡 **代码已完成 2026-09-24**：新增 `auth_api_routes.dart`（`GET /api/auth/public-key`、`POST /api/auth/login`、`POST /api/auth/refresh-token`，复用 `AuthService`，三条**全部** `requireAuth: false`）+ `api_routes.dart` 一行挂载 `/api/auth`。⏳ 剩 HTTP 冒烟 | `dart analyze` 全项目干净；⏳ 用 curl 能登录拿 token，且与 typed `/auth/login` 返回逐字节一致 |
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

### 6.1 关于决策 4（先收敛 `BaseService<T, TTable>`）

> **✅ 已于 2026-09-24 执行完毕**，实况见 §6.2。下面保留当初的推演，用来对照「预判 vs 实际」。

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
| 菜单 | ~~**表里没有 `tenantId` 列**~~ → ✅ 2026-09-24 **已给表加列**（见 §6.2），不再是障碍 |
| 字典×2 | `add` 与 `update` 的入参类型不一致 |

**(c) 顺序建议（已被推翻）**：原本建议「先做用户 + 字典这两个」。实际执行时
用户拍板**6 个 A 档资源一次做完** —— 因为 6 个资源的收敛点是同一批模式
（`find` → 引擎查询、`get` → `BaseService.get`、`update` → `BaseService.update`、
`delete` → `deleteBatch`），拆开做反而要反复回到同一批文件里。

### 6.2 决策 4 的执行实况（2026-09-24）

**做法：保签名、换引擎。** 对外的方法名 / 入参模型 / 返回类型**一个都不动**
（typed 侧要活到 S5 退役），只把 Service 内部的 `SysXxx.db.*` 换成
`BaseService<T,TTable>`。这样「typed 侧行为不变」可以被独立验证。

落地物：
- `flutter_web_server/lib/src/services/system/crud_engines.dart`（新增）
  —— 6 个 lazy 引擎入口 `SystemCrudEngines.{user,dept,role,menu,dictCode,dictData}`
  + 8 个适配 helper（`buildCrudQuery` / `findAllByEngine` / `condEq|condLike|condIn|condBetween` /
  `sortAsc|sortDesc` / `crudPageResponse` / `crudFailure`）。
- 6 个 Service 收敛：`user_service` / `dept_service` / `role_service` / `menu_service` / `dict_service`（含 dictCode + dictData 两个资源）。
- 迁移 `20260924011107788`：`ALTER TABLE "sys_menu" ADD COLUMN "tenantId" bigint NOT NULL DEFAULT 0;`（非破坏性）。

**执行中发现的 5 类行为变更**（回归时必须盯，全部已在代码注释里标 ⚠️）：

| # | 变更 | 影响 |
|---|---|---|
| 1 | **租户过滤变严** | 旧实现基本只在入参给了 `tenantId` 时才拼条件（单条 `findFirstRow` 更是一个租户条件都没有）；引擎一律按 `session.tenantId`。方向更正确，但要比对 `total`。⚠️ `dict.getDictData` 是 `@unauthenticatedClientCall`（登录前要用、拿不到 session），**刻意保留**按入参过滤 |
| 2 | **`delete` 必须两步走** | `BaseService.delete` 只收 `id`、拿不到实体，**不维护** `updater`/`updateTime`；且 `CrudService.update` 里有 `setDeleted(data, false)` → 用户删除必须先 `update()` 落审计字段、再 `delete()` 软删，**顺序不可颠倒** |
| 3 | **`deleteBatch` 同样不维护审计字段** | 原 role/dept 的批量删会写 `updater`/`updateTime`，收敛后不写了 |
| 4 | **`QueryEngine` 在 `sort` 为空时不排序** | 旧实现都有 `orderByList`，收敛时必须显式传 `sortAsc('id')`，否则分页结果顺序不确定 |
| 5 | **`QueryEngine` 的 `safePageSize` 是 200/20，旧代码是 100/10** | 由 `buildCrudQuery(defaultPageSize: 10, maxPageSize: 100)` 先收敛，否则上限被放大 |

**两个语法/运行时陷阱**（`dart analyze` 抓不到，只能靠真跑）：
- `BaseEntityService` 虽**无抽象成员**但被声明成 `abstract` → 必须写 6 个具体子类才能实例化。
- `EntityDescriptor.fromServerpod()` 会读 `Serverpod.instance.serializationManager`
  → 引擎**必须 lazy**（`??=` getter），写成 `static final` 会类加载即崩。

**全表 vs 分页的语义陷阱**：role / dept / menu / dict 的列表接口历来返回**全表**，
不能套 `BaseService.getList`（分页语义，会悄悄截断）→ 为此新增 `findAllByEngine`。

### 6.3 `sys_menu` 唯一约束改为按租户（2026-09-24 追加）

**诉求**：不同租户可以各自拥有同名菜单 / 同一个 permission 标识。

**改动**（迁移 `20260924020103589`，纯索引 DDL、非破坏性）：

```sql
DROP INDEX "sys_menu_title_parent_unique";
DROP INDEX "sys_menu_permission_unique";
DROP INDEX "sys_menu_parent_sort_idx";
CREATE UNIQUE INDEX "sys_menu_title_parent_unique" ON "sys_menu" USING btree ("tenantId", "title", "parentId");
CREATE UNIQUE INDEX "sys_menu_permission_unique"    ON "sys_menu" USING btree ("tenantId", "permission");
CREATE INDEX        "sys_menu_parent_sort_idx"      ON "sys_menu" USING btree ("tenantId", "parentId", "sort");
```

为什么 `permission` 也必须带上 `tenantId`：现网 121 行**每行都有各自唯一的 permission**
（连目录类也带 `menu:dashboard` 这种），所以另一个租户想复制同一套菜单树时，
**每一个 permission 都会撞**。只改 `title+parentId` 是不够的。

**为什么不需要改 Dart 代码**：`MenuService` 里**没有任何重名/重码预校验**（查重完全依赖 DB 唯一索引），
所以约束一改，能力自动就有了。租户归属由 `BaseService.create` → `CrudService.create` 按
`session.tenantId` 打标（`base_service.dart:566` 的 `_defaultResolveTenantId`：优先
`session.targetTenantId`，否则 `session.tenantId`；而 `session.tenantId` 来自 JWT scope
`tenantId:<id>`，由 `auth_service.dart` 在 `user.tenantId > 0` 时签发）。

**验证**（事务内试插后 `ROLLBACK`，未改数据）：

| 用例 | 结果 |
|---|---|
| 租户 1 插入与租户 0 **完全同名同 permission** 的菜单 | ✅ 成功（功能生效） |
| 租户 0 再插一次同名同 permission | ✅ 仍被 `sys_menu_title_parent_unique` 拦住 |
| 租户 1 插同 permission、不同 title | ✅ 成功（两个约束相互独立） |

**仍未处理的边界**：`permission` 的模型默认值是 `''`，而 `(tenantId, permission)` 里 `''` 是**真实值不是 NULL**
→ 同一租户内**只能有一个不填 permission 的菜单**（这是既有行为，改前更严：全表只能有一个）。
若日后要放开，得改成**部分唯一索引** `WHERE permission <> ''`（注意 Serverpod 的 `indexes:`
声明式语法不一定支持 `WHERE`，可能需要手写迁移 SQL）。另外唯一约束**不含 `deleted`**
→ 软删的行依旧占着 title / permission 名额。

**回滚**（把三行 `CREATE ... INDEX` 的列顺序换回旧值，并把 `serverpod_migrations` 的
`flutter_web` 版本改回 `20260924011107788`）。⚠️ 回滚前必须先清掉跨租户的同名/同 permission 数据，
否则重建全局唯一索引会失败。

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

### 7.1 决策 4 收敛的回归实测（2026-09-24）

收敛这一步「typed 侧行为不变」，所以先用**单侧基线**验证（还没到 S2 的 typed↔REST 对比）：

- 方式：`POST /<endpoint>/<method>` + Bearer token（登录密码 `asdf1234`），
  连本地 8080 真实发请求，用 DB 侧 count 做期望值。
- 结果：**22 条断言全绿**。覆盖 6 个资源的 list / detail，外加分页边界与顺序。

关键期望值与实测（DB 现网：user 16 行但 **status=1 只有 15 行**，dept 45，role 11，menu 121，dict_code 9，dict_data 24）：

| 接口 | 期望 | 实测 |
|---|---|---|
| `user.getUserList` 无 deptId | total=15、page=1、pageSize=10、totalPage=2、id 升序 | ✅ |
| `user.getUserList` deptId=1 | total=12（dept 1 子树含 13 人，其中 1 人 status=0） | ✅ |
| `user.getUserList` 第 2 页 | 5 条，ids=11,12,13,14,17 | ✅ |
| `user.getUserList` pageSize=999 / =0 | 收敛到 100 / 默认 10 | ✅ |
| `user.getDetail` id=1 | 含 `roleIds`/`roles`，**不含** `password` | ✅ |
| `dept.getList` | 树 45 节点、确有 children | ✅ |
| `role.getList` | 11 条、含 `disabled`、`sort ASC, id ASC` | ✅ |
| `menu.getList` | 树 121 节点 | ✅ |
| `dict.getDictCodeList` / `getDictDataList` | 9 / 24 条（全表，未截断） | ✅ |
| `user.getUserInfo` / `getUserRoutes` | 正常（本轮未动，防误伤） | ✅ |

**`numQueries` 也一并核对了**（`serverpod_session_log` 表），B1/B2 的性能优化没被收敛回退：

| 方法 | numQueries | 说明 |
|---|---|---|
| `user.getUserList` 无 deptId | **2** | count + find |
| `user.getUserList` deptId=1 | **3** | 建树 1 + count + find（`_collectDeptAndChildrenIds` 一次性取全表没被回退） |
| `dept.getList` / `role.getList` / `menu.getList` | **1** | 全表 + 内存建树 |
| `user.getDetail` | 3 | 用户 + `sys_user_role` + `sys_role`（旧逻辑原有） |
| `dict.getDictCodeList` | 2 | 列表 + creator/updater 昵称反查（旧逻辑原有） |

> ⚠️ 回归时踩到的一个自坑：`dict.getDictDataDetail(id, code)` 的 `code` 必须与
> `sys_dict_data.code` **同时命中**，随便传一个 code 会得到
> `50000 字典数据不存在或已删除` —— 这是正确行为，不是回归。

---

## 8. 风险清单

| # | 风险 | 说明 | 处置 |
|---|---|---|---|
| 1 | **同一挂载点只能挂一次** | relic `PathTrie` 注入第二个 handler 抛 `Conflicting values` | 必须走 `BaseRestRoute` 的「一次挂载 + N 条子路由」结构 |
| 2 | **relic 中间件是路由级的** | OPTIONS 未注册路由会在匹配阶段 405，中间件不跑 → CORS 头加不上 | `BaseRestRoute.injectIn` 已给每个子路径补注册 OPTIONS |
| 3 | **两套 REST 基类并存** | `api_route.dart` 与 `rest_crud.dart`，混用会运行时崩且 `dart analyze` 抓不到 | S0 收口 |
| 4 | **公开方法即路由** | Endpoint 子类的公开方法自动成为 HTTP 路由；加辅助逻辑必须下划线私有 | S5 清理时注意，删方法=删路由 |
| 5 | ~~**`sys_menu` 没有 `tenantId`**~~ → ✅ **已解决 2026-09-24** | 曾会 `ArgumentError` | 已给表加列（迁移 `20260924011107788`，`NOT NULL DEFAULT 0`），menu 可直接用 `BaseService`。✅ 同日**追加迁移 `20260924020103589`**：两个唯一约束改为**按租户**（`(tenantId, title, parentId)` / `(tenantId, permission)`），并顺手把 `sys_menu_parent_sort_idx` 改成 `(tenantId, parentId, sort)` —— 详见 §6.3 |
| 6 | **`update` 整行覆盖陷阱** | merge 基线要用 `toJson()`（含 `serverOnly`），用 `toJsonForProtocol()` 会把 `password` 清空 | 已固化在 `AutoRestCrudDelegate.update` |
| 7 | **新增 Route 必须重启** | 与 Service 热重载行为不同 | 写进每阶段验收清单 |
| 8 | **`Features.enableWebServer()` 反向陷阱** | `!server.hasApp` 时 webServer **根本不启动**（不是 404）；调试时把路由全注释掉会让 REST 层消失 | 别把路由全注释掉 |
| 9 | 现存 CORS 配置 bug | `config/development.yaml` 的 `origin: '*'` + `credentials: true` 互斥（只管 8080） | 前端改造阶段一起修 |

---

## 9. 与其它文档的关系

- `docs/rest-api-layer.md` —— REST 层的**当前形态与实现细节**（§1–§9：分层 / 对外契约 /
  接口清单 / 踩坑实测 / CORS / 待办；§10：泛型层的设计依据）
- 本文 —— **重构路线**（做什么、按什么顺序、边界在哪）
