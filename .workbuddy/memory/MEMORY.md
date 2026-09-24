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
**阶段**：S0 泛型层 ✅ → S1 认证 REST 化 ✅ → S1.5 信封收口 + 两套基类合一 ✅ `1528dfb` → **S2 A 档 6 资源 ✅（代码完、待提交）** → S3 B 档 12 动作 → S4 airtable → S5 退役收尾 → #14 HTTP 冒烟（验完**不提交**）。
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
- `RestActionRoute`：非 CRUD 单点动作路由（与 `BaseRestRoute` 共用鉴权/信封/状态码/异常兜底），S3 用。

### S2 已落地（A 档 6 资源）
- `web/routes/api/`：`rest_delegate_utils.dart`（公共工具）+ `dict_data`/`dict_code`/`menu`/`dept`/`role` 新建 delegate + `user_rest_delegate.dart` 改写；`api_routes.dart` 改用 `registerResource<T>(pod, path, delegate, {enableCreate})` 挂 6 个。
- ⚠️ **PATCH 语义是 delegate 的责任**，判断「字段是否出现」**只能用 `Map.containsKey`** —— 用 `?? fallback` 会让客户端显式传 `null`（清空）被静默忽略。`MenuService.update` 是 `req.sort ?? 0` 型（缺字段被重置成默认值，更隐蔽）。
- ⚠️ **批量删「一条都没命中」仍返回成功**（`successCount:0`）→ 单条删 404 必须看计数（`ensureDeleted`）。
- ⚠️ **非分页列表**：dict-code(9)/dict-data(24)/dept 树(45)/menu 树(121) 历来全表，换分页会**悄悄截断** → `list` 允许返回非 `RestPage`。
- `/api/dict-code` 的 `code` **不可改**；`/api/role` **无 add**。
- **刻意不一致**：not-found 场景 typed 返 `200+code50000`，REST 返 `404+40400`（验收基线要排除）。
- `dict_service.dart` 新增 `getDictDataDetailById`。

## Service 收敛到 BaseService（2026-09-24 完成）
- **形态：保签名、内部换引擎。** 对外方法名/入参模型/返回类型一个都不动（typed 侧要活到 S5），只把 `SysXxx.db.*` 换成 `SystemCrudEngines.<资源>`。6 个 A 档资源全收敛。
- 入口 `services/system/crud_engines.dart`：6 个 `BaseService<T,TTable>` **lazy** getter（别改 `static final`）；`BaseEntityService` 是 `abstract` → 需 6 个具体子类。辅助：`buildCrudQuery`（默认 10/上限 100；`QueryEngine` 自身 20/200）、`findAllByEngine`（**全表** ≠ `getList` 分页）、`condEq/condLike/condIn`（`condLike` 只传**裸值**）。
- ⚠️ `QueryEngine` 在 `sort` 为空时**不排序** → 需默认排序必须显式 `sortAsc('id')`。
- ⚠️ **租户过滤变严**：旧 Service 的 `findFirstRow` 基本不带租户条件，`BaseService`/`QueryEngine` **无条件**按 `session.tenantId` 过滤 → 回归必须比 `total`。**例外**：`dict.getDictData` 是 `@unauthenticatedClientCall` → 刻意保留按入参 `tenantId` 过滤。
- ⚠️ **`delete` 必须两步**：先 `update()` 落 `updater`/`updateTime`，再 `delete()` 软删。**顺序不可颠倒**（`CrudService.update` 里 `setDeleted(data,false)` 会复位）。
- ⚠️ `existing.tenantId = req.tenantId` 会被 `setTenantId(...)` **覆盖成当前登录租户**（更安全，别当 bug 修）。`role.update` 的重名/重码校验刻意不走引擎。
- ✅ **审计已接**：6 引擎各注入 `DbAuditService(type:'user'|'dept'|'role'|'menu'|'dict_code'|'dict_data')`。⚠️ `BaseService` 默认 `NoopAuditService` —— **不显式传＝完全没审计**。
- ⚠️ **`CrudRuntime` 全仓零引用**（`crud/crud_runtime_factory.dart`）→ 查询审计/分页校验未生效，需单独决策（写放大）。
- ⚠️ `UserService.delete` **没有级联清理 `sys_user_role`**。⚠️ `status` 默认过滤（`?? 1`）是**旧代码原有** → 无 deptId 的 `total` 是 **15 不是 16**。

