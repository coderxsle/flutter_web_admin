import 'package:auto_shop_server/common/index.dart';

final GetIt getIt = GetIt.instance;

/// 本地数据库管理器（业务表由后续开发接入）
class DBManager {
  static Future<void> init() async {
    // 建库/建表在此处接入
  }

  // 切换到当前用户的数据空间
  static Future<bool> switchBaseSpace() async {
    return false;
  }
}
