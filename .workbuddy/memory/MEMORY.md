# flutter_web_admin 项目长期约定

## 项目结构
- `flutter_web_server/`：Serverpod 后端（Dart）。模型定义在 `lib/src/models/**/*.spy.yaml`，业务逻辑在 `lib/src/services/system/*_service.dart`，端点薄封装在 `lib/src/endpoints/system/*_endpoint.dart`。
- `gi_demo_admin/`：Vue3 + Arco Design 后台（`src/views/**`、`src/apis/**`）。
- 存在两套并存的基类：`endpoints/system/base_endpoint.dart`（业务版，返回 `CommonResponse`）与 `serverpod_crud` 的 `BaseCrudEndpoint`（框架版）。混用会导致运行时 cast 崩溃，`dart analyze` 抓不到。

## 重要约定：表格「系统内置不可编辑」= 后端注入 `disabled`
- 前端统一读 `record.disabled` 控制编辑/删除按钮禁用，并在 `hooks/useTable.ts` 的 `selectAll` 里用它跳过不可操作行。
- **`disabled` 不是模型字段，必须由后端服务层手动注入**。参考实现：`services/system/role_service.dart` 的 `getList`，`json['disabled'] = role.type == 1;`；`services/system/user_service.dart` 的 `getUserList` 用 `user.isSuperuser || user.type == 1` 判定并同时派生 `json['type']`。
- 凡是直接 `CommonResponse.success(list)` 返回原始模型列表的服务，响应里都不会有 `disabled`，前端按钮必然不禁用 —— 排查此类问题先看这一点。

## 通用 CRUD 接口（`BaseEndpoint`）的入参契约
- `POST /<endpoint>/<method>`，body 用**参数名做外层 key**：`{"data": {...}}`、`{"query": {...}}`、`{"req": {...}}`、`{"ids": [...]}`。键名错了直接 `400 Missing required query parameter: xxx`。
- 参数名从 `lib/src/generated/endpoints.dart` 的 `MethodConnector` 里看最准（生成器能扫到继承自 `BaseEndpoint` 的方法）。
- **`add`/`update` 的 `data` 是 `dynamic`，经 `SerializationManager.deserialize<T>` → 模型的 `fromJson` 解码**，不走任何校验层。
- ⚠️ **`update` 是整行覆盖，不是部分更新**：`updateRow` → `update(columns: null)` → `SET` 所有落库列。缺哪个字段就用「fromJson 的默认值」覆盖哪个：
  - 缺 `password` → 置 NULL。而 `password` 是 `scope=serverOnly`，前端拿不到，所以**用通用 `update` 改用户一定会清空密码**。给 SysUser 写更新必须走定制实现（参考 `user_service.dart` 里被注释掉的那段：先查 existing、只改传入字段、再 `updateRow`）。
  - 缺 `authUserId` → 置 NULL，用户与登录账号的关联断掉，直接登不进系统。
  - 缺 `createTime` → 被重置为 `DateTime.now()`。
  - 缺 `deleted`/`status` 等 → 回落默认值（`false`/`1`…）。
  - 缺 `username`/`nickname` → `fromJson` 里是 `as String` 非空断言，**直接 500**。
  - 根因：`decodeModel` 是「从 payload 造一个全新模型」，**没有任何 merge 步骤**，所以基类 `update` 天然不支持 PATCH 语义（已用探针脚本实测确认）。
- ⚠️ **不能靠收窄形参类型来自定义 `update`**：Dart 会报 `invalid_override`（`dynamic` 是 top type，收窄即非法覆写）。所以自定义 update 必须保持 `update(Session session, dynamic data)` 签名，在方法体内自己 `fromJson` 成请求模型。
- ⚠️ **`dynamic` 形参不能直接收普通 JSON 对象**：Serverpod 4 对 `dynamic` 形参会走 `deserializeDynamicFieldValue`，要求线格式是带类型标签的 `{"className":"Map","data":{"id":{"className":"int","data":2}}}`（每个值还要包一层）；直接传 `{"id":2,"deptId":5}` 报 `No deserialization found for type named null`。改成 `Map<String, dynamic>` 也不行（报 `got int instead`）。**要收普通 JSON 对象只能声明成 `String` + `jsonDecode`**。
- ✅ **`BaseEndpoint.updateByJsonParams` = PATCH 语义**（2026-09-20 新增，与 `update` 并存；原名 `update2` 已废弃）：先按主键读出当前行做基线，只让请求里**出现过的 key** 覆盖它（`{...existing.toJson(), ...provided}` 后重新 decode）。因此 `{"id":2,"deptId":2}`、`{"id":2,"username":"chen.yu"}` 这类部分字段 payload 可直接用，不会误伤 password/authUserId/createTime。
  - 入参：`POST /<endpoint>/updateByJsonParams`，形参名 **`params`**、类型 **`String`**，body 为 `{"params":"{\"id\":2,\"deptId\":5}"}`（JSON 文本，前端用 `JSON.stringify`）。⚠️ 形参名以生成代码为准，**改名后必须重新 `serverpod generate`**，否则 body key 对不上直接 400 `Missing required query parameter`。
  - 约束：必须传主键；请求里除主键外至少要有一个合法字段名，否则返回「没有可更新的字段」并列出可用字段；merge 必须用 `toJson()`（`toJsonForProtocol()` 不含 serverOnly 字段）。
