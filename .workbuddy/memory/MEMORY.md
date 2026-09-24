# flutter_web_admin 项目长期约定

> 验证输出、推理、踩坑实测在 `.workbuddy/memory/YYYY-MM-DD.md` 日报与 `docs/`；本文件只留**跨会话必需的结论与指针**。

## 结构 / 目标
- `flutter_web_server/`：Serverpod 4 后端。模型 `models/**/*.spy.yaml`、业务 `services/system/*_service.dart`、typed 端点 `endpoints/system/`、REST 表现层 `web/routes/api/`。
- `gi_demo_admin/`：Vue3 + Arco 后台。`serverpod_crud/`：自研 CRUD 框架包。
- **REST 化目标**：所有接口改用 Serverpod REST Route + CRUD 自动产生。**不是关 8080**（关不掉也不需要关）。
- 分支 `feature/web-server-rest-api`；提交风格中文单行「模块：动作」。
- ⚠️ 旧「两套基类陷阱」（业务版 `base_endpoint.dart` vs `serverpod_crud` 的 `BaseCrudEndpoint`）**S5 已整份拆除**，全仓只剩 `serverpod_crud` 一套。

## REST 表现层进度（全部完成 ✅）
S0 → S1 认证 → S1.5 信封+基类合一 `1528dfb` → S2 A 档 6 资源 `8e1d1c8` → S3 B 档 12 动作 `00e375c` → S4 airtable `73280d2` → **S5 退役收尾 `f664aeb`** → **HTTP 冒烟 85/85**（按用户要求**验完不提交**）。

📖 **踩坑全集 / 契约 / 路由清单以 `docs/rest-api-layer.md` 为准**（§2 分层·收敛·退役、§3 契约、§4 接口清单、§5 验证、§6 踩坑实测、§7 CORS、§8 **已知缺口 14 条**、§9 本地验证、§10 泛型层硬约束）；框架侧 `docs/serverpod_crud_architecture.md`。
> ⚠️ `docs/rest-api-migration-plan.md`、`docs/gi-demo-提交分析与同步方案.md`、`flutter_web_server/docs/{auth_jwt_tasks_plan,mybatis_plus_style_refactor_sketch}.md` 已于 2026-09-24 删；结论已并入本节与 `rest-api-layer.md`。**别再找这四个文件。**
> ⚠️ `docs/images/`（14 张 / 11MB）**不能删** —— 根 `README.md` 引用了全部 14 张。

### REST 反复踩的坑（详版 §6）
- 挂 **8082**（`webServer`）；8080=apiServer、8081=insights，**同一进程三端口**。⚠️ 改 Route 后**必须重启进程**。
- 路径**统一单数**（`/api/user|dept|role|menu|dict-data|dict-code|auth/*`，连字符 `public-key`/`refresh-token`）；⚠️ airtable **例外用复数**。
- `addRoute` = `injectAt` → **同一挂载点只能挂一次**（`Conflicting values`）；**同路径多方法必须合并成一条** → `RestActionRoute.byMethod`；⚠️ `RestActionRoute`/`Map` **重复键静默覆盖**（方法凭空 404），`analyze` 不报。
- 路径参数名**必须沿用 `:id`**：`PathTrie` 同层不同参数名在**注册阶段**抛 → **服务起不来**（报错离原因很远）。字面量段优先于参数段。
- `handleCall` 正常返回**一律 200** → 业务失败必须自己 `ensureOk`。S1 auth 三条**刻意没调**（保与 typed 逐字节一致）；A 档/S3 走 `ensureOk`。两套并存待统一（§8 待办 9）。
- 响应体必须走 `encodeForProtocol`（`jsonEncode` 遇 `DateTime` 会 500）；Service 已返 `CommonResponse` 时 `success` 直接 `data.toJson()`（防双层信封）。
- `session.tenantId`/`targetTenantId` 来自 `serverpod_crud` 的 `SessionExtension`（**不是核心**）→ 必须 import `serverpod_crud`。
- **PATCH 语义是 delegate 的责任**（只能 `Map.containsKey`）；**批量删「一条没命中」仍返成功** → 单条删 404 要看计数。
- **非分页列表**（dict-code 9 / dict-data 24 / dept 树 45 / menu 树 121）历来全表 → `list` 允许返回非 `RestPage`。
- `Features.enableWebServer()`：8082 一条 Route 都没注册时 webServer **根本不启动**（不是 404）。`config/*.yaml` 的 `cors:` **只管 8080**；relic 中间件是**路由级**的 → 每个子路径单独注册 `OPTIONS`。
- 「自动产生 CRUD」真实边界 = 5 条路由 + HTTP 语义全自动，**数据映射仍需按资源写约 40 行 delegate**（`extends` 不用 `implements`；默认 lazy；`BaseRestRoute<T>` 只一个类型参数）。
- 匿名**恰好 6 条**（auth 3 + `/api/dict/options` + system 2）；`/api/dict/options` 按**入参 `tenantId`** 过滤 → 不传返回全部租户（刻意）；`PUT /api/role/:id/menus` 的 `menuIds` **允许空数组**。
- **刻意不一致**：not-found typed 返 `200+code50000`、REST 返 `404+40400` → **验收基线要排除**。

