import 'package:serverpod/serverpod.dart';

/// 字段别名插件：把外部字段名映射为真实数据库字段名。
abstract class FieldAliasPlugin implements SerializableModel {
  const FieldAliasPlugin();

  String resolveField(String rawField, Map<String, String> aliases) => aliases[rawField] ?? rawField;
}
