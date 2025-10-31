import 'package:flutter/material.dart';
import '../config/color_schemes.dart';
import '../config/theme_tokens.dart';
import '../config/font_config.dart';
import '../config/typography_config.dart';

/// 黑暗模式主题生成器
class DarkTheme {
  /// 生成黑暗模式主题
  static ThemeData generate(ColorSchemeType colorSchemeType) {
    final appColors = AppColorScheme.fromType(colorSchemeType, true);

    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      
      // ================================================
      // 字体配置 - 使用统一的字体配置系统
      // ================================================
      fontFamily: FontConfig.defaultFontFamily,

      // ================================================
      // Text 主题 - 使用统一的排版配置
      // ================================================
      textTheme: TypographyConfig.buildTextTheme(
        primaryColor: appColors.textPrimary,
        secondaryColor: appColors.textSecondary,
        tertiaryColor: appColors.textTertiary,
      ),
      
      // ================================================
      // 颜色方案
      // ================================================
      colorScheme: ColorScheme.dark(
        primary: appColors.primary,
        secondary: appColors.primary,
        surface: appColors.bgContainer,
        error: appColors.danger,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: appColors.textPrimary,
        onError: Colors.white,
      ),
      
      // ================================================
      // 基础颜色
      // ================================================
      primaryColor: appColors.primary,  // 设置 primaryColor 与 colorScheme.primary 一致
      scaffoldBackgroundColor: appColors.bgLayout,
      canvasColor: appColors.bgContainer,
      dividerColor: appColors.borderLight,
      
      // ================================================
      // 交互颜色 (Hover, Splash, Highlight)
      // ================================================
      hoverColor: appColors.fillHover,
      splashColor: appColors.primary.withValues(alpha: 0.15),
      highlightColor: appColors.fillActive,
      focusColor: appColors.primary.withValues(alpha: 0.12),
      
      // ================================================
      // Divider 主题
      // ================================================
      dividerTheme: DividerThemeData(
        color: appColors.borderLight,
        thickness: ThemeTokens.borderWidthThin,
      ),

      // ================================================
      // AppBar 主题
      // ================================================
      appBarTheme: AppBarTheme(
        backgroundColor: appColors.bgContainer,
        foregroundColor: appColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: appColors.textPrimary,
          fontSize: ThemeTokens.fontSizeLg,
          fontWeight: FontWeight.w600,
        ),
        iconTheme: IconThemeData(
          color: appColors.textPrimary,
        ),
      ),

