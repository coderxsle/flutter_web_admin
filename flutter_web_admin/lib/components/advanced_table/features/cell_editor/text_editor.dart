import 'package:flutter/material.dart';

/// 文本编辑器
class TextCellEditor extends StatefulWidget {
  /// 初始值
  final String? initialValue;
  
  /// 保存回调
  final void Function(String value) onSave;
  
  /// 取消回调
  final VoidCallback? onCancel;
  
  /// 是否自动聚焦
  final bool autofocus;

  const TextCellEditor({
    super.key,
    this.initialValue,
    required this.onSave,
    this.onCancel,
    this.autofocus = true,
  });

  @override
  State<TextCellEditor> createState() => _TextCellEditorState();
}

class _TextCellEditorState extends State<TextCellEditor> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
    
    if (widget.autofocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
        _controller.selection = TextSelection(
          baseOffset: 0,
          extentOffset: _controller.text.length,
        );
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        isDense: true,
      ),
      onSubmitted: (value) {
        widget.onSave(value);
      },
      onTapOutside: (_) {
        widget.onSave(_controller.text);
      },
    );
  }
}

