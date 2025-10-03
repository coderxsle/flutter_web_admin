import 'package:flutter/material.dart';
import '../config/color_schemes.dart';
import '../app_theme.dart';
import '../extensions/theme_extension.dart';

/// 主题切换器组件 - 示例用法
class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.bgContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '主题设置',
            style: context.textTheme.titleMedium?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // 明暗模式切换
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '暗色模式',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: colors.textSecondary,
                ),
              ),
              Switch(
                value: AppTheme.isDarkMode,
                onChanged: (value) async {
                  await AppTheme.setThemeMode(value);
                },
              ),
            ],
          ),

          const Divider(height: 24),

          // 颜色方案选择
          Text(
            '颜色方案',
            style: context.textTheme.bodyMedium?.copyWith(
              color: colors.textSecondary,
            ),
          ),
          const SizedBox(height: 12),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: ColorSchemeType.values.map((scheme) {
              final isSelected = AppTheme.currentColorScheme == scheme;
              final schemeColor = AppTheme.getColorSchemeColor(scheme);
              final schemeName = AppTheme.getColorSchemeName(scheme);

              return InkWell(
                onTap: () async {
                  await AppTheme.setColorScheme(scheme);
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? schemeColor.withOpacity(0.1)
                        : colors.fillDefault,
                    border: Border.all(
                      color: isSelected
                          ? schemeColor
                          : colors.borderLight,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: schemeColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        schemeName,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: isSelected
                              ? schemeColor
                              : colors.textSecondary,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
