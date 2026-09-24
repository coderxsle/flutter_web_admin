# flutter_web_admin 项目长期约定

## 结构
- `flutter_web_server/`：Serverpod 4 后端。模型 `lib/src/models/**/*.spy.yaml`（部分在 `flutter_web_shared/`），业务 `lib/src/services/system/*_service.dart`，typed 端点 `lib/src/endpoints/system/*_endpoint.dart`，REST 表现层 `lib/src/web/routes/api/`。
- `gi_demo_admin/`：Vue3 + Arco 后台。`serverpod_crud/`：自研 CRUD 框架包。
- ⚠️ `base_endpoint.dart`（业务版，返 `CommonResponse`）与 `serverpod_crud` 的 `BaseCrudEndpoint` **两套基类并存**，混用会运行时 cast 崩，`dart analyze` 抓不到。

## 关键约定
- **「系统内置不可编辑」= 后端服务层注入 `disabled`**（不是模型字段）。参考 `role_service.getList`、`user_service.getUserList`。前端读 `record.disabled`，`hooks/useTable.ts` 的 `selectAll` 也用它。**直接 `CommonResponse.success(list)` 返回原始模型的响应里不会有 `disabled`。**
- 判断「内置」用 `isSuperuser`：`SysUser.type` 标了 `!persist`（DB 无该列，恒为 2），`type === 1` 永不成立。

## BaseEndpoint 通用 CRUD 契约
- `POST /<endpoint>/<method>`，body 用**参数名做外层 key**（`{"data":{…}}`/`{"query":{…}}`/`{"req":{…}}`）。键名错 → `400 Missing required query parameter`。参数名以 `lib/src/generated/endpoints.dart` 的 `MethodConnector` 为准。
- `add`/`update` 的 `data` 是 `dynamic`，经 `deserialize<T>` → 模型 `fromJson`，**无校验层**。
- ⚠️ **`update` 是整行覆盖**：`decodeModel` 从 payload 造全新模型、**没有 merge**。缺 `password` → 置 NULL（且它 `serverOnly`，前端拿不到，所以通用 update 改用户必清空密码）；缺 `authUserId` → 断登录关联；缺 `createTime` → 重置为 now；缺 `username`/`nickname` → 500（非空断言）。
- 不能靠收窄形参类型自定义 `update`（`dynamic` 是 top type，报 `invalid_override`）；`dynamic`/`Map<String,dynamic>` 形参也收不了普通 JSON 对象（要求带类型标签线格式），**只能声明成 `String` + `jsonDecode`**。
- ✅ `updateByJsonParams` = **PATCH 语义**（先读当前行做基线，只让请求里出现过的 key 覆盖）；`addByJsonParams` = JSON 文本版新增。形参都是 **`params`/`String`**，body `{"params":"{\"id\":2,\"deptId\":5}"}`。**改名后必须 `serverpod generate`**。merge 要用 `toJson()`（`toJsonForProtocol()` 不含 serverOnly）。
- 公共逻辑：`endpoints/utils/json_param_codec.dart` 的 `JsonParamCodec.decodeObject`；`base_endpoint.dart` 私有辅助 `_knownFieldNames`/`_splitFieldNames`/`_extractPrimaryKey`/`_describeUnknownFields`。新增同类接口照抄。

