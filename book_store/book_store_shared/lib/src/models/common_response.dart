import 'package:book_store_shared/src/models/result_code.dart';
import 'package:serverpod_serialization/serverpod_serialization.dart';

class CommonResponse implements SerializableModel {
  /// 状态码
  final int code;
  /// 提示信息
  final String message;
  /// 数据封装
  final dynamic data;


  // 暂时不知道是否有用，先注释掉
  // @override
  // String get className => 'CommonResponse';

  CommonResponse({
    required this.code,
    required this.message,
    this.data,
  });

  /// 成功返回结果
  static CommonResponse success(dynamic data, [String? message]) {
    return CommonResponse(
      code: ResultCode.success.code, 
      message: message ?? ResultCode.success.message,
      data: data
    );
  }

  /// 失败返回结果
  static CommonResponse failed([String? message]) {
    return CommonResponse(
      code: ResultCode.failed.code,
      message: message ?? ResultCode.failed.message,
    );
  }

  /// 参数验证失败返回结果
  static CommonResponse validateFailed([String? message]) {
    return CommonResponse(
      code: ResultCode.validateFailed.code,
      message: message ?? ResultCode.validateFailed.message,
    );
  }

  /// 未登录返回结果
  static CommonResponse unauthorized([dynamic data]) {
    return CommonResponse(
      code: ResultCode.unauthorized.code,
      message: ResultCode.unauthorized.message,
      data: data,
    );
  }

  /// 登录态被挤下线
  static CommonResponse authReplaced([dynamic data]) {
    return CommonResponse(
      code: ResultCode.authReplaced.code,
      message: ResultCode.authReplaced.message,
      data: data,
    );
  }

  /// 未授权返回结果
  static CommonResponse forbidden([dynamic data]) {
    return CommonResponse(
      code: ResultCode.forbidden.code,
      message: ResultCode.forbidden.message,
      data: data,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
      'data': data,
    };
  }

  // @override
  // Map<String, dynamic> toJson() {
  //   final json = {'code': code, 'message': message};
  //   if (data != null) {
  //     if (data is SerializableModel) {
  //       json['data'] = (data as SerializableModel).toJson();
  //     } else if (data is List) {
  //       json['data'] = (data as List).map((e) => e is SerializableModel ? e.toJson() : e as Object).toList();
  //     } else {
  //       json['data'] = data as Object;
  //     }
  //   }
  //   return json;
  // }

  @override
  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    return CommonResponse(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'],
    );
  }
}