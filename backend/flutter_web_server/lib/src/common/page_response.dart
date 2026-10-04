import '../utils/json_cleaner.dart';
import 'common_response.dart';
import 'result_code.dart';

/// 分页返回结果。
class PageResponse<T> extends CommonResponse {

  final int page;
  final int pageSize;
  final int totalPage;
  final int total;

  PageResponse({
    super.code = 20000,
    super.message = '',
    required this.page,
    required this.pageSize,
    required this.totalPage,
    required this.total,
    super.data,
  });

  factory PageResponse.success(List<T> data, {required int page, required int pageSize, required int total, String? message}) {
    return PageResponse.restPage(data: data, page: page, pageSize: pageSize, total: total);
  }

  factory PageResponse.failed([String? message]) {
    return PageResponse(
      code: 40000,
      message: message ?? '',
      page: 1,
      pageSize: 10,
      totalPage: 0,
      total: 0,
      data: [],
    );
  }

  factory PageResponse.restPage({
    int? code,
    String? message,
    required List data,  
    required int page,
    required int pageSize,
    required int total,
  }) {
    return PageResponse(
      code: code ?? ResultCode.success.code,
      message: message ?? '',
      data: data,
      page: page,
      pageSize: pageSize,
      total: total,
      totalPage: (total / pageSize).ceil(), // 计算总页数
    );
  }
  
  factory PageResponse.fromJson(Map<String, dynamic> json) {
    // data 是对象 → 新形状（元信息与 records 都在里面）；是数组 → 旧的摊平形状。
    final rawData = json['data'];
    final meta = rawData is Map ? rawData : json;
    return PageResponse(
      code: json['code'] as int? ?? ResultCode.success.code,
      message: json['message'] as String? ?? '',
      page: meta['page'] as int? ?? 1,
      pageSize: meta['pageSize'] as int? ?? 10,
      total: meta['total'] as int? ?? 0,
      totalPage: meta['totalPage'] as int? ?? 0,
      data: rawData is Map ? rawData['records'] ?? [] : rawData ?? [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': {
        'records': JsonCleaner.clean(data),
        'total': total,
        'page': page,
        'pageSize': pageSize,
        'totalPage': totalPage,
      },
    };
  }
}
