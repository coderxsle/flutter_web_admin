import 'package:flutter/material.dart';
import 'dart:math' as math;

/// ArcoDesign 风格的按钮组件 - 高度还原 Vue demo
class GiArcoButton extends StatefulWidget {

  final GiArcoButtonType type;        // 按钮类型  
  final GiArcoButtonStatus status;    // 按钮状态
  final GiArcoButtonShape shape;      // 按钮形状
  final String? text;                 // 按钮文本
  final IconData? icon;               // 按钮图标
  final bool disabled;                // 是否禁用
  final VoidCallback? onPressed;      // 点击回调
  final Widget? child;                // 自定义子组件

  const GiArcoButton({
    super.key,
    this.type = GiArcoButtonType.primary,
    this.status = GiArcoButtonStatus.normal,
    this.shape = GiArcoButtonShape.square,
    this.text,
    this.icon,
    this.disabled = false,
    this.onPressed,
    this.child,
  });

  @override
  State<GiArcoButton> createState() => _GiArcoButtonState();
}

class _GiArcoButtonState extends State<GiArcoButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final config = _getButtonConfig();
    final isTextOnly = widget.type == GiArcoButtonType.text;
    
    Widget buttonWidget = AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            height: _getButtonHeight(),
            constraints: (widget.shape == GiArcoButtonShape.circle || widget.shape == GiArcoButtonShape.rect)
                ? BoxConstraints.tightFor(
                    width: _getButtonHeight(),
                    height: _getButtonHeight(),
                  )
                : const BoxConstraints(minWidth: 64),
            child: widget.type == GiArcoButtonType.dashed
                ? _buildDashedButton(config)
                : _buildNormalButton(config, isTextOnly),
          ),
        );
      },
    );

    // 如果按钮被禁用，添加悬停提示
    if (widget.disabled) {
      return Tooltip(
        richMessage: WidgetSpan(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.block, size: 14, color: Colors.white),
              SizedBox(width: 4),
              Text('按钮已禁用', style: TextStyle(color: Colors.white, fontSize: 12)),
            ],
          ),
        ),
        decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        preferBelow: false,
        child: Stack(
          children: [
            buttonWidget,
            Positioned.fill(
              child: MouseRegion(
                cursor: SystemMouseCursors.forbidden,
                child: Container(color: Colors.transparent),
              ),
            ),
          ],
        ),
      );
    }

    return buttonWidget;
  }

  /// 构建按钮禁用时鼠标样式
  ButtonStyle _buildMouseCursorStyle(ButtonConfig config) {
    return ButtonStyle(
      mouseCursor: WidgetStateProperty.resolveWith<MouseCursor>((states) {
        return states.contains(WidgetState.disabled)
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click;
      }),
    );
  }

  /// 构建普通按钮
  Widget _buildNormalButton(ButtonConfig config, bool isTextOnly) {
    // 对于 Outline 和 Text 按钮，使用 OutlinedButton 或 TextButton 以确保透明背景
    if (widget.type == GiArcoButtonType.outline) {
      return OutlinedButton(
        onPressed: widget.disabled ? null : _handlePressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: widget.disabled ? config.disabledTextColor : config.textColor,
          side: BorderSide(
            color: widget.disabled ? config.disabledBorderColor : config.borderColor,
            width: 1,
          ),
          elevation: 0,
          shape: widget.shape == GiArcoButtonShape.circle
              ? const CircleBorder()
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_getBorderRadius()),
                ),
          padding: (widget.shape == GiArcoButtonShape.circle || widget.shape == GiArcoButtonShape.rect) ? EdgeInsets.zero : _getButtonPadding(),
          minimumSize: (widget.shape == GiArcoButtonShape.circle || widget.shape == GiArcoButtonShape.rect)
              ? Size(_getButtonHeight(), _getButtonHeight())
              : null,
          fixedSize: (widget.shape == GiArcoButtonShape.circle || widget.shape == GiArcoButtonShape.rect)
              ? Size(_getButtonHeight(), _getButtonHeight())
              : null,
        ).merge(
          _buildMouseCursorStyle(config),
        ),
        child: _buildButtonContent(),
      );
    }

    if (widget.type == GiArcoButtonType.normal) {
      // 普通按钮：白底 + 灰边 + 灰字
      return OutlinedButton(
        onPressed: widget.disabled ? null : _handlePressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: widget.disabled ? ButtonConfigs.disabledBg : Colors.white,
          foregroundColor: widget.disabled ? ButtonConfigs.disabledText : ButtonConfigs.grayText,
          side: BorderSide(
            color: widget.disabled ? ButtonConfigs.disabledBorder : ButtonConfigs.grayBorder,
            width: 1,
          ),
          elevation: 0,
          shape: widget.shape == GiArcoButtonShape.circle
              ? const CircleBorder()
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_getBorderRadius()),
                ),
          padding: (widget.shape == GiArcoButtonShape.circle || widget.shape == GiArcoButtonShape.rect) ? EdgeInsets.zero : _getButtonPadding(),
          minimumSize: (widget.shape == GiArcoButtonShape.circle || widget.shape == GiArcoButtonShape.rect)
              ? Size(_getButtonHeight(), _getButtonHeight())
              : null,
          fixedSize: (widget.shape == GiArcoButtonShape.circle || widget.shape == GiArcoButtonShape.rect)
              ? Size(_getButtonHeight(), _getButtonHeight())
              : null,
        ).merge(
          _buildMouseCursorStyle(config),
        ),
        child: _buildButtonContent(),
      );
    }
    
    if (widget.type == GiArcoButtonType.text) {
      return TextButton(
        onPressed: widget.disabled ? null : _handlePressed,
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: widget.disabled ? config.disabledTextColor : config.textColor,
          elevation: 0,
          shape: widget.shape == GiArcoButtonShape.circle
              ? const CircleBorder()
              : RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(_getBorderRadius()),
                ),
          padding: (widget.shape == GiArcoButtonShape.circle || widget.shape == GiArcoButtonShape.rect) ? EdgeInsets.zero : _getButtonPadding(),
          minimumSize: (widget.shape == GiArcoButtonShape.circle || widget.shape == GiArcoButtonShape.rect)
              ? Size(_getButtonHeight(), _getButtonHeight())
              : null,
          fixedSize: (widget.shape == GiArcoButtonShape.circle || widget.shape == GiArcoButtonShape.rect)
              ? Size(_getButtonHeight(), _getButtonHeight())
              : null,
        ).merge(
          _buildMouseCursorStyle(config),
        ),
        child: _buildButtonContent(),
      );
    }
    
    // 对于 Primary 和 Secondary 按钮，使用 ElevatedButton
    return ElevatedButton(
      onPressed: widget.disabled ? null : _handlePressed,
      style: ElevatedButton.styleFrom(
        shadowColor: Colors.transparent,
        backgroundColor: widget.disabled ? config.disabledBackgroundColor : config.backgroundColor,
        foregroundColor: widget.disabled ? config.disabledTextColor : config.textColor,
        elevation: widget.disabled ? 0 : 1,
        shape: widget.shape == GiArcoButtonShape.circle
            ? const CircleBorder()
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(_getBorderRadius()),
              ),
        padding: (widget.shape == GiArcoButtonShape.circle || widget.shape == GiArcoButtonShape.rect) ? EdgeInsets.zero : _getButtonPadding(),
        minimumSize: (widget.shape == GiArcoButtonShape.circle || widget.shape == GiArcoButtonShape.rect)
            ? Size(_getButtonHeight(), _getButtonHeight())
            : null,
        fixedSize: (widget.shape == GiArcoButtonShape.circle || widget.shape == GiArcoButtonShape.rect)
            ? Size(_getButtonHeight(), _getButtonHeight())
            : null,
      ).merge(
        _buildMouseCursorStyle(config),
      ),
      child: _buildButtonContent(),
    );
  }

  /// 构建虚线边框按钮
  Widget _buildDashedButton(ButtonConfig config) {
    return GestureDetector(
      onTapDown: (_) => _handleTapDown(),
      onTapUp: (_) => _handleTapUp(),
      onTapCancel: _handleTapCancel,
      onTap: widget.disabled ? null : widget.onPressed,
      child: CustomPaint(
        painter: DashedBorderPainter(
          borderColor: widget.disabled ? config.disabledBorderColor : config.borderColor,
          backgroundColor: widget.disabled ? config.disabledBackgroundColor : config.backgroundColor,
          borderRadius: _getBorderRadius(),
          isPressed: _isPressed && !widget.disabled,
        ),
        child: Container(
          padding: _getButtonPadding(),
          decoration: BoxDecoration(
            color: _isPressed && !widget.disabled 
                ? config.borderColor.withValues(alpha: 0.1)
                : (widget.disabled ? config.disabledBackgroundColor : config.backgroundColor),
            borderRadius: BorderRadius.circular(_getBorderRadius()),
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              color: widget.disabled ? config.disabledTextColor : config.textColor,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
            child: _buildButtonContent(),
          ),
        ),
      ),
    );
  }

  /// 构建按钮内容
  Widget _buildButtonContent() {
    if (widget.child != null) {
      return widget.child!;
    }

    final hasIcon = widget.icon != null;
    final hasText = widget.text != null && widget.text!.isNotEmpty;

    if (hasIcon && hasText) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon!, size: 14),
          const SizedBox(width: 4),
          Text(widget.text!),
        ],
      );
    } else if (hasIcon) {
      return Icon(widget.icon!, size: 14);
    } else if (hasText) {
      return Text(widget.text!);
    } else {
      return const SizedBox.shrink();
    }
  }

  /// 处理按钮按下
  void _handlePressed() {
    if (!widget.disabled) {
      widget.onPressed?.call();
    }
  }

  void _handleTapDown() {
    if (!widget.disabled) {
      setState(() => _isPressed = true);
      _animationController.forward();
    }
  }

  void _handleTapUp() {
    if (!widget.disabled) {
      setState(() => _isPressed = false);
      _animationController.reverse();
    }
  }

  void _handleTapCancel() {
    if (!widget.disabled) {
      setState(() => _isPressed = false);
      _animationController.reverse();
    }
  }

  /// 获取按钮配置
  ButtonConfig _getButtonConfig() {
    return ButtonConfigs.getConfig(widget.type, widget.status);
  }

  /// 获取按钮高度
  double _getButtonHeight() {
    return 32.0;
  }

  /// 获取边框圆角
  double _getBorderRadius() {
    switch (widget.shape) {
      case GiArcoButtonShape.rect:
      case GiArcoButtonShape.square:
        return 6.0;
      case GiArcoButtonShape.round:
      case GiArcoButtonShape.circle:
        return 16.0;
    }
  }

  /// 获取按钮内边距
  EdgeInsets _getButtonPadding() {
    if (widget.shape == GiArcoButtonShape.circle || widget.shape == GiArcoButtonShape.rect) {
      return EdgeInsets.zero;
    }
    return const EdgeInsets.symmetric(horizontal: 15, vertical: 6);
  }
}

