import 'package:serverpod_serialization/serverpod_serialization.dart';

/// 创建 DTO 基类
///
/// 仅作为类型约束使用，具体字段由各业务 DTO 定义。
abstract class CreateDTO implements SerializableModel {
  const CreateDTO();
}

/// 更新 DTO 基类
///
/// 默认包含 id 字段，业务 DTO 可扩展更多字段。
abstract class UpdateDTO implements SerializableModel {
  final int? id;

  const UpdateDTO({this.id});
}

/// 响应 DTO 基类
///
/// 仅作为类型约束使用，具体字段由各业务 DTO 定义。
abstract class ResponseDTO implements SerializableModel {
  const ResponseDTO();
}
