import 'package:flutter_web_server/src/web/routes/api/modules/book_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/dept_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/dict_code_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/dict_data_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/menu_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/role_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/system/user_routes.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';

/// A 档 7 个资源的**装配**测试 —— 只验证路由表，不碰数据库、不碰 Service
/// （delegate 只在真正处理请求时才调 Service，路由构建阶段完全不触发）。
///
/// 业务资源（book / user / role / menu / dept / dictCode / dictData）现在把
/// 6 条 CRUD 也写进 `actionList`，所以 [BaseRoute.subRoutes] 对它们是空的 ——
/// 断言必须看**合并后的对外表面**（[surface]），而不是只看 `subRoutes`。
///
/// 这些断言能在**离线**发现的问题，正是起服务后最难察觉的那一类：
/// * 某个资源漏挂、挂重（relic `PathTrie` 的 `Conflicting values` 是运行期才抛）；
/// * `enableCreate: false` 没生效，导致 `POST /add` 被注册；
/// * 动作路径写错，被 `/getDetail` 之类的 CRUD 段挤掉。

/// 6 条 = 团队式路由表：**一动作一路径**，路径全是字面量段（没有 `:id`）。
const _fullCrud = <String>{
  'GET /getList',
  'GET /getDetail',
  'POST /add',
  'POST /update',
  'POST /delete',
  'POST /deleteBatch',
};

/// `BaseRoute.subRoutes` 之外的 6 条 CRUD 路径 —— 用来把业务动作从
/// `actionRoutes` 里剔出来（它们现在和 CRUD 混在同一个列表里）。
const _crudPaths = <String>{
  '/getList',
  '/getDetail',
  '/add',
  '/update',
  '/delete',
  '/deleteBatch',
};

/// 资源挂载点下的**全部**对外子路径（CRUD + 业务动作），按路径排序。
///
/// 同一路径被拆成多条 `ActionRoute` 时（role 的 `PUT` + `POST /:id/menus`）
/// 必须按路径合并方法，否则 `Map` 键冲突会把其中一条静默吃掉。
List<String> surface(dynamic route) {
  final byPath = <String, Set<Method>>{};
  for (final r in <Route>[...route.subRoutes, ...route.actionRoutes]) {
    (byPath[r.path] ??= <Method>{}).addAll(r.methods);
  }
  return byPath.keys.map((path) {
    final methods = byPath[path]!.map((m) => m.value).toList()..sort();
    return '${methods.join('|')} $path';
  }).toList()..sort();
}

/// [surface] 里属于 6 条 CRUD 的部分。
List<String> crudOf(dynamic route) =>
    surface(route).where((s) => _crudPaths.contains(s.split(' ').last)).toList();

/// [surface] 里属于业务动作的部分（CRUD 之外的全部）。
List<String> actionsOf(dynamic route) =>
    surface(route).where((s) => !_crudPaths.contains(s.split(' ').last)).toList();

