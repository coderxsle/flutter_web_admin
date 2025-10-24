import 'package:flutter_web_shared/shared.dart';
import 'package:serverpod_serialization/serverpod_serialization.dart';
import 'common_response.dart';
import 'result_code.dart';

/// 分页返回结果
class PageResponse<T> extends CommonResponse implements SerializableModel {

  final int pageNum;
  final int pageSize;
  final int totalPage;
  final int total;

  PageResponse({
    super.code = 20000,
    super.message = '',
    required this.pageNum,
    required this.pageSize,
    required this.totalPage,
    required this.total,
    super.data,
  });

  factory PageResponse.success(List<T> data, {
    required int pageNum,
    required int pageSize,
    required int total,
    String? message,
  }) {
    return PageResponse.restPage(
      data: data,
      pageNum: pageNum,
      pageSize: pageSize,
      total: total,
    );
  }

  factory PageResponse.error([String? message]) {
    return PageResponse(
      code: 40000,
      message: message ?? '',
      pageNum: 1,
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
    required int pageNum,
    required int pageSize,
    required int total,
  }) {
    return PageResponse(
      code: code ?? ResultCode.success.code,
      message: message ?? '',
      data: data,
      pageNum: pageNum,
      pageSize: pageSize,
      total: total,
      totalPage: (total / pageSize).ceil(), // 计算总页数
    );
  }
  
  @override
  factory PageResponse.fromJson(Map<String, dynamic> json) {
    return PageResponse(
      code: json['code'] as int? ?? ResultCode.success.code,
      message: json['message'] as String? ?? '',
      pageNum: json['pageNum'] as int? ?? 1,
      pageSize: json['pageSize'] as int? ?? 10,
      total: json['total'] as int? ?? 0,
      totalPage: json['totalPage'] as int? ?? 0,
      data: json['data'] ?? [],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = {'code': code, 'message': message};
    if (data != null) {
      if (data is SerializableModel) {
        json['data'] = (data as SerializableModel).toJson();
      } else if (data is List) {
        json['data'] = data.map((e) => e is SerializableModel ? e.toJson() : e).toList();
      } else if (data is Map) {
        json['data'] = Map.fromEntries(
          data.entries.map(
            (e) => MapEntry(
              e.key,
              e.value is SerializableModel ? (e.value as SerializableModel).toJson() : e.value,
            ),
          ),
        );
      } else {
        json['data'] = data;
      }
    }
    return json;
  }

}
