import 'package:flutter/material.dart';
import '../models/menu_item.dart';

/// 菜单工具类 - 提供菜单相关的辅助方法
class MenuUtils {
  /// 根据路由查找菜单项
  static MenuItem? findMenuByRoute(List<MenuItem> items, String route) {
    for (final item in items) {
      if (item.route == route && item.page != null) {
        return item;
      }
      if (item.hasChildren) {
        final found = findMenuByRoute(item.children!, route);
        if (found != null) {
          return found;
        }
      }
    }
    return null;
  }

  /// 获取路由对应的页面
  static Widget? getPageByRoute(List<MenuItem> items, String route) {
    final menuItem = findMenuByRoute(items, route);
    return menuItem?.page;
  }

  /// 自动构建菜单层级关系（用于展开父菜单）
  /// 返回格式：{ 'child_route': ['parent1', 'parent2'] }
  static Map<String, List<String>> buildMenuHierarchy(List<MenuItem> items) {
    final Map<String, List<String>> hierarchy = {};
    
    void traverse(List<MenuItem> menus, List<String> parents) {
      for (final menu in menus) {
        if (menu.route != null) {
          // 提取路由名称（去掉斜杠）
          final routeName = menu.route!.replaceAll('/', '');
          if (routeName.isNotEmpty && parents.isNotEmpty) {
            hierarchy[routeName] = List.from(parents);
          }
        }
        
        if (menu.hasChildren) {
          final newParents = List<String>.from(parents);
          if (menu.route != null) {
            newParents.add(menu.route!);
          }
          traverse(menu.children!, newParents);
        }
      }
    }
    
    traverse(items, []);
    return hierarchy;
  }

  /// 展开指定菜单项
  static void expandMenuItem(List<MenuItem> items, String itemId, Function refresh) {
    _expandItemInList(items, itemId);
    refresh();
  }

  static void _expandItemInList(List<MenuItem> items, String itemId) {
    for (int i = 0; i < items.length; i++) {
      if (items[i].id == itemId) {
        if (!items[i].isExpanded) {
          items[i] = items[i].copyWith(isExpanded: true);
        }
        return;
      }
      if (items[i].hasChildren) {
        _expandItemInList(items[i].children!, itemId);
      }
    }
  }

  /// 切换菜单项展开状态
  static void toggleMenuItemExpansion(List<MenuItem> items, String itemId, Function refresh) {
    _toggleExpansion(items, itemId);
    refresh();
  }

  static void _toggleExpansion(List<MenuItem> items, String itemId) {
    for (int i = 0; i < items.length; i++) {
      if (items[i].id == itemId) {
        items[i] = items[i].copyWith(isExpanded: !items[i].isExpanded);
        return;
      }
      if (items[i].hasChildren) {
        _toggleExpansion(items[i].children!, itemId);
      }
    }
  }

  /// 确保指定路由的所有父菜单都展开
  static void ensureParentMenusExpanded(
    List<MenuItem> items,
    String route,
    Map<String, List<String>> hierarchy,
    Function refresh,
  ) {
    final routeName = route.replaceAll('/', '');
    final parentsToExpand = hierarchy[routeName] ?? [];
    
    for (final parentId in parentsToExpand) {
      _expandItemInList(items, parentId);
    }
    refresh();
  }

  /// 获取所有叶子节点菜单（有page的菜单）
  static List<MenuItem> getAllLeafMenus(List<MenuItem> items) {
    final List<MenuItem> leafMenus = [];
    
    void traverse(List<MenuItem> menus) {
      for (final menu in menus) {
        if (menu.page != null) {
          leafMenus.add(menu);
        }
        if (menu.hasChildren) {
          traverse(menu.children!);
        }
      }
    }
    
    traverse(items);
    return leafMenus;
  }

  /// 获取所有路由路径
  static List<String> getAllRoutes(List<MenuItem> items) {
    final List<String> routes = [];
    
    void traverse(List<MenuItem> menus) {
      for (final menu in menus) {
        if (menu.route != null) {
          routes.add(menu.route!);
        }
        if (menu.hasChildren) {
          traverse(menu.children!);
        }
      }
    }
    
    traverse(items);
    return routes;
  }

  /// 验证路由是否存在
  static bool isValidRoute(List<MenuItem> items, String route) {
    return findMenuByRoute(items, route) != null;
  }

  /// 扁平化菜单树（用于搜索等场景）
  static List<MenuItem> flattenMenus(List<MenuItem> items) {
    final List<MenuItem> flattened = [];
    
    void traverse(List<MenuItem> menus) {
      for (final menu in menus) {
        flattened.add(menu);
        if (menu.hasChildren) {
          traverse(menu.children!);
        }
      }
    }
    
    traverse(items);
    return flattened;
  }

  /// 搜索菜单（根据标题）
  static List<MenuItem> searchMenus(List<MenuItem> items, String keyword) {
    final List<MenuItem> results = [];
    final flatMenus = flattenMenus(items);
    
    for (final menu in flatMenus) {
      if (menu.title.toLowerCase().contains(keyword.toLowerCase())) {
        results.add(menu);
      }
    }
    
    return results;
  }
}


