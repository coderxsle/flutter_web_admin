import 'package:serverpod/serverpod.dart';

/// 排序条件。
/// Query sort option
/// 单条排序规则（会被 QueryRequest.sort 引用）。
///
/// 字段说明：
/// - field：排序字段名（需是后端允许的可排序字段）
/// - order：排序方向，默认 asc；可传 desc
///
/// 多字段排序示例：
/// sort = [
///   { field: "createTime", order: "desc" },
///   { field: "id", order: "asc" }
/// ]
/// 表示先按 createTime 倒序，再按 id 升序。
class QuerySort implements SerializableModel{

  /// 排序字段（建议做白名单校验）
  final String field;

  /// 排序方向：asc / desc（默认 asc）
  final String order;

  /// 是否降序
  bool get isDesc => order.toLowerCase() == 'desc';

  /// 是否升序
  bool get isAsc => !isDesc;

  /// 标准化排序方向（统一小写）
  String get normalizedOrder => isDesc ? 'desc' : 'asc';

  const QuerySort({required this.field, String? order}) : order = order ?? 'asc';

  /// 校验是否合法（建议在 service 层调用）
  void validate({Set<String>? allowedFields}) {
    // 1. 校验字段白名单（防 SQL 注入关键点）
    if (allowedFields != null && !allowedFields.contains(field)) {
      throw ArgumentError('Invalid sort field: $field');
    }

    // 2. 校验排序方向
    final o = order.toLowerCase();
    if (o != 'asc' && o != 'desc') {
      throw ArgumentError('Invalid sort order: $order');
    }
  }

  /// 拷贝
  QuerySort copyWith({String? field, String? order}) {
    return QuerySort(
      field: field ?? this.field,
      order: order ?? this.order,
    );
  }

  /// JSON 反序列化
  factory QuerySort.fromJson(Map<String, dynamic> json) {
    return QuerySort(
      field: json['field'] as String,
      order: json['order'] as String?,
    );
  }

  /// JSON 序列化
  @override
  Map<String, dynamic> toJson() {
    return {
      'field': field,
      'order': order,
    };
  }

  @override
  String toString() => 'QuerySort(field: $field, order: $order)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuerySort &&
          runtimeType == other.runtimeType &&
          field == other.field &&
          normalizedOrder == other.normalizedOrder;

  @override
  int get hashCode => field.hashCode ^ normalizedOrder.hashCode;
}