# flutter_web_admin 项目长期约定

> 细节 / 验证输出在 `.workbuddy/memory/YYYY-MM-DD.md` 与 `docs/`；本文件只留**跨会话必需的结论与指针**。

## 结构 / 目标
- `flutter_web_server/` Serverpod 4 后端（模型 `models/**/*.spy.yaml`、业务 `services/system/`、typed `endpoints/system/`、REST 层 `web/routes/api/`）；`gi_demo_admin/` Vue3+Arco 后台；`serverpod_crud/` 自研 CRUD 框架包。
- **目标**：所有接口走 Serverpod REST Route + 自动 CRUD（**不是关 8080**）。分支 `feature/web-server-rest-api`；提交风格中文单行「模块：动作」。
- ⚠️ 旧「两套基类陷阱」（业务版 `base_endpoint.dart` vs `BaseCrudEndpoint`）**S5 已整份拆除**，全仓只剩 `serverpod_crud` 一套。

## 文档指针（冲突时以此为准）
- 📖 契约 / 路由清单 / 踩坑全集 = `docs/rest-api-layer.md`（§3 契约、§4 清单、§5 验证、§6 踩坑、§7 CORS、§8 缺口、§10 泛型层硬约束）；框架侧 `docs/serverpod_crud_architecture.md`。
- 进度：S1→S5 全部完成（`1528dfb`/`8e1d1c8`/`00e375c`/`73280d2`/`f664aeb`），HTTP 冒烟 85/85（S5 时期、旧路由）；**S6 团队式 CRUD（2026-09-24）离线断言 105/105**。
- ⚠️ 已于 2026-09-24 删：`docs/rest-api-migration-plan.md`、`docs/gi-demo-提交分析与同步方案.md`、`flutter_web_server/docs/{auth_jwt_tasks_plan,mybatis_plus_style_refactor_sketch}.md`。**别再找这四个文件。**
- ⚠️ `docs/images/`（14 张 / 11MB）**不能删** —— 根 `README.md` 引用了全部 14 张。

## S6 团队式 CRUD 契约（2026-09-24，**当前口径**）
- `BaseRestRoute<T>` 产出 **6 条字面子路径**，**全仓不再有原生 REST 动词路由**：
  `GET {base}/getList`（过滤/分页走 query）、`GET {base}/getDetail?id=`（**id 走 query**）、
  `POST {base}/add`（201）、`POST {base}/update`（body 带 `id`，PATCH 语义）、
  `POST {base}/delete`（body `{"id":1}`，**返 boolean**）、`POST {base}/deleteBatch`（body `{"ids":[…]}`，**返 `CrudBatchResult`**）。
- ⚠️ 旧 8 条（`GET /`、`GET /:id`、`PUT|PATCH /:id`、`DELETE /:id`、`DELETE /` + 两条 POST 别名）
  与 `updateMethods`/`enablePostAliases` 两个开关**已全部删除**；**A 档挂载点下没有 `:id` 段**（`GET /api/user/5` = 404），
  `PathTrie` 撞名约束只剩「动作路由之间」。
- ⚠️ `enableCreate: false`（现状只有 role）→ `POST {base}/add` 是 **404**（`PathMiss`），**不是 405**。
- ⚠️ 分页信封**刻意与 typed(8080) 不同**：REST 侧 `data` = `{records,total,page,pageSize,totalPage}`（元信息全进 `data`），
  typed 侧元信息摊顶层。只由 `ServerpodEnvelopeBuilder` 一家收口，`flutter_web_shared` 不动。
  收口处 `success()` 里 **`data is PageResponse` 守卫必须放在 `data is CommonResponse` 之前**（前者继承后者），
  且 `page(RestPage)` 与 `success(PageResponse)` 两条支路折成同一形状。
- ⚠️ `removeBatch` 返回 `CrudBatchResult`（5 字段 `total/successCount/notFoundCount/successIds/failedIds`）——
  Service 里**别只 `CommonResponse.success({'total','successCount'})`**，那会让 `successIds/failedIds` 恒空。
- ⚠️ 分页参数认 `pageSize` **优先**、`size` 兜底；`RestActionRoute`/`Map` **重复键静默覆盖**（方法凭空 404，`analyze` 不报）。
- 离线断言：`serverpod_crud` **34** + `flutter_web_server/test/web` **75** = **109**（2026-09-24 用 `~/fvm/versions/3.44.4/bin` 重跑，109/109 ✅）。
  ⚠️ 必须用 3.44.4 那个 SDK —— `~/fvm/default`（3.47）跑会在 sqlite3 build hook 上炸 `Invalid kernel binary format version`（**方向会反过来**：先 `expected 138, found 130`，清缓存后变 `expected 130, found 138`）。
  ⚠️ **遇到那个报错就 `rm -rf <pkg>/.dart_tool/hooks_runner`**（会按当前 SDK 重建）—— 比死磕 PATH 有效，`shared/` 子目录也要一起清。
