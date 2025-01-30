import 'package:serverpod_client/serverpod_client.dart';
import 'base_response.dart';
import 'data_response.dart';

/// 分页返回结果
class PageResponse<T> extends DataResponse<PageData<T>> {
  PageResponse({
    super.code = BaseResponse.successCode,
    super.message,
    super.data,
  });

  factory PageResponse.success(List<T> data, {
    required int pageNum,
    required int pageSize,
    required int total,
    String? message,
  }) {
    final page = PageData<T>.restPage(
      data: data,
      pageNum: pageNum,
      pageSize: pageSize,
      total: total,
    );
    
    return PageResponse(
      code: BaseResponse.successCode,
      message: message,
      data: page,
    );
  }

  factory PageResponse.error([String? message]) {
    return PageResponse(
      code: BaseResponse.errorCode,
      message: message,
      data: PageData<T>(
        pageNum: 1,
        pageSize: 10,
        totalPage: 0,
        total: 0,
        data: [],
      ),
    );
  }

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



class PageData<T> implements SerializableModel {
  final List<T> data;
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
    required List<T> data,
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