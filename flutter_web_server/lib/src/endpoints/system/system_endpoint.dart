
import 'package:flutter_web_server/src/services/system/system_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';

class SystemEndpoint extends Endpoint {

  /// 健康检查
  @unauthenticatedClientCall
  Future<CommonResponse> health(Session session) async {
    return SystemService.health(session);
  }

  /// 版本信息
  @unauthenticatedClientCall
  Future<CommonResponse> version(Session session) async {
    return SystemService.version(session);
  }

}
