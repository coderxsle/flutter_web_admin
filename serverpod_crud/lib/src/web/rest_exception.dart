/// REST 表现层的业务异常：把「哪一类失败」带给 HTTP 层。
///
/// 与「Service 返回失败码」的区别在于**粒度** —— Service 层通常只有
/// 「成功 / 失败」两个粒度，而 HTTP 需要区分 400 / 401 / 404。
///
/// [code] 取值 400/401/403/404/500 时表示「框架兜底」，需由业务项目的
/// 信封构造器翻译成自己的业务码；其它值原样透传。
class RestException implements Exception {
  const RestException(this.httpStatus, this.message, {this.code});

  /// 400 参数不合法。兜底业务码 `400`（语义：入参不合法）。
  const RestException.badRequest(String message, {int code = 400}) : this(400, message, code: code);

  /// 401 未登录 / token 失效。兜底业务码 `401`。
  const RestException.unauthorized([String message = '未登录或 token 已失效']) : this(401, message, code: 401);

  /// 403 无权限。兜底业务码 `403`。
  const RestException.forbidden(String message) : this(403, message, code: 403);

  /// 404 资源不存在。兜底业务码 `404`。
  const RestException.notFound(String message) : this(404, message, code: 404);

  final int httpStatus;
  final String message;

  /// 业务码；为 `null` 时由 `RestEnvelopeBuilder` 决定默认值。
  /// 取值 400/401/403/404/500 时表示「框架兜底」，需由业务项目翻译。
  final int? code;

  @override
  String toString() => 'RestException($httpStatus): $message';
}
