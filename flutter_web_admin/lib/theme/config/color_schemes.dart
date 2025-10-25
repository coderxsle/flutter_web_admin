import 'package:flutter/material.dart';
import 'theme_colors.dart';

/// 颜色方案类型
enum ColorSchemeType {
  blue,   // Arco Blue (默认蓝色)
  purple, // 紫色
  green,  // 绿色
}

/// 颜色方案扩展 - 包含所有语义化颜色
class AppColorScheme extends ThemeExtension<AppColorScheme> {
  // ================================================
  // 主要颜色
  // ================================================
  final Color primary;        // 主色
  final Color primaryHover;   // 主色悬停
  final Color primaryActive;  // 主色激活
  final Color primaryDisabled;// 主色禁用

  // ================================================
  // 功能色
  // ================================================
  final Color success;        // 成功色
  final Color warning;        // 警告色
  final Color danger;         // 危险色
  final Color info;           // 信息色
  final Color link;           // 链接色

  // ================================================
  // 背景色 (Background)
  // ================================================
  final Color bgContainer;    // 容器背景
  final Color bgLayout;       // 布局背景
  final Color bgElevated;     // 悬浮容器背景
  final Color bgMask;         // 遮罩背景
  final Color bgSpotlight;    // 聚光灯背景

  // ================================================
  // 文本色 (Text)
  // ================================================
  final Color textPrimary;    // 主要文本
  final Color textSecondary;  // 次要文本
  final Color textTertiary;   // 第三级文本
  final Color textDisabled;   // 禁用文本

  // ================================================
  // 边框色 (Border)
  // ================================================
  final Color borderDefault;  // 默认边框
  final Color borderLight;    // 浅色边框
  final Color borderDark;     // 深色边框

  // ================================================
  // 填充色 (Fill)
  // ================================================
  final Color fillDefault;    // 默认填充
  final Color fillHover;      // 悬停填充
  final Color fillActive;     // 激活填充
  final Color fillDisabled;   // 禁用填充

  const AppColorScheme({
    required this.primary,
    required this.primaryHover,
    required this.primaryActive,
    required this.primaryDisabled,
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
    required this.link,
    required this.bgContainer,
    required this.bgLayout,
    required this.bgElevated,
    required this.bgMask,
    required this.bgSpotlight,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.borderDefault,
    required this.borderLight,
    required this.borderDark,
    required this.fillDefault,
    required this.fillHover,
    required this.fillActive,
    required this.fillDisabled,
  });

  @override
  AppColorScheme copyWith({
    Color? primary,
    Color? primaryHover,
    Color? primaryActive,
    Color? primaryDisabled,
    Color? success,
    Color? warning,
    Color? danger,
    Color? info,
    Color? link,
    Color? bgContainer,
    Color? bgLayout,
    Color? bgElevated,
    Color? bgMask,
    Color? bgSpotlight,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textDisabled,
    Color? borderDefault,
    Color? borderLight,
    Color? borderDark,
    Color? fillDefault,
    Color? fillHover,
    Color? fillActive,
    Color? fillDisabled,
  }) {
    return AppColorScheme(
      primary: primary ?? this.primary,
      primaryHover: primaryHover ?? this.primaryHover,
      primaryActive: primaryActive ?? this.primaryActive,
      primaryDisabled: primaryDisabled ?? this.primaryDisabled,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      danger: danger ?? this.danger,
      info: info ?? this.info,
      link: link ?? this.link,
      bgContainer: bgContainer ?? this.bgContainer,
      bgLayout: bgLayout ?? this.bgLayout,
      bgElevated: bgElevated ?? this.bgElevated,
      bgMask: bgMask ?? this.bgMask,
      bgSpotlight: bgSpotlight ?? this.bgSpotlight,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textDisabled: textDisabled ?? this.textDisabled,
      borderDefault: borderDefault ?? this.borderDefault,
      borderLight: borderLight ?? this.borderLight,
      borderDark: borderDark ?? this.borderDark,
      fillDefault: fillDefault ?? this.fillDefault,
      fillHover: fillHover ?? this.fillHover,
      fillActive: fillActive ?? this.fillActive,
      fillDisabled: fillDisabled ?? this.fillDisabled,
    );
  }

