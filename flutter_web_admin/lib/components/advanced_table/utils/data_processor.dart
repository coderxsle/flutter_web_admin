import '../models/filter_model.dart';
import '../models/sort_model.dart';
import '../config/table_column_config.dart';

/// 数据处理器
class DataProcessor<T> {
  /// 应用筛选
  static List<T> applyFilter<T>(
    List<T> data,
    FilterModel? filterModel,
    List<TableColumnConfig<T>> columns,
  ) {
    if (filterModel == null || !filterModel.hasActiveFilters) {
      return data;
    }

    var result = data;

    // 应用全局搜索
    if (filterModel.globalSearch != null && filterModel.globalSearch!.isNotEmpty) {
      result = _applyGlobalSearch(result, filterModel.globalSearch!, columns);
    }

    // 应用列筛选
    if (filterModel.conditions.isNotEmpty) {
      result = _applyColumnFilters(result, filterModel.conditions, filterModel.logic, columns);
    }

    return result;
  }

  /// 应用全局搜索
  static List<T> _applyGlobalSearch<T>(
    List<T> data,
    String searchText,
    List<TableColumnConfig<T>> columns,
  ) {
    final lowerSearch = searchText.toLowerCase();
    
    return data.where((record) {
      // 检查所有可搜索的列
      for (final column in columns) {
        if (column.dataIndex != null) {
          final value = column.getDisplayValue(record).toLowerCase();
          if (value.contains(lowerSearch)) {
            return true;
          }
        }
      }
      return false;
    }).toList();
  }

  /// 应用列筛选
  static List<T> _applyColumnFilters<T>(
    List<T> data,
    List<FilterCondition> conditions,
    FilterLogic logic,
    List<TableColumnConfig<T>> columns,
  ) {
    return data.where((record) {
      if (logic == FilterLogic.and) {
        // AND 逻辑：所有条件都满足
        return conditions.every((condition) => _matchCondition(record, condition, columns));
      } else {
        // OR 逻辑：任一条件满足
        return conditions.any((condition) => _matchCondition(record, condition, columns));
      }
    }).toList();
  }

  /// 匹配单个筛选条件
  static bool _matchCondition<T>(
    T record,
    FilterCondition condition,
    List<TableColumnConfig<T>> columns,
  ) {
    final column = columns.firstWhere(
      (col) => col.columnKey == condition.columnKey,
      orElse: () => throw Exception('Column ${condition.columnKey} not found'),
    );

    // 如果列有自定义筛选函数
    if (column.filterFunction != null) {
      return column.filterFunction!(record, condition.value);
    }

    final value = column.getValue(record);

    switch (condition.operator) {
      case FilterOperator.equals:
        return value == condition.value;
      case FilterOperator.notEquals:
        return value != condition.value;
      case FilterOperator.contains:
        return value?.toString().toLowerCase().contains(
              condition.value?.toString().toLowerCase() ?? '',
            ) ?? false;
      case FilterOperator.notContains:
        return !(value?.toString().toLowerCase().contains(
              condition.value?.toString().toLowerCase() ?? '',
            ) ?? false);
      case FilterOperator.startsWith:
        return value?.toString().toLowerCase().startsWith(
              condition.value?.toString().toLowerCase() ?? '',
            ) ?? false;
      case FilterOperator.endsWith:
        return value?.toString().toLowerCase().endsWith(
              condition.value?.toString().toLowerCase() ?? '',
            ) ?? false;
      case FilterOperator.greaterThan:
        if (value is num && condition.value is num) {
          return value > condition.value;
        }
        return false;
      case FilterOperator.greaterThanOrEqual:
        if (value is num && condition.value is num) {
          return value >= condition.value;
        }
        return false;
      case FilterOperator.lessThan:
        if (value is num && condition.value is num) {
          return value < condition.value;
        }
        return false;
      case FilterOperator.lessThanOrEqual:
        if (value is num && condition.value is num) {
          return value <= condition.value;
        }
        return false;
      case FilterOperator.between:
        if (value is num && condition.value is num && condition.value2 is num) {
          return value >= condition.value && value <= condition.value2;
        }
        return false;
      case FilterOperator.isEmpty:
        return value == null || value.toString().isEmpty;
      case FilterOperator.isNotEmpty:
        return value != null && value.toString().isNotEmpty;
    }
  }

  /// 应用排序
  static List<T> applySort<T>(
    List<T> data,
    SortModel? sortModel,
    List<TableColumnConfig<T>> columns,
  ) {
    if (sortModel == null || sortModel.direction == SortDirection.none) {
      return data;
    }

    final column = columns.firstWhere(
      (col) => col.columnKey == sortModel.columnKey,
      orElse: () => throw Exception('Column ${sortModel.columnKey} not found'),
    );

    final sortedList = List<T>.from(data);

    // 使用自定义排序函数或默认排序
    if (column.sorter != null || sortModel.sorter != null) {
      final sorter = sortModel.sorter ?? column.sorter!;
      sortedList.sort(sorter);
    } else {
      // 默认排序逻辑
      sortedList.sort((a, b) {
        final valueA = column.getValue(a);
        final valueB = column.getValue(b);
        
        if (valueA == null && valueB == null) return 0;
        if (valueA == null) return -1;
        if (valueB == null) return 1;
        
        if (valueA is Comparable && valueB is Comparable) {
          return valueA.compareTo(valueB);
        }
        
        return valueA.toString().compareTo(valueB.toString());
      });
    }

    // 如果是降序，反转列表
    if (sortModel.direction == SortDirection.descending) {
      return sortedList.reversed.toList();
    }

    return sortedList;
  }

  /// 应用分页
  static List<T> applyPagination<T>(
    List<T> data,
    int currentPage,
    int pageSize,
  ) {
    final startIndex = (currentPage - 1) * pageSize;
    final endIndex = (startIndex + pageSize).clamp(0, data.length);
    
    if (startIndex >= data.length) {
      return [];
    }
    
    return data.sublist(startIndex, endIndex);
  }

  /// 完整的数据处理流程
  static List<T> processData<T>({
    required List<T> rawData,
    FilterModel? filterModel,
    SortModel? sortModel,
    int? currentPage,
    int? pageSize,
    required List<TableColumnConfig<T>> columns,
  }) {
    var result = rawData;

    // 1. 筛选
    result = applyFilter(result, filterModel, columns);

    // 2. 排序
    result = applySort(result, sortModel, columns);

    // 3. 分页（如果启用）
    if (currentPage != null && pageSize != null) {
      result = applyPagination(result, currentPage, pageSize);
    }

    return result;
  }
}



