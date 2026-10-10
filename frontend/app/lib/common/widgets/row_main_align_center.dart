import 'package:flutter/material.dart';

//默认的中心摆放
class RowMainAlignCenter extends StatelessWidget {
  final List<Widget> children;
  const RowMainAlignCenter({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }
}
