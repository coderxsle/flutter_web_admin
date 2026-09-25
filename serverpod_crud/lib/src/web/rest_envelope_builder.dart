import 'rest_api_exception.dart';
import 'rest_page.dart';
import 'rest_payload.dart';

/// 响应信封构造器 —— 业务项目与 CRUD Core 之间的接缝。
///
/// CRUD Core 不该知道业务项目的 `{code, message, data}` 长什么样，
/// 所以信封由业务项目实现。默认实现是 [PlainEnvelopeBuilder]。
abstract class RestEnvelopeBuilder {
  const RestEnvelopeBuilder();

  /// 单对象 / 任意载荷的成功响应。
  Map<String, dynamic> success(Object? data, {String? message});

  /// 分页成功响应。
  ///
  /// 单独一个方法（而不是复用 [success]）是因为**分页的形状由业务项目定**：
  /// 有的项目把 `page/pageSize/total/totalPage` 摊在顶层、`data` 放当前页
  /// 数组；有的项目（如团队前端 `PageRes`）把 `data` 做成
  /// `{records, total, …}` 的对象。Core 不预设，只把 [RestPage] 交出来。
  Map<String, dynamic> page(RestPage<Object?> page);

  /// 失败响应。[code] 为 `null` 时给一个默认业务码。
  Map<String, dynamic> failure(String message, {int? code});

  /// 业务失败时**对外给什么 HTTP 状态码**。默认原样透出
  /// [RestApiException.httpStatus]（HTTP 语义优先）；覆写可改成「一律 200、
  /// 成败只看 body 的 `code`」—— 本项目就是这么做的（`ServerpodEnvelopeBuilder`）。
  ///
  /// ⚠️ 覆写时**必须放行 401**：客户端靠这个真实状态码触发 refresh token，
  /// 压成 200 会让登录态无法续期。
  int httpStatusFor(RestApiException error) => error.httpStatus;
}

/// 默认信封：`{message, data}` / `{message, page..., data}` / `{message, code}`。
///
/// 字段名刻意保持中立 —— 不带 `ResultCode` 这类业务枚举。
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
