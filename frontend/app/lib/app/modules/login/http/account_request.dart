import 'dart:convert';

import 'package:auto_shop_server/app/simulator/umeng_manager.dart';
import 'package:crypto/crypto.dart';
import 'package:http_manager/http_manager.dart';

class AccountRequest {
// 注册验证码
  PubVillageV1SmsGetAppSignInSmsCode({String phone = "",}) async{
    phone = phone.replaceAll(" ", "");
    String url = "/$phone";
    Map<String, dynamic> data = { };
    return await httpManager.getAnalyzing(url, params: data);
  }

// 提交注册
  PubVillageV1LoginSignIn(Map<String, dynamic>? params) async {
    String url = "";
    return await httpManager.postAnalyzing(url, params: params);
  }


// 密码登录
  static Future<ResponseAnalyzed?> loginWithPassword({String account = "", String password = ''}) async {
    var account1 = account.replaceAll(" ", ""); // 如果有中文空格自动去除
    var account2 = account1.replaceAll(" ", ""); // 如果是英文空格自动去除
    String url = "/pub/v1/tenement/appLogin";
    final wdm5 = md5.convert(utf8.encode(password));
    final wdm5base64 = base64Encode(utf8.encode(wdm5.toString()));
    var deviceToken = await UmengPushManager.getDeviceToken();
    final data = {
      "inputBox": account2,
      "password": wdm5base64,
      //"uuid": AppManager.uuid,// 不可以使用，否则在调用首页接口时会返回 20401 退出登录。
      "deviceToken": deviceToken ?? await UmengPushManager.getDeviceToken(),
    };
    return await httpManager.postAnalyzing(url, params: data);
  }

}








// 校验手机号是否存在
AuthV1CustomerVerifyPhoneForApp({String phone = ''}) async {
  // phone = phone.replaceAll(" ", "");
  // String _url = "/auth/v1/customer/verifyPhoneForApp";
  // Map<String, dynamic> data = {
  //   "phone": phone,
  // };
  // var response = await httpManager.postAnalyzing(_url, data);
  // return analyzingAndCheckup(response);
}

// 获取验证码
PubVillageV1SmsSendSmsCode({String phone = '', isExist = '', uuid = ' '}) async {
  // phone = phone.replaceAll(" ", "");
  // String _url = "/auth/v1/customer/sendSmsCode";
  // Map<String, dynamic> data = {
  //   "phone": phone,
  //   "isExist": isExist,
  //   "uuid": uuid,
  // };
  // var response = await httpManager.postAnalyzing(_url, data);
  // return analyzingAndCheckup(response);
}

// 手机端修改手机号
AuthV1CustomerModifyPhoneForApp({phone = '', uuid = ' ', verificationCode = ''}) async {
  // phone = phone.replaceAll(" ", "");
  // String _url = "/auth/v1/customer/modifyPhoneForApp";
  // Map<String, dynamic> data = {
  //   "phone": phone,
  //   "uuid": uuid,
  //   "verificationCode": verificationCode,
  // };
  // var response = await httpManager.postAnalyzing(_url, data);
  // return analyzingAndCheckup(response);
}

// 删除账号
AuthV1CustomerCancelCustomerHttp({uuid = '', verificationCode = ' '}) async {
  String url = "/auth/v1/customer/cancelCustomer";
  Map<String, dynamic> data = {
    "uuid": uuid,
    "verificationCode": verificationCode,
  };
  return await httpManager.postAnalyzing(url, params: data);
}