import 'package:flutter_web_server/src/utils/operate_utils.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 基于 sys_operate_log 的审计实现。
/// `DbAuditService<T>`：给 BaseService.create/update/delete/deleteBatch 这类数据变更用的（auditService.record）。
/// 查询行为如（getDetail、getList）用的审计请走：Query 插件（ CrudRuntime -> audit plugins）。
/// 
/// 供业务项目注入到 BaseService / 自定义 Service，
/// 将 CRUD 审计事件持久化到操作日志表。
class DbAuditService<T> extends AuditService<T> {
  const DbAuditService({this.type = 'crud', this.resolveTenantId});

  /// 操作模块类型（sys_operate_log.type）
  final String type;

  /// 可选：外部租户解析器（不传则尝试从 session.authenticated.scope/scopes 提取）
  final int Function(Session session)? resolveTenantId;

  @override
  Future<void> record(Session session, AuditLog<T> log) async {
    final subType = log.action.name;
    final payload = {
      'actorId': log.actorId,
      'entityId': log.entityId,
      'before': OperateLogWriter.serializeValue(log.before),
      'after': OperateLogWriter.serializeValue(log.after),
      'timestamp': log.timestamp.toIso8601String(),
    };

    await OperateLogWriter.write(
      session,
      type: type,
      subType: subType,
      traceId: log.traceId,
      action: subType,
      bizId: log.entityId ?? 0,
      extra: payload,
      createTime: log.timestamp,
      resolveTenantId: resolveTenantId,
      tracePrefix: 'audit',
      errorLogPrefix: 'audit-record-failed',
    );
  }
}
