import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app_theme.dart';
import 'theme_config.dart';
import 'theme_controller.dart';

class ThemeSelector extends StatelessWidget {
  const ThemeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController controller = Get.find<ThemeController>();
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 主题类型选择器
        _buildThemeTypesSelector(controller),
        
        const SizedBox(height: 16),
        
        // 主题模式切换器
        _buildThemeModeToggle(controller),
      ],
    );
  }
  
  // 构建主题类型选择器
  Widget _buildThemeTypesSelector(ThemeController controller) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('主题选择', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: controller.availableThemeTypes.map((type) {
            final isSelected = controller.currentThemeType.value == type;
            return InkWell(
              onTap: () => controller.changeThemeType(type),
              child: _ThemePreviewCard(
                type: type,
                isSelected: isSelected,
                controller: controller,
              ),
            );
          }).toList(),
        ),
      ],
    ));
  }
  
  // 构建主题模式切换器
  Widget _buildThemeModeToggle(ThemeController controller) {
    return Obx(() => SwitchListTile(
      title: Text(
        AppTheme.isDarkMode() ? '浅色模式' : '深色模式'
      ),
      value: AppTheme.isDarkMode(),
      onChanged: (value) {
        AppTheme.toggleThemeMode();
      },
    ));
  }
}

// 主题预览卡片
class _ThemePreviewCard extends StatelessWidget {
  final AppThemeType type;
  final bool isSelected;
  final ThemeController controller;
  
  const _ThemePreviewCard({
    required this.type,
    required this.isSelected,
    required this.controller,
  });
  
  @override
  Widget build(BuildContext context) {
    // 根据主题类型获取颜色和名称
    final Color color = controller.getThemeTypeColor(type);
    final String name = controller.getThemeTypeName(type);
    
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: color.withOpacity(0.7),
        borderRadius: BorderRadius.circular(12),
        border: isSelected 
            ? Border.all(color: Colors.white, width: 2) 
            : null,
        boxShadow: isSelected 
            ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 8, spreadRadius: 1)]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          if (isSelected)
            const Icon(Icons.check_circle, color: Colors.white),
        ],
      ),
    );
  }
}
