import 'package:book_store_admin/global/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:side_menu/side_menu.dart';
import '../config/routes.dart';


class MainLayout extends StatefulWidget {
  final Widget child;
  
  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  late SideMenuController _menuController;
  String currentRoute = Routes.books;
  
    
  String _generateBreadcrumb() {
    final Map<String, String> routeNames = {
      Routes.system: '系统管理',
      Routes.systemUsers: '系统管理 / 用户管理',
      Routes.systemRoles: '系统管理 / 角色管理',
      Routes.systemResources: '系统管理 / 资源管理',
      Routes.systemLogs: '系统管理 / 操作日志',
      Routes.books: '图书管理',
      Routes.categories: '分类管理',
      Routes.packages: '组合管理',
      Routes.orders: '订单管理',
      Routes.users: '用户管理',
      Routes.statistics: '统计分析',
    };
    final currentRoute = routeNames[Get.currentRoute] ?? '首页';
    return currentRoute;
  }

  // 获取菜单数据
  List<MenuItemModel> _menuItems() {
    return [
      item('图书管理', 'books', Icons.book, Routes.books),
      item('组合管理', 'packages', Icons.category, Routes.packages),
      item('分类管理', 'categories', Icons.folder, Routes.categories),
      item('订单管理', 'orders', Icons.shopping_cart, Routes.orders),
      item('用户管理', 'users', Icons.people, Routes.users),
      item('统计分析', 'statistics', Icons.bar_chart, Routes.statistics),
      item('系统管理', 'system', Icons.settings, Routes.system, children: [
        item('用户管理', 'systemUsers', Icons.people, Routes.systemUsers),
        item('角色管理', 'systemRoles', Icons.security, Routes.systemRoles),
        item('资源管理', 'systemResources', Icons.menu, Routes.systemResources),
        item('操作日志', 'systemLogs', Icons.history, Routes.systemLogs),
      ]),
    ];
  }

  @override
  void initState() {
    super.initState();
    _menuController = SideMenuController(
      menuItems: _menuItems(),
      onStateChanged: () {
        if (_menuController.selectedMenuId != null) {
          // 查找选中菜单项的路由
          final route = _findRouteById(_menuController.selectedMenuId!);
          if (route != null) {
            // 避免导航循环：只在当前路由与目标路由不同时才导航
            if (Get.currentRoute != route) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                // 先更新当前路由状态，避免重复触发导航
                currentRoute = route;
                // 使用Get.toNamed导航到选中的路由
                Get.toNamed(route);
              });
            }
          }
        }
      },
    );
    
    // 初始化当前路由 - 只在第一次加载时执行
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentGetRoute = Get.currentRoute;
      if (currentGetRoute == '/') {
        _menuController.selectMenuItem('books', route: Routes.books);
      } else {
        // 根据当前路由选择对应的菜单项
        _updateMenuFromRoute(currentGetRoute);
      }
    });
  }
  
  // 根据路由更新菜单选中状态
  void _updateMenuFromRoute(String route) {
    // 查找与路由匹配的菜单ID
    for (final item in _menuItems()) {
      if (item.route == route) {
        _menuController.selectMenuItem(item.id, route: item.route);
        return;
      }
      if (item.hasChildren) {
        for (final child in item.children) {
          if (child.route == route) {
            _menuController.selectMenuItem(child.id, route: child.route);
            return;
          }
        }
      }
    }
    // 如果没有找到匹配的菜单项，默认选择books
    _menuController.selectMenuItem('books', route: Routes.books);
  }
  
  // 根据ID查找菜单项的路由
  String? _findRouteById(String id, [List<MenuItemModel>? items]) {
    items ??= _menuItems();
    for (final item in items) {
      if (item.id == id) {
        return item.route;
      }
      if (item.hasChildren) {
        final childRoute = _findRouteById(id, item.children);
        if (childRoute != null) {
          return childRoute;
        }
      }
    }
    return null;
  }
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Row(
        children: [
          // 侧边菜单
          SideMenu(
            title: '爱自然书籍管理系统',
            controller: _menuController,
            menuItems: _menuItems(),
          ),
          // 主内容区域
          Expanded(
            child: Container(
              color: Colors.grey[100],
              padding: const EdgeInsets.all(6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 面包屑导航
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.home, size: 22),
                        const SizedBox(width: 8),
                        Text(
                          _generateBreadcrumb(),
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),  
                            blurRadius: 15,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: widget.child,
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
}

