import 'package:serverpod_serialization/serverpod_serialization.dart';

/// 通用分页参数模型。
///
/// 使用场景：
/// - 列表接口接收前端分页参数时作为入参模型；
/// - 需要把 page/pageSize 统一转换为数据库 offset/limit 时复用。
///
/// 作用：
/// - 约定统一分页字段（`page`、`pageSize`）；
/// - 提供 `offset` 计算，避免各处重复写 `(page - 1) * pageSize`。
class CrudPagination implements SerializableModel {
  final int page;
  final int pageSize;

  const CrudPagination({this.page = 1, this.pageSize = 20});

  int get offset => (page - 1) * pageSize;

  @override
  factory CrudPagination.fromJson(Map<String, dynamic> json) {
    return CrudPagination(page: json['page'] as int? ?? 1, pageSize: json['pageSize'] as int? ?? 20);
  }

  @override
  Map<String, dynamic> toJson() {
    return {'page': page, 'pageSize': pageSize};
  }
}



/// 通用分页结果模型。
///
/// 使用场景：
/// - Service 层返回“列表数据 + 分页元信息”时统一使用；
/// - Endpoint 层需要把分页结果转换为标准响应结构时作为中间对象。
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

  factory CrudPage.from({required List<T> data, required int pageNum, required int pageSize, required int total}) {
    return CrudPage<T>(data: data, page: pageNum, pageSize: pageSize, total: total, totalPage: pageSize <= 0 ? 0 : (total / pageSize).ceil());
  }

  @override
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
    return {'data': data, 'page': page, 'pageSize': pageSize, 'total': total, 'totalPage': totalPage};
  }
}




/// 批量操作结果模型（当前主要用于批量删除）。
///
/// 使用场景：
/// - 批量删除/批量处理后，需要向前端返回处理统计信息；
/// - 业务侧希望明确区分“请求总量、成功量、未命中量”，并拿到成功/失败明细ID。
///
/// 作用：
/// - `total`：本次参与处理的有效记录总数；
/// - `successCount`：实际成功处理的数量；
/// - `notFoundCount`：未找到或未处理成功的数量；
/// - `successIds`：本次处理成功的主键ID列表；
/// - `failedIds`：本次处理失败（通常是未找到）的主键ID列表。
class CrudBatchResult implements SerializableModel {
  final int total;
  final int successCount;
  final int notFoundCount;
  final List<int> successIds;
  final List<int> failedIds;

  const CrudBatchResult({required this.total, required this.successCount, required this.notFoundCount, this.successIds = const [], this.failedIds = const []});

  @override
  factory CrudBatchResult.fromJson(Map<String, dynamic> json) {
    return CrudBatchResult(
      total: json['total'] as int? ?? 0,
      successCount: json['successCount'] as int? ?? 0,
      notFoundCount: json['notFoundCount'] as int? ?? 0,
      successIds: (json['successIds'] as List? ?? const []).whereType<int>().toList(),
      failedIds: (json['failedIds'] as List? ?? const []).whereType<int>().toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'total': total, 'successCount': successCount, 'notFoundCount': notFoundCount, 'successIds': successIds, 'failedIds': failedIds};
  }


}
