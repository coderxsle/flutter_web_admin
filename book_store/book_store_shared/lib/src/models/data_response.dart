import 'base_response.dart';

class DataResponse<T> extends BaseResponse {
  final T? data;

  DataResponse({
    super.code = BaseResponse.successCode,
    super.message,
    this.data,
  });

  factory DataResponse.success(T data, [String? message]) {
    return DataResponse(
      code: BaseResponse.successCode,
      message: message,
      data: data,
    );
  }

  factory DataResponse.error([String? message]) {
    return DataResponse(
      code: BaseResponse.errorCode,
      message: message,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    if (data != null) {
      if (data is Map) {
        json['data'] = data;
      } else if (data is List) {
        json['data'] = data;
      } else if (data is String || data is num || data is bool) {
        json['data'] = data;
      } else {
        json['data'] = (data as dynamic).toJson();
      }
    }
    return json;
  }
} 