import 'package:flutter/material.dart';

///@description 携带有描边的浅色容器
///@updateTime 2024/11/24 17:22
class ContainerWithBorder extends StatelessWidget {
  final bool isHasBorder;
  final double? height;
  final Color? highlightColor;
  final Color? splashColor;
  //装饰器的背景色
  final Color? boxColor;
  //边框选中的时候的颜色
  final Color? borderColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Widget child;
  //外侧边框的宽度是0.5默认，但是特殊情况下例如：卖车客户列表，是1.5显得更好看一些。
  final double? borderWidth;
  const ContainerWithBorder({
    super.key,
    this.borderRadius,
    required this.child,
    this.height,
    this.margin,
    this.padding,
    this.highlightColor,
    this.splashColor,
    required this.isHasBorder,
    this.boxColor,
    this.borderColor,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: height,
      padding: padding ?? const EdgeInsets.fromLTRB(0, 6, 0, 6), //EdgeInsets.zero
      margin: margin ?? const EdgeInsets.fromLTRB(0, 0, 0, 6), //EdgeInsets.zero
      decoration: BoxDecoration(
        color: boxColor ?? Colors.grey[50],
        borderRadius: borderRadius ?? BorderRadius.circular(4), //默认是4圆角。
        border: isHasBorder ? Border.all(color: borderColor??Colors.grey[300]!, width: borderWidth??0.5) : null,
      ),
      //第二种方式
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius_circular8)),
      //   shape: BoxShape.rectangle,
      // ),
      child: child,
    );
  }
}