### S4 airtable（13 条路径）
- 5 Endpoint / 21 方法（文档原写「4/17」是错的）；21 方法已搬进 `AirtableService`，Endpoint 退化成**薄壳**。`web/routes/api/airtable/*_action_routes.dart` **全手写 `RestActionRoute`，没套 `BaseRestRoute`**。
- ✅ 四张 `air_*` 表补 `tenantId`/`deleted` + `(tenantId,deleted)` 索引；`air_tables` 唯一索引 `(name)`→`(tenantId,name)`（迁移 `20260924070853559`，`create-migration` 的 unique 警告是**假警报**）；`updateField`/`deleteField` 改 `int id`；删 `getTables2`（合进 `getTables`）。
- ✅ 顺带修 3 个既有 bug：`updateField` 改名是**静默空操作** + 重名校验用旧名；`searchTableItems` 恒返空页；`getItemRelations` 的 `tiedItem` 取自己。
- 🔴 **删除仍是级联物理删**、**不落审计**、tenantId 过滤让租户 > 0 的账号看到 0 条。**切不切软删是独立决策。**
- 离线断言：`serverpod_crud` **32** + `flutter_web_server` **68** = **100**（原 79）。

### S5 退役（2026-09-24 已完成）
- 范围（用户拍板）：全删 + 先前端后后端 + 前端只改真实在用的 + book/product/client 都不动。
- 后端删 5 文件（`endpoints/system/base_endpoint.dart`、`endpoints/utils/json_param_codec.dart`、`crud/crud_runtime_factory.dart`、`crud/plugins/query_audit_log_plugin.dart`、`mappers/query_request_mapper.dart` —— 依赖簇只被已删基类引用）；`UserEndpoint`/`ProductEndpoint` 退成裸 `Endpoint`。
- ⚠️ **`UserEndpoint` 退裸连带消失 6 条 typed 路由**（`getList`/`update`/`delete`/`deleteBatch` 是**继承来的**）→ **前后端必须同时动**；退裸后 `generated/protocol.dart` import 变 unused（`CommonResponse` 等实际来自 `flutter_web_shared`）。

## 关键业务约定
- 「系统内置不可编辑」= **服务层注入 `disabled`**（不是模型字段），前端读 `record.disabled`。直接 `CommonResponse.success(list)` **没有** `disabled`。
- 「内置」判断用 `isSuperuser`：`SysUser.type` 标 `!persist`，DB 无该列恒为 2，`type===1` 永不成立。
- **认证自己实现**：`auth_endpoint.dart` 薄转发 → `services/system/auth_service.dart`（**不是** `serverpod_auth_idp_server`）。

