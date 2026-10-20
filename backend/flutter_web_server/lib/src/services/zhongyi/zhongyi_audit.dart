import 'package:flutter_web_server/src/utils/operate_utils.dart';
import 'package:serverpod/serverpod.dart';

/// 中医模块审计入口：写入 sys_operate_log，extra 结构与 DbAuditService 保持一致。
/// 操作人由 OperateLogWriter 统一落 userId / creator，这里不再重复。
/// 患者、收费类只写 detail，不传 before/after，避免把姓名、账单号等资料落进日志。
class ZhongyiAudit {
  ZhongyiAudit._();

  static const String typeMedicine = 'zhongyi_medicine';
  static const String typeMedicinePrice = 'zhongyi_medicine_price';
  static const String typeMedicinePrefix = 'zhongyi_medicine_prefix';
  static const String typeInventory = 'zhongyi_inventory';
  static const String typeDepartment = 'zhongyi_department';
  static const String typeStaff = 'zhongyi_staff';
  static const String typeBill = 'zhongyi_bill';
  static const String typeRefund = 'zhongyi_refund';
  static const String typePatient = 'zhongyi_patient';
  static const String typePrescriptionTemplate = 'zhongyi_prescription_template';

  /// subType 存动作标识便于过滤，action 存中文名给列表展示。
  static const Map<String, String> _actionLabels = {
    'create': '新增',
    'update': '更新',
    'delete': '删除',
    'set_status': '更新状态',
    'stock_in': '入库',
    'adjust': '库存调整',
    'pay': '收款',
    'cancel': '取消',
    'refund_request': '申请退款',
    'refund_approve': '审批退款',
    'refund_complete': '完成退款',
  };

  /// 审计写入失败只记服务端日志，不影响已提交的业务操作。
  static Future<void> record(
    Session session, {
    required String type,
    required String action,
    required int bizId,
    Object? before,
    Object? after,
    Map<String, dynamic>? detail,
    DateTime? timestamp,
  }) async {
    final now = timestamp ?? DateTime.now();
    final payload = {
      'entityId': bizId,
      'before': OperateLogWriter.serializeValue(before),
      'after': OperateLogWriter.serializeValue(after),
      'timestamp': now.toIso8601String(),
      ...?detail,
    };
    await OperateLogWriter.write(
      session,
      type: type,
      subType: action,
      action: _actionLabels[action] ?? action,
      bizId: bizId,
      extra: jsonSafe(payload) as Map<String, dynamic>,
      createTime: now,
      tracePrefix: 'zhongyi-audit',
      errorLogPrefix: 'zhongyi-audit-write-failed',
    );
  }

  /// 只记录发生变化（请求体里出现过）的字段名，不含字段内容。
  static List<String> changedFields(Map<String, dynamic> body, Iterable<String> candidates) =>
      [for (final key in candidates) if (body.containsKey(key)) key];

  /// 快照里常有 DateTime，直接 jsonEncode 会整条丢 extra，这里统一转成可序列化值。
  static Object? jsonSafe(Object? value) {
    if (value == null || value is num || value is String || value is bool) return value;
    if (value is DateTime) return value.toIso8601String();
    if (value is Map) return {for (final entry in value.entries) '${entry.key}': jsonSafe(entry.value)};
    if (value is Iterable) return [for (final item in value) jsonSafe(item)];
    return value.toString();
  }
}
