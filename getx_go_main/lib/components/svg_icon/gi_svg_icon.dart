import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// GiSvgIcon SVG图标组件
/// 
/// 用于显示自定义SVG图标
class GiSvgIcon extends StatelessWidget {
  /// 图标名称
  final String name;
  
  /// 图标大小
  final double? size;
  
  /// 图标颜色
  final Color? color;

  const GiSvgIcon({
    super.key,
    required this.name,
    this.size,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final double iconSize = size ?? 24.0;
    // 如果名称为空，返回占位符
    if (name.isEmpty) {
      return Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Icon(
          Icons.help_outline,
          size: iconSize * 0.6,
          color: Colors.grey.shade400,
        ),
      );
    }
    
    return SvgPicture.asset(
      'images/$name.svg',
      width: iconSize,
      height: iconSize,
      colorFilter: color != null 
        ? ColorFilter.mode(color!, BlendMode.srcIn)
        : null,
      semanticsLabel: name,
      placeholderBuilder: (context) => Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Icon(
          Icons.image_not_supported,
          size: iconSize * 0.6,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}
