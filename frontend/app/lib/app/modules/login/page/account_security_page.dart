import 'package:auto_shop_server/app/routes/app_pages.dart';
import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/divider_line_light.dart';
import '../../../utils/global.dart';
import '../../setting/page/setting_cell.dart';

/// 账号与安全：登录方式 / 账号注销 两组
class AccountSecurityPage extends StatelessWidget {
  const AccountSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const NavigatorTitle("账号与安全"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        // 底部留出 Home Indicator 的间距
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h + MediaQuery.paddingOf(context).bottom),
        children: [
          _buildGroup("登录方式", [
            SettingCell(
              title: "修改登录手机号",
              iconData: Icons.smartphone_outlined,
              showArrow: true,
              subTitle: _maskedPhone(AppManager.userAccount?.phone),
              subTitlePaddingR: 6.0,
            ).onTap(() => Get.toNamed(Routes.MODIFYPHONENUMBERPAGE)),
            const SettingCell(title: "修改登录密码", iconData: Icons.lock_outline, showArrow: true)
                .onTap(() => Get.toNamed(Routes.MODIFYPASSWORDPAGE)),
            // 没有绑定/解绑接口，这里只展示服务端下发的绑定状态，故不给箭头
            SettingCell(title: "微信绑定", iconData: Icons.chat_bubble_outline, subTitle: _wechatStatus),
          ]),
          SizedBox(height: 16.h),
          _buildGroup("账号注销", [
            SettingCell(
              title: "删除账号",
              iconData: Icons.delete_forever_outlined,
              bottomTitle: "删除所有数据，永久注销",
              titleColor: TdColors.brand,
              showArrow: true,
            ).onTap(() => Get.toNamed(Routes.DELETEACCOUNTPAGE)),
          ]),
          SizedBox(height: 16.h),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              "为保障账号安全，请勿向他人透露短信验证码及登录密码。",
              style: TextStyle(fontSize: 12, color: TdColors.grey85, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  /// 手机号脱敏；账号在退出登录/冷启动后可能为空，这里不能再用 !
  String _maskedPhone(String? phone) {
    if (phone == null || phone.isEmpty) return "未绑定";
    return phone.length == 11 ? phone.desensitized : phone;
  }

  /// 微信绑定状态，取服务端下发的 openId 与昵称
  String get _wechatStatus {
    final account = AppManager.userAccount;
    if (account == null || (account.wxUserOpenId ?? '').isEmpty) return "未绑定";
    final wxName = account.wxName ?? '';
    return wxName.isEmpty ? "已绑定" : "已绑定（$wxName）";
  }

  /// 一组设置项：组标题 + 白底圆角卡片
  Widget _buildGroup(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
          child: Text(title, style: const TextStyle(fontSize: 13, color: TdColors.grey85)),
        ),
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(color: TdColors.white, borderRadius: BorderRadius.circular(8)),
          child: Column(
            children: [
              for (int i = 0; i < items.length; i++) ...[
                if (i > 0) const DividerLineLight(height: 0.5),
                items[i],
              ],
            ],
          ),
        ),
      ],
    );
  }
}
