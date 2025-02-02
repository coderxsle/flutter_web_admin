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

class Routes {
  static const String login = '/login';
  static const String books = '/books';
  static const String categories = '/categories';
  static const String packages = '/packages';
  static const String orders = '/orders';
  static const String users = '/users';
  static const String statistics = '/statistics';
  static const String comboSales = '/combo-sales';

  static final List<GetPage> pages = [
    GetPage(
      name: login,
      page: () => const LoginPage(),
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
  ];
} 