import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

import 'auth_api_routes.dart';
import 'cors_middleware.dart';
import 'dept_rest_delegate.dart';
import 'dict_code_rest_delegate.dart';
import 'dict_data_rest_delegate.dart';
import 'menu_rest_delegate.dart';
import 'role_rest_delegate.dart';
import 'serverpod_envelope.dart';
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
