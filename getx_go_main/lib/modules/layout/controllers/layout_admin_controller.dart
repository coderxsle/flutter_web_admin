import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_go_main/modules/home/home_page.dart';
import 'package:getx_go_main/modules/layout/layout.dart';
import 'package:getx_go_main/modules/user_list/user_list.dart';
import 'package:getx_go_main/modules/user_menu_permissions/user_menu_permissions.dart';
import 'package:getx_go_main/modules/user_role/user_role.dart';
import 'package:getx_go_main/modules/user_role_permissions/user_role_permissions.dart';
import 'package:go_router/go_router.dart';
import '../../../models/menu_item.dart';
import '../../dashbord/dashbord.dart';



class LayoutAdminController extends GetxController {
  BuildContext? _context;
  final RxString currentPage = ''.obs;
  final RxBool isMenuExpanded = true.obs;
  late VoidCallback _routeListener;
  final RxList<MenuItem> menuItems = <MenuItem>[].obs;

  //====================================================================
  /// 当前布局类型
  final Rx<LayoutType> _layout = LayoutType.def.obs;
  LayoutType get layout => _layout.value;
  set layout(LayoutType value) => _layout.value = value;

  /// 菜单折叠状态
  final RxBool _menuCollapse = false.obs;
  bool get menuCollapse => _menuCollapse.value;
  set menuCollapse(bool value) => _menuCollapse.value = value;

  /// 菜单暗黑主题
  final RxBool _menuDark = false.obs;
  bool get menuDark => _menuDark.value;
  set menuDark(bool value) => _menuDark.value = value;

  /// 标签页可见性
  final RxBool _tabVisible = true.obs;
  bool get tabVisible => _tabVisible.value;
  set tabVisible(bool value) => _tabVisible.value = value;

  /// 菜单手风琴模式
  final RxBool _menuAccordion = true.obs;
  bool get menuAccordion => _menuAccordion.value;
  set menuAccordion(bool value) => _menuAccordion.value = value;

  /// 过渡动画名称
  final RxString _transitionName = 'slide-right'.obs;
  String get transitionName => _transitionName.value;
  set transitionName(String value) => _transitionName.value = value;

  /// 标签页样式
  final RxString _tab = 'line'.obs;
  String get tab => _tab.value;
  set tab(String value) => _tab.value = value;



  //===================================================================

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
    // menuItems.value = [
    //   MenuItem(id: 'dashboard', title: '仪表板', icon: Icons.dashboard, route: '/admin/dashboard', name: 'DashboardPage'),
    //   MenuItem(id: 'user_management', title: '用户管理', icon: Icons.people, children: [
    //     MenuItem(id: 'user_list', title: '用户列表', route: '/admin/users', name: 'UsersPage'),
    //     MenuItem(id: 'user_roles', title: '用户角色', route: '/admin/user_roles', name: 'UserRolesPage'),
    //     MenuItem(id: 'permissions', title: '权限管理', children: [
    //       MenuItem(id: 'role_permissions', title: '角色权限', route: '/admin/role_permissions', name: 'RolePermissionsPage'),
    //       MenuItem(id: 'menu_permissions', title: '菜单权限', route: '/admin/menu_permissions', name: 'MenuPermissionsPage'),
    //     ]),
    //   ]),
    //   MenuItem(id: 'content_management', title: '内容管理', icon: Icons.content_copy, children: [
    //     MenuItem(id: 'articles', title: '文章管理', route: '/admin/articles', name: 'ArticlesPage'),
    //     MenuItem(id: 'categories', title: '分类管理', children: [
    //       MenuItem(id: 'article_categories', title: '文章分类', route: '/admin/article_categories' , name: 'ArticleCategoriesPage'),
    //       MenuItem(id: 'product_categories', title: '产品分类', route: '/admin/product_categories' , name: 'ProductCategoriesPage'),
    //     ]),
    //   ]),
    //   MenuItem(id: 'system_settings', title: '系统设置', icon: Icons.settings, children: [
    //     MenuItem(id: 'basic_settings', title: '基础设置', icon: Icons.battery_saver_outlined, route: '/admin/basic_settings', name: 'BasicSettingsPage'),
    //     MenuItem(id: 'security_settings', title: '安全设置', route: '/admin/security_settings', name: 'SecuritySettingsPage'),
    //     MenuItem(id: 'component_examples', title: '组件示例', route: '/admin/component_demo_page', name: 'ComponentExamplesPage'),
    //   ]),
    // ];

    menuItems.value = [
      item('/admin/dashboard', '仪表板', svg: 'menu_chart.svg', page: const DashboardPage()),
      item('/admin/home', '首页', iconData: Icons.home, page: const HomePage()),
      item('/admin/users', '用户管理', iconData: Icons.people, children: [
        item('/admin/user_list', '用户列表', iconData: Icons.people, page: UserListPage()),
        item('/admin/user_roles', '用户角色', iconData: Icons.people, page: UserRolesPage()),
        item('/admin/permissions', '权限管理', iconData: Icons.power, children: [
          item('/admin/role_permissions', '角色权限', iconData: Icons.people, page: const UserRolesPermissionsPage()),
          item('/admin/menu_permissions', '菜单权限', iconData: Icons.people, page: const UserMenuPermissionsPage()),
        ])
      ]),
    ];
  }

  MenuItem item(String route, String name, {String? svg, IconData? iconData, Widget? page, List<MenuItem>? children}) {
    return MenuItem(id: route, title: name, route: route, svgIcon: svg, name: name, icon: iconData, page: page, children: children);
  }

  // 获取当前页面内容
  Widget getCurrentPageContent() {
    // 从菜单项中查找当前路由对应的页面
    final currentRoute = currentPage.value;
    final menuItem = _findMenuItemByRoute(menuItems, currentRoute);
    
    if (menuItem?.page != null) {
      return menuItem!.page!;
    }
    // 如果没有找到对应的页面，返回默认的仪表板页面
    return const DashboardPage();
  }

  // 根据路由查找菜单项
  MenuItem? _findMenuItemByRoute(List<MenuItem> items, String route) {
    for (final item in items) {
      if (item.route == route && item.page != null) {
        return item;
      }
      if (item.hasChildren) {
        final found = _findMenuItemByRoute(item.children!, route);
        if (found != null) {
          return found;
        }
      }
    }
    return null;
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
      'user_roles': ['user_management'],
      'role_permissions': ['user_management', 'permissions'],
      'menu_permissions': ['user_management', 'permissions'],
      'articles': ['content_management'],
      'article_categories': ['content_management', 'categories'],
      'product_categories': ['content_management', 'categories'],
      'basic_settings': ['system_settings'],
      'security_settings': ['system_settings'],
      'component_demo_page': ['system_settings'],
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
