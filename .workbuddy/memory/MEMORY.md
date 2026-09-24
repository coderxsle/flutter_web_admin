# flutter_web_admin 项目长期约定

> 细节 / 验证输出在 `.workbuddy/memory/YYYY-MM-DD.md` 与 `docs/`；本文件只留**跨会话必需的结论与指针**。

## 结构 / 目标
- `flutter_web_server/` Serverpod 4 后端（模型 `models/**/*.spy.yaml`、业务 `services/system/`、typed `endpoints/system/`、REST 层 `web/routes/api/`）；`gi_demo_admin/` Vue3+Arco 后台；`serverpod_crud/` 自研 CRUD 框架包。
- **目标**：所有接口走 Serverpod REST Route + 自动 CRUD（**不是关 8080**）。分支 `feature/web-server-rest-api`；提交风格中文单行「模块：动作」。
- 旧「两套基类陷阱」（业务版 `base_endpoint.dart` vs `BaseCrudEndpoint`）S5 已整份拆除，全仓只剩 `serverpod_crud` 一套。

## 文档指针（冲突时以此为准）
- 📖 契约 / 路由清单 / 接口分档 / 踩坑全集 = `docs/rest-api-layer.md`（§3 契约、§4 清单、§5 验证、§6 踩坑、§7 CORS、§8 缺口、§10 泛型层硬约束）；框架侧 `docs/serverpod_crud_architecture.md`。S1→S5 完成记录与 C 档 airtable/book/product 分档也在里面；HTTP 冒烟 85/85 是 S5 时期旧路由，别当现状。
- ⚠️ 已于 2026-09-24 删：`docs/rest-api-migration-plan.md`、`docs/gi-demo-提交分析与同步方案.md`、`flutter_web_server/docs/{auth_jwt_tasks_plan,mybatis_plus_style_refactor_sketch}.md`。别再找这四个。
- ⚠️ `docs/images/`（14 张 / 11MB）**不能删** —— 根 `README.md` 引用全部 14 张。

## S6 团队式 CRUD 契约（当前口径）
- `BaseRestRoute<T>` 产出 6 条字面子路径，**全仓不再有原生 REST 动词路由**：
  `GET {base}/getList`（过滤/分页走 query）、`GET {base}/getDetail?id=`（**id 走 query**）、
  `POST {base}/add`（201）、`POST {base}/update`（body 带 `id`，PATCH 语义）、
  `POST {base}/delete`（body `{"id":1}`，**返 boolean**）、`POST {base}/deleteBatch`（body `{"ids":[…]}`，**返 `CrudBatchResult`**）。
- 旧 8 条与 `updateMethods`/`enablePostAliases` 两开关已全删；**A 档挂载点下没有 `:id` 段**（`GET /api/user/5` = 404）；`PathTrie` 撞名约束只剩「动作路由之间」。`enableCreate: false`（现状只有 role）→ `POST {base}/add` 是 **404**（`PathMiss`），**不是 405**。
- 分页信封**刻意与 typed(8080) 不同**：REST 侧 `data` = `{records,total,page,pageSize,totalPage}`，typed 侧摊顶层。只由 `ServerpodEnvelopeBuilder` 一家收口，`flutter_web_shared` 不动。收口处 `success()` 里 **`data is PageResponse` 守卫必须在 `data is CommonResponse` 之前**（前者继承后者）。
- `removeBatch` 返 `CrudBatchResult`（`total/successCount/notFoundCount/successIds/failedIds`）—— Service 别只返 `{'total','successCount'}`，否则 `successIds/failedIds` 恒空。分页参数认 `pageSize` 优先、`size` 兜底。
- 离线断言 = `serverpod_crud` 34 + `flutter_web_server/test/web` 75 = **109**。真实 HTTP 冒烟脚本在 `/tmp/smoke_*.mjs`（**按要求不提交**），期望值/已知缺陷见 §5.2、跨租户见 §5.3。

