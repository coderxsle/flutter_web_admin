/// 审计动作类型：增、改、删、查。
enum AuditAction { create, update, delete, query }

/// 审计记录模型。
///
/// - before / after：用于记录变更前后快照
/// - actorId：操作者（可选）
/// - entityId：实体主键（可选）
class AuditLog<T> {

  final AuditAction action;    // 审计的动作类型（如 create/update/delete/query）
  final DateTime timestamp;    // 审计记录的发生时间
  final String? traceId;       // 关联链路追踪ID，用于日志链路跟踪（可选）
  final String? actorId;       // 操作者ID（可选，标识谁进行了操作）
  final int? entityId;         // 实体主键ID（可选，标识操作的对象）
  final T? before;             // 操作前的实体快照（如增、改、删时）
  final T? after;              // 操作后的实体快照（如增、改、删时）
  
  const AuditLog({
    required this.action,
    required this.timestamp,
    this.traceId,
    this.actorId,
    this.entityId,
    this.before,
    this.after,
  });
}
