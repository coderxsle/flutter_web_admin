import 'package:serverpod/serverpod.dart';

import 'data_permission_plugin.dart';

/// A data permission plugin that does not add any row-level filter.
class NoopDataPermissionPlugin<TTable extends Table>
    extends DataPermissionPlugin<TTable> {
  const NoopDataPermissionPlugin();

  @override
  Expression? buildFilter(Session session, TTable table) => null;

  @override
  Map<String, dynamic> toJson() => {};
}
