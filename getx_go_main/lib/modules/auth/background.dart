import 'dart:math';
import 'package:flutter/material.dart';

class ServerpodBackground extends StatefulWidget {
  final Widget child;
  final bool enableBubbles; // 气泡控制开关 - true表示显示动态气泡，false表示显示静态气泡
  
  const ServerpodBackground({
    super.key,
    required this.child,
    this.enableBubbles = true, // 默认显示动态气泡
  });

  @override
  State<ServerpodBackground> createState() => _ServerpodBackgroundState();
}

class _ServerpodBackgroundState extends State<ServerpodBackground> with TickerProviderStateMixin {
  // 使用可空类型
  AnimationController? _animationController;
  AnimationController? _fadeInController;
  final List<Bubble> _bubbles = []; // 动态气泡
  final List<StaticBubble> _staticBubbles = []; // 静态气泡
  final List<DecorativeLine> _lines = [];
  final List<DecorativeShape> _shapes = [];
  final Random _random = Random();
  bool _elementsGenerated = false;
  
  @override
  void initState() {
    super.initState();
    
    try {
      // 创建淡入动画控制器（无论是否启用气泡都需要）
      _fadeInController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800),
      )..forward();
      
      // 只有启用动态气泡时才初始化气泡动画控制器
      if (widget.enableBubbles) {
        _animationController = AnimationController(
          vsync: this,
          duration: const Duration(seconds: 10),
        )..repeat();
        
        // 添加气泡动画监听器
        _animationController?.addListener(() {
          if (_bubbles.isEmpty) return;
          for (var bubble in _bubbles) {
            bubble.move();
            if (bubble.position.dy < -bubble.radius * 2) {
              _resetBubble(bubble);
            }
          }
          if (mounted) setState(() {});
        });
      }
    } catch (e) {
      print('初始化控制器时发生错误: $e');
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    
    try {
      // 只生成一次元素
      if (!_elementsGenerated && mounted) {
        // 总是生成装饰元素
        _generateLines();
        _generateShapes();
        
        // 根据enableBubbles生成对应类型的气泡
        if (widget.enableBubbles) {
          // 动态气泡
          _generateBubbles();
        } else {
          // 静态气泡
          _generateStaticBubbles();
        }
        
        _elementsGenerated = true;
      }
    } catch (e) {
      print('生成元素时发生错误: $e');
    }
  }

  @override
  void didUpdateWidget(ServerpodBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    // 如果气泡显示模式发生变化，重新生成相应的气泡
    if (oldWidget.enableBubbles != widget.enableBubbles) {
      if (widget.enableBubbles) {
        // 切换到动态气泡
        _staticBubbles.clear();
        _generateBubbles();
        
        // 重新初始化并启动动画控制器
        _animationController?.dispose();
        _animationController = AnimationController(
          vsync: this,
          duration: const Duration(seconds: 10),
        )..repeat();
        
        _animationController?.addListener(() {
          if (_bubbles.isEmpty) return;
          for (var bubble in _bubbles) {
            bubble.move();
            if (bubble.position.dy < -bubble.radius * 2) {
              _resetBubble(bubble);
            }
          }
          if (mounted) setState(() {});
        });
      } else {
        // 切换到静态气泡
        _bubbles.clear();
        _generateStaticBubbles();
        
        // 释放动画控制器以节省资源
        _animationController?.dispose();
        _animationController = null;
      }
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    _fadeInController?.dispose();
    super.dispose();
  }
  
  void _generateStaticBubbles() {
    final screenSize = MediaQuery.of(context).size;
    _staticBubbles.clear();
    
    // 生成25个静态气泡，数量比动态气泡多一些，因为没有动画效果
    for (var i = 0; i < 25; i++) {
      // 均匀分布在整个屏幕上，而不仅是底部
      final x = _random.nextDouble() * screenSize.width;
      final y = _random.nextDouble() * screenSize.height;
      
      // 更淡的气泡颜色
      final colors = [
        const Color(0xFF90CAF9), // 更淡的蓝色
        const Color(0xFFF8BBD0), // 更淡的粉色
        const Color(0xFFA5D6A7), // 更淡的绿色
        const Color(0xFFB39DDB), // 更淡的紫色
      ];
      
      // 修改这里，增大静态气泡的尺寸
      // 原来是 5.0 + _random.nextDouble() * 35.0
      final radius = 10.0 + _random.nextDouble() * 70.0; 
      final color = colors[_random.nextInt(colors.length)];
      
      // 静态气泡透明度略微降低一点点
      final opacity = 0.15 + _random.nextDouble() * 0.25;
      
      // 生成随机高光位置 - 确保在气泡半径的40-70%范围内
      final highlightAngle = _random.nextDouble() * 2 * pi; // 随机角度
      final highlightDistance = radius * (0.4 + _random.nextDouble() * 0.3); // 随机距离(40%-70%半径)
      final highlightOffset = Offset(
        highlightDistance * cos(highlightAngle),
        highlightDistance * sin(highlightAngle)
      );
      
      _staticBubbles.add(
        StaticBubble(
          position: Offset(x, y),
          radius: radius,
          color: color,
          opacity: opacity,
          highlightOffset: highlightOffset,
        ),
      );
    }
  }
  
  void _generateBubbles() {
    final screenSize = MediaQuery.of(context).size;
    _bubbles.clear();
    
    // 生成20个动态气泡
    for (var i = 0; i < 20; i++) {
      _bubbles.add(_createBubble(screenSize));
    }
  }
  
  Bubble _createBubble(Size screenSize) {
    // 更淡的气泡颜色
    final colors = [
      const Color(0xFF90CAF9), // 更淡的蓝色
      const Color(0xFFF8BBD0), // 更淡的粉色
      const Color(0xFFA5D6A7), // 更淡的绿色
      const Color(0xFFB39DDB), // 更淡的紫色
    ];
    
    // 修改这里，增加气泡半径的范围，使大气泡尺寸增大一倍
    final radius = 20.0 + _random.nextDouble() * 60.0; // 原来是 10.0 + _random.nextDouble() * 30.0
    final x = _random.nextDouble() * screenSize.width;
    final y = screenSize.height + radius + _random.nextDouble() * 300;
    final color = colors[_random.nextInt(colors.length)];
    final speed = 0.5 + (80 - radius) / 80 * 1.5; // 调整速度计算公式以适应新的半径范围
    final wobble = 0.3 + _random.nextDouble() * 0.7;
    
    // 生成随机高光位置
    final highlightAngle = _random.nextDouble() * 2 * pi; // 随机角度
    final highlightDistance = radius * (0.3 + _random.nextDouble() * 0.4); // 随机距离(30%-70%半径)
    final highlightOffset = Offset(
      highlightDistance * cos(highlightAngle),
      highlightDistance * sin(highlightAngle)
    );
    
    // 生成随机高光点位置 - 通常在气泡的上半部分
    final dotAngle = _random.nextDouble() * pi - (pi / 2); // 随机角度(-90°到90°)
    final dotDistance = radius * (0.2 + _random.nextDouble() * 0.3); // 随机距离(20%-50%半径)
    final dotOffset = Offset(
      dotDistance * cos(dotAngle),
      dotDistance * sin(dotAngle)
    );
    
    // 动态气泡透明度略微降低一点点
    return Bubble(
      position: Offset(x, y),
      radius: radius,
      color: color,
      speed: speed,
      wobble: wobble,
      opacity: 0.3 + _random.nextDouble() * 0.3,
      phase: _random.nextDouble() * 2 * pi,
      highlightOffset: highlightOffset,
      dotOffset: dotOffset,
    );
  }
  
  void _generateShapes() {
    final screenSize = MediaQuery.of(context).size;
    _shapes.clear();
    
    // 添加左下角三角形
    _shapes.add(
      DecorativeShape.triangle(
        position: Offset(screenSize.width * 0.1, screenSize.height * 0.9),
        size: 80.0,
        rotation: pi / 6,
        color: const Color(0xFF81C784).withOpacity(0.05),
      ),
    );
    
    // 添加右上角圆形
    _shapes.add(
      DecorativeShape.circle(
        position: Offset(screenSize.width * 0.85, screenSize.height * 0.15),
        radius: 50.0,
        color: const Color(0xFF9575CD).withOpacity(0.05),
      ),
    );
    
    // 添加中间小圆点组
    for (var i = 0; i < 5; i++) {
      _shapes.add(
        DecorativeShape.circle(
          position: Offset(
            screenSize.width * (0.3 + i * 0.1),
            screenSize.height * (0.4 + (i % 2) * 0.05),
          ),
          radius: 3.0 + i * 1.5,
          color: const Color(0xFF64B5F6).withOpacity(0.08),
        ),
      );
    }
  }
  
  void _generateLines() {
    final screenSize = MediaQuery.of(context).size;
    _lines.clear();
    
    // 底部到左侧的线条
    _lines.add(
      DecorativeLine(
        start: Offset(0, screenSize.height * 0.75),
        end: Offset(screenSize.width * 0.3, screenSize.height),
        color1: const Color(0xFF90CAF9).withOpacity(0.3),
        color2: const Color(0xFFB39DDB).withOpacity(0.3),
        width: 1.5,
      ),
    );
    
    _lines.add(
      DecorativeLine(
        start: Offset(0, screenSize.height * 0.85),
        end: Offset(screenSize.width * 0.4, screenSize.height),
        color1: const Color(0xFF90CAF9).withOpacity(0.3),
        color2: const Color(0xFFB39DDB).withOpacity(0.3),
        width: 1.0,
      ),
    );
    
    // 顶部到右侧的线条
    _lines.add(
      DecorativeLine(
        start: Offset(screenSize.width * 0.7, 0),
        end: Offset(screenSize.width, screenSize.height * 0.25),
        color1: const Color(0xFFB39DDB).withOpacity(0.3),
        color2: const Color(0xFF90CAF9).withOpacity(0.3),
        width: 1.5,
      ),
    );
    
    _lines.add(
      DecorativeLine(
        start: Offset(screenSize.width * 0.6, 0),
        end: Offset(screenSize.width, screenSize.height * 0.15),
        color1: const Color(0xFFB39DDB).withOpacity(0.3),
        color2: const Color(0xFF90CAF9).withOpacity(0.3),
        width: 1.0,
      ),
    );
    
    // 弧形线条
    _lines.add(
      DecorativeLine.arc(
        center: Offset(0, screenSize.height),
        radius: screenSize.width * 0.5,
        startAngle: -0.5,
        endAngle: 0,
        color1: const Color(0xFF81D4FA).withOpacity(0.2),
        color2: const Color(0xFFCE93D8).withOpacity(0.2),
        width: 1.0,
      ),
    );
    
    _lines.add(
      DecorativeLine.arc(
        center: Offset(screenSize.width, 0),
        radius: screenSize.width * 0.5,
        startAngle: pi/2,
        endAngle: pi,
        color1: const Color(0xFFCE93D8).withOpacity(0.2),
        color2: const Color(0xFF81D4FA).withOpacity(0.2),
        width: 1.0,
      ),
    );
  }
  
  void _resetBubble(Bubble bubble) {
    if (!mounted) return;
    
    final screenSize = MediaQuery.of(context).size;
    final x = _random.nextDouble() * screenSize.width;
    final y = screenSize.height + bubble.radius + _random.nextDouble() * 100;
    
    bubble.position = Offset(x, y);
    bubble.phase = _random.nextDouble() * 2 * pi;
  }

  @override
  Widget build(BuildContext context) {
    // 安全检查：如果淡入控制器未初始化，显示简单的背景和子组件
    if (_fadeInController == null) {
      return Container(
        color: const Color.fromARGB(255, 100, 149, 237),
        child: widget.child,
      );
    }
    
    return AnimatedBuilder(
      animation: _fadeInController!,
      builder: (context, child) {
    return Container(
          // 背景渐变
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.0, -0.2),
              radius: 1.2,
              colors: [
                // 您可以在这里修改颜色
                const Color.fromARGB(47, 25, 97, 229), // 蓝色边缘
                const Color.fromARGB(30, 42, 206, 63), // 淡蓝色中心
                const Color.fromARGB(30, 242, 91, 74), // 淡蓝色中心
                const Color.fromARGB(30, 225, 236, 6), // 淡蓝色中心
              ],
              stops: const [0.4, 0.6, 0.8, 1.0],
            ),
          ),
          child: Opacity(
            opacity: _fadeInController?.value ?? 1.0,
      child: Stack(
        fit: StackFit.expand,
        children: [
                // 装饰形状 - 始终显示
                if (_shapes.isNotEmpty)
                  CustomPaint(
                    painter: ShapesPainter(_shapes),
                    size: Size.infinite,
                  ),
                
                // 装饰线条 - 始终显示
                if (_lines.isNotEmpty)
                  CustomPaint(
                    painter: LinesPainter(_lines),
                    size: Size.infinite,
                  ),
                
                // 静态气泡 - 仅当禁用动态气泡时显示
                if (!widget.enableBubbles && _staticBubbles.isNotEmpty)
                  CustomPaint(
                    painter: StaticBubblePainter(_staticBubbles),
                    size: Size.infinite,
                  ),
                
                // 动态气泡 - 仅当启用动态气泡时显示
                if (widget.enableBubbles && _animationController != null && _bubbles.isNotEmpty)
                  AnimatedBuilder(
                    animation: _animationController!, 
                    builder: (context, child) {
                      return CustomPaint(
                        painter: BubblePainter(_bubbles),
                        size: Size.infinite,
                      );
                    }
                  ),
          
                // 子组件（内容） - 始终显示
                AnimatedSlide(
                  offset: Offset(0.0, 0.05 - ((_fadeInController?.value ?? 1.0) * 0.05)),
                  duration: const Duration(milliseconds: 800),
                  child: widget.child,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}

class StaticBubble {
  final Offset position;
  final double radius;
  final Color color;
  final double opacity;
  final Offset highlightOffset; // 添加随机高光位置属性
  
  StaticBubble({
    required this.position,
    required this.radius,
    required this.color,
    required this.opacity,
    required this.highlightOffset, // 添加随机高光位置
  });
}

class Bubble {
  Offset position;
  final double radius;
  final Color color;
  final double speed;
  final double wobble;
  final double opacity;
  double phase;
  final Offset highlightOffset; // 添加随机高光位置属性
  final Offset dotOffset; // 添加随机高光点位置属性
  
  Bubble({
    required this.position,
    required this.radius,
    required this.color,
    required this.speed,
    required this.wobble,
    required this.opacity,
    required this.phase,
    required this.highlightOffset, // 添加随机高光位置
    required this.dotOffset, // 添加随机高光点位置
  });
  
  void move() {
    // 向上移动
    final dy = position.dy - speed;
    
    // 水平摆动
    final dx = position.dx + sin(phase) * wobble;
    
    // 更新位置
    position = Offset(dx, dy);
    
    // 更新相位
    phase += 0.01;
  }
}

class DecorativeShape {
  final Offset position;
  final double size;
  final double? radius;
  final double? rotation;
  final Color color;
  final ShapeType type;
  
  DecorativeShape.circle({
    required this.position,
    required this.radius,
    required this.color,
  }) : type = ShapeType.circle,
       size = radius! * 2,
       rotation = null;
  
  DecorativeShape.triangle({
    required this.position,
    required this.size,
    required this.rotation,
    required this.color,
  }) : type = ShapeType.triangle,
       radius = null;
}

enum ShapeType { circle, triangle }

class DecorativeLine {
  final Offset? start;
  final Offset? end;
  final Offset? center;
  final double? radius;
  final double? startAngle;
  final double? endAngle;
  final Color color1;
  final Color color2;
  final double width;
  final bool isArc;
  
  DecorativeLine({
    required this.start,
    required this.end,
    required this.color1,
    required this.color2,
    required this.width,
  }) : center = null, 
       radius = null, 
       startAngle = null, 
       endAngle = null,
       isArc = false;
  
  DecorativeLine.arc({
    required this.center,
    required this.radius,
    required this.startAngle,
    required this.endAngle,
    required this.color1,
    required this.color2,
    required this.width,
  }) : start = null, 
       end = null,
       isArc = true;
}

class ShapesPainter extends CustomPainter {
  final List<DecorativeShape> shapes;
  
  ShapesPainter(this.shapes);
  
  @override
  void paint(Canvas canvas, Size size) {
    for (var shape in shapes) {
      final paint = Paint()
        ..color = shape.color
        ..style = PaintingStyle.fill;
      
      switch (shape.type) {
        case ShapeType.circle:
          canvas.drawCircle(shape.position, shape.radius!, paint);
          break;
        case ShapeType.triangle:
          _drawTriangle(canvas, shape.position, shape.size, shape.rotation!, paint);
          break;
      }
    }
  }
  
  void _drawTriangle(Canvas canvas, Offset position, double size, double rotation, Paint paint) {
    final path = Path();
    
    // 创建一个以原点为中心的三角形
    path.moveTo(0, -size / 2);
    path.lineTo(-size / 2, size / 2);
    path.lineTo(size / 2, size / 2);
    path.close();
    
    // 保存当前画布状态
    canvas.save();
    
    // 将画布移动到指定位置
    canvas.translate(position.dx, position.dy);
    
    // 旋转画布
    canvas.rotate(rotation);
    
    // 绘制三角形
    canvas.drawPath(path, paint);
    
    // 恢复画布状态
    canvas.restore();
  }

  @override
  bool shouldRepaint(ShapesPainter oldDelegate) => false;
}

class LinesPainter extends CustomPainter {
  final List<DecorativeLine> lines;
  
  LinesPainter(this.lines);
  
  @override
  void paint(Canvas canvas, Size size) {
    for (var line in lines) {
      if (line.isArc) {
        // 绘制弧形
        final rect = Rect.fromCircle(
          center: line.center!, 
          radius: line.radius!
        );
        
        final paint = Paint()
          ..shader = SweepGradient(
            colors: [line.color1, line.color2],
            startAngle: line.startAngle!,
            endAngle: line.endAngle!,
          ).createShader(rect)
          ..style = PaintingStyle.stroke
          ..strokeWidth = line.width
          ..strokeCap = StrokeCap.round;
        
        canvas.drawArc(
          rect, 
          line.startAngle!, 
          line.endAngle! - line.startAngle!, 
          false, 
          paint
        );
      } else {
        // 绘制直线
        final paint = Paint()
          ..shader = LinearGradient(
            colors: [line.color1, line.color2],
          ).createShader(Rect.fromPoints(line.start!, line.end!))
          ..style = PaintingStyle.stroke
          ..strokeWidth = line.width
          ..strokeCap = StrokeCap.round;
        
        canvas.drawLine(line.start!, line.end!, paint);
      }
    }
  }

  @override
  bool shouldRepaint(LinesPainter oldDelegate) => false;
}

class StaticBubblePainter extends CustomPainter {
  final List<StaticBubble> bubbles;
  
  StaticBubblePainter(this.bubbles);
  
  @override
  void paint(Canvas canvas, Size size) {
    for (var bubble in bubbles) {
      // 绘制静态气泡
      final gradient = RadialGradient(
        colors: [
          bubble.color.withOpacity(0),
          bubble.color.withOpacity(bubble.opacity * 0.5),
          bubble.color.withOpacity(bubble.opacity)
        ],
        stops: const [0.7, 0.85, 1.0],
      );
      
      final paint = Paint()
        ..shader = gradient.createShader(
          Rect.fromCircle(center: bubble.position, radius: bubble.radius),
        )
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(bubble.position, bubble.radius, paint);
      
      // 添加高光效果 - 使用随机生成的高光位置
      if (bubble.radius > 10) { // 只给较大的气泡添加高光，避免小气泡看起来奇怪
        // 使用气泡中心点加上随机偏移量作为高光位置
        final highlightPosition = Offset(
          bubble.position.dx + bubble.highlightOffset.dx,
          bubble.position.dy + bubble.highlightOffset.dy
        );
        
        // 确保高光圆的半径适当
        final highlightRadius = bubble.radius * 0.4;
        
        final highlightPaint = Paint()
          ..color = Colors.white.withOpacity(bubble.opacity * 1.2)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;
        
        // 绘制高光
        canvas.drawCircle(
          highlightPosition,
          highlightRadius,
          highlightPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(StaticBubblePainter oldDelegate) => false;
}

class BubblePainter extends CustomPainter {
  final List<Bubble> bubbles;
  
  BubblePainter(this.bubbles);
  
  @override
  void paint(Canvas canvas, Size size) {
    for (final bubble in bubbles) {
      // 创建气泡外部光晕
      final outerGlow = Paint()
        ..color = bubble.color.withOpacity(0.1)
        ..style = PaintingStyle.fill
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8);
      
      canvas.drawCircle(
        bubble.position, 
        bubble.radius + 4, 
        outerGlow
      );
      
      // 绘制气泡主体
      final gradient = RadialGradient(
        colors: [
          bubble.color.withOpacity(0),
          bubble.color.withOpacity(bubble.opacity * 0.3),
          bubble.color.withOpacity(bubble.opacity)
        ],
        stops: const [0.8, 0.9, 1.0],
      );
      
      final shader = gradient.createShader(
        Rect.fromCircle(center: bubble.position, radius: bubble.radius),
      );
      
      final paint = Paint()
        ..shader = shader
        ..style = PaintingStyle.fill;
      
      canvas.drawCircle(bubble.position, bubble.radius, paint);
      
      // 添加气泡边缘高光效果 - 使用随机生成的高光位置
      if (bubble.radius > 10) { // 只给较大的气泡添加高光
        // 确保高光圆的半径适当 - 减小高光区域大小以避免溢出
        final highlightRadius = bubble.radius * 0.4;
        
        // 计算高光位置的最大偏移距离，确保高光气泡不会超出主气泡
        // 主气泡半径 - 高光气泡半径 = 最大可能偏移距离
        final maxOffset = bubble.radius - highlightRadius;
        
        // 如果highlightOffset的长度超过了最大偏移，则进行缩放
        double offsetLength = sqrt(pow(bubble.highlightOffset.dx, 2) + pow(bubble.highlightOffset.dy, 2));
        Offset adjustedOffset = bubble.highlightOffset;
        if (offsetLength > maxOffset) {
          // 按比例缩小偏移量
          double scale = maxOffset / offsetLength;
          adjustedOffset = Offset(
            bubble.highlightOffset.dx * scale,
            bubble.highlightOffset.dy * scale
          );
        }
        
        // 使用气泡中心点加上调整后的偏移量作为高光位置
        final highlightPosition = Offset(
          bubble.position.dx + adjustedOffset.dx,
          bubble.position.dy + adjustedOffset.dy
        );
        
        final highlightPaint = Paint()
          ..color = Colors.white.withOpacity(0.2)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0;
        
        canvas.drawCircle(
          highlightPosition,
          highlightRadius,
          highlightPaint,
        );
        
        // 添加内部反光高光点 - 放在高光区域的中心位置
        if (bubble.radius > 15) { // 只给足够大的气泡添加高光点
          // 使用高光区域的中心位置作为高光点位置
          final dotPosition = highlightPosition;
          
          // 确保高光点的半径适当
          final dotRadius = bubble.radius * 0.08;
          
          final highlightDot = Paint()
            ..color = Colors.white
            ..style = PaintingStyle.fill;
          
          canvas.drawCircle(
            dotPosition, 
            dotRadius, 
            highlightDot
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(BubblePainter oldDelegate) => true;
}