## Service 收敛到 BaseService（已落地）
- **保签名、内部换引擎**（`SysXxx.db.*` → `SystemCrudEngines.<资源>`），6 个 A 档资源；入口 `services/system/crud_engines.dart`（6 个 **lazy** getter）；辅助 `buildCrudQuery`（默认 10/上限 100）、`findAllByEngine`（**全表**≠分页）、`condLike` 只传**裸值**。
- ⚠️ 四坑：① `QueryEngine` 的 `sort` 空时**不排序** → 要默认排序须显式 `sortAsc('id')`；② **租户过滤变严**（无条件按 `session.tenantId`）→ 回归必须比 `total`；③ **`delete` 必须两步**（先 `update()` 落审计再 `delete()`，反了被复位）；④ `existing.tenantId = req.tenantId` 会被 `setTenantId` 覆盖（更安全，别当 bug 修）。
- ⚠️ 审计：6 引擎各注入 `DbAuditService`，但 `BaseService` 默认 **`NoopAuditService`**（不显式传＝完全没审计）；**查询审计（`QueryAuditLogPlugin`）在 S5 连装配文件一起删了** → 引擎用空 `CrudRuntime()`，**查询审计/分页校验插件/`contains` 都不在链路里**（要恢复得重写 runtime 装配）。
- ⚠️ `UserService.delete` 没级联清 `sys_user_role`；`status` 默认过滤（`?? 1`）是旧代码原有 → 无 deptId 的 `total` 是 **15 不是 16**。

## 接口分档（**退役后**口径）
- **A 档 CRUD 6**：user/dept/role/menu/dictCode/dictData ✅S2 ｜ **B 档 12**：auth×3 + user×3 + role×4 + menu×1 + dict×2 + system×2 ✅S3 ｜ **C 档**：airtable 5/21 ✅S4、book（示例）、product（半成品）。
- 「全仓 14 Endpoint / 69 公开方法」是**退役前**快照（只统计**声明**的方法）。退役后 typed 表面只剩业务特定方法。
- typed 通用规则（业务版 `BaseEndpoint` 已删）：⚠️ **Endpoint 子类的公开方法会自动变 HTTP 路由**，辅助逻辑必须下划线私有；**删方法 = 删路由**；typed `POST /<endpoint>/<method>` body 用**参数名做外层 key**（`{"query":…}`），键名错 → `400 Missing required query parameter`。

## sys_menu 租户化
- 补 `tenantId`（迁移 `20260924011107788`）；唯一约束改按租户（`20260924020103589`）：`(tenantId,title,parentId)`、`(tenantId,permission)`、`(tenantId,parentId,sort)`。⚠️ `permission` **必须进唯一键**（现网 121 行每行各有唯一 permission）。**不需要改 Dart**：查重靠 DB。
- 边界：`permission` 默认 `''` 且是真实值 → **同租户只能有一个不填 permission 的菜单**；唯一约束**不含 `deleted`**（软删行仍占名额）。
- ⚠️ 删未应用的迁移目录要**同步清 `migrations/migration_registry.txt`**。

## 前端（gi_demo_admin）—— ✅ S5 已切到 REST(8082)
- **真在用的是 system + user** 两模块 + role/menu/dict/dept 的部分方法；`/area /cate /file /test /v1/base/logout` 后端**无对应 Endpoint**（上游模板遗留，S5 决定不动）。`userAdd`/`userUpdate` 已删。
- `apis/base.ts` 的 `getBaseApi` 被 **7 个消费方**共用（person/user/role/dept/menu/dict），**改它 = 改公共契约**。**S5 已重写**：8→6 方法，`getList`→`GET /`、`getDetail`→`GET /:id`、`add`→`POST /`、`update`→`POST /update`、`delete`/`deleteBatch`→`POST /delete`。⚠️ `baseUrl` 必须与后端挂载点一致（**单数 + 连字符**）。
- ⚠️ `ServerpodEnvelopeBuilder` 已剥 `password`/`__className__`；⚠️ `SysUser` **没有 `roleIds`**（只有 `postIds`），通用 update 会**静默丢弃 roleIds**。
- 首屏 `getUserList` 只应 1 次；`dept.getList` 由 `useDept` 模块级 in-flight Promise 去重。
- env：`.env.{development,production,test}` 的 `VITE_API_PREFIX`/`VITE_API_BASE_URL` 全指向 **8082 的 `/api`**（production 需 nginx `location /api/ { proxy_pass http://127.0.0.1:8082/api/; }`）。`utils/http.ts` 有 401 → refresh 流程（`refresh-token` 连字符）。
- 🔴 **4 个表单弹窗的保存是「模拟保存」**（`setTimeout` + `Message.success('模拟保存成功')`，**完全不调接口**）：`dict/DictDataFormModal.vue:149`、`dict/DictFormModal.vue:101`、`role/RoleFormModal.vue:102`、`menu/MenuFormModal.vue:275`。真实功能缺口（任务 #15，未做）。

