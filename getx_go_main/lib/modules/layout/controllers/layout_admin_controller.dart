import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../models/menu_item.dart';
import '../../demo/demo_page.dart';

class LayoutAdminController extends GetxController {
  BuildContext? _context;
  final RxString currentPage = ''.obs;
  final RxBool isMenuExpanded = true.obs;
  late VoidCallback _routeListener;
  final RxList<MenuItem> menuItems = <MenuItem>[].obs;

  void setContext(BuildContext context) {
    _context = context;
    // 路由变化监听器
    _setupRouteListener();
  }

  // 设置路由变化监听器
  void _setupRouteListener() {
    if (_context != null) {
      final router = GoRouter.of(_context!);
      _routeListener = () {
        _updateCurrentPage();
      };
      router.routerDelegate.addListener(_routeListener);
    }
  }

  // 移除路由监听器
  void _removeRouteListener() {
    if (_context != null) {
      final router = GoRouter.of(_context!);
      router.routerDelegate.removeListener(_routeListener);
    }
  }

  @override
  void onInit() {
    super.onInit();
    _initializeMenu();
    currentPage.value = '/admin/dashboard';
  }

  @override
  void onReady() {
    super.onReady();
    // 路由变化，从路径段获取当前页面并更新
    _updateCurrentPage();
  }

  @override
  void onClose() {
    // 移除路由监听器
    _removeRouteListener();
    super.onClose();
  }


  // 初始化菜单
  void _initializeMenu() {
    menuItems.value = [
      MenuItem(id: 'dashboard', title: '仪表板', icon: Icons.dashboard, route: '/admin/dashboard'),
      MenuItem(id: 'user_management', title: '用户管理', icon: Icons.people, children: [
        MenuItem(id: 'user_list', title: '用户列表', route: '/admin/users'),
        MenuItem(id: 'user_roles', title: '用户角色', route: '/admin/user-roles'),
        MenuItem(id: 'permissions', title: '权限管理', children: [
          MenuItem(id: 'role_permissions', title: '角色权限', route: '/admin/role-permissions'),
          MenuItem(id: 'menu_permissions', title: '菜单权限', route: '/admin/menu-permissions'),
        ]),
      ]),
      MenuItem(id: 'content_management', title: '内容管理', icon: Icons.content_copy, children: [
        MenuItem(id: 'articles', title: '文章管理', route: '/admin/articles'),
        MenuItem(id: 'categories', title: '分类管理', children: [
          MenuItem(id: 'article_categories', title: '文章分类', route: '/admin/article-categories'),
          MenuItem(id: 'product_categories', title: '产品分类', route: '/admin/product-categories'),
        ]),
      ]),
      MenuItem(id: 'system_settings', title: '系统设置', icon: Icons.settings, children: [
        MenuItem(id: 'basic_settings', title: '基础设置', route: '/admin/basic-settings'),
        MenuItem(id: 'security_settings', title: '安全设置', route: '/admin/security-settings'),
      ]),
    ];
  }



  // 获取当前页面内容
  Widget getCurrentPageContent() {
    switch (currentPage.value) {
      case '/admin/dashboard':
        return const DashboardPage();
      case '/admin/users':
        return const UsersPage();
      case '/admin/user-roles':
        return const UserRolesPage();
      case '/admin/role-permissions':
        return const RolePermissionsPage();
      case '/admin/menu-permissions':
        return const MenuPermissionsPage();
      case '/admin/articles':
        return const ArticlesPage();
      case '/admin/article-categories':
        return const ArticleCategoriesPage();
      case '/admin/product-categories':
        return const ProductCategoriesPage();
      case '/admin/basic-settings':
        return const BasicSettingsPage();
      case '/admin/security-settings':
        return const SecuritySettingsPage();
      default:
        return const DashboardPage();
    }
  }

    

  // 导航到页面
  void navigateToPage(String route) {
    currentPage.value = route;
    // 提取页面名称并更新到路径段
    final pageName = route.replaceAll('/admin/', '');
    if (_context != null) {
      GoRouter.of(_context!).go('/admin/$pageName');
    }
  }


  // 从路由更新当前页面
  void _updateCurrentPage() {
    if (_context != null) {
      final router = GoRouter.of(_context!);
      final uri = router.routerDelegate.currentConfiguration.uri;
      // 期望路径形如：/admin 或 /admin/<child>
      final segments = uri.pathSegments;
      String page = 'dashboard';
      if (segments.isNotEmpty && segments.first == 'admin') {
        if (segments.length >= 2 && segments[1].isNotEmpty) {
          page = segments[1];
        }
      }
      final newRoute = '/admin/$page';

      if (currentPage.value != newRoute) {
        currentPage.value = newRoute;
        _ensureParentMenusExpanded(newRoute);
      }
    }
  }

  // 根据当前路由展开相应的父菜单
  void _ensureParentMenusExpanded(String route) {
    final pageName = route.replaceAll('/admin/', '');
    // 定义菜单项的父子关系
    final menuHierarchy = {
      'users': ['user_management'],
      'user-roles': ['user_management'],
      'role-permissions': ['user_management', 'permissions'],
      'menu-permissions': ['user_management', 'permissions'],
      'articles': ['content_management'],
      'article-categories': ['content_management', 'categories'],
      'product-categories': ['content_management', 'categories'],
      'basic-settings': ['system_settings'],
      'security-settings': ['system_settings'],
    };
    
    final parentsToExpand = menuHierarchy[pageName] ?? [];
    
    // 展开所有需要的父菜单
    for (final parentId in parentsToExpand) {
      _expandMenuItem(parentId);
    }
  }

  // 展开菜单项
  void _expandMenuItem(String itemId) {
    _expandItemInList(menuItems, itemId);
    menuItems.refresh();
  }

  // 展开菜单项列表
  void _expandItemInList(List<MenuItem> items, String itemId) {
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

  // 切换菜单展开状态
  void toggleMenuExpansion() {
    isMenuExpanded.value = !isMenuExpanded.value;
  }

  // 切换菜单项展开状态
  void toggleMenuItemExpansion(String itemId) {
    _toggleExpansion(menuItems, itemId);
  }

  // 切换菜单项展开状态
  void _toggleExpansion(List<MenuItem> items, String itemId) {
    for (int i = 0; i < items.length; i++) {
      if (items[i].id == itemId) {
        items[i] = items[i].copyWith(isExpanded: !items[i].isExpanded);
        menuItems.refresh();
        return;
      }
      if (items[i].hasChildren) {
        _toggleExpansion(items[i].children!, itemId);
      }
    }
  }

}
