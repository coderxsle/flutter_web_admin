import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_manager/result_analyzed.dart';

import '../../../utils/global.dart';
import '../../../utils/result_code.dart';
import '../../mine/request/mine_request.dart';
import '../widget/account_form.dart';

/// 修改登录密码：旧密码 → 新密码 → 确认新密码（修改成功后退出登录）
class ModifyPasswordPage extends StatefulWidget {
  const ModifyPasswordPage({super.key});

  @override
  State<ModifyPasswordPage> createState() => _ModifyPasswordPageState();
}

class _ModifyPasswordPageState extends State<ModifyPasswordPage> {
  final _oldC = TextEditingController();
  final _newC = TextEditingController();
  final _affirmC = TextEditingController();

  Future _changeFunc() async {
    if (_oldC.text.isEmpty) {
      showMessage('旧密码不能为空~');
      return;
    }
    if (_newC.text.isEmpty) {
      showMessage('新密码不能为空~');
      return;
    }
    if (_affirmC.text.isEmpty) {
      showMessage('确认密码不能为空~');
      return;
    }
    if (_newC.text.length < 8) {
      showMessage('新密码不得少于8位！');
      return;
    }
    if (_newC.text != _affirmC.text) {
      showMessage('两次密码输入不一致！');
      return;
    }

    showLoadingMessage("正在提交...");
    ResponseAnalyzed value = await validatePassword(_oldC.text);
    if (value.code == ResultCode.success) {
      ResponseAnalyzed result = await modifyPassword(_oldC.text, _newC.text, _affirmC.text);
      dismissLoading();
      if (result.code == ResultCode.success) {
        showMessage("密码修改成功");
        AppManager.signOut();
      }
      return;
    }
    dismissLoading();
  }

  @override
  void dispose() {
    _oldC.dispose();
    _newC.dispose();
    _affirmC.dispose();
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
          const FormGroupTitle("登录密码"),
          FormCard(
            children: [
              FormInputRow(label: "旧密码", controller: _oldC, hintText: "请填写旧密码", password: true, maxLength: 16),
              FormInputRow(label: "新密码", controller: _newC, hintText: "请输入新密码", password: true, maxLength: 16),
              FormInputRow(label: "确认密码", controller: _affirmC, hintText: "请再次输入新密码", password: true, maxLength: 16),
            ],
          ),
          const FormGap(8),
          const FormHint("密码必须是 8-16 位英文字母、数字、字符组合，不能是纯数字。"),
          const FormGap(24),
          FormPrimaryButton(title: "确认修改", onTap: _changeFunc),
        ],
      ),
    );
  }
}
