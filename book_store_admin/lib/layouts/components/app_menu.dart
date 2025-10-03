///
/// @file Menu 组件
/// @description 系统菜单组件，支持垂直和水平布局、手风琴模式、响应式折叠等功能
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:side_menu/side_menu/menu_item_model.dart';
import '../../global/global.dart';
import '../../config/routes.dart';

/// 菜单模式枚举
enum MenuMode {
  /// 垂直菜单
  vertical,
  /// 水平菜单
  horizontal,
}

/// 系统菜单组件
/// 
/// 功能特性：
/// - 支持垂直和水平布局
/// - 手风琴模式
/// - 响应式折叠
/// - 多级菜单
/// - 外部链接支持
/// - 主题适配
class AppMenu extends StatefulWidget {
  /// 菜单项配置
  final List<MenuItemModel>? menus;
  
  /// 菜单模式
  final MenuMode mode;
  
  /// 是否折叠
  final bool collapsed;
  
  /// 菜单样式配置
  final Map<String, dynamic>? menuStyle;
  
  /// 菜单项点击后回调
  final VoidCallback? onMenuItemClickAfter;

  const AppMenu({
    super.key,
    this.menus,
    this.mode = MenuMode.vertical,
    this.collapsed = false,
    this.menuStyle,
    this.onMenuItemClickAfter,
  });

  @override
  State<AppMenu> createState() => _AppMenuState();
}

class _AppMenuState extends State<AppMenu> {
  /// 应用状态控制器
  final _appController = Get.find<GlobalController>();
  
  /// 展开的菜单项
  final Set<String> _expandedMenus = <String>{};

  @override
  void initState() {
    super.initState();
    _initializeExpandedMenus();
  }

  /// 初始化展开的菜单项
  void _initializeExpandedMenus() {
    final currentRoute = Get.currentRoute;
    _findAndExpandParentMenus(currentRoute);
  }

  /// 查找并展开父级菜单
  void _findAndExpandParentMenus(String route) {
    final menus = widget.menus ?? _appController.menuRoutes;
    
    for (final menu in menus) {
      if (_hasChildRoute(menu, route)) {
        _expandedMenus.add(menu.id);
        break;
      }
    }
  }

  /// 检查菜单是否包含指定路由
  bool _hasChildRoute(MenuItemModel menu, String route) {
    if (menu.route == route) return true;
    if (menu.children == null) return false;
    
    for (final child in menu.children!) {
      if (_hasChildRoute(child, route)) {
        return true;
      }
    }
    return false;
  }

  /// 获取当前激活的菜单路径
  String get _activeMenuPath {
    final route = Get.currentRoute;
    final meta = _appController.getRouteMetaByPath(route);
    return route; // meta?.activeMenu ?? route;
  }

  /// 处理菜单项点击
  void _handleMenuItemClick(String key) {
    if (_isExternal(key)) {
      // 打开外部链接
      // launchUrl(Uri.parse(key));
      return;
    }
    
    // 导航到路由
    Get.toNamed(key);
    
    // 触发点击后回调
    widget.onMenuItemClickAfter?.call();
  }

  /// 检查是否为外部链接
  bool _isExternal(String path) {
    return path.startsWith('http://') || path.startsWith('https://');
  }

  /// 处理菜单展开/折叠
  void _handleMenuExpand(String menuId, bool isExpanded) {
    setState(() {
      if (isExpanded) {
        // 手风琴模式：关闭其他展开的菜单
        if (_appController.menuAccordion) {
          _expandedMenus.clear();
        }
        _expandedMenus.add(menuId);
      } else {
        _expandedMenus.remove(menuId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final menus = widget.menus ?? _appController.menuRoutes;
    
    return Container(
      width: widget.menuStyle?['width']?.toDouble(),
      child: widget.mode == MenuMode.horizontal
          ? _buildHorizontalMenu(menus)
          : _buildVerticalMenu(menus),
    );
  }

  /// 构建垂直菜单
  Widget _buildVerticalMenu(List<MenuItemModel> menus) {
    return Column(
      children: menus.map((menu) => _buildVerticalMenuItem(menu)).toList(),
    );
  }

  /// 构建水平菜单
  Widget _buildHorizontalMenu(List<MenuItemModel> menus) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: menus.map((menu) => _buildHorizontalMenuItem(menu)).toList(),
      ),
    );
  }

  /// 构建垂直菜单项
  Widget _buildVerticalMenuItem(MenuItemModel menu) {
    final hasChildren = menu.children != null && menu.children!.isNotEmpty;
    final isActive = _activeMenuPath == menu.route;
    final isExpanded = _expandedMenus.contains(menu.id);

    return Column(
      children: [
        // 菜单项主体
        InkWell(
          onTap: () {
            if (hasChildren) {
              _handleMenuExpand(menu.id, !isExpanded);
            } else if (menu.route != null) {
              _handleMenuItemClick(menu.route!);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: widget.collapsed ? 12 : 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: isActive 
                  ? Theme.of(context).primaryColor.withOpacity(0.1)
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                // 菜单图标
                if (menu.icon != null)
                  Icon(
                    menu.icon,
                    size: 18,
                    color: isActive 
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                
                // 菜单标题（非折叠状态显示）
                if (!widget.collapsed) ...[
                  if (menu.icon != null) const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      menu.title ?? '',
                      style: TextStyle(
                        fontSize: 14,
                        color: isActive 
                            ? Theme.of(context).primaryColor
                            : Theme.of(context).textTheme.bodyMedium?.color,
                        fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                  ),
                  
                  // 展开/折叠图标
                  if (hasChildren)
                    Icon(
                      isExpanded 
                          ? Icons.keyboard_arrow_down 
                          : Icons.keyboard_arrow_right,
                      size: 16,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                ],
              ],
            ),
          ),
        ),
        
        // 子菜单
        if (hasChildren && isExpanded && !widget.collapsed)
          Container(
            margin: const EdgeInsets.only(left: 16),
            child: Column(
              children: menu.children!
                  .map((child) => _buildVerticalMenuItem(child))
                  .toList(),
            ),
          ),
      ],
    );
  }

  /// 构建水平菜单项
  Widget _buildHorizontalMenuItem(MenuItemModel menu) {
    final isActive = _activeMenuPath == menu.route;

    return InkWell(
      onTap: () {
        if (menu.route != null) {
          _handleMenuItemClick(menu.route!);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isActive 
              ? Theme.of(context).primaryColor.withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 菜单图标
            if (menu.icon != null) ...[
              Icon(
                menu.icon,
                size: 18,
                color: isActive 
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).textTheme.bodyMedium?.color,
              ),
              const SizedBox(width: 8),
            ],
            
            // 菜单标题
            Text(
              menu.title ?? '',
              style: TextStyle(
                fontSize: 14,
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
  }
}
