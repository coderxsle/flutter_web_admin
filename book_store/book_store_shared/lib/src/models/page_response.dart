import 'package:serverpod_serialization/serverpod_serialization.dart';
import 'base_response.dart';
import 'common_response.dart';

/// 分页返回结果
class PageResponse extends CommonResponse {
  PageResponse({
    super.code = 20000,
    super.message = '',
    super.data,
  });

  factory PageResponse.success(List data, {
    required int pageNum,
    required int pageSize,
    required int total,
    String? message,
  }) {
    final page = PageData.restPage(
      data: data,
      pageNum: pageNum,
      pageSize: pageSize,
      total: total,
    );
    
    return PageResponse(
      code: 20000,
      message: message ?? '',
      data: page,
    );
  }

  factory PageResponse.error([String? message]) {
    return PageResponse(
      code: 40000,
      message: message ?? '',
      data: PageData(
        pageNum: 1,
        pageSize: 10,
        totalPage: 0,
        total: 0,
        data: [],
      ),
    );
  }

  @override
  factory PageResponse.fromJson(Map<String, dynamic> json) {
    return PageResponse(
      code: json['code'],
      message: json['message'],
      data: PageData.fromJson(json['data']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data?.toJson(),
    };
  }


}



class PageData implements SerializableModel {
  final List data;
  final int pageNum;
  final int pageSize;
  final int totalPage;
  final int total;

  PageData({
    required this.data,
    required this.pageNum,
    required this.pageSize,
    required this.totalPage,
    required this.total,
  });

  factory PageData.restPage({
    required List data,
    required int pageNum,
    required int pageSize,
    required int total,
  }) {
    // 计算总页数
    final totalPage = (total / pageSize).ceil();
    return PageData(
      data: data,
      pageNum: pageNum,
      pageSize: pageSize,
      totalPage: totalPage,
      total: total,
    );
  }


  @override
  factory PageData.fromJson(Map<String, dynamic> json) {
    return PageData(
      data: json['data'],
      pageNum: json['pageNum'],
      pageSize: json['pageSize'],
      totalPage: json['totalPage'],
      total: json['total'],
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'list': data is List<SerializableModel>
          ? (data as List<SerializableModel>).map((e) => e.toJson()).toList()
          : data,
      'pageNum': pageNum,
      'pageSize': pageSize,
      'totalPage': totalPage,
      'total': total,
    };
  }
}