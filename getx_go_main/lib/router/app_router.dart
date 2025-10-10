import 'package:go_router/go_router.dart';
import 'package:getx_go/getx_go.dart';
import 'package:getx_go_main/modules/auth/router.dart';
import 'package:getx_go_main/modules/layout/router/layout_admin_router.dart';
import 'package:getx_go_main/components/feedback/gi_acro_message.dart';


abstract class AppRouter {
  static final router = GoRouter(
    navigatorKey: GiArcoMessage.navigatorKey(),
    initialLocation: '/home',
    routes: [
      ControllerRoute(name: AppRoutes.login.name, path: AppRoutes.login.path, routeControllerConfig: LoginRouter()),
      // 使用单一路由，所有页面都在同一个 LayoutAdminRouter 实例中
      ControllerRoute(name: AppRoutes.admin.name, path: '/:page', routeControllerConfig: LayoutAdminRouter()),
    ],
  );
}

enum AppRoutes {
  login('/login'),
  admin('/'),
  home('/home'),
  feedback('/feedback'),
  counterPreview('/counter_preview'),
  taggedPage('/tagged_page');

  final String path;

  const AppRoutes(this.path);

  String get name => toString().split('.').last;
  String get initialLocation => path;
}
