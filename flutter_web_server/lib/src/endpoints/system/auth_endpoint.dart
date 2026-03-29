import 'package:flutter_web_server/src/services/system/auth_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';

class AuthEndpoint extends Endpoint {

  /// 用户登录接口（使用 JwtTokenManager 签发 accessToken / refreshToken）
  Future<CommonResponse> login(Session session, String username, String password) async {
    return AuthService.login(session, username, password);
  }

  /// 无需登录即可获取登录用 RSA 公钥（PEM 字符串）
  Future<CommonResponse> publicKey(Session session) async {
    return AuthService.publicKey(session);
  }

  /// 使用 refreshToken 刷新 accessToken（无需已登录）
  Future<CommonResponse> refreshToken(Session session, String refreshToken) async {
    return AuthService.refreshToken(session, refreshToken);
  }

}