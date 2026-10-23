import 'package:serverpod/serverpod.dart';

/// 路由层权限校验回调，由业务项目注入。
typedef PermissionResolver = Future<bool> Function(Session session, String permission);

/// 未注入回调或回调返回 false 时一律拒绝，避免漏配变成放行。
class PermissionGuard {
  PermissionGuard._();

  static PermissionResolver? resolver;

  static Future<bool> has(Session session, String permission) async {
    final resolve = resolver;
    if (resolve == null) return false;
    return resolve(session, permission);
  }

  static Future<bool> hasAll(Session session, Iterable<String> permissions) async {
    for (final permission in permissions) {
      if (!await has(session, permission)) return false;
    }
    return true;
  }
}
