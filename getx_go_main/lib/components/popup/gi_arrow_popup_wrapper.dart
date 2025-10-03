import 'package:flutter/material.dart';

/// 弹出方向枚举
enum PopupDirection {
  top,
  bottom,
  left,
  right,
}

/// 通用箭头弹出组件包装器
/// 
/// 使用方式：
/// ```dart
/// GiArrowPopupWrapper(
///   direction: PopupDirection.bottom,
///   size: Size(200, 100),
///   popupBuilder: (context) => MyCustomWidget(),
///   child: ElevatedButton(
///     onPressed: () {},
///     child: Text("点我"),
///   ),
/// )
/// ```
class GiArrowPopupWrapper extends StatefulWidget {
  /// 弹出方向
  final PopupDirection direction;
  
  /// 弹框尺寸
  final Size size;
  
  /// 弹框内容构建器
  final Widget Function(BuildContext context) popupBuilder;
  
  /// 被包裹的子组件
  final Widget child;
  
  /// 箭头大小
  final double arrowSize;
  
  /// 弹框圆角
  final double borderRadius;
  
  /// 弹框阴影
  final double elevation;
  
  /// 弹框背景色
  final Color backgroundColor;
  
  /// 是否启用动画
  final bool enableAnimation;
  
  /// 动画时长
  final Duration animationDuration;
  
  /// 弹框偏移量（用于微调位置）
  final Offset offset;
  
  /// 触发方式回调（用于手动触发，如果提供此参数则不会自动包装 GestureDetector）
  final Function(VoidCallback showPopup)? onTrigger;

  const GiArrowPopupWrapper({
    super.key,
    required this.direction,
    required this.size,
    required this.popupBuilder,
    required this.child,
    this.arrowSize = 8.0,
    this.borderRadius = 8.0,
    this.elevation = 8.0,
    this.backgroundColor = Colors.white,
    this.enableAnimation = true,
    this.animationDuration = const Duration(milliseconds: 200),
    this.offset = Offset.zero,
    this.onTrigger,
  });

  @override
  State<GiArrowPopupWrapper> createState() => _GiArrowPopupWrapperState();
}

class _GiArrowPopupWrapperState extends State<GiArrowPopupWrapper>
    with SingleTickerProviderStateMixin {
  final GlobalKey _childKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  AnimationController? _animationController;
  Animation<double>? _scaleAnimation;
  Animation<double>? _fadeAnimation;

  @override
  void initState() {
    super.initState();
    if (widget.enableAnimation) {
      _animationController = AnimationController(
        duration: widget.animationDuration,
        vsync: this,
      );
      _scaleAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeOutBack,
      ));
      _fadeAnimation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(CurvedAnimation(
        parent: _animationController!,
        curve: Curves.easeOut,
      ));
    }
    
    // 如果提供了触发回调，则在初始化时调用
    if (widget.onTrigger != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onTrigger!(_showPopup);
      });
    }
  }

  @override
  void dispose() {
    _removePopup();
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 如果提供了触发回调，则不自动包装 GestureDetector
    if (widget.onTrigger != null) {
      return Container(
        key: _childKey,
        child: widget.child,
      );
    }
    
    // 默认使用 GestureDetector 自动触发
    return GestureDetector(
      key: _childKey,
      onTap: _togglePopup,
      child: widget.child,
    );
  }

  /// 切换弹框显示/隐藏
  void _togglePopup() {
    if (_isOpen) {
      _removePopup();
    } else {
      _showPopup();
    }
  }

  /// 显示弹框
  void _showPopup() {
    if (_overlayEntry != null) return;
    
    final RenderBox? renderBox = _childKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;
    
    final Offset position = renderBox.localToGlobal(Offset.zero);
    final Size childSize = renderBox.size;
    
    // 计算弹框位置
    final PopupPosition popupPosition = _calculatePopupPosition(position, childSize);
    
    _overlayEntry = OverlayEntry(
      builder: (context) => _PopupOverlay(
        position: popupPosition.offset,
        size: widget.size,
        direction: widget.direction,
        arrowSize: widget.arrowSize,
        borderRadius: widget.borderRadius,
        elevation: widget.elevation,
        backgroundColor: widget.backgroundColor,
        enableAnimation: widget.enableAnimation,
        scaleAnimation: _scaleAnimation,
        fadeAnimation: _fadeAnimation,
        arrowPosition: popupPosition.arrowPosition,
        onTapOutside: _removePopup,
        child: widget.popupBuilder(context),
      ),
    );
    
    Overlay.of(context).insert(_overlayEntry!);
    _isOpen = true;
    
    if (widget.enableAnimation) {
      _animationController?.forward();
    }
  }

  /// 移除弹框
  void _removePopup() {
    if (!_isOpen) return;
    
    if (widget.enableAnimation && _animationController != null) {
      _animationController!.reverse().then((_) {
        _overlayEntry?.remove();
        _overlayEntry = null;
        _isOpen = false;
      });
    } else {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _isOpen = false;
    }
  }

  /// 计算弹框位置
  PopupPosition _calculatePopupPosition(Offset childPosition, Size childSize) {
    final double arrowSize = widget.arrowSize;
    final Size popupSize = widget.size;
    
    late Offset popupOffset;
    late double arrowPosition;
    
    switch (widget.direction) {
      case PopupDirection.top:
        popupOffset = Offset(
          childPosition.dx + (childSize.width - popupSize.width) / 2,
          childPosition.dy - popupSize.height - arrowSize,
        );
        arrowPosition = popupSize.width / 2;
        break;
        
      case PopupDirection.bottom:
        popupOffset = Offset(
          childPosition.dx + (childSize.width - popupSize.width) / 2,
          childPosition.dy + childSize.height + arrowSize,
        );
        arrowPosition = popupSize.width / 2;
        break;
        
      case PopupDirection.left:
        popupOffset = Offset(
          childPosition.dx - popupSize.width - arrowSize,
          childPosition.dy + (childSize.height - popupSize.height) / 2,
        );
        arrowPosition = popupSize.height / 2;
        break;
        
      case PopupDirection.right:
        popupOffset = Offset(
          childPosition.dx + childSize.width + arrowSize,
          childPosition.dy + (childSize.height - popupSize.height) / 2,
        );
        arrowPosition = popupSize.height / 2;
        break;
    }
    
    // 应用偏移量
    popupOffset = popupOffset + widget.offset;
    
    return PopupPosition(offset: popupOffset, arrowPosition: arrowPosition);
  }
}

