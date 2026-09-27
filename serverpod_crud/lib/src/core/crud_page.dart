import 'package:serverpod_serialization/serverpod_serialization.dart';

/// 通用分页结果模型。
///
/// 使用场景：
/// - Service 层返回“列表数据 + 分页元信息”时统一使用；
/// - HTTP 层需要把分页结果转换为标准响应结构时作为中间对象。
///
/// 作用：
/// - 封装当前页数据 `data`；
/// - 提供分页元信息（页码、页大小、总条数、总页数）；
/// - 通过 `CrudPage.from(...)` 自动计算 `totalPage`，统一分页口径。
class CrudPage<T> implements SerializableModel {
  final List<T> data;
  final int page;
  final int pageSize;
  final int total;
  final int totalPage;

  const CrudPage({required this.data, required this.page, required this.pageSize, required this.total, required this.totalPage});

  factory CrudPage.from({
    required List<T> data,
    required int pageNum,
    required int pageSize,
    required int total,
  }) {
    return CrudPage<T>(
      data: data,
      page: pageNum,
      pageSize: pageSize,
      total: total,
      totalPage: pageSize <= 0 ? 0 : (total / pageSize).ceil(),
    );
  }

  factory CrudPage.fromJson(Map<String, dynamic> json) {
    return CrudPage<T>(
      data: (json['data'] as List? ?? const []).cast<T>(),
      page: json['pageNum'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 20,
      total: json['total'] as int? ?? 0,
      totalPage: json['totalPage'] as int? ?? 0,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'data': data,
      'page': page,
      'pageSize': pageSize,
      'total': total,
      'totalPage': totalPage,
    };
  }
}
