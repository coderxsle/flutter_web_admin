import 'package:book_store_admin/pages/statistics/statistics_page.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../pages/auth/login_page.dart';
import '../pages/books/book_list_page.dart';
import '../pages/categories/category_list_page.dart';
import '../pages/packages/package_list_page.dart';
import '../pages/orders/order_list_page.dart';
import '../pages/users/user_list_page.dart';
import '../layouts/main_layout.dart';
import '../pages/combo_sales/combo_sales_page.dart';
// 系统管理模块相关页面
import '../pages/system/system_home_page.dart';
import '../pages/system/users/system_user_list_page.dart';
import '../pages/system/roles/system_role_list_page.dart';
import '../pages/system/resources/system_resource_list_page.dart';

class Routes {
  static const String login = '/login';
  static const String system = '/system';
  static const String books = '/books';
  static const String categories = '/categories';
  static const String packages = '/packages';
  static const String orders = '/orders';
  static const String users = '/users';
  static const String statistics = '/statistics';
  static const String comboSales = '/combo-sales';
  
  // 系统管理模块相关路由
  static const String systemHome = '/system/home';
  static const String systemUsers = '/system/users';
  static const String systemRoles = '/system/roles';
  static const String systemResources = '/system/resources';
  static const String systemLogs = '/system/logs';

  static final List<GetPage> pages = [
    _createPage(login, const LoginPage()),
    _createPage(system, const SystemHomePage()),
    _createPage(books, const BookListPage()),
    _createPage(categories, const CategoryListPage()),
    _createPage(packages, const PackageListPage()),
    _createPage(orders, const OrderListPage()),
    _createPage(users, const UserListPage()),
    _createPage(statistics, const StatisticsPage()),
    _createPage(comboSales, const ComboSalesPage()),

    // 系统管理模块相关页面
    _createPage(systemHome, const SystemHomePage()),
    _createPage(systemUsers, const SystemUserListPage()),
    _createPage(systemRoles, const SystemRoleListPage()),
    _createPage(systemResources, const SystemResourceListPage()),
    // _createPage(systemLogs, const SystemLogListPage()),
  ];
  
  static GetPage _createPage(String name, Widget page) {
    return GetPage(name: name, page: () => MainLayout(child: page));
  }
}

