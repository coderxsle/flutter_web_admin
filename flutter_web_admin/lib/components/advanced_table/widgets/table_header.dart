import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import '../controller/advanced_table_controller.dart';
import '../config/table_column_config.dart';
import '../config/table_selection_config.dart';
import '../models/sort_model.dart';
import 'filter_panel.dart';
import 'column_resizer.dart';
import 'column_dragger.dart';

/// 表格表头
class TableHeader<T> extends StatelessWidget {
  /// 控制器
  final AdvancedTableController<T> controller;
  
  /// 列配置
  final List<TableColumnConfig<T>> columns;
  
  /// 选择配置
  final TableSelectionConfig<T>? selectionConfig;
  
  /// 是否显示边框
  final bool showBorder;
  
  /// 水平滚动控制器
  final ScrollController? scrollController;

  const TableHeader({
    super.key,
    required this.controller,
    required this.columns,
    this.selectionConfig,
    this.showBorder = true,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
          border: showBorder
              ? Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                )
              : null,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          child: Row(
            children: [
              // 选择列
              if (selectionConfig?.enabled == true)
                _buildSelectionColumn(context),
              
              // 数据列
              ...columns.where((col) => col.show).map((column) {
                return _buildHeaderCell(context, column);
              }),
            ],
          ),
        ),
      ),
    );
  }

  /// 构建选择列
  Widget _buildSelectionColumn(BuildContext context) {
    return Container(
      width: selectionConfig?.selectionWidth ?? 50,
      height: 48,
      alignment: Alignment.center,
      decoration: showBorder
          ? BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              ),
            )
          : null,
      child: selectionConfig?.isMultiple == true && selectionConfig?.showSelectAll == true
          ? Checkbox(
              value: controller.isAllSelected,
              tristate: true,
              onChanged: (value) {
                if (value == true) {
                  controller.selectAll();
                } else {
                  controller.clearSelection();
                }
              },
            )
          : null,
    );
  }

  /// 构建表头单元格
  Widget _buildHeaderCell(BuildContext context, TableColumnConfig<T> column) {
    final columnIndex = columns.indexOf(column);
    final columnWidth = column.width ?? 150.0;
    final resizerWidth = column.resizable ? 8.0 : 0.0;
    
    return ColumnDragger(
      columnIndex: columnIndex,
      columnTitle: column.title,
      draggable: column.draggable,
      onDragComplete: (oldIndex, newIndex) {
        controller.reorderColumns(oldIndex, newIndex);
      },
      child: SizedBox(
        width: columnWidth + resizerWidth,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: showBorder
                    ? BoxDecoration(
                        border: Border(
                          right: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: 1,
                          ),
                        ),
                      )
                    : null,
                child: Row(
                  mainAxisAlignment: _getMainAxisAlignment(column.align),
                  children: [
                    // 自定义表头或默认表头
                    Expanded(
                      child: column.headerBuilder?.call(context) ?? 
                             _buildDefaultHeader(context, column),
                    ),
                    
                    // 排序图标
                    if (column.sortable)
                      _buildSortIcon(context, column),
                    
                    // 筛选图标
                    if (column.filterable)
                      _buildFilterIcon(context, column),
                  ],
                ),
              ),
            ),
            
            // 列宽调整器
            if (column.resizable)
              ColumnResizer(
                columnKey: column.columnKey,
                currentWidth: columnWidth,
                minWidth: column.minWidth,
                maxWidth: column.maxWidth,
                onWidthChange: (key, width) {
                  controller.updateColumnWidth(key, width);
                },
              ),
          ],
        ),
      ),
    );
  }

  /// 构建默认表头
  Widget _buildDefaultHeader(BuildContext context, TableColumnConfig<T> column) {
    return InkWell(
      onTap: column.sortable ? () => controller.toggleSort(column.columnKey) : null,
      child: Text(
        column.title,
        style: column.headerStyle ?? const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
        textAlign: column.textAlign,
        overflow: column.ellipsis ? TextOverflow.ellipsis : null,
      ),
    );
  }

  /// 构建排序图标
  Widget _buildSortIcon(BuildContext context, TableColumnConfig<T> column) {
    final sortModel = controller.sortModel;
    final isActive = sortModel?.columnKey == column.columnKey;
    final direction = isActive ? sortModel!.direction : SortDirection.none;
    
    return InkWell(
      onTap: () => controller.toggleSort(column.columnKey),
      child: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Icon(
          direction == SortDirection.ascending
              ? Icons.arrow_upward
              : direction == SortDirection.descending
                  ? Icons.arrow_downward
                  : Icons.unfold_more,
          size: 16,
          color: isActive ? Theme.of(context).primaryColor : Colors.grey,
        ),
      ),
    );
  }

  /// 构建筛选图标
  Widget _buildFilterIcon(BuildContext context, TableColumnConfig<T> column) {
    final hasFilter = controller.filterModel?.conditions.any(
      (c) => c.columnKey == column.columnKey,
    ) ?? false;
    
    return InkWell(
      onTap: () {
        // 打开筛选面板
        _showFilterPanel(context, column);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 4),
        child: Icon(
          hasFilter ? Icons.filter_alt : Icons.filter_alt_outlined,
          size: 16,
          color: hasFilter ? Theme.of(context).primaryColor : Colors.grey,
        ),
      ),
    );
  }

  /// 显示筛选面板
  void _showFilterPanel(BuildContext context, TableColumnConfig<T> column) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: FilterPanel<T>(
          column: column,
          currentCondition: controller.filterModel?.conditions
              .firstWhereOrNull((c) => c.columnKey == column.columnKey),
          onFilterChange: (condition) {
            if (condition == null) {
              controller.removeFilterCondition(column.columnKey);
            } else {
              controller.updateFilterCondition(condition);
            }
          },
        ),
      ),
    );
  }

  /// 获取主轴对齐方式
  MainAxisAlignment _getMainAxisAlignment(TableColumnAlign align) {
    switch (align) {
      case TableColumnAlign.left:
        return MainAxisAlignment.start;
      case TableColumnAlign.center:
        return MainAxisAlignment.center;
      case TableColumnAlign.right:
        return MainAxisAlignment.end;
    }
  }
}


