/// 纯中医业务规则。保持无数据库依赖，便于路由服务和单元测试复用。
class ZhongyiRules {
  ZhongyiRules._();

  /// 计算库存变化后的数量；库存不允许为负，变动量不能为零或非有限值。
  static double adjustStock({required num current, required num change}) {
    final currentValue = current.toDouble();
    final changeValue = change.toDouble();
    final next = currentValue + changeValue;
    if (!currentValue.isFinite || currentValue < 0 || !changeValue.isFinite || changeValue == 0 || next < 0) {
      throw ArgumentError('库存数量不合法');
    }
    return next;
  }

  /// 校验退款金额不超过已收且尚未退款、未处于退款流程中的金额。
  static double validateRefundAmount({
    required num paidAmount,
    required num refundedAmount,
    required num pendingRefundAmount,
    required num amount,
  }) {
    final paid = paidAmount.toDouble();
    final refunded = refundedAmount.toDouble();
    final pending = pendingRefundAmount.toDouble();
    final requested = amount.toDouble();
    if (!paid.isFinite ||
        !refunded.isFinite ||
        !pending.isFinite ||
        !requested.isFinite ||
        paid < 0 ||
        refunded < 0 ||
        pending < 0 ||
        requested <= 0 ||
        refunded + pending > paid) {
      throw ArgumentError('退款金额不合法');
    }
    if (requested > paid - refunded - pending) {
      throw ArgumentError('退款金额超过可退金额');
    }
    return requested;
  }

  /// 根据收费、实收、退款进度计算可用于前端展示的状态码。
  static String paymentStatus({
    required num total,
    required num paid,
    required num refunded,
    bool hasPendingRefund = false,
  }) {
    final totalValue = total.toDouble();
    final paidValue = paid.toDouble();
    final refundedValue = refunded.toDouble();
    if (!totalValue.isFinite ||
        !paidValue.isFinite ||
        !refundedValue.isFinite ||
        totalValue < 0 ||
        paidValue < 0 ||
        paidValue > totalValue ||
        refundedValue < 0 ||
        refundedValue > paidValue) {
      throw ArgumentError('收费状态金额不合法');
    }
    if (paidValue > 0 && refundedValue >= paidValue) return 'refunded';
    if (hasPendingRefund) return 'refunding';
    if (refundedValue > 0) return 'partially_refunded';
    if (paidValue <= 0) return 'unpaid';
    if (paidValue < totalValue) return 'partially_paid';
    return 'paid';
  }

  /// 规范处方模板药味并校验必要字段。
  static List<Map<String, dynamic>> validateTemplateItems(List<dynamic> items) {
    final result = <Map<String, dynamic>>[];
    for (var index = 0; index < items.length; index++) {
      final item = items[index];
      if (item is! Map) throw ArgumentError('药味必须是对象');
      final medicineId = _positiveInt(item['medicine_id']);
      final dosage = _positiveNumber(item['dosage_grams']);
      if (medicineId == null || dosage == null) {
        throw ArgumentError('药味必须包含有效的 medicine_id 和正剂量');
      }
      final sortOrder = _nonNegativeInt(item['sort_order']) ?? index;
      final dosageUnit = _nonEmptyString(item['dosage_unit']) ?? 'g';
      result.add({
        ...item.map((key, value) => MapEntry(key.toString(), value)),
        'medicine_id': medicineId,
        'dosage_grams': dosage,
        'sort_order': sortOrder,
        'dosage_unit': dosageUnit,
      });
    }
    return result;
  }

  /// 患者列表投影。患者管理页需要完整档案数据，因此保留调用方传入的所有字段，
  /// 但服务层仍不把租户、软删除和审计字段传入该方法。
  static Map<String, dynamic> patientSummary(Map<String, dynamic> patient) {
    return Map<String, dynamic>.from(patient);
  }

  static int? _positiveInt(Object? value) {
    final number = value is num ? value : int.tryParse(value?.toString() ?? '');
    if (number == null || !number.isFinite || number <= 0 || number % 1 != 0) return null;
    return number.toInt();
  }

  static int? _nonNegativeInt(Object? value) {
    if (value == null) return null;
    final number = value is num ? value : int.tryParse(value.toString());
    if (number == null || !number.isFinite || number < 0 || number % 1 != 0) return null;
    return number.toInt();
  }

  static double? _positiveNumber(Object? value) {
    final number = value is num ? value.toDouble() : double.tryParse(value?.toString() ?? '');
    if (number == null || !number.isFinite || number <= 0) return null;
    return number;
  }

  static String? _nonEmptyString(Object? value) {
    if (value == null) return null;
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }

}
