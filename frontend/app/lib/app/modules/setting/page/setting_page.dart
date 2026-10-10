import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:app_installer/app_installer.dart';
import 'package:app_settings/app_settings.dart';
import 'package:auto_shop_server/app/routes/app_pages.dart';
import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/utils/app_version_update/app_version_manager.dart';
import 'package:auto_shop_server/app/utils/file_utils.dart';
import 'package:auto_shop_server/common/common_tools.dart';
import 'package:auto_shop_server/utils/error_log_utils.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import '../../../utils/common_widget/logger.dart';
import '../../../utils/global.dart';
import '../../../utils/sring_utils.dart';
import '../../../../common/widgets/divider_line_light.dart';
import '../../../../common/widgets/dot_widget.dart';
import '../../launching/loacal_storage.dart';
import '../../launching/request/launching_request.dart';
import '../controllers/update_dot_controller.dart';
import 'setting_cell.dart';

/// 设置页：通知与推送 / 应用 / 账号 三组，两端共用同一套条目。
class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  // static final GlobalKey<_SettingPageState> globalKey = GlobalKey();
  // SettingPage({globalKey});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> with WidgetsBindingObserver {
  // static final globalKey = GlobalKey<_SettingPageState>();

  String _cacheSize = '计算中…';
  String osVersion = '';

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
    WidgetsBinding.instance.addObserver(this);
    Get.lazyPut(() => UpdateDotController());
    updateDotController = Get.find<UpdateDotController>();

    _refreshCacheSize();
    _refreshNotificationState();

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
    WidgetsBinding.instance.removeObserver(this);
    _unbindBackgroundIsolate();
    super.dispose();
  }

  // 去系统设置改完权限回来，副标题要跟着更新
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refreshNotificationState();
  }

  void _unbindBackgroundIsolate() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
  }

  @pragma('vm:entry-point')
  static Future<void> downloadCallback(String id, int status, int progress) async {
    IsolateNameServer.lookupPortByName('downloader_send_port')?.send([id, status, progress]);
  }

  // 两端缓存目录不同，分别统计
  void _refreshCacheSize() {
    final future = Platform.isAndroid ? AppManager.findCacheSumSizeForAndroid() : AppManager.findCacheSumSize();
    future.then((size) {
      if (mounted) setState(() => _cacheSize = size);
    });
  }

  // 原来在 build 里调、异步赋值又没 setState，副标题会一直停在初始值
  Future<void> _refreshNotificationState() async {
    final version = await CommonTools.getOsVersion();
    final status = await Permission.notification.status;
    if (!mounted) return;
    setState(() {
      osVersion = version;
      isOpenNotification = status.isGranted ? "已开启" : "未开启";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const NavigatorTitle("设置"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
          onPressed: () => Get.back(),
        ),
      ),
      body: ListView(
        // 底部留出 Home Indicator 的间距
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 12.h + MediaQuery.paddingOf(context).bottom),
        children: [
          _buildGroup("通知与推送", [
            SettingCell(title: "消息推送设置", iconData: Icons.notifications_active_outlined, showArrow: true)
                .onTap(() => Get.toNamed(Routes.UMSETTINGPAGE)),
            SettingCell(
              title: "通知权限",
              iconData: Icons.notifications_none,
              showArrow: true,
              subTitle: isOpenNotification,
              subTitlePaddingR: 6.0,
            ).onTap(_openNotificationSettings),
          ]),
          SizedBox(height: 16.h),
          _buildGroup("应用", [
            SettingCell(
              title: "检测新版本",
              iconData: Icons.system_update_alt,
              showArrow: true,
              trailing: Obx(
                () => updateDotController.isHasUpdateInfo.value ? const DotWidget(textNumber: "1") : const SizedBox.shrink(),
              ),
            ).onTap(() => getVersionOrUpdateDialog(context)),
            SettingCell(
              title: "系统设置",
              iconData: Icons.settings_outlined,
              showArrow: true,
              subTitle: osVersion,
              subTitlePaddingR: 6.0,
            ).onTap(openSetting),
            SettingCell(title: "应用市场详情", iconData: Icons.storefront_outlined, showArrow: true)
                .onTap(() => AppVersionManager.openAndroidMarket()),
            SettingCell(title: "清除缓存", iconData: Icons.delete_outline, subTitle: _cacheSize).onTap(_confirmClearCache),
            SettingCell(title: "关于我们", iconData: Icons.info_outline, showArrow: true)
                .onTap(() => Get.toNamed(Routes.ABOUTMEPAGE)),
          ]),
          SizedBox(height: 16.h),
          _buildGroup("账号", [
            // SettingCell(title: '账户与安全', imageName: 'setting_clean.png', showArrow: true),
            SettingCell(title: "退出登录", iconData: Icons.logout, titleColor: TdColors.brand).onTap(_confirmSignOut),
          ]),
        ],
      ),
    );
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

  Future<void> _confirmClearCache() async {
    showAlertDialog(
      title: '温馨提示',
      message: '确定清除缓存吗？',
      confirm: () async {
        dismissAlertDialog();
        await AppManager.clearApplicationCache();
        _refreshCacheSize();
      },
    );
  }

  void _confirmSignOut() {
    showAlertDialog(
      title: '退出登录',
      message: '是否确认退出',
      confirm: () {
        dismissAlertDialog();
        AppManager.signOut();
      },
    );
  }

  // 跳系统的通知权限设置页
  Future<void> _openNotificationSettings() async {
    await AppSettings.openAppSettings(type: AppSettingsType.notification);
    if (mounted) _refreshNotificationState();
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
            await LaunchRequest.androidAppUpdateInfo();
          }
        }
        // 下载地址是空的
        //Logger.logMy("$logCatTag 首次安装");
      }
    }
    //------------------------------------------------------------------------------
  }
}
