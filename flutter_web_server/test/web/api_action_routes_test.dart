import 'package:flutter_web_server/src/web/routes/api/system/auth_api_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/modules/book_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/dept_api_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/dict_action_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/dict_code_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/dict_data_api_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/menu_api_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/role_api_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:flutter_web_server/src/web/routes/api/system/health_api_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/user_api_routes.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';
import 'package:test/test.dart';

/// B 档业务动作的**装配**测试 —— 只验证路由表与匹配行为，不碰数据库、
/// 不碰 Service（`ActionRoute` 只在真正处理请求时才调 handler）。
///
/// 方案 D（2026-09-27）之后动作路由分两组：
/// * **资源内动作** 9 条 —— 路径本来就嵌在某个资源挂载点下面，作为
///   `XxxRestRoute` 的 `actions` 与 6 条 CRUD 一起挂（book / menu / role / user）；
/// * **独立动作** 6 条 —— 背后没有资源挂载点可依附，只能自己起一个挂载点
///   （auth 3 + dict 1 + system 2）。
///
/// ⚠️ 改的是**装配方式**，对外路径一条都不能变：15 条绝对路径与重构前逐条
/// 一致（[kAllAbsoluteActionPaths]），这是前端与文档按死的那份契约。
///
/// 这里断言的也都是「起服务后最难察觉」的那一类：
/// * **嵌套挂载会不会撞** —— `/api/role/:id/...` 嵌在已被 A 档占用的挂载点下面，
///   relic 的 `PathTrie` 只在注册那一刻校验冲突，冲突了是抛异常（服务起不来）；
/// * **字面量段会不会被参数段吃掉** —— `info` / `options` 一旦落到 `:id` 上，
///   只在真发请求时才暴露成 400「路径参数必须是正整数」；
/// * **匿名开关 / 信封有没有漏传** —— 漏了都不报错，只表现为 401 或前端解析失灵。
///
/// ⚠️ 离线挂载必须挂 `'/api/x'` 而不能带 `*` 主机通配段：
/// `Router.lookupUri` 只规范化 `uri.pathSegments`（不含 host），带 `*` 的
/// 挂载点在离线查询里一条都匹配不上。生产环境的 `WebServer.addRoute` 内部是
/// `_app.injectAt('*$path', route)`，多出来的只是最前面那一段主机通配，
/// **不影响冲突检测与后续各段的优先级结论**。

/// **独立挂载**的动作路由（键 = 完整路径，一条路由一个挂载点）。
Map<String, ActionRoute> standaloneActionRoutes() => {
  ...authActionRoutes(),
  ...dictActionRoutes(),
  ...systemActionRoutes(),
};

/// **资源内动作**按挂载点分组 —— 它们不再是独立挂载点，只能从资源 route 类取。
Map<String, List<ActionRoute>> resourceActionGroups() => {
  '/api/book': BookRestRoute().actionRoutes,
  '/api/menu': MenuRestRoute().actionRoutes,
  '/api/role': RoleRestRoute().actionRoutes,
  '/api/user': UserRestRoute().actionRoutes,
};

/// 两组合并成一张「**对外绝对路径** → 路由」表，断言才好逐条钉。
Map<String, ActionRoute> allAbsoluteActionRoutes() => {
  ...standaloneActionRoutes(),
  for (final entry in resourceActionGroups().entries)
    for (final route in entry.value) '${entry.key}${route.path}': route,
};

/// 独立挂载的 6 条：auth 3 + dict 1 + system 2。
///
/// ⚠️ 是 **6** 而不是 7：`getDictDataDetail(id, code)` 复用 A 档已有的
/// `GET /api/dictData/getDetail?id=`，刻意不造第二条重复路由
/// （见 dict_action_routes.dart）。
const kStandaloneActionPaths = <String>[
  '/api/auth/publicKey',
  '/api/auth/login',
  '/api/auth/refreshToken',
  '/api/dict/options',
  '/api/system/health',
  '/api/system/version',
];

