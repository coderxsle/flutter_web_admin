import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

/// 登录密码加密，与后端 `LoginPasswordCipher` 对称：RSA-OAEP(SHA-256) 加密后 Base64。
/// 公钥从 `GET /api/auth/publicKey` 取，见 backend/flutter_web_server/lib/src/security/login_password_cipher.dart。
class LoginPasswordCipher {
  LoginPasswordCipher._();

  static String encrypt(String plainPassword, String publicKeyPem) {
    final publicKey = RSAKeyParser.parsePublicKeyFromPem(publicKeyPem);
    return RSAOAEP(hash: SHA256Digest()).encryptString(plainPassword, publicKey);
  }
}
