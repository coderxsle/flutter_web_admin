import 'package:flutter/material.dart';
import 'gi_table_column.dart';

/// 列设置项
class _ColumnSettingItem<T> {
  final GiTableColumn<T> column;
  bool visible;
  final bool disabled;
  
  _ColumnSettingItem({
    required this.column,
    required this.visible,
    required this.disabled,
  });
}

/// GiTable 列设置弹窗
/// 
/// 功能:
/// - 显示/隐藏列
/// - 拖拽排序列
/// - 禁用某些列的控制
/// - 重置列配置
class GiTableColumnSetting<T> extends StatefulWidget {
  /// 所有列
  final List<GiTableColumn<T>> columns;
  
  /// 当前可见列
  final List<GiTableColumn<T>> visibleColumns;
  
  /// 禁止控制的列 keys
  final List<String> disabledColumnKeys;
  
  /// 列配置变化回调
  final void Function(List<GiTableColumn<T>> columns) onColumnsChanged;

  const GiTableColumnSetting({
    super.key,
    required this.columns,
    required this.visibleColumns,
    required this.disabledColumnKeys,
    required this.onColumnsChanged,
  });

  @override
  State<GiTableColumnSetting<T>> createState() => _GiTableColumnSettingState<T>();
}

class _GiTableColumnSettingState<T> extends State<GiTableColumnSetting<T>> {
  late List<_ColumnSettingItem<T>> _items;
  
  @override
  void initState() {
    super.initState();
    _initializeItems();
  }
  
  /// 初始化列项
  void _initializeItems() {
    // 先添加可见列(保持顺序)
    final visibleFields = widget.visibleColumns.map((c) => c.field).toSet();
    _items = widget.visibleColumns.map((col) {
      return _ColumnSettingItem<T>(
        column: col,
        visible: true,
        disabled: widget.disabledColumnKeys.contains(col.field),
      );
    }).toList();
    
    // 再添加不可见的列
    for (final col in widget.columns) {
      if (!visibleFields.contains(col.field)) {
        _items.add(_ColumnSettingItem<T>(
          column: col,
          visible: false,
          disabled: widget.disabledColumnKeys.contains(col.field),
        ));
      }
    }
  }
  
  /// 重置列配置
  void _resetColumns() {
    setState(() {
      _items.clear();
      for (final col in widget.columns) {
        _items.add(_ColumnSettingItem<T>(
          column: col,
          visible: true,
          disabled: widget.disabledColumnKeys.contains(col.field),
        ));
      }
    });
  }
  
  /// 应用列配置
  void _applyColumns() {
    final visibleColumns = _items
        .where((item) => item.visible)
        .map((item) => item.column)
        .toList();
    
    widget.onColumnsChanged(visibleColumns);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: 400,
        constraints: const BoxConstraints(maxHeight: 600),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 标题栏
            _buildHeader(context),
            
            const Divider(height: 1),
            
            // 列列表
            Flexible(
              child: _buildColumnList(),
            ),
            
            const Divider(height: 1),
            
            // 底部按钮
            _buildFooter(context),
          ],
        ),
      ),
    );
  }
  
  /// 构建标题栏
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          const Text(
            '列设置',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(Icons.close, size: 20),
            onPressed: () => Navigator.of(context).pop(),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }
  
  /// 构建列列表
  Widget _buildColumnList() {
    return ReorderableListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _items.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (oldIndex < newIndex) {
            newIndex -= 1;
          }
          final item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
        });
      },
      itemBuilder: (context, index) {
        final item = _items[index];
        return _buildColumnItem(context, item, index);
      },
    );
  }
  
  /// 构建列项
  Widget _buildColumnItem(
    BuildContext context,
    _ColumnSettingItem<T> item,
    int index,
  ) {
    return Container(
      key: ValueKey(item.column.field),
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: item.visible 
            ? null 
            : Theme.of(context).disabledColor.withOpacity(0.05),
      ),
      child: InkWell(
        onTap: item.disabled 
            ? null 
            : () {
                setState(() {
                  item.visible = !item.visible;
                });
              },
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
          child: Row(
            children: [
              // 拖拽手柄
              ReorderableDragStartListener(
                index: index,
                child: const Icon(
                  Icons.drag_indicator,
                  size: 18,
                  color: Colors.grey,
                ),
              ),
              
              const SizedBox(width: 8),
              
              // 复选框
              Checkbox(
                value: item.visible,
                onChanged: item.disabled 
                    ? null 
                    : (value) {
                        setState(() {
                          item.visible = value ?? false;
                        });
                      },
                visualDensity: VisualDensity.compact,
              ),
              
              const SizedBox(width: 8),
              
              // 列标题
              Expanded(
                child: Text(
                  item.column.title,
                  style: TextStyle(
                    fontSize: 14,
                    color: item.disabled 
                        ? Theme.of(context).disabledColor 
                        : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  /// 构建底部按钮
  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 重置按钮
          TextButton.icon(
            onPressed: _resetColumns,
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('重置'),
            style: TextButton.styleFrom(
              foregroundColor: Theme.of(context).textTheme.bodyMedium?.color,
            ),
          ),
          
          // 右侧按钮组
          Row(
            children: [
              // 取消按钮
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('取消'),
              ),
              
              const SizedBox(width: 8),
              
              // 确定按钮
              ElevatedButton(
                onPressed: _applyColumns,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('确定'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