## REST 最反直觉的几条（详版 §6）
- 挂 **8082**；8080=apiServer、8081=insights，**同一进程三端口**。改 Route 后**必须重启进程**，重启前先问用户。
- `addRoute`=`injectAt` → 同一挂载点只能挂一次；同路径多方法必须合并；`Map`/`RestActionRoute` **重复键静默覆盖**（方法凭空 404，`analyze` 不报）。
- **动作路由**（`/api/role/:id/menus`）参数名必须沿用 `:id`：`PathTrie` 同层不同参数名在**注册阶段**抛 → **服务起不来**（报错离原因很远）。
- 响应体必须走 `encodeForProtocol`（`jsonEncode` 遇 `DateTime` 会 500）；Service 已返 `CommonResponse` 时直接 `data.toJson()`（防双层信封）。
- ✅ 状态码口径（2026-09-24 统一）：业务失败一律 `200` + body `code`（含入参非法 / 资源不存在）。**只三种非 2xx**：401（未登录）、500（未预期异常）、404/405（路由未注册，空 body 不经信封）。落地点 = `RestEnvelopeBuilder.httpStatusFor(RestApiException)`，项目侧覆写成 `e.httpStatus == 401 ? 401 : 200` → **改口径只需改这一个方法**。固定码 `ServerpodEnvelopeBuilder._mapCode`：401→40100、403→40300、404/400→40400、500→50000；⚠️ `validateFailed` 与 not-found **共用 40400**（根治 = Service 语义化 code，§8.2 第 7 条）。
- 🔴 **不能给真实 4xx —— 前端会丢文案**（§6.9，动状态码前必读）：`gi_demo_admin/src/utils/http.ts` 按 **HTTP 状态码**分流 —— 2xx 分支读 body `code` 并显示服务端 `message`；非 2xx 分支只显示 `StatusCodeMessage[status]`、**丢弃 body**。⚠️ 前端 L168 `code === 401` 分支**永不命中**（REST 未登录返 `40100`），实际靠 L201 `status === 401` → **401 必须保留真实状态码**；**改状态码口径必须同时改这个拦截器**。
- 8082 **一条 Route 都没注册时 webServer 根本不启动**（不是 404）。`config/*.yaml` 的 `cors:` **只管 8080**；relic 中间件**路由级** → 每个子路径单独注册 `OPTIONS`。
- ⚠️ **刻意不一致**：not-found typed 返 `200+code50000`、REST 返 `404+40400`。
- 「自动产生 CRUD」真实边界 = HTTP 语义全自动，**数据映射仍需按资源写约 40 行 delegate**（`extends` 不用 `implements`；默认 lazy；`BaseRestRoute<T>` 只一个类型参数）。
- `session.tenantId`/`targetTenantId` 来自 `serverpod_crud` 的 `SessionExtension`（不是核心）。
- C 档 airtable：21 方法搬进 `AirtableService`、Endpoint 成薄壳、四张 `air_*` 表补 `tenantId`/`deleted`；🔴 删除仍是级联物理删、不落审计。S5 让 `UserEndpoint`/`ProductEndpoint` 退成裸 `Endpoint`，⚠️ **连带消失 6 条 typed 路由** → 前后端必须同时动。

## 关键业务约定
- 「系统内置不可编辑」= **服务层注入 `disabled`**（不是模型字段），前端读 `record.disabled`。
- 「内置」判断用 `isSuperuser`：`SysUser.type` 标 `!persist`，DB 无该列恒为 2，`type===1` 永不成立。
- **认证自己实现**：`auth_endpoint.dart` 薄转发 → `services/system/auth_service.dart`（不是 `serverpod_auth_idp_server`）。
- ✅ **删除的引用完整性 —— 四路收口（2026-09-24）**：① `UserService.delete` 级联软删 `sys_user_role`；② `dept.delete` 前置检查下级部门 + **部门下有用户则整批拒绝**；③ `menu.delete` 前置检查子菜单 + 级联软删 `sys_role_menu`；④ `RoleService.delete` 级联两张关联表（原有先例，另三条照它写，`role_service.dart:365-380`）。套路：`findAllByEngine(引擎, session, where: (t) => t.x.inSet(idsSet))`；`idsSet` 必须 `Set<int>`（`ColumnInt.inSet` 不收 `List`）；**同一批一起删的子孙不算孤儿**，要 `!idsSet.contains(c.id)` 过滤。⚠️ 影响面：13 个部门有 12 个挂用户，得先移出才能删（刻意）；`sys_role_menu_unique (roleId, menuId)` **不含 `deleted`**，软删行会挡住重新插入。
- ⚠️ 建树孤儿是**提升到顶层**（`!nodeMap.containsKey(parentId)` → `roots.add`），**不是子树消失** —— 早期文档写错过。`SysDept.name` 可空、`SysMenu.title` 非空（写 `?? ''` 会被 `dead_null_aware_expression` 拦）。

