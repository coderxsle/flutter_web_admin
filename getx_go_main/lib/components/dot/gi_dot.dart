import 'package:flutter/material.dart';

/// GiDot 组件 - 用于显示带有可选动画效果的状态点
class GiDot extends StatefulWidget {
  /// 是否启用动画效果
  final bool animation;
  
  /// 点的类型
  final DotType type;

  /// 点的尺寸
  final double size;

  const GiDot({
    super.key,
    this.animation = true,
    this.type = DotType.primary,
    this.size = 8,
  });

  @override
  State<GiDot> createState() => _GiDotState();
}

class _GiDotState extends State<GiDot> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.5,
      end: 2.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 0.7),
        weight: 30,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 0.7, end: 0.0),
        weight: 70,
      ),
    ]).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (widget.animation) {
      _animationController.repeat();
    }
  }

  @override
  void didUpdateWidget(GiDot oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animation != oldWidget.animation) {
      if (widget.animation) {
        _animationController.repeat();
      } else {
        _animationController.stop();
        _animationController.reset();
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color dotColor = _getDotColor(context);
    
    Widget dot = Container(
      width: widget.size,
      height: widget.size,
      decoration: BoxDecoration(
        color: dotColor,
        shape: BoxShape.circle,
      ),
    );

    if (widget.animation) {
      return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // 主点
              dot,
              // 动画层
              Transform.scale(
                scale: _scaleAnimation.value,
                child: Opacity(
                  opacity: _opacityAnimation.value,
                  child: Container(
                    width: widget.size,
                    height: widget.size,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    }

    return dot;
  }

  /// 获取点的颜色
  Color _getDotColor(BuildContext context) {
    switch (widget.type) {
      case DotType.primary:
        return Theme.of(context).primaryColor;
      case DotType.success:
        return Colors.green;
      case DotType.warning:
        return Colors.orange;
      case DotType.danger:
        return Colors.red;
      case DotType.info:
        return Colors.grey;
    }
  }
}

/// 点的类型枚举
enum DotType {
  primary,
  success,
  warning,
  danger,
  info,
}