/// 弹框位置信息
class PopupPosition {
  final Offset offset;
  final double arrowPosition;
  
  const PopupPosition({
    required this.offset,
    required this.arrowPosition,
  });
}

/// 弹框覆盖层
class _PopupOverlay extends StatelessWidget {
  final Offset position;
  final Size size;
  final PopupDirection direction;
  final double arrowSize;
  final double borderRadius;
  final double elevation;
  final Color backgroundColor;
  final bool enableAnimation;
  final Animation<double>? scaleAnimation;
  final Animation<double>? fadeAnimation;
  final double arrowPosition;
  final VoidCallback onTapOutside;
  final Widget child;

  const _PopupOverlay({
    required this.position,
    required this.size,
    required this.direction,
    required this.arrowSize,
    required this.borderRadius,
    required this.elevation,
    required this.backgroundColor,
    required this.enableAnimation,
    this.scaleAnimation,
    this.fadeAnimation,
    required this.arrowPosition,
    required this.onTapOutside,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Widget popup = Positioned(
      left: position.dx,
      top: position.dy,
      child: Material(
        type: MaterialType.transparency,
        child: CustomPaint(
          painter: _PopupShapePainter(
            direction: direction,
            arrowSize: arrowSize,
            borderRadius: borderRadius,
            backgroundColor: backgroundColor,
            arrowPosition: arrowPosition,
            elevation: elevation,
          ),
          child: Container(
            width: size.width,
            height: size.height,
            margin: _getMargin(),
            decoration: BoxDecoration(
              color: Colors.transparent, // 透明背景，由 CustomPaint 处理绘制
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius),
              child: child,
            ),
          ),
        ),
      ),
    );

    // 添加动画
    if (enableAnimation && scaleAnimation != null && fadeAnimation != null) {
      popup = AnimatedBuilder(
        animation: scaleAnimation!,
        builder: (context, child) {
          return Positioned(
            left: position.dx,
            top: position.dy,
            child: Transform.scale(
              scale: scaleAnimation!.value,
              child: Opacity(
                opacity: fadeAnimation!.value,
                child: Material(
                  type: MaterialType.transparency,
                  child: CustomPaint(
                    painter: _PopupShapePainter(
                      direction: direction,
                      arrowSize: arrowSize,
                      borderRadius: borderRadius,
                      backgroundColor: backgroundColor,
                      arrowPosition: arrowPosition,
                      elevation: elevation,
                    ),
                    child: Container(
                      width: size.width,
                      height: size.height,
                      margin: _getMargin(),
                      decoration: BoxDecoration(
                        color: Colors.transparent, // 透明背景，由 CustomPaint 处理绘制
                        borderRadius: BorderRadius.circular(borderRadius),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(borderRadius),
                        child: this.child,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }

    return Stack(
      children: [
        // 透明背景，用于捕获外部点击
        Positioned.fill(
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: onTapOutside,
            child: Container(color: Colors.transparent),
          ),
        ),
        // 弹框内容
        popup,
      ],
    );
  }

  /// 获取弹框边距（为箭头留出空间）
  EdgeInsets _getMargin() {
    switch (direction) {
      case PopupDirection.top:
        return EdgeInsets.only(bottom: arrowSize);
      case PopupDirection.bottom:
        return EdgeInsets.only(top: arrowSize);
      case PopupDirection.left:
        return EdgeInsets.only(right: arrowSize);
      case PopupDirection.right:
        return EdgeInsets.only(left: arrowSize);
    }
  }
}

/// 弹框形状绘制器（包含矩形主体和箭头的完整形状）
class _PopupShapePainter extends CustomPainter {
  final PopupDirection direction;
  final double arrowSize;
  final double borderRadius;
  final Color backgroundColor;
  final double arrowPosition;
  final double elevation;

  _PopupShapePainter({
    required this.direction,
    required this.arrowSize,
    required this.borderRadius,
    required this.backgroundColor,
    required this.arrowPosition,
    required this.elevation,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    // 创建包含矩形和箭头的完整路径
    final Path popupPath = _createPopupPath(size);

    // 绘制阴影
    if (elevation > 0) {
      final Paint shadowPaint = Paint()
        ..color = Colors.black.withValues(alpha: 0.25)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, elevation);
      
      // 绘制主阴影
      canvas.save();
      canvas.translate(0, 2);
      canvas.drawPath(popupPath, shadowPaint);
      canvas.restore();
      
      // 绘制更深的阴影
      final Paint deepShadowPaint = Paint()
        ..color = Colors.black.withValues(alpha: 0.25)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, elevation * 2);
      
      canvas.save();
      canvas.translate(0, 4);
      canvas.drawPath(popupPath, deepShadowPaint);
      canvas.restore();
    }

    // 绘制实际形状
    canvas.drawPath(popupPath, paint);
  }

  /// 创建包含矩形主体和箭头的完整路径
  Path _createPopupPath(Size size) {
    final Path path = Path();
    
    switch (direction) {
      case PopupDirection.bottom:
        _createBottomArrowPath(path, size);
        break;
      case PopupDirection.top:
        _createTopArrowPath(path, size);
        break;
      case PopupDirection.left:
        _createLeftArrowPath(path, size);
        break;
      case PopupDirection.right:
        _createRightArrowPath(path, size);
        break;
    }
    
    return path;
  }

  /// 创建底部箭头路径（箭头向上指）
  void _createBottomArrowPath(Path path, Size size) {
    final double arrowStart = arrowPosition - arrowSize;
    final double arrowEnd = arrowPosition + arrowSize;
    final double contentTop = arrowSize;
    
    // 创建矩形路径
    final RRect rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, contentTop, size.width, size.height - arrowSize),
      Radius.circular(borderRadius),
    );
    path.addRRect(rect);
    
    // 添加箭头三角形
    final Path arrowPath = Path();
    arrowPath.moveTo(arrowStart, contentTop);
    arrowPath.lineTo(arrowPosition, 0);
    arrowPath.lineTo(arrowEnd, contentTop);
    arrowPath.close();
    
    // 合并路径
    path.addPath(arrowPath, Offset.zero);
  }

  /// 创建顶部箭头路径（箭头向下指）
  void _createTopArrowPath(Path path, Size size) {
    final double arrowStart = arrowPosition - arrowSize;
    final double arrowEnd = arrowPosition + arrowSize;
    final double contentHeight = size.height - arrowSize;
    
    // 创建矩形路径
    final RRect rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, contentHeight),
      Radius.circular(borderRadius),
    );
    path.addRRect(rect);
    
    // 添加箭头三角形
    final Path arrowPath = Path();
    arrowPath.moveTo(arrowStart, contentHeight);
    arrowPath.lineTo(arrowPosition, size.height);
    arrowPath.lineTo(arrowEnd, contentHeight);
    arrowPath.close();
    
    // 合并路径
    path.addPath(arrowPath, Offset.zero);
  }

  /// 创建左侧箭头路径（箭头向右指）
  void _createLeftArrowPath(Path path, Size size) {
    final double arrowStart = arrowPosition - arrowSize;
    final double arrowEnd = arrowPosition + arrowSize;
    final double contentWidth = size.width - arrowSize;
    
    // 创建矩形路径
    final RRect rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, contentWidth, size.height),
      Radius.circular(borderRadius),
    );
    path.addRRect(rect);
    
    // 添加箭头三角形
    final Path arrowPath = Path();
    arrowPath.moveTo(contentWidth, arrowStart);
    arrowPath.lineTo(size.width, arrowPosition);
    arrowPath.lineTo(contentWidth, arrowEnd);
    arrowPath.close();
    
    // 合并路径
    path.addPath(arrowPath, Offset.zero);
  }

  /// 创建右侧箭头路径（箭头向左指）
  void _createRightArrowPath(Path path, Size size) {
    final double arrowStart = arrowPosition - arrowSize;
    final double arrowEnd = arrowPosition + arrowSize;
    final double contentLeft = arrowSize;
    
    // 创建矩形路径
    final RRect rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(contentLeft, 0, size.width - arrowSize, size.height),
      Radius.circular(borderRadius),
    );
    path.addRRect(rect);
    
    // 添加箭头三角形
    final Path arrowPath = Path();
    arrowPath.moveTo(contentLeft, arrowStart);
    arrowPath.lineTo(0, arrowPosition);
    arrowPath.lineTo(contentLeft, arrowEnd);
    arrowPath.close();
    
    // 合并路径
    path.addPath(arrowPath, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant _PopupShapePainter oldDelegate) {
    return oldDelegate.direction != direction ||
        oldDelegate.arrowSize != arrowSize ||
        oldDelegate.borderRadius != borderRadius ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.arrowPosition != arrowPosition ||
        oldDelegate.elevation != elevation;
  }
}
