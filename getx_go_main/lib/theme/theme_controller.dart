import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/color_schemes.dart';
import 'themes/light_theme.dart';
import 'themes/dark_theme.dart';
import 'theme_service.dart';

// 主题控制器
// 用于管理主题设置和状态
class ThemeController extends GetxController {
  final ThemeService _themeService = ThemeService();

  // 响应式变量
  final Rx<ColorSchemeType> currentColorScheme = ColorSchemeType.blue.obs;
  final RxBool isDarkMode = false.obs;

  // 计算属性：当前主题数据
  ThemeData get themeData {
    if (isDarkMode.value) {
      return DarkTheme.generate(currentColorScheme.value);
    } else {
      return LightTheme.generate(currentColorScheme.value);
    }
  }

  @override
  void onInit() {
    super.onInit();
    // 从存储中加载主题设置
    _loadThemeSettings();
  }

  // 加载主题设置
  void _loadThemeSettings() {
    final savedColorScheme = _themeService.getColorScheme();
    final savedDarkMode = _themeService.getDarkMode();

    currentColorScheme.value = savedColorScheme;
    isDarkMode.value = savedDarkMode;

    // 初始化时应用主题
    update();
  }

  // 切换明暗模式
  Future<void> toggleThemeMode() async {
    isDarkMode.value = !isDarkMode.value;
    await _themeService.saveDarkMode(isDarkMode.value);
    update();
  }

  // 设置明暗模式
  Future<void> setThemeMode(bool dark) async {
    isDarkMode.value = dark;
    await _themeService.saveDarkMode(isDarkMode.value);
    update();
  }

  // 更改颜色方案
  Future<void> changeColorScheme(ColorSchemeType scheme) async {
    currentColorScheme.value = scheme;
    await _themeService.saveColorScheme(scheme);
    update();
  }

  // 获取所有可用颜色方案
  List<ColorSchemeType> get availableColorSchemes => ColorSchemeType.values;

  // 获取颜色方案名称
  String getColorSchemeName(ColorSchemeType type) {
    switch (type) {
      case ColorSchemeType.blue:
        return 'Arco Blue';
      case ColorSchemeType.purple:
        return 'Purple';
      case ColorSchemeType.green:
        return 'Green';
    }
  }

  // 获取颜色方案预览颜色
  Color getColorSchemeColor(ColorSchemeType type) {
    final colorScheme = AppColorScheme.fromType(type, false);
    return colorScheme.primary;
  }
}
