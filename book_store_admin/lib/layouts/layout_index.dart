///
/// @file Layout 组件
/// @description 布局根组件，支持默认布局、混合布局和顶部布局三种模式
///
import 'package:flutter/material.dart';
import '../global/global.dart';
import 'layout_default.dart';
import 'layout_mix.dart';
import 'layout_top.dart';

/// 布局类型枚举
enum LayoutType {
  /// 默认布局 - 左侧菜单 + 右侧内容
  defaultLayout('default'),
  /// 混合布局 - 左侧菜单 + 顶部导航 + 右侧内容
  mix('mix'),
  /// 顶部布局 - 纯顶部导航
  top('top');

  const LayoutType(this.value);
  final String value;
}

/// 布局根组件
/// 
/// 根据应用状态动态切换布局模式，支持：
/// - 默认布局：传统的左侧菜单布局
/// - 混合布局：顶部导航 + 左侧菜单组合
/// - 顶部布局：纯顶部导航模式
class LayoutIndex extends StatefulWidget {
  /// 子组件内容
  final Widget child;

  const LayoutIndex({
    super.key,
    required this.child,
  });

  @override
  State<LayoutIndex> createState() => _LayoutIndexState();
}

class _LayoutIndexState extends State<LayoutIndex> {
  /// 布局组件映射
  final Map<LayoutType, Widget Function(Widget)> _layoutMap = {
    LayoutType.mix: (child) => LayoutMix(child: child),
    LayoutType.top: (child) => LayoutTop(child: child),
    LayoutType.defaultLayout: (child) => LayoutDefault(child: child),
  };

  /// 获取当前布局类型
  LayoutType get _currentLayoutType {
    // 从全局状态或配置中获取布局类型
    // 这里可以根据实际需求从状态管理中获取
    // 从全局状态或配置中获取布局类型
    final layoutValue = Global.prefs.getString('layout') ?? 'default';
    
    return LayoutType.values.firstWhere(
      (type) => type.value == layoutValue,
      orElse: () => LayoutType.defaultLayout,
    );
  }

  /// 获取当前布局组件
  Widget Function(Widget) get _currentLayout {
    return _layoutMap[_currentLayoutType] ?? _layoutMap[LayoutType.defaultLayout]!;
  }

  @override
  Widget build(BuildContext context) {
    return _currentLayout(widget.child);
  }
}
