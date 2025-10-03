///
/// @file Main 组件
/// @description 主内容区组件，支持路由切换动画、页面缓存和组件重载功能
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/global.dart';

/// 主内容区组件
/// 
/// 功能特性：
/// - 路由内容展示
/// - 页面切换动画
/// - 页面缓存管理
/// - 组件重载功能
/// - 响应式布局
class AppMain extends StatefulWidget {
  /// 子组件内容
  final Widget child;

  const AppMain({
    super.key,
    required this.child,
  });

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain>
    with SingleTickerProviderStateMixin {
  /// 应用状态控制器
  final _appController = Get.find<GlobalController>();
  
  /// 动画控制器
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  /// 初始化动画
  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // 启动入场动画
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GlobalController>(
      builder: (controller) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(0),
            child: _buildAnimatedContent(),
          ),
        );
      },
    );
  }

  /// 构建动画内容
  Widget _buildAnimatedContent() {
    // 根据配置的过渡动画类型构建不同的动画效果
    final transitionName = _appController.transitionName;
    
    switch (transitionName) {
      case 'fade':
        return FadeTransition(
          opacity: _fadeAnimation,
          child: widget.child,
        );
      case 'slide':
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: widget.child,
          ),
        );
      case 'none':
      default:
        return widget.child;
    }
  }

  @override
  void didUpdateWidget(AppMain oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // 当子组件发生变化时，重新播放动画
    if (oldWidget.child != widget.child) {
      _animationController.reset();
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
