import 'package:flutter_web_server/src/web/routes/api/modules/book_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/dept_api_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/dict_code_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/dict_data_api_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/menu_api_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/role_api_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/user_api_routes.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

/// A 档 7 个资源的**装配**测试 —— 只验证路由表，不碰数据库、不碰 Service
/// （delegate 只在真正处理请求时才调 Service，路由构建阶段完全不触发）。
///
/// 方案 D（2026-09-27）之后，带业务动作的 4 个资源（book / user / role / menu）
/// 走各自的 `XxxRestRoute`：**一次挂载**产出「6 条 CRUD + N 条动作」。所以这里
/// 除了 CRUD 子路由，也要断言动作子路由确实进来了、且没挤掉任何一条 CRUD。
///
/// 这些断言能在**离线**发现的问题，正是起服务后最难察觉的那一类：
/// * 某个资源漏挂、挂重（relic `PathTrie` 的 `Conflicting values` 是运行期才抛）；
/// * `enableCreate` 传错，导致 `POST /add` 被注册或被漏掉；
/// * 信封漏传，退回中立信封（前端拿不到 `code`，且不会报错）。
String _signature(Route route) {
  final methods = route.methods.map((m) => m.value).toList()..sort();
  return '${methods.join('|')} ${route.path}';
}

// 6 条 = 团队式路由表：**一动作一路径**，路径全是字面量段（没有 `:id`）。
const _fullCrud = <String>[
  'GET /getList',
  'GET /getDetail',
  'POST /add',
  'POST /update',
  'POST /delete',
  'POST /deleteBatch',
];

/// 6 条子路径及其方法 —— 挂载后就是 `/api/user/getList` 这样的完整路径。
const _subPaths = <String, Method>{
  '/getList': Method.get,
  '/getDetail': Method.get,
  '/add': Method.post,
  '/update': Method.post,
  '/delete': Method.post,
  '/deleteBatch': Method.post,
};

