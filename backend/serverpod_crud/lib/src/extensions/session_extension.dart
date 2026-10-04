import 'package:serverpod/serverpod.dart';

/// Session 租户扩展
/// 用于平台超管跨租户查看时，临时设置目标租户ID

extension SessionExtension on Session {
  /// 获取会话上下文 Map（用于存储临时数据如目标租户等）
  Map<String, dynamic> _getContextMap() {
    if (userObject is! Map) {
      userObject = <String, dynamic>{};
    }
    return userObject as Map<String, dynamic>;
  }

  /// 获取目标租户ID（平台超管用）
  int? get targetTenantId {
    return _getContextMap()['targetTenantId'] as int?;
  }

  /// 设置目标租户ID（平台超管用）
  set targetTenantId(int? tenantId) {
    _getContextMap()['targetTenantId'] = tenantId;
  }

  /// 清除目标租户ID
  void clearTargetTenantId() {
    _getContextMap().remove('targetTenantId');
  }

  /// 获取登录态租户ID（从 scope 中解析 tenantId:xxx）
  int get tenantId {
    final auth = authenticated;
    if (auth == null) return 0;
    for (final scope in auth.scopes) {
      final name = scope.name;
      if (name == null) continue;
      if (!name.startsWith('tenantId:')) continue;
      final id = int.tryParse(name.substring('tenantId:'.length));
      if (id != null) return id;
    }
    return 0;
  }
}
