///
/// @file GlobalController
/// @description 全局状态控制器，管理应用的全局状态和配置
///
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:side_menu/side_menu.dart';
import '../config/routes.dart';
import '../models/tab_model.dart';
import 'global.dart';

/// 全局状态控制器
/// 
/// 管理应用的全局状态，包括：
/// - 布局配置（布局类型、菜单折叠等）
/// - 主题配置（暗黑模式、主题色等）
/// - 标签页管理
/// - 菜单路由管理
/// - 用户信息管理
class GlobalController extends GetxController {
  /// 布局类型
  String _layout = 'default';
  String get layout => _layout;

  /// 菜单折叠状态
  bool _menuCollapse = false;
  bool get menuCollapse => _menuCollapse;

  /// 菜单暗黑模式
  bool _menuDark = false;
  bool get menuDark => _menuDark;

  /// 菜单手风琴模式
  bool _menuAccordion = true;
  bool get menuAccordion => _menuAccordion;

  /// 标签页可见性
  bool _tabVisible = true;
  bool get tabVisible => _tabVisible;

  /// 标签页样式
  String _tabStyle = 'line';
  String get tabStyle => _tabStyle;

  /// 暗黑模式
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  /// 过渡动画名称
  String _transitionName = 'fade';
  String get transitionName => _transitionName;

  /// 暗黑主题色
  Color _darkThemeColor = const Color(0xFF1A1A1A);
  Color get darkThemeColor => _darkThemeColor;

  /// 标签页列表
  final List<TabModel> _tabList = [];
  List<TabModel> get tabList => _tabList;

  /// 缓存列表
  final List<String> _cacheList = [];
  List<String> get cacheList => _cacheList;

  /// 重载标志
  bool _reloadFlag = true;
  bool get reloadFlag => _reloadFlag;

  /// 用户信息
  Map<String, dynamic>? get userInfo => Global.userInfo;

