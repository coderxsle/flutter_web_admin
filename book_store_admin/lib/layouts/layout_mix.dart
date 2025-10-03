///
/// @file LayoutMix 组件
/// @description 混合布局组件，支持顶部导航和左侧菜单组合的布局方式
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:side_menu/side_menu/menu_item_model.dart';
import '../global/global.dart';
import '../config/routes.dart';
import 'components/app_logo.dart';
import 'components/app_menu.dart';
import 'components/app_main.dart';
import 'components/app_tabs.dart';
import 'components/menu_fold_btn.dart';
import 'components/header_right_bar.dart';

/// 混合布局组件
/// 
/// 结合顶部导航和左侧菜单的混合布局：
/// - 左侧：Logo + 二级菜单
/// - 右侧：顶部一级菜单 + 标签页 + 主内容区
class LayoutMix extends StatefulWidget {
  /// 子组件内容
  final Widget child;

  const LayoutMix({
    super.key,
    required this.child,
  });

  @override
  State<LayoutMix> createState() => _LayoutMixState();
}

class _LayoutMixState extends State<LayoutMix> {
  /// 应用状态控制器
  final _appController = Get.find<GlobalController>();
  
  /// 当前激活的顶级菜单
  final ValueNotifier<List<String>> _activeMenu = ValueNotifier<List<String>>([]);
  
  /// 左侧菜单数据
  final ValueNotifier<List<MenuItemModel>> _leftMenus = ValueNotifier<List<MenuItemModel>>([]);

  @override
  void initState() {
    super.initState();
    _initializeMenus();
  }

  /// 初始化菜单数据
  void _initializeMenus() {
    final currentRoute = Get.currentRoute;
    _getLeftMenus(currentRoute);
  }

  /// 获取左侧菜单数据
  void _getLeftMenus(String key) {
    final menuRoutes = _appController.menuRoutes;
    
    // 查找匹配的顶级菜单
    MenuItemModel? targetMenu;
    for (final menu in menuRoutes) {
      if (menu.route == key || _hasChildRoute(menu, key)) {
        targetMenu = menu;
        break;
      }
    }

    if (targetMenu != null) {
      _activeMenu.value = [targetMenu.route ?? ''];
      _leftMenus.value = targetMenu.children;
    } else {
      _activeMenu.value = [''];
      _leftMenus.value = [];
    }
  }

  /// 检查菜单是否包含指定路由
  bool _hasChildRoute(MenuItemModel menu, String route) {
    if (menu.children == null) return false;
    
    for (final child in menu.children!) {
      if (child.route == route || _hasChildRoute(child, route)) {
        return true;
      }
    }
    return false;
  }

  /// 获取菜单图标
  IconData? _getMenuIcon(MenuItemModel item) {
    return item.icon ?? item.children?.first.icon;
  }

  /// 处理顶部菜单项点击
  void _handleMenuItemClick(String key) {
    // 检查是否为外部链接
    if (_isExternal(key)) {
      // 打开外部链接
      // launchUrl(Uri.parse(key));
      return;
    }

    // 延迟获取左侧菜单，确保UI更新
    Future.delayed(const Duration(milliseconds: 10), () {
      _getLeftMenus(key);
    });

    // 查找目标菜单
    final targetMenu = _appController.menuRoutes.firstWhereOrNull(
      (item) => item.route == key,
    );

    // 如果菜单设置为不重定向，则不进行路由跳转
    // if (targetMenu?.redirect == 'noRedirect') return;

    // 导航到选中的路由
    Get.toNamed(key);
  }

  /// 检查是否为外部链接
  bool _isExternal(String path) {
    return path.startsWith('http://') || path.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    return Scaffold(
      body: GetBuilder<GlobalController>(
        builder: (controller) {
          return Row(
            children: [
              // 左侧菜单区域（桌面端显示）
              if (isDesktop)
                Container(
                  decoration: BoxDecoration(
                    color: controller.menuDark 
                        ? controller.darkThemeColor 
                        : Theme.of(context).colorScheme.surface,
                    border: Border(
                      right: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Logo 组件
                      AppLogo(collapsed: controller.menuCollapse),
                      
                      // 左侧菜单
                      Expanded(
                        child: ValueListenableBuilder<List<MenuItemModel>>(
                          valueListenable: _leftMenus,
                          builder: (context, leftMenus, child) {
                            return AppMenu(
                              menus: leftMenus,
                              menuStyle: const {
                                'width': 200.0,
                                'flex': 1,
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

              // 右侧内容区域
              Expanded(
                child: Column(
                  children: [
                    // 顶部导航栏
                    Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        border: Border(
                          bottom: BorderSide(
                            color: Theme.of(context).dividerColor,
                            width: 1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          // 菜单折叠按钮
                          const MenuFoldBtn(),
                          
                          // 顶部水平菜单（桌面端显示）
                          if (isDesktop)
                            Expanded(
                              child: ValueListenableBuilder<List<String>>(
                                valueListenable: _activeMenu,
                                builder: (context, activeMenu, child) {
                                  return _buildHorizontalMenu(activeMenu);
                                },
                              ),
                            ),
                          
                          // 右侧工具栏
                          const HeaderRightBar(),
                        ],
                      ),
                    ),
                    
                    // 标签页（根据配置显示）
                    if (controller.tabVisible) const AppTabs(),
                    
                    // 主内容区域
                    Expanded(
                      child: AppMain(child: widget.child),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// 构建水平菜单
  Widget _buildHorizontalMenu(List<String> activeMenu) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _appController.menuRoutes.map((item) {
          final isActive = activeMenu.contains(item.route);
          final icon = _getMenuIcon(item);
          final title = item.title ?? item.children?.first?.title ?? '';

          return InkWell(
            onTap: () => _handleMenuItemClick(item.route ?? ''),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: isActive 
                    ? Theme.of(context).primaryColor.withOpacity(0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(
                      icon,
                      size: 18,
                      color: isActive 
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    title,
                    style: TextStyle(
                      color: isActive 
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).textTheme.bodyMedium?.color,
                      fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _activeMenu.dispose();
    _leftMenus.dispose();
    super.dispose();
  }
}
