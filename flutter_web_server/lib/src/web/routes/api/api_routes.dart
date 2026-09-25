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

void registerApiRoutes(Serverpod pod) {
  // 浏览器跨域（Vite dev server → 8082）需要的 CORS 头。
  // Serverpod 的 `cors:` 配置只管 API server，Web Server 这条链路得自己补。
  // 来源白名单默认是本地开发端口，可用环境变量 `REST_CORS_ORIGINS` 覆盖。
  pod.webServer.addMiddleware(CorsMiddleware().asMiddleware, '/api');

  // ── 认证资源
  // 三条动作路由，全部匿名可访问，各挂完整路径。
  registerAuthRoutes(pod);

  // ── A 档 6 个标准 CRUD 资源（S2）─────────────────────────────────
  //
  // 每个资源一次挂载，自动产出整套子路由；业务差异全部收敛在各自的
  // delegate 里（建树、`disabled` 注入、批量删、入参类型差异…）。
  //
  // 挂载点各不相同，顺序无所谓；按「简单 → 复杂」排便于对照阅读。
  registerResource<SysDictData>(pod, '/api/dictData', DictDataRestDelegate());
  registerResource<SysDictCode>(pod, '/api/dictCode', DictCodeRestDelegate());
  registerResource<SysMenu>(pod, '/api/menu', MenuRestDelegate());
  registerResource<SysDept>(pod, '/api/dept', DeptRestDelegate());
  // ⚠️ 角色**没有「新增」**行业务动作，REST 侧不凭空造一个 →
  // `POST /api/role/add` 不注册，命中 404（不是 405）。
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
  // 21 个方法 → 13 条路径（见 airtable 目录的
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
