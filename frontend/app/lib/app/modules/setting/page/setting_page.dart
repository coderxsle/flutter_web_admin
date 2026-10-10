import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:app_installer/app_installer.dart';
import 'package:app_settings/app_settings.dart';
import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/utils/app_version_update/app_version_manager.dart';
import 'package:auto_shop_server/app/utils/file_utils.dart';
import 'package:auto_shop_server/common/common_tools.dart';
import 'package:auto_shop_server/utils/error_log_utils.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../../utils/common_widget/logger.dart';
import '../../../utils/global.dart';
import '../../../utils/sring_utils.dart';
import '../../launching/loacal_storage.dart';
import '../../launching/request/launching_request.dart';
import 'setting_cell.dart';
import '../../../../common/widgets/dot_widget.dart';
import '../controllers/update_dot_controller.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  // static final GlobalKey<_SettingPageState> globalKey = GlobalKey();
  // SettingPage({globalKey});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // static final globalKey = GlobalKey<_SettingPageState>();

  String _cacheSize = '0.0';
  String osVersion = '0.0';

  ProgressDialog? progressDialogAndroid;

  //下载任务id
  String? taskIdMy;

  //监听下载任务，只能放在外部
  ReceivePort portMy = ReceivePort();

  //是否开启权限通知
  String isOpenNotification = "";

  late UpdateDotController updateDotController;

  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => UpdateDotController());
    updateDotController = Get.find<UpdateDotController>();

    if (Platform.isIOS) getCacheSize();
    if (Platform.isAndroid) getCacheSizeForAndroid();

    if (Platform.isAndroid) {
      FlutterDownloader.registerCallback(downloadCallback, step: 10);

      progressDialogAndroid = ProgressDialog(context: context);
      final isSuccess = IsolateNameServer.registerPortWithName(portMy.sendPort, "downloader_send_port");
      //Logger.logMy("$logCatTag isSuccess 注册状态 外部--：${isSuccess.toString()}");
      if (!isSuccess) {
        _unbindBackgroundIsolate();
        return;
      }

      portMy.listen((dynamic data) async {
        //如果用到就取，用不到暂屏蔽
        //final taskId = (data as List<dynamic>)[0] as String;
        final status = DownloadTaskStatus.fromInt(data[1] as int);
        final progress = data[2] as int;

        setState(() {
          //Logger.logMy("$logCatTag setState progress 更新进度条 外部：${progress.toString()}");
          progressDialogAndroid?.update(value: progress);
        });

        if (status == DownloadTaskStatus.complete) {
          //Logger.logMy("状态是下载完成--complete");
          String downLoadPath = await FileUtilsMy.getDownLoadDirPath();
          String completePath = await FileUtilsMy.getCompleteDirPath();

          if (box.hasData(keyApkName)) {
            String? apkNameLong = localStorageRead<String>("apkName");
            String? apkNameShort = StringUtils.splitApkNameWithDateTime(apkNameLong.toString() ?? "");
            if (!ObjectUtil.isEmptyString(apkNameShort)) {
              //logger.d("执行短名称拷贝apkNameShort-->$apkNameShort");
              FileUtilsMy.copyFile("$downLoadPath/$apkNameLong", "$completePath/$apkNameShort");
            } else {
              String? downLoadUrlCurr = localStorageRead<String>(app_update_android_download_url);
              String? apkShortName = StringUtils.splitPathName(downLoadUrlCurr ?? "");
              if (!ObjectUtil.isEmptyString(downLoadUrlCurr)) {
                //logger.d("走到取出downLoadUrlCurr之中的短名称");
                FileUtilsMy.copyFile("$downLoadPath/$apkNameLong", "$completePath/$apkShortName"); ////
              }
            }
            //Logger.logMy("查找路径是->$stringBuffer");
            // final res = await InstallPlugin.install(stringBuffer.toString());
            try {
              AppInstaller.installApk("$downLoadPath/$apkNameLong");
            } on Exception catch (e) {
              if (!ObjectUtil.isEmpty(e)) {
                logger.w(" catch Exception =>${e.toString()}");
                ErrorLogUtils.addLogSingle(fun: "AppInstaller.installApk", error: "安装apk失败");
              }
            }
          } else {
            LoggerTool.logMy("没有下载路径，无法安装");
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _unbindBackgroundIsolate();
    super.dispose();
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @pragma('vm:entry-point')
  static Future<void> downloadCallback(String id, int status, int progress) async {
    IsolateNameServer.lookupPortByName('downloader_send_port')?.send([id, status, progress]);
  }

  getCacheSize() {
    AppManager.findCacheSumSize().then((size) {
      setState(() {
        _cacheSize = size;
      });
    });
  }

  getCacheSizeForAndroid() {
    AppManager.findCacheSumSizeForAndroid().then((size) {
      setState(() {
        _cacheSize = size;
      });
    });
  }

  getOsVersion() async {
    await CommonTools.getOsVersion(context).then((version) {
      // Logger.logMy("版本信息=$version");
      osVersion = version;
    });

    var status = await Permission.notification.status;
    if (status.isGranted) {
      isOpenNotification = "已开启";
    } else {
      isOpenNotification = "未开启";
    }
  }

  @override
  Widget build(BuildContext context) {
    getOsVersion();
    return Scaffold(
        appBar: AppBar(
          title: const NavigatorTitle("设置"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: BGColor_white_255),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Stack(
          children: [
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  buildAndroidView(context),
                  // SettingCell(title: '账户与安全', imageName: 'setting_clean.png', showArrow: true),
                  SettingCell(title: '清除缓存', iconData: Icons.delete_forever, subTitle: _cacheSize).onTap(() async {
                    showDialog(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return CupertinoAlertDialog(
                          title: const Text('温馨提示', style: TextStyle(fontSize: 17)),
                          content: Container(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                            child: const Text(
                              "确定清除缓存吗？",
                            ),
                          ),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: const Text(
                                '取消',
                                style: TextStyle(color: Color.fromRGBO(215, 85, 82, 1)),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            CupertinoDialogAction(
                              child: const Text('确定'),
                              onPressed: () async {
                                Get.back();
                                await AppManager.clearApplicationCache();
                                if (Platform.isIOS) getCacheSize();
                                if (Platform.isAndroid) getCacheSizeForAndroid();
                              },
                            )
                          ],
                        );
                      },
                    );
                  }),

                  const SizedBox(height: 1),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      debugPrint("关于我们");
                      Get.toNamed("/AboutMePage");
                    },
                    child: const SettingCell(title: '关于我们', iconData: Icons.home),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      showDialog(
                        context: context,
                        barrierDismissible: false, // user must tap button!
                        builder: (BuildContext context) {
                          return CupertinoAlertDialog(
                            title: const Text('退出登录', style: TextStyle(fontSize: 17)),
                            content: Container(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                              //padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: const Text(
                                "是否确认退出",
                              ),
                            ),
                            actions: <Widget>[
                              CupertinoDialogAction(
                                child: const Text(
                                  '取消',
                                  style: TextStyle(color: Color.fromRGBO(215, 85, 82, 1)),
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                              ),
                              CupertinoDialogAction(
                                child: const Text('确定'),
                                onPressed: () async {
                                  // ref.read(cartState.notifier).state = null;
                                  AppManager.signOut();
                                },
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: Container(
                      // height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      margin: const EdgeInsets.fromLTRB(20, 15, 20, 10),
                      child: const Text("退出登录", style: TextStyle(fontSize: 15)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  //仅仅只有安卓的布局
  buildAndroidView(BuildContext context) {
    if (Platform.isAndroid) {
      Widget widget = Column(
        children: [
          const SettingCell(
            title: "消息推送设置",
            iconData: Icons.unsubscribe,
          ).onTap(() {
            //一个新页面，关闭友盟消息推送
            Get.toNamed("/UmSettingPage");
          }),
          const SizedBox(height: 1),
          Stack(alignment: Alignment.center, children: <Widget>[
            SettingCell(
              title: "检测新版本",
              iconData: Icons.browser_updated,
            ).onTap(
              () => getVersionOrUpdateDialog(context),
            ),
            Positioned(
                top: 12.0,
                right: 10.0,
                child: GetBuilder<UpdateDotController>(
                  assignId: true,
                  builder: (logic) {
                    return Visibility(
                      visible: updateDotController.isHasUpdateInfo.value,
                      // visible: false,
                      child: DotWidget(
                        textNumber: '1',
                      ),
                    );
                  },
                )),
          ]),
          const SizedBox(height: 1),
          const SettingCell(title: "系统设置", iconData: Icons.settings, showArrow: true).onTap(() {
            openSetting();
          }),
          const SizedBox(height: 1),
          const SettingCell(title: "应用市场详情", iconData: Icons.storefront, showArrow: true).onTap(() {
            AppVersionManager.openAndroidMarket();
          }),
          const SizedBox(height: 1),
          SettingCell(
            title: "通知权限手动设置",
            iconData: Icons.handyman,
            showArrow: true,
            subTitle: osVersion,
            subTitlePaddingR: 6.0,
          ).onTap(() {
            //第二种跳转到通知权限设置页，每一步设置
            AppSettings.openAppSettings(type: AppSettingsType.notification);
          }),
          const SizedBox(height: 1),
          SettingCell(
            title: "通知权限是否开启",
            iconData: Icons.notification_important_sharp,
            showArrow: true,
            subTitle: isOpenNotification,
            subTitlePaddingR: 6.0,
          ).onTap(() async {
            var status = await Permission.notification.status;
            if (status == PermissionStatus.granted) {
              setState(() {
                isOpenNotification = "已开启";
              });
              showMessageBottomLikeAndroid("通知权限已开启~", isLong: true);
            } else {
              setState(() {
                isOpenNotification = "未开启";
              });
              showMessageBottomLikeAndroid("通知权限未开启，请打开系统设置", isLong: true);
            }
          }),
          const SizedBox(height: 1),
          // SettingCell(
          //   title: "设置通知声音", //
          //   iconData: Icons.notification_important_sharp, //
          //   showArrow: true, //
          //   subTitle: isOpenNotification, //
          //   subTitlePaddingR: 6.0, //
          // ).onTap(() async {
          //   AppSettings.openAppSettings(type: AppSettingsType.sound);
          // }),
        ],
      );
      return widget;
    } else {
      return const SizedBox.shrink();
    }
  }

  //打开系统设置
  Future<void> openSetting() async {
    try {
      // do
      openAppSettings();
    } catch (e) {
      //Logger.logMy("$logCatTag openAppSettings：${openAppSettings.toString()}");
      logger.i("$logCatTag catch：${e.toString()}");
    }
  }

  void getVersionOrUpdateDialog(BuildContext context) async {
    //------------------------------------------------------------------------------
    if (Platform.isAndroid) {
      //如果是非首次安装，要检测一次；
      if (box.hasData(app_update_android_download_url)) {
        String? downLoadUrlCurr = localStorageRead<String>(app_update_android_download_url);
        // Logger.logMy("$logCatTag downLoadUrl：${downLoadUrlCurr.toString()}");

        if (downLoadUrlCurr is String) {
          if (!StringUtils.isNullOrEmpty(downLoadUrlCurr)) {
            PackageInfo packageInfo = await PackageInfo.fromPlatform();
            //String buildNumber = packageInfo.buildNumber;
            String serviceVersion = CommonTools.getServiceVersionCode(downLoadUrlCurr);
            // Logger.logMy("$logCatTag serviceVersion：${serviceVersion.toString()}");
            if (!StringUtils.isNullOrEmpty(serviceVersion)) {
              if (int.parse(packageInfo.buildNumber) < int.parse(serviceVersion)) {
                await Future.delayed(const Duration(seconds: 1));
                if (context.mounted) {
                  progressDialogAndroid = ProgressDialog(context: context);
                  CommonTools.showUpdateDialogAndroid(mContext: context, downLoadUrlCurr: downLoadUrlCurr, newVersion: serviceVersion, progressDialogAndroid: progressDialogAndroid!);
                }
              } else {
                showAlertDialogSingleNoMessageNoButton(message: "当前是最新版本");
                await Future.delayed(const Duration(seconds: 1));
                SmartDialog.dismiss();
              }
            } else {
              // Logger.logMy("$logCatTag 没有存储升级的下载链接信息}");
              //那么需要重新调用一次接口响应
              final info = await LaunchRequest.androidAppUpdateInfo();
            }
          }
          // 下载地址是空的
          //Logger.logMy("$logCatTag 首次安装");
        }
      }
    }
    //------------------------------------------------------------------------------
  }
}
