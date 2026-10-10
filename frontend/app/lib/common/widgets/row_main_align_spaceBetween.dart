import 'package:flutter/material.dart';

//默认两边散开的
class RowMainAlignSpaceBetween extends StatelessWidget {
  final List<Widget> children;
  const RowMainAlignSpaceBetween({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