- ✅ **团队式路径的真实 HTTP 冒烟已于 2026-09-24 跑过**（脚本 `/tmp/smoke_team_crud.mjs` 54 条 + `smoke_tenant.mjs` 12 条 + `smoke_dict_cleanup.mjs` 8 条；**按用户要求不提交**）。
  覆盖 `/api/auth` 3 条 + 鉴权边界、A 档 6 资源 × 6 子路径、B 档动作、负向状态码、CORS/OPTIONS 预检、user/dict 写入全链路（含级联软删）。
  期望值/已知缺陷见 `docs/rest-api-layer.md` §5.2、跨租户表在 §5.3。⚠️ 改 Route **必须重启进程**；重启前先问用户（那是他在 App Studio 里拉的）。

## REST 最反直觉的几条（详版 §6）
- 挂 **8082**；8080=apiServer、8081=insights，**同一进程三端口**。改 Route 后**必须重启进程**。
- `addRoute`=`injectAt` → **同一挂载点只能挂一次**；**同路径多方法必须合并**；⚠️ `Map`/`RestActionRoute` **重复键静默覆盖**（方法凭空 404），`analyze` 不报。
- **动作路由**（`/api/role/:id/menus` 等）的参数名**必须沿用 `:id`**：`PathTrie` 同层不同参数名在**注册阶段**抛 → **服务起不来**（报错离原因很远）。A 档 CRUD 已无参数段（见上）。
- `handleCall` 正常返回**一律 200**。响应体必须走 `encodeForProtocol`（`jsonEncode` 遇 `DateTime` 会 500）；Service 已返 `CommonResponse` 时直接 `data.toJson()`（防双层信封）。
- ✅ **状态码口径已于 2026-09-24 统一：业务失败一律 `200` + body `code`**（含入参非法 / 资源不存在）。
  **只三种非 2xx**：**401**（未登录，唯一「业务相关」的例外）、500（未预期异常）、404/405（路由未注册，**空 body 不经信封**）。
  落地点 = 框架新增的扩展点 `RestEnvelopeBuilder.httpStatusFor(RestApiException)`（默认原样透出 = HTTP 语义优先），
  项目侧 `ServerpodEnvelopeBuilder` 覆写成 `e.httpStatus == 401 ? 401 : 200`。**改口径只需改这一个方法。**
  固定码映射仍在 `ServerpodEnvelopeBuilder._mapCode`：401→40100、403→40300、404/400→40400、500→50000。
  ⚠️ `validateFailed`（入参不合法）与 not-found **共用 40400**，只能靠 `message` 区分（根治 = Service 语义化 code，§8.2 第 7 条）。
- 🔴 **为什么不能给真实 4xx —— 前端会丢文案**（`docs/rest-api-layer.md` §6.9，动状态码前必读）：
  `gi_demo_admin/src/utils/http.ts` 按 **HTTP 状态码**（不是 body `code`）分流成两个拦截器 ——
  HTTP **2xx** 分支读 body `code` 并 `Message.error(message)` 显示**服务端原文**；
  HTTP **非 2xx** 分支只 `Message.error(StatusCodeMessage[status])`（`400:'请求错误(400)'`、`404:'请求出错(404)'`）、
  **丢弃 body、从不读 message**。所以业务失败一旦走 4xx，「昵称不能为空」这类提示永远到不了用户眼前。
  ⚠️ 前端 L168 的 `code === 401` 分支**永不命中**（REST 未登录返的是 `40100`），实际靠 L201 `status === 401` ——
  所以 **401 必须保留真实状态码**，压成 `200 + 40100` 会让 refresh token 整条失效。
  **改状态码口径必须同时改这个拦截器。**
- `session.tenantId`/`targetTenantId` 来自 `serverpod_crud` 的 `SessionExtension`（**不是核心**）→ 必须 import `serverpod_crud`。
- 8082 **一条 Route 都没注册时 webServer 根本不启动**（不是 404）。`config/*.yaml` 的 `cors:` **只管 8080**；relic 中间件**路由级** → 每个子路径单独注册 `OPTIONS`。
- ⚠️ **刻意不一致**：not-found typed 返 `200+code50000`、REST 返 `404+40400`。
- 「自动产生 CRUD」真实边界 = HTTP 语义全自动，**数据映射仍需按资源写约 40 行 delegate**（`extends` 不用 `implements`；默认 lazy；`BaseRestRoute<T>` 只一个类型参数）。