/// 资源内动作的**相对**子路径（键 = 挂载点），共 9 条：
/// book 1 + menu 1 + role 4 + user 3。
const kResourceActionPaths = <String, List<String>>{
  '/api/book': ['/isbn-check'],
  '/api/menu': ['/options'],
  '/api/role': ['/:id/menu-ids', '/:id/users', '/:id/users/remove', '/:id/menus'],
  '/api/user': ['/info', '/routes', '/reset-password'],
};

/// **对外契约**：15 条动作路径逐条钉死（顺序按挂载点归类，便于比对）。
///
/// 6 条独立 + 9 条资源内。方案 D 只动装配，这张表一条都不该变。
const kAllAbsoluteActionPaths = <String>[
  '/api/auth/publicKey',
  '/api/auth/login',
  '/api/auth/refreshToken',
  '/api/dict/options',
  '/api/system/health',
  '/api/system/version',
  '/api/book/isbn-check',
  '/api/menu/options',
  '/api/role/:id/menu-ids',
  '/api/role/:id/users',
  '/api/role/:id/users/remove',
  '/api/role/:id/menus',
  '/api/user/info',
  '/api/user/routes',
  '/api/user/reset-password',
];

/// 三条 auth + 一条字典 + 两条系统探活 = 6 条匿名。
///
/// 这条断言的价值在于**防反向**：漏写 `requireAuth: false` 会让登录/探活
/// 直接 401（且不报错）；反过来多写一个 `false` 就是越权开放，
/// 两种都要能被这条测试拦下来。资源内动作（9 条）全要求登录。
const _anonymousPaths = <String>{
  '/api/auth/publicKey',
  '/api/auth/login',
  '/api/auth/refreshToken',
  '/api/dict/options',
  '/api/system/health',
  '/api/system/version',
};

/// 完整复刻 `registerApiRoutes` 的挂载：A 档 7 个资源 + 全部动作路由。
///
/// 之所以要「一起挂」，是因为有 9 条动作嵌在资源挂载点下面 ——
/// 单独挂其中任何一个都不会报错，只有合起来才能验出冲突。
///
/// ⚠️ 资源内动作**不能**走 `standaloneActionRoutes().forEach(injectAt)`：
/// 它的键是相对子路径，`injectAt('相对路径', route)` 会在 `/info` 这种鬼地方
/// 起一个新的挂载点（而且**不报错**），后面所有断言都命不中、还看不出问题。
/// 所以必须整包挂资源 route 类（`XxxRestRoute()` 内部自己展开）。
RelicRouter mountApi() {
  final app = RelicRouter();
  app.injectAt('/api/book', BookRestRoute());
  app.injectAt('/api/dictData', DictDataRestRoute());
  app.injectAt('/api/dictCode', DictCodeRestRoute());
  app.injectAt('/api/menu', MenuRestRoute());
  app.injectAt('/api/dept', DeptRestRoute());
  app.injectAt('/api/role', RoleRestRoute());
  app.injectAt('/api/user', UserRestRoute());
  standaloneActionRoutes().forEach((path, route) => app.injectAt(path, route));
  return app;
}

