import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/common/common.dart';

class SystemService {

  /// 健康检查
  static Future<CommonResponse> health(Session session) async {
    // 真查一次库：连不上就抛，由路由层返回 500，容器探活才有效
    await session.db.unsafeQuery('SELECT 1');

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
  static Future<CommonResponse> version(Session session) async {
    final payload = {
      'version': _readEnv('VERSION', 'dev'),
      'appTitle': _readEnv('APP_TITLE', 'Flutter Web Admin'),
      'projectName': _readEnv('PROJECT_NAME', 'flutter_web_server'),
      'build': _readEnv('APP_BUILD', 'dev'),
      'commit': _readEnv('GIT_COMMIT', 'unknown'),
      'dartVersion': Platform.version,
    };

    return CommonResponse.success(payload);
  }

  static String _readEnv(String key, String fallback) {
    return Platform.environment[key] ?? fallback;
  }
}