## REST 表现层（2026-09-23，分支 `feature/web-server-rest-api`）
- 定位：`Route` 只是**表现层**，不碰 ORM；与 typed Endpoint **共用 `services/system/*_service.dart`**。详见 **`docs/rest-api-layer.md`**（§1–§9 = 当前形态 / 契约 / 接口清单 / 踩坑实测，§10 = 泛型层的设计依据）；路线见 `docs/rest-api-migration-plan.md`。
- 挂在 **8082**（`webServer`）；8080=apiServer、8081=insights，**同一个进程三个端口**，不是重复启动。
- **路径统一单数**：`/api/user`（与 typed Endpoint 资源名一致）。⚠️ 早期手写 Route 曾误挂复数 `/api/users`，2026-09-23 核查后已连同文档一并改回单数。**改挂载点字符串也必须重启进程才生效。**
- 关键坑：① `addRoute` **同一挂载点只能挂一次**（relic `Conflicting values`）→ 手写形态用 `ApiMount`，泛型形态已内置在 `BaseRestRoute.injectIn`；② **relic 中间件是路由级**的，OPTIONS 未注册路由就 405、中间件不跑 → 要给每个子路径补注册 OPTIONS；③ relic 2.0 的 `Headers` 值是 `Iterable<String>`，`headers:{'k':'v'}` 编译不过，`copyWith(headers:)` 是整体替换；④ Service 失败只有 `code 50000` 一个粒度，401/404 只能表现层补；⑤ `config/*.yaml` 的 `cors:` **只管 API server(8080)**，8082 不看 → 自建 `CorsMiddleware`（白名单 + 回显 origin + `Vary: Origin`）。
- 新增/改 Route 后**必须重启进程**（`run()` 只跑一次，`addRoute` 不随热重载重跑）。
- **泛型 REST 层**（2026-09-23 新增）：`serverpod_crud/lib/src/web/rest_crud.dart` 提供 `BaseRestRoute<T>` + `RestCrudDelegate<T>` + `pod.registerCrud/registerAutoCrud`，挂载一次**自动产出 8 条路由**；测试 `serverpod_crud/test/rest_crud_route_test.dart`（**17 断言**）。接缝是 `RestCrudDelegate`（收 `Map<String,dynamic> body`）+ `RestEnvelopeBuilder`（业务项目提供 `{code,message,data}` 信封）。
  - ⚠️ **`serverpod_crud` 的 REST 层与 `flutter_web_server` 的 `api_route.dart` 现在是两套基类并存**，是 `base_endpoint.dart` 那个老陷阱的翻版，待合并（**S1.5**）。这个风险同时写在 `rest-api-layer.md` **§2.2 / §8 待办 6 / §10.7**，**是同一件事，别当成三个问题**。
  - ⚠️ `BaseRestRoute` 是**模板方法**，不是「零代码」：用户资源有 5 处 per-resource 逻辑（`disabled` 注入 / dept 子树 / 9 个专用过滤字段 / RSA 密码 / `roleIds` 关联表），必须覆写 hook。
  - `deserialize<T>(普通Json, T)` **接受普通 JSON**（命中 `T.fromJson` 分支）；只有 `deserializeDynamicFieldValue` 才要 `{className,data}` 线格式。所以自动 delegate 不用客户端额外包装。
  - `AutoRestCrudDelegate.update` 的 merge 基线用 **`toJson()`**（含 serverOnly），用 `toJsonForProtocol()` 会把 `password` 写成 NULL。

## REST 化重构（2026-09-23，目标已澄清）→ 方案见 `docs/rest-api-migration-plan.md`
- **目标是后端接口的实现方式重构**：所有接口改用 Serverpod REST Route 实现 + **CRUD 自动产生**（不是关 8080）。前端等后端完成后再重建调用层。
- ⚠️ **用户明确纠正过一次**：不要把「关闭 8080」当目标。`apiServer` 关不掉（`features.dart` 无 `enableApiServer`；`serverpod.dart:1247` 无条件 `server.start()`），但**也不需要关**。
- ⚠️ **`Features.enableWebServer()` 反向陷阱**：`if (server != null && !server.hasApp) return false` → 8082 一条 Route 都没注册时 webServer **根本不启动**（不是 404）。别把路由全注释掉。
- ⚠️ 绑定地址硬编码 `InternetAddress.anyIPv6`（`server.dart:181` / `web_server.dart:151`），配置改不了 —— 仅当需要收紧暴露面时才相关。

### 接口全清单（15 Endpoint / 78 方法，三档分类）
- **A 档 标准 CRUD（6 个）**：user / dept / role / menu / dictCode / dictData。
- **B 档 业务动作（12 个）**：auth×3、user(getUserInfo/getUserRoutes/resetPassword)、role×4(权限/成员)、menu(getMenuOptions)、dict(getDictData/getDictDataDetail)、system(health/version)。
- **C 档 子系统/示例**：airtable 4 个 Endpoint（17 方法，是「表/字段/行/关系」子系统，**别套 CRUD**）、book（Serverpod 示例）、product（半成品，只有 getDetail/getPriceList）。
- ⚠️ `ProductEndpoint extends BaseEndpoint<Book, BookTable>` —— **类型参数是 Book 不是 Product**，复制粘贴遗留。
- ⚠️ **`sys_menu` 表里没有 `tenantId` 列** → `registerAutoCrud` 会在构造期抛 `ArgumentError`（`base_service.dart:27-40` 的 `_crudFindIntColumn` 找不到列就抛）。menu 必须自定义 delegate。
- ⚠️ **6 个 A 档资源没有一个能 `registerAutoCrud` 零覆写**：user(5 处特殊逻辑)、dept(返树+批量删)、role(无 add+批量删+关联表)、menu(无 tenantId+返树)、dict×2(入参类型不一致)。「自动产生 CRUD」的真实边界 = **5 条路由 + HTTP 语义全自动，数据映射按资源写一个 delegate（约 40 行）**。
- ⚠️ **6 个里有 4 个是批量删**（dept/role/menu/dict），只有 user 单条 → `RestCrudDelegate` 必须加 `removeBatch`；dept/menu 列表返回树 → `list` 要允许返回非分页载荷。这两条是 S0 的必做项。
- **要退役的**：`addByJsonParams`/`updateByJsonParams`（`endpoints/system/base_endpoint.dart:162/275`，纯为解码限制打的补丁）、`endpoints/system/base_endpoint.dart`（业务版，与 `serverpod_crud` 的 `BaseCrudEndpoint` 两套并存）、`UserEndpoint`/`ProductEndpoint` 对 `BaseEndpoint` 的继承。

