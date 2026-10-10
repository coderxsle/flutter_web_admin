import 'package:flutter/material.dart';

//流式布局中的标签，带点击事件
class ItemWrapWidgetWithClick extends StatelessWidget {
  final String text;
  final bool clickSate;
  final int index;
  final Color? borderColor;
  final EdgeInsetsGeometry? paddingMy;
  final TextStyle? textStyleMy;
  final GestureTapCallback? onTap;
  final double? borderRadiusMy;

  const ItemWrapWidgetWithClick({
    super.key,
    required this.text,
    required this.clickSate,
    required this.index,
    required this.onTap,
    this.paddingMy,
    this.textStyleMy,
    this.borderColor,
    this.borderRadiusMy,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: (index == 0) ? const EdgeInsets.fromLTRB(6, 1, 0, 2) : const EdgeInsets.fromLTRB(2, 1, 0, 2),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.transparent, // 去掉水波纹
        highlightColor: Colors.transparent, // 去掉高亮背景色
        child: Container(
          padding: paddingMy ?? const EdgeInsets.fromLTRB(6, 2, 6, 3),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: borderColor ?? const Color(0xFFE0E0E0), width: 0.5),
            borderRadius: BorderRadius.circular(borderRadiusMy ?? 10.0),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: textStyleMy ?? TextStyle(fontSize: 12, color: clickSate ? Colors.white : Colors.black),
          ),
        ),
      ),
    );
  }
}
