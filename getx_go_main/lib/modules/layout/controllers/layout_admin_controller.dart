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
import '../../demo/pages/demo_page.dart';
import '../../demo/pages/api_test_page.dart';
import '../../demo/pages/gi_arco_button_page.dart';
import '../../demo/pages/gi_arrow_popup_demo_page.dart';
import '../../demo/pages/gi_dot_page.dart';
import '../../demo/pages/gi_icon_box_page.dart';
import '../../demo/pages/gi_icon_selector_page.dart';
import '../../demo/pages/gi_js_modal_page.dart';
import '../../demo/pages/gi_pagination_demo_page.dart';
import '../../demo/pages/gi_space_page.dart';
import '../../demo/pages/gi_tag_page.dart';
import '../../demo/pages/layout_demo_page.dart';



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
    currentPage.value = '/home';
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
    //   MenuItem(id: 'dashboard', title: '仪表板', icon: Icons.dashboard, route: '/dashboard', name: 'DashboardPage'),
    //   MenuItem(id: 'user_management', title: '用户管理', icon: Icons.people, children: [
    //     MenuItem(id: 'user_list', title: '用户列表', route: '/users', name: 'UsersPage'),
    //     MenuItem(id: 'user_roles', title: '用户角色', route: '/user_roles', name: 'UserRolesPage'),
    //     MenuItem(id: 'permissions', title: '权限管理', children: [
    //       MenuItem(id: 'role_permissions', title: '角色权限', route: '/role_permissions', name: 'RolePermissionsPage'),
    //       MenuItem(id: 'menu_permissions', title: '菜单权限', route: '/menu_permissions', name: 'MenuPermissionsPage'),
    //     ]),
    //   ]),
    //   MenuItem(id: 'content_management', title: '内容管理', icon: Icons.content_copy, children: [
    //     MenuItem(id: 'articles', title: '文章管理', route: '/articles', name: 'ArticlesPage'),
    //     MenuItem(id: 'categories', title: '分类管理', children: [
    //       MenuItem(id: 'article_categories', title: '文章分类', route: '/article_categories' , name: 'ArticleCategoriesPage'),
    //       MenuItem(id: 'product_categories', title: '产品分类', route: '/product_categories' , name: 'ProductCategoriesPage'),
    //     ]),
    //   ]),
    //   MenuItem(id: 'system_settings', title: '系统设置', icon: Icons.settings, children: [
    //     MenuItem(id: 'basic_settings', title: '基础设置', icon: Icons.battery_saver_outlined, route: '/basic_settings', name: 'BasicSettingsPage'),
    //     MenuItem(id: 'security_settings', title: '安全设置', route: '/security_settings', name: 'SecuritySettingsPage'),
    //     MenuItem(id: 'component_examples', title: '组件示例', route: '/component_demo_page', name: 'ComponentExamplesPage'),
    //   ]),
    // ];

    menuItems.value = [
      item('/home', '首页', iconData: Icons.home, page: const HomePage()),
      item('/dashboard', '仪表板', svg: 'menu_chart.svg', page: const DashboardPage()),
      item('/users', '用户管理', iconData: Icons.people, children: [
        item('/user_list', '用户列表', iconData: Icons.people, page: UserListPage()),
        item('/user_roles', '用户角色', iconData: Icons.people, page: UserRolesPage()),
        item('/permissions', '权限管理', iconData: Icons.power, children: [
          item('/role_permissions', '角色权限', iconData: Icons.people, page: const UserRolesPermissionsPage()),
          item('/menu_permissions', '菜单权限', iconData: Icons.people, page: const UserMenuPermissionsPage()),
        ])
      ]),
      item('/components', '组件示例', iconData: Icons.widgets, children: [
        item('/demo', '组件展示', iconData: Icons.dashboard_customize, page: const DemoPage()),
        item('/api_test', '接口测试', iconData: Icons.api, page: const ApiTestPage(title: '接口测试')),
        item('/gi_button', '按钮组件', iconData: Icons.smart_button, page: const GiArcoButtonDemoPage(title: '按钮组件')),
        item('/gi_tag', '标签组件', iconData: Icons.label, page: const GiTagDemoPage(title: 'GiTag 组件演示')),
        item('/gi_space', '间距组件', iconData: Icons.space_bar, page: const GiSpaceDemoPage(title: 'GiSpace 间距组件')),
        item('/gi_icon_box', '图标盒子', iconData: Icons.widgets, page: const GiIconBoxDemoPage(title: 'GiIconBox 图标盒子组件')),
        item('/gi_dot', '圆点组件', iconData: Icons.circle, page: const GiDotDemoPage(title: 'GiDot 圆点组件')),
        item('/gi_icon_selector', '图标选择器', iconData: Icons.select_all, page: const GiIconSelectorDemoPage(title: 'GiIconSelector 图标选择器')),
        item('/gi_pagination', '分页组件', iconData: Icons.pageview, page: const GiPaginationDemoPage(title: 'GiPagination 分页组件')),
        item('/gi_arrow_popup', '箭头弹出', iconData: Icons.arrow_drop_down, page: const GiArrowPopupDemoPage(title: 'GiArrowPopupWrapper 箭头弹出组件')),
        item('/gi_js_modal', '函数调用模态框', iconData: Icons.call_to_action, page: const GiJsModalPage(title: '函数调用模态框')),
        item('/layout_demo', '布局系统演示', iconData: Icons.dashboard_customize, page: const LayoutDemoPage()),
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
    // 提取页面名称并更新到路径段
    currentPage.value = route;
    if (_context != null) {
      GoRouter.of(_context!).go(currentPage.value);
    }
  }


  // 从路由更新当前页面
  void _updateCurrentPage() {
    if (_context != null) {
      final router = GoRouter.of(_context!);
      final uri = router.routerDelegate.currentConfiguration.uri;
      // 期望路径形如：/ 或 /<page>
      final segments = uri.pathSegments;
      String newRoute;
      
      if (segments.isEmpty) {
        // 路径是 '/'，默认显示 home
        newRoute = '/home';
      } else {
        // 路径是 '/<page>'，如 '/role_permissions'
        newRoute = '/${segments.first}';
      }

      if (currentPage.value != newRoute) {
        currentPage.value = newRoute;
        _ensureParentMenusExpanded(newRoute);
      }
    }
  }

  // 根据当前路由展开相应的父菜单
  void _ensureParentMenusExpanded(String route) {
    final pageName = route.replaceAll('/', '');
    // 定义菜单项的父子关系
    final menuHierarchy = {
      'user_list': ['/users'],
      'user_roles': ['/users'],
      'role_permissions': ['/users', '/permissions'],
      'menu_permissions': ['/users', '/permissions'],
      'demo': ['/components'],
      'api_test': ['/components'],
      'gi_button': ['/components'],
      'gi_tag': ['/components'],
      'gi_space': ['/components'],
      'gi_icon_box': ['/components'],
      'gi_dot': ['/components'],
      'gi_icon_selector': ['/components'],
      'gi_pagination': ['/components'],
      'gi_arrow_popup': ['/components'],
      'gi_js_modal': ['/components'],
      'layout_demo': ['/components'],
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
