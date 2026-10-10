import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/modules/login/model/user_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_manager/result_analyzed.dart';

import '../../../utils/global.dart';
import '../../../utils/result_code.dart';
import '../request/mine_request.dart';

enum UpdateType { nickname, truename, occupation }

class ModifyUserInfoPage extends StatefulWidget {
  const ModifyUserInfoPage({super.key});
  @override
  State<ModifyUserInfoPage> createState() => _ModifyUserInfoPageState();
}

class _ModifyUserInfoPageState extends State<ModifyUserInfoPage> {
  String _value = "";

  @override
  void initState() {
    super.initState();
  }

  Future _updateCustomerInfo(Map<String, dynamic> param) async {
    showLoadingMessage("正在提交");
    ResponseAnalyzed result = await modifyUserInfo(param);
    dismissLoading();
    if (result.code == ResultCode.success) {
      UserAccount? account = AppManager.userAccount;
      switch (Get.arguments) {
          case UpdateType.nickname:
            account?.nickName = _value;
            break;
          case UpdateType.truename:
            account?.trueName = _value;
            break;
          case UpdateType.occupation:
            account?.occupation = _value;
            break;
          default:
        }
      AppManager.userAccount = account;
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    String title = '';
    String placeholder = '';
    switch (Get.arguments) {
      case UpdateType.nickname:
        title = '设置昵称';
        placeholder = '请输入昵称';
        break;
      case UpdateType.truename:
        title = '设置姓名';
        placeholder = '请输入姓名';
        break;
      case UpdateType.occupation:
        title = '设置职业';
        placeholder = '请输入职业';
        break;
      default:
    }
    return Scaffold(
      appBar: AppBar(
          title: Text(title),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0,
          actions: [
            TextButton(
                onPressed: () {

                  if (_value.isEmpty) {
                    showMessage('内容不能为空');
                    return;
                  }

                  Map<String, dynamic> param = {
                    'customerId' : AppManager.userAccount!.customerId!,
                  };

                  switch (Get.arguments) {
                    case UpdateType.nickname:
                      param["nickName"] = _value;
                      break;

                    case UpdateType.truename:
                      param["trueName"] = _value;
                      break;

                    case UpdateType.occupation:
                      param["occupation"] = _value;
                      break;
                    default:
                  }

                  _updateCustomerInfo(param);

                },
                child: const Text('保存', style: TextStyle(color: Colors.white, fontSize: 16)))
          ]),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 20.0, right: 15.0),
        child: TextField(
          onChanged: (value) {
            _value = value;
          },
          autofocus: true,
          decoration: InputDecoration(hintText: placeholder),
        ),
      ),
    );
  }
}