## S4 airtable / S5 退役（详版留在 docs）
- airtable：21 方法搬进 `AirtableService`，Endpoint 成**薄壳**；路由**全手写 `RestActionRoute`**；四张 `air_*` 表补 `tenantId`/`deleted`。🔴 **删除仍是级联物理删、不落审计**。
- S5 删 5 个已退役文件、`UserEndpoint`/`ProductEndpoint` 退成裸 `Endpoint`。⚠️ **退裸连带消失 6 条 typed 路由**（继承来的）→ **前后端必须同时动**。

## 关键业务约定
- 「系统内置不可编辑」= **服务层注入 `disabled`**（不是模型字段），前端读 `record.disabled`。直接 `CommonResponse.success(list)` **没有** `disabled`。
- 「内置」判断用 `isSuperuser`：`SysUser.type` 标 `!persist`，DB 无该列恒为 2，`type===1` 永不成立。
- **认证自己实现**：`auth_endpoint.dart` 薄转发 → `services/system/auth_service.dart`（**不是** `serverpod_auth_idp_server`）。

## Service 收敛到 BaseService（已落地）
- **保签名、内部换引擎**（`SysXxx.db.*` → `SystemCrudEngines.<资源>`），6 个 A 档资源；入口 `services/system/crud_engines.dart`（**lazy** getter）；辅助 `buildCrudQuery`（默认 10 / 上限 100）、`findAllByEngine`（**全表**≠分页）、`condLike` 只传**裸值**。
- ⚠️ 四坑：① `QueryEngine.sort` 空时**不排序** → 默认排序须显式 `sortAsc('id')`；② **租户过滤变严**（无条件按 `session.tenantId`）→ 回归必须比 `total`；③ **`delete` 必须两步**（先 `update()` 落审计再 `delete()`）；④ `existing.tenantId = req.tenantId` 会被 `setTenantId` 覆盖（更安全，别当 bug 修）。
- ⚠️ 审计：6 引擎各注入 `DbAuditService`，但 `BaseService` 默认 **`NoopAuditService`**；查询审计插件在 S5 连装配文件一起删了 → 引擎用空 `CrudRuntime()`，**查询审计 / 分页校验 / `contains` 都不在链路里**。
- ⚠️ `UserService.delete` 没级联清 `sys_user_role` —— **2026-09-24 已修**（`user_service.dart` 里 `delete()` 后按 `userId + tenantId + deleted=false` 软删 `sys_user_role`）；`status` 默认过滤（`?? 1`）是旧代码原有 → 无 deptId 的 `total` 是 **15 不是 16**。
- 🔴 **`POST /api/dept/delete` / `POST /api/menu/delete` 不检查子节点**（2026-09-24 冒烟撞出，**未修**，§8.3 第 14 条）：
  收 id 直接 `deleteBatch`（`dept_service.dart:205-221`、`menu_service.dart:60-86`），无 children 前置查询。
  删有子节点的父级会返 `200 {"code":20000,"data":true}`，父被软删、**子节点全成孤儿**（前端建树时整棵子树消失）。上游模板与前端同样没挡。

## 接口分档（**退役后**口径）
- **A 档 CRUD 6**：user/dept/role/menu/dictCode/dictData ✅S2 ｜ **B 档 12**：auth×3 + user×3 + role×4 + menu×1 + dict×2 + system×2 ✅S3 ｜ **C 档**：airtable 5/21 ✅S4、book（示例）、product（半成品）。
- typed 通用规则（公开方法自动变路由、**删方法=删路由**、body 用参数名做外层 key）见 §6。

## sys_menu 租户化
- 补 `tenantId`（迁移 `20260924011107788`）；唯一约束改按租户（`20260924020103589`）：`(tenantId,title,parentId)`、`(tenantId,permission)`、`(tenantId,parentId,sort)`。⚠️ `permission` **必须进唯一键**；查重靠 DB，**不需要改 Dart**。
- 边界：`permission` 默认 `''` 且是真实值 → **同租户只能有一个不填 permission 的菜单**；唯一约束**不含 `deleted`**。⚠️ 删未应用的迁移目录要**同步清 `migrations/migration_registry.txt`**。

