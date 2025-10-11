import 'package:flutter/material.dart';
import 'package:getx_go_main/models/menu_item.dart';
import 'package:getx_go_main/modules/home/home_page.dart';
import 'package:getx_go_main/modules/user_list/user_list.dart';
import 'package:getx_go_main/modules/user_menu_permissions/user_menu_permissions.dart';
import 'package:getx_go_main/modules/user_role/user_role.dart';
import 'package:getx_go_main/modules/user_role_permissions/user_role_permissions.dart';
import '../modules/dashbord/dashbord.dart';
import '../modules/demo/pages/demo_page.dart';
import '../modules/demo/pages/api_test_page.dart';
import '../modules/demo/pages/gi_arco_button_page.dart';
import '../modules/demo/pages/gi_arrow_popup_demo_page.dart';
import '../modules/demo/pages/gi_dot_page.dart';
import '../modules/demo/pages/gi_icon_box_page.dart';
import '../modules/demo/pages/gi_icon_selector_page.dart';
import '../modules/demo/pages/gi_js_modal_page.dart';
import '../modules/demo/pages/gi_pagination_demo_page.dart';
import '../modules/demo/pages/gi_space_page.dart';
import '../modules/demo/pages/gi_tag_page.dart';
import '../modules/demo/pages/layout_demo_page.dart';

/// 菜单配置类 - 统一管理所有菜单配置
/// 只需在这里配置一次，系统会自动处理路由注册、父子关系等
class MenuConfig {
  /// 静态菜单配置（本地菜单）
  /// 这是唯一需要配置菜单的地方！
  static List<MenuItem> getStaticMenus() {
    return [
      _menu('/home', '首页', 
        iconData: Icons.home, 
        page: const HomePage()
      ),
      
      _menu('/dashboard', '仪表板', 
        svg: 'menu_chart.svg', 
        page: const DashboardPage()
      ),
      
      _menu('/users', '用户管理', 
        iconData: Icons.people, 
        children: [
          _menu('/user_list', '用户列表', 
            iconData: Icons.people, 
            page: UserListPage()
          ),
          _menu('/user_roles', '用户角色', 
            iconData: Icons.people, 
            page: UserRolesPage()
          ),
          _menu('/permissions', '权限管理', 
            iconData: Icons.power, 
            children: [
              _menu('/role_permissions', '角色权限', 
                iconData: Icons.people, 
                page: const UserRolesPermissionsPage()
              ),
              _menu('/menu_permissions', '菜单权限', 
                iconData: Icons.people, 
                page: const UserMenuPermissionsPage()
              ),
            ]
          )
        ]
      ),
      
      _menu('/components', '组件示例', 
        iconData: Icons.widgets, 
        children: [
          _menu('/demo', '组件展示', 
            iconData: Icons.dashboard_customize, 
            page: const DemoPage()
          ),
          _menu('/api_test', '接口测试', 
            iconData: Icons.api, 
            page: const ApiTestPage(title: '接口测试')
          ),
          _menu('/gi_button', '按钮组件', 
            iconData: Icons.smart_button, 
            page: const GiArcoButtonDemoPage(title: '按钮组件')
          ),
          _menu('/gi_tag', '标签组件', 
            iconData: Icons.label, 
            page: const GiTagDemoPage(title: 'GiTag 组件演示')
          ),
          _menu('/gi_space', '间距组件', 
            iconData: Icons.space_bar, 
            page: const GiSpaceDemoPage(title: 'GiSpace 间距组件')
          ),
          _menu('/gi_icon_box', '图标盒子', 
            iconData: Icons.widgets, 
            page: const GiIconBoxDemoPage(title: 'GiIconBox 图标盒子组件')
          ),
          _menu('/gi_dot', '圆点组件', 
            iconData: Icons.circle, 
            page: const GiDotDemoPage(title: 'GiDot 圆点组件')
          ),
          _menu('/gi_icon_selector', '图标选择器', 
            iconData: Icons.select_all, 
            page: const GiIconSelectorDemoPage(title: 'GiIconSelector 图标选择器')
          ),
          _menu('/gi_pagination', '分页组件', 
            iconData: Icons.pageview, 
            page: const GiPaginationDemoPage(title: 'GiPagination 分页组件')
          ),
          _menu('/gi_arrow_popup', '箭头弹出', 
            iconData: Icons.arrow_drop_down, 
            page: const GiArrowPopupDemoPage(title: 'GiArrowPopupWrapper 箭头弹出组件')
          ),
          _menu('/gi_js_modal', '函数调用模态框', 
            iconData: Icons.call_to_action, 
            page: const GiJsModalPage(title: '函数调用模态框')
          ),
          _menu('/layout_demo', '布局系统演示', 
            iconData: Icons.dashboard_customize, 
            page: const LayoutDemoPage()
          ),
        ]
      ),
    ];
  }

  /// 创建菜单项的辅助方法
  static MenuItem _menu(
    String route, 
    String title, {
    String? svg, 
    IconData? iconData, 
    Widget? page, 
    List<MenuItem>? children
  }) {
    return MenuItem(
      id: route,
      title: title,
      route: route,
      svgIcon: svg,
      name: title,
      icon: iconData,
      page: page,
      children: children,
    );
  }

  /// 从服务器数据构建菜单
  /// 服务器返回的菜单数据格式示例：
  /// {
  ///   "route": "/home",
  ///   "title": "首页",
  ///   "icon": "home", // 或 "iconData": "Icons.home"
  ///   "svgIcon": "menu_home.svg", // 可选
  ///   "children": [...] // 可选
  /// }
  static List<MenuItem> fromServerData(List<Map<String, dynamic>> serverMenus) {
    return serverMenus.map((data) => _buildMenuFromData(data)).toList();
  }

  /// 从服务器数据构建单个菜单项
  static MenuItem _buildMenuFromData(Map<String, dynamic> data) {
    // 解析图标
    IconData? iconData;
    if (data['iconData'] != null) {
      iconData = _parseIconData(data['iconData']);
    }

    // 解析子菜单
    List<MenuItem>? children;
    if (data['children'] != null && data['children'] is List) {
      children = (data['children'] as List)
          .map((child) => _buildMenuFromData(child as Map<String, dynamic>))
          .toList();
    }

    // 获取页面组件（如果服务器返回了组件名称，可以通过工厂模式创建）
    Widget? page;
    if (data['componentName'] != null) {
      page = _getPageByName(data['componentName']);
    }

    return MenuItem(
      id: data['route'] ?? data['id'],
      title: data['title'],
      route: data['route'],
      svgIcon: data['svgIcon'],
      name: data['title'],
      icon: iconData,
      page: page,
      children: children,
    );
  }

  /// 根据图标名称解析 IconData
  static IconData? _parseIconData(String iconName) {
    // 这里可以根据字符串名称返回对应的图标
    // 示例：
    final iconMap = {
      'home': Icons.home,
      'dashboard': Icons.dashboard,
      'people': Icons.people,
      'settings': Icons.settings,
      'widgets': Icons.widgets,
      'api': Icons.api,
      // 添加更多图标映射
    };
    return iconMap[iconName];
  }

  /// 根据组件名称获取页面实例（页面工厂）
  static Widget? _getPageByName(String componentName) {
    // 这里可以通过工厂模式创建页面实例
    // 如果服务器返回的菜单需要动态加载页面，可以在这里实现
    final pageMap = {
      'HomePage': const HomePage(),
      'DashboardPage': const DashboardPage(),
      'UserListPage': UserListPage(),
      'UserRolesPage': UserRolesPage(),
      // 添加更多页面映射
    };
    return pageMap[componentName];
  }
}

