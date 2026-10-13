// ignore_for_file: non_constant_identifier_names, constant_identifier_names

import 'package:yun_men_yi_pan/app/utils/app_manager.dart';
import 'package:yun_men_yi_pan/app/utils/common_widget/my_dialog.dart';
import 'package:yun_men_yi_pan/utils/error_log_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:http_manager/http_manager.dart';

/// 服务端业务码。
///
/// 必须与 backend/flutter_web_server/lib/src/common/result_code.dart 里的 ResultCode 一一对应，
/// 改一边就要改另一边。业务失败同样返回 HTTP 200，成败只看 body 里的 code。
class ResultCode {
  ResultCode._();

  static const String success = "20000"; // 成功
  static const String failed = "50000"; // 操作失败（服务端兜底码）
  static const String validateFailed = "40400"; // 入参不合法
  static const String unauthorized = "40100"; // 未登录，或 accessToken 已过期
  static const String authReplaced = "40800"; // 登录态已在别处失效
  static const String forbidden = "40300"; // 没有相关权限

  // 以下四个是客户端页面状态，服务端不会返回，只给 LayoutSubviews / BaseController 用。
  static const String loading = "loading";
  static const String error = "error";
  static const String empty_data = "empty";
  static const String no_more_data = "noMore";
}

/// 登录态失效只处理一次：并发请求同时 401 时不重复弹窗、不重复跳登录页。
bool _authFailedHandling = false;

extension ResponseAnalyzedExtension on ResponseAnalyzed {
  bool get success => code == ResultCode.success;
  bool get failure => !success;

  /// 客户端页面状态，不是服务端业务码
  bool get empty => code == ResultCode.empty_data;
  bool get noMoreData => code == ResultCode.no_more_data;

  /// 未登录 / accessToken 已过期
  bool get emptyToken => code == ResultCode.unauthorized;

  /// 所有响应的统一检查入口，注册给 `ResponseAnalyzed.setResultCheck()`。
  ///
  /// [ResponseAnalyzed.code] 在解析失败时可能是 HTTP 状态码甚至整段 body，
  /// 所以这里只做字符串比较，不要 int.parse。
  static Future<void> checkAnalyzing(ResponseAnalyzed result) async {
    final code = result.code;

    if (code == ResultCode.success) {
      _authFailedHandling = false; // 登录态已恢复，允许下次再触发
      return;
    }

    // 登录态失效：清掉本地登录信息并回登录页，别让界面继续拿废 token 发请求
    if (code == ResultCode.unauthorized || code == ResultCode.authReplaced) {
      _onAuthFailed(code == ResultCode.authReplaced);
      return;
    }

    // 业务失败：服务端的 message 就是给用户看的文案，直接提示
    if (code == ResultCode.failed || code == ResultCode.validateFailed || code == ResultCode.forbidden) {
      _toast(result);
    } else {
      // 非业务码（HTTP 状态码、解析失败、客户端还不认识的新码）：只记日志，不提示
      debugPrint("未识别的响应码 code=$code, message=${result.message}");
    }

    await ErrorLogUtils.addLog(result);
  }

  static void _onAuthFailed(bool replaced) {
    if (_authFailedHandling) return;
    _authFailedHandling = true;
    showMessage(replaced ? "账号已在其他设备登录，请重新登录" : "登录已过期，请重新登录");
    AppManager.signOut(); // 里面会清掉本地 token 和 Authorization 头
  }

  static void _toast(ResponseAnalyzed result) {
    final message = result.message;
    result.isExposedToUser = true;
    showMessage(message == null || message.isEmpty ? _fallbackMessage(result.code) : message);
  }

  static String _fallbackMessage(String? code) {
    if (code == ResultCode.unauthorized) return "登录已过期，请重新登录";
    if (code == ResultCode.authReplaced) return "账号已在其他设备登录，请重新登录";
    if (code == ResultCode.forbidden) return "没有相关权限";
    if (code == ResultCode.validateFailed) return "提交的参数不合法";
    return "操作失败，请稍后重试";
  }
}