## Service / sys_menu / 性能
- Service 已收敛到 `BaseService`：保签名、内部换引擎（`SysXxx.db.*` → `SystemCrudEngines.<资源>`），6 个 A 档资源；入口 `services/system/crud_engines.dart`（lazy getter）；辅助 `buildCrudQuery`（默认 10 / 上限 100）、`findAllByEngine`（全表≠分页）、`condLike` 只传裸值。
- ⚠️ 四坑：① `QueryEngine.sort` 空时不排序 → 默认排序须显式 `sortAsc('id')`；② 租户过滤变严（无条件按 `session.tenantId`）→ 回归必须比 `total`；③ `delete` 必须两步（先 `update()` 落审计再 `delete()`）；④ `existing.tenantId = req.tenantId` 会被 `setTenantId` 覆盖（更安全，别当 bug 修）。
- ⚠️ 审计：6 引擎各注入 `DbAuditService`，但 `BaseService` 默认 `NoopAuditService`；查询审计插件 S5 连装配文件一起删 → 引擎用空 `CrudRuntime()`。`UserService` 的 `status` 默认过滤（`?? 1`）是旧代码原有 → 无 deptId 的 `total` 是 **15 不是 16**。
- `sys_menu` 租户化：补 `tenantId`（`20260924011107788`）；唯一约束按租户（`20260924020103589`）`(tenantId,title,parentId)` / `(tenantId,permission)` / `(tenantId,parentId,sort)`。⚠️ `permission` 必须进唯一键、默认 `''` 是真实值 → 同租户只能有一个不填 permission 的菜单，且约束**不含 `deleted`**。⚠️ 删未应用的迁移目录要同步清 `migrations/migration_registry.txt`。
- 性能基线：`getUserList` 的 dept 子树改**一次取全表 + 内存建树**。期望 `numQueries` 带 `deptId`=3 / 不带=2、`dept|role|menu.getList`=1；⚠️ 看到 4x = 被回退。`getUserList` 是服务端真分页（上限 100），role/menu/dept 仍是「全表 + 客户端切片」假分页。

## 前端（gi_demo_admin）—— ✅ S5 已切到 REST(8082)
- 真在用：system + user 两模块 + role/menu/dict/dept 部分方法；`/area /cate /file /test /v1/base/logout` 后端无对应 Endpoint（上游模板遗留，不动）。
- `apis/base.ts` 的 `getBaseApi` 被 7 个消费方共用（person/user/role/dept/menu/dict），**改它 = 改公共契约**。⚠️ `baseUrl` 必须与后端挂载点一致：`/user` `/role` `/menu` `/dept` `/dictCode`（字典 2026-09-24 由连字符改 **camelCase**，`apis/system/dict.ts` 已同步 ✅ `5f94bdb`）；`base.ts` 的 6 个方法全指向团队式子路径。
- ⚠️ `vue-tsc` 有 **60 条既有类型错误**（全上游模板遗留；S6 实测 0 新增 / -1）。全局 `Pagination = {page,size}` 与 `dict/index.vue`、`role/index.vue` 传的 `{page,pageSize}` 不一致 —— 后端两个都认，纯类型层问题。
- ⚠️ `ServerpodEnvelopeBuilder` 已剥 `password`/`__className__`；⚠️ `SysUser` **没有 `roleIds`**（只有 `postIds`），通用 update 会静默丢弃 roleIds。
- 首屏 `getUserList` 只应 1 次；`dept.getList` 由 `useDept` 模块级 in-flight Promise 去重。
- env：`.env.*` 的 `VITE_API_BASE_URL` 全指向 8082 的 `/api`（production 需 nginx `location /api/ { proxy_pass http://127.0.0.1:8082/api/; }`）。`utils/http.ts` 有 401 → refresh 流程（`refresh-token` 连字符）。
- 🔴 **4 个表单弹窗的保存是「模拟保存」**（`setTimeout` + `Message.success('模拟保存成功')`，完全不调接口）：`dict/DictDataFormModal.vue:149`、`dict/DictFormModal.vue:101`、`role/RoleFormModal.vue:102`、`menu/MenuFormModal.vue:275`（未做）。

