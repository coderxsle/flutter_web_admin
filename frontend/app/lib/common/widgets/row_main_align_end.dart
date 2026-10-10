import 'package:flutter/material.dart';

//默认的从右往左边的row
class RowMainAlignEnd extends StatelessWidget {
  final List<Widget> children;
  const RowMainAlignEnd({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
