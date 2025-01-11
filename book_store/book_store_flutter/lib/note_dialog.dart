import 'package:flutter/material.dart';

void showBookDialog({
  required BuildContext context,
  String text = '',
  required ValueChanged<String> onSaved,
}) {
  showDialog(
    context: context,
    builder: (context) => BookDialog(
      text: text,
      onSaved: onSaved,
    ),
  );
}

class BookDialog extends StatefulWidget {
  const BookDialog({
    required this.text,
    required this.onSaved,
    super.key,
  });

  final String text;
  final ValueChanged<String> onSaved;

  @override
  BookDialogState createState() => BookDialogState();
}

class BookDialogState extends State<BookDialog> {
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.text = widget.text;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: controller,
                expands: true,
                maxLines: null,
                minLines: null,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Write your Book here...',
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.onSaved(controller.text);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}