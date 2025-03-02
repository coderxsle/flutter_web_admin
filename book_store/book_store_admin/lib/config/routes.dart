import 'package:book_store_admin/pages/statistics/statistics_page.dart';
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
import '../pages/system/users/user_list_page.dart' as sys_user;
import '../pages/system/roles/role_list_page.dart';
import '../pages/system/resources/resource_list_page.dart';

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
    GetPage(
      name: login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: system,
      page: () => const MainLayout(
        child: SystemHomePage(),
      ),
    ),
    GetPage(
      name: books,
      page: () => const MainLayout(
        child: BookListPage(),
      ),
    ),
    GetPage(
      name: categories,
      page: () => const MainLayout(
        child: CategoryListPage(),
      ),
    ),
    GetPage(
      name: packages,
      page: () => const MainLayout(
        child: PackageListPage(),
      ),
    ),
    GetPage(
      name: orders,
      page: () => const MainLayout(
        child: OrderListPage(),
      ),
    ),
    GetPage(
      name: users,
      page: () => const MainLayout(
        child: UserListPage(),
      ),
    ),
    GetPage(
      name: statistics,
      page: () => const MainLayout(
        child: StatisticsPage(),
      ),
    ),
    GetPage(
      name: comboSales,
      page: () => const MainLayout(
        child: ComboSalesPage(),
      ),
    ),
    
    // 系统管理模块相关页面
    GetPage(
      name: systemHome,
      page: () => const MainLayout(
        child: SystemHomePage(),
      ),
    ),
    GetPage(
      name: systemUsers,
      page: () => const MainLayout(
        child: sys_user.UserListPage(),
      ),
    ),
    GetPage(
      name: systemRoles,
      page: () => const MainLayout(
        child: RoleListPage(),
      ),
    ),
    GetPage(
      name: systemResources,
      page: () => const MainLayout(
        child: ResourceListPage(),
      ),
    ),
  ];
} 