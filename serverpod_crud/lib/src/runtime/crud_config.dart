/// 框架级全局配置。
///
/// 只放真正全局的东西 资源级配置走 `CrudOptions`。
class CrudConfig {
  CrudConfig._();

  /// 每页最大条数：客户端传超了夹到这个值，不报错。改这一处，全项目生效。
  static int maxPageSize = 2000;
}
