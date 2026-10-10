import 'package:flutter/material.dart';

//默认的从上到下的
class ColumnMainAlignStart extends StatelessWidget {
  final List<Widget> children;
  const ColumnMainAlignStart({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }
}
