# flutter_web_admin 项目长期约定

> 细节（含验证输出、逐条推理）在 `.workbuddy/memory/YYYY-MM-DD.md` 日报里；本文件只留**跨会话必需的结论与陷阱**。

## 结构 / 目标
- `flutter_web_server/`：Serverpod 4 后端。模型 `lib/src/models/**/*.spy.yaml`，业务 `services/system/*_service.dart`，typed 端点 `endpoints/system/`，REST 表现层 `web/routes/api/`。
- `gi_demo_admin/`：Vue3 + Arco 后台。`serverpod_crud/`：自研 CRUD 框架包。
- ⚠️ **两套基类陷阱**：`base_endpoint.dart`（业务版，返 `CommonResponse`）vs `serverpod_crud` 的 `BaseCrudEndpoint`，混用会运行时 cast 崩、`dart analyze` 抓不到。（S1.5 起 REST 侧已只剩一套。）
- **REST 化目标**：所有接口改用 Serverpod REST Route 实现 + CRUD 自动产生。**不是关 8080**（关不掉也不需要关）。

## 关键约定
- **「系统内置不可编辑」= 服务层注入 `disabled`**（不是模型字段），前端读 `record.disabled`。直接 `CommonResponse.success(list)` 的响应里**不会有** `disabled`。
- 判断「内置」用 `isSuperuser`：`SysUser.type` 标 `!persist`，DB 无该列恒为 2，`type===1` 永不成立。

## REST 表现层（分支 `feature/web-server-rest-api`）
**阶段**：S0 泛型层 ✅ → S1 认证 REST 化 ✅ → S1.5 信封收口 + 两套基类合一 ✅ `1528dfb` → S2 A 档 6 资源 ✅ `8e1d1c8` → S3 B 档 12 动作 ✅ `00e375c` → **S4 airtable ✅（本阶段）** → S5 退役收尾 → #14 HTTP 冒烟（验完**不提交**）。
- 挂 **8082**（`webServer`）；8080=apiServer、8081=insights，**同一进程三个端口**。
- **路径统一单数**：`/api/user`、`/api/dict-data`、`/api/dict-code`、`/api/menu`、`/api/dept`、`/api/role`、`/api/auth/*`（连字符 `public-key`/`refresh-token`）。
- 文档：`docs/rest-api-layer.md`（§1–5 形态/契约/清单，§6 踩坑实测，§8 待办，§10 设计依据）、`docs/rest-api-migration-plan.md`（§7.1 回归基线）。
- ⚠️ 新增/改 Route 后**必须重启进程**（`run()` 只跑一次，`addRoute` 不随热重载）。
- ⚠️ `addRoute` 内部是 `injectAt`：**同一挂载点只能挂一次**（relic `Conflicting values`）；同路径同方法二次注册抛 `already registered`。
- ⚠️ `Features.enableWebServer()`：8082 一条 Route 都没注册时 webServer **根本不启动**（不是 404）→ 别把路由全注释掉。
- ⚠️ `config/*.yaml` 的 `cors:` **只管 8080**；8082 用自建 `CorsMiddleware`（白名单 + 回显 origin + `Vary: Origin`）。⚠️ relic 中间件是**路由级**的 → 每个子路径都要单独注册 `OPTIONS`。
- **信封**：唯一 `ServerpodEnvelopeBuilder`（`serverpod_crud`），接缝 `RestEnvelopeBuilder.success/page/failure`。普通成功 message=`'succeed'`、分页成功=**空串**；`data==null` 时**不输出 `data` 键**。
- `_mapCode`：401→40100、403→40300、404/400→40400、500→50000、`null`→50000，其余透传。`RestApiException` 兜底约定：识别不出业务码时填 **HTTP 风格码**（400/401/403/404/500）由项目侧翻译（本项目 `ResultCode` 全 ≥20000，不撞车）。
- ⚠️ **响应体必须走 `SerializationManager.encodeForProtocol`（框架 `encodeEnvelope`），不能 `jsonEncode`** —— dept/menu 的 `list` 是手搓树，Map 里的 `DateTime` 会抛 `Converting object to an encodable object failed` → 500。
- ⚠️ **双层信封**：Service 已返 `CommonResponse` → `success` 必须直接 `data.toJson()`。`toJson()` 走 `JsonCleaner`：递归剔 `__className__`/`password`；时间字段**只格式化 String**。
- `RestCrudDelegate.detail/create/update` 返 `Future<Object?>`（详情常带组合字段如 `roleIds`/`roles`）。
- `BaseRestRoute` 自动产出 **8 条路由**：`GET /`、`GET /:id`、`POST /`(201)、`PUT|PATCH /:id`、`DELETE /:id`、`DELETE /`、`POST /update`、`POST /delete`（后三条由 `enableBatchDelete`/`enablePostAliases` 控制，默认开）。`enableCreate:false` → 不注册 `POST /`，落 **405 不是 404**。
- ⚠️ 实现 delegate 用 **`extends` 不用 `implements`**（`removeBatch` 有默认实现）；⚠️ 默认 delegate 是 **lazy**（别改成构造期装配）；⚠️ `BaseRestRoute<T>` **只一个类型参数**。
- `RestActionRoute`：非 CRUD 单点动作路由（与 `BaseRestRoute` 共用鉴权/信封/状态码/异常兜底）。

