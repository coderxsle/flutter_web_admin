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
      Routes.demo: '组件演示',
    };
    final currentRoute = routeNames[Get.currentRoute] ?? '首页';
    return currentRoute;
  }

  // 获取菜单数据
  List<MenuItemModel> _menuItems() {
    return [
      item('系统管理', 'system', Icons.settings, Routes.system, children: [
        item('用户管理', 'systemUsers', Icons.people, Routes.systemUsers),
        item('角色管理', 'systemRoles', Icons.security, Routes.systemRoles),
        item('资源管理', 'systemResources', Icons.menu, Routes.systemResources),
        item('操作日志', 'systemLogs', Icons.history, Routes.systemLogs),
      ]),
      item('图书管理', 'books', Icons.book, Routes.books),
      item('客户管理', 'users', Icons.people, Routes.users, children: [
        item('分类管理', 'categories', Icons.folder, Routes.categories),
        item('统计分析', 'statistics', Icons.bar_chart, Routes.statistics),
      ]),
      
      item('组合管理', 'packages', Icons.category, Routes.packages),
      
      item('订单管理', 'orders', Icons.shopping_cart, Routes.orders),

      item('组件演示', 'demo', Icons.code, Routes.demo),
    ];
  }

  @override
  void initState() {
    super.initState();
    _menuController = SideMenuController(
      menuItems: _menuItems(),
      onStateChanged: () {
        // 强制刷新UI状态
        setState(() {});
        
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
                        // 退出登录按钮
                        const Spacer(),
                        userIcon(),
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
  

  Widget userIcon() {
    // 获取用户信息
    final userInfo = Global.userInfo;
    final username = userInfo?['username'] ?? '管理员';
    final email = userInfo?['email'] ?? 'admin@example.com';
    
    return PopupMenuButton<String>(
      offset: const Offset(0, 40),
      tooltip: '',
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onSelected: (value) {
        if (value == 'logout') {
          // 显示确认对话框
          Get.dialog(
            AlertDialog(
              title: const Text('确认退出'),
              content: const Text('您确定要退出登录吗？'),
              actions: [
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('取消'),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                    Global.logout();
                  },
                  child: const Text('确定'),
                ),
              ],
            ),
          );
        } else if (value == 'profile') {
          // 跳转到个人资料页面
          // Get.toNamed(Routes.profile);
        } else if (value == 'password') {
          // 跳转到修改密码页面
          // Get.toNamed(Routes.changePassword);
        }
      },
      itemBuilder: (context) => [
        // 用户信息
        PopupMenuItem<String>(
          enabled: false,
          child: Row(
            children: [
              const CircleAvatar(
                radius: 15,
                backgroundColor: Color(0xFF0078D4),
                child: Icon(Icons.person, size: 18, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  Text(
                    email,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        // 个人资料
        const PopupMenuItem<String>(
          value: 'profile',
          child: Row(
            children: [
              Icon(Icons.account_circle, size: 18),
              SizedBox(width: 10),
              Text('个人资料'),
            ],
          ),
        ),
        // 修改密码
        const PopupMenuItem<String>(
          value: 'password',
          child: Row(
            children: [
              Icon(Icons.lock, size: 18),
              SizedBox(width: 10),
              Text('修改密码'),
            ],
          ),
        ),
        const PopupMenuDivider(),
        // 退出登录
        const PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.logout, size: 18),
              SizedBox(width: 10),
              Text('退出登录'),
            ],
          ),
        ),
      ],
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundColor: Color(0xFF0078D4),
              child: Icon(Icons.person, size: 20, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Text(
              username,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_drop_down, size: 20),
          ],
        ),
      ),
    );
  }
}
