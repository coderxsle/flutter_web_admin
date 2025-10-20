import 'package:flutter/material.dart';
import 'package:trina_grid/trina_grid.dart';
import 'gi_table_adapter.dart';

/// 列类型枚举
enum GiColumnType {
  text,             /// 文本类型
  number,           /// 数字类型
  date,             /// 日期类型
  time,             /// 时间类型
  datetime,         /// 日期时间类型
  select,           /// 选择类型 (下拉)
  currency,         /// 货币类型
  percentage,       /// 百分比类型
}

/// GiTable 列配置
/// 
/// 提供用户友好的 API,内部自动转换为 TrinaColumn
class GiTableColumn<T> {
  /// 列标题
  final String title;
  
  /// 字段名 (对应数据中的 key)
  final String field;
  
  /// 列类型
  final GiColumnType type;
  
  /// 列宽度 (默认 100)
  final double? width;
  
  /// 最小宽度 (默认 50)
  final double? minWidth;
  
  /// 是否可排序
  final bool sortable;
  
  /// 是否可筛选
  final bool filterable;
  
  /// 是否冻结列 (固定列)
  final bool frozen;
  
  /// 冻结位置 (start: 左侧, end: 右侧)
  final TrinaColumnFrozen frozenPosition;
  
  /// 文本对齐方式
  final TextAlign? textAlign;
  
  /// 是否只读
  final bool readOnly;
  
  /// 自定义单元格渲染器
  /// 
  /// 参数:
  /// - context: BuildContext
  /// - cell: TrinaCell (单元格数据)
  /// - rowIndex: 行索引
  final Widget Function(BuildContext context, TrinaCell cell, int rowIndex)? cellRenderer;
  
  /// 自定义标题渲染器
  final Widget Function(BuildContext context)? titleRenderer;
  
  /// 值格式化函数
  final String Function(dynamic value)? formatter;
  
  /// 下拉选项 (仅当 type 为 select 时有效)
  final List<String>? selectOptions;
  
  /// 是否启用列菜单
  final bool enableColumnMenu;
  
  /// 是否启用上下文菜单
  final bool enableContextMenu;
  
  const GiTableColumn({
    required this.title,
    required this.field,
    this.type = GiColumnType.text,
    this.width,
    this.minWidth,
    this.sortable = true,
    this.filterable = false,
    this.frozen = false,
    this.frozenPosition = TrinaColumnFrozen.none,
    this.textAlign,
    this.readOnly = false,
    this.cellRenderer,
    this.titleRenderer,
    this.formatter,
    this.selectOptions,
    this.enableColumnMenu = true,
    this.enableContextMenu = true,
  });
  
  /// 转换为 TrinaColumn
  TrinaColumn toTrinaColumn() {
    // 确定冻结位置
    final effectiveFrozen = frozen 
        ? (frozenPosition != TrinaColumnFrozen.none 
            ? frozenPosition 
            : TrinaColumnFrozen.start)
        : TrinaColumnFrozen.none;
    
    // 转换列类型
    TrinaColumnType trinaType;
    if (type == GiColumnType.select && selectOptions != null) {
      trinaType = TrinaColumnType.select(selectOptions!);
    } else {
      trinaType = GiTableAdapter.convertColumnType(type);
    }
    
    return TrinaColumn(
      title: title,
      field: field,
      type: trinaType,
      width: width ?? 100,
      minWidth: minWidth ?? 50,
      frozen: effectiveFrozen,
      enableSorting: sortable,
      enableFilterMenuItem: filterable,
      enableContextMenu: enableColumnMenu || enableContextMenu,
      textAlign: GiTableAdapter.convertTextAlign(textAlign),
      titleTextAlign: GiTableAdapter.convertTextAlign(textAlign),
      readOnly: readOnly,
      
      // 自定义渲染器
      renderer: cellRenderer != null
          ? (rendererContext) {
              return Builder(
                builder: (context) => cellRenderer!(
                  context,
                  rendererContext.cell,
                  rendererContext.rowIdx,
                ),
              );
            }
          : null,
      
      // 自定义标题渲染器
      titleRenderer: titleRenderer != null
          ? (rendererContext) {
              return Builder(
                builder: (context) => titleRenderer!(context),
              );
            }
          : null,
      
      // 值格式化
      formatter: formatter,
    );
  }
  
  /// 复制列配置
  GiTableColumn<T> copyWith({
    String? title,
    String? field,
    GiColumnType? type,
    double? width,
    double? minWidth,
    bool? sortable,
    bool? filterable,
    bool? frozen,
    TrinaColumnFrozen? frozenPosition,
    TextAlign? textAlign,
    bool? readOnly,
    Widget Function(BuildContext, TrinaCell, int)? cellRenderer,
    Widget Function(BuildContext)? titleRenderer,
    String Function(dynamic)? formatter,
    List<String>? selectOptions,
    bool? enableColumnMenu,
    bool? enableContextMenu,
  }) {
    return GiTableColumn<T>(
      title: title ?? this.title,
      field: field ?? this.field,
      type: type ?? this.type,
      width: width ?? this.width,
      minWidth: minWidth ?? this.minWidth,
      sortable: sortable ?? this.sortable,
      filterable: filterable ?? this.filterable,
      frozen: frozen ?? this.frozen,
      frozenPosition: frozenPosition ?? this.frozenPosition,
      textAlign: textAlign ?? this.textAlign,
      readOnly: readOnly ?? this.readOnly,
      cellRenderer: cellRenderer ?? this.cellRenderer,
      titleRenderer: titleRenderer ?? this.titleRenderer,
      formatter: formatter ?? this.formatter,
      selectOptions: selectOptions ?? this.selectOptions,
      enableColumnMenu: enableColumnMenu ?? this.enableColumnMenu,
      enableContextMenu: enableContextMenu ?? this.enableContextMenu,
    );
  }
}

