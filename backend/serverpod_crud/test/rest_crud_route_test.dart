import 'dart:convert';

import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';
import 'package:test/test.dart';

/// 最小的 [TableRow] 实现 —— 这些测试只看路由表，不触碰数据库，
/// 所以 [table] 故意抛异常（也就避免了构造真实 `Table` 的麻烦）。
class _FakeRow implements TableRow<int?> {
  _FakeRow(this.id);

  @override
  final int? id;

  @override
  Table<int?> get table => throw UnimplementedError('测试不触碰表');

  @override
  Map<String, dynamic> toJson() => {'id': id};
}

/// 只用来验证路由表的空实现。
///
/// 注意是 `extends` 而不是 `implements` —— [CrudDelegate.removeBatch]
/// 有默认实现，`implements` 会要求把它也重写一遍。
class _FakeDelegate extends CrudDelegate<_FakeRow> {
  @override
  Future<Object?> list(Session session, Request request) => throw UnimplementedError();

  @override
  Future<_FakeRow> detail(Session session, int id) => throw UnimplementedError();

  @override
  Future<_FakeRow> create(Session session, Map<String, dynamic> body) => throw UnimplementedError();

  @override
  Future<_FakeRow> update(Session session, int id, Map<String, dynamic> body) => throw UnimplementedError();

  @override
  Future<void> remove(Session session, int id) => throw UnimplementedError();
}

class _FakeModel implements SerializableModel {
  @override
  Map<String, dynamic> toJson() => {'id': 1, 'name': '张三'};
}

class _MarkerEnvelope extends PlainEnvelopeBuilder {
  const _MarkerEnvelope();
}

/// 把一条路由压成 `method(s) path` 便于断言。
String _signature(Route route) {
  final methods = route.methods.map((m) => m.value).toList()..sort();
  return '${methods.join('|')} ${route.path}';
}

BaseRoute<_FakeRow> _route({bool enableBatchDelete = true, bool enableCreate = true}) => BaseRoute<_FakeRow>(
  delegate: _FakeDelegate(),
  enableBatchDelete: enableBatchDelete,
  enableCreate: enableCreate,
);

