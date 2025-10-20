import 'package:flutter/material.dart';
import '../models/filter_model.dart';

/// 列固定位置
enum TableColumnFixed {
  left,
  right,
}

/// 列对齐方式
enum TableColumnAlign {
  left,
  center,
  right,
}

/// 表格列配置
class TableColumnConfig<T> {
  /// 列标题
  final String title;
  
  /// 数据字段名（用于从 Map 或对象中获取数据）
  final String? dataIndex;
  
  /// 列键（唯一标识）
  final String? key;
  
  /// 列宽度
  final double? width;
  
  /// 最小宽度
  final double minWidth;
  
  /// 最大宽度
  final double? maxWidth;
  
  /// 是否固定列
  final TableColumnFixed? fixed;
  
  /// 对齐方式
  final TableColumnAlign align;
  
  /// 是否可排序
  final bool sortable;
  
  /// 自定义排序函数
  final int Function(T a, T b)? sorter;
  
  /// 是否可筛选
  final bool filterable;
  
  /// 筛选类型
  final FilterType? filterType;
  
  /// 筛选选项（用于下拉选择类型）
  final List<FilterOption>? filterOptions;
  
  /// 自定义筛选函数
  final bool Function(T record, dynamic filterValue)? filterFunction;
  
  /// 是否可调整大小
  final bool resizable;
  
  /// 是否显示
  final bool show;
  
  /// 是否可以隐藏（在列设置中）
  final bool hideable;
  
  /// 是否可拖拽
  final bool draggable;
  
  /// 自定义单元格渲染
  final Widget Function(BuildContext context, T record, int index)? cellBuilder;
  
  /// 自定义表头渲染
  final Widget Function(BuildContext context)? headerBuilder;
  
  /// 自定义表头筛选器渲染
  final Widget Function(BuildContext context, void Function(dynamic) onFilter)? filterBuilder;
  
  /// 单元格样式
  final TextStyle? cellStyle;
  
  /// 表头样式
  final TextStyle? headerStyle;
  
  /// 提示文本
  final String? tooltip;
  
  /// 是否支持省略显示
  final bool ellipsis;
  
  /// 数据格式化函数
  final String Function(T record)? formatter;

  const TableColumnConfig({
    required this.title,
    this.dataIndex,
    this.key,
    this.width,
    this.minWidth = 50.0,
    this.maxWidth,
    this.fixed,
    this.align = TableColumnAlign.left,
    this.sortable = false,
    this.sorter,
    this.filterable = false,
    this.filterType,
    this.filterOptions,
    this.filterFunction,
    this.resizable = true,
    this.show = true,
    this.hideable = true,
    this.draggable = true,
    this.cellBuilder,
    this.headerBuilder,
    this.filterBuilder,
    this.cellStyle,
    this.headerStyle,
    this.tooltip,
    this.ellipsis = true,
    this.formatter,
  });

  /// 获取列的唯一标识
  String get columnKey => key ?? dataIndex ?? title;

  /// 获取对齐方式
  Alignment get alignment {
    switch (align) {
      case TableColumnAlign.left:
        return Alignment.centerLeft;
      case TableColumnAlign.center:
        return Alignment.center;
      case TableColumnAlign.right:
        return Alignment.centerRight;
    }
  }

  /// 获取文本对齐方式
  TextAlign get textAlign {
    switch (align) {
      case TableColumnAlign.left:
        return TextAlign.left;
      case TableColumnAlign.center:
        return TextAlign.center;
      case TableColumnAlign.right:
        return TextAlign.right;
    }
  }

  /// 从数据中获取值
  dynamic getValue(T record) {
    if (dataIndex == null) return null;
    
    try {
      // 如果是 Map 类型
      if (record is Map<String, dynamic>) {
        return record[dataIndex];
      }
      
      // 如果有自定义格式化函数
      if (formatter != null) {
        return formatter!(record);
      }
      
      // 尝试通过反射获取属性值（简化版，实际可能需要更复杂的逻辑）
      return null;
    } catch (e) {
      return null;
    }
  }

  /// 格式化显示值
  String getDisplayValue(T record) {
    if (formatter != null) {
      return formatter!(record);
    }
    
    final value = getValue(record);
    return value?.toString() ?? '';
  }

  /// 复制并修改
  TableColumnConfig<T> copyWith({
    String? title,
    String? dataIndex,
    String? key,
    double? width,
    double? minWidth,
    double? maxWidth,
    TableColumnFixed? fixed,
    TableColumnAlign? align,
    bool? sortable,
    int Function(T a, T b)? sorter,
    bool? filterable,
    FilterType? filterType,
    List<FilterOption>? filterOptions,
    bool Function(T record, dynamic filterValue)? filterFunction,
    bool? resizable,
    bool? show,
    bool? hideable,
    bool? draggable,
    Widget Function(BuildContext context, T record, int index)? cellBuilder,
    Widget Function(BuildContext context)? headerBuilder,
    Widget Function(BuildContext context, void Function(dynamic) onFilter)? filterBuilder,
    TextStyle? cellStyle,
    TextStyle? headerStyle,
    String? tooltip,
    bool? ellipsis,
    String Function(T record)? formatter,
  }) {
    return TableColumnConfig<T>(
      title: title ?? this.title,
      dataIndex: dataIndex ?? this.dataIndex,
      key: key ?? this.key,
      width: width ?? this.width,
      minWidth: minWidth ?? this.minWidth,
      maxWidth: maxWidth ?? this.maxWidth,
      fixed: fixed ?? this.fixed,
      align: align ?? this.align,
      sortable: sortable ?? this.sortable,
      sorter: sorter ?? this.sorter,
      filterable: filterable ?? this.filterable,
      filterType: filterType ?? this.filterType,
      filterOptions: filterOptions ?? this.filterOptions,
      filterFunction: filterFunction ?? this.filterFunction,
      resizable: resizable ?? this.resizable,
      show: show ?? this.show,
      hideable: hideable ?? this.hideable,
      draggable: draggable ?? this.draggable,
      cellBuilder: cellBuilder ?? this.cellBuilder,
      headerBuilder: headerBuilder ?? this.headerBuilder,
      filterBuilder: filterBuilder ?? this.filterBuilder,
      cellStyle: cellStyle ?? this.cellStyle,
      headerStyle: headerStyle ?? this.headerStyle,
      tooltip: tooltip ?? this.tooltip,
      ellipsis: ellipsis ?? this.ellipsis,
      formatter: formatter ?? this.formatter,
    );
  }
}

/// 筛选选项
class FilterOption {
  /// 显示文本
  final String label;
  
  /// 值
  final dynamic value;
  
  /// 是否选中
  final bool selected;

  const FilterOption({
    required this.label,
    required this.value,
    this.selected = false,
  });

  FilterOption copyWith({
    String? label,
    dynamic value,
    bool? selected,
  }) {
    return FilterOption(
      label: label ?? this.label,
      value: value ?? this.value,
      selected: selected ?? this.selected,
    );
  }
}



