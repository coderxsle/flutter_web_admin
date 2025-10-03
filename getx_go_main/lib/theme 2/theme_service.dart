import 'package:get_storage/get_storage.dart';
import 'theme_config.dart';

class ThemeService {
  // 存储键名
  static const String themeTypeKey = 'app_theme_type';
  static const String themeModeKey = 'app_theme_mode';
  
  // 获取存储实例
  final _box = GetStorage();
  
  // 保存主题类型
  Future<void> saveThemeType(AppThemeType type) async {
    await _box.write(themeTypeKey, type.index);
  }
  
  // 获取主题类型
  AppThemeType getThemeType() {
    final index = _box.read<int>(themeTypeKey);
    if (index != null && index >= 0 && index < AppThemeType.values.length) {
      return AppThemeType.values[index];
    }
    return AppThemeType.system; // 默认使用系统主题
  }
  
  // 保存主题模式
  Future<void> saveThemeMode(AppThemeMode mode) async {
    await _box.write(themeModeKey, mode.index);
  }
  
  // 获取主题模式
  AppThemeMode getThemeMode() {
    final index = _box.read<int>(themeModeKey);
    if (index != null && index >= 0 && index < AppThemeMode.values.length) {
      return AppThemeMode.values[index];
    }
    return AppThemeMode.light; // 默认使用浅色模式
  }
} 