import 'package:serverpod/serverpod.dart';
import 'audit_log.dart';

/// 审计服务抽象：用于持久化/上报审计日志。
abstract class AuditService<T> {
  const AuditService();
  Future<void> record(Session session, AuditLog<T> log);
}

/// 兜底默认实现：**不持久化**任何审计，但会在丢弃记录时打一条 warn。
///
/// 「静默丢弃」改成「出声丢弃」是刻意的：`BaseService` 的 `auditService` 默认
/// 就是它，所以忘了注入真实实现的资源会**一条审计都不落库、却毫无症状** ——
/// 本项目 `/api/book` 就这样裸奔了很久。同一个实体类型只出声一次，不按每条
/// 写操作刷屏。
class NoopAuditService<T> extends AuditService<T> {
  const NoopAuditService();

  /// 已经 warn 过的类型 —— 同一个资源只提醒一次。
  ///
  /// ⚠️ Dart 泛型类的 `static` 字段是**所有实例化共享一份**（不像 C++ 每个
  /// 实例化各有一份），所以要按 `T` 自己记账。
  static final Set<String> _warned = <String>{};

  @override
  Future<void> record(Session session, AuditLog<T> log) async {
    if (!_warned.add('$T')) return;
    try {
      session.log(
        '审计没有落库：$T 的 ${log.action.name} 事件没有配 auditService，'
        '记录的审计被丢弃。给对应的 Service / AutoCrudDelegate 传一个 AuditService'
        '（本项目是 DbAuditService）即可消除这条 warning。',
        level: LogLevel.warning,
      );
    } catch (_) {
      // 出声本身绝不能让业务写操作失败 —— 与 OperateLogWriter 的口径一致。
    }
  }
}
