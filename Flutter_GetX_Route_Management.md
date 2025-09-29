# Flutter GetX 路由管理方案

## 概述

本文档提供了两种 Flutter + GetX 路由管理的简化方案，用于替代复杂的路由配置，实现类似 Vue Router 的 `meta` 字段功能。

## 方案二：Map 存储元数据（推荐）

### 1. 核心类定义

```dart
// lib/routes/route_meta.dart
class RouteMeta {
  final String? title;
  final IconData? icon;
  final bool hidden;
  final bool affix;
  final bool keepAlive;
  final List<String>? roles;
  final int? sort;
  final bool showInTabs;
  final bool breadcrumb;

  const RouteMeta({
    this.title,
    this.icon,
    this.hidden = false,
    this.affix = false,
    this.keepAlive = false,
    this.roles,
    this.sort = 0,
    this.showInTabs = true,
    this.breadcrumb = true,
  });

  RouteMeta copyWith({
    String? title,
    IconData? icon,
    bool? hidden,
    bool? affix,
    bool? keepAlive,
    List<String>? roles,
    int? sort,
    bool? showInTabs,
    bool? breadcrumb,
  }) {
    return RouteMeta(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      hidden: hidden ?? this.hidden,
      affix: affix ?? this.affix,
      keepAlive: keepAlive ?? this.keepAlive,
      roles: roles ?? this.roles,
      sort: sort ?? this.sort,
      showInTabs: showInTabs ?? this.showInTabs,
      breadcrumb: breadcrumb ?? this.breadcrumb,
    );
  }
}
```

### 2. 路由配置

```dart
// lib/routes/app_routes.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'route_meta.dart';
import '../pages/home/home_page.dart';
import '../pages/profile/profile_page.dart';
import '../pages/login/login_page.dart';
import '../pages/error/error_page.dart';
import '../bindings/home_binding.dart';
import '../bindings/profile_binding.dart';
import '../bindings/login_binding.dart';

class AppRoutes {
  // 路由名称常量
  static const String home = '/home';
  static const String profile = '/profile';
  static const String login = '/login';
  static const String error = '/error';
  static const String redirect = '/redirect';

  // 路由配置
  static final List<GetPage> routes = [
    // 首页
    GetPage(
      name: home,
      page: () => const HomePage(),
      binding: HomeBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    
    // 个人中心
    GetPage(
      name: profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    
    // 登录页
    GetPage(
      name: login,
      page: () => const LoginPage(),
      binding: LoginBinding(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    
    // 错误页
    GetPage(
      name: error,
      page: () => const ErrorPage(),
      transition: Transition.fadeIn,
    ),
    
    // 重定向页
    GetPage(
      name: redirect,
      page: () => const RedirectPage(),
      transition: Transition.fadeIn,
    ),
  ];

  // 路由元数据配置
  static final Map<String, RouteMeta> _routeMeta = {
    home: const RouteMeta(
      title: '首页',
      icon: Icons.home,
      affix: true,
      keepAlive: true,
      showInTabs: true,
      breadcrumb: false,
      sort: 1,
    ),
    
    profile: const RouteMeta(
      title: '个人中心',
      icon: Icons.person,
      hidden: false,
      keepAlive: true,
      showInTabs: true,
      breadcrumb: true,
      sort: 2,
      roles: ['user', 'admin'],
    ),
    
    login: const RouteMeta(
      title: '登录',
      icon: Icons.login,
      hidden: true,
      showInTabs: false,
      breadcrumb: false,
    ),
    
    error: const RouteMeta(
      title: '错误页面',
      hidden: true,
      showInTabs: false,
      breadcrumb: false,
    ),
    
    redirect: const RouteMeta(
      title: '重定向',
      hidden: true,
      showInTabs: false,
      breadcrumb: false,
    ),
  };

  // 获取路由元数据
  static RouteMeta? getMeta(String routeName) {
    return _routeMeta[routeName];
  }

  // 获取所有可见路由（用于菜单生成）
  static List<String> getVisibleRoutes() {
    return _routeMeta.entries
        .where((entry) => !entry.value.hidden)
        .map((entry) => entry.key)
        .toList()
      ..sort((a, b) {
        final metaA = _routeMeta[a];
        final metaB = _routeMeta[b];
        return (metaA?.sort ?? 0).compareTo(metaB?.sort ?? 0);
      });
  }

  // 获取固定标签页路由
  static List<String> getAffixRoutes() {
    return _routeMeta.entries
        .where((entry) => entry.value.affix)
        .map((entry) => entry.key)
        .toList();
  }

  // 获取可缓存路由
  static List<String> getKeepAliveRoutes() {
    return _routeMeta.entries
        .where((entry) => entry.value.keepAlive)
        .map((entry) => entry.key)
        .toList();
  }

  // 检查路由权限
  static bool hasPermission(String routeName, List<String> userRoles) {
    final meta = getMeta(routeName);
    if (meta?.roles == null || meta!.roles!.isEmpty) {
      return true; // 无权限要求
    }
    return meta.roles!.any((role) => userRoles.contains(role));
  }

  // 获取面包屑路由
  static List<String> getBreadcrumbRoutes(String currentRoute) {
    // 这里可以根据实际需求实现面包屑逻辑
    return [home, currentRoute];
  }
}
```

