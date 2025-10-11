import 'package:flutter/material.dart';
import 'theme_tokens.dart';
import 'font_config.dart';

/// 排版配置
/// 基于 Material Design 3 的排版规范，结合自定义字体配置
class TypographyConfig {
  TypographyConfig._();

  // ================================================
  // 显示级别文本样式 (Display)
  // ================================================
  
  /// Display Large - 用于超大标题
  static TextStyle displayLarge({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.primaryFont,
      fontFamilyFallback: FontConfig.defaultFontFallback,
      fontSize: ThemeTokens.fontSize5Xl,
      fontWeight: FontWeight.w700,
      height: ThemeTokens.lineHeightTight,
      letterSpacing: -0.5,
      color: color,
    );
  }

  /// Display Medium - 用于大标题
  static TextStyle displayMedium({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.primaryFont,
      fontFamilyFallback: FontConfig.defaultFontFallback,
      fontSize: ThemeTokens.fontSize4Xl,
      fontWeight: FontWeight.w700,
      height: ThemeTokens.lineHeightTight,
      letterSpacing: -0.25,
      color: color,
    );
  }

  /// Display Small - 用于标题
  static TextStyle displaySmall({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.primaryFont,
      fontFamilyFallback: FontConfig.defaultFontFallback,
      fontSize: ThemeTokens.fontSize3Xl,
      fontWeight: FontWeight.w700,
      height: ThemeTokens.lineHeightTight,
      letterSpacing: 0,
      color: color,
    );
  }

  // ================================================
  // 标题级别文本样式 (Headline)
  // ================================================
  
  /// Headline Large - 用于页面主标题
  static TextStyle headlineLarge({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.primaryFont,
      fontFamilyFallback: FontConfig.defaultFontFallback,
      fontSize: ThemeTokens.fontSize2Xl,
      fontWeight: FontWeight.w600,
      height: ThemeTokens.lineHeightNormal,
      letterSpacing: 0,
      color: color,
    );
  }

  /// Headline Medium - 用于区域标题
  static TextStyle headlineMedium({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.primaryFont,
      fontFamilyFallback: FontConfig.defaultFontFallback,
      fontSize: ThemeTokens.fontSizeXl,
      fontWeight: FontWeight.w600,
      height: ThemeTokens.lineHeightNormal,
      letterSpacing: 0,
      color: color,
    );
  }

  /// Headline Small - 用于小标题
  static TextStyle headlineSmall({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.primaryFont,
      fontFamilyFallback: FontConfig.defaultFontFallback,
      fontSize: ThemeTokens.fontSizeLg,
      fontWeight: FontWeight.w600,
      height: ThemeTokens.lineHeightNormal,
      letterSpacing: 0,
      color: color,
    );
  }

  // ================================================
  // 标题文本样式 (Title)
  // ================================================
  
  /// Title Large - 用于卡片标题、对话框标题
  static TextStyle titleLarge({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.primaryFont,
      fontFamilyFallback: FontConfig.defaultFontFallback,
      fontSize: ThemeTokens.fontSizeLg,
      fontWeight: FontWeight.w500,
      height: ThemeTokens.lineHeightNormal,
      letterSpacing: 0,
      color: color,
    );
  }

  /// Title Medium - 用于列表标题
  static TextStyle titleMedium({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.primaryFont,
      fontFamilyFallback: FontConfig.defaultFontFallback,
      fontSize: ThemeTokens.fontSizeMd,
      fontWeight: FontWeight.w500,
      height: ThemeTokens.lineHeightNormal,
      letterSpacing: 0.15,
      color: color,
    );
  }

  /// Title Small - 用于小标题
  static TextStyle titleSmall({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.primaryFont,
      fontFamilyFallback: FontConfig.defaultFontFallback,
      fontSize: ThemeTokens.fontSizeSm,
      fontWeight: FontWeight.w500,
      height: ThemeTokens.lineHeightNormal,
      letterSpacing: 0.1,
      color: color,
    );
  }

  // ================================================
  // 正文文本样式 (Body)
  // ================================================
  
  /// Body Large - 用于长文本、段落
  static TextStyle bodyLarge({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.primaryFont,
      fontFamilyFallback: FontConfig.defaultFontFallback,
      fontSize: ThemeTokens.fontSizeMd,
      fontWeight: FontWeight.w400,
      height: ThemeTokens.lineHeightRelaxed,
      letterSpacing: 0.5,
      color: color,
    );
  }

