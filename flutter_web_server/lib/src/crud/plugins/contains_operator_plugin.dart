import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';
/// 自定义 contains 操作符插件。
///
/// 在 QueryEngine 中可使用 comparator=contains，
/// 对字符串字段生成 `ILIKE %value%` 表达式。
class ContainsOperatorPlugin extends OperatorPlugin implements SerializableModel {
  const ContainsOperatorPlugin();

  @override
  String get name => 'contains';

  @override
  Expression? build(Column column, dynamic value) {
    if (column is ColumnString && value is String) return column.ilike('%$value%');
    return null;
  }
  
  @override
  Map<String, dynamic> toJson() => {'name': name};

}