### S2 已落地（A 档 6 资源）
- `web/routes/api/`：`rest_delegate_utils.dart`（公共工具）+ 5 个新 delegate + 改写 `user_rest_delegate.dart`；`api_routes.dart` 用 `registerResource<T>(pod, path, delegate, {enableCreate})` 挂 6 个。
- ⚠️ **PATCH 语义是 delegate 的责任**：「字段是否出现」**只能用 `Map.containsKey`** —— `?? fallback` 会让显式传 `null`（清空）被静默忽略；`MenuService.update` 是 `req.sort ?? 0` 型（缺字段被重置成默认值，更隐蔽）。
- ⚠️ **批量删「一条都没命中」仍返成功**（`successCount:0`）→ 单条删 404 必须看计数（`ensureDeleted`）。
- ⚠️ **非分页列表**：dict-code(9)/dict-data(24)/dept 树(45)/menu 树(121) 历来全表，换分页会**悄悄截断** → `list` 允许返回非 `RestPage`。
- `/api/dict-code` 的 `code` **不可改**；`/api/role` **无 add**；`dict_service` 新增 `getDictDataDetailById`。
- **刻意不一致**：not-found typed 返 `200+code50000`、REST 返 `404+40400`（验收基线要排除）。

### S3 已落地（B 档 12 动作 → 14 条动作路由）
- 5 个 `web/routes/api/{user,role,menu,dict,system}_action_routes.dart`；**路由表以 `Map<String, RestActionRoute>` 同时供给注册与测试**（测试不手抄清单）。
- 路由：`GET /api/user/{info,routes}`、`POST /api/user/reset-password`、`GET /api/role/:id/{menu-ids,users}`、`POST /api/role/:id/users/remove`、`PUT|POST /api/role/:id/menus`、`GET /api/menu/options`、`GET /api/dict/options`、`GET /api/system/{health,version}`。
- ⚠️ **12 个 typed 方法只对应 11 条新路由**：`getDictDataDetail(id, code)` 被 A 档 `GET /api/dict-data/:id` 覆盖（REST 更宽松，只按 id）。
- ⚠️ **路径参数名必须沿用 `:id`**：`PathTrie._build` 同层遇不同参数名会在**注册阶段**抛 `Conflicting parameter names at the same level` → **服务起不来**（报错离原因很远）。
- ⚠️ **字面量段优先于参数段**：`GET /api/user/info` 命中字面节点、不被 `/:id` 吃掉；哪天改成 `:tab` 就会被抢走 → 运行期 400（不是 404）。
- ✅ `PathTrie.attach` 是**合并**子路由（非嵌套 router），`/:id/x` 与 `/:id` 不互相匹配、也不 `Conflicting values` → **嵌套安全，问题只在参数名**。
- ⚠️ **`RestActionRoute.handleCall` 在 handler 正常返回时一律 200**，不按 body 的 `code` 改状态码 → 「业务失败 → 400」必须 handler 自己调 `ensureOk`。**S1 auth 三条刻意没调**（保「与 typed 逐字节一致」）→ 登录失败是 `200+50000`；A 档/S3 走 `ensureOk` → 400。**两套做法并存，待统一**（rest-api-layer.md §8 待办 9）。
- 匿名可访问**恰好 6 条**（auth 3 + `/api/dict/options` + system 2），有断言钉住；`/api/dict/options` 按**入参 `tenantId`** 过滤（登录前无 session）→ 不传返回**全部租户**的字典项，是刻意行为，别当漏洞修。
- 批量动作 id 集合必填（缺失/空数组 → 400，因 Service 对空数组返 `successCount:0` 的**成功**）；⚠️ `PUT /api/role/:id/menus` 的 `menuIds` **允许空数组**（全量替换 = 清空权限）→ 用 `normalizedIntList` 不用 `requiredIntList`。