void main() {
  group('A 档 7 个资源的路由表', () {
    test('/api/book —— 完整 6 条 CRUD（走框架 AutoCrudDelegate）', () {
      expect(crudOf(BookRoute()).toSet(), _fullCrud);
    });

    // book 的显式 delegate 要读 `Serverpod.instance`，离线路由测试里不会真的构造；
    // 这里钉住统一类暴露出来的那组配置常量，挂载行为仍由下面几条测试覆盖。
    test('/api/book —— 统一类内聚的 CRUD 配置常量保持原值', () {
      expect(BookRoute.auditType, 'book');
      expect(BookRoute.keywordFields, const ['name', 'isbn', 'author', 'publisher']);
    });

    // `/isbn-check`、`/updatePrice` 是资源内部的相对子路由。
    // 两条一起验：动作确实进来了，且没有挤掉任何一条 CRUD。
    test('/api/book —— 动作子路由是相对路径，CRUD 6 条不变', () {
      final route = BookRoute();

      expect(actionsOf(route), <String>['GET /isbn-check', 'GET /updatePrice']);
      expect(
        route.actionRoutes.firstWhere((action) => action.path == '/isbn-check').path,
        '/isbn-check',
        reason: '键/路径必须是相对挂载点的子路径，而不是 /api/book/isbn-check',
      );

      // 动作的存在不改变 CRUD 子路由集合。
      expect(crudOf(route).toSet(), _fullCrud);
    });

    test('/api/user —— 6 条 CRUD + 3 条动作（批量删走默认的逐条实现）', () {
      final route = UserRoute();

      expect(crudOf(route).toSet(), _fullCrud);
      expect(actionsOf(route), <String>['GET /info', 'GET /routes', 'POST /reset-password']);
    });

    test('/api/dept —— 完整 6 条（列表返回树）', () {
      expect(crudOf(DeptRoute()).toSet(), _fullCrud);
    });

    test('/api/menu —— 6 条 CRUD + 1 条动作（列表返回树）', () {
      final route = MenuRoute();

      expect(crudOf(route).toSet(), _fullCrud);
      expect(actionsOf(route), <String>['GET /options']);
    });

    test('/api/dictCode —— 完整 6 条（列表不分页）', () {
      expect(crudOf(DictCodeRoute()).toSet(), _fullCrud);
    });

    test('/api/dictData —— 完整 6 条（列表不分页）', () {
      expect(crudOf(DictDataRoute()).toSet(), _fullCrud);
    });

    // 角色「新增」走显式动作 `POST /add`（enableCreate 仍为 false），
    // 因为它要带权限校验 + 默认值，不能走框架的裸 delegate.create。
    test('/api/role —— 完整 6 条 CRUD + 4 条动作', () {
      final route = RoleRoute();
      final crud = crudOf(route);

      expect(crud.toSet(), _fullCrud);

      // 项目只用 GET / POST，「保存角色权限」只保留 POST 一条契约。
      expect(actionsOf(route), <String>[
        'GET /:id/menu-ids',
        'GET /:id/users',
        'POST /:id/menus',
        'POST /:id/users/remove',
      ]);
    });

    test('业务动作与 CRUD 子路径不重名（重名会在构造期直接抛异常）', () {
      for (final route in <dynamic>[
        BookRoute(),
        UserRoute(),
        RoleRoute(),
        MenuRoute(),
        DeptRoute(),
        DictCodeRoute(),
        DictDataRoute(),
      ]) {
        final paths = <String, Set<Method>>{};
        for (final r in <Route>[...route.subRoutes, ...route.actionRoutes]) {
          final methods = paths[r.path] ??= <Method>{};
          for (final m in r.methods) {
            expect(
              methods.add(m),
              isTrue,
              reason: '${route.runtimeType} 的 ${m.value} ${r.path} 重复注册',
            );
          }
        }
      }
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
      app.injectAt('/api/book', BookRoute());
      app.injectAt('/api/dictData', DictDataRoute());
      app.injectAt('/api/dictCode', DictCodeRoute());
      app.injectAt('/api/menu', MenuRoute());
      app.injectAt('/api/dept', DeptRoute());
      app.injectAt('/api/role', RoleRoute());
      app.injectAt('/api/user', UserRoute());
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
        for (final entry in _subPaths.entries) {
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

    test('10 条资源内动作子路径都能命中', () {
      final app = mountAll();

      const cases = <(Method, String)>[
        (Method.get, '/api/book/isbn-check'),
        (Method.get, '/api/book/updatePrice'),
        (Method.get, '/api/user/info'),
        (Method.get, '/api/user/routes'),
        (Method.post, '/api/user/reset-password'),
        (Method.get, '/api/menu/options'),
        (Method.get, '/api/role/5/menu-ids'),
        (Method.get, '/api/role/5/users'),
        (Method.post, '/api/role/5/users/remove'),
        (Method.post, '/api/role/5/menus'),
      ];

      for (final (method, path) in cases) {
        expect(app.lookupUri(method, Uri.parse(path)), isA<RouterMatch>(), reason: '${method.value} $path');
      }
    });

    // 历史包袱：role 曾因 `enableCreate: false` 而没有 `POST /add`（404）。
    // 现在新增改成显式动作注册，这条路径必须能命中。
    test('7 个资源的 POST /add 都能命中', () {
      final app = mountAll();

      for (final path in mountedPaths) {
        expect(app.lookupUri(Method.post, Uri.parse('$path/add')), isA<RouterMatch>(), reason: 'POST $path/add');
      }
    });

    test('资源自身只负责挂载（path=/），请求全部走子路由', () {
      expect(DeptRoute().path, '/');
      expect(RoleRoute().path, '/');
    });
  });
}

/// 6 条子路径及其方法 —— 挂载后就是 `/api/user/getList` 这样的完整路径。
const _subPaths = <String, Method>{
  '/getList': Method.get,
  '/getDetail': Method.get,
  '/add': Method.post,
  '/update': Method.post,
  '/delete': Method.post,
  '/deleteBatch': Method.post,
};