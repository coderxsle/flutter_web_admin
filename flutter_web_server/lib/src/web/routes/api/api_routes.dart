import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

import 'airtable/airtable_action_routes.dart';
import 'auth_api_routes.dart';
import 'cors_middleware.dart';
import 'dept_rest_delegate.dart';
import 'dict_action_routes.dart';
import 'dict_code_rest_delegate.dart';
import 'dict_data_rest_delegate.dart';
import 'menu_action_routes.dart';
import 'menu_rest_delegate.dart';
import 'role_action_routes.dart';
import 'role_rest_delegate.dart';
import 'serverpod_envelope.dart';
import 'system_action_routes.dart';
import 'user_action_routes.dart';
import 'user_rest_delegate.dart';

/// 注册全部 REST 路由（挂载在 `webServer`，开发环境是 8082 端口）。
///
/// 和 typed Endpoint 的分工：
///
/// | | typed Endpoint（8080） | REST Route（8082 `/api/**`） |
/// |---|---|---|
/// | 消费者 | Flutter / Vue 客户端（serverpod 生成的 client） | 浏览器、Webhook、第三方服务、脚本 |
/// | 入参 | 具名参数 + 类型标签线格式 | URL path / query / 普通 JSON body |
/// | 出参 | 协议序列化 | 纯 JSON（`CommonResponse` 信封） |
/// | 业务实现 | `services/system/*_service.dart` | **同一个 Service** |
///
/// 也就是说 REST 层是「再加一层表现层」，不是「再写一套 CRUD」。
///
/// ## 只有一套基类（S1.5 收口）
///
/// 全部 Route 都来自 `serverpod_crud`：
/// * 资源型（固定那套 CRUD 路由）→ [BaseRestRoute]，业务体写在 `RestCrudDelegate` 里；
/// * 动作型（登录、取公钥…）→ [RestActionRoute]，业务体写在 `handler` 里。
///
/// 两者共用同一份鉴权 / 信封 / HTTP 状态码 / 异常兜底实现，信封由
/// [ServerpodEnvelopeBuilder] 统一产出。**不要再引入第三种写法** ——
/// 混用两套基类是运行期才崩、`dart analyze` 抓不到的坑。
///
/// ⚠️ 一个挂载点只能 `addRoute` 一次（relic 的 `PathTrie` 会抛
/// `Conflicting values`），所以：
/// * `/api/user` 这类资源把整套子路由塞进 <b>一次</b> `addRoute`（见
///   [BaseRestRoute.injectIn]）；
/// * `/api/auth/login` 这类动作用**完整路径**各挂一次。
///
/// ## A 档 6 个资源（S2）
///
/// 路径统一**单数 + 连字符**（决策 1）。实际注册出来的路由：
///
/// | 资源 | `GET /` | `GET /:id` | `POST /` | `PUT\|PATCH /:id` | 单条删 | 批量删 |
/// |---|---|---|---|---|---|---|
/// | `/api/user` | 分页列表 | ✓ | ✓ 201 | ✓ | ✓ | ✓（默认逐条） |
/// | `/api/dept` | **部门树** | ✓ | ✓ 201 | ✓ | ✓ | ✓ |
/// | `/api/role` | 平铺 + `disabled` | ✓ | **405** | ✓ | ✓ | ✓ |
/// | `/api/menu` | **菜单树** | ✓ | ✓ 201 | ✓ | ✓ | ✓ |
/// | `/api/dict-code` | 全量列表 | ✓ | ✓ 201 | ✓ | ✓ | ✓ |
/// | `/api/dict-data` | 全量列表 | ✓ | ✓ 201 | ✓ | ✓ | ✓ |
///
/// 每个资源另有 `DELETE /`（批量删，body `{"ids":[…]}`）与两条 POST 兼容形式
/// `POST /update`、`POST /delete`（项目习惯只用 GET / POST）。
/// `OPTIONS` 预检由基类自动补注册，不用手写。
///
/// ## B 档：12 个业务动作（S3）
///
/// 套不进 CRUD 模板的单点接口，全部用 [RestActionRoute]（与 [BaseRestRoute]
/// 共用鉴权 / 信封 / 状态码 / 异常兜底）。auth 那 3 条在 S1 已完成，
/// 这里补的是剩下的 9 条路由（覆盖 12 个 typed 方法中的 9 个，
/// 另 1 个由 A 档详情路由复用）：
///
/// | 资源 | REST | typed 方法 |
/// |---|---|---|
/// | user | `GET /api/user/info` | `getUserInfo` |
/// | user | `GET /api/user/routes` | `getUserRoutes` |
/// | user | `POST /api/user/reset-password` | `resetPassword(ids)` |
/// | role | `GET /api/role/:id/menu-ids` | `getRoleMenuIds` |
/// | role | `GET /api/role/:id/users` | `getRoleUsers` |
/// | role | `POST /api/role/:id/users/remove` | `cancelUserRoles` |
/// | role | `PUT\|POST /api/role/:id/menus` | `saveRolePermissions` |
/// | menu | `GET /api/menu/options` | `getMenuOptions` |
/// | dict | `GET /api/dict/options` | `getDictData` |
/// | dict | *复用* `GET /api/dict-data/:id` | `getDictDataDetail(id, code)` |
/// | system | `GET /api/system/health` | `health` |
/// | system | `GET /api/system/version` | `version` |
///
/// 匿名可访问的有三条：`/api/dict/options`（登录页要用）、
/// `/api/system/health`、`/api/system/version`（探活）。
///
/// ⚠️ 两条贯穿 S3 的约束，改动前先看：
/// * **嵌套在资源挂载点下的动作路径，参数名必须叫 `:id`** ——
///   `PathTrie._build` 在同一层遇到不同参数名会抛
///   `Conflicting parameter names at the same level`；
/// * **字面量段优先于参数段** —— `GET /api/user/info` 不会被 A 档的
///   `GET /api/user/:id` 吃掉。两条都有测试钉住
///   （`test/web/api_action_routes_test.dart`）。
void registerApiRoutes(Serverpod pod) {
  // 浏览器跨域（Vite dev server → 8082）需要的 CORS 头。
  // Serverpod 的 `cors:` 配置只管 API server，Web Server 这条链路得自己补。
  // 来源白名单默认是本地开发端口，可用环境变量 `REST_CORS_ORIGINS` 覆盖。
  pod.webServer.addMiddleware(CorsMiddleware().asMiddleware, '/api');

  // ── 认证资源（S1）───────────────────────────────────────────────
  // 三条动作路由，全部匿名可访问，各挂完整路径。
  registerAuthRoutes(pod);

  // ── A 档 6 个标准 CRUD 资源（S2）─────────────────────────────────
  //
  // 每个资源一次挂载，自动产出整套子路由；业务差异全部收敛在各自的
  // delegate 里（建树、`disabled` 注入、批量删、入参类型差异…）。
  //
  // 挂载点各不相同，顺序无所谓；按「简单 → 复杂」排便于对照阅读。
  registerResource<SysDictData>(pod, '/api/dict-data', DictDataRestDelegate());
  registerResource<SysDictCode>(pod, '/api/dict-code', DictCodeRestDelegate());
  registerResource<SysMenu>(pod, '/api/menu', MenuRestDelegate());
  registerResource<SysDept>(pod, '/api/dept', DeptRestDelegate());

  // ⚠️ 角色**没有「新增」**：typed `RoleEndpoint` 就没有 `add`，REST 侧不
  // 凭空造业务动作 → `enableCreate: false`，`POST /api/role` 不在路由表里。
  registerResource<SysRole>(
    pod,
    '/api/role',
    RoleRestDelegate(),
    enableCreate: false,
  );

  registerResource<SysUser>(pod, '/api/user', UserRestDelegate());

  // ── B 档 12 个业务动作（S3）─────────────────────────────────────
  //
  // ⚠️ 顺序无所谓，但**必须放在上面 6 个 registerResource 之后才读得懂**：
  // 这几条里有 4 条是嵌在 `/api/user`、`/api/role`、`/api/menu` 这些
  // 已被占用的挂载点**下面**（`/api/role/:id/menus` 这类）。它们和资源挂载
  // 共用同一棵 trie，不是两套路由 —— 靠的是字面量段优先 + 参数名一致。
  // 详见 api_routes.dart 顶部 B 档那张表的说明。
  registerUserActionRoutes(pod);
  registerRoleActionRoutes(pod);
  registerMenuActionRoutes(pod);
  registerDictActionRoutes(pod);
  registerSystemActionRoutes(pod);

  // ── C 档 airtable 子系统（S4）────────────────────────────────────
  //
  // 5 个 typed Endpoint / 21 个方法 → 13 条路径（见 airtable 目录的
  // `airtable_action_routes.dart`，那里有完整的路径表）。
  //
  // 与 A/B 档的差别：airtable 是**四层嵌套**（表 / 字段 / 行 / 单元格 / 关联），
  // 所以：
  // · 路径用**复数 + 完整层级**（`/api/airtable/tables/:id/fields`），
  //   而不是 A 档的单数资源名；
  // · 全部手写 [RestActionRoute]，没有套泛型 `BaseRestRoute` ——
  //   子资源语义、级联物理删、不统一的返回值都对不上 CRUD 模板；
  // · 同一路径的多种方法必须先用 `RestActionRoute.byMethod` 合并成一条，
  //   因为 `addRoute` 的挂载点是唯一的。
  registerAirtableActionRoutes(pod);
}

/// 挂一个资源路由的薄封装。
///
/// 统一在这里传信封，避免每行都重复写
/// `envelope: const ServerpodEnvelopeBuilder()` —— 漏传会退回中立信封
/// （`{message, data}`，**没有 `code`**），前端解析会静默失灵。
void registerResource<T extends TableRow>(
  Serverpod pod,
  String path,
  RestCrudDelegate<T> delegate, {
  bool enableCreate = true,
}) {
  pod.webServer.addRoute(
    BaseRestRoute<T>(
      delegate: delegate,
      envelope: const ServerpodEnvelopeBuilder(),
      enableCreate: enableCreate,
    ),
    path,
  );
}
