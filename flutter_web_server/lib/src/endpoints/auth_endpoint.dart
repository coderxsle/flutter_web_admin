import 'dart:io';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart' as auth;
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/shared.dart';
import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

const _loginRsaPublicKeyPath = 'config/keys/login_rsa_public.pem';
const _loginRsaPrivateKeyPath = 'config/keys/login_rsa_private.pem';

class AuthEndpoint extends Endpoint {
  /// 用户登录接口（使用 JwtTokenManager 签发 accessToken / refreshToken）
  Future<CommonResponse> login(Session session, String username, String password) async {
    try {
      // password 现在约定为：前端使用 RSA-OAEP(SHA-256) 加密后再 Base64 编码的密文
      // 这里先用服务端私钥解密，得到真实明文密码
      final plainPassword = await _decryptLoginPassword(password);

      // 1. 查询用户
      final user = await SysUser.db.findFirstRow(session, where: (t) => t.username.equals(username) & t.deleted.equals(false));
      // 2. 验证用户名和密码
      if (user == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '用户不存在');
      }

      // 3. 验证密码（实际项目中应该使用加密后的密码比较）
      final plainPassword2 = "asdf1234"; // 测试使用明文密码
      if (user.password != plainPassword2) {
        return CommonResponse(code: ResultCode.failed.code, message: '用户或密码错误');
      }

      // 3. 为当前登录用户创建一个 AuthUser（只承担认证身份，不和业务表强绑定）
      final authUser = await auth.AuthServices.instance.authUsers.create(session);

      // 4. 使用 JwtTokenManager 签发 accessToken / refreshToken
      final jwtManager = auth.AuthServices.getTokenManager<auth.JwtTokenManager>();
      final authSuccess = await jwtManager.issueToken(
        session,
        authUserId: authUser.id,
        method: 'password', // 自定义登录方式标识
        scopes: {Scope.none},
      );

      final accessToken = authSuccess.token;
      final refreshToken = authSuccess.refreshToken;
      var expiresIn = 3600;
      // 计算 accessToken 剩余有效期（秒），tokenExpiresAt 是 JWT token 的过期时间，取其与当前时间的差值
      if (authSuccess.tokenExpiresAt != null) {
        expiresIn = authSuccess.tokenExpiresAt!.difference(DateTime.now().toUtc()).inSeconds;
      }

      final now = DateTime.now();

      // 5. 更新用户登录时间和 token（不再清空密码字段，以便后续登录校验）
      final newUser = user.copyWith(loginTime: now, token: accessToken);
      final updatedUser = await SysUser.db.updateRow(session, newUser);

      // 6. 返回认证信息（后续通过 UserEndpoint 获取详细用户信息）
      final authPayload = {
        'userId': updatedUser.id,
        'username': updatedUser.username,
        'expiresIn': expiresIn,
        'tokenType': 'Bearer',
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
      // 7. 返回认证信息
      return CommonResponse.success(authPayload);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '登录失败：$e');
    }
  }

  /// 无需登录即可获取登录用 RSA 公钥（PEM 字符串）
  @unauthenticatedClientCall
  Future<CommonResponse> publicKey(Session session) async {
    try {
      final file = File(_loginRsaPublicKeyPath);
      if (!await file.exists()) {
        return CommonResponse(code: ResultCode.failed.code, message: '登录公钥不存在，请联系管理员');
      }
      final pem = await file.readAsString();
      return CommonResponse.success(pem);
    } catch (e, stackTrace) {
      session.log('读取登录公钥失败: $e\n$stackTrace');
      return CommonResponse(code: ResultCode.failed.code,message: '读取登录公钥失败');
    }
  }

  /// 解密登录密码
  Future<String> _decryptLoginPassword(String passwordCipherBase64) async {
    try {
      final file = File(_loginRsaPrivateKeyPath);
      if (!await file.exists()) {
        throw Exception('登录私钥文件不存在');
      }
      final privateKeyPem = await file.readAsString();
      final privateKey = RSAKeyParser.parsePrivateKeyFromPem(privateKeyPem);
      
      final oaep = RSAOAEP(hash: SHA256Digest());
      // rsa_oaep_dart 的 decryptString 接收 Base64 编码的密文字符串并返回明文字符串
      return oaep.decryptString(passwordCipherBase64, privateKey);
    } catch (e) {
      throw Exception('登录密码解密失败: $e');
    }
  }

  /// 使用 refreshToken 刷新 accessToken（无需已登录）
  @unauthenticatedClientCall
  Future<CommonResponse> refreshToken(Session session, String refreshToken) async {
    try {
      final jwt = auth.AuthServices.getTokenManager<auth.JwtTokenManager>().jwt;
      final authSuccess = await jwt.refreshAccessToken(session, refreshToken: refreshToken);

      final accessToken = authSuccess.token;
      final newRefreshToken = authSuccess.refreshToken;
      var expiresIn = 3600;
      if (authSuccess.tokenExpiresAt != null) {
        expiresIn = authSuccess.tokenExpiresAt!.difference(DateTime.now().toUtc()).inSeconds;
      }

      final data = {
        'accessToken': accessToken,
        'refreshToken': newRefreshToken,
        'tokenType': 'Bearer',
        'expiresIn': expiresIn,
      };

      return CommonResponse.success(data);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '刷新token失败：$e');
    }
  }
}