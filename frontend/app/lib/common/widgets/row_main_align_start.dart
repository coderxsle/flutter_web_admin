import 'package:flutter/material.dart';

//默认的从左往右的
class RowMainAlignStart extends StatelessWidget {
  final List<Widget> children;
  const RowMainAlignStart({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
