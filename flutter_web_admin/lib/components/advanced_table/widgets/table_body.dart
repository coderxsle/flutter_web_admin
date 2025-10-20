import 'package:flutter/material.dart';
import '../controller/advanced_table_controller.dart';
import '../config/table_column_config.dart';
import '../config/table_selection_config.dart';

/// 表格主体
class TableBody<T> extends StatelessWidget {
  /// 控制器
  final AdvancedTableController<T> controller;
  
  /// 列配置
  final List<TableColumnConfig<T>> columns;
  
  /// 选择配置
  final TableSelectionConfig<T>? selectionConfig;
  
  /// 是否显示边框
  final bool showBorder;
  
  /// 是否显示斑马纹
  final bool showStripe;
  
  /// 行点击回调
  final void Function(T record, int index)? onRowTap;
  
  /// 行双击回调
  final void Function(T record, int index)? onRowDoubleTap;
  
  /// 行高
  final double rowHeight;
  
  /// 空数据组件
  final Widget? emptyWidget;
  
  /// 展开行构建器
  final Widget Function(BuildContext context, T record, int index)? expandedBuilder;
  
  /// 水平滚动控制器
  final ScrollController? scrollController;
  
  /// 垂直滚动控制器
  final ScrollController? verticalScrollController;

  const TableBody({
    super.key,
    required this.controller,
    required this.columns,
    this.selectionConfig,
    this.showBorder = true,
    this.showStripe = false,
    this.onRowTap,
    this.onRowDoubleTap,
    this.rowHeight = 32,
    this.emptyWidget,
    this.expandedBuilder,
    this.scrollController,
    this.verticalScrollController,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        if (controller.displayData.isEmpty) {
          return emptyWidget ?? _buildEmptyWidget(context);
        }

        final totalWidth = _calculateTotalWidth();
        
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            width: totalWidth,
            child: ListView.builder(
              controller: verticalScrollController,
              itemCount: controller.displayData.length,
              itemBuilder: (context, index) {
                final record = controller.displayData[index];
                final rowKey = selectionConfig?.getRowKey?.call(record) ?? index.toString();
                final isSelected = controller.selectedRowKeys.contains(rowKey);
                final isExpanded = controller.isRowExpanded(rowKey);
                
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow(context, record, index, rowKey, isSelected),
                    if (isExpanded && expandedBuilder != null)
                      _buildExpandedRow(context, record, index),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  /// 计算表格总宽度
  double _calculateTotalWidth() {
    double totalWidth = 0;
    
    // 选择列宽度
    if (selectionConfig?.enabled == true) {
      totalWidth += selectionConfig?.selectionWidth ?? 50;
    }
    
    // 数据列宽度
    for (final column in columns.where((col) => col.show)) {
      final columnWidth = column.width ?? 150.0;
      final resizerWidth = column.resizable ? 8.0 : 0.0;
      totalWidth += columnWidth + resizerWidth;
    }
    
    // 调试信息
    debugPrint('📊 表格总宽度: $totalWidth px, 可见列数: ${columns.where((col) => col.show).length}');
    
    return totalWidth;
  }

  /// 构建行
  Widget _buildRow(
    BuildContext context,
    T record,
    int index,
    String rowKey,
    bool isSelected,
  ) {
    final backgroundColor = _getRowBackgroundColor(context, index, isSelected);
    
    return InkWell(
      onTap: () => onRowTap?.call(record, index),
      onDoubleTap: () => onRowDoubleTap?.call(record, index),
      child: Container(
        height: rowHeight,
        decoration: BoxDecoration(
          color: backgroundColor,
          border: showBorder
              ? Border(
                  bottom: BorderSide(
                    color: Theme.of(context).dividerColor,
                    width: 1,
                  ),
                )
              : null,
        ),
        child: Row(
          children: [
            // 选择列
            if (selectionConfig?.enabled == true)
              _buildSelectionCell(context, record, rowKey),
            
            // 数据列
            ...columns.where((col) => col.show).map((column) {
              return _buildDataCell(context, column, record, index);
            }),
          ],
        ),
      ),
    );
  }

  /// 构建选择单元格
  Widget _buildSelectionCell(BuildContext context, T record, String rowKey) {
    final isSelected = controller.selectedRowKeys.contains(rowKey);
    final isSelectable = selectionConfig?.rowSelectable?.call(record) ?? true;
    
    return Container(
      width: selectionConfig?.selectionWidth ?? 50,
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
      child: isSelectable
          ? selectionConfig?.isMultiple == true
              ? Checkbox(
                  value: isSelected,
                  onChanged: (value) {
                    controller.toggleRowSelection(rowKey);
                  },
                )
              : Radio<bool>(
                  value: true,
                  groupValue: isSelected,
                  onChanged: (value) {
                    controller.toggleRowSelection(rowKey);
                  },
                )
          : null,
    );
  }

  /// 构建数据单元格
  Widget _buildDataCell(
    BuildContext context,
    TableColumnConfig<T> column,
    T record,
    int index,
  ) {
    final columnWidth = column.width ?? 150.0;
    final resizerWidth = column.resizable ? 8.0 : 0.0;
    
    return SizedBox(
      width: columnWidth + resizerWidth,
      child: Row(
        children: [
          SizedBox(
            width: columnWidth,
            child: Container(
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
              alignment: column.alignment,
              child: column.cellBuilder?.call(context, record, index) ??
                     _buildDefaultCell(context, column, record),
            ),
          ),
          
          // 列宽调整器占位（保持与表头对齐）
          if (column.resizable)
            SizedBox(width: 8.0),
        ],
      ),
    );
  }

  /// 构建默认单元格
  Widget _buildDefaultCell(
    BuildContext context,
    TableColumnConfig<T> column,
    T record,
  ) {
    final displayValue = column.getDisplayValue(record);
    
    return Text(
      displayValue,
      style: column.cellStyle,
      textAlign: column.textAlign,
      overflow: column.ellipsis ? TextOverflow.ellipsis : null,
      maxLines: column.ellipsis ? 1 : null,
    );
  }

  /// 构建展开行
  Widget _buildExpandedRow(BuildContext context, T record, int index) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.1),
        border: showBorder
            ? Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor,
                  width: 1,
                ),
              )
            : null,
      ),
      padding: const EdgeInsets.all(16),
      child: expandedBuilder!.call(context, record, index),
    );
  }

  /// 获取行背景色
  Color? _getRowBackgroundColor(BuildContext context, int index, bool isSelected) {
    if (isSelected) {
      return Theme.of(context).primaryColor.withOpacity(0.1);
    }
    
    if (showStripe && index % 2 == 1) {
      return Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.05);
    }
    
    return null;
  }

  /// 构建空数据组件
  Widget _buildEmptyWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            '暂无数据',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}


