import 'package:flutter/material.dart';

/// 选择编辑器选项
class SelectOption {
  final String label;
  final dynamic value;

  const SelectOption({
    required this.label,
    required this.value,
  });
}

/// 选择编辑器
class SelectCellEditor extends StatefulWidget {
  /// 初始值
  final dynamic initialValue;
  
  /// 选项列表
  final List<SelectOption> options;
  
  /// 保存回调
  final void Function(dynamic value) onSave;
  
  /// 取消回调
  final VoidCallback? onCancel;

  const SelectCellEditor({
    super.key,
    this.initialValue,
    required this.options,
    required this.onSave,
    this.onCancel,
  });

  @override
  State<SelectCellEditor> createState() => _SelectCellEditorState();
}

class _SelectCellEditorState extends State<SelectCellEditor> {
  dynamic _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<dynamic>(
      value: _selectedValue,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        isDense: true,
      ),
      items: widget.options.map((option) {
        return DropdownMenuItem<dynamic>(
          value: option.value,
          child: Text(option.label),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedValue = value;
        });
        widget.onSave(value);
      },
    );
  }
}