      // ================================================
      // Card 主题
      // ================================================
      cardTheme: CardThemeData(
        color: appColors.bgContainer,
        elevation: ThemeTokens.elevationXs,
        shadowColor: Colors.black.withOpacity(0.3),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeTokens.radiusMd),
          side: BorderSide(
            color: appColors.borderLight,
            width: ThemeTokens.borderWidthThin,
          ),
        ),
        margin: const EdgeInsets.all(ThemeTokens.spacingSm),
      ),

      // ================================================
      // Button 主题
      // ================================================
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: appColors.primary,
          foregroundColor: Colors.white,
          elevation: ThemeTokens.elevationNone,
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeTokens.spacingLg,
            vertical: ThemeTokens.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeTokens.radiusSm),
          ),
          textStyle: const TextStyle(
            fontSize: ThemeTokens.fontSizeSm,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: appColors.primary,
          side: BorderSide(
            color: appColors.borderDefault,
            width: ThemeTokens.borderWidthThin,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeTokens.spacingLg,
            vertical: ThemeTokens.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeTokens.radiusSm),
          ),
          textStyle: const TextStyle(
            fontSize: ThemeTokens.fontSizeSm,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: appColors.primary,
          padding: const EdgeInsets.symmetric(
            horizontal: ThemeTokens.spacingLg,
            vertical: ThemeTokens.spacingMd,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ThemeTokens.radiusSm),
          ),
          textStyle: const TextStyle(
            fontSize: ThemeTokens.fontSizeSm,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // ================================================
      // Input 主题
      // ================================================
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: appColors.bgContainer,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: ThemeTokens.spacingMd,
          vertical: ThemeTokens.spacingMd,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeTokens.radiusSm),
          borderSide: BorderSide(
            color: appColors.borderDefault,
            width: ThemeTokens.borderWidthThin,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeTokens.radiusSm),
          borderSide: BorderSide(
            color: appColors.borderDefault,
            width: ThemeTokens.borderWidthThin,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeTokens.radiusSm),
          borderSide: BorderSide(
            color: appColors.primary,
            width: ThemeTokens.borderWidthMedium,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeTokens.radiusSm),
          borderSide: BorderSide(
            color: appColors.danger,
            width: ThemeTokens.borderWidthThin,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(ThemeTokens.radiusSm),
          borderSide: BorderSide(
            color: appColors.danger,
            width: ThemeTokens.borderWidthMedium,
          ),
        ),
        hintStyle: TextStyle(
          color: appColors.textTertiary,
          fontSize: ThemeTokens.fontSizeSm,
        ),
        labelStyle: TextStyle(
          color: appColors.textSecondary,
          fontSize: ThemeTokens.fontSizeSm,
        ),
      ),

      // ================================================
      // Dialog 主题
      // ================================================
      dialogTheme: DialogThemeData(
        backgroundColor: appColors.bgContainer,
        elevation: ThemeTokens.elevationLg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeTokens.radiusMd),
        ),
        titleTextStyle: TextStyle(
          color: appColors.textPrimary,
          fontSize: ThemeTokens.fontSizeLg,
          fontWeight: FontWeight.w600,
        ),
        contentTextStyle: TextStyle(
          color: appColors.textSecondary,
          fontSize: ThemeTokens.fontSizeSm,
        ),
      ),

      // ================================================
      // Icon 主题
      // ================================================
      iconTheme: IconThemeData(
        color: appColors.textSecondary,
        size: ThemeTokens.iconSizeLg,
      ),

      // ================================================
      // Drawer 主题
      // ================================================
      drawerTheme: DrawerThemeData(
        backgroundColor: appColors.bgContainer,
        elevation: ThemeTokens.elevationLg,
      ),

      // ================================================
      // BottomSheet 主题
      // ================================================
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: appColors.bgContainer,
        elevation: ThemeTokens.elevationLg,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(ThemeTokens.radiusLg),
          ),
        ),
      ),

      // ================================================
      // Chip 主题
      // ================================================
      chipTheme: ChipThemeData(
        backgroundColor: appColors.fillDefault,
        selectedColor: appColors.primary.withOpacity(0.2),
        labelStyle: TextStyle(
          color: appColors.textPrimary,
          fontSize: ThemeTokens.fontSizeXs,
        ),
        side: BorderSide(
          color: appColors.borderLight,
          width: ThemeTokens.borderWidthThin,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ThemeTokens.radiusSm),
        ),
      ),

      // ================================================
      // Switch 主题
      // ================================================
      switchTheme: SwitchThemeData(
        // 滑块颜色
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return appColors.primary; // 打开状态 - 主题色滑块
          }
          return Colors.grey.shade600; // 关闭状态 - 深灰色滑块（暗色模式）
        }),
        // 轨道颜色
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return appColors.primary.withValues(alpha: 0.5); // 打开状态 - 半透明主题色背景
          }
          return Colors.grey.shade800; // 关闭状态 - 深灰色背景（暗色模式）
        }),
        // 轨道边框颜色
        trackOutlineColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return null; // 打开状态 - 无边框
          }
          return Colors.grey.shade700; // 关闭状态 - 灰色边框（暗色模式）
        }),
      ),

      // ================================================
      // DataTable 主题
      // ================================================
      dataTableTheme: DataTableThemeData(
        headingTextStyle: TextStyle(
          color: appColors.textSecondary,
          fontSize: ThemeTokens.fontSizeSm,
          fontWeight: FontWeight.w600,
        ),
        dataTextStyle: TextStyle(
          color: appColors.textPrimary,
          fontSize: ThemeTokens.fontSizeSm,
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: appColors.borderLight,
            width: ThemeTokens.borderWidthThin,
          ),
          borderRadius: BorderRadius.circular(ThemeTokens.radiusMd),
        ),
      ),

      // ================================================
      // 自定义主题扩展
      // ================================================
      extensions: [appColors],
    );
  }
}
