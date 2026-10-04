import 'dart:io';

import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

const _loginRsaPrivateKeyPath = 'config/keys/login_rsa_private.pem';

/// 登录/创建用户时密码密文处理
class LoginPasswordCipher {
  static Future<String> decrypt(String passwordCipherBase64) async {
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
      throw Exception('密码解密失败: $e');
    }
  }
}
