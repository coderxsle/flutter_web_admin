import 'package:flutter_web_server/src/web/routes/api/zhongyi/zhongyi_action_routes.dart';
import 'package:test/test.dart';

void main() {
  test('中医所有路由都声明 zhongyi 权限并带模块门', () {
    final routes = zhongyiActionRoutes();
    expect(routes, isNotEmpty);
    for (final entry in routes.entries) {
      final permissions = entry.value.requiredPermissions;
      expect(permissions, isNotEmpty, reason: entry.key);
      expect(permissions, contains('zhongyi:*'), reason: entry.key);
      expect(permissions.every((permission) => permission.startsWith('zhongyi:')), isTrue, reason: entry.key);
    }
  });
}
