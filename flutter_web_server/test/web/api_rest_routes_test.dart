import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/web/routes/api/dept_rest_delegate.dart';
import 'package:flutter_web_server/src/web/routes/api/dict_code_rest_delegate.dart';
import 'package:flutter_web_server/src/web/routes/api/dict_data_rest_delegate.dart';
import 'package:flutter_web_server/src/web/routes/api/menu_rest_delegate.dart';
import 'package:flutter_web_server/src/web/routes/api/role_rest_delegate.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:flutter_web_server/src/web/routes/api/user_rest_delegate.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';
import 'package:test/test.dart';

/// A 档 6 个资源的**装配**测试 —— 只验证路由表，不碰数据库、不碰 Service
/// （delegate 只在真正处理请求时才调 Service，路由构建阶段完全不触发）。
///
/// 这些断言能在**离线**发现的问题，正是起服务后最难察觉的那一类：
/// * 某个资源漏挂、挂重（relic `PathTrie` 的 `Conflicting values` 是运行期才抛）；
/// * `enableCreate` 传错，导致 `POST /` 被注册或被漏掉；
/// * 信封漏传，退回中立信封（前端拿不到 `code`，且不会报错）。
String _signature(Route route) {
  final methods = route.methods.map((m) => m.value).toList()..sort();
  return '${methods.join('|')} ${route.path}';
}

BaseRestRoute<T> _resource<T extends TableRow>(
  RestCrudDelegate<T> delegate, {
  bool enableCreate = true,
}) => BaseRestRoute<T>(
  delegate: delegate,
  envelope: const ServerpodEnvelopeBuilder(),
  enableCreate: enableCreate,
);

/// 8 条 = 完整 CRUD + 批量删 + 两条 POST 兼容形式。
const _fullCrud = <String>[
  'GET /',
  'GET /:id',
  'POST /',
  'PATCH|PUT /:id',
  'DELETE /:id',
  'DELETE /',
  'POST /update',
  'POST /delete',
];

void main() {
  group('A 档 6 个资源的路由表', () {
    test('/api/user —— 完整 CRUD（批量删用默认的逐条实现）', () {
      final route = _resource<SysUser>(UserRestDelegate());
      expect(route.subRoutes.map(_signature), _fullCrud);
    });

    test('/api/dept —— 完整 CRUD（列表返回树）', () {
      final route = _resource<SysDept>(DeptRestDelegate());
      expect(route.subRoutes.map(_signature), _fullCrud);
    });

    test('/api/menu —— 完整 CRUD（列表返回树）', () {
      final route = _resource<SysMenu>(MenuRestDelegate());
      expect(route.subRoutes.map(_signature), _fullCrud);
    });

    test('/api/dict-code —— 完整 CRUD（列表不分页）', () {
      final route = _resource<SysDictCode>(DictCodeRestDelegate());
      expect(route.subRoutes.map(_signature), _fullCrud);
    });

    test('/api/dict-data —— 完整 CRUD（列表不分页）', () {
      final route = _resource<SysDictData>(DictDataRestDelegate());
      expect(route.subRoutes.map(_signature), _fullCrud);
    });

    // typed RoleEndpoint 没有 add，所以 REST 侧也不注册 POST /。
    test('/api/role —— 少一条 POST /（没有「新增」这个业务动作）', () {
      final route = _resource<SysRole>(RoleRestDelegate(), enableCreate: false);
      final signatures = route.subRoutes.map(_signature);

      expect(signatures, isNot(contains('POST /')));
      expect(route.subRoutes.length, 7);
      // POST 兼容形式仍在 —— 「没有新增」不等于「没有 POST」。
      expect(signatures, containsAll(<String>['POST /update', 'POST /delete']));
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
      app.injectAt('/api/dict-data', _resource<SysDictData>(DictDataRestDelegate()));
      app.injectAt('/api/dict-code', _resource<SysDictCode>(DictCodeRestDelegate()));
      app.injectAt('/api/menu', _resource<SysMenu>(MenuRestDelegate()));
      app.injectAt('/api/dept', _resource<SysDept>(DeptRestDelegate()));
      app.injectAt(
        '/api/role',
        _resource<SysRole>(RoleRestDelegate(), enableCreate: false),
      );
      app.injectAt('/api/user', _resource<SysUser>(UserRestDelegate()));
      return app;
    }

    const mountedPaths = <String>[
      '/api/dict-data',
      '/api/dict-code',
      '/api/menu',
      '/api/dept',
      '/api/role',
      '/api/user',
    ];

    test('6 个资源挂在 6 个不同挂载点上，互不冲突', () {
      expect(mountAll, returnsNormally);
      expect(mountedPaths.toSet().length, mountedPaths.length);
    });

    test('挂载点与其子路径都能命中', () {
      final app = mountAll();
      for (final path in mountedPaths) {
        expect(
          app.lookupUri(Method.get, Uri.parse(path)),
          isA<RouterMatch>(),
          reason: 'GET $path',
        );
        expect(
          app.lookupUri(Method.get, Uri.parse('$path/1')),
          isA<RouterMatch>(),
          reason: 'GET $path/1',
        );
        expect(
          app.lookupUri(Method.options, Uri.parse(path)),
          isA<RouterMatch>(),
          reason: 'OPTIONS $path（预检必须注册）',
        );
      }
    });

    // role 没有新增能力：POST /api/role 应当是 **405**（该路径注册了
    // GET/DELETE/OPTIONS，方法不匹配），而不是 404。
    test('role 的 POST /api/role 是 405，其它资源的 POST 能命中', () {
      final app = mountAll();

      final result = app.lookupUri(Method.post, Uri.parse('/api/role'));
      expect(result, isA<MethodMiss>());
      expect((result as MethodMiss).allowed, isNot(contains(Method.post)));

      for (final path in mountedPaths.where((p) => p != '/api/role')) {
        expect(
          app.lookupUri(Method.post, Uri.parse(path)),
          isA<RouterMatch>(),
          reason: 'POST $path',
        );
      }
    });

    test('资源自身只负责挂载（path=/），请求全部走子路由', () {
      expect(_resource<SysDept>(DeptRestDelegate()).path, '/');
    });
  });
}
