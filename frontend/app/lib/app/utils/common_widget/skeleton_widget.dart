import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Widget? child;
  const SkeletonWidget({super.key, this.child, this.width, this.height, this.margin, this.padding, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final highestColor = themeData.colorScheme.surfaceContainerHighest;
    final foregroundColor = themeData.colorScheme.surface;
    return Container(
      padding: padding,
      color: backgroundColor ?? Colors.white,
      child: Shimmer.fromColors(
        baseColor: highestColor,
        highlightColor: foregroundColor,
        child: Container(width: width, height: height, padding: margin, color: highestColor, child: child),
      ),
    );
  }
}
