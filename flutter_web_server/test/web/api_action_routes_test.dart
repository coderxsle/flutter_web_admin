import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/web/routes/api/auth_api_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/dept_rest_delegate.dart';
import 'package:flutter_web_server/src/web/routes/api/dict_action_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/dict_code_rest_delegate.dart';
import 'package:flutter_web_server/src/web/routes/api/dict_data_rest_delegate.dart';
import 'package:flutter_web_server/src/web/routes/api/menu_action_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/menu_rest_delegate.dart';
import 'package:flutter_web_server/src/web/routes/api/role_action_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/role_rest_delegate.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:flutter_web_server/src/web/routes/api/system_action_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/user_action_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/user_rest_delegate.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';
import 'package:test/test.dart';

/// B 档 12 个业务动作的**装配**测试（S3）—— 只验证路由表与匹配行为，
/// 不碰数据库、不碰 Service（`RestActionRoute` 只在真正处理请求时才调 handler）。
///
/// 这里断言的都是「起服务后最难察觉」的那一类：
///
/// * **嵌套挂载会不会撞**。`/api/role/:id/menus` 这类路径是**嵌在已被 A 档
///   占用的挂载点下面**的，relic 的 `PathTrie` 只在注册那一刻校验冲突，
///   冲突了是抛异常（服务起不来）还是静默覆盖，光看代码看不出来；
/// * **字面量段会不会被参数段吃掉**。`GET /api/user/info` 与 A 档的
///   `GET /api/user/:id` 同层，如果参数段优先，`info` 会被当成 id，
///   运行期变成 400「路径参数必须是正整数」—— 而且只在真发请求时才暴露；
/// * **匿名开关有没有漏传**。`requireAuth` 默认 `true`，漏写不会报错，
///   只会让登录页/探活接口 401；
/// * **信封有没有漏传**。漏了就静默退回中立信封（`{message, data}`，**没有
///   `code`**），前端解析静默失灵。
///
/// ⚠️ 离线挂载必须挂 `'/api/x'` 而不能带 `*` 主机通配段：
/// `Router.lookupUri` 只规范化 `uri.pathSegments`（不含 host），带 `*` 的
/// 挂载点在离线查询里一条都匹配不上。生产环境的 `WebServer.addRoute` 内部是
/// `_app.injectAt('*$path', route)`，多出来的只是最前面那一段主机通配，
/// **不影响冲突检测与后续各段的优先级结论**。
Map<String, RestActionRoute> allActionRoutes() => {
  ...authActionRoutes(),
  ...userActionRoutes(),
  ...roleActionRoutes(),
  ...menuActionRoutes(),
  ...dictActionRoutes(),
  ...systemActionRoutes(),
};

BaseRestRoute<T> _resource<T extends TableRow>(
  RestCrudDelegate<T> delegate, {
  bool enableCreate = true,
}) => BaseRestRoute<T>(
  delegate: delegate,
  envelope: const ServerpodEnvelopeBuilder(),
  enableCreate: enableCreate,
);

/// 完整复刻 `registerApiRoutes` 的挂载：A 档 6 个资源 + 全部动作路由。
///
/// 之所以要「一起挂」，是因为动作路由里有 4 条嵌在资源挂载点下面 ——
/// 单独挂其中任何一个都不会报错，只有合起来才能验出冲突。
RelicRouter mountApi() {
  final app = RelicRouter();
  app.injectAt('/api/dictData', _resource<SysDictData>(DictDataRestDelegate()));
  app.injectAt('/api/dictCode', _resource<SysDictCode>(DictCodeRestDelegate()));
  app.injectAt('/api/menu', _resource<SysMenu>(MenuRestDelegate()));
  app.injectAt('/api/dept', _resource<SysDept>(DeptRestDelegate()));
  app.injectAt(
    '/api/role',
    _resource<SysRole>(RoleRestDelegate(), enableCreate: false),
  );
  app.injectAt('/api/user', _resource<SysUser>(UserRestDelegate()));
  allActionRoutes().forEach((path, route) => app.injectAt(path, route));
  return app;
}

/// 动作路由总数 = auth 3 + user 3 + role 4 + menu 1 + dict 1 + system 2。
///
/// ⚠️ 是 **14** 而不是 15：`getDictDataDetail(id, code)` 复用 A 档已有的
/// `GET /api/dictData/getDetail?id=`，刻意不造第二条重复路由
/// （见 dict_action_routes.dart）。⚠️ 也正因为复用，「`code` 参与定位」这条
/// typed 侧的约束在 REST 侧**不再成立** —— 只按 `id` 查，`code` 传了也不看。
const _actionPaths = <String>[
  '/api/auth/public-key',
  '/api/auth/login',
  '/api/auth/refresh-token',
  '/api/user/info',
  '/api/user/routes',
  '/api/user/reset-password',
  '/api/role/:id/menu-ids',
  '/api/role/:id/users',
  '/api/role/:id/users/remove',
  '/api/role/:id/menus',
  '/api/menu/options',
  '/api/dict/options',
  '/api/system/health',
  '/api/system/version',
];

