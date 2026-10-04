/// 单个过滤条件：field + comparator + value。
//  网络传来的字符串 "123" → 解析为 int 123
//  网络传来的字符串 "true" → 解析为 bool true
//  网络传来的字符串 "[1,2,3]" → 解析为 List [1, 2, 3]
//  网络传来的字符串 "hello" → 保留为 String "hello"
class QueryCondition {

  /// 字段名（必须做白名单校验）
  final String field;

  /// 比较操作符：eq/ne/like/in/between/gt/gte/lt/lte
  final String comparator;

  /// 值（已解析后的 dynamic 类型）
  final dynamic value;

  /// 标准化操作符（统一小写）
  String get op => comparator.toLowerCase();

  /// 是否需要数组值（in / between）
  bool get requiresListValue => op == 'in' || op == 'between';

  const QueryCondition({required this.field, required this.comparator, this.value});

  /// 校验（⚠️ 强烈建议在 service 层调用）
  void validate({Set<String>? allowedFields,  Set<String>? allowedOperators}) {
    // 1. 字段白名单（防 SQL 注入）
    if (allowedFields != null && !allowedFields.contains(field)) {
      throw ArgumentError('Invalid field: $field');
    }

    // 2. 操作符校验
    final validOps = allowedOperators ??
        {
          'eq', 'ne', 'like', 'ilike',
          'in', 'between',
          'gt', 'gte', 'lt', 'lte'
        };

    if (!validOps.contains(op)) {
      throw ArgumentError('Invalid operator: $comparator');
    }

    // 3. value 校验
    if (requiresListValue && value is! List) {
      throw ArgumentError('$comparator requires List value');
    }

    if (op == 'between' && (value as List).length != 2) {
      throw ArgumentError('between requires exactly 2 values');
    }
  }

  /// 转 SQL 片段（⚠️ 推荐配合参数绑定，不要直接拼值）
  String toSql({required int paramIndexStart}) {
    switch (op) {
      case 'eq':
        return '$field = \$$paramIndexStart';
      case 'ne':
        return '$field != \$$paramIndexStart';
      case 'gt':
        return '$field > \$$paramIndexStart';
      case 'gte':
        return '$field >= \$$paramIndexStart';
      case 'lt':
        return '$field < \$$paramIndexStart';
      case 'lte':
        return '$field <= \$$paramIndexStart';
      case 'like':
      case 'ilike':
        return '$field ${op.toUpperCase()} \$$paramIndexStart';
      case 'in':
        final list = value as List;
        final params = List.generate(
          list.length,
          (i) => '\$${paramIndexStart + i}',
        ).join(', ');
        return '$field IN ($params)';
      case 'between':
        return '$field BETWEEN \$$paramIndexStart AND \$${paramIndexStart + 1}';
      default:
        throw UnsupportedError('Unsupported operator: $op');
    }
  }

  /// 提取参数列表（配合 SQL 占位符）
  List<dynamic> get params {
    if (value == null) return [];

    if (requiresListValue) {
      return List<dynamic>.from(value);
    }

    return [value];
  }

  /// 拷贝
  QueryCondition copyWith({
    String? field,
    String? comparator,
    dynamic value,
  }) {
    return QueryCondition(
      field: field ?? this.field,
      comparator: comparator ?? this.comparator,
      value: value ?? this.value,
    );
  }

  /// JSON 反序列化
  factory QueryCondition.fromJson(Map<String, dynamic> json) {
    return QueryCondition(
      field: json['field'] as String,
      comparator: json['comparator'] as String,
      value: json['value'],
    );
  }

  /// JSON 序列化
  Map<String, dynamic> toJson() {
    return {
      'field': field,
      'comparator': comparator,
      'value': value,
    };
  }

  @override
  String toString() =>
      'QueryCondition(field: $field, op: $comparator, value: $value)';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QueryCondition &&
          field == other.field &&
          op == other.op &&
          value == other.value;

  @override
  int get hashCode => field.hashCode ^ op.hashCode ^ value.hashCode;
}