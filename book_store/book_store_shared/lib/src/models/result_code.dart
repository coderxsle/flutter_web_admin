/// 错误码接口
abstract class IErrorCode {
  int get code;
  String get message;
}

/// 响应码枚举
enum ResultCode implements IErrorCode {
  success(20000, 'succeed'),
  failed(500, 'operation.failed'),
  validateFailed(404, 'the.submitted.parameter.is.invalid'),
  unauthorized(401, 'the.token.has.expired'),
  authReplaced(408, 'the.token.has.replaced'),
  forbidden(403, 'no.relevant.permission');

  @override
  final int code;
  @override
  final String message;

  const ResultCode(this.code, this.message);
} 