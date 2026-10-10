import 'package:flutter/material.dart';
///@description 文本录入监听，将来改造，暂时放着
///@updateTime 2024/10/11 14:09
class MyTextField extends StatefulWidget {
  const MyTextField({super.key});

  @override
  MyTextFieldState createState() => MyTextFieldState();
}

class MyTextFieldState extends State<MyTextField> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus && _controller.text.isNotEmpty) {
      print('Text field lost focus: ${_controller.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      focusNode: _focusNode,
      onSubmitted: (String value) {
        print('Text submitted: $value');
      },
      decoration: InputDecoration(
        labelText: 'Enter some text',
      ),
    );
  }
}
