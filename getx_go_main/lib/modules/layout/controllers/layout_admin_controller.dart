import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_go_main/modules/layout/layout.dart';
import 'package:go_router/go_router.dart';
import '../../../models/menu_item.dart';
import '../../../services/menu_service.dart';
import '../../../utils/menu_utils.dart';
import '../../../config/menu_config.dart';
import '../../dashbord/dashbord.dart';



class LayoutAdminController extends GetxController {
  BuildContext? _context;
  final RxString currentPage = ''.obs;
  final RxBool isMenuExpanded = true.obs;
  late VoidCallback _routeListener;
  final RxList<MenuItem> menuItems = <MenuItem>[].obs;
  
  /// 菜单服务
  final MenuService _menuService = MenuService();
  
  /// 菜单层级关系（自动从菜单配置中构建）
  Map<String, List<String>> _menuHierarchy = {};

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
  
  /// 初始化菜单（支持异步加载）
  Future<void> initializeMenuAsync() async {
    // 从服务获取菜单（支持本地静态菜单和服务器动态菜单）
    final menus = await _menuService.getMenus();
    menuItems.value = menus;
    
    // 自动构建菜单层级关系
    _menuHierarchy = MenuUtils.buildMenuHierarchy(menus);
    
    print('菜单初始化完成，共 ${MenuUtils.getAllRoutes(menus).length} 个路由');
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


  // 初始化菜单（同步方式，用于快速启动）
  // 现在只需要从 MenuConfig 获取静态菜单即可
  void _initializeMenu() {
    menuItems.value = MenuConfig.getStaticMenus();
    _menuHierarchy = MenuUtils.buildMenuHierarchy(menuItems);
  }

  // 获取当前页面内容
  Widget getCurrentPageContent() {
    final currentRoute = currentPage.value;
    // 使用 MenuUtils 查找页面
    final page = MenuUtils.getPageByRoute(menuItems, currentRoute);
    
    // 如果没有找到对应的页面，返回默认的仪表板页面
    return page ?? const DashboardPage();
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

  // 根据当前路由展开相应的父菜单（现在自动从菜单层级关系中获取）
  void _ensureParentMenusExpanded(String route) {
    MenuUtils.ensureParentMenusExpanded(
      menuItems,
      route,
      _menuHierarchy,
      () => menuItems.refresh(),
    );
  }

  // 切换菜单展开状态
  void toggleMenuExpansion() {
    isMenuExpanded.value = !isMenuExpanded.value;
  }

  // 切换菜单项展开状态
  void toggleMenuItemExpansion(String itemId) {
    MenuUtils.toggleMenuItemExpansion(
      menuItems,
      itemId,
      () => menuItems.refresh(),
    );
  }
  
  /// 刷新菜单（从服务器重新加载）
  Future<void> refreshMenus() async {
    final menus = await _menuService.refreshMenus();
    menuItems.value = menus;
    _menuHierarchy = MenuUtils.buildMenuHierarchy(menus);
  }
  
  /// 切换到服务器菜单
  Future<void> switchToServerMenus() async {
    _menuService.setUseServerMenus(true);
    await refreshMenus();
  }
  
  /// 切换到本地菜单
  void switchToLocalMenus() {
    _menuService.setUseServerMenus(false);
    _initializeMenu();
  }

}
