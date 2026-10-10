import 'package:flutter/cupertino.dart';

///@description 垂直布局的缩小布局的写法
///@updateTime 2024/12/21 16:59
class ColumnWithSizeMin extends StatelessWidget {
  final List<Widget> children;
  const ColumnWithSizeMin({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: children,
    );
  }
}