### S4 已落地（C 档 airtable → 13 条路径）
- airtable 是 **5 个 Endpoint / 21 个方法**（文档原写「4 / 17」是错的）；`services/airtable/` 原本是**空目录**，逻辑全在 Endpoint 里。
- 结构：`lib/src/web/routes/api/airtable/{tables,fields,rows,items,relations}_action_routes.dart` + `airtable_action_routes.dart`（汇总 + `registerAirtableActionRoutes`）。**全部手写 `RestActionRoute`，没套 `BaseRestRoute`**（子资源语义 / 级联物理删 / 返回值不统一）。
- 路径**用复数 + 完整层级**（`/api/airtable/tables/:id/fields`），**有意**与 A 档单数不一致。
- ✅ 四张 `air_*` 表补了 `tenantId` / `deleted` + `(tenantId, deleted)` 索引；`air_tables` 唯一索引 `(name)` → **`(tenantId, name)`**（迁移 `20260924070853559`）。`create-migration` 的 unique-index 警告是**假警报**（旧索引本就 name 唯一，tenantId 补成全表 0 → 只会更宽松），`--force` 过。
- ✅ 21 个方法搬进 `AirtableService`，5 个 Endpoint 退化成**薄壳**。
- ⚠️ **`session.tenantId` / `session.targetTenantId` 来自 `serverpod_crud` 的 `SessionExtension`**（不是 serverpod 核心）→ 用它们必须 import `serverpod_crud`，否则 `undefined_getter`。
- ⚠️ **同一路径的多种方法必须合并成一条路由**：`addRoute` 挂载点唯一，`GET /x`+`POST /x` 写两次 → `Conflicting values`。用框架新增的 **`RestActionRoute.byMethod({handlers: {Method.get:…}})`**（key 集合即 `methods`，handler 按 `request.method` 分派）。
- ⚠️ **`Map<String, RestActionRoute>` 重复键静默覆盖** → 某方法凭空 404。`airtableActionRoutes()` 里有断言兜。
- ⚠️ `RestActionRoute.byMethod` 的初始化列表**不能直接写函数字面量**（Dart 3 记录语法会解析成「括号表达式 + 块」）→ 抽成静态方法。
- 新增公共工具 `countOf(res, key)`：airtable 批量删返 **`deletedCount`** 而非 `successCount`（`successCountOf` 取不到）→ 一条都没命中时要显式判 404。
- 🔴 **删除仍是级联物理删，`deleted` 列恒 false**（刻意取舍）：级联链「表→行/字段→单元格」四层标记易漏；切软删会让**被删的表永久占住 `(tenantId,name)` 唯一索引**、无法同名重建（同 `sys_menu.permission` 那类问题）。**切不切软删是独立决策**。
- ⚠️ **airtable 不落审计**：直接调 `AirTableXxx.db.*`，没走 `BaseService` → 增删改不写 `sys_operate_log`。
- ⚠️ `tenantId` 过滤会让数据量与改造前不同（改造前**完全不按租户过滤**）；现网 tenantId 全 0 所以当前不丢数据，但**租户 > 0 的账号会看到 0 条**。
- ✅ 顺带修 3 个既有 bug：`updateField` 赋原值（改名是**静默空操作**）+ 重名校验用旧名；`searchTableItems` 在 `AirTableRows` 上拿 `t.id` 比 tableId → **恒返回空页**（应 `t.tables.id`）；`getItemRelations` 的 `tiedItem` 取 `item.id`（自己）而非 `item.itemId`。
- 沿用未修：`GET /tables/:id/rows` 返 `PageResponse` 且 `keyword` **从未被使用**（REST 侧不挂该 query）；`POST .../rows` 返回 `true` 非新行 id。
- 离线断言：`serverpod_crud` **32**、`flutter_web_server` **68**（合 **100**，原 79）。

