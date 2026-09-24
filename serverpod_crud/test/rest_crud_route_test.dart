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
/// 注意是 `extends` 而不是 `implements` —— [RestCrudDelegate.removeBatch]
/// 有默认实现，`implements` 会要求把它也重写一遍。
class _FakeDelegate extends RestCrudDelegate<_FakeRow> {
  @override
  Future<Object?> list(Session session, Request request) =>
      throw UnimplementedError();

  @override
  Future<_FakeRow> detail(Session session, int id) => throw UnimplementedError();

  @override
  Future<_FakeRow> create(Session session, Map<String, dynamic> body) =>
      throw UnimplementedError();

  @override
  Future<_FakeRow> update(
    Session session,
    int id,
    Map<String, dynamic> body,
  ) => throw UnimplementedError();

  @override
  Future<void> remove(Session session, int id) => throw UnimplementedError();
}

class _FakeModel implements SerializableModel {
  @override
  Map<String, dynamic> toJson() => {'id': 1, 'name': '张三'};
}

/// 把一条路由压成 `method(s) path` 便于断言。
String _signature(Route route) {
  final methods = route.methods.map((m) => m.value).toList()..sort();
  return '${methods.join('|')} ${route.path}';
}

BaseRestRoute<_FakeRow> _route({
  bool enableBatchDelete = true,
  bool enablePostAliases = true,
  Set<Method> updateMethods = const {Method.put, Method.patch},
}) => BaseRestRoute<_FakeRow>(
  delegate: _FakeDelegate(),
  enableBatchDelete: enableBatchDelete,
  enablePostAliases: enablePostAliases,
  updateMethods: updateMethods,
);

void main() {
  group('BaseRestRoute 自动产生的路由表', () {
    test('默认产出 8 条路由（含用户要的 5 条 + 批量删 + 两条 POST 兼容）', () {
      expect(_route().subRoutes.map(_signature).toList(), [
        'GET /',
        'GET /:id',
        'POST /',
        'PATCH|PUT /:id',
        'DELETE /:id',
        'DELETE /',
        'POST /update',
        'POST /delete',
      ]);
    });

    test('用户点名的那 5 条一定在', () {
      final signatures = _route().subRoutes.map(_signature);
      for (final expected in [
        'GET /',
        'GET /:id',
        'POST /',
        'PATCH|PUT /:id',
        'DELETE /:id',
      ]) {
        expect(signatures, contains(expected));
      }
    });

    test('关掉 POST 兼容形式只剩标准动词', () {
      expect(
        _route(enablePostAliases: false).subRoutes.map(_signature),
        isNot(anyOf(contains('POST /update'), contains('POST /delete'))),
      );
      expect(_route(enablePostAliases: false).subRoutes.length, 6);
    });

    test('关掉批量删时不注册 DELETE /', () {
      final signatures = _route(enableBatchDelete: false).subRoutes.map(_signature);
      expect(signatures, isNot(contains('DELETE /')));
      expect(_route(enableBatchDelete: false).subRoutes.length, 7);
    });

    test('updateMethods 可裁剪 PUT|PATCH', () {
      final signatures = _route(updateMethods: const {Method.put}).subRoutes
          .map(_signature);
      expect(signatures, contains('PUT /:id'));
      expect(signatures, isNot(contains('PATCH|PUT /:id')));
    });

    test('挂载点是 / 且自身不处理请求（请求走子路由）', () {
      expect(_route().path, '/');
    });

    // 这条是本项目最容易踩的坑：`WebServer.addRoute` 内部是
    // `_app.injectAt('*/$path', route)`，而 relic 的 PathTrie 不允许在同一个
    // 挂载点注入第二个 handler（会抛 `Conflicting values`）。BaseRestRoute
    // 把「一次挂载 + N 条子路由」放在同一次 injectIn 里，所以不会冲突 ——
    // 这条测试就是把它钉住，免得以后有人改回逐条 addRoute。
    test('整套子路由能注入同一个 relic 路由器而不冲突', () {
      final router = RelicRouter();
      expect(() => _route().injectIn(router), returnsNormally);
    });
  });

  group('extractIds', () {
    test('接受 {"id":n}', () {
      expect(extractIds({'id': 3}), [3]);
    });

    test('接受 {"ids":[…]}，并容忍字符串数字', () {
      expect(extractIds({'ids': [1, '2', 3]}), [1, 2, 3]);
    });

    test('去重且丢弃非法值', () {
      expect(extractIds({'ids': [1, 1, 2, 0, -3, 'x', null]}), [1, 2]);
    });

    test('取不到合法 id 时抛 400', () {
      for (final body in <Map<String, dynamic>>[
        {},
        {'ids': <int>[]},
        {'ids': [0, -1]},
        {'id': 'abc'},
      ]) {
        expect(
          () => extractIds(body),
          throwsA(
            isA<RestApiException>().having((e) => e.httpStatus, 'httpStatus', 400),
          ),
          reason: 'body=$body',
        );
      }
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

    test('page 把分页元信息摊平到顶层（对齐项目 PageResponse）', () {
      final json = envelope.page(
        RestPage<Object>(
          data: [_FakeModel()],
          page: 2,
          pageSize: 3,
          total: 12,
        ),
      );

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
      expect(envelope.failure('boom', code: 404), {
        'message': 'boom',
        'code': 404,
      });
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