void main() {
  group('A 档 7 个资源的路由表', () {
    test('/api/book —— 完整 6 条 CRUD（整条链路由框架 AutoCrudDelegate 装配）', () {
      expect(BookRestRoute().subRoutes.map(_signature), _fullCrud);
    });

    // book 的显式 delegate 要读 `Serverpod.instance`，离线路由测试里不会真的构造；
    // 这里钉住统一类暴露出来的那组配置常量，挂载行为仍由下面几条测试覆盖。
    test('/api/book —— 统一类内聚的 CRUD 配置常量保持原值', () {
      expect(BookRestRoute.auditType, 'book');
      expect(BookRestRoute.keywordFields, const ['name', 'isbn', 'author', 'publisher']);
    });

    // 方案 D：`/isbn-check` 从独立挂载点变成资源内部的相对子路由。
    // 两条一起验：动作确实进来了，且没有挤掉任何一条 CRUD。
    test('/api/book —— 动作子路由是相对路径 /isbn-check，CRUD 6 条不变', () {
      final route = BookRestRoute();

      expect(route.actionRoutes.map(_signature), <String>['GET /isbn-check', 'GET /updatePrice']);
      expect(
        route.actionRoutes.firstWhere((action) => action.path == '/isbn-check').path,
        '/isbn-check',
        reason: '键/路径必须是相对挂载点的子路径，而不是 /api/book/isbn-check',
      );

      // 动作的存在不改变 CRUD 子路由集合。
      expect(route.subRoutes.map(_signature), _fullCrud);
      expect(route.subRoutes.length, 6);
    });

    test('/api/user —— 6 条 CRUD + 3 条动作（批量删走默认的逐条实现）', () {
      final route = UserRestRoute();

      expect(route.subRoutes.map(_signature), _fullCrud);
      expect(route.actionRoutes.map(_signature), <String>['GET /info', 'GET /routes', 'POST /reset-password']);
    });

    test('/api/dept —— 完整 6 条（列表返回树）', () {
      expect(DeptRestRoute().subRoutes.map(_signature), _fullCrud);
    });

    test('/api/menu —— 6 条 CRUD + 1 条动作（列表返回树）', () {
      final route = MenuRestRoute();

      expect(route.subRoutes.map(_signature), _fullCrud);
      expect(route.actionRoutes.map(_signature), <String>['GET /options']);
    });

    test('/api/dictCode —— 完整 6 条（列表不分页）', () {
      expect(DictCodeRestRoute().subRoutes.map(_signature), _fullCrud);
    });

    test('/api/dictData —— 完整 6 条（列表不分页）', () {
      expect(DictDataRestRoute().subRoutes.map(_signature), _fullCrud);
    });

    // 角色业务上没有「新增」，所以 REST 侧也不注册 POST /add ——
    // 这个开关写在 `RoleRestRoute` 里（调用方不必再记得传 enableCreate）。
    test('/api/role —— 5 条 CRUD（没有「新增」）+ 4 条动作', () {
      final route = RoleRestRoute();
      final signatures = route.subRoutes.map(_signature);

      expect(signatures, isNot(contains('POST /add')));
      expect(route.subRoutes.length, 5);
      expect(signatures, containsAll(<String>['POST /update', 'POST /delete', 'POST /deleteBatch']));

      expect(route.actionRoutes.map(_signature), <String>[
        'GET /:id/menu-ids',
        'GET /:id/users',
        'POST /:id/users/remove',
        'POST|PUT /:id/menus',
      ]);
    });
  });

  group('挂载（模拟 WebServer.addRoute → injectAt）', () {
    // 真实挂载：`WebServer.addRoute(route, '/api/x')` 内部是
    // `_app.injectAt('/api/x', route)`
    // （`serverpod/lib/src/web_server/web_server.dart:98`），
    // 而 `injectAt` 给每条路由建一个子路由器再 attach —— **一个挂载点只能
    // 注入一次**，同字符串注入两次会抛 `Conflicting values`。
    // 这里就用同一套 API 复现，不起服务也能验出「挂重了」。
    RelicRouter mountAll() {
      final app = RelicRouter();
      app.injectAt('/api/book', BookRestRoute());
      app.injectAt('/api/dictData', DictDataRestRoute());
      app.injectAt('/api/dictCode', DictCodeRestRoute());
      app.injectAt('/api/menu', MenuRestRoute());
      app.injectAt('/api/dept', DeptRestRoute());
      app.injectAt('/api/role', RoleRestRoute());
      app.injectAt('/api/user', UserRestRoute());
      return app;
    }

    const mountedPaths = <String>[
      '/api/book',
      '/api/dictData',
      '/api/dictCode',
      '/api/menu',
      '/api/dept',
      '/api/role',
      '/api/user',
    ];

    test('7 个资源挂在 7 个不同挂载点上，互不冲突', () {
      expect(mountAll, returnsNormally);
      expect(mountedPaths.toSet().length, mountedPaths.length);
    });

    test('每个挂载点下的 6 条子路径都能命中，且每条都补了 OPTIONS', () {
      final app = mountAll();

      for (final path in mountedPaths) {
        // role 没有「新增」→ `/api/role/add` 这条路由不存在。
        final missingAdd = path == '/api/role';

        for (final entry in _subPaths.entries) {
          if (missingAdd && entry.key == '/add') continue;
          expect(
            app.lookupUri(entry.value, Uri.parse('$path${entry.key}')),
            isA<RouterMatch>(),
            reason: '${entry.value.value} $path${entry.key}',
          );
          expect(
            app.lookupUri(Method.options, Uri.parse('$path${entry.key}')),
            isA<RouterMatch>(),
            reason: 'OPTIONS $path${entry.key}（预检必须注册）',
          );
        }
      }
    });

    // 方案 D：9 条动作与 CRUD 同在一个挂载点里，挂载点本身只有一个 ——
    // 这份断言是「动作真的跟着资源一起挂上了」的落点。
    test('4 个资源内的 9 条动作子路径都能命中', () {
      final app = mountAll();

      const cases = <(Method, String)>[
        (Method.get, '/api/book/isbn-check'),
        (Method.get, '/api/user/info'),
        (Method.get, '/api/user/routes'),
        (Method.post, '/api/user/reset-password'),
        (Method.get, '/api/menu/options'),
        (Method.get, '/api/role/5/menu-ids'),
        (Method.get, '/api/role/5/users'),
        (Method.post, '/api/role/5/users/remove'),
        (Method.put, '/api/role/5/menus'),
        (Method.post, '/api/role/5/menus'),
      ];

      for (final (method, path) in cases) {
        expect(app.lookupUri(method, Uri.parse(path)), isA<RouterMatch>(), reason: '${method.value} $path');
      }
    });

    // ⚠️ 语义变更：`POST /api/role` 从 **405** 变成了 **404**。
    //
    // 旧路由表里 role 的 `/` 上还挂着 `GET /` 与 `DELETE /`，所以 relic 能
    // 匹配到路径、只是方法不允许（405）；现在「一动作一路径」，`/add` 是一条
    // 独立路由，没注册就是路径不存在 → 404。别把这个当回归去「修」。
    test('role 的 POST /api/role/add 是 404，其它资源的 POST /add 能命中', () {
      final app = mountAll();

      expect(app.lookupUri(Method.post, Uri.parse('/api/role/add')), isA<PathMiss>());

      for (final path in mountedPaths.where((p) => p != '/api/role')) {
        expect(app.lookupUri(Method.post, Uri.parse('$path/add')), isA<RouterMatch>(), reason: 'POST $path/add');
      }
    });

    test('资源自身只负责挂载（path=/），请求全部走子路由', () {
      expect(DeptRestRoute().path, '/');
      expect(RoleRestRoute().path, '/');
    });
  });
}
