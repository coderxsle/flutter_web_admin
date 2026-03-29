import 'package:serverpod_serialization/serverpod_serialization.dart';
import 'result_code.dart';

class BaseResponse implements SerializableModel {
  final int code;
  final String? message;

  BaseResponse({this.code = 20000, this.message});

  factory BaseResponse.success([String? message]) {
    return BaseResponse(code: ResultCode.success.code, message: message);
  }

  factory BaseResponse.error([String? message]) {
    return BaseResponse(code: ResultCode.failed.code, message: message);
  }

  @override
  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      code: json['code'] as int,
      message: json['message'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'message': message,
    };
  }
  
} 
