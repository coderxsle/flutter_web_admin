import 'package:auto_shop_server/app/utils/constant_api.dart';
import 'package:flutter/material.dart';

//携带半径和点击的容器
class ContainerWithRadius extends StatelessWidget {
  final double? height;
  final Color? highlightColor;
  final Color? splashColor;
  //布局的背景颜色
  final Color? bgColor;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final Widget? child;
  final VoidCallback? onTap;
  const ContainerWithRadius({
    super.key,
    this.borderRadius,
    this.child,
    this.onTap,
    this.height,
    this.margin,
    this.padding,
    this.highlightColor,
    this.splashColor,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      // highlightColor: highlightColor,
      // splashColor: Colors.transparent,
      highlightColor: highlightColor ?? Colors.transparent,
      splashColor: splashColor ?? Colors.transparent,
      onTap: onTap,
      child: Container(
        height: height,
        padding: padding ?? const EdgeInsets.fromLTRB(10, 5, 10, 5), //EdgeInsets.zero
        margin: margin ?? const EdgeInsets.fromLTRB(6, 0, 6, 6), //EdgeInsets.zero
        decoration: BoxDecoration(
          color: bgColor ?? Colors.white,
          borderRadius: borderRadius ?? BorderRadius.all(Radius.circular(radius_circular8)),
          shape: BoxShape.rectangle,
        ),
        child: child,
      ),
    );
  }
}