## 环境 / 命令 / 已知坑
- **SDK 纪律（唯一口径）**：`analyze` / `test` / `generate` 全用 `~/fvm/versions/3.44.4/bin`（Dart 3.12.2）；`generate` 用 `PATH="$HOME/fvm/versions/3.44.4/bin:$PATH" ~/.pub-cache/bin/serverpod …`。⚠️ `~/fvm/default`（3.47）会炸 sqlite3 build hook `Invalid kernel binary format version` —— **遇到就 `rm -rf <pkg>/.dart_tool/hooks_runner`**（`shared/` 一起清，只删 `sqlite3/` 不够）；平时**别删**这个缓存目录。
- ✅ 生成物执行位噪音已修（`e22dfd1`）：`flutter_web_client/lib/src/protocol/` 44 个 `.dart` 755→644。⚠️ 别对全仓 755 批量 chmod —— `dai_shan_chu/scripts/*.sh` + `start.sh` 共 15 个是真脚本；勿用 `git update-index --chmod=-x`（正解 = `chmod 644` + `git add`）。
- ⚠️ 别跑 `dart format`（仓库不是 3.13 formatter clean）。
- ⚠️ macOS BSD 工具：`xargs` 不支持 `-a file`；`grep` 不支持 `\|` / `^` 锚点 → 用专用 Grep 工具；zsh 会把 `--include=*.dart` 当 glob 展开。沙箱里 `ps` 不可用（判断进程启动时间看日志 mtime）；本地无 `psql` → `docker exec development-postgres-1 psql -U postgres -d flutter_web_admin`，**列名 camelCase 必须加双引号**。
- 验证后端别只看 `dart analyze` → skill `serverpod-local-api-verify` 真发请求（`--noproxy '*'` + 关沙箱；种子密码 `asdf1234`）。删文档前按文件名全仓扫引用 → skill `doc-prune-reference-safety`。
- ⚠️ 前端 `vite build` / `vue-tsc`：`node_modules/.bin/*` 是 sh wrapper → `env -u NODE_OPTIONS -u CODEBUDDY_BROKERED_FS_HOOK_ENABLED sh node_modules/.bin/vue-tsc --noEmit` + `dangerouslyDisableSandbox: true`。
- ⚠️ **动用户在 App Studio 里启动的进程前必须先问**；8080/8081/8082 是同一进程三个端口。`JWTExpiredException: jwt expired` + 全栈 ERROR 是预期噪声。
- 🕐 **控制台日志时间 UTC = 硬编码，官方无时区配置**。要点：`serverpod.dart` 8 处 `.toUtc()` + `text_session_log_writer.dart:163`；TUI 走 `toLocal()`（只在真终端生效）；`SERVERPOD_SILENCE_LIFECYCLE_MESSAGES=1` 可整条静默生命周期消息。skill `serverpod-console-log-timezone`。

## 资产 / Git
- ✅ `system_resources_2/` 已于 2026-09-24 删除（不是任何包的依赖）。⚠️ 恢复（纯 CN 镜像机器才会报 `Could not load native library: libsysres-darwin-arm64.dylib`）：`mkdir -p flutter_web_server/lib/build && cp ~/.pub-cache/hosted/pub.dev/system_resources_2-*/lib/build/libsysres-darwin-arm64.dylib flutter_web_server/lib/build/`。
- `flutter_web_client/` 是模板 typed client，无 App 在用（僵尸资产）。`apispec.json` 已删（`serverpod_openapi@0.0.3` 的 Snapshot，零消费者）。
- 提交 `a008181` 故意含硬编码调试 payload，照原样提交，别当正常。
