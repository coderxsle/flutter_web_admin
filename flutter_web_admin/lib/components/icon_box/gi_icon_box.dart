import 'package:flutter/material.dart';

/// GiIconBox 图标盒子组件
/// 
/// 用于展示图标的容器组件，支持不同颜色、尺寸和形状
class GiIconBox extends StatelessWidget {
  /// 图标
  final Widget icon;
  
  /// 颜色，可以是颜色字符串或预定义的颜色名称
  final String? color;
  
  /// 尺寸
  final double? size;
  
  /// 形状，支持 'square' 和 'round'
  final String? shape;
  
  /// 点击回调
  final VoidCallback? onTap;

  const GiIconBox({
    super.key,
    required this.icon,
    this.color,
    this.size,
    this.shape,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double iconSize = size ?? 24.0;
    final double boxSize = iconSize + 16.0; // 图标周围留出16像素的边距
    final BorderRadius borderRadius = _getBorderRadius();
    final Color backgroundColor = _getBackgroundColor(context);

    Widget iconBox = Container(
      width: boxSize,
      height: boxSize,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: borderRadius,
      ),
      child: Center(
        child: IconTheme(
          data: IconThemeData(
            color: Colors.white,
            size: iconSize,
          ),
          child: icon,
        ),
      ),
    );

    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: iconBox,
      );
    }

    return iconBox;
  }

  /// 获取边框圆角
  BorderRadius _getBorderRadius() {
    if (shape == 'round') {
      return BorderRadius.circular(1000); // 圆形
    }
    return BorderRadius.circular(6); // 默认圆角
  }

  /// 获取背景颜色
  Color _getBackgroundColor(BuildContext context) {
    if (color == null) {
      return Theme.of(context).primaryColor;
    }

    // 处理预定义的颜色名称
    switch (color!.toLowerCase()) {
      case 'danger':
        return Colors.red;
      case 'warning':
        return Colors.orange;
      case 'success':
        return Colors.green;
      case 'info':
        return Colors.blue;
      case 'primary':
        return Theme.of(context).primaryColor;
      default:
        // 处理十六进制颜色
        if (color!.startsWith('#')) {
          try {
            return Color(int.parse(color!.substring(1), radix: 16) + 0xFF000000);
          } catch (e) {
            return Theme.of(context).primaryColor;
          }
        }
        return Theme.of(context).primaryColor;
    }
  }
}