  @override
  AppColorScheme lerp(ThemeExtension<AppColorScheme>? other, double t) {
    if (other is! AppColorScheme) return this;
    return AppColorScheme(
      primary: Color.lerp(primary, other.primary, t)!,
      primaryHover: Color.lerp(primaryHover, other.primaryHover, t)!,
      primaryActive: Color.lerp(primaryActive, other.primaryActive, t)!,
      primaryDisabled: Color.lerp(primaryDisabled, other.primaryDisabled, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      info: Color.lerp(info, other.info, t)!,
      link: Color.lerp(link, other.link, t)!,
      bgContainer: Color.lerp(bgContainer, other.bgContainer, t)!,
      bgLayout: Color.lerp(bgLayout, other.bgLayout, t)!,
      bgElevated: Color.lerp(bgElevated, other.bgElevated, t)!,
      bgMask: Color.lerp(bgMask, other.bgMask, t)!,
      bgSpotlight: Color.lerp(bgSpotlight, other.bgSpotlight, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      borderDefault: Color.lerp(borderDefault, other.borderDefault, t)!,
      borderLight: Color.lerp(borderLight, other.borderLight, t)!,
      borderDark: Color.lerp(borderDark, other.borderDark, t)!,
      fillDefault: Color.lerp(fillDefault, other.fillDefault, t)!,
      fillHover: Color.lerp(fillHover, other.fillHover, t)!,
      fillActive: Color.lerp(fillActive, other.fillActive, t)!,
      fillDisabled: Color.lerp(fillDisabled, other.fillDisabled, t)!,
    );
  }

  // ================================================
  // 明亮模式颜色方案工厂方法
  // ================================================

  /// Arco Blue 明亮模式
  static AppColorScheme lightBlue() {
    return const AppColorScheme(
      primary: ArcoColors.blue6,
      primaryHover: ArcoColors.blue5,
      primaryActive: ArcoColors.blue7,
      primaryDisabled: ArcoColors.blue3,
      success: ArcoColors.success6,
      warning: ArcoColors.warning6,
      danger: ArcoColors.danger6,
      info: ArcoColors.info6,
      link: ArcoColors.blue6,
      bgContainer: ArcoColors.white,
      bgLayout: ArcoColors.lightGray2,
      bgElevated: ArcoColors.white,
      bgMask: ArcoColors.black,
      bgSpotlight: ArcoColors.lightGray3,
      textPrimary: ArcoColors.lightGray11,
      textSecondary: ArcoColors.lightGray9,
      textTertiary: ArcoColors.lightGray7,
      textDisabled: ArcoColors.lightGray5,
      borderDefault: ArcoColors.lightGray4,
      borderLight: ArcoColors.lightGray5,
      borderDark: ArcoColors.lightGray6,
      fillDefault: ArcoColors.lightGray2,
      fillHover: ArcoColors.lightGray5,
      fillActive: ArcoColors.lightGray4,
      fillDisabled: ArcoColors.lightGray2,
    );
  }

  /// Purple 明亮模式
  static AppColorScheme lightPurple() {
    return const AppColorScheme(
      primary: ArcoColors.purple6,
      primaryHover: ArcoColors.purple5,
      primaryActive: ArcoColors.purple7,
      primaryDisabled: ArcoColors.purple3,
      success: ArcoColors.success6,
      warning: ArcoColors.warning6,
      danger: ArcoColors.danger6,
      info: ArcoColors.info6,
      link: ArcoColors.purple6,
      bgContainer: ArcoColors.white,
      bgLayout: ArcoColors.lightGray2,
      bgElevated: ArcoColors.white,
      bgMask: ArcoColors.black,
      bgSpotlight: ArcoColors.lightGray3,
      textPrimary: ArcoColors.lightGray11,
      textSecondary: ArcoColors.lightGray9,
      textTertiary: ArcoColors.lightGray7,
      textDisabled: ArcoColors.lightGray5,
      borderDefault: ArcoColors.lightGray4,
      borderLight: ArcoColors.lightGray5,
      borderDark: ArcoColors.lightGray6,
      fillDefault: ArcoColors.lightGray2,
      fillHover: ArcoColors.lightGray5,
      fillActive: ArcoColors.lightGray4,
      fillDisabled: ArcoColors.lightGray2,
    );
  }

  /// Green 明亮模式
  static AppColorScheme lightGreen() {
    return const AppColorScheme(
      primary: ArcoColors.green6,
      primaryHover: ArcoColors.green5,
      primaryActive: ArcoColors.green7,
      primaryDisabled: ArcoColors.green3,
      success: ArcoColors.success6,
      warning: ArcoColors.warning6,
      danger: ArcoColors.danger6,
      info: ArcoColors.info6,
      link: ArcoColors.green6,
      bgContainer: ArcoColors.white,
      bgLayout: ArcoColors.lightGray2,
      bgElevated: ArcoColors.white,
      bgMask: ArcoColors.black,
      bgSpotlight: ArcoColors.lightGray3,
      textPrimary: ArcoColors.lightGray11,
      textSecondary: ArcoColors.lightGray9,
      textTertiary: ArcoColors.lightGray7,
      textDisabled: ArcoColors.lightGray5,
      borderDefault: ArcoColors.lightGray4,
      borderLight: ArcoColors.lightGray5,
      borderDark: ArcoColors.lightGray6,
      fillDefault: ArcoColors.lightGray2,
      fillHover: ArcoColors.lightGray5,
      fillActive: ArcoColors.lightGray4,
      fillDisabled: ArcoColors.lightGray2,
    );
  }

  // ================================================
  // 黑暗模式颜色方案工厂方法
  // ================================================

  /// Arco Blue 黑暗模式
  static AppColorScheme darkBlue() {
    return const AppColorScheme(
      primary: ArcoColors.blue6,
      primaryHover: ArcoColors.blue5,
      primaryActive: ArcoColors.blue7,
      primaryDisabled: ArcoColors.blue8,
      success: ArcoColors.success6,
      warning: ArcoColors.warning6,
      danger: ArcoColors.danger6,
      info: ArcoColors.info6,
      link: ArcoColors.blue5,
      bgContainer: ArcoColors.darkGray1,
      bgLayout: ArcoColors.darkGray2,
      bgElevated: ArcoColors.darkGray3,
      bgMask: ArcoColors.black,
      bgSpotlight: ArcoColors.darkGray4,
      textPrimary: ArcoColors.darkGray10,
      textSecondary: ArcoColors.darkGray8,
      textTertiary: ArcoColors.darkGray6,
      textDisabled: ArcoColors.darkGray5,
      borderDefault: ArcoColors.darkGray4,
      borderLight: ArcoColors.darkGray3,
      borderDark: ArcoColors.darkGray6,
      fillDefault: ArcoColors.darkGray2,
      fillHover: ArcoColors.darkGray3,
      fillActive: ArcoColors.darkGray4,
      fillDisabled: ArcoColors.darkGray2,
    );
  }

  /// Purple 黑暗模式
  static AppColorScheme darkPurple() {
    return const AppColorScheme(
      primary: ArcoColors.purple6,
      primaryHover: ArcoColors.purple5,
      primaryActive: ArcoColors.purple7,
      primaryDisabled: ArcoColors.purple8,
      success: ArcoColors.success6,
      warning: ArcoColors.warning6,
      danger: ArcoColors.danger6,
      info: ArcoColors.info6,
      link: ArcoColors.purple5,
      bgContainer: ArcoColors.darkGray1,
      bgLayout: ArcoColors.darkGray2,
      bgElevated: ArcoColors.darkGray3,
      bgMask: Color(0x80000000),
      bgSpotlight: ArcoColors.darkGray4,
      textPrimary: ArcoColors.darkGray10,
      textSecondary: ArcoColors.darkGray8,
      textTertiary: ArcoColors.darkGray6,
      textDisabled: ArcoColors.darkGray5,
      borderDefault: ArcoColors.darkGray4,
      borderLight: ArcoColors.darkGray3,
      borderDark: ArcoColors.darkGray6,
      fillDefault: ArcoColors.darkGray2,
      fillHover: ArcoColors.darkGray3,
      fillActive: ArcoColors.darkGray4,
      fillDisabled: ArcoColors.darkGray2,
    );
  }

  /// Green 黑暗模式
  static AppColorScheme darkGreen() {
    return const AppColorScheme(
      primary: ArcoColors.green6,
      primaryHover: ArcoColors.green5,
      primaryActive: ArcoColors.green7,
      primaryDisabled: ArcoColors.green8,
      success: ArcoColors.success6,
      warning: ArcoColors.warning6,
      danger: ArcoColors.danger6,
      info: ArcoColors.info6,
      link: ArcoColors.green5,
      bgContainer: ArcoColors.darkGray1,
      bgLayout: ArcoColors.darkGray2,
      bgElevated: ArcoColors.darkGray3,
      bgMask: ArcoColors.black,
      bgSpotlight: ArcoColors.darkGray4,
      textPrimary: ArcoColors.darkGray10,
      textSecondary: ArcoColors.darkGray8,
      textTertiary: ArcoColors.darkGray6,
      textDisabled: ArcoColors.darkGray5,
      borderDefault: ArcoColors.darkGray4,
      borderLight: ArcoColors.darkGray3,
      borderDark: ArcoColors.darkGray6,
      fillDefault: ArcoColors.darkGray2,
      fillHover: ArcoColors.darkGray3,
      fillActive: ArcoColors.darkGray4,
      fillDisabled: ArcoColors.darkGray2,
    );
  }

  /// 根据颜色方案类型和模式获取颜色方案
  static AppColorScheme fromType(ColorSchemeType type, bool isDark) {
    if (isDark) {
      switch (type) {
        case ColorSchemeType.blue:
          return darkBlue();
        case ColorSchemeType.purple:
          return darkPurple();
        case ColorSchemeType.green:
          return darkGreen();
      }
    } else {
      switch (type) {
        case ColorSchemeType.blue:
          return lightBlue();
        case ColorSchemeType.purple:
          return lightPurple();
        case ColorSchemeType.green:
          return lightGreen();
      }
    }
  }
}
