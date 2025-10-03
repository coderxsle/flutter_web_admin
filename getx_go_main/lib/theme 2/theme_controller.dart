import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_theme.dart';
import 'theme_config.dart';
import 'theme_service.dart';

class ThemeController extends GetxController {
  final ThemeService _themeService = ThemeService();
  final ThemeConfig _themeConfig = ThemeConfig();
  
  // 响应式变量
  final Rx<AppThemeType> currentThemeType = AppThemeType.system.obs;
  final Rx<AppThemeMode> currentThemeMode = AppThemeMode.light.obs;
  
  // 计算属性：当前主题数据
  ThemeData get themeData => _themeConfig.getThemeData(
    currentThemeType.value, 
    currentThemeMode.value
  );
  
  @override
  void onInit() {
    super.onInit();
    // 从存储中加载主题设置
    loadThemeSettings();
  }
  
  // 加载主题设置
  void loadThemeSettings() {
    final savedType = _themeService.getThemeType();
    final savedMode = _themeService.getThemeMode();
    
    currentThemeType.value = savedType;
    currentThemeMode.value = savedMode;
    
    // 初始化时应用主题
    updateAppTheme();
  }
  
  // 更新应用主题
  void updateAppTheme() {
    try {
      // 获取当前主题数据
      final newTheme = themeData;
      // 尝试使用GetMaterialApp的更新机制来更新主题
      Get.changeTheme(newTheme);
      // 强制更新，确保UI刷新
      update();
    } catch (e) {
      // 如果出现"GetRoot is not part of the three"错误，这里会捕获它
      // 但我们仍然需要确保UI更新
      // debugPrint('主题更新时发生错误: $e');
      // 尝试使用update强制刷新UI
      // update();
    }
  }
  
  // 更改主题类型
  Future<void> changeThemeType(AppThemeType type) async {
    currentThemeType.value = type;
    await _themeService.saveThemeType(type);
    updateAppTheme(); // 使用新方法更新主题
  }
  
  // 更改主题模式（浅色/深色）
  Future<void> _changeThemeMode(AppThemeMode mode) async {
    currentThemeMode.value = mode;
    await _themeService.saveThemeMode(mode);
    updateAppTheme(); // 使用新方法更新主题
  }
  
  // 切换浅色/深色模式
  Future<void> toggleThemeMode() async {
    final newMode = AppTheme.isDarkMode() ? AppThemeMode.light : AppThemeMode.dark;
    await _changeThemeMode(newMode);
  }
  
  // 获取所有可用主题类型
  List<AppThemeType> get availableThemeTypes => AppThemeType.values;

  ThemeData? get lightTheme => null;

  get themeMode => null;
  
  // 获取主题类型名称
  String getThemeTypeName(AppThemeType type) {
    switch (type) {
      case AppThemeType.system:
        return '系统';
      case AppThemeType.blue:
        return '蓝色';
      case AppThemeType.green:
        return '绿色';
      case AppThemeType.purple:
        return '紫色';
      }
  }
  
  // 获取主题类型颜色
  Color getThemeTypeColor(AppThemeType type) {
    switch (type) {
      case AppThemeType.system:
        return Colors.grey;
      case AppThemeType.blue:
        return Colors.blue;
      case AppThemeType.green:
        return Colors.green;
      case AppThemeType.purple:
        return Colors.purple;
      }
  }
} 