  /// Body Medium - 用于正文
  static TextStyle bodyMedium({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.primaryFont,
      fontFamilyFallback: FontConfig.defaultFontFallback,
      fontSize: ThemeTokens.fontSizeSm,
      fontWeight: FontWeight.w400,
      height: ThemeTokens.lineHeightRelaxed,
      letterSpacing: 0.25,
      color: color,
    );
  }

  /// Body Small - 用于辅助文本
  static TextStyle bodySmall({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.primaryFont,
      fontFamilyFallback: FontConfig.defaultFontFallback,
      fontSize: ThemeTokens.fontSizeXs,
      fontWeight: FontWeight.w400,
      height: ThemeTokens.lineHeightNormal,
      letterSpacing: 0.4,
      color: color,
    );
  }

  // ================================================
  // 标签文本样式 (Label)
  // ================================================
  
  /// Label Large - 用于按钮文本、Tab 标签
  static TextStyle labelLarge({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.primaryFont,
      fontFamilyFallback: FontConfig.defaultFontFallback,
      fontSize: ThemeTokens.fontSizeSm,
      fontWeight: FontWeight.w500,
      height: ThemeTokens.lineHeightNormal,
      letterSpacing: 0.1,
      color: color,
    );
  }

  /// Label Medium - 用于小按钮、芯片
  static TextStyle labelMedium({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.primaryFont,
      fontFamilyFallback: FontConfig.defaultFontFallback,
      fontSize: ThemeTokens.fontSizeXs,
      fontWeight: FontWeight.w500,
      height: ThemeTokens.lineHeightNormal,
      letterSpacing: 0.5,
      color: color,
    );
  }

  /// Label Small - 用于标签、提示文本
  static TextStyle labelSmall({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.primaryFont,
      fontFamilyFallback: FontConfig.defaultFontFallback,
      fontSize: ThemeTokens.fontSizeXs,
      fontWeight: FontWeight.w500,
      height: ThemeTokens.lineHeightNormal,
      letterSpacing: 0.5,
      color: color,
    );
  }

  // ================================================
  // 特殊文本样式
  // ================================================
  
  /// 代码文本样式
  static TextStyle code({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.monoFont,
      fontFamilyFallback: [FontConfig.primaryFont],
      fontSize: ThemeTokens.fontSizeSm,
      fontWeight: FontWeight.w400,
      height: ThemeTokens.lineHeightRelaxed,
      letterSpacing: 0,
      color: color,
    );
  }

  /// 数字文本样式（表格、数据展示）
  static TextStyle numeric({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.primaryFont,
      fontFamilyFallback: FontConfig.defaultFontFallback,
      fontSize: ThemeTokens.fontSizeSm,
      fontWeight: FontWeight.w500,
      height: ThemeTokens.lineHeightNormal,
      letterSpacing: 0,
      fontFeatures: const [FontFeature.tabularFigures()],
      color: color,
    );
  }

  /// 强调文本样式
  static TextStyle emphasis({Color? color}) {
    return TextStyle(
      fontFamily: FontConfig.primaryFont,
      fontFamilyFallback: FontConfig.defaultFontFallback,
      fontSize: ThemeTokens.fontSizeSm,
      fontWeight: FontWeight.w600,
      height: ThemeTokens.lineHeightNormal,
      letterSpacing: 0,
      color: color,
    );
  }

  // ================================================
  // 构建完整的 TextTheme
  // ================================================
  
  /// 根据颜色构建完整的 TextTheme
  static TextTheme buildTextTheme({
    required Color primaryColor,
    required Color secondaryColor,
    required Color tertiaryColor,
  }) {
    return TextTheme(
      displayLarge: displayLarge(color: primaryColor),
      displayMedium: displayMedium(color: primaryColor),
      displaySmall: displaySmall(color: primaryColor),
      headlineLarge: headlineLarge(color: primaryColor),
      headlineMedium: headlineMedium(color: primaryColor),
      headlineSmall: headlineSmall(color: primaryColor),
      titleLarge: titleLarge(color: primaryColor),
      titleMedium: titleMedium(color: primaryColor),
      titleSmall: titleSmall(color: primaryColor),
      bodyLarge: bodyLarge(color: primaryColor),
      bodyMedium: bodyMedium(color: secondaryColor),
      bodySmall: bodySmall(color: tertiaryColor),
      labelLarge: labelLarge(color: primaryColor),
      labelMedium: labelMedium(color: secondaryColor),
      labelSmall: labelSmall(color: tertiaryColor),
    );
  }
}

