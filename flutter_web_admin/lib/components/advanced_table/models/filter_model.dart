/// 筛选类型枚举
enum FilterType {
  text,       // 文本筛选
  number,     // 数字筛选
  date,       // 日期筛选
  select,     // 下拉选择
  multiSelect, // 多选
  custom,     // 自定义筛选
}

/// 筛选操作符枚举
enum FilterOperator {
  equals,          // 等于
  notEquals,       // 不等于
  contains,        // 包含
  notContains,     // 不包含
  startsWith,      // 开始于
  endsWith,        // 结束于
  greaterThan,     // 大于
  greaterThanOrEqual, // 大于等于
  lessThan,        // 小于
  lessThanOrEqual, // 小于等于
  between,         // 介于
  isEmpty,         // 为空
  isNotEmpty,      // 不为空
}

/// 筛选条件
class FilterCondition {
  /// 列键
  final String columnKey;
  
  /// 筛选类型
  final FilterType type;
  
  /// 操作符
  final FilterOperator operator;
  
  /// 筛选值
  final dynamic value;
  
  /// 第二个值（用于 between 操作）
  final dynamic value2;

  const FilterCondition({
    required this.columnKey,
    required this.type,
    required this.operator,
    this.value,
    this.value2,
  });

  /// 复制并修改
  FilterCondition copyWith({
    String? columnKey,
    FilterType? type,
    FilterOperator? operator,
    dynamic value,
    dynamic value2,
  }) {
    return FilterCondition(
      columnKey: columnKey ?? this.columnKey,
      type: type ?? this.type,
      operator: operator ?? this.operator,
      value: value ?? this.value,
      value2: value2 ?? this.value2,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FilterCondition &&
        other.columnKey == columnKey &&
        other.type == type &&
        other.operator == operator &&
        other.value == value &&
        other.value2 == value2;
  }

  @override
  int get hashCode =>
      columnKey.hashCode ^
      type.hashCode ^
      operator.hashCode ^
      value.hashCode ^
      value2.hashCode;
}

/// 筛选逻辑组合
enum FilterLogic {
  and, // 且
  or,  // 或
}

/// 筛选模型
class FilterModel {
  /// 筛选条件列表
  final List<FilterCondition> conditions;
  
  /// 条件之间的逻辑关系（AND/OR）
  final FilterLogic logic;
  
  /// 全局搜索关键词
  final String? globalSearch;

  const FilterModel({
    this.conditions = const [],
    this.logic = FilterLogic.and,
    this.globalSearch,
  });

  /// 添加筛选条件
  FilterModel addCondition(FilterCondition condition) {
    return FilterModel(
      conditions: [...conditions, condition],
      logic: logic,
      globalSearch: globalSearch,
    );
  }

  /// 移除筛选条件
  FilterModel removeCondition(String columnKey) {
    return FilterModel(
      conditions: conditions.where((c) => c.columnKey != columnKey).toList(),
      logic: logic,
      globalSearch: globalSearch,
    );
  }

  /// 更新筛选条件
  FilterModel updateCondition(FilterCondition condition) {
    final index = conditions.indexWhere((c) => c.columnKey == condition.columnKey);
    if (index == -1) {
      return addCondition(condition);
    }
    final newConditions = [...conditions];
    newConditions[index] = condition;
    return FilterModel(
      conditions: newConditions,
      logic: logic,
      globalSearch: globalSearch,
    );
  }

  /// 设置全局搜索
  FilterModel setGlobalSearch(String? search) {
    return FilterModel(
      conditions: conditions,
      logic: logic,
      globalSearch: search,
    );
  }

  /// 清空所有筛选
  FilterModel clear() {
    return const FilterModel();
  }

  /// 是否有活动的筛选
  bool get hasActiveFilters => conditions.isNotEmpty || (globalSearch?.isNotEmpty ?? false);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is FilterModel &&
        other.logic == logic &&
        other.globalSearch == globalSearch &&
        _listEquals(other.conditions, conditions);
  }

  bool _listEquals(List a, List b) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode => conditions.hashCode ^ logic.hashCode ^ globalSearch.hashCode;
}

