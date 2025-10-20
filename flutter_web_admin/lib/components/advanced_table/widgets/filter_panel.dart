import 'package:flutter/material.dart';
import '../config/table_column_config.dart';
import '../models/filter_model.dart';

/// 筛选面板
class FilterPanel<T> extends StatefulWidget {
  /// 列配置
  final TableColumnConfig<T> column;
  
  /// 当前筛选条件
  final FilterCondition? currentCondition;
  
  /// 筛选变化回调
  final void Function(FilterCondition? condition) onFilterChange;

  const FilterPanel({
    super.key,
    required this.column,
    this.currentCondition,
    required this.onFilterChange,
  });

  @override
  State<FilterPanel<T>> createState() => _FilterPanelState<T>();
}

class _FilterPanelState<T> extends State<FilterPanel<T>> {
  late FilterOperator _operator;
  late TextEditingController _valueController;
  late TextEditingController _value2Controller;
  List<FilterOption> _selectedOptions = [];

  @override
  void initState() {
    super.initState();
    _operator = widget.currentCondition?.operator ?? FilterOperator.contains;
    _valueController = TextEditingController(
      text: widget.currentCondition?.value?.toString() ?? '',
    );
    _value2Controller = TextEditingController(
      text: widget.currentCondition?.value2?.toString() ?? '',
    );
    
    if (widget.column.filterOptions != null) {
      _selectedOptions = widget.column.filterOptions!
          .where((opt) => opt.selected)
          .toList();
    }
  }

  @override
  void dispose() {
    _valueController.dispose();
    _value2Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '筛选 ${widget.column.title}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // 筛选器内容
          if (widget.column.filterType == FilterType.select ||
              widget.column.filterType == FilterType.multiSelect)
            _buildSelectFilter()
          else
            _buildTextFilter(),
          
          const SizedBox(height: 16),
          
          // 操作按钮
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  widget.onFilterChange(null);
                  Navigator.pop(context);
                },
                child: const Text('清空'),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _applyFilter,
                child: const Text('确定'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 构建文本筛选器
  Widget _buildTextFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 操作符选择
        DropdownButtonFormField<FilterOperator>(
          value: _operator,
          decoration: const InputDecoration(
            labelText: '条件',
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
          items: _getOperators().map((op) {
            return DropdownMenuItem(
              value: op,
              child: Text(_getOperatorLabel(op)),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _operator = value!;
            });
          },
        ),
        const SizedBox(height: 12),
        
        // 值输入
        if (_operator != FilterOperator.isEmpty && 
            _operator != FilterOperator.isNotEmpty)
          TextField(
            controller: _valueController,
            decoration: const InputDecoration(
              labelText: '值',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        
        // 第二个值输入（用于 between）
        if (_operator == FilterOperator.between) ...[
          const SizedBox(height: 12),
          TextField(
            controller: _value2Controller,
            decoration: const InputDecoration(
              labelText: '结束值',
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
        ],
      ],
    );
  }

  /// 构建选择筛选器
  Widget _buildSelectFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widget.column.filterOptions!.map((option) {
        final isSelected = _selectedOptions.contains(option);
        return CheckboxListTile(
          dense: true,
          contentPadding: EdgeInsets.zero,
          title: Text(option.label),
          value: isSelected,
          onChanged: (value) {
            setState(() {
              if (value == true) {
                if (widget.column.filterType == FilterType.select) {
                  _selectedOptions = [option];
                } else {
                  _selectedOptions.add(option);
                }
              } else {
                _selectedOptions.remove(option);
              }
            });
          },
        );
      }).toList(),
    );
  }

  /// 获取可用的操作符
  List<FilterOperator> _getOperators() {
    switch (widget.column.filterType) {
      case FilterType.text:
        return [
          FilterOperator.contains,
          FilterOperator.notContains,
          FilterOperator.equals,
          FilterOperator.notEquals,
          FilterOperator.startsWith,
          FilterOperator.endsWith,
          FilterOperator.isEmpty,
          FilterOperator.isNotEmpty,
        ];
      case FilterType.number:
        return [
          FilterOperator.equals,
          FilterOperator.notEquals,
          FilterOperator.greaterThan,
          FilterOperator.greaterThanOrEqual,
          FilterOperator.lessThan,
          FilterOperator.lessThanOrEqual,
          FilterOperator.between,
        ];
      case FilterType.date:
        return [
          FilterOperator.equals,
          FilterOperator.greaterThan,
          FilterOperator.lessThan,
          FilterOperator.between,
        ];
      default:
        return [FilterOperator.equals, FilterOperator.notEquals];
    }
  }

  /// 获取操作符标签
  String _getOperatorLabel(FilterOperator operator) {
    switch (operator) {
      case FilterOperator.equals:
        return '等于';
      case FilterOperator.notEquals:
        return '不等于';
      case FilterOperator.contains:
        return '包含';
      case FilterOperator.notContains:
        return '不包含';
      case FilterOperator.startsWith:
        return '开始于';
      case FilterOperator.endsWith:
        return '结束于';
      case FilterOperator.greaterThan:
        return '大于';
      case FilterOperator.greaterThanOrEqual:
        return '大于等于';
      case FilterOperator.lessThan:
        return '小于';
      case FilterOperator.lessThanOrEqual:
        return '小于等于';
      case FilterOperator.between:
        return '介于';
      case FilterOperator.isEmpty:
        return '为空';
      case FilterOperator.isNotEmpty:
        return '不为空';
    }
  }

  /// 应用筛选
  void _applyFilter() {
    if (widget.column.filterType == FilterType.select ||
        widget.column.filterType == FilterType.multiSelect) {
      if (_selectedOptions.isEmpty) {
        widget.onFilterChange(null);
      } else {
        final values = _selectedOptions.map((opt) => opt.value).toList();
        widget.onFilterChange(FilterCondition(
          columnKey: widget.column.columnKey,
          type: widget.column.filterType!,
          operator: FilterOperator.equals,
          value: widget.column.filterType == FilterType.select 
              ? values.first 
              : values,
        ));
      }
    } else {
      final value = _valueController.text;
      if (value.isEmpty && 
          _operator != FilterOperator.isEmpty && 
          _operator != FilterOperator.isNotEmpty) {
        widget.onFilterChange(null);
      } else {
        widget.onFilterChange(FilterCondition(
          columnKey: widget.column.columnKey,
          type: widget.column.filterType ?? FilterType.text,
          operator: _operator,
          value: value,
          value2: _operator == FilterOperator.between 
              ? _value2Controller.text 
              : null,
        ));
      }
    }
    
    Navigator.pop(context);
  }
}