### 3. 使用示例

#### 菜单控制器
```dart
// lib/controllers/menu_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class MenuItem {
  final String title;
  final IconData? icon;
  final String route;
  final bool isActive;

  const MenuItem({
    required this.title,
    this.icon,
    required this.route,
    this.isActive = false,
  });
}

class MenuController extends GetxController {
  final RxString currentRoute = ''.obs;
  final RxList<MenuItem> menuItems = <MenuItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _updateMenuItems();
    _listenRouteChanges();
  }

  void _updateMenuItems() {
    final visibleRoutes = AppRoutes.getVisibleRoutes();
    final items = visibleRoutes.map((route) {
      final meta = AppRoutes.getMeta(route);
      return MenuItem(
        title: meta?.title ?? route,
        icon: meta?.icon,
        route: route,
        isActive: currentRoute.value == route,
      );
    }).toList();
    
    menuItems.value = items;
  }

  void _listenRouteChanges() {
    ever(currentRoute, (_) => _updateMenuItems());
  }

  void updateCurrentRoute(String route) {
    currentRoute.value = route;
  }

  void navigateTo(String route) {
    Get.toNamed(route);
    updateCurrentRoute(route);
  }
}
```

#### 标签页控制器
```dart
// lib/controllers/tabs_controller.dart
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class TabItem {
  final String route;
  final String title;
  final bool isAffix;
  final bool isActive;

  const TabItem({
    required this.route,
    required this.title,
    this.isAffix = false,
    this.isActive = false,
  });
}

class TabsController extends GetxController {
  final RxList<TabItem> tabList = <TabItem>[].obs;
  final RxString currentTab = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _initAffixTabs();
    _listenRouteChanges();
  }

  void _initAffixTabs() {
    final affixRoutes = AppRoutes.getAffixRoutes();
    final affixTabs = affixRoutes.map((route) {
      final meta = AppRoutes.getMeta(route);
      return TabItem(
        route: route,
        title: meta?.title ?? route,
        isAffix: true,
      );
    }).toList();
    
    tabList.value = affixTabs;
  }

  void _listenRouteChanges() {
    ever(currentTab, (_) => _updateActiveTab());
  }

  void _updateActiveTab() {
    final updatedTabs = tabList.map((tab) {
      return tab.copyWith(isActive: tab.route == currentTab.value);
    }).toList();
    tabList.value = updatedTabs;
  }

  void addTab(String route) {
    final meta = AppRoutes.getMeta(route);
    if (meta?.showInTabs == false) return;

    final existingTab = tabList.firstWhereOrNull((tab) => tab.route == route);
    if (existingTab != null) {
      currentTab.value = route;
      return;
    }

    final newTab = TabItem(
      route: route,
      title: meta?.title ?? route,
      isAffix: meta?.affix ?? false,
    );

    tabList.add(newTab);
    currentTab.value = route;
  }

  void removeTab(String route) {
    final tab = tabList.firstWhereOrNull((tab) => tab.route == route);
    if (tab?.isAffix == true) return;

    tabList.removeWhere((tab) => tab.route == route);
    
    if (currentTab.value == route && tabList.isNotEmpty) {
      currentTab.value = tabList.last.route;
      Get.toNamed(tabList.last.route);
    }
  }

  void closeAllTabs() {
    final affixTabs = tabList.where((tab) => tab.isAffix).toList();
    tabList.value = affixTabs;
    
    if (affixTabs.isNotEmpty) {
      currentTab.value = affixTabs.first.route;
      Get.toNamed(affixTabs.first.route);
    }
  }
}
```

#### 面包屑控制器
```dart
// lib/controllers/breadcrumb_controller.dart
import 'package:get/get.dart';
import '../routes/app_routes.dart';

class BreadcrumbItem {
  final String title;
  final String route;
  final bool isLast;

  const BreadcrumbItem({
    required this.title,
    required this.route,
    this.isLast = false,
  });
}

class BreadcrumbController extends GetxController {
  final RxList<BreadcrumbItem> breadcrumbItems = <BreadcrumbItem>[].obs;

  void updateBreadcrumb(String currentRoute) {
    final routes = AppRoutes.getBreadcrumbRoutes(currentRoute);
    final items = routes.map((route) {
      final meta = AppRoutes.getMeta(route);
      final isLast = route == currentRoute;
      
      return BreadcrumbItem(
        title: meta?.title ?? route,
        route: route,
        isLast: isLast,
      );
    }).toList();
    
    breadcrumbItems.value = items;
  }

  void navigateToBreadcrumb(String route) {
    Get.toNamed(route);
  }
}
```

