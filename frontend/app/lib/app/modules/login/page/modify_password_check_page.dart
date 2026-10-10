import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/global.dart';
import '../widget/account_form.dart';

/// 验证手机号后修改登录密码。
/// 注意：这条链路目前没有入口（全项目无 Get.toNamed(ModifySignPasswordCheckPage)），
/// 且短信接口未开放，保留页面结构以备接入，不参与现有跳转。
class ModifyPasswordCheckPage extends StatefulWidget {
  const ModifyPasswordCheckPage({super.key});

  @override
  State<ModifyPasswordCheckPage> createState() => _ModifyPasswordCheckPageState();
}

class _ModifyPasswordCheckPageState extends State<ModifyPasswordCheckPage> {
  //手机号码
  final TextEditingController _phoneController = TextEditingController();
  //验证码
  final TextEditingController _codeController = TextEditingController();
  // 可以获取验证码
  bool _canGetCode = false;

  //短信验证码按钮标题
  String _sendMessageTitle = '获取验证码';
  Timer? _timer;
  int _countdownTime = 0;

  void _refreshCanGetCode() {
    setState(() {
      _canGetCode = _phoneController.text.length == 11 && _countdownTime == 0;
    });
  }

  void _submit() {
    if (_codeController.text.isEmpty) {
      showMessage("请输入验证码");
      return;
    }
    // AuthV1CustomerModifyPhoneForAppHttp();
  }

  void _sendCode() {
    FocusScope.of(context).requestFocus(FocusNode());
    // 短信接口未开放，接入后在此处调用
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
        _canGetCode = _phoneController.text.length == 11 && _countdownTime == 0;
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
        title: const NavigatorTitle("修改登录密码"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: FormScrollBody(
        children: [
          const FormGroupTitle("验证手机号"),
          FormCard(
            children: [
              FormInputRow(
                label: "手机号",
                controller: _phoneController,
                hintText: "请输入手机号",
                maxLength: 11,
                digitsOnly: true,
                onChanged: (_) => _refreshCanGetCode(),
              ),
              FormInputRow(
                label: "验证码",
                controller: _codeController,
                hintText: "请输入验证码",
                maxLength: 6,
                digitsOnly: true,
                trailing: FormCodeButton(title: _sendMessageTitle, enabled: _canGetCode, onTap: _sendCode),
              ),
            ],
          ),
          const FormGap(8),
          const FormHint("验证通过后即可设置新的登录密码。"),
          const FormGap(24),
          FormPrimaryButton(title: "去修改", onTap: _submit),
        ],
      ),
    );
  }
}
