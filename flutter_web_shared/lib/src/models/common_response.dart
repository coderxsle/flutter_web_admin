import 'package:flutter_web_shared/shared.dart';
import 'package:serverpod_serialization/serverpod_serialization.dart';

class CommonResponse extends BaseResponse implements SerializableModel {
  /// 数据封装
  final dynamic data;

    /// 是否失败
  bool get isFailed => code != ResultCode.success.code;
  /// 是否成功
  bool get isSuccess => code == ResultCode.success.code;

  /// 用于协议层，直接返回 'CommonResponse'
  String get className => 'CommonResponse';
  /// 用于协议层，直接返回 toJson()
  Map<String, dynamic> toJsonForProtocol() => toJson();

  CommonResponse({required super.code, required super.message, this.data});

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
      dynamic jsonData;
      if (data is SerializableModel) {
        jsonData = (data as SerializableModel).toJson();
      } else if (data is List) {
        jsonData = data.map((e) => e is SerializableModel ? e.toJson() : e).toList();
      } else if (data is Map) {
        // 兼容 dynamic Map：
        // 1) 先显式转为 Map，避免 data.entries 在 dynamic 场景下的类型报错；
        // 2) JSON 对象 key 需为字符串，这里统一使用 key.toString()；
        // 3) value 若为 SerializableModel 则递归 toJson()，其余值原样保留。
        // coderxslee by 2026年2月26日22:19:51
        final mapData = Map<dynamic, dynamic>.from(data as Map);
        jsonData = mapData.map(
          (key, value) => MapEntry(
            key.toString(),
            value is SerializableModel ? value.toJson() : value,
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
      // json['data'] = jsonData;
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
