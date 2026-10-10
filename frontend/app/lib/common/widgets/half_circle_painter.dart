import 'dart:math';

import 'package:flutter/material.dart';

///@description 要创建具有两侧半圆形状的Container
///@updateTime 2024/11/24 9:16
class HalfCirclePainter extends CustomPainter {
  final Axis direction;

  HalfCirclePainter({this.direction = Axis.vertical});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue;
    final rect = direction == Axis.vertical
        ? Rect.fromLTWH(0.0, 0.0, size.width, size.height / 2)
        : Rect.fromLTWH(
            0.0,
            0.0,
            size.width / 2,
            size.height,
          );

    canvas.drawArc(rect, -pi / 2, pi, true, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