  /// 菜单路由列表
  List<MenuItemModel> get menuRoutes => _getMenuItems();

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
    _initializeTabs();
  }

  /// 加载设置
  void _loadSettings() {
    _layout = Global.prefs.getString('layout') ?? 'default';
    _menuCollapse = Global.prefs.getBool('menu_collapse') ?? false;
    _menuDark = Global.prefs.getBool('menu_dark') ?? false;
    _menuAccordion = Global.prefs.getBool('menu_accordion') ?? true;
    _tabVisible = Global.prefs.getBool('tab_visible') ?? true;
    _tabStyle = Global.prefs.getString('tab_style') ?? 'line';
    _isDarkMode = Global.prefs.getBool('is_dark_mode') ?? false;
    _transitionName = Global.prefs.getString('transition_name') ?? 'fade';
  }

  /// 初始化标签页
  void _initializeTabs() {
    // 添加首页标签
    final homeTab = TabModel(
      path: Routes.books,
      title: '图书管理',
      affix: true,
    );
    _tabList.add(homeTab);
    _cacheList.add('BooksPage');
  }

  /// 获取菜单项
  List<MenuItemModel> _getMenuItems() {
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

  /// 获取布局类型
  String? getLayoutType() => _layout;

  /// 设置布局类型
  void setLayout(String layout) {
    _layout = layout;
    Global.prefs.setString('layout', layout);
    update();
  }

  /// 设置菜单折叠状态
  void setMenuCollapse(bool collapse) {
    _menuCollapse = collapse;
    Global.prefs.setBool('menu_collapse', collapse);
    update();
  }

  /// 设置菜单暗黑模式
  void setMenuDark(bool dark) {
    _menuDark = dark;
    Global.prefs.setBool('menu_dark', dark);
    update();
  }

  /// 设置菜单手风琴模式
  void setMenuAccordion(bool accordion) {
    _menuAccordion = accordion;
    Global.prefs.setBool('menu_accordion', accordion);
    update();
  }

  /// 设置标签页可见性
  void setTabVisible(bool visible) {
    _tabVisible = visible;
    Global.prefs.setBool('tab_visible', visible);
    update();
  }

  /// 设置标签页样式
  void setTabStyle(String style) {
    _tabStyle = style;
    Global.prefs.setString('tab_style', style);
    update();
  }

  /// 切换主题
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    Global.prefs.setBool('is_dark_mode', _isDarkMode);
    Get.changeThemeMode(_isDarkMode ? ThemeMode.dark : ThemeMode.light);
    update();
  }

  /// 设置过渡动画
  void setTransitionName(String name) {
    _transitionName = name;
    Global.prefs.setString('transition_name', name);
    update();
  }

  /// 添加标签页
  void addTab(TabModel tab) {
    final existingIndex = _tabList.indexWhere((t) => t.path == tab.path);
    if (existingIndex == -1) {
      _tabList.add(tab);
      update();
    }
  }

  /// 关闭标签页
  void closeTab(String path) {
    if (_tabList.length <= 1) return; // 至少保留一个标签页
    
    final index = _tabList.indexWhere((tab) => tab.path == path);
    if (index != -1 && !_tabList[index].affix) {
      _tabList.removeAt(index);
      _cacheList.removeWhere((cache) => cache.contains(path));
      
      // 如果关闭的是当前页面，跳转到相邻页面
      if (Get.currentRoute == path) {
        final targetIndex = index > 0 ? index - 1 : 0;
        if (targetIndex < _tabList.length) {
          Get.toNamed(_tabList[targetIndex].path);
        }
      }
      
      update();
    }
  }

  /// 关闭右侧标签页
  void closeRightTabs(String path) {
    final index = _tabList.indexWhere((tab) => tab.path == path);
    if (index != -1 && index < _tabList.length - 1) {
      final tabsToRemove = _tabList.sublist(index + 1)
          .where((tab) => !tab.affix)
          .toList();
      
      for (final tab in tabsToRemove) {
        _tabList.remove(tab);
        _cacheList.removeWhere((cache) => cache.contains(tab.path));
      }
      
      update();
    }
  }

  /// 关闭其他标签页
  void closeOtherTabs(String path) {
    final currentTab = _tabList.firstWhereOrNull((tab) => tab.path == path);
    if (currentTab != null) {
      final affixTabs = _tabList.where((tab) => tab.affix).toList();
      _tabList.clear();
      _tabList.addAll(affixTabs);
      
      if (!currentTab.affix) {
        _tabList.add(currentTab);
      }
      
      _cacheList.clear();
      _cacheList.addAll(_tabList.map((tab) => _getPageNameByPath(tab.path)));
      
      update();
    }
  }

  /// 关闭所有标签页
  void closeAllTabs() {
    final affixTabs = _tabList.where((tab) => tab.affix).toList();
    _tabList.clear();
    _tabList.addAll(affixTabs);
    
    _cacheList.clear();
    _cacheList.addAll(_tabList.map((tab) => _getPageNameByPath(tab.path)));
    
    if (_tabList.isNotEmpty) {
      Get.toNamed(_tabList.first.path);
    }
    
    update();
  }

  /// 重载当前页面
  void reloadCurrentPage() {
    _reloadFlag = false;
    update();
    
    Future.delayed(const Duration(milliseconds: 100), () {
      _reloadFlag = true;
      update();
    });
  }

  /// 根据路径获取路由元数据
  Map<String, dynamic>? getRouteMetaByPath(String path) {
    // 这里可以根据实际路由配置返回元数据
    return null;
  }

  /// 根据路径获取页面名称
  String _getPageNameByPath(String path) {
    final routeNames = {
      Routes.books: 'BooksPage',
      Routes.users: 'UsersPage',
      Routes.orders: 'OrdersPage',
      Routes.categories: 'CategoriesPage',
      Routes.packages: 'PackagesPage',
      Routes.statistics: 'StatisticsPage',
      Routes.demo: 'DemoPage',
      Routes.systemUsers: 'SystemUsersPage',
      Routes.systemRoles: 'SystemRolesPage',
      Routes.systemResources: 'SystemResourcesPage',
      Routes.systemLogs: 'SystemLogsPage',
    };
    return routeNames[path] ?? 'UnknownPage';
  }

  /// 退出登录
  Future<void> logout() async {
    await Global.logout();
  }
}
