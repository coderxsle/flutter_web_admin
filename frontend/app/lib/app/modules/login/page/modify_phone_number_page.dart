import 'dart:async';

import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_manager/result_analyzed.dart';

import '../../../utils/global.dart';
import '../../../utils/result_code.dart';
import '../http/account_request.dart';
import '../widget/account_form.dart';

/// 修改登录手机号：填新号码 → 取验证码 → 提交（提交成功后退出登录）
class ModifyPhoneNumberPage extends StatefulWidget {
  const ModifyPhoneNumberPage({super.key});

  @override
  State<ModifyPhoneNumberPage> createState() => _ModifyPhoneNumberPageState();
}

class _ModifyPhoneNumberPageState extends State<ModifyPhoneNumberPage> {
  //手机号码
  final TextEditingController _phoneNumberController = TextEditingController();
  //验证码
  final TextEditingController _codeNumberController = TextEditingController();
  // 可以获取验证码
  bool _canGetCode = false;

  //短信验证码按钮标题
  String _sendMessageTitle = '获取验证码';
  Timer? _timer;
  int _countdownTime = 0;

  /// 手机号合法且不在倒计时中才允许取验证码
  void _refreshCanGetCode() {
    setState(() {
      _canGetCode = _phoneNumberController.text.length == 11 && _countdownTime == 0;
    });
  }

  /// 验证手机号是否可以修改
  Future _AuthV1CustomerVerifyPhoneForAppHttp() async {
    // ResponseAnalyzed result = await AuthV1CustomerVerifyPhoneForApp(phone: _phoneNumberController.text);
    // if (result.code == ResultCode.success) {
    //   if (result.data is Map) {
    //     if ((result.data as Map).containsKey('isExist')) {
    //       String isExist = result.data['isExist'].toString();
    //       if (result.data['isExist'] == 3) {
    //         _PubVillageV1SmsSendSmsCodeHttp(isExist);
    //       }else if (result.data['isExist'] == 2) {
    //         String desc = result.data['desc'];
    //         // 弹框提示，是否确定修改的操作
    //         showTipMessageToUser(desc, isExist);
    //       }else { /// result.data['isExist'] <= 1
    //         showMessage(result.data['desc']);
    //       }
    //     }
    //   }
    // }
  }

  /// 获取验证码
  Future _PubVillageV1SmsSendSmsCodeHttp(String isExist) async {
    // showLoadingMessage("正在获取验证码...");
    // String _phone = _phoneNumberController.text;
    // ResponseAnalyzed result = await PubVillageV1SmsSendSmsCode(phone: _phone, isExist: isExist, uuid: AppManager.uuid);
    // dismissLoading();
    // if (result.code == ResultCode.success) {
    //   //   {"codeLength": 4, "time": 120, "timeUnit": "SECONDS" }
    //   /// 开启重新获取验证码的倒计时
    //   startCountdownTimer(result.data['time']);
    // }else {
    //   if (result.isExposedToUser) {
    //     /// 判断结果码是否面向用户
    //     result.show();
    //   }
    // }
  }

  /// 提交修改手机号
  Future authV1CustomerModifyPhoneForAppHttp() async {
    String phone = _phoneNumberController.text;
    String code = _codeNumberController.text;
    // 接口未开放时返回 null，不能直接取 result.code
    final ResponseAnalyzed? result = await AuthV1CustomerModifyPhoneForApp(phone: phone, uuid: AppManager.uuid, verificationCode: code);
    if (result?.code == ResultCode.success) {
      /// 手机号修改成功后，需要退出当前的登录状态
      AppManager.signOut();
    }
  }

  void _submit() {
    if (_phoneNumberController.text.length != 11) {
      showMessage("请输入 11 位手机号");
      return;
    }
    if (_codeNumberController.text.isEmpty) {
      showMessage("请输入验证码");
      return;
    }
    authV1CustomerModifyPhoneForAppHttp();
  }

  void _sendCode() {
    FocusScope.of(context).requestFocus(FocusNode());
    _AuthV1CustomerVerifyPhoneForAppHttp();
  }

  /// 弹出提示框，选择操作流程
  showTipMessageToUser(String desc, String isExist) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('温馨提示', style: TextStyle(fontSize: 17)),
          content: Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
            child: Text(desc),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: const Text('取消', style: TextStyle(color: Color.fromRGBO(215, 85, 82, 1))),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: const Text('确定'),
              onPressed: () async {
                Get.back();
                /// 获取验证码
                _PubVillageV1SmsSendSmsCodeHttp(isExist);
              },
            ),
          ],
        );
      },
    );
  }

  /// 验证码倒计时(倒计时结束后可重新获取)
  void startCountdownTimer(int second) {
    _countdownTime = second;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        _countdownTime--;
        if (_countdownTime <= 0) {
          timer.cancel();
          _countdownTime = 0;
          _sendMessageTitle = '获取验证码';
        } else {
          _sendMessageTitle = '$_countdownTime 秒';
        }
        _canGetCode = _phoneNumberController.text.length == 11 && _countdownTime == 0;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const NavigatorTitle("修改登录手机号"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: FormScrollBody(
        children: [
          const FormGroupTitle("绑定新号码"),
          FormCard(
            children: [
              FormInputRow(
                label: "手机号",
                controller: _phoneNumberController,
                hintText: "请输入新手机号",
                maxLength: 11,
                digitsOnly: true,
                onChanged: (_) => _refreshCanGetCode(),
              ),
              FormInputRow(
                label: "验证码",
                controller: _codeNumberController,
                hintText: "请输入验证码",
                maxLength: 6,
                digitsOnly: true,
                trailing: FormCodeButton(title: _sendMessageTitle, enabled: _canGetCode, onTap: _sendCode),
              ),
            ],
          ),
          const FormGap(8),
          const FormHint("验证码将发送至新号码；修改成功后需要用新号码重新登录。"),
          const FormGap(24),
          FormPrimaryButton(title: "提交", onTap: _submit),
        ],
      ),
    );
  }
}
