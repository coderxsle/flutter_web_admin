/// @file SettingDrawer 组件
/// @description 设置抽屉组件，提供布局模式、主题设置等配置选项
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:getx_go_main/modules/layout/controllers/layout_admin_controller.dart';
import 'package:getx_go_main/modules/layout/static/static.dart';
import 'package:getx_go_main/theme/theme.dart';

/// 设置抽屉组件
class SettingDrawer extends StatefulWidget {
  final double width;
  const SettingDrawer({super.key, this.width = 320});

  @override
  State<SettingDrawer> createState() => SettingDrawerState();
}

class SettingDrawerState extends State<SettingDrawer> {
  /// 缓存的主题数据
  ThemeData? _cachedTheme;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 缓存主题数据以避免在 Obx 中访问已销毁的 context
    _cachedTheme = Theme.of(context);
  }


  @override
  Widget build(BuildContext context) {
    return _buildDrawerContent();
  }

  /// 构建布局模式选择器
  Widget _buildLayoutModeSelector() {
    final appController = Get.find<LayoutAdminController>();
    final theme = _cachedTheme ?? Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '布局模式',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: theme.textTheme.titleMedium?.color,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // 布局选项
        Obx(() => Column(
          children: [
            _buildLayoutOption(
              title: '默认布局',
              description: '左侧菜单 + 右侧内容',
              layoutType: LayoutType.def,
              currentLayout: appController.layout,
              onChanged: (layout) => appController.layout = layout,
            ),
            
            const SizedBox(height: 12),
            
            _buildLayoutOption(
              title: '混合布局',
              description: '顶部导航 + 左侧菜单',
              layoutType: LayoutType.mix,
              currentLayout: appController.layout,
              onChanged: (layout) => appController.layout = layout,
            ),
            
            const SizedBox(height: 12),
            
            _buildLayoutOption(
              title: '顶部布局',
              description: '顶部横向导航',
              layoutType: LayoutType.top,
              currentLayout: appController.layout,
              onChanged: (layout) => appController.layout = layout,
            ),
          ],
        )),
      ],
    );
  }

  /// 构建布局选项
  Widget _buildLayoutOption({
    required String title,
    required String description,
    required LayoutType layoutType,
    required LayoutType currentLayout,
    required void Function(LayoutType) onChanged,
  }) {
    final theme = _cachedTheme ?? Theme.of(context);
    final isSelected = currentLayout == layoutType;
    
    return GestureDetector(
      onTap: () => onChanged(layoutType),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected 
              ? theme.primaryColor.withOpacity(0.1)
              : theme.cardColor,
          border: Border.all(
            color: isSelected 
                ? theme.primaryColor 
                : theme.dividerColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            // 布局预览图
            Container(
              width: 60,
              height: 40,
              decoration: BoxDecoration(
                color: theme.dividerColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              child: _buildLayoutPreview(layoutType, theme),
            ),
            
            const SizedBox(width: 16),
            
            // 布局信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isSelected 
                          ? theme.primaryColor 
                          : theme.textTheme.titleMedium?.color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
            ),
            
            // 选中状态
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: theme.primaryColor,
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  /// 构建布局预览图
  Widget _buildLayoutPreview(LayoutType layoutType, ThemeData theme) {
    switch (layoutType) {
      case LayoutType.def:
        return Row(
          children: [
            Container(
              width: 16,
              height: double.infinity,
              color: theme.primaryColor.withOpacity(0.3),
            ),
            Expanded(
              child: Container(
                color: theme.primaryColor.withOpacity(0.1),
              ),
            ),
          ],
        );
      
      case LayoutType.mix:
        return Column(
          children: [
            Container(
              height: 12,
              color: theme.primaryColor.withOpacity(0.2),
            ),
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 16,
                    height: double.infinity,
                    color: theme.primaryColor.withOpacity(0.3),
                  ),
                  Expanded(
                    child: Container(
                      color: theme.primaryColor.withOpacity(0.1),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      
      case LayoutType.top:
        return Column(
          children: [
            Container(
              height: 12,
              color: theme.primaryColor.withOpacity(0.3),
            ),
            Expanded(
              child: Container(
                color: theme.primaryColor.withOpacity(0.1),
              ),
            ),
          ],
        );
    }
  }

  /// 构建明暗模式切换卡片
  Widget _buildThemeModeCard() {
    final theme = _cachedTheme ?? Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '外观模式',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: theme.textTheme.titleMedium?.color,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildModeOption(
                icon: Icons.light_mode,
                label: '明亮模式',
                isSelected: !AppTheme.isDarkMode,
                onTap: () async {
                  await AppTheme.setThemeMode(false);
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildModeOption(
                icon: Icons.dark_mode,
                label: '暗黑模式',
                isSelected: AppTheme.isDarkMode,
                onTap: () async {
                  await AppTheme.setThemeMode(true);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// 模式选项
  Widget _buildModeOption({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = _cachedTheme ?? Theme.of(context);
    final colors = context.themeColors;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? colors.primary.withOpacity(0.1)
              : theme.cardColor,
          border: Border.all(
            color: isSelected ? colors.primary : theme.dividerColor,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? colors.primary : theme.iconTheme.color,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? colors.primary : theme.textTheme.bodyMedium?.color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建颜色方案选择卡片
  Widget _buildColorSchemeCard() {
    final theme = _cachedTheme ?? Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '主题颜色',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: theme.textTheme.titleMedium?.color,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
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
                width: 130,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? schemeColor.withOpacity(0.1)
                      : theme.cardColor,
                  border: Border.all(
                    color: isSelected ? schemeColor : theme.dividerColor,
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
                    Expanded(
                      child: Text(
                        schemeName,
                        style: TextStyle(
                          fontSize: 11,
                          color: isSelected
                              ? schemeColor
                              : theme.textTheme.bodyMedium?.color,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                    if (isSelected)
                      Icon(
                        Icons.check_circle,
                        size: 14,
                        color: schemeColor,
                      ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// 构建布局设置
  Widget _buildLayoutSettings() {
    final appController = Get.find<LayoutAdminController>();
    final theme = _cachedTheme ?? Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '布局设置',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: theme.textTheme.titleMedium?.color,
          ),
        ),
        
        const SizedBox(height: 16),
        
        // 暗黑菜单
        Obx(() => SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('暗黑菜单'),
          subtitle: const Text('菜单栏使用暗黑主题'),
          value: appController.menuDark,
          onChanged: (value) => appController.menuDark = value,
        )),
        
        // 手风琴菜单
        Obx(() => SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('手风琴菜单'),
          subtitle: const Text('只展开一个菜单项'),
          value: appController.menuAccordion,
          onChanged: (value) => appController.menuAccordion = value,
        )),
        
        // 标签页可见性
        Obx(() => SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('显示标签页'),
          subtitle: const Text('是否显示页面标签页'),
          value: appController.tabVisible,
          onChanged: (value) => appController.tabVisible = value,
        )),
      ],
    );
  }

  /// 构建标签页样式设置
  Widget _buildTabStyleSettings() {
    final appController = Get.find<LayoutAdminController>();
    final theme = _cachedTheme ?? Theme.of(context);
    
    final tabStyles = [
      {'key': 'line', 'name': '线条样式'},
      {'key': 'card', 'name': '卡片样式'},
      {'key': 'custom1', 'name': '自定义1'},
      {'key': 'custom2', 'name': '标签样式'},
    ];
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '标签页样式',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: theme.textTheme.titleMedium?.color,
          ),
        ),
        
        const SizedBox(height: 16),
        
        Obx(() => Wrap(
          spacing: 8,
          runSpacing: 8,
          children: tabStyles.map((style) {
            final isSelected = appController.tab == style['key'];
            return GestureDetector(
              onTap: () => appController.tab = style['key']!,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected 
                      ? theme.primaryColor 
                      : theme.cardColor,
                  border: Border.all(
                    color: isSelected 
                        ? theme.primaryColor 
                        : theme.dividerColor,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  style['name']!,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected 
                        ? Colors.white 
                        : theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ),
            );
          }).toList(),
        )),
      ],
    );
  }

  /// 构建抽屉内容
  Widget _buildDrawerContent() {
    final theme = _cachedTheme ?? Theme.of(context);
    return Container(
      width: widget.width,
      color: theme.scaffoldBackgroundColor,
      child: Column(
        children: [
          // 标题栏
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.settings, size: 24),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    '项目配置',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => SmartDialog.dismiss(tag: 'settingDrawer'),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          
          // 内容区域
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 布局模式
                  _buildLayoutModeSelector(),
                  const SizedBox(height: 24),
      
                  // 外观模式
                  _buildThemeModeCard(),
                  const SizedBox(height: 24),
                  
                  // 主题颜色
                  _buildColorSchemeCard(),
                  const SizedBox(height: 24),
                  
                  const Divider(),
                  const SizedBox(height: 24),
                  
                  // 布局设置
                  _buildLayoutSettings(),
                  const SizedBox(height: 24),
                  
                  // 标签页样式
                  _buildTabStyleSettings(),
                  const SizedBox(height: 32),
                  
                  // 重置按钮
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: _resetSettings,
                      icon: const Icon(Icons.refresh),
                      label: const Text('重置所有设置'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.error,
                        side: BorderSide(color: theme.colorScheme.error),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 重置设置
  void _resetSettings() {
    final appController = Get.find<LayoutAdminController>();
    
    Get.dialog(
      AlertDialog(
        title: const Text('确认重置'),
        content: const Text('确定要重置所有设置到默认值吗？'),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () {
              // 重置到默认设置
              appController.layout = LayoutType.def;
              appController.menuDark = false;
              appController.menuAccordion = true;
              appController.tabVisible = true;
              appController.tab = 'line';
              appController.menuCollapse = false;
              
              Get.back();
              Get.snackbar('提示', '设置已重置');
            },
            child: const Text('确认'),
          ),
        ],
      ),
    );
  }
}
