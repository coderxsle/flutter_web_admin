import 'package:serverpod/serverpod.dart';

/// 操作符插件：扩展 QueryEngine 的 compareOperator。
///
/// 例如可注册 contains、jsonContains 等自定义运算。
abstract class OperatorPlugin implements SerializableModel {
  const OperatorPlugin();

  String get name;

  Expression? build(Column column, dynamic value);
}
