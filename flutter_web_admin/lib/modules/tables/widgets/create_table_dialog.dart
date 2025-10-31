import 'package:flutter/material.dart';

/// 创建表格对话框
class CreateTableDialog extends StatefulWidget {
  final Function(String name) onConfirm;
  final String? initialName;
  final String title;

  const CreateTableDialog({
    super.key,
    required this.onConfirm,
    this.initialName,
    this.title = '创建表格',
  });

  @override
  State<CreateTableDialog> createState() => _CreateTableDialogState();
}

class _CreateTableDialogState extends State<CreateTableDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.table_chart),
          const SizedBox(width: 12),
          Text(widget.title),
        ],
      ),
      content: SizedBox(
        width: 400,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '表格名称',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: '请输入表格名称',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
              ),
              onSubmitted: (_) => _onConfirm(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('取消'),
        ),
        ElevatedButton(
          onPressed: _onConfirm,
          child: const Text('确定'),
        ),
      ],
    );
  }

  void _onConfirm() {
    final name = _controller.text.trim();
    if (name.isNotEmpty) {
      widget.onConfirm(name);
      Navigator.pop(context);
    }
  }
}


