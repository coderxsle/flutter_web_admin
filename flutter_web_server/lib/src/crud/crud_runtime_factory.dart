import 'package:serverpod_crud/serverpod_crud.dart';

import 'plugins/contains_operator_plugin.dart';
import 'plugins/noop_data_permission_plugin.dart';
import 'plugins/query_audit_log_plugin.dart';
import 'plugins/query_page_validation_plugin.dart';

/// CRUD 运行时工厂：集中装配查询相关插件。
///
/// 你可以在这里统一开关/替换：
/// - 参数校验插件
/// - 审计插件
/// - 自定义操作符插件
/// - 数据权限插件
class CrudRuntimeFactory {
  static CrudRuntime create() {
    return CrudRuntime(
      plugins: CrudPluginRegistry(
        validations: const [QueryPageValidationPlugin()],
        audits: const [QueryAuditLogPlugin()],
        operators: const [ContainsOperatorPlugin()],
        dataPermissions: const [NoopDataPermissionPlugin()],
      ),
    );
  }
}
