///
/// @file Breadcrumb 组件
/// @description 面包屑导航组件，显示当前页面的导航路径
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:side_menu/side_menu/menu_item_model.dart';
import '../../global/global.dart';

/// 面包屑导航组件
/// 
/// 功能特性：
/// - 显示当前页面的导航路径
/// - 支持点击跳转到上级页面
/// - 响应式设计
/// - 自动生成面包屑路径
class AppBreadcrumb extends StatelessWidget {
  const AppBreadcrumb({super.key});

  /// 生成面包屑路径
  List<BreadcrumbItem> _generateBreadcrumbPath() {
    final appController = Get.find<GlobalController>();
    final currentRoute = Get.currentRoute;
    final breadcrumbItems = <BreadcrumbItem>[];

    // 添加首页
    breadcrumbItems.add(
      BreadcrumbItem(
        title: '首页',
        route: '/',
        icon: Icons.home,
      ),
    );

    // 查找当前路由对应的菜单项
    final menuItem = _findMenuByRoute(appController.menuRoutes, currentRoute);
    if (menuItem != null) {
      // 构建路径
      final pathItems = _buildMenuPath(appController.menuRoutes, menuItem);
      breadcrumbItems.addAll(pathItems);
    }

    return breadcrumbItems;
  }

  /// 根据路由查找菜单项
  MenuItemModel? _findMenuByRoute(List<MenuItemModel> menus, String route) {
    for (final menu in menus) {
      if (menu.route == route) {
        return menu;
      }
      if (menu.children != null) {
        final found = _findMenuByRoute(menu.children!, route);
        if (found != null) {
          return found;
        }
      }
    }
    return null;
  }

  /// 构建菜单路径
  List<BreadcrumbItem> _buildMenuPath(List<MenuItemModel> menus, MenuItemModel target) {
    final path = <BreadcrumbItem>[];
    
    // 查找父级菜单
    final parent = _findParentMenu(menus, target);
    if (parent != null) {
      path.addAll(_buildMenuPath(menus, parent));
    }

    // 添加当前菜单项
    path.add(
      BreadcrumbItem(
        title: target.title ?? '',
        route: target.route,
        icon: target.icon,
      ),
    );

    return path;
  }

  /// 查找父级菜单
  MenuItemModel? _findParentMenu(List<MenuItemModel> menus, MenuItemModel target) {
    for (final menu in menus) {
      if (menu.children != null) {
        for (final child in menu.children!) {
          if (child.id == target.id) {
            return menu;
          }
          final found = _findParentMenu(menu.children!, target);
          if (found != null) {
            return found;
          }
        }
      }
    }
    return null;
  }

  /// 处理面包屑项点击
  void _handleBreadcrumbClick(String? route) {
    if (route != null && route.isNotEmpty) {
      Get.toNamed(route);
    }
  }

  @override
  Widget build(BuildContext context) {
    final breadcrumbItems = _generateBreadcrumbPath();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: breadcrumbItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == breadcrumbItems.length - 1;

          return Row(
            children: [
              // 面包屑项
              InkWell(
                onTap: isLast ? null : () => _handleBreadcrumbClick(item.route),
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // 图标
                      if (item.icon != null) ...[
                        Icon(
                          item.icon,
                          size: 14,
                          color: isLast 
                              ? Theme.of(context).textTheme.bodyMedium?.color
                              : Theme.of(context).primaryColor,
                        ),
                        const SizedBox(width: 4),
                      ],
                      
                      // 标题
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 14,
                          color: isLast 
                              ? Theme.of(context).textTheme.bodyMedium?.color
                              : Theme.of(context).primaryColor,
                          fontWeight: isLast ? FontWeight.normal : FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              // 分隔符
              if (!isLast) ...[
                const SizedBox(width: 4),
                Icon(
                  Icons.keyboard_arrow_right,
                  size: 16,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
                const SizedBox(width: 4),
              ],
            ],
          );
        }).toList(),
      ),
    );
  }
}

/// 面包屑项数据模型
class BreadcrumbItem {
  /// 标题
  final String title;
  
  /// 路由
  final String? route;
  
  /// 图标
  final IconData? icon;

  const BreadcrumbItem({
    required this.title,
    this.route,
    this.icon,
  });
}
