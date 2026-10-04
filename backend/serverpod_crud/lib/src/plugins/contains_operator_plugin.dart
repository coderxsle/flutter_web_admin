import 'package:serverpod/serverpod.dart';

import 'operator_plugin.dart';

/// Adds a case-insensitive substring operator for string columns.
class ContainsOperatorPlugin extends OperatorPlugin {
  const ContainsOperatorPlugin();

  @override
  String get name => 'contains';

  @override
  Expression? build(Column column, dynamic value) {
    if (column is ColumnString && value is String) {
      return column.ilike('%$value%');
    }
    return null;
  }

  @override
  Map<String, dynamic> toJson() => {'name': name};
}
