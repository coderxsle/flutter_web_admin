import 'package:flutter_web_server/src/common/common.dart';

extension CrudPaginationExtension on Pagination {
  /// 计算偏移量：用于数据库分页查询
  ///
  /// 公式：offset = (page - 1) × pageSize
  int get offset => (page - 1) * pageSize;
}
