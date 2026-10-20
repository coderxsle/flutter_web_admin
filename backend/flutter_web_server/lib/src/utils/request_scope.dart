import 'dart:async';

import 'package:serverpod/serverpod.dart';

/// 当前 REST 请求的元数据。
class RequestInfo {
  const RequestInfo({required this.method, required this.path, this.remoteInfo, this.userAgent});

  final String method;
  final String path;
  final String? remoteInfo;
  final String? userAgent;
}

/// 把请求信息放进 Zone，供业务层（审计等）读取。
///
/// REST 路由拿到的是 `WebCallSession`，它的 `method` / `request` 恒为 null，
/// 所以 `session.request?.url` 这条老路在 8082 上取不到值。
class RequestScope extends MiddlewareObject {
  const RequestScope();

  static final Object _key = Object();

  static RequestInfo? get current => Zone.current[_key] as RequestInfo?;

  static R run<R>(RequestInfo info, R Function() body) => runZoned(body, zoneValues: {_key: info});

  @override
  Handler call(Handler next) => (request) async {
    final info = RequestInfo(
      method: request.method.value,
      path: request.url.path,
      remoteInfo: request.remoteInfo,
      userAgent: request.headers.userAgent,
    );
    return RequestScope.run(info, () => next(request));
  };
}
