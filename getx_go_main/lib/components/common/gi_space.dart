import 'package:flutter/material.dart';

/// Gi 间距组件
/// 
/// 用于在组件之间添加统一的间距，支持水平和垂直方向
/// 支持 Flex 布局和 Wrap 布局两种模式
/// 
/// 使用示例：
/// ```dart
/// // 水平间距
/// GiSpace(
///   children: [
///     Text('项目1'),
///     Text('项目2'),
///     Text('项目3'),
///   ],
/// )
/// 
/// // 垂直间距
/// GiSpace(
///   direction: Axis.vertical,
///   spacing: 16.0,
///   children: [
///     Card(child: Text('卡片1')),
///     Card(child: Text('卡片2')),
///   ],
/// )
/// 
/// // 自动换行模式
/// GiSpace(
///   wrap: true,
///   spacing: 8.0,
///   runSpacing: 8.0,
///   children: tags.map((tag) => Chip(label: Text(tag))).toList(),
/// )
/// ```
class GiSpace extends StatelessWidget {
  /// 子组件列表
  final List<Widget> children;
  
  /// 主轴间距
  final double spacing;
  
  /// 交叉轴间距（仅在 wrap 模式下有效）
  final double runSpacing;
  
  /// 布局方向
  final Axis direction;
  
  /// 主轴对齐方式
  final MainAxisAlignment mainAxisAlignment;
  
  /// 交叉轴对齐方式
  final CrossAxisAlignment crossAxisAlignment;
  
  /// 是否启用自动换行模式
  final bool wrap;

  const GiSpace({
    super.key,
    required this.children,
    this.spacing = 8.0,
    this.runSpacing = 8.0,
    this.direction = Axis.horizontal,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.wrap = false,
  });

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) return const SizedBox.shrink();

    if (wrap) {
      return Wrap(
        direction: direction,
        spacing: spacing,
        runSpacing: runSpacing,
        children: children,
      );
    }

    return Flex(
      direction: direction,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: _buildSpacedChildren(),
    );
  }

  /// 构建带间距的子组件列表
  List<Widget> _buildSpacedChildren() {
    final spacedChildren = <Widget>[];
    
    for (int i = 0; i < children.length; i++) {
      spacedChildren.add(children[i]);
      
      if (i < children.length - 1) {
        spacedChildren.add(
          direction == Axis.horizontal
              ? SizedBox(width: spacing)
              : SizedBox(height: spacing),
        );
      }
    }
    
    return spacedChildren;
  }
}
