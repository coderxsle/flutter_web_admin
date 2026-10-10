import 'package:auto_shop_server/app/modules/account_manager/account_manager.dart';
import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/utils/common_widget/base_controller.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/app/modules/launching/app_launching.dart';
import 'package:auto_shop_server/database/db_manager.dart';
import 'package:auto_shop_server/app/modules/login/model/user_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/modules/home/models/shop_model.dart';
import '../../../../app/modules/home/request/home_request.dart';
import '../../../../app/utils/result_code.dart';
import '../../launching/loacal_storage.dart';
import '../../launching/request/launching_request.dart';
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

  // 获取获取店铺
  getShopListAndOpenApp() async {
    debugPrint("AppManager.currentShop = null");
    debugPrint("正在获取 currentShop...");
    showLoadingMessage("正在获取店铺...");
    // await Future.delayed(const Duration(milliseconds: 500));

    // 验证登录账号是否分配店铺
    HomeRequest.getShopList().then((result) {
      if (result.success) {
        List<ShopModel> shops;
        shops = (result.data as List).map((i) => ShopModel.fromJson(i)).toList();
        AppManager.setShopModel(shops.first);

        Get.offNamed("/");

      }else if (result.code == ResultCode.empty_data) {
        dismissLoading();
        showMessage("该账号尚未分配店铺，请联系管理员分配！");
      }else {
        dismissLoading();
        getShopListAndOpenApp();
      }
    });
  }

  _loginWitPassword(String account, String password) {
    showLoadingMessage("拼命登录中...");
    AccountRequest.loginWithPassword(account: account, password: password).then((result) {
      if (result!.success) {
        AppManager.userAccount = UserAccount.fromJson(result.data);
        localStorageWrite("native_auth", true);
        localStorageWrite("lastAccountPassword", password);
        AccountManager.addAccountToHistory(account, password);
        getShopListAndOpenApp();
        // 登录成功，需要切换空间
        DBManager.switchBaseSpace();
      }else if (result.emptyToken) {
        dismissLoading();
        AppManager.userToken = "";
        gotoLoginWithPassword(account, password);
      }else {
        dismissLoading();
      }
    });
  }

  // 密码登录
  gotoLoginWithPassword(String account, String password) {
    if (AppManager.userToken.isNotEmpty) {
      _loginWitPassword(account, password);
    }else {
      debugPrint("AppManager.userToken = null");
      debugPrint("正在获取 UserToken...");
      showLoadingMessage("正在获取token...");
      LaunchRequest.getUserToken(uuid: AppManager.uuid).then((result) {
        if (result.success && AppManager.userToken.isNotEmpty) {
          _loginWitPassword(account, password);
        }else {
          dismissLoading();
          _loginWitPassword(account, password);
        }
      });
    }
  }


}
