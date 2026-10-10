import 'package:flutter/material.dart';

///@description 线条改造 dividerLineLight
///@updateTime 2025/1/13 19:58
class DividerLineLight extends StatelessWidget {
  final double? left;
  final double? right;
  final double? height;
  final double? thickness;
  final Color? color;
  const DividerLineLight({
    super.key,
    this.left = 0,
    this.right = 0,
    this.height = 0,
    this.thickness = 0.4,
    this.color = Colors.black12,
  });

  @override
  Widget build(BuildContext context) {
    return Divider(
      indent: left,
      endIndent: right,
      thickness: thickness,
      height: height,
      color: color,
    );
  }
}
