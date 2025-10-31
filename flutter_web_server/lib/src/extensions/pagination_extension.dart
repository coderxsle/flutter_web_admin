/// Pagination 扩展 - 添加计算属性
/// 此文件与 pagination.dart 配套使用
library;

import 'package:flutter_web_server/src/generated/common/pagination.dart';

extension PaginationExtension on Pagination {
  /// 计算偏移量：用于数据库分页查询
  /// 
  /// 公式：offset = (page - 1) × pageSize
  /// 
  /// 例如：
  /// - 第1页，每页20条：offset = 0（从第1条开始）
  /// - 第2页，每页20条：offset = 20（从第21条开始）
  /// - 第3页，每页20条：offset = 40（从第41条开始）
  int get offset => (page - 1) * pageSize;
}

