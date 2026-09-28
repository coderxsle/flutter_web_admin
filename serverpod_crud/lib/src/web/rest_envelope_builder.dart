import 'rest_exception.dart';
import 'rest_page.dart';
import 'rest_payload.dart';

/// 响应信封构造器 —— 业务项目与 CRUD Core 之间的接缝。
///
/// CRUD Core 不该知道业务项目的 `{code, message, data}` 长什么样，
/// 所以信封由业务项目实现。默认实现是 [PlainEnvelopeBuilder]。
abstract class RestEnvelopeBuilder {
  const RestEnvelopeBuilder();

  /// 单对象，任意载荷的成功响应。
  Map<String, dynamic> success(Object? data, {String? message});

  /// 分页成功响应。
  ///
  Map<String, dynamic> page(RestPage<Object?> page);

  /// 失败响应。[code] 为 `null` 时给一个默认业务码。
  Map<String, dynamic> failure(String message, {int? code});

  /// 业务失败时**对外给什么 HTTP 状态码**。默认原样透出
  /// [RestException.httpStatus]（HTTP 语义优先）；覆写可改成「一律 200、
  /// 成败只看 body 的 `code`」—— 本项目就是这么做的（`ServerpodEnvelopeBuilder`）。
  ///
  /// ⚠️ 覆写时**必须放行 401**：客户端靠这个真实状态码触发 refresh token，
  /// 压成 200 会让登录态无法续期。
  int httpStatusFor(RestException error) => error.httpStatus;
}

/// 默认信封：`{message, data}` / `{message, page..., data}` / `{message, code}`。
class PlainEnvelopeBuilder extends RestEnvelopeBuilder {
  const PlainEnvelopeBuilder();

  @override
  Map<String, dynamic> success(Object? data, {String? message}) => {
    'message': message ?? '',
    'data': restJsonify(data),
  };

  @override
  Map<String, dynamic> page(RestPage<Object?> page) => {
    'message': '',
    'page': page.page,
    'pageSize': page.pageSize,
    'total': page.total,
    'totalPage': page.totalPage,
    'data': restJsonify(page.data),
  };

  @override
  Map<String, dynamic> failure(String message, {int? code}) => {
    'message': message,
    'code': ?code,
  };
}
