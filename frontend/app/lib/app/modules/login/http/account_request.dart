import 'package:flutter/material.dart';
import 'package:yun_men_yi_pan/app/utils/app_manager.dart';
import 'package:yun_men_yi_pan/app/utils/login_password_cipher.dart';
import 'package:yun_men_yi_pan/app/utils/result_code.dart';
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

  /// 登录用 RSA 公钥（PEM 字符串）
  static Future<ResponseAnalyzed> getLoginPublicKey() async {
    return await httpManager.getAnalyzing("/api/auth/publicKey");
  }

  /// 密码登录：username + RSA-OAEP(SHA-256) 加密后的密码，
  /// 成功返回 data = {userId, username, expiresIn, tokenType, accessToken, refreshToken}
  static Future<ResponseAnalyzed> loginWithPassword({String account = "", String password = ''}) async {
    final key = await getLoginPublicKey();
    if (!key.success) return key;

    // 中文空格(U+2006)、英文空格都去掉，避免复制粘贴带进来
    final username = account.replaceAll("\u2006", "").replaceAll(" ", "").trim();
    final data = {"username": username, "password": LoginPasswordCipher.encrypt(password, key.data as String)};
    return await httpManager.postAnalyzing("/api/auth/login", params: data);
  }

  /// 当前登录用户信息，需要带 Authorization: Bearer。
  /// 成功返回 data = {user, posts, roles, permissions, menus}
  static Future<ResponseAnalyzed> getUserInfo() async {
    return await httpManager.getAnalyzing("/api/user/info");
  }

  // 刷新 UserToken
  static Future<ResponseAnalyzed> refreshToken({String uuid = ""}) async {
    String url = "/api/auth/refreshToken";
    Map<String, dynamic> data = {};
    var result = await httpManager.getAnalyzing(url, params: data);
    if (result.success) {
      AppManager.userToken = result.data;
    } else {
      debugPrint("getUserToken 获取失败 ${result.message}");
    }
    return result;
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
