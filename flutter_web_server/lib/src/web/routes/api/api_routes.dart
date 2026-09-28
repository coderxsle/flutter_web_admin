import 'package:serverpod/serverpod.dart';

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

void registerApiRoutes(Serverpod pod) {
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

  registerSystemActionRoutes(pod);

  // registerAirtableActionRoutes(pod);

  // 图书资源
  pod.webServer.addRoute(BookRoute(), '/api/book');

}