#### 权限中间件
```dart
// lib/middlewares/auth_middleware.dart
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../controllers/auth_controller.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    final authController = Get.find<AuthController>();
    
    // 检查路由权限
    if (route != null && !AppRoutes.hasPermission(route, authController.userRoles)) {
      return const RouteSettings(name: '/login');
    }
    
    return null;
  }
}
```

## 方案三：注解方式（简化版）

### 1. 注解定义

```dart
// lib/annotations/route_config.dart
class RouteConfig {
  final String? title;
  final IconData? icon;
  final bool hidden;
  final bool affix;
  final bool keepAlive;
  final List<String>? roles;
  final int? sort;
  final bool showInTabs;
  final bool breadcrumb;

  const RouteConfig({
    this.title,
    this.icon,
    this.hidden = false,
    this.affix = false,
    this.keepAlive = false,
    this.roles,
    this.sort = 0,
    this.showInTabs = true,
    this.breadcrumb = true,
  });
}
```

### 2. 页面使用注解

```dart
// lib/pages/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../annotations/route_config.dart';
import '../../controllers/home_controller.dart';

@RouteConfig(
  title: '首页',
  icon: Icons.home,
  affix: true,
  keepAlive: true,
  showInTabs: true,
  breadcrumb: false,
  sort: 1,
)
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('首页'),
          ),
          body: const Center(
            child: Text('欢迎来到首页'),
          ),
        );
      },
    );
  }
}
```

```dart
// lib/pages/profile/profile_page.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../annotations/route_config.dart';
import '../../controllers/profile_controller.dart';

@RouteConfig(
  title: '个人中心',
  icon: Icons.person,
  hidden: false,
  keepAlive: true,
  showInTabs: true,
  breadcrumb: true,
  sort: 2,
  roles: ['user', 'admin'],
)
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('个人中心'),
          ),
          body: const Center(
            child: Text('个人中心页面'),
          ),
        );
      },
    );
  }
}
```

### 3. 注解解析器

```dart
// lib/utils/route_annotation_parser.dart
import 'dart:mirrors';
import '../annotations/route_config.dart';
import '../routes/route_meta.dart';

class RouteAnnotationParser {
  static final Map<Type, RouteMeta> _cache = {};

  static RouteMeta? getRouteMeta(Type pageType) {
    if (_cache.containsKey(pageType)) {
      return _cache[pageType];
    }

    final classMirror = reflectClass(pageType);
    final annotations = classMirror.metadata;
    
    for (final annotation in annotations) {
      if (annotation.reflectee is RouteConfig) {
        final config = annotation.reflectee as RouteConfig;
        final meta = RouteMeta(
          title: config.title,
          icon: config.icon,
          hidden: config.hidden,
          affix: config.affix,
          keepAlive: config.keepAlive,
          roles: config.roles,
          sort: config.sort,
          showInTabs: config.showInTabs,
          breadcrumb: config.breadcrumb,
        );
        
        _cache[pageType] = meta;
        return meta;
      }
    }
    
    return null;
  }

  static void clearCache() {
    _cache.clear();
  }
}
```

### 4. 路由配置（注解版）

```dart
// lib/routes/app_routes_annotation.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/home/home_page.dart';
import '../pages/profile/profile_page.dart';
import '../pages/login/login_page.dart';
import '../utils/route_annotation_parser.dart';

class AppRoutesAnnotation {
  static final List<GetPage> routes = [
    GetPage(
      name: '/home',
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: '/profile',
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: '/login',
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
  ];

  // 通过注解获取路由元数据
  static RouteMeta? getMeta(Type pageType) {
    return RouteAnnotationParser.getRouteMeta(pageType);
  }

  // 获取所有可见路由
  static List<String> getVisibleRoutes() {
    final visibleRoutes = <String>[];
    
    for (final route in routes) {
      final meta = getMeta(route.page.runtimeType);
      if (meta?.hidden != true) {
        visibleRoutes.add(route.name);
      }
    }
    
    return visibleRoutes;
  }
}
```

## 使用建议

### 推荐使用方案二的原因：

1. **简单直观** - 不需要反射和注解解析
2. **性能更好** - 直接 Map 查找，无反射开销
3. **类型安全** - 编译时检查，无运行时错误
4. **易于调试** - 配置集中，问题定位容易
5. **可维护性强** - 修改配置不需要重新编译页面

### 方案三适用场景：

1. **页面数量较少** - 反射开销可接受
2. **配置变更频繁** - 注解方式更直观
3. **团队偏好注解** - 符合某些团队的编码习惯

## 总结

两种方案都能实现类似 Vue Router `meta` 字段的功能，但方案二更实用、性能更好，推荐在生产环境中使用。方案三适合小项目或对注解有特殊偏好的团队。