### 泛型 REST 层的能力（2026-09-23 S0 已完成，`serverpod_crud/lib/src/web/rest_crud.dart`）
- **目标形态**：`class UserRestRoute extends BaseRestRoute<SysUser> {}`（空类体）或 `pod.registerCrud<SysUser>('/api/user');` —— 已验证在真实模型上编译通过（`flutter_web_server/lib/src/web/routes/api/user_rest_route.dart`，只做编译证明、**未注册**）。
- **自动产出 8 条路由**：`GET /`、`GET /:id`、`POST /`(201)、`PUT|PATCH /:id`、`DELETE /:id`、`DELETE /`、`POST /update`、`POST /delete`。后三条由 `enableBatchDelete` / `enablePostAliases` 控制（默认开；加 POST 形式是因为**项目基本上只用 GET、POST**）。
- ⚠️ **`BaseRestRoute<T>` 只需一个类型参数**，依据：`Table` 是 `Table<T_ID>` 泛型类（`serverpod_database/src/concepts/table.dart:50`，`id` 是 `ColumnComparable<T_ID>`），而 `serverpod_crud` 取列取表**都是反射式**（`_crudFindColumn` 遍历 `table.columns`；`getTableForType(T)`）→ `TTable` 可直接填**裸 `Table`**，`SysUserTable extends Table<int?>` 因协变而 `is Table` 成立。**不要再退回双类型参数。**
- ⚠️ **默认 delegate 是 lazy 的**（`late final` 推到首次请求）：路由注册在 `pod.start()` 之前，而 `CrudEntityMeta.auto()` 会立刻读 `SerializationManager` + 表列。别再改成构造期装配。
- ⚠️ **实现 delegate 要用 `extends` 不要 `implements`**：`RestCrudDelegate.removeBatch` 有默认实现，`implements` 会要求把它也重写（已实测报 `non_abstract_class_inherits_abstract_member`）。
- 测试：`serverpod_crud/test/rest_crud_route_test.dart`，**17 断言**，含「8 条子路由能注入同一个 `RelicRouter` 不冲突」（钉住第一大坑）。
- ⚠️ 潜在命名冲突：`flutter_web_server` 的 `api_route.dart` 也定义了 `asIntOrNull` / `ApiRequestExtension`，而 `serverpod_crud` 现在也 export 了同名 `asIntOrNull` / `RestRequestExtension`。同一文件同时 import 两者会报歧义。这正是「两套基类并存」要收口的原因（P1/S1.5）。

### 用户已拍板的决策（2026-09-23）
1. URL **沿用**现有资源名 → **单数** `/api/user`。⚠️ 代码原先实际挂的是复数 `/api/users`，2026-09-23 核查出来后用户拍板统一单数，**已改代码（`api_routes.dart` 挂载点 + 4 处注释）与两份文档**。改动需**重启进程**才对真实 HTTP 生效。
2. 批量删**走 POST**（项目基本上只用 GET、POST）
3. A 档 6 个资源**全做**（即使前端没在用 dept/menu 的 CRUD）
4. **先收敛到 `BaseService<T, TTable>`** —— 最大一项。注意：收敛 ≠ 零覆写，用户/部门/角色/菜单/字典各有盖不住的特殊逻辑；且 **`sys_menu` 无 `tenantId` 列** 需先定方案（改表或让 BaseService 支持「无租户列」模式）。建议先做 user + dict 两个验证，别一次动 9 个 Service。
5. airtable **最后再改**

### 前端实际在调的接口（决定优先级）
`gi_demo_admin/src/apis/**` 里真在用的只有 **`system` + `user` 两个模块**：`/auth/login`、`/auth/refreshToken`、`/user/{getUserInfo,getUserRoutes,getUserList,userUpdate,resetPassword}`、`/role/{getRoleMenuIds,getRoleUsers,cancelUserRoles,saveRolePermissions}`、`/menu/getMenuOptions`、`/system/dict/{getDictData,getDictDataList,getDictDataDetail}`。
- ⚠️ `/area/*`、`/cate/*`、`/file/*`、`/test/*`、`/v1/base/logout`、`/user/userAdd` 在后端**没有对应 Endpoint** → gi-demo 上游模板遗留（`/user/userAdd` 那个调用可能已经是坏的）。
- **前端没有在用 dept/menu 的 CRUD、也没用 airtable** → 这些可以推迟到前端改造时再做。

