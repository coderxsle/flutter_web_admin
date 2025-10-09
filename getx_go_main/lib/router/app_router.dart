import 'package:go_router/go_router.dart';
import 'package:getx_go/getx_go.dart';
import 'package:getx_go_main/modules/auth/router.dart';
import 'package:getx_go_main/modules/layout/router/layout_admin_router.dart';
import 'package:getx_go_main/components/feedback/gi_acro_message.dart';


abstract class AppRouter {
  static final router = GoRouter(
    navigatorKey: GiArcoMessage.navigatorKey(),
    initialLocation: AppRoutes.admin.initialLocation,
    routes: [
      ControllerRoute(name: AppRoutes.login.name, path: AppRoutes.login.path, routeControllerConfig: LoginRouter()),
      ControllerRoute(name: AppRoutes.admin.name, path: AppRoutes.admin.path, routeControllerConfig: LayoutAdminRouter()),
      // 支持基于路径段的 Admin 子页面：/admin/<child>
      ControllerRoute(name: 'adminPage', path: '/admin/:page', routeControllerConfig: LayoutAdminRouter()),
      // ControllerRoute(name: AppRoutes.home.name, path: AppRoutes.home.path, routeControllerConfig: HomeRouter()),
      // ControllerRoute(name: AppRoutes.feedback.name, path: AppRoutes.feedback.path, routeControllerConfig: FeedbackRouter()),
      // ControllerRoute(name: AppRoutes.counterPreview.name, path: AppRoutes.counterPreview.path, routeControllerConfig: CounterPreviewRouter()),
      // ControllerRoute(name: AppRoutes.taggedPage.name, path: AppRoutes.taggedPage.path, routeControllerConfig: TaggedPageRouter()),
    ],
  );
}

enum AppRoutes {
  login('/login'),
  admin('/admin'),
  home('/home'),
  feedback('/feedback'),
  counterPreview('/counter_preview'),
  taggedPage('/tagged_page');

  final String path;

  const AppRoutes(this.path);

  String get name => toString().split('.').last;
  String get initialLocation => path;
}