/// 三条 auth + 一条字典 + 两条系统探活 = 6 条匿名。
///
/// 这条断言的价值在于**防反向**：漏写 `requireAuth: false` 会让登录/探活
/// 直接 401（且不报错）；反过来多写一个 `false` 就是越权开放，
/// 两种都要能被这条测试拦下来。
const _anonymousPaths = <String>{
  '/api/auth/public-key',
  '/api/auth/login',
  '/api/auth/refresh-token',
  '/api/dict/options',
  '/api/system/health',
  '/api/system/version',
};

void main() {
  group('动作路由表（注册源即测试源）', () {
    test('14 条路由，路径与预期一一对应', () {
      expect(allActionRoutes().keys.toSet(), _actionPaths.toSet());
      expect(allActionRoutes().length, 14);
    });

    test('方法与设计一致（含 PUT|POST 双注册的那条）', () {
      final routes = allActionRoutes();
      String methodsOf(String path) =>
          (routes[path]!.methods.map((m) => m.value).toList()..sort()).join('|');

      expect(methodsOf('/api/auth/public-key'), 'GET');
      expect(methodsOf('/api/auth/login'), 'POST');
      expect(methodsOf('/api/auth/refresh-token'), 'POST');
      expect(methodsOf('/api/user/info'), 'GET');
      expect(methodsOf('/api/user/routes'), 'GET');
      expect(methodsOf('/api/user/reset-password'), 'POST');
      expect(methodsOf('/api/role/:id/menu-ids'), 'GET');
      expect(methodsOf('/api/role/:id/users'), 'GET');
      expect(methodsOf('/api/role/:id/users/remove'), 'POST');
      // 「保存角色权限」是幂等的整体替换 → PUT 是主语义，POST 是项目习惯的别名。
      expect(methodsOf('/api/role/:id/menus'), 'POST|PUT');
      expect(methodsOf('/api/menu/options'), 'GET');
      expect(methodsOf('/api/dict/options'), 'GET');
      expect(methodsOf('/api/system/health'), 'GET');
      expect(methodsOf('/api/system/version'), 'GET');
    });

    test('匿名可访问的恰好 6 条，其余全部要求登录', () {
      final anonymous = allActionRoutes().entries
          .where((e) => !e.value.requireAuth)
          .map((e) => e.key)
          .toSet();
      expect(anonymous, _anonymousPaths);
    });

    test('信封全部显式传了 ServerpodEnvelopeBuilder（漏传会静默退回中立信封）', () {
      for (final entry in allActionRoutes().entries) {
        expect(
          entry.value.envelope,
          isA<ServerpodEnvelopeBuilder>(),
          reason: entry.key,
        );
      }
    });
  });

  group('全量挂载（复刻 registerApiRoutes → WebServer.addRoute → injectAt）', () {
    test('A 档 6 个资源 + 14 条动作路由一起挂，互不冲突', () {
      // 「嵌套挂载会不会撞」这件事只有合起来挂才验得出来 ——
      // relic 的 PathTrie 在同一层遇到不同参数名会抛
      // `Conflicting parameter names at the same level`，
      // 挂载点是纯字符串重复则抛 `Conflicting values`。
      expect(mountApi, returnsNormally);
    });

    test('14 条动作路径全部命中，且 OPTIONS 预检都注册了', () {
      final app = mountApi();
      for (final path in _actionPaths) {
        // 路径参数用真实值替换。
        final concrete = path.replaceAll(':id', '5');
        final method = _primaryMethodOf(path);

        final result = app.lookupUri(method, Uri.parse(concrete));
        expect(result, isA<RouterMatch>(), reason: '${method.value} $concrete');

        expect(
          app.lookupUri(Method.options, Uri.parse(concrete)),
          isA<RouterMatch>(),
          reason: 'OPTIONS $concrete（relic 中间件是路由级的，预检必须显式注册）',
        );
      }
    });

    test('嵌套的动作路径不会破坏 A 档 CRUD', () {
      final app = mountApi();

      // role 的团队式 CRUD 五件套仍在（`/api/role/add` 例外，见下）。
      for (final entry in <String, Method>{
        '/api/role/getList': Method.get,
        '/api/role/getDetail': Method.get,
        '/api/role/update': Method.post,
        '/api/role/delete': Method.post,
        '/api/role/deleteBatch': Method.post,
      }.entries) {
        expect(
          app.lookupUri(entry.value, Uri.parse(entry.key)),
          isA<RouterMatch>(),
          reason: '${entry.value.value} ${entry.key}',
        );
      }

      // 反向：role 没有「新增」这件事不能被动作路由破坏 ——
      // `/api/role/add` 这条路由**根本没注册**，是 404（不是 405）。
      expect(
        app.lookupUri(Method.post, Uri.parse('/api/role/add')),
        isA<PathMiss>(),
      );

      // 字面量段（CRUD 子路径）与参数段（动作路由的 `:id`）在同一层共存，
      // 各自都能命中 —— 这是「字面量优先于参数段」这条规则的落点。
      expect(
        app.lookupUri(Method.get, Uri.parse('/api/role/5/menu-ids')),
        isA<RouterMatch>(),
      );

      // dict 域：新起的 `/api/dict` 挂载点不能影响已有的两个资源。
      expect(app.lookupUri(Method.get, Uri.parse('/api/dict/options')), isA<RouterMatch>());
      expect(
        app.lookupUri(Method.get, Uri.parse('/api/dictData/getList')),
        isA<RouterMatch>(),
      );
      expect(
        app.lookupUri(Method.get, Uri.parse('/api/dictCode/getList')),
        isA<RouterMatch>(),
      );
    });
  });

  group('字面量段优先于参数段（否则 info/options 会被当成 id）', () {
    /// 参数为空的匹配 = 命中的是**字面量**节点；
    /// 带参数 = 命中了某条动作路由的 `:id`。
    void expectLiteralWins(String path, Method method) {
      final app = mountApi();
      final match = app.lookupUri(method, Uri.parse(path));
      expect(match, isA<RouterMatch>(), reason: '${method.value} $path');
      expect(
        (match as RouterMatch).parameters,
        isEmpty,
        reason: '$path 必须命中字面量段，落到 :id 上就会变成 400「路径参数必须是正整数」',
      );
    }

    test('GET /api/user/info 命中字面量（不落到任何 :id 上）', () {
      expectLiteralWins('/api/user/info', Method.get);
    });

    test('GET /api/user/routes 同上', () {
      expectLiteralWins('/api/user/routes', Method.get);
    });

    test('POST /api/user/reset-password 同上', () {
      expectLiteralWins('/api/user/reset-password', Method.post);
    });

    test('GET /api/menu/options 命中字面量', () {
      expectLiteralWins('/api/menu/options', Method.get);
    });

    // 2026-09-24：A 档的 `GET /:id` 已被团队式 `GET /getDetail?id=` 取代，
    // 资源挂载点下**再没有参数段**。钉住这一条是为了防止有人「顺手」把
    // REST 原生的 `/:id` 加回来 —— 加回来之后 `/api/user/5` 会与
    // `/api/user/info` 落进同一层，参数段与字面量段又要抢路由。
    test('对照：资源挂载点下已经没有 :id 路径段（`GET /api/user/5` 是 404）', () {
      final app = mountApi();
      expect(app.lookupUri(Method.get, Uri.parse('/api/user/5')), isA<PathMiss>());
      expect(app.lookupUri(Method.get, Uri.parse('/api/menu/7')), isA<PathMiss>());
      expect(app.lookupUri(Method.get, Uri.parse('/api/role/5')), isA<PathMiss>());
    });
  });

  group('角色子资源的路径参数', () {
    test('四条嵌套路径都能提取到同一个 :id', () {
      final app = mountApi();

      final cases = <(Method, String)>[
        (Method.get, '/api/role/5/menu-ids'),
        (Method.get, '/api/role/5/users'),
        (Method.post, '/api/role/5/users/remove'),
        (Method.put, '/api/role/5/menus'),
        (Method.post, '/api/role/5/menus'),
      ];

      for (final (method, path) in cases) {
        final match = app.lookupUri(method, Uri.parse(path));
        expect(match, isA<RouterMatch>(), reason: '${method.value} $path');
        expect(
          (match as RouterMatch).parameters[#id],
          '5',
          reason: '${method.value} $path',
        );
      }
    });

    test('路径参数名不能另起：`:roleId` 会与已有动作路由的 `:id` 冲突', () {
      // ⚠️ 冲突的**来源变了**（2026-09-24）：以前 A 档 role 自己注册了
      // `GET /:id` / `PUT|PATCH /:id` / `DELETE /:id`，所以任何新子路径都得
      // 沿用 `:id`；现在 A 档 role 的子路径全是字面量段、没有参数段，
      // 冲突改由**动作路由之间**产生（`/api/role/:id/menu-ids` 等四条）。
      // 结论没变：`/api/role/...` 下的参数段只能叫 `:id`。
      //
      // 换成 `:roleId` 会在 `pod.start()` 前的注册阶段直接抛异常 ——
      // 服务根本起不来，而且报错信息（`Segment no 3: ":roleId" is invalid`）
      // 离真正的原因（「和别的动作路由撞名了」）很远。
      final app = RelicRouter()
        ..injectAt(
          '/api/role',
          _resource<SysRole>(RoleRestDelegate(), enableCreate: false),
        )
        ..injectAt(
          '/api/role/:id/menu-ids',
          roleActionRoutes()['/api/role/:id/menu-ids']!,
        );

      expect(
        () => app.injectAt(
          '/api/role/:roleId/users',
          roleActionRoutes()['/api/role/:id/users']!,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}

/// 取该路径的**主**方法（用于「能不能命中」这类与具体方法无关的断言）。
///
/// `/api/role/:id/menus` 同时注册了 PUT 与 POST，这里取 PUT 是因为它是主语义；
/// 组内另有专门一条断言把两个方法都覆盖掉。
Method _primaryMethodOf(String path) {
  final methods = allActionRoutes()[path]!.methods.toList()..sort(
    (a, b) => a.value.compareTo(b.value),
  );
  return methods.contains(Method.put) ? Method.put : methods.first;
}