## Service 收敛到 BaseService（2026-09-24 完成）
- **形态：保签名、内部换引擎**（`SysXxx.db.*` → `SystemCrudEngines.<资源>`），6 个 A 档资源全收敛；对外签名一个没动（typed 要活到 S5）。
- 入口 `services/system/crud_engines.dart`：6 个 `BaseService<T,TTable>` **lazy** getter（别改 `static final`）；`BaseEntityService` 是 `abstract` → 需 6 个具体子类。辅助：`buildCrudQuery`（默认 10/上限 100；`QueryEngine` 自身 20/200）、`findAllByEngine`（**全表** ≠ `getList` 分页，硬套会悄悄截断）、`condLike` 只传**裸值**。
- ⚠️ 四个坑：① `QueryEngine` 的 `sort` 为空时**不排序** → 要默认排序必须显式 `sortAsc('id')`；② **租户过滤变严**（旧 `findFirstRow` 基本不带租户条件，引擎**无条件**按 `session.tenantId` 过滤）→ 回归必须比 `total`（**例外**：`dict.getDictData` 匿名，刻意按入参 `tenantId`）；③ **`delete` 必须两步** —— 先 `update()` 落审计字段再 `delete()`，顺序颠倒会被 `setDeleted(false)` 复位；④ `existing.tenantId = req.tenantId` 会被 `setTenantId(...)` 覆盖成当前登录租户（更安全，别当 bug 修）。
- ✅ **审计已接**：6 引擎各注入 `DbAuditService(type: 资源名)`。⚠️ `BaseService` 默认 `NoopAuditService` —— **不显式传＝完全没审计**。⚠️ **`CrudRuntime` 全仓零引用** → 查询审计/分页校验未生效，需单独决策（写放大）。
- ⚠️ `UserService.delete` 没级联清 `sys_user_role`；`status` 默认过滤（`?? 1`）是**旧代码原有** → 无 deptId 的 `total` 是 **15 不是 16**。

## 接口分档（15 Endpoint / 78 方法）
- **A 档 CRUD 6**：user/dept/role/menu/dictCode/dictData ✅S2 ｜ **B 档 12**：auth×3 + user×3 + role×4 + menu×1 + dict×2 + system×2 ✅S3 ｜ **C 档**：airtable **5 Endpoint/21 方法**（「表/字段/行/单元格/关联」四层子系统，**别套 CRUD**）✅S4、book（示例）、product（半成品）。全仓共 **14 个 Endpoint / 69 个公开方法**。
- ⚠️ `ProductEndpoint extends BaseEndpoint<Book, BookTable>`（类型参数写错，复制粘贴遗留）。
- ⚠️ **6 个 A 档资源没一个能零覆写**：「自动产生 CRUD」的真实边界 = **5 条路由 + HTTP 语义全自动，数据映射按资源写一个 delegate（约 40 行）**。
- **S5 要退役**：`addByJsonParams`/`updateByJsonParams`、业务版 `base_endpoint.dart`、`UserEndpoint`/`ProductEndpoint` 对 `BaseEndpoint` 的继承。

## typed BaseEndpoint 契约（S5 前仍在用，S5 后大部分作废）
- `POST /<endpoint>/<method>`，body 用**参数名做外层 key**（`{"data":…}`/`{"query":…}`/`{"req":…}`），键名错 → `400 Missing required query parameter`。参数名以 `lib/src/generated/endpoints.dart` 的 `MethodConnector` 为准。
- ⚠️ **`update` 是整行覆盖**（`decodeModel` 造全新模型、**无 merge**）：缺 `password`→NULL（且 `serverOnly`，前端拿不到，通用 update 改用户**必清空密码**）、缺 `authUserId`→断登录关联、缺 `createTime`→重置 now、缺 `username`/`nickname`→500。
- 不能收窄形参类型自定义 `update`（`dynamic` 是 top type → `invalid_override`）；`dynamic`/`Map` 形参收不了普通 JSON，**只能 `String` + `jsonDecode`**。
- `updateByJsonParams` = **PATCH 语义**（先读基线）；`addByJsonParams` = JSON 文本版新增。形参都是 `params`/`String`，body `{"params":"{\"id\":2}"}`。**改名后必须 `serverpod generate`**；merge 用 `toJson()`（`toJsonForProtocol()` 不含 serverOnly）。两者都是 S5 要退役的补丁。