- ✅ **`BaseEndpoint.addByJsonParams` = 新增的 JSON 文本版**（2026-09-20 新增，与 `add` 并存）：`POST /<endpoint>/addByJsonParams`，形参同样是 `String params`、body `{"params":"{...}"}`，最终走 `service.create`。`add`/`update` 那两个 `dynamic` 版**保留给 serverpod 生成的 client 代码**，不要删。
- ✅ 两个 JSON 文本接口的公共逻辑已抽离（2026-09-20）：
  - `lib/src/endpoints/utils/json_param_codec.dart` 的 `JsonParamCodec.decodeObject(raw, paramName:)` —— jsonDecode + 必须是对象 + cast，失败抛 `JsonParamFormatException`；
  - `base_endpoint.dart` 的私有辅助 `_knownFieldNames` / `_idFieldName` / `_primaryKeyKeys` / `_splitFieldNames` / `_extractPrimaryKey` / `_describeUnknownFields`。
  - 新增接口时**照这个模式抄**：解析交给 codec，字段白名单交给 `_splitFieldNames`。
- 注：`SysUser.type` 不在 `SysUserTable.columns` 里（`!persist`），所以任何 row 级写法都不会动它。
- 注：`toJsonForProtocol()` **不含** `password`（`scope=serverOnly`），需要完整落库字段的场合要用 `toJson()`。

## 已知坑
- ⚠️ **Endpoint 子类的「公开方法」会自动变成 HTTP 路由**。往 `BaseEndpoint`（或任何继承 `Endpoint` 的类）上加辅助逻辑，**必须用下划线私有**，否则会多出一条 `/xxx/你的辅助方法` 路由。判据：看 `lib/src/generated/endpoints.dart` 里该端点的 `methodConnectors` 列表。`decodeModel` 没被注册只是因为返回泛型 `T`、生成器表达不出来，属巧合不是保证。
- 新增 / 重命名端点方法后**必须 `serverpod generate` 并重启进程**（热重载不重建路由表）。
- `dart analyze` 问题数**突然暴涨**（比如从 2 个变 143 个）时，先去看最近那次编辑的语法结构 —— 通常是括号/注释围栏被改坏导致类声明崩了，那些莫名其妙的 lint 都是并发症，不要逐个去查。
- `SysUser.type` 标了 `!persist`（`models/system/sys_user.spy.yaml`），DB 无该列，读出来恒为默认值 2。因此「类型」列永远显示"自定义"，`type === 1` 判断永不成立。用户侧判断系统内置应改用 `isSuperuser`（该字段是落库的真实字段）。
- `services/system/user_service.dart` 顶部有 2 个未使用的 import（`crud_runtime_factory.dart`、`db_audit_service.dart`），`dart analyze` 常驻 2 个 warning，属既有遗留。
- **`getUserList` 的部门子树查询已优化**（2026-09-23）：`_collectDeptAndChildrenIds` 原为逐节点 `SysDept.db.find` 的 BFS（每个部门一次，45 个部门 → 日志 `queries=46`），现改为**一次取全表 + 内存建 `parentId→children` 映射**后走树。实测同一根部门从 `queries=46` 降到 **2**（1 用户列表 + 1 部门表），返回用户数与递归 CTE 口径核对一致。**若再看到 `queries=4x`，说明这个改动被回退了。**（注：`SysDept.parentId` 是 `int?, default = 0`，根部门用 0 而非 null。）
- **`getUserList` 的 `numQueries` 期望值（2026-09-23 加 B2 后已变，别按旧值误判）**：
  | 调用 | B1 only | B1 + B2（现状） |
  |---|---|---|
  | 带 `deptId` | 2（BFS + find） | **3**（BFS + count + find） |
  | 不带 `deptId` | 1（find） | **2**（count + find） |

  看到带 `deptId` 时出现 **2** = B2 的 `count`/`limit` 被回退；出现 **4x** = B1 内存建树被回退。
