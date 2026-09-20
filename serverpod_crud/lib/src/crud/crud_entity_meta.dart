import 'package:serverpod/serverpod.dart';

import '../runtime/crud_runtime.dart';
import 'base_service.dart';

/// 模型解码器：将 Endpoint 入参动态对象转为实体模型。
typedef ModelDecoder<T extends TableRow> = T Function(dynamic data);

/// 实体 CRUD 元信息。
///
/// 聚合一个实体运行 CRUD 所需的最小配置：
/// - descriptor：数据库访问与字段映射配置
/// - decodeModel：请求体解码
/// - runtime：查询插件运行时（可按实体覆盖）
/// - entityName：实体标识（可用于权限/日志）
class CrudEntityMeta<T extends TableRow, TTable extends Table>
    implements SerializableModel {
  const CrudEntityMeta({
    required this.descriptor,
    required this.decodeModel,
    this.runtime,
    this.entityName = '',
  });

  /// 自动创建 Serverpod 实体元数据。
  ///
  /// 业务 Endpoint 不再需要为每张表编写 `ProductCrudMeta`。表、主键、
  /// 租户列、软删除列、字段映射和数据库操作均从生成的 Serverpod 协议
  /// 自动取得；模型解码也通过协议的 `deserialize` 完成。
  factory CrudEntityMeta.auto({
    String tenantIdField = 'tenantId',
    String? deletedField,
    List<String>? keywordFields,
    Map<String, String> fieldAliases = const {},
    CrudRuntime? runtime,
    String entityName = '',
    void Function(T model, int tenantId)? setTenantId,
    void Function(T model, bool deleted)? setDeleted,
    int? Function(T model)? getId,
  }) {
    final descriptor = EntityDescriptor<T, TTable>.fromServerpod(
      tenantIdField: tenantIdField,
      deletedField: deletedField,
      keywordFields: keywordFields,
      fieldAliases: {
        'createdAt': 'createTime',
        'updatedAt': 'updateTime',
        ...fieldAliases,
      },
      setTenantId: setTenantId,
      setDeleted: setDeleted,
      getId: getId,
    );
    return CrudEntityMeta<T, TTable>(
      descriptor: descriptor,
      decodeModel: (data) {
        if (data is T) return data;
        return Serverpod.instance.serializationManager.deserialize<T>(data, T);
      },
      runtime: runtime,
      entityName: entityName,
    );
  }

  final EntityDescriptor<T, TTable> descriptor;
  final ModelDecoder<T> decodeModel;
  final CrudRuntime? runtime;
  final String entityName;

  @override
  Map<String, dynamic> toJson() {
    return {
      'descriptor': descriptor.toJson(),
      'entityName': entityName,
      'runtime': runtime,
    };
  }
}
