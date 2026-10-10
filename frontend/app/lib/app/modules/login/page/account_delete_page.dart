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

/// 删除账号（注销）：短信验证码校验后注销，注销成功即退出登录
class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {
  //验证码
  final TextEditingController _codeNumberController = TextEditingController();

  //短信验证码按钮标题
  String _sendMessageTitle = '获取验证码';
  Timer? _timer;
  int _countdownTime = 0;

  /// 手机号脱敏；账号可能已被清空（退出登录/被踢下线），这里不能再用 !
  String get _maskedPhone {
    final phone = AppManager.userAccount?.phone ?? '';
    if (phone.isEmpty) return "未绑定";
    return phone.length == 11 ? phone.desensitized : phone;
  }

  /// 提交删除账号
  Future _authV1CustomerCancelCustomerHttp() async {
    String code = _codeNumberController.text;
    ResponseAnalyzed result = await AuthV1CustomerCancelCustomerHttp(uuid: AppManager.uuid, verificationCode: code);
    if (result.code == ResultCode.success) {
      /// 注销成功后需要退出当前的登录状态
      AppManager.signOut();
    }
  }

  void _submit() {
    if (_codeNumberController.text.isEmpty) {
      showMessage("请输入验证码");
      return;
    }
    _authV1CustomerCancelCustomerHttp();
  }

  /// 获取验证码：短信接口尚未开放，接入后在此处调用
  void _sendCode() {
    FocusScope.of(context).requestFocus(FocusNode());
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
        title: const NavigatorTitle("删除账号"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: FormScrollBody(
        children: [
          const FormWarnBanner("注销账号并删除该账号的所有数据，注销成功后将无法登录，请谨慎操作。"),
          const FormGap(16),
          const FormGroupTitle("当前账号"),
          FormCard(children: [FormInfoRow(label: "手机号", value: _maskedPhone)]),
          const FormGap(16),
          const FormGroupTitle("身份验证"),
          FormCard(
            children: [
              FormInputRow(
                label: "验证码",
                controller: _codeNumberController,
                hintText: "请输入验证码",
                maxLength: 6,
                digitsOnly: true,
                trailing: FormCodeButton(
                  title: _sendMessageTitle,
                  enabled: _maskedPhone != "未绑定",
                  onTap: _sendCode,
                ),
              ),
            ],
          ),
          const FormGap(24),
          FormPrimaryButton(title: "确认删除", onTap: _submit),
        ],
      ),
    );
  }
}