- **用户管理页首屏重复请求已修**（2026-09-23）：① `getUserList` 原来打 3 次 —— `useTable(immediate:true)` 一次（无 deptId，`queries=1`）+ `useDept.onSuccess` 里 `selectNode()` 触发的 `onDeptSelect → search()` 一次 + 紧接着显式 `search()` 一次；现用 `skipSelectSearch` 标志位抑制编程式选中引发的 search。再叠加 F3（`useTable({ immediate: false })`，改由 `onSuccess` 里那次 `search()` 独占首屏请求）后，**首屏 `getUserList` 只剩 1 次**（带 deptId、`queries=3`），且**不应该再出现任何无 deptId 的 `getUserList`（即 `queries=2`）**。② `dept.getList` 原来打 2 次（`index.vue:85` 与常驻挂载的 `UserFormModal.vue:30` 各一次），现由 `useDept` 的**模块级 in-flight Promise 去重**解决。注意：去重只在并发期间生效、请求结束即清空，所以 `DeptFormModal` 增删改后的刷新仍会发真实请求，无需 `force` 参数；也正因如此，**Vite HMR 的连续重挂载（每次挂载相隔数百毫秒）仍会各发一次 `dept.getList`**，那不是去重失效。
- **`useTable({ immediate: false })` 是安全的**（F3 依据）：它只跳过首屏那次自动 `getTableData()`。`search()` → `pagination.onChange(1)` → 无条件 `callback()`（`usePagination.ts:43-46` 没有「值未变则提前返回」的短路），`refresh()` → `getTableData()`，`handleDelete()` 内部也直接 `getTableData()` —— 三条显式路径都不受影响。
- **`JWTExpiredException: jwt expired` + 全栈 ERROR 是预期噪声**：accessToken 有效期 1 小时（`server.dart` 的 `JwtConfig`），过期后前端会自动 `auth.refreshToken` 续期。日志特征：两条无 `user=` 的请求失败 → 一次 `auth.refreshToken` 成功 → 后续请求都带 `user=`。**不要顺着这个 ERROR 去查**。
- **`getUserList` 已改服务端真分页**（2026-09-23，B2）：`UserListRequest` 新增 `page`（默认 1）/`pageSize`（默认 10）字段；`user_service.getUserList` 抽了局部函数 `buildFilter(SysUserTable)` 同时喂给 `SysUser.db.count` 与 `SysUser.db.find(limit:, offset:)`，入参用 `safePageNum`/`safePageSize` 收敛（page<1→1，pageSize<1→10，pageSize>100→100，与 `role_service.getRoleUsers` 同一套规则），响应改为 `PageResponse.success(result, page:, pageSize:, total:)`。
  - 契约：`PageResponse<T> extends CommonResponse`，`data` 是**当前页数组**，`page/pageSize/totalPage/total` 在**顶层** —— 这与 `useTable.ts:76` 的 `res.total` 优先读取逻辑天然对齐，所以前端拿到的是真 total 而不是 `records.length`。端点签名没变，仍是 `Future<CommonResponse> getUserList(Session, UserListRequest query)`。
  - 前端调用：`getUserList({ query: { ...page, ...queryParams } })`（`apis/system/user.ts`）。全仓**只有 `views/system/user/index.vue` 一个消费者**（`UserFormModal.vue:13` 那处是死导入），Flutter client 返回类型未变，无破坏面。
  - 实测（`admin` 登录后直接 curl）：deptId=1 子树 `total=12/totalPage=2`，page=1 返 10 条、page=2 返 2 条（id 13/17，不重叠）；不带 deptId `total=15`；`pageSize=999`→收敛为 100；`page=0`→收敛为 1；不存在的 deptId → `total=0` 空数组。`disabled` 注入仍正常。
  - 同类接口（role/menu/dept 等）**仍有「全表返回 + 客户端切片」的假分页特征**，看到响应大先想到它。
- **Arco `Tree.selectNode()` 会派发 `select` 事件**（源码 `es/tree/tree.js`：`selectNode` → `internalSelectNodes` → `selectNodes` → `emitSelectEvent` → `emit('select')`）。所以「编程式选中 + 手动 search()」会发两次相同请求；反之 `expandAll()` 走 `internalSetExpandedKeys`，**不**派发 `expand`。
- 先只诊断、不动代码：用户说「看看/查一下/什么原因」时只输出结论与方案，等明确指令再改。

