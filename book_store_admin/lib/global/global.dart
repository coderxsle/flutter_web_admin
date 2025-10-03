import 'package:book_store_admin/config/routes.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'global_controller.dart';

class Global {
  static late SharedPreferences prefs;
  static bool isRelease = const bool.fromEnvironment("dart.vm.product");

  static Future<void> init() async {
    // 初始化 SharedPreferences
    prefs = await SharedPreferences.getInstance();
  }

  // 是否登录
  static bool get isLoggedIn => prefs.getString('token') != null;

  // 获取 token
  static String? get token => prefs.getString('token');

  // 设置 token
  static Future<bool> setToken(String token) => prefs.setString('token', token);

  // 清除 token
  static Future<bool> clearToken() => prefs.remove('token');

  // 获取用户信息
  static Map<String, dynamic>? get userInfo {
    String? userStr = prefs.getString('user_info');
    if (userStr == null) return null;
    return {}; // TODO: 实现 JSON 解析
  }

  // 设置用户信息
  static Future<bool> setUserInfo(Map<String, dynamic> userInfo) =>
      prefs.setString('user_info', userInfo.toString()); // TODO: 实现 JSON 序列化

  // 清除用户信息
  static Future<bool> clearUserInfo() => prefs.remove('user_info');

  // 退出登录
  static Future<void> logout() async {
    await clearToken();
    await clearUserInfo();
    Get.offAllNamed(Routes.login);
  }
} 



