import 'package:flutter/material.dart';
import '../config/color_schemes.dart';

/// BuildContext 扩展，方便访问主题颜色
extension ThemeExtensions on BuildContext {
  /// 获取当前主题的颜色方案
  AppColorScheme get themeColors {
    final extension = Theme.of(this).extension<AppColorScheme>();
    if (extension == null) {
      throw Exception('AppColorScheme not found in theme. Make sure to add it to ThemeData.extensions');
    }
    return extension;
  }

  /// 判断是否为暗色模式
  bool get isDarkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }

  /// 获取主题数据
  ThemeData get theme {
    return Theme.of(this);
  }

  /// 获取文本主题
  TextTheme get textTheme {
    return Theme.of(this).textTheme;
  }

  /// 获取颜色方案
  ColorScheme get colorScheme {
    return Theme.of(this).colorScheme;
  }
}
