import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/global.dart';
import '../../setting/page/setting_cell.dart';


class AccountSecurityPage extends StatefulWidget {
  const AccountSecurityPage({super.key});

  @override
  State<AccountSecurityPage> createState() => _AccountSecurityPageState();
}

class _AccountSecurityPageState extends State<AccountSecurityPage> {

  late String phone;

  @override
  void initState() {
    super.initState();

    phone = AppManager.userAccount!.phone!.replaceFirst(RegExp(r'\d{4}'), '****', 3);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const NavigatorTitle("账号与安全"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: BGColor_white_255),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Stack(
          children: [
            // 列表
            ListView(
              children: [
                const SizedBox(height: 20),
                SettingCell(title: '修改登录手机号', subTitle: phone, showArrow: true).onTap((){
                  Get.toNamed("/ModifyPhoneNumberPage");
                }),

                dividerLine(left: 20),

                const SettingCell(title: '修改登录密码', showArrow: true).onTap((){
                  Get.toNamed("/ModifyPasswordPage");
                }),

                dividerLine(left: 20),

                const SizedBox(height: 10),
                const SettingCell(title: '删除账号', bottomTitle: "删除所有数据，永久注销", showArrow: true).onTap(() {
                  Get.toNamed("/DeleteAccountPage");
                }),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
    );
  }


}