## 接口分档（15 Endpoint / 78 方法）
- **A 档 CRUD 6**：user / dept / role / menu / dictCode / dictData ✅ S2。
- **B 档 12**：auth×3、user(getUserInfo/getUserRoutes/resetPassword)、role×4、menu(getMenuOptions)、dict(getDictData/getDictDataDetail)、system(health/version)。
- **C 档**：airtable 4 Endpoint / 17 方法（「表/字段/行/关系」子系统，**别套 CRUD**）、book（示例）、product（半成品）。
- ⚠️ `ProductEndpoint extends BaseEndpoint<Book, BookTable>`（类型参数写错，复制粘贴遗留）。
- ⚠️ **6 个 A 档资源没一个能 `registerAutoCrud` 零覆写**：「自动产生 CRUD」的真实边界 = **5 条路由 + HTTP 语义全自动，数据映射按资源写一个 delegate（约 40 行）**。
- **S5 要退役**：`addByJsonParams`/`updateByJsonParams`、业务版 `base_endpoint.dart`、`UserEndpoint`/`ProductEndpoint` 对 `BaseEndpoint` 的继承。

## typed BaseEndpoint 契约（S5 前仍在用）
- `POST /<endpoint>/<method>`，body 用**参数名做外层 key**（`{"data":…}`/`{"query":…}`/`{"req":…}`），键名错 → `400 Missing required query parameter`。参数名以 `lib/src/generated/endpoints.dart` 的 `MethodConnector` 为准。
- ⚠️ **`update` 是整行覆盖**（`decodeModel` 造全新模型、**无 merge**）：缺 `password`→NULL（且 `serverOnly`，前端拿不到，通用 update 改用户**必清空密码**）、缺 `authUserId`→断登录关联、缺 `createTime`→重置 now、缺 `username`/`nickname`→500。
- 不能收窄形参类型自定义 `update`（`dynamic` 是 top type → `invalid_override`）；`dynamic`/`Map` 形参收不了普通 JSON，**只能 `String` + `jsonDecode`**。
- `updateByJsonParams` = **PATCH 语义**（先读基线）；`addByJsonParams` = JSON 文本版新增。形参都是 `params`/`String`，body `{"params":"{\"id\":2}"}`。**改名后必须 `serverpod generate`**；merge 用 `toJson()`（`toJsonForProtocol()` 不含 serverOnly）。

## sys_menu 租户化（2026-09-24）
- 补 `tenantId`（迁移 `20260924011107788`）；唯一约束改按租户（`20260924020103589`）：`(tenantId,title,parentId)`、`(tenantId,permission)`、`(tenantId,parentId,sort)`。
- ⚠️ `permission` **必须进唯一键**（现网每行各有唯一 permission，目录类也带 `menu:dashboard`）。**不需要改 Dart**：查重靠 DB，租户由 `CrudService.create` 按 `session.tenantId` 打标。
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
- ⚠️ **别跑 `dart format`** —— 仓库整体不是 3.13 formatter 的 clean 状态，会产生大量无关 diff。
- ⚠️ **别删 `.dart_tool/hooks_runner/`**（sqlite3 build hook 缓存，删了要联网重下，本机不通直接起不来）。
- ⚠️ macOS BSD `grep` **不支持 `\|` 交替**（静默返回空）→ 用专用 Grep 工具。
- 验证后端**别只看 `dart analyze`** → 用 skill `serverpod-local-api-verify` 真发请求（`--noproxy '*'` + 关沙箱；种子密码 `asdf1234`）。
- ⚠️ **动用户在 App Studio 里启动的进程前必须先问**。
- ⚠️ **Endpoint 子类的公开方法会自动变 HTTP 路由**，辅助逻辑必须下划线私有。
- `dart analyze` 问题数暴涨（2→143）先看最近那次编辑的括号/注释。`user_service.dart` 顶部 2 个未使用 import 是既有 warning。
- `JWTExpiredException: jwt expired` + 全栈 ERROR 是**预期噪声**（1h 过期自动 refresh）。

## Git
- 分支 `feature/web-server-rest-api`。提交风格：中文单行标题「模块：动作」。
- ⚠️ `system_resources_2/` 是**嵌套 git 仓库**，`git add -A` 只记成 gitlink → 提交前 `git reset -- system_resources_2`。✅ 本地那份**已可删**（包从 pub cache 解析且自带 dylib，只有 `start.sh` 菜单 9 用它）。
- `flutter_web_client/` 是模板 typed client，无 App 在用（僵尸资产）。
- 提交 `a008181` **故意含硬编码调试 payload**，用户要求照原样提交，别当正常。
