import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/web/components/serverpod_page.dart';

import 'system/auth_routes.dart';
import 'modules/book_routes.dart';
import 'cors_middleware.dart';
import 'system/dept_routes.dart';
import 'system/dict_code_routes.dart';
import 'system/dict_data_routes.dart';
import 'system/menu_routes.dart';
import 'system/role_routes.dart';
import 'system/health_routes.dart';
import 'system/user_routes.dart';

// class RootRoute extends WidgetRoute {
//   @override
//   Future<WebWidget> build(Session session, Request request) async {
//     return ServerpodPageWidget();
//   }
// }


/// 服务器中所有 REST 表现层的路由注册。
class RoutesManager {

  /// 注册 REST 表现层（`/api/**`）—— 全部接口的唯一入口（8082）。
  /// 这一层不写任何 ORM 调用，全部委托给 services/system/ 下的 Service。
  /// 详见 lib/src/web/routes/api/api_routes.dart。
  static void registerApiRoutes(Serverpod pod) {

    // 将 admin 前端应用挂载到网站根路径，访问 http://localhost:8082/ 即可打开。
    // 同时保留 /admin 入口，兼容已有书签或外部链接。
    RoutesManager.mountSpa(pod, '/', 'web/admin');
    RoutesManager.mountSpa(pod, '/admin', 'web/admin');
    RoutesManager.mountTemplatePage(pod, '/templates', 'web/templates');


    // 浏览器跨域（Vite dev server → 8082）需要的 CORS 头。
    // Serverpod 的 `cors:` 配置只管 API server，Web Server 这条链路得自己补。
    // 来源白名单默认是本地开发端口，可用环境变量 `CORS_ORIGINS` 覆盖。
    pod.webServer.addMiddleware(CorsMiddleware().asMiddleware, '/api');

    // 认证资源
    // 三条动作路由背后没有表、也没有 CRUD 半边（泛型的 `T` 填不出来），
    // 只能各挂完整路径，并不进任何资源挂载点。
    registerAuthRoutes(pod);

    pod.webServer.addRoute(UserRoute(), '/api/user');
    pod.webServer.addRoute(RoleRoute(), '/api/role');
    pod.webServer.addRoute(MenuRoute(), '/api/menu');

    // 没有业务动作、或动作并不进来的资源：直接走通用的资源挂载。
    pod.webServer.addRoute(DictDataRoute(), '/api/dictData');
    pod.webServer.addRoute(DictCodeRoute(), '/api/dictCode');
    pod.webServer.addRoute(DeptRoute(), '/api/dept');

    // registerDictActionRoutes(pod);
    registerSystemActionRoutes(pod);

    // registerAirtableActionRoutes(pod);

    // 图书资源
    pod.webServer.addRoute(BookRoute(), '/api/book');

  }


  /// 将一个前端单页应用（SPA）挂载到 Serverpod 的 Web Server 上。
  ///
  /// [prefix] 是浏览器访问该站点时使用的 URL 前缀，例如 `/admin`；
  /// [dir] 是相对于服务器工作目录的前端构建产物目录，例如 `web/admin`。
  ///
  /// `SpaRoute` 会先从 [dir] 中查找请求的静态文件；文件不存在时，回退到
  /// `dir/index.html`，这样 Vue Router 使用 history 模式时，直接刷新子路由
  /// 也不会因为服务器找不到对应文件而返回 404。
  ///
  /// 前端构建时的 `base` 必须与 [prefix] 保持一致。例如：
  ///
  /// ```text
  /// VITE_BASE=/admin/
  /// web/admin/index.html
  /// ```
  ///
  /// 然后通过 `http://localhost:8082/admin/` 访问。
  static void mountSpa(Serverpod pod, String prefix, String dir) {
    final root = path.join(Directory.current.path, dir);
    pod.webServer.addRoute(
      SpaRoute(Directory(root), fallback: File(path.join(root, 'index.html'))),
      prefix,
    );
  }

  /// 挂载一个由 Serverpod 模板渲染的页面，并单独提供其静态资源。
  static void mountTemplatePage(Serverpod pod, String prefix, String dir) {
    final root = path.join(Directory.current.path, dir);
    pod.webServer.addRoute(ServerpodPageRoute(), prefix);
    pod.webServer.addRoute(StaticRoute.directory(Directory(path.join(root, 'static'))), '$prefix/static');
  }
}

