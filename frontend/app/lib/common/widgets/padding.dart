import 'package:flutter/material.dart';

class ScaleEdgeInsets {
  static double _scaleFactor(BuildContext context) {
    // 使用屏幕宽度作为基准，假设设计图的基准宽度为 375
    double baseWidth = 375.0;
    double screenWidth = MediaQuery.of(context).size.width;
    return screenWidth / baseWidth;
  }

  static EdgeInsets all(BuildContext context, double value) {
    double scaleFactor = _scaleFactor(context);
    return EdgeInsets.all(value * scaleFactor);
  }

  static EdgeInsets symmetric({
    required BuildContext context,
    double horizontal = 0,
    double vertical = 0,
  }) {
    double scaleFactor = _scaleFactor(context);
    return EdgeInsets.symmetric(
      horizontal: horizontal * scaleFactor,
      vertical: vertical * scaleFactor,
    );
  }

  static EdgeInsets only({
    required BuildContext context,
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    double scaleFactor = _scaleFactor(context);
    return EdgeInsets.only(
      left: left * scaleFactor,
      top: top * scaleFactor,
      right: right * scaleFactor,
      bottom: bottom * scaleFactor,
    );
  }

  static EdgeInsets fromLTRB(
      BuildContext context,
      double left,
      double top,
      double right,
      double bottom,
      ) {
    double scaleFactor = _scaleFactor(context);
    return EdgeInsets.fromLTRB(
      left * scaleFactor,
      top * scaleFactor,
      right * scaleFactor,
      bottom * scaleFactor,
    );
  }
}