import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/color_schemes.dart';
import 'theme_controller.dart';

/// 应用主题工具类 - 对外暴露的主题 API
class AppTheme {
  AppTheme._();

  // ================================================
  // 主题模式相关
  // ================================================

  /// 是否是暗色模式
  static bool get isDarkMode {
    final controller = Get.find<ThemeController>();
    return controller.isDarkMode.value;
  }

  /// 切换明暗模式
  static Future<void> toggleThemeMode() async {
    final controller = Get.find<ThemeController>();
    await controller.toggleThemeMode();
  }

  /// 设置明暗模式
  static Future<void> setThemeMode(bool dark) async {
    final controller = Get.find<ThemeController>();
    await controller.setThemeMode(dark);
  }

  // ================================================
  // 颜色方案相关
  // ================================================

  /// 获取当前颜色方案
  static ColorSchemeType get currentColorScheme {
    final controller = Get.find<ThemeController>();
    return controller.currentColorScheme.value;
  }

  /// 设置颜色方案
  static Future<void> setColorScheme(ColorSchemeType scheme) async {
    final controller = Get.find<ThemeController>();
    await controller.changeColorScheme(scheme);
  }

  /// 获取所有可用的颜色方案
  static List<ColorSchemeType> get availableColorSchemes {
    final controller = Get.find<ThemeController>();
    return controller.availableColorSchemes;
  }

  /// 获取颜色方案名称
  static String getColorSchemeName(ColorSchemeType type) {
    final controller = Get.find<ThemeController>();
    return controller.getColorSchemeName(type);
  }

  /// 获取颜色方案预览颜色
  static Color getColorSchemeColor(ColorSchemeType type) {
    final controller = Get.find<ThemeController>();
    return controller.getColorSchemeColor(type);
  }

  // ================================================
  // 便捷方法
  // ================================================

  /// 从 BuildContext 获取当前主题的颜色方案
  static AppColorScheme of(BuildContext context) {
    final extension = Theme.of(context).extension<AppColorScheme>();
    if (extension == null) {
      throw Exception(
        'AppColorScheme not found in theme. '
        'Make sure ThemeController is initialized.',
      );
    }
    return extension;
  }
}
