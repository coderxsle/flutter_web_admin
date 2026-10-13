import 'package:yun_men_yi_pan/app/modules/account_manager/account_manager.dart';
import 'package:yun_men_yi_pan/app/utils/app_manager.dart';
import 'package:yun_men_yi_pan/app/utils/common_widget/base_controller.dart';
import 'package:yun_men_yi_pan/app/utils/global.dart';
import 'package:yun_men_yi_pan/app/modules/launching/app_launching.dart';
import 'package:yun_men_yi_pan/database/db_manager.dart';
import 'package:yun_men_yi_pan/app/modules/login/model/user_info.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/utils/result_code.dart';
import '../../launching/loacal_storage.dart';
import '../http/account_request.dart';


class LoginAccountBinding extends Binding {
  @override
  List<Bind> dependencies() => [
        // autoRemove:false —— 与旧 Get.lazyPut 一致：注册后不随路由销毁
        Bind<LoginAccountController>.builder(
          create: (_) => LoginAccountController(),
          autoRemove: false,
        ),
      ];
}


class LoginAccountController extends BaseController {

  final TextEditingController accountVC = TextEditingController(); // 账号
  final TextEditingController passwordVC = TextEditingController(); // 密码
  final hostVC = TextEditingController();

  String account = "";
  List<String> loginHistory = [];

  bool accountIsEditing = false;
  bool checkboxSelected = false; //维护复选框状态
  bool canLogin = false; //可以获取验证码
  late String showAccountText = "";

  final FocusNode accountFocusNode = FocusNode();


  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 2000)).then((value) {
      AppLaunching.readUserInfoTap();
    });
    // loadLoginHistory();
    _loadLastAccount();
  }

  // // 加载历史账号
  // loadLoginHistory() async {
  //   List<Map<String, String>> history = await AccountManager.getLoginHistory();
  //   loginHistory = history.map((entry) => entry.keys.first).toList();
  // }

  // 填充账号对应的密码
  Future<String> _fillPasswordForAccount(String account) async {
    return await AccountManager.getPasswordForAccount(account)??"";
  }

  // 添加自动填充上次登录信息的方法
  void _loadLastAccount() async {
    final lastAccount = await AccountManager.getLoginHistory();
    if (lastAccount.isNotEmpty) {
      accountVC.text = lastAccount.first.keys.first;
      final password = await _fillPasswordForAccount(lastAccount.first.keys.first);
      if (password.isNotEmpty) {
        passwordVC.text = password;
      }
      account = lastAccount.first.keys.first;
      showAccountText = lastAccount.first.keys.first;
    }
  }

  gotoLogin() {
    FocusScope.of(Get.context!).requestFocus(FocusNode());
    if (accountVC.text == "") {
      showMessage("请输入账号或手机号");
      return;
    }
    if (passwordVC.text == "") {
      showMessage("请输入密码");
      return;
    }
    if (!checkboxSelected) {
      showMessage("请先阅读与同意《服务协议》和《隐私协议》");
      return;
    }
    gotoLoginWithPassword(accountVC.text, passwordVC.text);
  }

  _loginWitPassword(String account, String password) async {
    showLoadingMessage("拼命登录中...");
    final result = await AccountRequest.loginWithPassword(account: account, password: password);
    if (!result.success) {
      dismissLoading();
      return;
    }

    final data = result.data as Map;
    // 下一步拉资料要靠它鉴权，先装到请求头
    AppManager.setAuthToken(access: data["accessToken"], refresh: data["refreshToken"]);

    // 登录只下发 token，昵称/头像/角色/权限/菜单走 GET /api/user/info
    final info = await AccountRequest.getUserInfo();
    if (!info.success) {
      dismissLoading();
      AppManager.clearAuthToken(); // 资料拉不全就当没登录成，别留半截状态
      // 业务码的提示统一响应检查已经弹过，这里只兜它不认识的情况
      if (!_isKnownBusinessCode(info.code)) showMessage("获取用户信息失败，请稍后重试");
      return;
    }

    AppManager.userInfo = UserInfoResponse.fromJson(Map<String, dynamic>.from(info.data as Map));

    localStorageWrite("native_auth", true);
    localStorageWrite("lastAccountPassword", password);
    AccountManager.addAccountToHistory(account, password);
    // 登录成功，需要切换空间
    DBManager.switchBaseSpace();
    Get.offNamed("/");
  }

  /// 这几个码的提示已由统一响应检查弹过，避免重复弹两次
  bool _isKnownBusinessCode(String? code) {
    return code == ResultCode.failed ||
        code == ResultCode.validateFailed ||
        code == ResultCode.forbidden ||
        code == ResultCode.unauthorized ||
        code == ResultCode.authReplaced;
  }

  // 密码登录
  gotoLoginWithPassword(String account, String password) {
    _loginWitPassword(account, password);
  }


}
