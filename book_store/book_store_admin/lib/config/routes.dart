import 'package:book_store_admin/pages/statistics/statistics_page.dart';
import 'package:get/get.dart';
import '../pages/auth/login_page.dart';
import '../pages/books/book_list_page.dart';
import '../pages/categories/category_list_page.dart';
import '../pages/packages/package_list_page.dart';
import '../pages/orders/order_list_page.dart';
import '../pages/users/user_list_page.dart';

class Routes {
  static const String login = '/login';
  static const String books = '/books';
  static const String categories = '/categories';
  static const String packages = '/packages';
  static const String orders = '/orders';
  static const String users = '/users';
  static const String statistics = '/statistics';

  static final List<GetPage> pages = [
    GetPage(
      name: login,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: books,
      page: () => const BookListPage(),
    ),
    GetPage(
      name: categories,
      page: () => const CategoryListPage(),
    ),
    GetPage(
      name: packages,
      page: () => const PackageListPage(),
    ),
    GetPage(
      name: orders,
      page: () => const OrderListPage(),
    ),
    GetPage(
      name: users,
      page: () => const UserListPage(),
    ),
    GetPage(
      name: statistics,
      page: () => const StatisticsPage(),
    ),
  ];
} 