import 'package:flutter_web_server/src/common/common.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 业务项目的 REST 信封。
class ServerpodEnvelopeBuilder implements EnvelopeBuilder {
  const ServerpodEnvelopeBuilder();

  @override
  Map<String, dynamic> success(Object? data, {String? message}) {
    // Service 层已经返回信封（**含分页的 `PageResponse`**）时直接采用
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

  /// 业务失败一律 **HTTP 200**，成败只由 body 里的 `code` 表达（2026-09-24 决策）。
  @override
  int httpStatusFor(RestException error) => error.httpStatus == 401 ? 401 : 200;

  /// 把 CRUD Core 传来的兜底值翻译成本项目的业务码。
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
