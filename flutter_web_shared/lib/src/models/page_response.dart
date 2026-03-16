import 'package:flutter_web_shared/shared.dart';
import 'package:serverpod_serialization/serverpod_serialization.dart';

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

  factory PageResponse.failed([String? message]) {
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
    final json = {
      'code': code,
      'message': message,
      'pageNum': pageNum,
      'pageSize': pageSize,
      'totalPage': totalPage,
      'total': total,
    };
    if (data != null) {
      dynamic jsonData;
      if (data is SerializableModel) {
        jsonData = (data as SerializableModel).toJson();
      } else if (data is List) {
        jsonData = data.map((e) => e is SerializableModel ? e.toJson() : e).toList();
      } else if (data is Map) {
        jsonData = Map.fromEntries(
          data.entries.map(
            (e) => MapEntry(
              e.key,
              e.value is SerializableModel ? (e.value as SerializableModel).toJson() : e.value,
            ),
          ),
        );
      } else {
        jsonData = data;
      }
     /* 
      清理 __className__、password 字段，使接口更适合非 Flutter 客户端（如 Vue）使用
      http://localhost:8080/tables 这个接口返回的数据：
      {
        "code": 20000,
        "message": "succeed",
        "data": {
          "__className__": "AirTableDetail",
          "id": 1,
          "name": "persion",
          "fields": [{
            "__className__": "AirTableFieldsSummary",
            "id": 1,
            "field": "name"
          }]
        }
       }

      */
      json['data'] = JsonCleaner.clean(jsonData);
    }
    return json;
  }

}
