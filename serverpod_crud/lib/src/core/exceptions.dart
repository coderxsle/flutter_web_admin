/// CRUD 层统一异常基类，所有自定义异常均应继承自该类。
///
/// 用于在应用中抛出与 CRUD 相关的标准化异常，避免直接使用系统异常，
/// 并支持统一的错误码（code）和错误信息（message）
///
/// [code] - 错误类型标识字符串，便于前后端/日志/监控等识别异常类别。
/// [message] - 异常具体提示语，供开发与用户参考。
/// 
/// 
/// 
class CrudException implements Exception {
  /// 构造函数，建议传入自定义 message 支持追踪。
  /// [message] - 异常描述信息
  /// [code] - 异常类型标识（默认 "CRUD_ERROR"）
  const CrudException(this.message, {this.code = 'CRUD_ERROR'});

  /// 异常类型标识
  final String code;

  /// 异常提示信息
  final String message;

  @override
  String toString() => '[$code] $message';
}

/// 数据校验失败异常
///
/// 用于参数校验、业务规则校验失败场景，例如请求参数不合法。
/// 默认 code 为 "VALIDATION_ERROR"。
class ValidationException extends CrudException {
  /// [message] - 失败原因提示语
  /// [code] - 可自定义错误类型标识
  const ValidationException(super.message, {super.code = 'VALIDATION_ERROR'});
}

/// 资源未找到异常
///
/// 用于当查询的数据不存在时抛出，避免返回 null 。
/// 默认 code 为 "NOT_FOUND"。
class NotFoundException extends CrudException {
  /// [message] - 描述哪些内容未找到
  /// [code] - 可自定义错误类型标识
  const NotFoundException(super.message, {super.code = 'NOT_FOUND'});
}

/// 未授权异常
///
/// 用于未通过身份认证（未登录等），禁止访问受限资源。
/// 默认 code 为 "UNAUTHORIZED"。
class UnauthorizedException extends CrudException {
  /// [message] - 未授权原因
  /// [code] - 可自定义错误类型标识
  const UnauthorizedException(super.message, {super.code = 'UNAUTHORIZED'});
}

/// 无权限异常
///
/// 用于通过认证但权限不足的场景（如非管理员操作）。
/// 默认 code 为 "FORBIDDEN"。
class ForbiddenException extends CrudException {
  /// [message] - 禁止访问原因
  /// [code] - 可自定义错误类型标识
  const ForbiddenException(super.message, {super.code = 'FORBIDDEN'});
}
