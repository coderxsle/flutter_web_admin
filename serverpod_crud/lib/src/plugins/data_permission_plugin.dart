import 'package:serverpod/serverpod.dart';

/// 数据权限插件：为查询自动追加权限过滤条件。
abstract class DataPermissionPlugin<TTable extends Table> implements SerializableModel {
  const DataPermissionPlugin();

  Expression? buildFilter(Session session, TTable table);
}