### 其它
- **认证是自己实现的**：`auth_endpoint.dart` 只有 3 个薄转发 → `services/system/auth_service.dart`。**不是** `serverpod_auth_idp_server` 的 IdpEndpoint 子类 → 复刻到 REST 是纯表现层工作，零业务改动。
- `flutter_web_client/` 是模板生成的 typed client 包，仓库里没有 Flutter App 在用它（僵尸资产）。
- ⚠️ **现存配置 bug**：`config/development.yaml` 的 `cors:` 是 `origin: '*'` + `credentials: true`，两者互斥，浏览器会拒绝（只管 8080；8082 用的自建 `CorsMiddleware` 是正确的白名单+回显）。

## Service 层实际形态（2026-09-23 核对，做通用化前必看）
9 个 Service **没有一个符合统一 CRUD 契约**，四类不一致：① 实例（`UserService`）vs 静态（其余全部）；② 单条删（只有 User）vs `delete(List<int>)` 批量；③ 列表返回**树**（Dept）/ 分页（User）/ 全表（其余）；④ 每家一个专用 Request 模型（`UserRequest`/`DeptRequest`/`MenuRequest`/`DictCodeRequest`），`RoleService` 更新直接收 `SysRole` 且**没有 add**；`DictService` 一个类塞了 code+data 两个资源。`serverpod_crud` 里其实**已有** `BaseService<T,TTable>`（含 create/update/delete/get/getList/deleteBatch）+ `BaseEndpoint<T,TTable>`，只是业务代码全都没用。

## 其它已知坑
- ⚠️ **Endpoint 子类的公开方法会自动变成 HTTP 路由**，加辅助逻辑必须下划线私有。
- ⚠️ **别删 `.dart_tool/hooks_runner/`** —— 里面有 sqlite3 build hook 的下载缓存，删了会重新去 GitHub 下载 `libsqlite3.arm64.macos.dylib`，本机网络不通直接起不来（`Building assets for package:sqlite3 failed`）。
  - ⚠️ 再更正（2026-09-23 21:50 核对）：`flutter_web_server/pubspec.yaml` 已**整段回滚**成原始 23 行（连注释都没有），`git status` 里也不再显示它。**唯一兜底就是 `hooks_runner` 缓存**，改动回滚不影响启动。别去"恢复"那段配置，也别删缓存。
- **Dart 版本**：项目用 fvm **3.44.4 = Dart 3.12.2**；`~/fvm/default` 是 3.47.0 = Dart 3.13.0。混用会在 `.dart_tool/` 留内核版本冲突（报 `expected 130, found 138`）。
- `dart analyze` 问题数突然暴涨（2→143）时，先看最近那次编辑的括号/注释有没有改坏，那些 lint 都是并发症。
- `user_service.dart` 顶部 2 个未使用 import，常驻 2 warning，属既有遗留。
- **Arco `Tree.selectNode()` 会派发 `select` 事件**；`expandAll()` **不**派发 `expand`。所以「编程式选中 + 手动 search()」会发两次请求。
- `docker/development/logs/{access,error}.log` 是已跟踪文件，跑服务就常驻 `git status`。
- **`JWTExpiredException: jwt expired` + 全栈 ERROR 是预期噪声**（accessToken 1h 过期，前端自动 refresh），别顺着查。

## 性能 / 请求数基线（2026-09-23）
- `getUserList` 的 `_collectDeptAndChildrenIds` 已改为**一次取全表 + 内存建树**，从 `queries=46` 降到 2。**看到 `queries=4x` = 该改动被回退。**（`SysDept.parentId` 是 `int?, default = 0`。）
- `getUserList` 期望 `numQueries`：带 `deptId` → **3**（BFS+count+find）；不带 → **2**（count+find）。带 deptId 出现 2 = 分页被回退。
- 已改**服务端真分页**（`UserListRequest.page/pageSize`，`safePageSize` 上限 100），响应 `PageResponse` 的 `data` 是当前页数组、`page/total` 在**顶层**。**role/menu/dept 仍是「全表返回 + 客户端切片」的假分页。**
- 用户页首屏 `getUserList` 只应 1 次（带 deptId）；靠 `skipSelectSearch` + `useTable({immediate:false})`。`dept.getList` 由 `useDept` 模块级 in-flight Promise 去重（只在并发期生效，HMR 重挂载仍会各发一次）。

