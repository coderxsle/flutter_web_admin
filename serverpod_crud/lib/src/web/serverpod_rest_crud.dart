import 'package:serverpod/serverpod.dart';

import 'base_route.dart';
import 'crud_delegate.dart';
import 'envelope_builder.dart';

/// 一行注册 —— 用户要的 `registerCrud<User>('/api/user')` 形态。
extension ServerpodRestCrud on Serverpod {
  /// 注册一个 REST 资源。
  ///
  /// ```dart
  /// pod.registerCrud<SysUser>('/api/user');                  // 全自动
  /// pod.registerCrud<SysUser>('/api/user', delegate: Xxx());  // 自定义
  /// ```
  void registerCrud<T extends TableRow>(
    String path, {
    CrudDelegate<T>? delegate,
    EnvelopeBuilder envelope = const PlainEnvelopeBuilder(),
    bool requireAuth = true,
    bool enableCreate = true,
    bool enableBatchDelete = true,
  }) {
    webServer.addRoute(
      BaseRoute<T>(
        delegate: delegate,
        envelope: envelope,
        requireAuth: requireAuth,
        enableCreate: enableCreate,
        enableBatchDelete: enableBatchDelete,
      ),
      path,
    );
  }
}
