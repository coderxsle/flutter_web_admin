import 'package:flutter_web_server/src/services/system/role_service.dart';
import 'package:flutter_web_server/src/web/routes/api/rest_delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 角色资源的**业务动作**路由（迁移路线 S3 / B 档）。
///
/// 这四条都是「角色 ↔ 菜单」「角色 ↔ 用户」这两张关联表的读写，
/// 套不进 `BaseRestRoute` 的 CRUD 模板（CRUD 管的是 `sys_role` 这张主表）。
///
/// | typed 方法 | REST |
/// |---|---|
/// | `getRoleMenuIds(roleId)` | `GET /api/role/:id/menu-ids` |
/// | `getRoleUsers(roleId, page, pageSize, nickname)` | `GET /api/role/:id/users` |
/// | `cancelUserRoles(roleId, userIds)` | `POST /api/role/:id/users/remove` |
/// | `saveRolePermissions(roleId, menuIds)` | `PUT\|POST /api/role/:id/menus` |
///
/// ## ⚠️ 路径参数必须叫 `:id`
///
/// `/api/role` 这个挂载点已经被 A 档的 `RoleRestDelegate` 占着，它的子路由里有
/// `/:id`。`PathTrie._build` 走同一个参数节点时会校验名字，起 `:roleId` 会直接抛
/// `Conflicting parameter names at the same level`（有测试钉住这条）。
/// 所以这里统一用 `:id`，读参数用框架的 `request.pathId()`。
///
/// 嵌套本身是安全的：`PathTrie` 的 `attach` 会把子路由**合并**进同一棵 trie，
/// 而 `/:id/menu-ids`（两段）与 `/:id`（一段）不可能互相匹配。
Map<String, RestActionRoute> roleActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    // GET /api/role/:id/menu-ids —— 角色已分配的菜单 ID 列表。
    //
    // 返回的是**去重后的裸数组**（`[1, 5, 9]`），与 typed 一致 ——
    // 前端直接拿去回显 Arco Tree 的 checkedKeys。
    '/api/role/:id/menu-ids': RestActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async {
        final roleId = request.pathId();
        return ensureOk(await RoleService.getRoleMenuIds(session, roleId));
      },
    ),

    // GET /api/role/:id/users —— 角色下的用户列表（分页 + 昵称模糊搜索）。
    //
    // query：`page`（默认 1）、`pageSize`（默认 20，Service 侧上限 200）、
    //        `nickname`（模糊匹配）。`page_size` 下划线写法也认。
    //
    // 返回 `PageResponse`（`{code, message, page, pageSize, totalPage, total, data}`）——
    // 它是 `CommonResponse` 的子类，信封 `success` 会直接采用它的 `toJson()`，
    // 所以这里**不走** CRUD 那条 `RestPage` 分页分支，形状与 typed 逐字节一致。
    '/api/role/:id/users': RestActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async {
        final roleId = request.pathId();
        return ensureOk(
          await RoleService.getRoleUsers(
            session,
            roleId,
            page: request.queryInt('page') ?? 1,
            pageSize:
                request.queryInt('pageSize') ??
                request.queryInt('page_size') ??
                20,
            nickname: request.queryString('nickname'),
          ),
        );
      },
    ),

    // POST /api/role/:id/users/remove —— 批量取消用户的角色分配（幂等软删）。
    //
    // 请求体：`{"userIds": [1, 2]}`（兼容 `user_ids`）。
    //
    // 为什么是 `POST .../remove` 而不是 `DELETE /api/role/:id/users`：
    // ① 本项目前端只用 GET / POST（与批量删走 POST 是同一条约定）；
    // ② `DELETE` 带请求体的支持度参差（部分网关/客户端会直接丢掉 body），
    //    而这里**必须**带 userIds 才能表达「移除哪几个」。
    '/api/role/:id/users/remove': RestActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async {
        final roleId = request.pathId();
        final body = await request.jsonObjectBody();
        final userIds = requiredIntList(
          body,
          'userIds',
          aliases: const ['user_ids'],
        );
        return ensureOk(await RoleService.cancelUserRoles(session, roleId, userIds));
      },
    ),

    // PUT|POST /api/role/:id/menus —— 保存角色权限（**全量替换**菜单集）。
    //
    // 请求体：`{"menuIds": [1, 5]}`（兼容 `menu_ids`）。
    //
    // 语义是「让这个角色的菜单集合恰好等于传进来的这些」：
    // 不在集合里的旧关联被软删，新的插入，曾经删过的会被**复活**（`deleted=false`）。
    // 所以传空数组 `[]` 是合法的 —— 表示清空该角色的全部菜单权限，
    // ⚠️ 因此这里**不能**用 `requiredIntList` 把它当非法入参挡掉。
    //
    // 返回值里带 `invalidMenuIds`（传了但库里不存在的），与 typed 一致。
    //
    // 同时注册 PUT 与 POST：REST 语义上 PUT 更合适（幂等的整体替换），
    // 但按项目「只用 GET/POST」的习惯给一条 POST 别名，两条走同一个 handler。
    '/api/role/:id/menus': RestActionRoute(
      methods: const {Method.put, Method.post},
      envelope: envelope,
      handler: (session, request) async {
        final roleId = request.pathId();
        final body = await request.jsonObjectBody();
        final menuIds = _menuIdsOf(body);
        return ensureOk(
          await RoleService.saveRolePermissions(session, roleId, menuIds),
        );
      },
    ),
  };
}

/// 把 [roleActionRoutes] 挂到 Web Server 上。
void registerRoleActionRoutes(Serverpod pod) => roleActionRoutes().forEach(
  (path, route) => pod.webServer.addRoute(route, path),
);

/// 读 `menuIds`：**允许空数组**（表示清空权限），但字段本身必须出现。
///
/// 与 [requiredIntList] 的区别就在这里 —— 那个用来挡「压根没传」，
/// 这个用来表达「明确清空」：菜单集是全量替换语义，`[]` 是合法且有意义的值。
List<int> _menuIdsOf(Map<String, dynamic> body) {
  if (!body.containsKey('menuIds') && !body.containsKey('menu_ids')) {
    throw const RestApiException.badRequest('参数不合法：menuIds 不能为空');
  }
  final raw = body.containsKey('menuIds') ? body['menuIds'] : body['menu_ids'];
  return normalizedIntList(raw);
}
