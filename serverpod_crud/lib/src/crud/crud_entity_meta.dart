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
class CrudEntityMeta<T extends TableRow, TTable extends Table> implements SerializableModel{
  const CrudEntityMeta({required this.descriptor, required this.decodeModel, this.runtime, this.entityName = ''});

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
