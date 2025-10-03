///
/// @file AppHeader 组件
/// @description 应用头部组件，包含菜单折叠按钮、面包屑导航和右侧工具栏
///
import 'package:flutter/material.dart';
import 'menu_fold_btn.dart';
import 'app_breadcrumb.dart';
import 'header_right_bar.dart';

/// 应用头部组件
/// 
/// 功能特性：
/// - 菜单折叠按钮
/// - 面包屑导航（响应式显示）
/// - 右侧工具栏
/// - 响应式布局
class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth >= 768 && screenWidth < 1024;
    final isDesktop = screenWidth >= 1024;

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // 菜单折叠按钮区域
          const MenuFoldBtn(),
          
          // 主要内容区域
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 16),
              child: Row(
                children: [
                  // 面包屑导航（响应式显示）
                  if (isTablet || isDesktop)
                    Expanded(
                      flex: isDesktop ? 1 : 0,
                      child: const AppBreadcrumb(),
                    ),
                  
                  // 右侧工具栏
                  const HeaderRightBar(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
