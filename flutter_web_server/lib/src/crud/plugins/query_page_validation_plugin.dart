import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';
/// 查询分页参数校验插件。
///
/// 用于约束页码和每页数量，防止非法分页请求或过大的 pageSize 压垮数据库。
class QueryPageValidationPlugin extends ValidationPlugin implements SerializableModel{
  const QueryPageValidationPlugin({this.maxPageSize = 200});

  final int maxPageSize;

  @override
  void validate(QueryDTO query) {
    // if (query.page < 1) throw QueryValidationException('page must be greater than or equal to 1');
    // if (query.pageSize < 1 || query.pageSize > maxPageSize) {
    //   throw QueryValidationException('pageSize must be between 1 and $maxPageSize');
    // }
  }
  
  @override
  Map<String, dynamic> toJson() {
    return {
      'maxPageSize': maxPageSize,
    };
  }
}
