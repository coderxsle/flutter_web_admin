import 'package:flutter/material.dart';

/// 日期编辑器
class DateCellEditor extends StatefulWidget {
  /// 初始值
  final DateTime? initialValue;
  
  /// 保存回调
  final void Function(DateTime value) onSave;
  
  /// 取消回调
  final VoidCallback? onCancel;
  
  /// 日期格式
  final String format;

  const DateCellEditor({
    super.key,
    this.initialValue,
    required this.onSave,
    this.onCancel,
    this.format = 'yyyy-MM-dd',
  });

  @override
  State<DateCellEditor> createState() => _DateCellEditorState();
}

class _DateCellEditorState extends State<DateCellEditor> {
  late DateTime _selectedDate;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialValue ?? DateTime.now();
    _controller = TextEditingController(
      text: _formatDate(_selectedDate),
    );
    
    // 自动打开日期选择器
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDatePicker();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    return '$year-$month-$day';
  }

  Future<void> _showDatePicker() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _controller.text = _formatDate(picked);
      });
      widget.onSave(picked);
    } else {
      widget.onCancel?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        isDense: true,
        suffixIcon: IconButton(
          icon: const Icon(Icons.calendar_today, size: 16),
          onPressed: _showDatePicker,
        ),
      ),
      onTap: _showDatePicker,
    );
  }
}