/// 虚线边框绘制器
class DashedBorderPainter extends CustomPainter {
  final Color borderColor;
  final Color backgroundColor;
  final double borderRadius;
  final bool isPressed;

  DashedBorderPainter({
    required this.borderColor,
    required this.backgroundColor,
    required this.borderRadius,
    this.isPressed = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(0.5, 0.5, size.width - 1, size.height - 1);
    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    // 绘制虚线边框
    _drawDashedRRect(canvas, rrect, paint);
  }

  void _drawDashedRRect(Canvas canvas, RRect rrect, Paint paint) {
    const dashWidth = 4.0;
    const dashSpace = 3.0;
    
    final path = Path()..addRRect(rrect);
    final pathMetrics = path.computeMetrics();
    
    for (final pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final extractPath = pathMetric.extractPath(
          distance,
          math.min(distance + dashWidth, pathMetric.length),
        );
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate is DashedBorderPainter &&
        (oldDelegate.borderColor != borderColor ||
            oldDelegate.backgroundColor != backgroundColor ||
            oldDelegate.borderRadius != borderRadius ||
            oldDelegate.isPressed != isPressed);
  }
}

/// 按钮类型
enum GiArcoButtonType {
  primary,
  secondary,
  normal,
  dashed,
  outline,
  text,
}

/// 按钮状态
enum GiArcoButtonStatus {
  normal,
  success,
  warning,
  danger,
}

/// 按钮形状
/// - square: 默认矩形（圆角较小）
/// - round: 圆角矩形（圆角较大）
/// - circle: 圆形按钮（宽高相等，完全圆形）
/// - rect: 正方形按钮（宽高相等，圆角较小）
enum GiArcoButtonShape {
  square,   // 矩形
  round,    // 圆角矩形
  circle,   // 圆形
  rect,     // 正方形
}

/// 按钮配置
class ButtonConfig {
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;
  final Color disabledBackgroundColor;
  final Color disabledTextColor;
  final Color disabledBorderColor;

  const ButtonConfig({
    required this.backgroundColor,
    required this.textColor,
    required this.borderColor,
    required this.disabledBackgroundColor,
    required this.disabledTextColor,
    required this.disabledBorderColor,
  });
}

/// 按钮配置管理
class ButtonConfigs {
  // 颜色定义 - 参考 ArcoDesign
  static const Color primaryBlue = Color(0xFF165DFF);
  static const Color successGreen = Color(0xFF00B42A);
  static const Color warningOrange = Color(0xFFFF7D00);
  static const Color dangerRed = Color(0xFFF53F3F);
  
  static const Color grayBg = Color(0xFFF7F8FA);
  static const Color grayBorder = Color(0xFFDCDFE3);
  static const Color grayText = Color(0xFF4E5969);
  static const Color disabledBg = Color(0xFFF7F8FA);
  static const Color disabledText = Color(0xFFC9CDD4);
  static const Color disabledBorder = Color(0xFFF2F3F5);

  static ButtonConfig getConfig(GiArcoButtonType type, GiArcoButtonStatus status) {
    final baseColor = _getStatusColor(status);
    
    switch (type) {
      case GiArcoButtonType.primary:
        return ButtonConfig(
          backgroundColor: baseColor,
          textColor: Colors.white,
          borderColor: baseColor,
          disabledBackgroundColor: disabledBg,
          disabledTextColor: disabledText,
          disabledBorderColor: disabledBorder,
          // 禁用时保持颜色但降低透明度
          // disabledBackgroundColor: baseColor.withValues(alpha: 0.4),
          // disabledTextColor: Colors.white.withValues(alpha: 0.8),
          // disabledBorderColor: baseColor.withValues(alpha: 0.4),
        );
        
      case GiArcoButtonType.secondary:
        return ButtonConfig(
          backgroundColor: baseColor.withValues(alpha: 0.15),
          textColor: baseColor,
          borderColor: grayBorder,
          disabledBackgroundColor: disabledBg,
          disabledTextColor: disabledText,
          disabledBorderColor: disabledBorder,
          // 禁用时保持颜色但降低透明度
          // disabledBackgroundColor: baseColor.withValues(alpha: 0.08),
          // disabledTextColor: baseColor.withValues(alpha: 0.5),
          // disabledBorderColor: grayBorder.withValues(alpha: 0.8),
        );

      case GiArcoButtonType.normal:
        // 白底 + 灰边 + 灰字（不随状态色变动）
        return const ButtonConfig(
          backgroundColor: Colors.white,
          textColor: grayText,
          borderColor: grayBorder,
          disabledBackgroundColor: disabledBg,
          disabledTextColor: disabledText,
          disabledBorderColor: disabledBorder,
        );
        
      case GiArcoButtonType.dashed:
      case GiArcoButtonType.outline:
        return ButtonConfig(
          backgroundColor: Colors.transparent,
          textColor: baseColor,
          borderColor: baseColor,
          disabledBackgroundColor: Colors.transparent,
          // disabledTextColor: disabledText,
          // disabledBorderColor: disabledBorder,
          // 禁用时保持颜色但降低透明度
          disabledTextColor: baseColor.withValues(alpha: 0.5),
          disabledBorderColor: baseColor.withValues(alpha: 0.4),
        );
        
      case GiArcoButtonType.text:
        return ButtonConfig(
          backgroundColor: Colors.transparent,
          textColor: baseColor,
          borderColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          disabledTextColor: disabledText,
          disabledBorderColor: disabledBorder,
          // 禁用时保持颜色但降低透明度
          // disabledTextColor: disabledText,
          // disabledBorderColor: Colors.transparent,
        );
    }
  }

  static Color _getStatusColor(GiArcoButtonStatus status) {
    switch (status) {
      case GiArcoButtonStatus.normal:
        return primaryBlue;
      case GiArcoButtonStatus.success:
        return successGreen;
      case GiArcoButtonStatus.warning:
        return warningOrange;
      case GiArcoButtonStatus.danger:
        return dangerRed;
    }
  }
}
