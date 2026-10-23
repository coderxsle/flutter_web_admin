import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/security/account_guard.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 当前登录用户的权限快照：权限码 + 可见菜单 + 是否超管。
///
/// `/api/user/info` 下发的菜单/权限与路由校验共用这一份，避免两边口径不一致。
class PermissionSnapshot {
  const PermissionSnapshot({required this.codes, required this.menus, this.superuser = false});

  static const empty = PermissionSnapshot(codes: <String>{}, menus: <SysMenu>[]);

  /// 菜单上的权限标识，已去空。
  final Set<String> codes;

  /// 授权范围内的菜单（含 type=3 按钮），已过滤 `deleted` / `status` / 租户。
  final List<SysMenu> menus;

  /// 超管绕过一切权限码校验。
  final bool superuser;
}

/// 当前登录用户的权限解析。
class PermissionService {
  PermissionService._();

  static const _cacheKey = 'permissionSnapshot';

  /// 支持 `zhongyi:*` 前缀匹配；未登录或账号失效返回 false。
  static Future<bool> has(Session session, String permission) async {
    final snapshot = await of(session);
    if (snapshot.superuser) return true;
    if (permission.endsWith(':*')) {
      final prefix = permission.substring(0, permission.length - 1);
      return snapshot.codes.any((code) => code.startsWith(prefix));
    }
    return snapshot.codes.contains(permission);
  }

  static Future<bool> hasAny(Session session, Iterable<String> permissions) async {
    for (final permission in permissions) {
      if (await has(session, permission)) return true;
    }
    return false;
  }

  /// 无权限直接抛 403，交给统一信封输出 40300。
  static Future<void> require(Session session, String permission) async {
    if (!await has(session, permission)) {
      throw const RestException.forbidden('无权限访问该功能');
    }
  }

  static Future<void> requireAny(Session session, Iterable<String> permissions) async {
    if (!await hasAny(session, permissions)) {
      throw const RestException.forbidden('无权限访问该功能');
    }
  }

  /// 包一层权限校验，供 `BaseRoute` 的 `get()` / `post()` 用 —— 这些动作没有独立权限字段。
  static Future<Object?> Function(Session, Request) guard(
    List<String> permissions,
    Future<Object?> Function(Session, Request) handler,
  ) => (session, request) async {
    await requireAny(session, permissions);
    return handler(session, request);
  };

  static Future<bool> isSuperuser(Session session) async => (await of(session)).superuser;

  /// 一次请求内只查一次库。
  static Future<PermissionSnapshot> of(Session session) async {
    final cached = session.userObject;
    if (cached is Map && cached[_cacheKey] is PermissionSnapshot) {
      return cached[_cacheKey] as PermissionSnapshot;
    }
    final snapshot = await _load(session);
    if (session.userObject is! Map) session.userObject = <String, dynamic>{};
    (session.userObject as Map)[_cacheKey] = snapshot;
    return snapshot;
  }

  static Future<PermissionSnapshot> _load(Session session) async {
    final auth = session.authenticated;
    if (auth == null) return PermissionSnapshot.empty;

    final user = await AccountGuard.findActive(session, auth.authUserId);
    if (user == null || !AccountGuard.isEnabled(user)) return PermissionSnapshot.empty;

    // 超管不看角色，直接拿租户内全部启用菜单，前端才有东西可渲染。
    if (user.isSuperuser) {
      final menus = await SysMenu.db.find(
        session,
        where: (t) =>
            t.deleted.equals(false) & t.status.equals(1) & (t.tenantId.equals(user.tenantId) | t.tenantId.equals(0)),
      );
      return PermissionSnapshot(codes: _codesOf(menus), menus: menus, superuser: true);
    }

    final userRoles = await SysUserRole.db.find(
      session,
      where: (t) =>
          t.userId.equals(user.id!) & t.deleted.equals(false) & (t.tenantId.equals(user.tenantId) | t.tenantId.equals(0)),
    );
    final roleIds = userRoles.map((e) => e.roleId).toSet();
    if (roleIds.isEmpty) return PermissionSnapshot.empty;

    final roles = await SysRole.db.find(
      session,
      where: (t) =>
          t.id.inSet(roleIds) &
          t.deleted.equals(false) &
          t.status.equals(1) &
          (t.tenantId.equals(user.tenantId) | t.tenantId.equals(0)),
    );
    final activeRoleIds = roles.map((e) => e.id).whereType<int>().toSet();
    if (activeRoleIds.isEmpty) return PermissionSnapshot.empty;

    final roleMenus = await SysRoleMenu.db.find(
      session,
      where: (t) =>
          t.roleId.inSet(activeRoleIds) &
          t.deleted.equals(false) &
          (t.tenantId.equals(user.tenantId) | t.tenantId.equals(0)),
    );
    final menuIds = roleMenus.map((e) => e.menuId).toSet();
    if (menuIds.isEmpty) return PermissionSnapshot.empty;

    final menus = await SysMenu.db.find(
      session,
      where: (t) =>
          t.id.inSet(menuIds) &
          t.deleted.equals(false) &
          t.status.equals(1) &
          (t.tenantId.equals(user.tenantId) | t.tenantId.equals(0)),
    );
    return PermissionSnapshot(codes: _codesOf(menus), menus: menus);
  }

  static Set<String> _codesOf(Iterable<SysMenu> menus) =>
      menus.map((menu) => menu.permission.trim()).where((permission) => permission.isNotEmpty).toSet();
}
