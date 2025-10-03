import 'package:flutter/material.dart';
import '../config/color_schemes.dart';
import '../config/theme_tokens.dart';

/// 明亮模式主题生成器
class LightTheme {
  /// 生成明亮模式主题
  static ThemeData generate(ColorSchemeType colorSchemeType) {
    final appColors = AppColorScheme.fromType(colorSchemeType, false);

    return ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
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
      splashColor: appColors.primary.withValues(alpha: 0.5),
      highlightColor: appColors.fillActive,
      focusColor: appColors.primary.withValues(alpha: 0.5),

      // ================================================
      // 颜色方案
      // ================================================
      colorScheme: ColorScheme.light(
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
        shadowColor: appColors.textPrimary.withOpacity(0.1),
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

      // ================================================
      // OutlinedButton 主题
      // ================================================
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

      // ================================================
      // TextButton 主题
      // ================================================
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
      // Text 主题
      // ================================================
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: ThemeTokens.fontSize5Xl,
          fontWeight: FontWeight.bold,
          color: appColors.textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: ThemeTokens.fontSize4Xl,
          fontWeight: FontWeight.bold,
          color: appColors.textPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: ThemeTokens.fontSize3Xl,
          fontWeight: FontWeight.bold,
          color: appColors.textPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: ThemeTokens.fontSize2Xl,
          fontWeight: FontWeight.w600,
          color: appColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: ThemeTokens.fontSizeXl,
          fontWeight: FontWeight.w600,
          color: appColors.textPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: ThemeTokens.fontSizeLg,
          fontWeight: FontWeight.w600,
          color: appColors.textPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: ThemeTokens.fontSizeLg,
          fontWeight: FontWeight.w500,
          color: appColors.textPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: ThemeTokens.fontSizeMd,
          fontWeight: FontWeight.w500,
          color: appColors.textPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: ThemeTokens.fontSizeSm,
          fontWeight: FontWeight.w500,
          color: appColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: ThemeTokens.fontSizeMd,
          color: appColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: ThemeTokens.fontSizeSm,
          color: appColors.textSecondary,
        ),
        bodySmall: TextStyle(
          fontSize: ThemeTokens.fontSizeXs,
          color: appColors.textTertiary,
        ),
        labelLarge: TextStyle(
          fontSize: ThemeTokens.fontSizeSm,
          fontWeight: FontWeight.w500,
          color: appColors.textPrimary,
        ),
        labelMedium: TextStyle(
          fontSize: ThemeTokens.fontSizeXs,
          fontWeight: FontWeight.w500,
          color: appColors.textSecondary,
        ),
        labelSmall: TextStyle(
          fontSize: ThemeTokens.fontSizeXs,
          fontWeight: FontWeight.w500,
          color: appColors.textTertiary,
        ),
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
        selectedColor: appColors.primary.withOpacity(0.1),
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
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return Colors.white;
          }
          return appColors.textTertiary;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return appColors.primary;
          }
          return appColors.fillActive;
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
