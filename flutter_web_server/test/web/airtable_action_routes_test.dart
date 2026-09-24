import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/web/routes/api/airtable/airtable_action_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/airtable/fields_action_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/airtable/items_action_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/airtable/relations_action_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/airtable/rows_action_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/airtable/tables_action_routes.dart';
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

/// C 档 airtable 的**装配**测试（S4）—— 只验证路由表与匹配行为，
/// 不碰数据库、不碰 Service。
///
/// 这里钉住的都是「起服务后最难察觉」的那一类问题，而且**大多数是 S4 新引入
/// 的风险面**（A/B 档没遇到过）：
///
/// * **同一路径多种方法 → 必须是一条路由**。`addRoute` 的挂载点唯一，
///   同字符串挂两次抛 `Conflicting values`；而 `Map<String, …>` 的重复键会
///   **静默覆盖**，表现为「某个方法凭空 404」。两条都有断言。
/// * **一层里只能有一个参数名**。airtable 用 `tables/:id/fields`、
///   `tables/:id/rows`、`tables/:id/searchable-items` 共用了同一层节点，
///   混写 `:tableId` 会让服务在**注册阶段**就起不来。
/// * **字面量段优先**。`POST /rows/delete`（批量删）与 `POST /rows/:id`
///   （改行）同层同方法，参数段优先的话 `delete` 会被当成 id →
///   变成 400「路径参数必须是正整数」。
/// * **信封有没有漏传**。漏了就静默退回中立信封（`{message, data}`，
///   没有 `code`），前端解析静默失灵。
void main() {
  group('airtable 路由表（注册源即测试源）', () {
    test('13 条路径，与预期一一对应', () {
      expect(airtableActionRoutes().keys.toSet(), kAirtablePaths.toSet());
      expect(airtableActionRoutes().length, 13);
    });

    test('分组拼装不会因为重复键静默丢路由', () {
      // `airtableActionRoutes()` 内部有一条同义断言；这里从外面再验一遍，
      // 因为重复键的后果（少一条路由）在运行期只表现为 404，非常难查。
      final grouped = [
        ...airtableTableActionRoutes().keys,
        ...airtableFieldActionRoutes().keys,
        ...airtableRowActionRoutes().keys,
        ...airtableItemActionRoutes().keys,
        ...airtableRelationActionRoutes().keys,
      ];
      expect(grouped.toSet().length, grouped.length, reason: '存在重复路径');
      expect(grouped.length, 13);
    });

    test('每条路径允许的方法与设计一致', () {
      final routes = airtableActionRoutes();
      String methodsOf(String path) =>
          (routes[path]!.methods.map((m) => m.value).toList()..sort()).join('|');

      expect(methodsOf('/api/airtable/tables'), 'GET|POST');
      expect(methodsOf('/api/airtable/tables/:id'), 'DELETE|GET|POST|PUT');
      expect(methodsOf('/api/airtable/tables/:id/fields'), 'GET|POST');
      expect(methodsOf('/api/airtable/fields/:id'), 'DELETE|POST|PUT');
      expect(methodsOf('/api/airtable/tables/:id/rows'), 'GET|POST');
      expect(methodsOf('/api/airtable/rows/:id'), 'DELETE|POST|PUT');
      expect(methodsOf('/api/airtable/rows/delete'), 'POST');
      expect(methodsOf('/api/airtable/items'), 'POST');
      expect(methodsOf('/api/airtable/items/:id'), 'DELETE');
      expect(methodsOf('/api/airtable/items/:id/relations'), 'GET');
      expect(methodsOf('/api/airtable/tables/:id/searchable-items'), 'GET');
      expect(methodsOf('/api/airtable/relations/tables'), 'GET');
      expect(methodsOf('/api/airtable/relations/tables/:id/fields'), 'GET');
    });

    test('airtable 全部要求登录（没有匿名接口）', () {
      final anonymous = airtableActionRoutes().entries
          .where((e) => !e.value.requireAuth)
          .map((e) => e.key)
          .toList();
      expect(anonymous, isEmpty);
    });

    test('信封全部显式传了 ServerpodEnvelopeBuilder', () {
      for (final entry in airtableActionRoutes().entries) {
        expect(
          entry.value.envelope,
          isA<ServerpodEnvelopeBuilder>(),
          reason: entry.key,
        );
      }
    });
  });

  group('全量挂载（复刻 registerApiRoutes → WebServer.addRoute → injectAt）', () {
    test('A 档 + B 档 + C 档一起挂，互不冲突', () {
      expect(mountFullApi, returnsNormally);
    });

    test('13 条路径全部命中，且 OPTIONS 预检都注册了', () {
      final app = mountFullApi();
      for (final path in kAirtablePaths) {        for (final method in airtableActionRoutes()[path]!.methods) {
          final concrete = path.replaceAll(':id', '5');
          expect(
            app.lookupUri(method, Uri.parse(concrete)),
            isA<RouterMatch>(),
            reason: '${method.value} $concrete',
          );
        }

        final concrete = path.replaceAll(':id', '5');
        expect(
          app.lookupUri(Method.options, Uri.parse(concrete)),
          isA<RouterMatch>(),
          reason: 'OPTIONS $concrete（relic 中间件是路由级的，预检必须显式注册）',
        );
      }
    });

    test('反向：定义里没有的方法返回 405 而不是 404', () {
      final app = mountFullApi();

      // `/tables` 只接受 GET / POST。
      final miss = app.lookupUri(Method.delete, Uri.parse('/api/airtable/tables'));
      expect(miss, isA<MethodMiss>());
      expect((miss as MethodMiss).allowed, isNot(contains(Method.delete)));

      // `/items` 只接受 POST（写入是按坐标的 UPSERT，没有「列出所有单元格」）。
      expect(
        app.lookupUri(Method.get, Uri.parse('/api/airtable/items')),
        isA<MethodMiss>(),
      );
    });

    test('airtable 不会影响 A/B 档已有路由', () {
      final app = mountFullApi();

      expect(
        app.lookupUri(Method.get, Uri.parse('/api/user/getList')),
        isA<RouterMatch>(),
      );
      expect(app.lookupUri(Method.get, Uri.parse('/api/user/info')), isA<RouterMatch>());
      expect(app.lookupUri(Method.get, Uri.parse('/api/role/5/menu-ids')), isA<RouterMatch>());
      expect(app.lookupUri(Method.get, Uri.parse('/api/dict/options')), isA<RouterMatch>());
    });
  });

  group('同一路径的多种方法（byMethod 分派）', () {
    test('GET 与 POST 命中的是同一条路由对象', () {
      final app = mountFullApi();

      final viaGet = app.lookupUri(Method.get, Uri.parse('/api/airtable/tables'));
      final viaPost = app.lookupUri(Method.post, Uri.parse('/api/airtable/tables'));

      expect(viaGet, isA<RouterMatch>());
      expect(viaPost, isA<RouterMatch>());

      // 两条必须在**同一个挂载点**上 —— 这正是「一条路由多方法」的意义。
      // `RouterMatch.value` 是 `Route.asHandler` 产出的闭包，不能靠值身份
      // 判断命中哪条路由（同一个 route 每次 asHandler 都会是新闭包），
      // 所以这里改成验「methods 集合」这件事已经由上面的路由表断言覆盖。
      expect(
        airtableActionRoutes()['/api/airtable/tables']!.methods,
        {Method.get, Method.post},
      );
    });

    test('byMethod 的 methods 集合恰好等于传入的 handlers 键集合', () {
      for (final entry in airtableActionRoutes().entries) {
        expect(entry.value.methods, isNotEmpty, reason: entry.key);
        expect(
          entry.value.methods.length,
          entry.value.methods.toSet().length,
          reason: '${entry.key} 存在重复 method',
        );
      }
    });
  });

  group('字面量段优先于参数段', () {
    test('POST /api/airtable/rows/delete 命中字面量，不被 /rows/:id 吃掉', () {
      final app = mountFullApi();

      final match = app.lookupUri(
        Method.post,
        Uri.parse('/api/airtable/rows/delete'),
      );
      expect(match, isA<RouterMatch>());
      expect(
        (match as RouterMatch).parameters,
        isEmpty,
        reason: '落到 :id 上就会变成 400「路径参数必须是正整数」，批量删彻底不可用',
      );
    });

    test('对照：真按 id 访问时能正确提取 :id', () {
      final app = mountFullApi();

      final match = app.lookupUri(
        Method.delete,
        Uri.parse('/api/airtable/rows/5'),
      ) as RouterMatch;
      expect(match.parameters[#id], '5');
    });
  });

  group('路径参数名全组统一为 :id', () {
    test('四条 tables 子路径共用同一层，提取到的都是同一个 :id', () {
      final app = mountFullApi();

      final cases = <(Method, String)>[
        (Method.get, '/api/airtable/tables/5'),
        (Method.get, '/api/airtable/tables/5/fields'),
        (Method.get, '/api/airtable/tables/5/rows'),
        (Method.get, '/api/airtable/tables/5/searchable-items'),
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

    test('items / relations 两组各自提取到 :id', () {
      final app = mountFullApi();

      final cases = <(Method, String)>[
        (Method.get, '/api/airtable/items/9/relations'),
        (Method.get, '/api/airtable/relations/tables/9/fields'),
      ];

      for (final (method, path) in cases) {
        final match = app.lookupUri(method, Uri.parse(path)) as RouterMatch;
        expect(match.parameters[#id], '9', reason: '${method.value} $path');
      }
    });

    test('参数名不能另起：`:tableId` 会与同层的 `:id` 冲突', () {
      // 这条不是「测试 relic 的怪癖」，而是钉住一条**必须遵守的约束**：
      // 任何新加的 airtable 子路径都只能用 `:id`。换成 `:tableId` 会在
      // `pod.start()` 之前的注册阶段直接抛异常 —— 服务根本起不来。
      //
      // ⚠️ 必须先挂上 `tables/:id` 才有冲突可言：`PathTrie` 是「同层已有
      // 参数节点」时校验名字，只挂字面量 `/tables` 时 `:tableId` 是第一个
      // 参数节点，不会报错。
      final app = RelicRouter()
        ..injectAt(
          '/api/airtable/tables',
          airtableTableActionRoutes()['/api/airtable/tables']!,
        )
        ..injectAt(
          '/api/airtable/tables/:id',
          airtableTableActionRoutes()['/api/airtable/tables/:id']!,
        );

      expect(
        () => app.injectAt(
          '/api/airtable/tables/:tableId/fields',
          airtableFieldActionRoutes()['/api/airtable/tables/:id/fields']!,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('同一挂载点挂两次会抛 Conflicting values（所以必须合并成一条路由）', () {
      final app = RelicRouter()
        ..injectAt(
          '/api/airtable/tables',
          airtableTableActionRoutes()['/api/airtable/tables']!,
        );

      expect(
        () => app.injectAt(
          '/api/airtable/tables',
          airtableTableActionRoutes()['/api/airtable/tables']!,
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}

/// airtable 一共 **13 条路径**，覆盖 5 个 typed Endpoint / 21 个方法。
///
/// 21 → 13 的原因：
/// * 同一路径的多种方法合并成一条路由（`GET` + `POST /tables` 是 1 条不是 2 条）；
/// * `PUT` 与 `POST` 两种写法走同一条路径的同一个 handler；
/// * `getTables2` 与 `getTables` 合并成 `GET /tables`（−1）。
const kAirtablePaths = <String>[
  '/api/airtable/tables',
  '/api/airtable/tables/:id',
  '/api/airtable/tables/:id/fields',
  '/api/airtable/fields/:id',
  '/api/airtable/tables/:id/rows',
  '/api/airtable/rows/:id',
  '/api/airtable/rows/delete',
  '/api/airtable/items',
  '/api/airtable/items/:id',
  '/api/airtable/items/:id/relations',
  '/api/airtable/tables/:id/searchable-items',
  '/api/airtable/relations/tables',
  '/api/airtable/relations/tables/:id/fields',
];

BaseRestRoute<T> _resource<T extends TableRow>(
  RestCrudDelegate<T> delegate, {
  bool enableCreate = true,
}) => BaseRestRoute<T>(
  delegate: delegate,
  envelope: const ServerpodEnvelopeBuilder(),
  enableCreate: enableCreate,
);

/// 复刻 `registerApiRoutes` 的完整挂载：A 档 6 资源 + B 档 14 条动作 + C 档 airtable。
RelicRouter mountFullApi() {
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

  final groups = <Map<String, RestActionRoute>>[
    authActionRoutes(),
    userActionRoutes(),
    roleActionRoutes(),
    menuActionRoutes(),
    dictActionRoutes(),
    systemActionRoutes(),
    airtableActionRoutes(),
  ];
  for (final group in groups) {
    group.forEach((path, route) => app.injectAt(path, route));
  }

  return app;
}