void main() {
  group('动作路由表（注册源即测试源）', () {
    test('独立挂载恰好 6 条，路径与预期一一对应', () {
      expect(standaloneActionRoutes().keys.toSet(), kStandaloneActionPaths.toSet());
      expect(standaloneActionRoutes().length, 6);
    });

    // 方案 D 的落点：9 条动作的键都是**相对**子路径（以 / 开头、不带挂载点），
    // 且分组与预期一一对应。键写成完整路径的话，`injectIn` 会把挂载点拼两遍
    // （`/api/user/info/info`），而且是**静默**的。
    test('资源内动作 9 条：按挂载点分组，键全是相对子路径', () {
      final groups = resourceActionGroups();

      expect(groups.keys.toSet(), kResourceActionPaths.keys.toSet());
      expect(groups.values.fold<int>(0, (sum, routes) => sum + routes.length), 9);

      for (final entry in kResourceActionPaths.entries) {
        final actual = groups[entry.key]!.map((route) => route.path).toList();
        expect(actual, entry.value, reason: entry.key);

        for (final path in actual) {
          expect(path.startsWith('/'), isTrue, reason: '$path 必须以 / 开头');
          expect(path.startsWith('/api/'), isFalse, reason: '$path 是相对子路径，不该带 /api 前缀');
        }
      }
    });

    test('对外 15 条绝对路径与重构前逐条一致', () {
      expect(allAbsoluteActionRoutes().keys.toSet(), kAllAbsoluteActionPaths.toSet());
      expect(allAbsoluteActionRoutes().length, 15);
    });

    test('方法与设计一致（含 PUT|POST 双注册的那条）', () {
      final routes = allAbsoluteActionRoutes();
      String methodsOf(String path) => (routes[path]!.methods.map((m) => m.value).toList()..sort()).join('|');

      expect(methodsOf('/api/auth/publicKey'), 'GET');
      expect(methodsOf('/api/auth/login'), 'POST');
      expect(methodsOf('/api/auth/refreshToken'), 'POST');
      expect(methodsOf('/api/user/info'), 'GET');
      expect(methodsOf('/api/user/routes'), 'GET');
      expect(methodsOf('/api/user/reset-password'), 'POST');
      expect(methodsOf('/api/role/:id/menu-ids'), 'GET');
      expect(methodsOf('/api/role/:id/users'), 'GET');
      expect(methodsOf('/api/role/:id/users/remove'), 'POST');
      // 「保存角色权限」是幂等的整体替换 → PUT 是主语义，POST 是项目习惯的别名。
      expect(methodsOf('/api/role/:id/menus'), 'POST|PUT');
      expect(methodsOf('/api/menu/options'), 'GET');
      expect(methodsOf('/api/book/isbn-check'), 'GET');
      expect(methodsOf('/api/dict/options'), 'GET');
      expect(methodsOf('/api/system/health'), 'GET');
      expect(methodsOf('/api/system/version'), 'GET');
    });

    test('匿名可访问的恰好 6 条，其余全部要求登录', () {
      final anonymous = allAbsoluteActionRoutes().entries
          .where((entry) => !entry.value.requireAuth)
          .map((entry) => entry.key)
          .toSet();
      expect(anonymous, _anonymousPaths);
    });

    test('信封全部显式传了 ServerpodEnvelopeBuilder（漏传会静默退回中立信封）', () {
      for (final entry in allAbsoluteActionRoutes().entries) {
        expect(entry.value.envelope, isA<ServerpodEnvelopeBuilder>(), reason: entry.key);
      }
    });
  });

  group('全量挂载（复刻 registerApiRoutes → WebServer.addRoute → injectAt）', () {
    test('A 档 7 个资源 + 15 条动作路由一起挂，互不冲突', () {
      // 「嵌套挂载会不会撞」这件事只有合起来挂才验得出来 ——
      // relic 的 PathTrie 在同一层遇到不同参数名会抛
      // `Conflicting parameter names at the same level`，
      // 挂载点是纯字符串重复则抛 `Conflicting values`。
      expect(mountApi, returnsNormally);
    });

    test('15 条动作路径全部命中，且 OPTIONS 预检都注册了', () {
      final app = mountApi();
      for (final path in kAllAbsoluteActionPaths) {
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

    // 方案 D 最容易踩的坑：动作路由的键一旦改成相对子路径，若还用
    // 「键当挂载点」的挂法（`injectAt(path, route)`），`Route.path` 会被拼在
    // 挂载点后面变成 `/api/user/info/info` —— **一条断言都不会报错**。
    test('资源内动作没有被拼成双重路径（/api/user/info/info 是 404）', () {
      final app = mountApi();

      expect(app.lookupUri(Method.get, Uri.parse('/api/user/info')), isA<RouterMatch>());
      expect(app.lookupUri(Method.get, Uri.parse('/api/user/info/info')), isA<PathMiss>());
      expect(app.lookupUri(Method.get, Uri.parse('/api/menu/options/options')), isA<PathMiss>());
    });

    // 方案 D：book/menu 的动作与 CRUD 现在同在一个挂载点里，
    // 「同层字面量段共存」这件事必须真的成立。
    test('方案 D：资源内动作是挂载点内部的字面量段子路由', () {
      final app = mountApi();

      for (final (method, path) in <(Method, String)>[
        (Method.get, '/api/book/isbn-check'),
        (Method.get, '/api/menu/options'),
        (Method.get, '/api/user/info'),
        (Method.get, '/api/user/routes'),
        (Method.post, '/api/user/reset-password'),
      ]) {
        final match = app.lookupUri(method, Uri.parse(path));
        expect(match, isA<RouterMatch>(), reason: '${method.value} $path');
        expect((match as RouterMatch).parameters, isEmpty, reason: '$path 命中的必须是字面量段，而不是某个 :id 参数段');
      }

      // 反向：这些挂载点下没有 `:id` 段，`/api/user/5` 不该命中。
      expect(app.lookupUri(Method.get, Uri.parse('/api/user/5')), isA<PathMiss>());
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
      expect(app.lookupUri(Method.post, Uri.parse('/api/role/add')), isA<PathMiss>());

      // 字面量段（CRUD 子路径）与参数段（动作路由的 `:id`）在同一层共存，
      // 各自都能命中 —— 这是「字面量优先于参数段」这条规则的落点。
      expect(app.lookupUri(Method.get, Uri.parse('/api/role/5/menu-ids')), isA<RouterMatch>());

      // dict 域：独立挂载的 `/api/dict` 不能影响已有的两个资源。
      expect(app.lookupUri(Method.get, Uri.parse('/api/dict/options')), isA<RouterMatch>());
      expect(app.lookupUri(Method.get, Uri.parse('/api/dictData/getList')), isA<RouterMatch>());
      expect(app.lookupUri(Method.get, Uri.parse('/api/dictCode/getList')), isA<RouterMatch>());
    });
  });

  group('字面量段优先于参数段（否则 info/options 会被当成 id）', () {
    /// 参数为空的匹配 = 命中的是**字面量**节点；
    /// 带参数 = 命中了某条动作路由的 `:id`。
    void expectLiteralWins(String path, Method method) {
      final app = mountApi();
      final match = app.lookupUri(method, Uri.parse(path));
      expect(match, isA<RouterMatch>(), reason: '${method.value} $path');
      expect((match as RouterMatch).parameters, isEmpty, reason: '$path 必须命中字面量段，落到 :id 上就会变成 400「路径参数必须是正整数」');
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
        expect((match as RouterMatch).parameters[#id], '5', reason: '${method.value} $path');
      }
    });

    test('路径参数名不能另起：`:roleId` 会与已有 :id 冲突', () {
      // 冲突的来源：A 档 role 的子路径全是字面量段、没有参数段，
      // 所以冲突在**动作路由之间**产生（`/:id/menu-ids` 等四条）。
      // 换成 `:roleId` 会在 `pod.start()` 前的注册阶段直接抛异常 ——
      // 服务根本起不来，而且报错信息（`Segment no 3: ":roleId" is invalid`）
      // 离真正的原因（「和别的动作路由撞名了」）很远。
      final app = RelicRouter()..injectAt('/api/role', RoleRestRoute());

      expect(
        () => app.injectAt('/api/role/:roleId/users', _noopAction()),
        throwsA(
          predicate<Object>(
            (e) => e is ArgumentError && '${e.message}'.contains('parameter'),
            '同层参数名冲突（不是别的 ArgumentError）',
          ),
        ),
      );
    });
  });
}

/// 取该路径的**主**方法（用于「能不能命中」这类与具体方法无关的断言）。
///
/// `/api/role/:id/menus` 同时注册了 PUT 与 POST，这里取 PUT 是因为它是主语义；
/// 组内另有专门一条断言把两个方法都覆盖掉。
Method _primaryMethodOf(String path) {
  final methods = allAbsoluteActionRoutes()[path]!.methods.toList()..sort((a, b) => a.value.compareTo(b.value));
  return methods.contains(Method.put) ? Method.put : methods.first;
}

/// 只为「挂上去会不会冲突」准备的占位动作路由（`Route.path` 保持默认的
/// `/`，挂载点即完整路径）—— 永远不该被调用。
ActionRoute _noopAction() => ActionRoute(
  methods: const {Method.get},
  envelope: const ServerpodEnvelopeBuilder(),
  handler: (session, request) async => null,
);