void main() {
  group('BaseRoute 自动产生的路由表（团队式）', () {
    test('默认产出 6 条路由，一动作一路径', () {
      expect(_route().subRoutes.map(_signature).toList(), [
        'GET /getList',
        'GET /getDetail',
        'POST /add',
        'POST /update',
        'POST /delete',
        'POST /deleteBatch',
      ]);
    });

    // 换掉 REST 原生那套（`GET /:id`、`PUT|PATCH /:id`、`DELETE /:id`）之后，
    // 资源挂载点下不再有参数段 —— `PathTrie` 那条「同层不同参数名会抛
    // Conflicting parameter names at the same level」的约束也就无从触发。
    test('没有任何 :id 参数段', () {
      for (final route in _route().subRoutes) {
        expect(route.path, isNot(contains(':')), reason: route.path);
      }
    });

    test('关掉批量删时不注册 POST /deleteBatch', () {
      final signatures = _route(enableBatchDelete: false).subRoutes.map(_signature);
      expect(signatures, isNot(contains('POST /deleteBatch')));
      expect(_route(enableBatchDelete: false).subRoutes.length, 5);
    });

    test('挂载点是 / 且自身不处理请求（请求走子路由）', () {
      expect(_route().path, '/');
    });

    test('每条子路径都补了 OPTIONS（否则浏览器预检 405，CORS 头加不上）', () {
      final router = RelicRouter();
      _route().injectIn(router);
      for (final path in ['/getList', '/getDetail', '/add', '/update', '/delete', '/deleteBatch']) {
        expect(router.lookupUri(Method.options, Uri.parse(path)), isA<RouterMatch>(), reason: 'OPTIONS $path');
      }
    });

    // 这条是本项目最容易踩的坑：`WebServer.addRoute` 内部是
    // `_app.injectAt('*/$path', route)`，而 relic 的 PathTrie 不允许在同一个
    // 挂载点注入第二个 handler（会抛 `Conflicting values`）。BaseRoute
    // 把「一次挂载 + N 条子路由」放在同一次 injectIn 里，所以不会冲突 ——
    // 这条测试就是把它钉住，免得以后有人改回逐条 addRoute。
    test('整套子路由能注入同一个 relic 路由器而不冲突', () {
      final router = RelicRouter();
      expect(() => _route().injectIn(router), returnsNormally);
    });
  });

  // 本项目 `sys_role` 就是这种资源：业务侧没有「新增角色」这个动作，
  // REST 侧也不该凭空造一个。
  group('enableCreate: false（不支持新增的资源）', () {
    test('不注册 POST /add，其余照旧', () {
      final signatures = _route(enableCreate: false).subRoutes.map(_signature);
      expect(signatures, isNot(contains('POST /add')));
      expect(_route(enableCreate: false).subRoutes.length, 5);
      expect(signatures, containsAll(<String>['POST /update', 'POST /delete', 'POST /deleteBatch']));
    });

    // ⚠️ 语义与「一动作一路径」之前**不同**：那时 `POST /` 是 405
    // （路径还在，只是方法不允许）；现在 `/add` 是一条独立路由，
    // 没注册就是 404 —— 这个变化是有意的，别当成回归去「修」。
    test('POST /add 落 404（路径上一条路由都没有），OPTIONS 也没补', () {
      final router = RelicRouter();
      _route(enableCreate: false).injectIn(router);

      expect(router.lookupUri(Method.post, Uri.parse('/add')), isA<PathMiss>());
      expect(router.lookupUri(Method.options, Uri.parse('/add')), isA<PathMiss>());

      // 对照：默认配置下 POST /add 是能匹配上的。
      final openRouter = RelicRouter();
      _route().injectIn(openRouter);
      expect(openRouter.lookupUri(Method.post, Uri.parse('/add')), isA<RouterMatch>());
    });

    test('已注册子路径的 OPTIONS 仍照常补上', () {
      final router = RelicRouter();
      _route(enableCreate: false).injectIn(router);
      expect(router.lookupUri(Method.options, Uri.parse('/getList')), isA<RouterMatch>());
    });
  });

  // 「手搓的树」是本项目最典型的载荷：`DeptService.getList` / `MenuService.getList`
  // 返回的是自己拼的 `List<Map<String, dynamic>>`，里面的 `createTime` 是
  // **DateTime 对象**。用 `dart:convert` 的 `jsonEncode` 直接抛，而 typed
  // Endpoint 走的 `SerializationManager.encodeForProtocol` 会转成 ISO 串 ——
  // 所以 REST 侧必须用同一个编码器，否则部门树 / 菜单树一调就 500。
  group('encodeEnvelope（为什么必须用 Serverpod 的编码器）', () {
    test('手搓树里的 DateTime 会被编码成 ISO 串', () {
      final payload = <String, dynamic>{
        'code': 20000,
        'message': 'succeed',
        'data': [
          {'id': 1, 'name': '研发部', 'createTime': DateTime.utc(2026, 9, 24, 3)},
        ],
      };

      expect(jsonDecode(encodeEnvelope(payload)), {
        'code': 20000,
        'message': 'succeed',
        'data': [
          {'id': 1, 'name': '研发部', 'createTime': '2026-09-24T03:00:00.000Z'},
        ],
      });
    });

    test('同一份载荷交给 jsonEncode 会直接抛（这条钉住上面的理由）', () {
      final payload = <String, dynamic>{
        'data': [
          {'createTime': DateTime.utc(2026)},
        ],
      };
      expect(() => jsonEncode(payload), throwsA(isA<JsonUnsupportedObjectError>()));
      expect(() => encodeEnvelope(payload), returnsNormally);
    });

    test('嵌套的 SerializableModel 也会被 json 化', () {
      final encoded = encodeEnvelope({
        'data': [_FakeModel()],
      });
      expect(jsonDecode(encoded), {
        'data': [
          {'id': 1, 'name': '张三'},
        ],
      });
    });
  });

  group('extractIds', () {
    test('接受 {"id":n}', () {
      expect(extractIds({'id': 3}), [3]);
    });

    test('接受 {"ids":[…]}，并容忍字符串数字', () {
      expect(
        extractIds({
          'ids': [1, '2', 3],
        }),
        [1, 2, 3],
      );
    });

    test('去重且丢弃非法值', () {
      expect(
        extractIds({
          'ids': [1, 1, 2, 0, -3, 'x', null],
        }),
        [1, 2],
      );
    });

    test('取不到合法 id 时抛 400', () {
      for (final body in <Map<String, dynamic>>[
        {},
        {'ids': <int>[]},
        {
          'ids': [0, -1],
        },
        {'id': 'abc'},
      ]) {
        expect(
          () => extractIds(body),
          throwsA(isA<RestException>().having((e) => e.httpStatus, 'httpStatus', 400)),
          reason: 'body=$body',
        );
      }
    });
  });

  // `POST /delete` 只删单条，`POST /deleteBatch` 才删多条。两者的响应形状
  // 不同（`boolean` vs `CrudBatchResult`），所以路由层必须硬性区分 ——
  // 同一条路由按入参长度返回两种形状会很难用。
  group('extractSingleId（POST /delete 的入参）', () {
    test('接受 {"id":n} 与只有一个元素的 {"ids":[n]}', () {
      expect(extractSingleId({'id': 3}), 3);
      expect(
        extractSingleId({
          'ids': [3],
        }),
        3,
      );
      expect(
        extractSingleId({
          'ids': ['3'],
        }),
        3,
      );
    });

    test('多个 id 抛 400 —— 那是 POST /deleteBatch 的活', () {
      expect(
        () => extractSingleId({
          'ids': [1, 2],
        }),
        throwsA(isA<RestException>().having((e) => e.httpStatus, 'httpStatus', 400)),
      );
    });

    test('取不到合法 id 时同样抛 400', () {
      for (final body in <Map<String, dynamic>>[
        {},
        {'ids': <int>[]},
      ]) {
        expect(() => extractSingleId(body), throwsA(isA<RestException>()), reason: 'body=$body');
      }
    });
  });

  group('ActionRoute（非 CRUD 的业务动作路由）', () {
    ActionRoute action({Set<Method> methods = const {Method.post}, bool requireAuth = true}) =>
        ActionRoute(methods: methods, requireAuth: requireAuth, handler: (session, request) async => {'ok': true});

    test('只是普通 Route：默认挂载点是 / 且方法可自定义', () {
      final route = action(methods: const {Method.get});
      expect(_signature(route), 'GET /');
      expect(action().requireAuth, isTrue);
      expect(action(requireAuth: false).requireAuth, isFalse);
    });

    // 这条是「OPTIONS 必须注册」的守门测试 —— 线上它只在浏览器发预检时
    // 才暴露（未注册就 405、CORS 中间件根本不跑）。relic 的 lookupUri 让
    // 我们不用起服务就能断言。
    test('同路径注册了业务方法 + OPTIONS（否则预检 405，CORS 头加不上）', () {
      final router = RelicRouter();
      action().injectIn(router);

      expect(router.lookupUri(Method.post, Uri.parse('/')), isA<RouterMatch>());
      expect(router.lookupUri(Method.options, Uri.parse('/')), isA<RouterMatch>());

      // 没注册的方法应当是 MethodMiss（405），而不是 PathMiss（404）。
      final miss = router.lookupUri(Method.get, Uri.parse('/'));
      expect(miss, isA<MethodMiss>());
      expect((miss as MethodMiss).allowed, containsAll(<Method>[Method.post, Method.options]));
    });

    test('多条动作路由按完整路径各挂一次，互不冲突', () {
      final router = RelicRouter();
      expect(
        () => ActionRoute(
          methods: const {Method.get},
          path: '/publicKey',
          handler: (session, request) async => null,
        ).injectIn(router),
        returnsNormally,
      );
      expect(
        () => ActionRoute(
          methods: const {Method.post},
          path: '/login',
          handler: (session, request) async => null,
        ).injectIn(router),
        returnsNormally,
      );
    });
  });

  group('RestAction 工厂', () {
    test('get/post/put/delete 分别生成对应 HTTP 方法', () {
      String signature(RestAction action) => '${action.methods.map((method) => method.value).join('|')} ${action.path}';

      expect(signature(get('/get', (session, request) async => null)), 'GET /get');
      expect(signature(post('/post', (session, request) async => null)), 'POST /post');
      expect(signature(put('/put', (session, request) async => null)), 'PUT /put');
      expect(signature(delete('/delete', (session, request) async => null)), 'DELETE /delete');
    });

    test('BaseRoute 可以用 CrudOptions 自动装配 delegate 和动作', () {
      final route = BaseRoute<_FakeRow>(
        options: const CrudOptions<_FakeRow>(),
        actionList: [
          get('/custom', (session, request) async => {'ok': true}),
        ],
      );

      expect(route.isAutoAssembled, isTrue);
      expect(route.actionRoutes.map(_signature), ['GET /custom']);
    });

    test('动作未指定信封时继承 BaseRoute 的信封', () {
      const envelope = _MarkerEnvelope();
      final route = BaseRoute<_FakeRow>(
        delegate: _FakeDelegate(),
        envelope: envelope,
        actionList: [get('/custom', (session, request) async => null)],
      );

      expect(route.actionRoutes.single.envelope, same(envelope));
    });

    test('动作显式信封时覆盖 BaseRoute 的默认信封', () {
      const routeEnvelope = _MarkerEnvelope();
      const actionEnvelope = PlainEnvelopeBuilder();
      final route = BaseRoute<_FakeRow>(
        delegate: _FakeDelegate(),
        envelope: routeEnvelope,
        actionList: [get('/custom', (session, request) async => null, envelope: actionEnvelope)],
      );

      expect(route.actionRoutes.single.envelope, same(actionEnvelope));
    });

    test('同一路径多个方法只注册一条 OPTIONS', () {
      final route = BaseRoute<_FakeRow>(
        actionList: [
          put('/:id/menus', (session, request) async => {'ok': true}),
          post('/:id/menus', (session, request) async => {'ok': true}),
        ],
      );
      final router = RelicRouter();

      expect(() => route.injectIn(router), returnsNormally);
      expect(router.lookupUri(Method.put, Uri.parse('/1/menus')), isA<RouterMatch>());
      expect(router.lookupUri(Method.post, Uri.parse('/1/menus')), isA<RouterMatch>());
      expect(router.lookupUri(Method.options, Uri.parse('/1/menus')), isA<RouterMatch>());
    });
  });

  group('ActionRoute.byMethod（同路径多方法、各自不同逻辑）', () {
    ActionRoute twoMethods() => ActionRoute.byMethod(
      handlers: {
        Method.get: (session, request) async => {'picked': 'GET'},
        Method.post: (session, request) async => {'picked': 'POST'},
      },
    );

    test('methods 恰好是 handlers 的键集合', () {
      expect(_signature(twoMethods()), 'GET|POST /');
    });

    test('每个方法都注册进路由表，并且补上了 OPTIONS', () {
      final router = RelicRouter();
      twoMethods().injectIn(router);

      expect(router.lookupUri(Method.get, Uri.parse('/')), isA<RouterMatch>());
      expect(router.lookupUri(Method.post, Uri.parse('/')), isA<RouterMatch>());
      expect(router.lookupUri(Method.options, Uri.parse('/')), isA<RouterMatch>());

      // 不在 handlers 里的方法 → 405（MethodMiss），不是 404（PathMiss）。
      final miss = router.lookupUri(Method.delete, Uri.parse('/'));
      expect(miss, isA<MethodMiss>());
      expect((miss as MethodMiss).allowed, isNot(contains(Method.delete)));
    });

    test('与主构造一致：默认要求登录，信封可自定义', () {
      final route = ActionRoute.byMethod(handlers: {Method.get: (session, request) async => null});
      expect(route.requireAuth, isTrue);
      expect(route.envelope, isA<PlainEnvelopeBuilder>());
      expect(
        ActionRoute.byMethod(
          handlers: {Method.get: (session, request) async => null},
          requireAuth: false,
        ).requireAuth,
        isFalse,
      );
    });

    test('handlers 为空直接被断言拦住（否则会挂出一条永不匹配的路由）', () {
      expect(
        () => ActionRoute.byMethod(handlers: const <Method, Future<Object?> Function(Session, Request)>{}),
        throwsA(isA<AssertionError>()),
      );
    });

    // 说明：`handlers[request.method]` 那条分派分支本身没有单测 ——
    // 它需要真的构造一个 `Session` 才能调到，而 Serverpod 的 `Session`
    // 没有公开构造函数。分派逻辑只有一行，且「不在 methods 里的方法」在
    // 路由匹配阶段就 405 了，所以那个 `null` 分支按构造不可能到达
    // （如果调用方传了同名方法两次，`handlers.keys.toSet()` 也会先把它合并掉）。
  });

  group('RestException 的业务码兜底', () {
    test('识别不出业务码时填 HTTP 状态码风格的值，由项目侧翻译', () {
      expect(const RestException.badRequest('x').code, 400);
      expect(const RestException.unauthorized().code, 401);
      expect(const RestException.forbidden('x').code, 403);
      expect(const RestException.notFound('x').code, 404);
    });

    test('显式业务码不会被覆盖', () {
      const e = RestException(400, 'x', code: 50000);
      expect(e.code, 50000);
      expect(e.httpStatus, 400);
    });
  });

  group('PlainEnvelopeBuilder', () {
    const envelope = PlainEnvelopeBuilder();

    test('success 把模型 json 化', () {
      expect(envelope.success(_FakeModel()), {
        'message': '',
        'data': {'id': 1, 'name': '张三'},
      });
    });

    // Core 的中立信封：摊平形状，与任何业务项目的 PageResponse 无关
    //（本项目 REST 侧走的是 ServerpodEnvelopeBuilder）。
    test('page 把分页元信息摊平到顶层', () {
      final json = envelope.page(RestPage<Object>(data: [_FakeModel()], page: 2, pageSize: 3, total: 12));

      expect(json['page'], 2);
      expect(json['pageSize'], 3);
      expect(json['total'], 12);
      expect(json['totalPage'], 4);
      expect(json['data'], [
        {'id': 1, 'name': '张三'},
      ]);
    });

    test('failure 省略空业务码', () {
      expect(envelope.failure('boom'), {'message': 'boom'});
      expect(envelope.failure('boom', code: 404), {'message': 'boom', 'code': 404});
    });
  });

  group('RestPage', () {
    test('totalPage 向上取整，pageSize 为 0 时不除零', () {
      expect(const RestPage<Object>(data: [], pageSize: 3, total: 12).totalPage, 4);
      expect(const RestPage<Object>(data: [], pageSize: 0, total: 12).totalPage, 0);
    });

    test('toPayload 抹掉载荷静态类型', () {
      final payload = const RestPage<_FakeRow>(data: []).toPayload();
      expect(payload, isA<RestPage<Object?>>());
    });
  });

  group('restJsonify', () {
    test('递归处理 Map / Iterable / DateTime', () {
      final when = DateTime.utc(2026, 9, 23, 12);
      final result = restJsonify({
        'rows': [_FakeModel()],
        'at': when,
        'count': 2,
        'nothing': null,
      });

      expect(result, {
        'rows': [
          {'id': 1, 'name': '张三'},
        ],
        'at': '2026-09-23T12:00:00.000Z',
        'count': 2,
        'nothing': null,
      });
    });
  });
}
