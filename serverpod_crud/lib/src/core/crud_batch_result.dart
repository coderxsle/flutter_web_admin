import 'package:serverpod/serverpod.dart';

/// 批量操作结果模型（当前主要用于批量删除）。
///
/// 使用场景：
/// - 批量删除/批量处理后，需要向前端返回处理统计信息；
/// - 业务侧希望明确区分“请求总量、成功量、未命中量”，并拿到成功/失败明细ID。
///
/// 作用：
/// - `total`：本次参与处理的有效记录总数；
/// - `successCount`：实际成功处理的数量；
/// - `notFoundCount`：未找到或未处理成功的数量；
/// - `successIds`：本次处理成功的主键ID列表；
/// - `failedIds`：本次处理失败（通常是未找到）的主键ID列表。
class CrudBatchResult implements SerializableModel {
  final int total;
  final int successCount;
  final int notFoundCount;
  final List<int> successIds;
  final List<int> failedIds;

  const CrudBatchResult({
    required this.total,
    required this.successCount,
    required this.notFoundCount,
    this.successIds = const [],
    this.failedIds = const [],
  });

  factory CrudBatchResult.fromJson(Map<String, dynamic> json) {
    return CrudBatchResult(
      total: json['total'] as int? ?? 0,
      successCount: json['successCount'] as int? ?? 0,
      notFoundCount: json['notFoundCount'] as int? ?? 0,
      successIds: (json['successIds'] as List? ?? const [])
          .whereType<int>()
          .toList(),
      failedIds: (json['failedIds'] as List? ?? const [])
          .whereType<int>()
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'successCount': successCount,
      'notFoundCount': notFoundCount,
      'successIds': successIds,
      'failedIds': failedIds,
    };
  }
}