## 性能基线
- `getUserList` 的 dept 子树已改**一次取全表 + 内存建树**（queries 46→2）。期望 `numQueries`：带 `deptId`=**3**、不带=**2**。⚠️ 看到 4x = 被回退。
- `getUserList` 是**服务端真分页**（上限 100）。**role/menu/dept 仍是「全表 + 客户端切片」假分页。**

## 环境 / 命令 / 已知坑
- `dart analyze`/`dart test` 用 `~/fvm/default/bin/dart`（Dart 3.13.0）；项目本身 fvm 3.44.4 = Dart 3.12.2 → **混用留内核版本冲突**（`expected 130, found 138`）。`serverpod generate` / `create-migration` 用 `PATH="$HOME/fvm/versions/3.44.4/bin:$PATH" ~/.pub-cache/bin/serverpod …`。
- ✅ **生成物执行位噪音已修**（`e22dfd1`）：`flutter_web_client/lib/src/protocol/` 44 个 `.dart` 755→644，**重跑 generate 不再产生假 diff**。⚠️ **别对全仓 755 批量 chmod** —— `dai_shan_chu/scripts/*.sh` + `start.sh` 共 15 个是**真脚本，必须 755**。⚠️ 勿用 `git update-index --chmod=-x`（只改 index 会让 `git status` 立刻报一堆 modified；正解 = `chmod 644` 磁盘 + `git add`）。
- ⚠️ **别跑 `dart format`**（仓库不是 3.13 formatter clean）；⚠️ **别删 `.dart_tool/hooks_runner/`**（sqlite3 build hook 缓存）。
- ⚠️ macOS BSD 工具：`xargs` **不支持 `-a file`**（用 `xargs … < file`）；`grep` 不支持 `\|` **和 `^` 锚点** → 用专用 Grep 工具；zsh 会把 `--include=*.dart` 当 glob 展开。
- 验证后端**别只看 `dart analyze`** → 用 skill `serverpod-local-api-verify` 真发请求（`--noproxy '*'` + 关沙箱；种子密码 `asdf1234`）。删文档前先按**文件名**全仓扫引用 → skill `doc-prune-reference-safety`。
- ⚠️ **前端 `vite build` / `vue-tsc` 正确跑法**：`node_modules/.bin/*` 是 **sh wrapper**（用 `node` 直接跑报 `missing ) after argument list`）→ `sh node_modules/.bin/vue-tsc --noEmit` 或 `node node_modules/vite/bin/vite.js build`。⚠️ 沙箱往 `NODE_OPTIONS` 注入 `node-language-shim.cjs` → 关沙箱反而 `ECONNREFUSED broker.sock`；**正解 = `env -u NODE_OPTIONS -u CODEBUDDY_BROKERED_FS_HOOK_ENABLED …` + `dangerouslyDisableSandbox: true`**。
- ⚠️ **动用户在 App Studio 里启动的进程前必须先问**；8080/8081/8082 是**同一进程的三个端口**。
- `JWTExpiredException: jwt expired` + 全栈 ERROR 是**预期噪声**（1h 过期自动 refresh）。

## 资产 / Git
- ⚠️ `system_resources_2/` 是**嵌套 git 仓库**，`git add -A` 只记成 gitlink → 提交前 `git reset -- system_resources_2`。✅ 本地那份**已可删**（尚未删）。
- `flutter_web_client/` 是模板 typed client，无 App 在用（僵尸资产）。
- `flutter_web_server/apispec.json` **已删除**（2026-09-24）。它**不是 `serverpod generate` 产物** —— 第三方包 **`serverpod_openapi@0.0.3`** 在 `c052a07`（2026-03-29，Serverpod **3.4.4** 时期）挂 `/openapi` 时一次性导出的 Swagger 快照；`948513c`（2026-09-18 升 4.0）已删依赖 + `/openapi` 路由 → **停更、零消费者、`/api/**` 命中 0**。该包只读 typed 元数据，**原理上永远盖不到 REST 面**，所以「顺手重导一次」是错的说法。取证链条留档于 `docs/rest-api-layer.md` §8 待办 14。
- 提交 `a008181` **故意含硬编码调试 payload**，用户要求照原样提交，别当正常。
