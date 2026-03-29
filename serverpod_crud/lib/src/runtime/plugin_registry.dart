import 'package:serverpod/serverpod.dart';

import '../plugins/audit_plugin.dart';
import '../plugins/data_permission_plugin.dart';
import '../plugins/field_alias_plugin.dart';
import '../plugins/operator_plugin.dart';
import '../plugins/query_mapper_plugin.dart';
import '../plugins/validation_plugin.dart';

/// CRUD 插件注册表。
///
/// 统一管理查询映射、字段别名、参数校验、审计、操作符、数据权限插件。
class CrudPluginRegistry implements SerializableModel{
  CrudPluginRegistry({
    this.queryMapper,
    FieldAliasPlugin? fieldAlias,
    List<ValidationPlugin>? validations,
    List<AuditPlugin>? audits,
    List<OperatorPlugin>? operators,
    List<DataPermissionPlugin<dynamic>>? dataPermissions,
  }) : fieldAlias = fieldAlias ?? const DefaultFieldAliasPlugin(),
       validations = List.unmodifiable(validations ?? const []),
       audits = List.unmodifiable(audits ?? const []),
       operators = List.unmodifiable(operators ?? const []),
       dataPermissions = List.unmodifiable(dataPermissions ?? const []);

  final QueryMapperPlugin? queryMapper;
  final FieldAliasPlugin fieldAlias;
  final List<ValidationPlugin> validations;
  final List<AuditPlugin> audits;
  final List<OperatorPlugin> operators;
  final List<DataPermissionPlugin<dynamic>> dataPermissions;

  CrudPluginRegistry copyWith({
    QueryMapperPlugin? queryMapper,
    FieldAliasPlugin? fieldAlias,
    List<ValidationPlugin>? validations,
    List<AuditPlugin>? audits,
    List<OperatorPlugin>? operators,
    List<DataPermissionPlugin<dynamic>>? dataPermissions,
  }) {
    return CrudPluginRegistry(
      queryMapper: queryMapper ?? this.queryMapper,
      fieldAlias: fieldAlias ?? this.fieldAlias,
      validations: validations ?? this.validations,
      audits: audits ?? this.audits,
      operators: operators ?? this.operators,
      dataPermissions: dataPermissions ?? this.dataPermissions,
    );
  }
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'queryMapper': queryMapper?.toJson(),
      'fieldAlias': fieldAlias.toJson(),
      'validations': validations.map((v) => v.toJson()).toList(),
      'audits': audits.map((a) => a.toJson()).toList(),
      'operators': operators.map((o) => o.toJson()).toList(),
      'dataPermissions': dataPermissions.map((d) => d.toJson()).toList(),
    };
  }
}

class DefaultFieldAliasPlugin extends FieldAliasPlugin implements SerializableModel {
  const DefaultFieldAliasPlugin();
  
  @override
  Map<String, dynamic> toJson() {
    return {};
  }
  
}
