import 'dart:async';

import 'package:flutter/material.dart';

class MyMaterialButton extends StatefulWidget {
  final void Function() onPressed;
  final Color? color;
  final Color? splashColor;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? highlightColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onLongPress;
  final double? width;
  final double? height;
  final int? delayed;
  final Widget? child;

  const MyMaterialButton({
    super.key,
    required this.onPressed,
    this.color,
    this.splashColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.borderRadius,
    this.padding,
    this.onLongPress,
    this.width,
    this.height,
    this.delayed,
    this.child,
  });

  @override
  State<MyMaterialButton> createState() => _MyMaterialButtonState();
}

class _MyMaterialButtonState extends State<MyMaterialButton> {
  DateTime? _lastCall;

  void _handlePressed() {
    final now = DateTime.now();
    final duration = Duration(milliseconds: widget.delayed ?? 160);
    if (_lastCall == null || now.difference(_lastCall!) > duration) {
      _lastCall = now;
      Future.delayed(duration).then((value) => widget.onPressed());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: widget.width ?? double.infinity, // 控制宽度
      decoration: BoxDecoration(
        color: widget.color ?? Colors.transparent,
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
      ),
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: Material(
          color: Colors.transparent, // 避免遮盖背景颜色
          child: InkWell(
            splashColor: widget.splashColor,
            focusColor: widget.focusColor,
            hoverColor: widget.hoverColor,
            highlightColor: widget.highlightColor,
            onTap: _handlePressed,
            child: Padding(
              padding: widget.padding ?? EdgeInsets.zero,
              child: widget.child, // 自动适应 child 的高度
            ),
          ),
        ),
      ),
    );
  }
}