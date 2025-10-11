import 'package:flutter/cupertino.dart';
import 'package:http_manager/http_manager.dart';

class UserApi {
  
  /// 获取验证码
  static Future<ResponseAnalyzed> getCaptcha() async {
    final url = "/captchaImage";
    return await httpManager.getAnalyzing(url);
  }
  
  /// 获取 userToken
  static Future<ResponseAnalyzed> getUserToken(var uuid) async {
    String url = "/user/userToken";
    final param = {"uuid": uuid};
    debugPrint("登录不需要 userToken ，已设置测试代码的 userToken");
    // return await HttpManager.requestAnalyzing(HttpMethod.post, url, params: param);
    await Future.delayed(const Duration(seconds: 1));
    return ResponseAnalyzed(
        code: "200",
        data: "登录不需要 userToken ，已设置测试代码的 userToken",
        message: "登录不需要 userToken ，已设置测试代码的 userToken"
    );
  }

  /// 发送验证码
  // static Future<ResponseAnalyzed> shortMessageCode(var value) async {
  //   String url = "";
  //   final param = {"": ""};
  //   return await HttpManager.requestAnalyzing(HttpMethod.post, url, params: param);
  // }

  /// 注册
  static Future<ResponseAnalyzed> registerAccount(var account, var password) async {
    String url = "/user/register";
    final param = {"userName": account, "pwd": password, "role": "0"};
    return await httpManager.postAnalyzing(url, params: param);
  }

  /// 密码登录
  static Future<ResponseAnalyzed> login(var params) async {
    String url = "/v1/auth/login";
    return await httpManager.postAnalyzing(url, params: params);
  }

  /// 退出登录
  static Future<ResponseAnalyzed> logout({String account = "", String password = ""}) async {
    String url = "/user/logout";
    final param = {"userName": account, "password": password};
    return await httpManager.postAnalyzing(url, params: param);
  }



  /// 获取用户信息
  static Future<ResponseAnalyzed> getUserInfo() async {
    String url = "/getInfo";
    return await httpManager.getAnalyzing(url);
  }

  /// 短信登录
  // static Future<ResponseAnalyzed> loginWithShortMessage(var value) async {
  //   String url = "";
  //   final param = {"": ""};
  //   return await httpManager.requestAnalyzing(HttpMethod.post, url, params: param);
  // }



  // 密码登录
  // static Future<ResponseAnalyzed> loginWithPassword({String account = "", String password = ''}) async {
  //   var account1 = account.replaceAll(" ", ""); // 如果有中文空格自动去除
  //   var account2 = account1.replaceAll(" ", ""); // 如果是英文空格自动去除
  //   String url = "/api/user/register";
  //
  //   final wdm5 = md5.convert(utf8.encode(password));
  //   final wdm5base64 = base64Encode(utf8.encode(wdm5.toString()));
  //   var deviceToken = await AppManager.getDeviceToken();
  //   final data = {
  //     "inputBox": account2,
  //     "password": wdm5base64,
  //     //"uuid": AppManager.uuid,// 不可以使用，否则在调用首页接口时会返回 20401 退出登录。
  //     "deviceToken": deviceToken ?? await AppManager.getDeviceToken(),
  //   };
  //   return await httpManager.requestAnalyzing(HttpMethod.post, url, params: data);
  // }


  /// 忘记密码
  // static Future<ResponseAnalyzed> forgetPassword(var value) async {
  //   String url = "";
  //   final param = {"": ""};
  //   return await httpManager.requestAnalyzing(HttpMethod.post, url, params: param);
  // }



  /// 上报用户同意隐私协议
  // static Future<ResponseAnalyzed> uploadingSigned(var uuid) async {
  //   String url = "";
  //   final param = {"uuid": ""};
  //   return await HttpManager.requestAnalyzing(HttpMethod.post, url, params: param);
  // }


}