## sys_menu 租户化（2026-09-24）
- 补 `tenantId`（迁移 `20260924011107788`）；唯一约束改按租户（`20260924020103589`）：`(tenantId,title,parentId)`、`(tenantId,permission)`、`(tenantId,parentId,sort)`。⚠️ `permission` **必须进唯一键**（现网每行各有唯一 permission，目录类也带 `menu:dashboard`）。**不需要改 Dart**：查重靠 DB，租户由 `CrudService.create` 按 `session.tenantId` 打标。
- 边界：`permission` 默认 `''` 且是真实值 → **同租户只能有一个不填 permission 的菜单**；唯一约束**不含 `deleted`**。
- ⚠️ 删未应用的迁移目录要**同步清 `migrations/migration_registry.txt`**。

## 前端（gi_demo_admin）
- 真在用的只有 **system + user**，见日报。`/area /cate /file /test /v1/base/logout /user/userAdd` 后端**无对应 Endpoint**（上游模板遗留）。前端**没用** dept/menu 的 CRUD、也没用 airtable。
- `apis/base.ts` 的 `getBaseApi` 被 6 模块共用，**改它 = 改公共契约**；调用形态必须 `{ params: JSON.stringify(payload) }`。⚠️ `SysUser` **没有 `roleIds`**（只有 `postIds`），通用 update 会**静默丢弃 roleIds**。
- 首屏 `getUserList` 只应 1 次（`skipSelectSearch` + `useTable({immediate:false})`）；`dept.getList` 由 `useDept` 模块级 in-flight Promise 去重。

## 性能基线
- `getUserList` 的 dept 子树已改**一次取全表 + 内存建树**（`queries` 46→2；看到 4x = 被回退）。期望 `numQueries`：带 `deptId`=**3**、不带=**2**。
- `getUserList` 是**服务端真分页**（上限 100）。**role/menu/dept 仍是「全表 + 客户端切片」假分页。**

## 环境 / 命令 / 已知坑
- **认证自己实现**：`auth_endpoint.dart` 薄转发 → `services/system/auth_service.dart`，**不是** `serverpod_auth_idp_server` → 复刻到 REST 是纯表现层工作。
- `dart analyze`/`dart test` 用 `~/fvm/default/bin/dart`（Dart 3.13.0）；项目本身 fvm 3.44.4 = Dart 3.12.2 → **混用留内核版本冲突**（`expected 130, found 138`）。`serverpod generate` 用 `PATH="$HOME/fvm/versions/3.44.4/bin:$PATH" ~/.pub-cache/bin/serverpod generate`。
- ⚠️ **别跑 `dart format`**（仓库整体不是 3.13 formatter clean，会产生大量无关 diff）；⚠️ **别删 `.dart_tool/hooks_runner/`**（sqlite3 build hook 缓存，删了要联网重下，本机不通直接起不来）。
- ⚠️ macOS BSD `grep` 不支持 `\|` **和 `^` 锚点**（静默返回空）→ 用专用 Grep 工具。
- 验证后端**别只看 `dart analyze`** → 用 skill `serverpod-local-api-verify` 真发请求（`--noproxy '*'` + 关沙箱；种子密码 `asdf1234`）。
- ⚠️ **动用户在 App Studio 里启动的进程前必须先问**；⚠️ **Endpoint 子类的公开方法会自动变 HTTP 路由**，辅助逻辑必须下划线私有。
- `dart analyze` 问题数暴涨（2→143）先看最近那次编辑的括号/注释。`user_service.dart` 顶部 2 个未使用 import 是既有 warning。
- `JWTExpiredException: jwt expired` + 全栈 ERROR 是**预期噪声**（1h 过期自动 refresh）。

## Git
- 分支 `feature/web-server-rest-api`。提交风格：中文单行标题「模块：动作」。
- ⚠️ `system_resources_2/` 是**嵌套 git 仓库**，`git add -A` 只记成 gitlink → 提交前 `git reset -- system_resources_2`。✅ 本地那份**已可删**（包从 pub cache 解析且自带 dylib，只有 `start.sh` 菜单 9 用它）。
- `flutter_web_client/` 是模板 typed client，无 App 在用（僵尸资产）。
- 提交 `a008181` **故意含硬编码调试 payload**，用户要求照原样提交，别当正常。
