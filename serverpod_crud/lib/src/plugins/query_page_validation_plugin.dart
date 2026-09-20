import '../models/query/query_dto.dart';
import '../query/query_engine.dart';
import 'validation_plugin.dart';

/// Validates pagination parameters for list queries.
class QueryPageValidationPlugin extends ValidationPlugin {
  const QueryPageValidationPlugin({this.maxPageSize = 200});

  final int maxPageSize;

  @override
  void validate(QueryDTO query) {
    if (query.page < 1) {
      throw QueryValidationException('page must be greater than or equal to 1');
    }
    if (query.pageSize < 1 || query.pageSize > maxPageSize) {
      throw QueryValidationException(
        'pageSize must be between 1 and $maxPageSize',
      );
    }
  }

  @override
  Map<String, dynamic> toJson() => {'maxPageSize': maxPageSize};
}
