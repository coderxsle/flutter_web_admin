import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

/// 密码哈希工具（PBKDF2-HMAC-SHA256）
///
/// 存储格式：`pbkdf2_sha256$<iterations>$<saltBase64>$<hashBase64>`
class PasswordHasher {
  static const String _algorithm = 'pbkdf2_sha256';
  static const int _iterations = 100000;
  static const int _saltLength = 16;
  static const int _keyLength = 32;

  static String hashPassword(String plainPassword) {
    final salt = _generateSalt(_saltLength);
    final hash = _pbkdf2(plainPassword, salt, _iterations, _keyLength);

    return '$_algorithm\$$_iterations\$${base64Encode(salt)}\$${base64Encode(hash)}';
  }

  static bool verifyPassword(String plainPassword, String storedPassword) {
    final parts = storedPassword.split(r'$');
    if (parts.length != 4 || parts[0] != _algorithm) {
      return false;
    }

    final iterations = int.tryParse(parts[1]);
    if (iterations == null || iterations <= 0) {
      return false;
    }

    try {
      final salt = base64Decode(parts[2]);
      final expectedHash = base64Decode(parts[3]);
      final actualHash = _pbkdf2(plainPassword, salt, iterations, expectedHash.length);
      return _constantTimeEquals(actualHash, expectedHash);
    } catch (_) {
      return false;
    }
  }

  static Uint8List _generateSalt(int length) {
    final random = Random.secure();
    return Uint8List.fromList(List<int>.generate(length, (_) => random.nextInt(256)));
  }

  static Uint8List _pbkdf2(String password, Uint8List salt, int iterations, int keyLength) {
    final derivator = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64));
    derivator.init(Pbkdf2Parameters(salt, iterations, keyLength));
    return derivator.process(Uint8List.fromList(utf8.encode(password)));
  }

  static bool _constantTimeEquals(Uint8List a, Uint8List b) {
    if (a.length != b.length) {
      return false;
    }
    var diff = 0;
    for (var i = 0; i < a.length; i++) {
      diff |= a[i] ^ b[i];
    }
    return diff == 0;
  }
}
