import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:serverpod/serverpod.dart';

/// 账号状态守卫：登录、刷新 token、每次鉴权共用同一套判定，避免各自漏判。
class AccountGuard {
  /// 按认证身份取未软删的 sys_user 行；返回 null 表示账号已删除。
  static Future<SysUser?> findActive(Session session, UuidValue authUserId) =>
      SysUser.db.findFirstRow(
        session,
        where: (t) =>
            t.authUserId.equals(authUserId) & t.deleted.equals(false),
      );

  /// status 非 1（含 null）一律按禁用处理。
  static bool isEnabled(SysUser user) => user.status == 1;
}
