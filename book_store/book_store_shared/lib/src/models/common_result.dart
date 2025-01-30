import 'package:serverpod_client/serverpod_client.dart';
import 'result_code.dart';


/// 通用返回结果
class CommonResult<T> implements SerializableModel {
  /// 状态码
  final int code;
  
  /// 提示信息
  final String message;
  
  /// 数据封装
  final T? data;

  /// 是否失败
  bool get isFailed => code != ResultCode.success.code;

  /// 是否成功
  bool get isSuccess => code == ResultCode.success.code;

  CommonResult({
    required this.code,
    required this.message,
    this.data,
  });


  /// 成功返回结果
  static CommonResult<T> success<T>(T data, [String? message]) {
    return CommonResult<T>(
      code: ResultCode.success.code,
      message: message ?? ResultCode.success.message,
      data: data,
    );
  }

  /// 失败返回结果
  static CommonResult<T> failed<T>([String? message]) {
    return CommonResult<T>(
      code: ResultCode.failed.code,
      message: message ?? ResultCode.failed.message,
    );
  }

  /// 参数验证失败返回结果
  static CommonResult<T> validateFailed<T>([String? message]) {
    return CommonResult<T>(
      code: ResultCode.validateFailed.code,
      message: message ?? ResultCode.validateFailed.message,
    );
  }

  /// 未登录返回结果
  static CommonResult<T> unauthorized<T>([T? data]) {
    return CommonResult<T>(
      code: ResultCode.unauthorized.code,
      message: ResultCode.unauthorized.message,
      data: data,
    );
  }

  /// 登录态被挤下线
  static CommonResult<T> authReplaced<T>([T? data]) {
    return CommonResult<T>(
      code: ResultCode.authReplaced.code,
      message: ResultCode.authReplaced.message,
      data: data,
    );
  }

  /// 未授权返回结果
  static CommonResult<T> forbidden<T>([T? data]) {
    return CommonResult<T>(
      code: ResultCode.forbidden.code,
      message: ResultCode.forbidden.message,
      data: data,
    );
  }

  /// 从JSON反序列化
  factory CommonResult.fromJson(Map<String, dynamic> json, {Function? fromJsonT}) {
    var data = json['data'];
    T? typedData;
    
    if (data != null && fromJsonT != null) {
      if (data is List) {
        typedData = data.map((e) => fromJsonT(e)).toList() as T;
      } else {
        typedData = fromJsonT(data) as T;
      }
    }
    
    return CommonResult<T>(
      code: json['code'] as int,
      message: json['message'] as String,
      data: typedData,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = {'code': code, 'message': message};
    if (data != null) {
      if (data is SerializableModel) {
        json['data'] = (data as SerializableModel).toJson();
      } else if (data is List) {
        json['data'] = (data as List).map((e) => e is SerializableModel ? e.toJson() : e as Object).toList();
      } else {
        json['data'] = data as Object;
      }
    }
    return json;
  }

} 