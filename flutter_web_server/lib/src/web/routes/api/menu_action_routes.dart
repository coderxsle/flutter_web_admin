import 'package:flutter_web_server/src/services/system/menu_service.dart';
import 'package:flutter_web_server/src/web/routes/api/rest_delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 菜单资源的**业务动作**路由（B 档）。
///
/// | typed 方法 | REST |
/// |---|---|
/// | `getMenuOptions()` | `GET /api/menu/options` |
///
/// 与 A 档 `MenuService.getList` 的区别值得记一笔，两者很容易混：
///
/// | | `GET /api/menu`（A 档列表） | `GET /api/menu/options`（本条） |
/// |---|---|---|
/// | 数据源 | 整张 `sys_menu`（可选 `name`/`status` 过滤） | **当前登录用户**的角色所关联的菜单 |
/// | 过滤 | 按查询条件 | 只保留 `status = 1`，并剔除不属于该用户的 |
/// | 形态 | 菜单树 | 菜单树 |
///
/// 也就是说 `options` 是「我能看到的菜单」，`GET /api/menu` 是「系统里有哪些菜单」。
/// 前端进后台时拉的是前者（决定侧边栏），菜单管理页拉的是后者。
Map<String, RestActionRoute> menuActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    // GET /api/menu/options —— 当前登录用户的菜单树。
    //
    // ⚠️ `options` 是**字面量段**，与 A 档的 `getList` / `getDetail` 等同层。
    // relic 的 `PathTrie` 允许同一层挂多个不同字面量，不会互相吃掉；有测试钉住。
    '/api/menu/options': RestActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async =>
          ensureOk(await MenuService.getMenuOptions(session)),
    ),
  };
}

/// 把 [menuActionRoutes] 挂到 Web Server 上。
void registerMenuActionRoutes(Serverpod pod) => menuActionRoutes().forEach(
  (path, route) => pod.webServer.addRoute(route, path),
);
