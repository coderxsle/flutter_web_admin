import 'package:get_storage/get_storage.dart';
import 'config/color_schemes.dart';

class ThemeService {
  // 存储键名
  static const String colorSchemeKey = 'app_color_scheme';
  static const String isDarkModeKey = 'app_is_dark_mode';

  // 获取存储实例
  final _box = GetStorage();

  // 保存颜色方案类型
  Future<void> saveColorScheme(ColorSchemeType type) async {
    await _box.write(colorSchemeKey, type.index);
  }

  // 获取颜色方案类型
  ColorSchemeType getColorScheme() {
    final index = _box.read<int>(colorSchemeKey);
    if (index != null && index >= 0 && index < ColorSchemeType.values.length) {
      return ColorSchemeType.values[index];
    }
    return ColorSchemeType.blue; // 默认使用蓝色主题
  }

  // 保存暗色模式状态
  Future<void> saveDarkMode(bool isDark) async {
    await _box.write(isDarkModeKey, isDark);
  }

  // 获取暗色模式状态
  bool getDarkMode() {
    return _box.read<bool>(isDarkModeKey) ?? false; // 默认使用明亮模式
  }
}
