import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_shared/shared.dart';

class SystemEndpoint extends Endpoint {

  /// 健康检查
  @unauthenticatedClientCall
  Future<CommonResponse> health(Session session) async {
    final payload = {
      'status': 'healthy',
      'timestamp': DateTime.now().toUtc().toIso8601String(),
      'version': _readEnv('VERSION', 'dev'),
      'environment': _readEnv('APP_ENV', 'development'),
      'service': _readEnv('PROJECT_NAME', 'flutter_web_server'),
      'database': 'connected',
    };

    return CommonResponse.success(payload);
  }

  /// 版本信息
  @unauthenticatedClientCall
  Future<CommonResponse> version(Session session) async {
    final payload = {
      'version': _readEnv('VERSION', 'dev'),
      'app_title': _readEnv('APP_TITLE', 'Flutter Web Admin'),
      'project_name': _readEnv('PROJECT_NAME', 'flutter_web_server'),
      'build': _readEnv('APP_BUILD', 'dev'),
      'commit': _readEnv('GIT_COMMIT', 'unknown'),
      'dart_version': Platform.version,
    };

    return CommonResponse.success(payload);
  }

  String _readEnv(String key, String fallback) {
    return Platform.environment[key] ?? fallback;
  }
}