## 前端（gi_demo_admin）—— ✅ S5 已切到 REST(8082)
- **真在用的是 system + user** 两模块 + role/menu/dict/dept 的部分方法；`/area /cate /file /test /v1/base/logout` 后端**无对应 Endpoint**（上游模板遗留，不动）。
- `apis/base.ts` 的 `getBaseApi` 被 **7 个消费方**共用（person/user/role/dept/menu/dict），**改它 = 改公共契约**。⚠️ `baseUrl` 必须与后端挂载点一致：`/user` `/role` `/menu` `/dept` `/dictCode`。字典两资源 2026-09-24 起由连字符改为 **camelCase**（`/api/dictCode`、`/api/dictData`）；⚠️ 前端 `apis/system/dict.ts`（`baseUrl` + `/dict…/getList` + `/dict…/getDetail`）**当时未同步 → 字典模块 404，待修**。`base.ts` 的 6 个方法全部指向团队式子路径。
- ⚠️ 前端 `vue-tsc` 有 **60 条既有类型错误**（全上游模板遗留；S6 实测**改前后 0 新增 / -1**）。其中全局 `Pagination = {page,size}` 与部分页面传 `{page,pageSize}` 口径不一致（`dict/index.vue`、`role/index.vue`）—— 后端两个都认，纯类型层问题。
- ⚠️ `ServerpodEnvelopeBuilder` 已剥 `password`/`__className__`；⚠️ `SysUser` **没有 `roleIds`**（只有 `postIds`），通用 update 会**静默丢弃 roleIds**。
- 首屏 `getUserList` 只应 1 次；`dept.getList` 由 `useDept` 模块级 in-flight Promise 去重。
- env：`.env.*` 的 `VITE_API_BASE_URL` 全指向 **8082 的 `/api`**（production 需 nginx `location /api/ { proxy_pass http://127.0.0.1:8082/api/; }`）。`utils/http.ts` 有 401 → refresh 流程（`refresh-token` 连字符）。
- 🔴 **4 个表单弹窗的保存是「模拟保存」**（`setTimeout` + `Message.success('模拟保存成功')`，**完全不调接口**）：`dict/DictDataFormModal.vue:149`、`dict/DictFormModal.vue:101`、`role/RoleFormModal.vue:102`、`menu/MenuFormModal.vue:275`（任务 #15，未做）。

## 性能基线
- `getUserList` 的 dept 子树已改**一次取全表 + 内存建树**（queries 46→2）。期望 `numQueries`：带 `deptId`=**3**、不带=**2**。⚠️ 看到 4x = 被回退。`getUserList` 是**服务端真分页**（上限 100）；**role/menu/dept 仍是「全表 + 客户端切片」假分页。**

## 环境 / 命令 / 已知坑
- `dart analyze`/`dart test` 用 `~/fvm/default/bin/dart`（Dart 3.13.0）；项目本身 fvm 3.44.4 = Dart 3.12.2 → **混用留内核版本冲突**。`serverpod generate` 用 `PATH="$HOME/fvm/versions/3.44.4/bin:$PATH" ~/.pub-cache/bin/serverpod …`。
- ✅ **生成物执行位噪音已修**（`e22dfd1`）：`flutter_web_client/lib/src/protocol/` 44 个 `.dart` 755→644。⚠️ **别对全仓 755 批量 chmod** —— `dai_shan_chu/scripts/*.sh` + `start.sh` 共 15 个是**真脚本**。⚠️ 勿用 `git update-index --chmod=-x`（正解 = `chmod 644` 磁盘 + `git add`）。
- ⚠️ **别跑 `dart format`**（仓库不是 3.13 formatter clean）；⚠️ **别删 `.dart_tool/hooks_runner/`**（sqlite3 build hook 缓存）。
- ⚠️ macOS BSD 工具：`xargs` **不支持 `-a file`**；`grep` 不支持 `\|` **和 `^` 锚点** → 用专用 Grep 工具；zsh 会把 `--include=*.dart` 当 glob 展开。
- 验证后端**别只看 `dart analyze`** → skill `serverpod-local-api-verify` 真发请求（`--noproxy '*'` + 关沙箱；种子密码 `asdf1234`）。删文档前按**文件名**全仓扫引用 → skill `doc-prune-reference-safety`。
- ⚠️ **前端 `vite build` / `vue-tsc`**：`node_modules/.bin/*` 是 **sh wrapper** → `env -u NODE_OPTIONS -u CODEBUDDY_BROKERED_FS_HOOK_ENABLED sh node_modules/.bin/vue-tsc --noEmit` + `dangerouslyDisableSandbox: true`。
- ⚠️ **动用户在 App Studio 里启动的进程前必须先问**；8080/8081/8082 是**同一进程的三个端口**。`JWTExpiredException: jwt expired` + 全栈 ERROR 是**预期噪声**。

## 资产 / Git
- ✅ `system_resources_2/` 已于 2026-09-24 删除（**不是任何包的依赖**；只是 macOS dylib workaround 的取货点）。⚠️ **恢复（纯 CN 镜像机器才会报 `Could not load native library: libsysres-darwin-arm64.dylib`）**：`mkdir -p flutter_web_server/lib/build && cp ~/.pub-cache/hosted/pub.dev/system_resources_2-*/lib/build/libsysres-darwin-arm64.dylib flutter_web_server/lib/build/`。
- `flutter_web_client/` 是模板 typed client，无 App 在用（僵尸资产）。`apispec.json` 已删（是 `serverpod_openapi@0.0.3` 的 Snapshot，非 generate 产物，零消费者）。
- 提交 `a008181` **故意含硬编码调试 payload**，照原样提交，别当正常。