## 前端 `getBaseApi` 与后端的契约（`gi_demo_admin/src/apis/base.ts`）
- `getBaseApi` 被 6 个模块共用：person / dept / dict / menu / role / user。**改它的 `update` 等于改公共契约**。
- 只有 `UserEndpoint` / `ProductEndpoint` 继承 `BaseEndpoint`；`Dept`/`Role`/`Menu`/`Dict` Endpoint 都是普通 `Endpoint`，**没有 `/xxx/update2` 路由**（404）。且这几个端点的 `update` 是各自重写的，形参名是 `req` 而非基类的 `data`。
- `updateByJsonParams` 的调用形态是 **`{ params: JSON.stringify(payload) }`**：外层必须是对象，字符串是 `params` 字段的**值**。直接把信封 `JSON.stringify({params:...})` 当 `data` 传是错的 —— axios 0.27 对 string data 不设 `Content-Type: application/json`，且服务端会把 `params` 解成对象而非 String。`string` 也不能赋给 `Record<string, any>` / `object`（tsc 会报 TS2345），类型约束应写在 `DefaultP.UpdateParams` 里做字段级收窄。
- ⚠️ `apis/base.ts:48` 里 `updateByJsonParams` 的 URL 必须跟着后端改名走（`/update2` → `/updateByJsonParams`），否则 `Method not found in endpoint`。
- ⚠️ `SysUser` **没有 `roleIds` 字段**（只有 `postIds`）。角色在 `sys_user_role` 关联表，由 `user_service.dart` 的 `_saveUserRoles` 维护，且目前**只在 `add` 里调用过**。因此走通用 `update2` 改用户会**静默丢弃 roleIds** —— 用户编辑应恢复 `user_service.dart:423-497` / `user_endpoint.dart:49` 里被注释掉的定制 `update`。
- 判断浏览器 Network 里那条请求是新代码还是旧代码发出的，**看 `Content-Type` 最快**（axios 0.27 实测）：`data` 是字符串 → 保留默认的 `application/x-www-form-urlencoded`；`data` 是对象 → `application/json`。字符串 body 里的 `param` 是对象且无转义，对象 body 里 `param` 是字符串且带 `\"` 转义。

## 验证后端接口
- 改完后端不要只看 `dart analyze`（抓不到运行时 cast 与「字段是否真的在响应里」）。用 skill `serverpod-local-api-verify` 的流程真发一次请求。
- 关键事实：Serverpod dev 模式对 `lib/src/services/**` 的方法体改动**自动热重载**（不用重启），但**新增/删除端点路由必须重启进程**（路由表 `Endpoints()` 只在启动时构建一次）；种子用户密码统一 `asdf1234`；调本机后端需 `--noproxy '*'` 且关沙箱。
- `serverpod generate` 要用 `PATH="$HOME/fvm/versions/3.44.4/bin:$PATH" ~/.pub-cache/bin/serverpod generate`（Dart 3.12.2）。用默认 fvm 的 Dart 3.13 会报内核版本不匹配。`dart analyze` 则用 `~/fvm/default/bin/dart`。

## Git 仓库注意事项
- ⚠️ `system_resources_2/` 是一个**嵌套 git 仓库**（clone 自 github.com/serverpod/system_resources_2，HEAD=tag v2.2.2，本地改过 `pubspec.yaml`）。`git add -A` 只会把它记成 **gitlink（mode 160000）**，内部改动与文件内容都不会进外层仓库，别人 clone 拿不到。要入库得 `git submodule add`，否则应加进 `.gitignore`。
  - **2026-09-23 的处置**：提交 `937d3e4` 时用 `git reset -- system_resources_2` 把它退回了未跟踪状态（因为仓库无 `.gitmodules`，commit 进去对方只会拿到空目录）。**它至今不在 `.gitignore` 里**，所以下次 `git add -A` 会再被带进暂存区，需要重复处理。
- `docker/development/logs/{access,error}.log` 是**已被跟踪**的文件，跑一次服务就会在 `git status` 里常驻。不是配置错误。
- 提交风格：中文单行标题，常见「模块：动作」式；历史上也有大量 `no message`。
- 2026-09-23 的提交 `a008181`（用户模块脱离 AutoCrudService + 恢复 getDetail + 列表注入 disabled）里**故意包含了一段硬编码调试 payload**（`gi_demo_admin/src/apis/base.ts` 的 `update()`），用户明确要求照原样提交 —— 后续修复合法的 `{params: params}` 版本时不要以为那是正常的。
