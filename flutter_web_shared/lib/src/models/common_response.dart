import 'package:flutter_web_admin_shared/flutter_web_admin_shared.dart';
import 'package:serverpod_serialization/serverpod_serialization.dart';

class CommonResponse extends BaseResponse implements SerializableModel {
  /// 数据封装
  final dynamic data;

    /// 是否失败
  bool get isFailed => code != ResultCode.success.code;
  /// 是否成功
  bool get isSuccess => code == ResultCode.success.code;


  // 暂时不知道是否有用，先注释掉
  // @override
  // String get className => 'CommonResponse';

  CommonResponse({
    required super.code,
    required super.message,
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

  @override
  factory CommonResponse.fromJson(Map<String, dynamic> json) {
    dynamic deserializeData(dynamic value) {
      if (value == null) return null;
      if (value is List) {
        return value.map((e) => deserializeData(e)).toList();
      }
      if (value is Map<String, dynamic>) {
        return Map.fromEntries(
          value.entries.map((e) => MapEntry(e.key, deserializeData(e.value))),
        );
      }
      return value;
    }

    return CommonResponse(
      code: json['code'] as int,
      message: json['message'] as String,
      data: deserializeData(json['data']),
    );
  }
}