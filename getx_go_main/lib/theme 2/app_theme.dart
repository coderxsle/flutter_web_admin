
import 'package:get/get.dart';
import 'theme_config.dart';
import 'theme_controller.dart';

class AppTheme {

  // 是否是暗黑模式
  static bool isDarkMode () {
    final controller = Get.find<ThemeController>();
    return controller.currentThemeMode.value == AppThemeMode.dark;
  }

  // 切换明暗模式
  static void toggleThemeMode () {
    final controller = Get.find<ThemeController>();
    controller.toggleThemeMode();
  }

  // 获取当前主题模式
  static AppThemeMode themeMode () {
    final controller = Get.find<ThemeController>();
    return controller.currentThemeMode.value;
  }
  
}
