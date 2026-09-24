import 'package:flutter_web_server/src/web/routes/api/airtable/fields_action_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/airtable/items_action_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/airtable/relations_action_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/airtable/rows_action_routes.dart';
import 'package:flutter_web_server/src/web/routes/api/airtable/tables_action_routes.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// airtable 子系统（C 档）REST 路由的**汇总入口**。
///
/// ## 覆盖范围：5 个 typed Endpoint / 21 个方法 → 13 条路径
///
/// | 层 | 路径 | 方法 |
/// |---|---|---|
/// | 表 | `/api/airtable/tables` | GET（分页列表）、POST（新建） |
/// | 表 | `/api/airtable/tables/:id` | GET（详情）、PUT\|POST（改名）、DELETE |
/// | 字段 | `/api/airtable/tables/:id/fields` | GET、POST |
/// | 字段 | `/api/airtable/fields/:id` | PUT\|POST（改名）、DELETE |
/// | 行 | `/api/airtable/tables/:id/rows` | GET（分页）、POST（新增） |
/// | 行 | `/api/airtable/rows/:id` | PUT\|POST（改序）、DELETE |
/// | 行 | `/api/airtable/rows/delete` | POST（批量删） |
/// | 单元格 | `/api/airtable/items` | POST（按「行 × 列」UPSERT） |
/// | 单元格 | `/api/airtable/items/:id` | DELETE |
/// | 关联 | `/api/airtable/items/:id/relations` | GET |
/// | 关联 | `/api/airtable/tables/:id/searchable-items` | GET（分页） |
/// | 关联 | `/api/airtable/relations/tables` | GET |
/// | 关联 | `/api/airtable/relations/tables/:id/fields` | GET |
///
/// ## 为什么路径是「复数 + 完整资源层级」，与 A 档的单数不一样
///
/// A 档（决策 1）统一用**单数**：`/api/user`、`/api/dept` —— 因为那是
/// 「一个资源一处挂载点」。
///
/// airtable 不是：它是**四层嵌套**，`tables/:id/fields` 与 `fields/:id`
/// 表达的是两个不同层级上的东西（「表下面挂的列」 vs 「一个列本身」）。
/// 用复数能一眼看出「这里是某一层的集合」，也不会和单数资源名混淆。
/// 这是**有意的不一致**，不是漏改。
///
/// ## ⚠️ 参数名全组统一为 `:id`
///
/// `tables/:id/fields`、`tables/:id/rows`、`tables/:id/searchable-items`
/// 共用同一层节点，**参数名必须一致** —— 写 `:tableId` 会让
/// `PathTrie` 在注册阶段抛 `Conflicting parameter names at the same level`，
/// 服务直接起不来。所以这里靠**位置**而不是名字表达语义。
///
/// ## ⚠️ 合并时不能有重复键
///
/// Dart 的 map 字面量遇到重复键会**静默覆盖**（后者赢），而每个键对应一条
/// 路由 —— 覆盖就等于少挂一条，且只会在运行期表现为 404。
/// [airtableActionRoutes] 里有一条断言专门兜这个，别删。
Map<String, RestActionRoute> airtableActionRoutes() {
  final groups = <Map<String, RestActionRoute>>[
    airtableTableActionRoutes(),
    airtableFieldActionRoutes(),
    airtableRowActionRoutes(),
    airtableItemActionRoutes(),
    airtableRelationActionRoutes(),
  ];

  final merged = <String, RestActionRoute>{};
  for (final group in groups) {
    for (final entry in group.entries) {
      assert(
        !merged.containsKey(entry.key),
        'airtable REST 路径重复：${entry.key} —— 重复的 map 键会静默覆盖成一条路由',
      );
      merged[entry.key] = entry.value;
    }
  }
  return merged;
}

/// 把 airtable 的全部路由挂到 Web Server 上。
///
/// ⚠️ 每条路由一个**完整路径**挂载点 —— `addRoute` 内部是 `PathTrie.injectAt`，
/// 同一个挂载点挂两次会抛 `Conflicting values`。所以同一路径的不同方法
/// 必须先在各自的 `*_action_routes.dart` 里用 `RestActionRoute.byMethod` 合并。
void registerAirtableActionRoutes(Serverpod pod) => airtableActionRoutes()
    .forEach((path, route) => pod.webServer.addRoute(route, path));
