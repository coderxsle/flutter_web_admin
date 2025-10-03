///
/// @file AppAsider 组件
/// @description 应用侧边栏组件，包含 Logo 和菜单
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global/global.dart';
import 'app_logo.dart';
import 'app_menu.dart';

/// 应用侧边栏组件
/// 
/// 功能特性：
/// - 响应式显示（桌面端显示，移动端隐藏）
/// - 支持菜单折叠
/// - 包含 Logo 和菜单列表
/// - 主题切换支持
/// - 滚动支持
class AppAsider extends StatelessWidget {
  const AppAsider({super.key});

  /// 检查是否为桌面端
  bool _isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 768;
  }


  @override
  Widget build(BuildContext context) {
    if (!_isDesktop(context)) {
      // 移动端不显示侧边栏
      return const SizedBox.shrink();
    }

    return GetBuilder<GlobalController>(
      builder: (controller) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: controller.menuCollapse ? 64 : 220,
          decoration: BoxDecoration(
            color: controller.menuDark 
                ? controller.darkThemeColor 
                : Theme.of(context).colorScheme.surface,
            border: Border(
              right: BorderSide(
                color: Theme.of(context).dividerColor.withOpacity(0.5),
                width: 1,
              ),
            ),
          ),
          child: Column(
            children: [
              // Logo 组件
              AppLogo(collapsed: controller.menuCollapse),
              
              // 分隔线
              Divider(
                height: 1,
                color: Theme.of(context).dividerColor,
              ),
              
              // 菜单滚动区域
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: AppMenu(
                      menus: controller.menuRoutes,
                      collapsed: controller.menuCollapse,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
