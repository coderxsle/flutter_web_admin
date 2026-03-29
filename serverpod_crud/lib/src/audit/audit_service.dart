import 'package:serverpod/serverpod.dart';

import 'audit_log.dart';

/// 审计服务抽象：用于持久化/上报审计日志。
abstract class AuditService<T> {
  const AuditService();

  Future<void> record(Session session, AuditLog<T> log);
}

/// 兜底默认实现
/// 空实现审计服务：默认不做任何记录。
class NoopAuditService<T> extends AuditService<T> {
  const NoopAuditService();

  @override
  Future<void> record(Session session, AuditLog<T> log) async {}
}
