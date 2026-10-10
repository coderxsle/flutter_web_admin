import 'package:app_settings/app_settings.dart';
import 'package:auto_shop_server/app/utils/common_widget/base_item.dart';
import 'package:auto_shop_server/app/utils/common_widget/build_row.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/app/modules/setting/controllers/um_setting_controller.dart';
import 'package:auto_shop_server/app/modules/setting/page/setting_cell.dart';
import 'package:auto_shop_server/common/widgets/divider_line_light.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//友盟消息推送设置页
class UmSettingPage extends GetView<UmSettingController> {
  const UmSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("消息设置"),
          leading: IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios, color: BGColor_white_255)),
        ),
        body: ListView(
          children: [
            ShapeRadiusContainer(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //处于顶部有一个高度
                    BuildRow2(icon: null, title: "处于APP未打开时", titleStyle: blackBoldStyle(), readOnly: true, firstRadius: true),
                    const DividerLineLight(height: 0.5),
                    //新消息系统通知
                    Obx(() {
                      return SettingCell(
                        title: "通知权限是否开启",
                        iconData: Icons.notification_important_sharp,
                        showArrow: true,
                        subTitle: controller.isOpenNotification.value,
                        subTitlePaddingR: 6.0, //
                      ).onTap(() {
                        controller.updateShow();
                      });
                    }),
                    //通知权限手动设置
                    const DividerLineLight(height: 0.5),
                    Obx((){
                     return SettingCell(
                        title: "通知权限手动设置",
                        //
                        iconData: Icons.handyman,
                        //
                        showArrow: true,
                        //
                        subTitle: controller.osVersion.value,
                        subTitlePaddingR: 6.0,
                      ).onTap(() {
                        //第二种跳转到通知权限设置页，每一步设置
                        AppSettings.openAppSettings(type: AppSettingsType.notification);
                      });
                    }),
                  ],
                )),
            ShapeRadiusContainer(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildRow2(
                      icon: null,
                      title: "处于APP未打开时",
                      titleStyle: blackBoldStyle(),
                      readOnly: true,
                      firstRadius: true,
                    ),
                    const DividerLineLight(height: 0.5),
                    //APP内横幅通知
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text("APP内横幅通知"),
                        ),
                        GetBuilder<UmSettingController>(
                          assignId: true,
                          builder: (logic) {
                            return CupertinoSwitch(
                              value: controller.valveNoticeSwitch,
                              trackColor: controller.valveNoticeSwitch ? Colors.grey[400] : null,
                              onChanged: (value) {
                                //Logger.logMy("value-APP内横幅通知-原始值-"+controller.valveNoticeSwitch.toString());
                                controller.updateNotice(value);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    //声音提醒
                    const DividerLineLight(height: 0.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text("声音提醒"),
                        ),
                        GetBuilder<UmSettingController>(
                          assignId: true,
                          builder: (logic) {
                            return CupertinoSwitch(
                              value: controller.valveSoundSwitch,
                              trackColor: controller.valveSoundSwitch ? Colors.grey[400] : null,
                              onChanged: (value) => {controller.updateSound(value)},
                            );
                          },
                        ),
                      ],
                    ),
                    //震动提醒
                    const DividerLineLight(height: 0.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text("震动提醒"),
                        ),
                        GetBuilder<UmSettingController>(
                          assignId: true,
                          builder: (logic) {
                            return CupertinoSwitch(
                              value: controller.valveShockSwitch,
                              trackColor: controller.valveShockSwitch ? Colors.grey[400] : null,
                              onChanged: (value) => {controller.updateShock(value)},
                            );
                          },
                        ),
                      ],
                    )
                    //午休免打扰
                  ],
                )),
            ShapeRadiusContainer(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //处于顶部有一个高度
                    BuildRow2(icon: null, title: "你希望午休时", titleStyle: blackBoldStyle(), readOnly: true, firstRadius: true),
                    const DividerLineLight(height: 0.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text("午休免打扰"),
                        ),
                        GetBuilder<UmSettingController>(
                          assignId: true,
                          builder: (logic) {
                            return CupertinoSwitch(
                              value: controller.valveMiddayRestSwitch,
                              trackColor: controller.valveMiddayRestSwitch ? Colors.grey[400] : null,
                              onChanged: (value) => {controller.updateMiddayRest(value)},
                            );
                          },
                        ),
                      ],
                    ),
                    const DividerLineLight(height: 0.5),
                    const Padding(
                      padding: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
                      child: Text("夜间时段已为您开启打扰，如您希望午休时段12:00至14:00暂停接收消息，可以开启午休免打扰"),
                    ),
                    //个性化推荐开关
                    const DividerLineLight(height: 0.5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text("个性化推荐开关"),
                        ),
                        GetBuilder<UmSettingController>(
                          assignId: true,
                          builder: (logic) {
                            return CupertinoSwitch(
                              value: controller.valvePersonAlizSwitch,
                              trackColor: controller.valvePersonAlizSwitch ? Colors.grey[400] : null,
                              onChanged: (value) => {controller.updatePersonAliz(value)},
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                )),

            //一个底部设置按钮
            buildSubmitButton(),
          ],
        ));
  }

  Widget buildSubmitButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 6),
      child: ElevatedButton(
        onPressed: () {
          controller.clearBadge();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('清空全部消息', style: whiteStyle()),
          ],
        ),
      ),
    );
  }
}
