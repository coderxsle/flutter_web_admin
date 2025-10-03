import 'package:flutter/material.dart';

// 主题类型枚举
enum AppThemeType {
  system,   // 系统默认主题
  blue,     // 蓝色主题
  green,    // 绿色主题
  purple,   // 紫色主题
  // 可以根据需要扩展更多主题
}

// 主题模式枚举
enum AppThemeMode {
  light,
  dark,
}

// 主题配置类
class ThemeConfig {
  // 单例模式
  static final ThemeConfig _instance = ThemeConfig._internal();
  factory ThemeConfig() => _instance;
  ThemeConfig._internal();
  
  // 获取特定主题和模式的主题数据
  ThemeData getThemeData(AppThemeType type, AppThemeMode mode) {
    switch (type) {
      case AppThemeType.system:
        return mode == AppThemeMode.light 
            ? _lightTheme 
            : _darkTheme;
      case AppThemeType.blue:
        return mode == AppThemeMode.light 
            ? _blueLightTheme 
            : _blueDarkTheme;
      case AppThemeType.green:
        return mode == AppThemeMode.light 
            ? _greenLightTheme 
            : _greenDarkTheme;
      case AppThemeType.purple:
        return mode == AppThemeMode.light 
            ? _purpleLightTheme 
            : _purpleDarkTheme;
      }
  }
  
  // ================================================
  // 系统默认浅色主题
  // ================================================
  final ThemeData _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.grey.shade100,
    dividerColor: Colors.red,
    canvasColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
      surface: Colors.white,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.red,
      elevation: 0,
    ),
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    textTheme: TextTheme(
      titleMedium: TextStyle(
        color: Colors.black,
      ),
    ),
    // 卡片主题
    cardTheme: CardThemeData(
      elevation: 0, // 阴影
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.black.withValues(alpha: 2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
  
  // 系统默认深色主题
  final ThemeData _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue.shade800,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    iconTheme: IconThemeData(
      color: Colors.white
    ),
    cardTheme: const CardThemeData(
      elevation: 2,
      margin: EdgeInsets.all(8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue.shade700,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue.shade700,
      foregroundColor: Colors.white,
    ),
  );
  



  // ================================================
  // 蓝色浅色主题
  // ================================================
  final ThemeData _blueLightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.blue[50],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
    ),
  );
  
  // 蓝色深色主题
  final ThemeData _blueDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.blue,
    primaryColor: Colors.blue[400],
    scaffoldBackgroundColor: const Color(0xFF0A1929),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blue.shade800,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF102A43),
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue.shade700,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.blue.shade700,
      foregroundColor: Colors.white,
    ),
  );
  


  // ================================================
  // 绿色浅色主题
  // ================================================
  final ThemeData _greenLightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.green,
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.green[50],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.green,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green.shade700,
      foregroundColor: Colors.white,
    ),
  );
  


  // ================================================
  // 绿色深色主题
  // ================================================
  final ThemeData _greenDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.green,
    primaryColor: Colors.green[400],
    scaffoldBackgroundColor: const Color(0xFF0C291A),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green.shade800,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF102C1A),
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.green.shade700,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.green.shade700,
      foregroundColor: Colors.white,
    ),
  );


  // ================================================
  // 紫色浅色主题
  final ThemeData _purpleLightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.purple,
    primaryColor: Colors.purple,
    scaffoldBackgroundColor: Colors.purple[50],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.purple.shade700,
      foregroundColor: Colors.white,
    ),
  );
  
  // 紫色深色主题
  final ThemeData _purpleDarkTheme = ThemeData(
    brightness: Brightness.dark,
    primarySwatch: Colors.purple,
    primaryColor: Colors.purple[400],
    scaffoldBackgroundColor: const Color(0xFF1E0C29),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple.shade800,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardTheme: CardThemeData(
      color: const Color(0xFF2C1040),
      elevation: 2,
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple.shade700,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.purple.shade700,
      foregroundColor: Colors.white,
    ),
  );
} 