## 前端 `getBaseApi` 契约（`gi_demo_admin/src/apis/base.ts`）
- 被 6 个模块共用，**改它的 `update` = 改公共契约**。只有 `UserEndpoint`/`ProductEndpoint` 继承 `BaseEndpoint`，Dept/Role/Menu/Dict 没有 `/updateByJsonParams` 路由（404），且它们自己的 `update` 形参名是 `req`。
- 调用形态必须是 **`{ params: JSON.stringify(payload) }`**（外层对象、字符串是 `params` 的**值**）。
- 判断请求是新代码还是旧代码：**看 `Content-Type`**（data 是 string → `x-www-form-urlencoded`；object → `application/json`）。
- ⚠️ `SysUser` **没有 `roleIds`**（只有 `postIds`），角色在 `sys_user_role`；走通用 update 会**静默丢弃 roleIds**。

## 验证后端
- 不要只看 `dart analyze`（抓不到运行时 cast 和「字段是否真在响应里」）。用 skill `serverpod-local-api-verify` 真发请求（需 `--noproxy '*'` + 关沙箱；种子密码统一 `asdf1234`）。
- `serverpod generate` 用 `PATH="$HOME/fvm/versions/3.44.4/bin:$PATH" ~/.pub-cache/bin/serverpod generate`；`dart analyze` 用 `~/fvm/default/bin/dart`。`serverpod start` 的 TUI 日志很乱，`dart run bin/main.dart` 干净（启动约 5s）。
- 改服务要重启进程前，**先问用户**（他习惯在 App Studio 里管理服务）。

## Git
- ⚠️ `system_resources_2/` 是**嵌套 git 仓库**（tag v2.2.2），`git add -A` 只记成 gitlink（mode 160000），内容不进外层仓库。**至今不在 `.gitignore` 里**，提交前需 `git reset -- system_resources_2`。
- ✅ **本地那份 `system_resources_2/` 现在可以删，已无必要**（2026-09-23 查证 + 实测）：
  - `system_resources_2` 这个 **Dart 包**是 `serverpod 4.0.0` 的传递依赖（`serverpod/lib/src/server/health_check.dart` 用它取 `cpuLoadAvg()`/`memUsage()`），**包本身不能去掉**；但它一直从 **pub cache** 解析（所有 `.dart_tool/package_config.json` 的 `rootUri` 都指向 `~/.pub-cache/hosted/pub.dev/system_resources_2-2.2.2`），**从未指向本地目录**。
  - 本地目录唯一用途是 `flutter_web_server/start.sh` 的 `fix_sysres_dylib()`（拷 `libsysres-darwin-*.dylib` → `flutter_web_server/lib/build/`），而它**只在菜单项 9 被调用**，不在启动流程里（菜单 1 → `start_serverpod` 不调它）。
  - 当初为什么要它：旧版加载器只试 `Platform.script` 目录与 **CWD 相对路径** `lib/build/$libName`，不含 pub cache 路径；dylib 找不到时需手工往运行目录放一份，于是 clone GitHub 仓库取预编译库（`flutter_web_server/lib/build/libsysres-darwin-arm64.dylib` 是 2026-02-24 的产物）。
  - 现在为什么不需要：① `2.2.2` CHANGELOG 第一条即「Fix pub cache fallback path missing version suffix for macOS native library loading」，加载器已会扫 `$PUB_CACHE/hosted/pub.dev/system_resources_2-*/lib/build/`；② 下载 pub.dev 的 2.2.2 发布包核对过，**官方包内自带那两个 dylib**（与本地 md5 一致，不是手补进 pub cache 的）；③ **实测**：探针放 `/tmp`、CWD 也用 `/tmp`（该处无任何 `lib/build/`），`SystemResources.init()` → `cpuLoadAvg()`/`memUsage()` 仍返回真实值。
  - 失败也不致命：`health_check.dart` 把这两个调用包在 `try/catch` 里，最多健康检查少两个指标。
  - 删的连带项：菜单 9 会报错 → 想干净就把菜单项 9 与该函数一并删；`flutter_web_server/lib/build/`（未跟踪）可顺手删；本地 clone 里那处 `pubspec.yaml` 的 sdk 下限改动（→ `>=3.10.0`）无价值可丢。
- 提交风格：中文单行标题「模块：动作」式。
- 提交 `a008181` 里**故意含硬编码调试 payload**（`apis/base.ts`），用户要求照原样提交；后续已修掉，别以为那是正常的。
