import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';
/// 空实现的数据权限插件（No-op）。
///
/// 默认不附加任何行级权限条件，适合本地开发或尚未接入权限系统时使用。
class NoopDataPermissionPlugin<TTable extends Table> extends DataPermissionPlugin<TTable> {
  const NoopDataPermissionPlugin();

  @override
  Expression? buildFilter(Session session, TTable table) => null;
  
  @override
  Map<String, dynamic> toJson() => {};
}
