import 'package:flutter/material.dart';

/// 应用颜色管理类
/// 集中管理所有应用颜色，避免硬编码颜色值
class AppColors {
  // 防止实例化
  AppColors._();

  // 主题颜色
  static const Color primary = Color(0xFF0078D4);
  static const Color secondary = Color(0xFF268CDC);
  static const Color accent = Color(0xFF005A9E);
  
  // 背景颜色
  static const Color background = Colors.white;
  static const Color cardBackground = Colors.white;
  static const Color scaffoldBackground = Colors.white;
  
  // 文本颜色
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);
  static const Color textHint = Color(0xFF999999);
  
  // 边框和分割线
  static const Color divider = Color(0xFFEEEEEE);
  static const Color border = Color(0xFFDDDDDD);
  
  // 状态颜色
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);
  
  // 其他常用颜色
  static const Color disabled = Color(0xFFBDBDBD);
  static const Color shadow = Color(0x1A000000); // 10% 透明度的黑色
} 