import 'package:flutter/material.dart';

/// 表格列配置类
/// 
/// 定义表格列的属性和行为，支持排序、筛选、自定义渲染等功能
class GiTableColumn<T> {
  /// 列标题
  final String title;
  
  /// 数据字段名
  final String? dataIndex;
  
  /// 列宽度
  final double? width;
  
  /// 最小宽度
  final double? minWidth;
  
  /// 最大宽度
  final double? maxWidth;
  
  /// 是否固定列
  final bool fixed;
  
  /// 固定位置（左侧或右侧）
  final GiTableColumnFixed? fixedSide;
  
  /// 对齐方式
  final Alignment alignment;
  
  /// 是否可排序
  final bool sortable;
  
  /// 排序比较器
  final int Function(T a, T b)? sorter;
  
  /// 是否可筛选
  final bool filterable;
  
  /// 筛选器
  final bool Function(T item, String query)? filter;
  
  /// 是否可调整大小
  final bool resizable;
  
  /// 是否显示
  final bool show;
  
  /// 是否可以通过列设置隐藏
  final bool hideable;
  
  /// 自定义单元格构建器
  final Widget Function(BuildContext context, T record, int index)? cellBuilder;
  
  /// 自定义头部构建器
  final Widget Function(BuildContext context)? headerBuilder;
  
  /// 列的唯一标识
  final String? key;
  
  /// 是否是操作列
  final bool isAction;

  const GiTableColumn({
    required this.title,
    this.dataIndex,
    this.width,
    this.minWidth,
    this.maxWidth,
    this.fixed = false,
    this.fixedSide,
    this.alignment = Alignment.centerLeft,
    this.sortable = false,
    this.sorter,
    this.filterable = false,
    this.filter,
    this.resizable = true,
    this.show = true,
    this.hideable = true,
    this.cellBuilder,
    this.headerBuilder,
    this.key,
    this.isAction = false,
  });

  /// 获取列的唯一标识
  String get columnKey => key ?? dataIndex ?? title;

  /// 复制并修改列配置
  GiTableColumn<T> copyWith({
    String? title,
    String? dataIndex,
    double? width,
    double? minWidth,
    double? maxWidth,
    bool? fixed,
    GiTableColumnFixed? fixedSide,
    Alignment? alignment,
    bool? sortable,
    int Function(T a, T b)? sorter,
    bool? filterable,
    bool Function(T item, String query)? filter,
    bool? resizable,
    bool? show,
    bool? hideable,
    Widget Function(BuildContext context, T record, int index)? cellBuilder,
    Widget Function(BuildContext context)? headerBuilder,
    String? key,
    bool? isAction,
  }) {
    return GiTableColumn<T>(
      title: title ?? this.title,
      dataIndex: dataIndex ?? this.dataIndex,
      width: width ?? this.width,
      minWidth: minWidth ?? this.minWidth,
      maxWidth: maxWidth ?? this.maxWidth,
      fixed: fixed ?? this.fixed,
      fixedSide: fixedSide ?? this.fixedSide,
      alignment: alignment ?? this.alignment,
      sortable: sortable ?? this.sortable,
      sorter: sorter ?? this.sorter,
      filterable: filterable ?? this.filterable,
      filter: filter ?? this.filter,
      resizable: resizable ?? this.resizable,
      show: show ?? this.show,
      hideable: hideable ?? this.hideable,
      cellBuilder: cellBuilder ?? this.cellBuilder,
      headerBuilder: headerBuilder ?? this.headerBuilder,
      key: key ?? this.key,
      isAction: isAction ?? this.isAction,
    );
  }

  /// 从数据中获取值
  dynamic getValue(T record) {
    if (dataIndex == null) return null;
    
    // 简单的属性访问，实际项目中可能需要更复杂的逻辑
    try {
      final map = record as Map<String, dynamic>;
      return map[dataIndex];
    } catch (e) {
      return null;
    }
  }
}

/// 固定列位置枚举
enum GiTableColumnFixed {
  left,
  right,
}

/// 排序方向枚举
enum GiTableSortDirection {
  none,
  ascending,
  descending,
}

/// 排序配置类
class GiTableSortConfig<T> {
  final String columnKey;
  final GiTableSortDirection direction;
  final int Function(T a, T b)? sorter;

  const GiTableSortConfig({
    required this.columnKey,
    required this.direction,
    this.sorter,
  });
}

/// 表格选择配置类
class GiTableSelection<T> {
  /// 选择类型
  final GiTableSelectionType type;
  
  /// 已选择的行
  final Set<String> selectedRowKeys;
  
  /// 选择变化回调
  final void Function(Set<String> selectedKeys, List<T> selectedRows)? onSelectionChanged;
  
  /// 获取行的唯一标识
  final String Function(T record)? getRowKey;
  
  /// 是否显示全选
  final bool showSelectAll;

  const GiTableSelection({
    required this.type,
    required this.selectedRowKeys,
    this.onSelectionChanged,
    this.getRowKey,
    this.showSelectAll = true,
  });
}

/// 选择类型枚举
enum GiTableSelectionType {
  none,
  single,
  multiple,
}

/// 表格尺寸枚举
enum GiTableSize {
  mini,
  small,
  medium,
  large,
}

/// 表格工具栏配置类
class GiTableToolbarConfig {
  /// 是否显示刷新按钮
  final bool showRefresh;
  
  /// 是否显示全屏按钮
  final bool showFullscreen;
  
  /// 是否显示边框切换按钮
  final bool showBorder;
  
  /// 是否显示尺寸切换按钮
  final bool showSize;
  
  /// 是否显示列设置按钮
  final bool showColumnSetting;
  
  /// 是否显示斑马纹切换按钮
  final bool showStripe;

  const GiTableToolbarConfig({
    this.showRefresh = true,
    this.showFullscreen = true,
    this.showBorder = true,
    this.showSize = true,
    this.showColumnSetting = true,
    this.showStripe = true,
  });
}
