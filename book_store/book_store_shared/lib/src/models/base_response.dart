import 'package:serverpod_client/serverpod_client.dart';

class BaseResponse implements SerializableModel {
  static const int successCode = 20000;
  static const int errorCode = 40000;

  bool get isSuccess => code == successCode;

  final int code;
  final String? message;

  BaseResponse({
    this.code = successCode,
    this.message,
  });

  factory BaseResponse.success([String? message]) {
    return BaseResponse(code: successCode, message: message);
  }

  factory BaseResponse.error([String? message]) {
    return BaseResponse(code: errorCode, message: message);
  }


  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
      code: json['code'],
      message: json['message'],
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