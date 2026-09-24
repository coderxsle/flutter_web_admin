import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 业务项目的 REST 信封。
///
/// [RestEnvelopeBuilder] 是 CRUD Core 与业务项目之间的**唯一**接缝：
/// Core 不认识 `{code, message, data}`，只负责把载荷交出来；由本类决定它
/// 长什么样。整个项目**只应该有一个**实现 —— 这正是 S1.5「信封收口」的目标
/// （此前手写 Route 各自调 `CommonResponse.toJson()`，泛型 Route 用
/// `PlainEnvelopeBuilder`，两条链路的输出形状不一致）。
///
/// ## 输出形状（与 typed Endpoint 逐字节一致）
///
/// | 场景 | JSON |
/// |---|---|
/// | 单对象 / 列表成功 | `{code: 20000, message: 'succeed', data: …}` |
/// | 分页成功 | `{code: 20000, message: '', page, pageSize, totalPage, total, data: […]}` |
/// | 失败 | `{code: ……, message: …}` |
///
/// 之所以能逐字节一致：成功路径直接复用 `CommonResponse.toJson()` /
/// `PageResponse.toJson()` —— 它们内部会走 `JsonCleaner` 去掉 `__className__`
/// 与 `password`。**不要**在这里手搓 map，否则很容易漏掉 `JsonCleaner`。
///
/// ⚠️ 注意两个 message 的差异：普通成功是 `'succeed'`（`ResultCode.success.message`），
/// 而分页成功是**空串**（`PageResponse.restPage` 的默认值就是 `''`）。这是既有行为，别"顺手统一"。
class ServerpodEnvelopeBuilder implements RestEnvelopeBuilder {
  const ServerpodEnvelopeBuilder();

  @override
  Map<String, dynamic> success(Object? data, {String? message}) {
    // Service 层已经返回信封的情况：直接采用，**不要**再包一层。
    // 否则会变成 {code, message, data: {code, message, …}} 的双层嵌套
    // —— 本项目 9 个业务 Service 全都返回 CommonResponse，
    // 所以这是常态而不是特例。
    if (data is CommonResponse) return data.toJson();
    return CommonResponse.success(data, message).toJson();
  }

  @override
  Map<String, dynamic> page(RestPage<Object?> page) => PageResponse.restPage(
    data: restJsonify(page.data) as List,
    page: page.page,
    pageSize: page.pageSize,
    total: page.total,
  ).toJson();

  @override
  Map<String, dynamic> failure(String message, {int? code}) => {
    'code': _mapCode(code),
    'message': message,
  };

  /// 把 CRUD Core 传来的兜底值翻译成本项目的业务码。
  ///
  /// 约定见 [RestApiException] 的文档：框架在不知道业务码时会填
  /// **HTTP 状态码风格**的值（400/401/403/404/500），这里把它们翻成
  /// `ResultCode`；其余值（含 `null`）按业务码语义处理。
  ///
  /// ⚠️ 之所以不会有歧义：本项目 `ResultCode` 的取值全部 ≥ 20000，
  /// 与那五个 HTTP 状态码不可能撞车。
  static int _mapCode(int? code) {
    switch (code) {
      case 401:
        return ResultCode.unauthorized.code; // 40100
      case 403:
        return ResultCode.forbidden.code; // 40300
      case 404:
        return ResultCode.validateFailed.code; // 40400
      case 500:
        return ResultCode.failed.code; // 50000
      case 400:
        return ResultCode.validateFailed.code; // 40400：入参不合法
      default:
        // null 与「明确的业务码」都走这里：
        // · null  = 框架只说「失败了」→ 50000
        // · 其它  = 调用方透传的业务码（如 Service 的 50000 / 40400）→ 原样
        return code ?? ResultCode.failed.code;
    }
  }
}
