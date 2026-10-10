import 'dart:convert';
import 'dart:io';

import 'package:app_installer/app_installer.dart';
import 'package:auto_shop_server/app/utils/common_widget/base_controller.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/app/utils/sring_utils.dart';
import 'package:auto_shop_server/app/utils/storage_utils.dart';
import 'package:auto_shop_server/app/modules/launching/loacal_storage.dart';
import 'package:auto_shop_server/utils/error_log_utils.dart';
import 'package:auto_shop_server/common/widgets/divider_line_light.dart';
import 'package:common_utils/common_utils.dart';
import 'package:decimal/decimal.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:http_manager/result_analyzed.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';

import 'package:auto_shop_server/base/common_request.dart';
import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/utils/app_version_update/app_version_manager.dart';
import 'package:auto_shop_server/app/utils/common_widget/logger.dart';
import 'package:auto_shop_server/app/utils/constant_api.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/app/utils/file_utils.dart';

//取消下载的方法
// typedef CancelDownLoadCallback = void Function();
class CommonTools {
  CommonTools._privateConstructor();

  //---------------------------------------------------------------------------------------

  //通用的列表按钮传递携带类型的对象
  /*static Widget buttonWidthType(ButtonType buttonType,
          {Color? textColor, //
          Color? boxBackgroundColor, //
          Color? boxBorderColor, //
          double? heightMy,
          double? paddingLMy,
          double? paddingRMy,
          GestureTapCallback? onPressed}) =>
      GestureDetector(
        onTap: onPressed,
        child: Container(
          height: heightMy ?? button_height_26,
          padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(paddingLMy ?? 10.0, 0, paddingRMy ?? 10, 0),
            decoration: BoxDecoration(
              color: boxBackgroundColor??TdColors.brand,
              border: Border.all(color: boxBorderColor ?? Colors.transparent), //边框色如果没有就透明
              borderRadius: BorderRadius.circular(17.5),
            ),
            //第一种不传递默认是白色
            child: Text(buttonType.functionName!.toString(), style: TextStyle(color: textColor??Colors.white, fontSize: 14)),
            //第二种直接写固定是白色
            // child: Text(buttonType.functionName!.toString(), style: const TextStyle(color: Colors.white, fontSize: 14)),
          ),
        ),
      );*/

  static Widget createButtonMy(String name,
          {Color? textColor, //
          Color? boxBackgroundColor, //
          Color? boxBorderColor, //
          double? heightMy,
          double? paddingLMy,
          double? paddingRMy,
          GestureTapCallback? onPressed}) =>
      GestureDetector(
        onTap: onPressed,
        child: Container(
          height: heightMy ?? button_height_26,
          padding: const EdgeInsets.fromLTRB(0, 0, 3, 0),
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(paddingLMy ?? 10.0, 0, paddingRMy ?? 10, 0),
            decoration: BoxDecoration(
              color: boxBackgroundColor,
              border: Border.all(color: boxBorderColor ?? Colors.transparent), //边框色如果没有就透明
              borderRadius: BorderRadius.circular(17.5),
            ),
            child: Text(name, style: TextStyle(color: textColor, fontSize: 14)),
          ),
        ),
      );

  static showBottomOneSelectMy(
      String? selectTitle, //
      String? imageKey, //
      String? titleKey, //
      String? subTitleKey, //
      {required List keyValues,
      required Function(dynamic) callback}) {
    Get.bottomSheet(
      StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
        List<Widget> list = [];
        var img = "";
        var title = "";
        var subTitle = "";
        for (var index = 0; index < keyValues.length; index++) {
          if (keyValues[index].keys.contains(imageKey)) {
            img = keyValues[index][imageKey];
          }
          if (keyValues[index].keys.contains(titleKey)) {
            title = keyValues[index][titleKey];
          }
          if (keyValues[index].keys.contains(subTitleKey)) {
            subTitle = keyValues[index][subTitleKey];
          }

          list.add(
            GestureDetector(
              onTap: () => callback(index),
              child: Column(
                children: [
                  Container(
                    height: dialogItemClick35,
                    color: Colors.white,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (img.isNotEmpty && img.startsWith(httpStartWithPrefix)) //http
                              imageNetwork(
                                img,
                                width: 35,
                                height: 35,
                                fit: BoxFit.fitHeight,
                              ),
                            Text(title, style: blackStyle()),
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Offstage(
                          offstage: !subTitle.isNotEmpty,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(subTitle, style: greyStyle(font: 14)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const DividerLineLight(left: 1, right: 1)
                  // if(list.isNotEmpty){
                  //  retrun dividerLineLight(left: 1, right: 1);
                  // }else{
                  //   return SizedBox.shrink();
                  // }
                ],
              ),
            ),
          );
        }
        return Container(
          height: 600,
          color: TdColors.pageBg,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Column(
            children: [
              Container(
                color: TdColors.pageBg,
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(selectTitle ?? "请选择", textAlign: TextAlign.center, style: const TextStyle(fontSize: 15)),
                  ],
                ),
              ),
              Expanded(child: ListView(padding: const EdgeInsets.fromLTRB(0, 0, 0, 30), children: list)),
            ],
          ),
        );
      }),
    );
  }

  //请求本地文件夹的权限
  // static Future<void> requestStoragePermission() async {
  //   var status = await Permission.storage.request();
  //   if (status.isGranted) {
  //     Logger.logMy("$logCatTag 存储权限requestStoragePermission：Storage permission granted.");
  //   } else if (status.isPermanentlyDenied) {
  //     // 如果用户永久拒绝了权限，你可以提示他们去设置页面手动开启权限
  //     openAppSettings();
  //   } else if (status.isDenied) {
  //     //requestStoragePermission();
  //     showMessageBottomLikeAndroid("用户读写权限被拒绝");
  //     //权限被拒绝
  //     Logger.logMy("$logCatTag 存储权限requestStoragePermission：Storage permission denied.");
  //   }
  // }

  //获取服务端的版本号
  static String getServiceVersionCode(String downLoadUrlCurrent) {
    if (!StringUtils.isNullOrEmpty(downLoadUrlCurrent)) {
      String downLoadUrlCurrentInterception = StringUtils.splitPathName(downLoadUrlCurrent);
      //Logger.logMy("$logCatTag downLoadUrlCurrentInterception：${downLoadUrlCurrentInterception.toString()}");
      //应用名35.apk

      List<String> fileNameArray = [];

      if (!StringUtils.isNullOrEmpty(downLoadUrlCurrentInterception)) {
        fileNameArray = downLoadUrlCurrentInterception.split(".");
        //Logger.logMy("$logCatTag fileNameArray：${fileNameArray.toString()}");

        String serviceNumber = fileNameArray[0].substring(AppName.length);
        //Logger.logMy("$logCatTag serviceNumber：${serviceNumber.toString()}");

        return serviceNumber;
      }
    } else {
      return "";
    }

    return "";
  }

  //android的权限提示
  static showDialogPermissionAndroidSingle(
      {required String messageSingle, //
      required Permission permissionSingle, //
      required VoidCallback grantedSingle}) {
    showAlertDialog(
      title: permission_title_single,
      //message: "检测到新版本",
      margin: const EdgeInsets.only(left: 20, right: 20),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: messageSingle,
                  style: const TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
                ),
              ]),
            ),
          ),
        ],
      ),
      confirmText: permission_setting,
      cancelText: permission_cancel,
      buttonVertical: false,
      confirm: () async {
        dismissAlertDialog();
        requestPermissionAndroidSingle(permission: permissionSingle, message: messageSingle, callbackGranted: grantedSingle);
        //TODO 2024/8/24 请求多个权限
      },
      cancel: () {
        dismissAlertDialog();
      },
    );
  }

  //多权限申请
  // static showDialogPermissionAndroidList(List<Permission> permissions, //
  //     {required String messageToUser, //
  //     required VoidCallback doGranted, //
  //     required VoidCallback doDenied}) {
  static showDialogPermissionAndroidList({required List<Permission> permissions, required String messageToUser, required VoidCallback doGranted}) {
    showAlertDialog(
      title: permission_title_list,
      margin: const EdgeInsets.only(left: 20, right: 20),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: messageToUser,
                  style: const TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
                ),
              ]),
            ),
          ),
        ],
      ),
      confirmText: permission_setting,
      cancelText: permission_cancel,
      buttonVertical: false,
      confirm: () async {
        requestPermissionAndroidList(permissions, messageToUser, doGranted);
        dismissAlertDialog();
      },
      cancel: () {
        dismissAlertDialog();
      },
    );
  }

  //android端请求权限的提示:请求单个的权限
  static requestPermissionAndroidSingle(
      {required Permission permission, //
      required String message, //
      required VoidCallback callbackGranted,
      VoidCallback? callbackDenied}) async {
    //这个怎么用，有待研究？
    //bool isShown = await Permission.storage.shouldShowRequestRationale;
    var status = await permission.status;

    if (status.isGranted) {
      LoggerTool.logMy("$logCatTag 权限被授予");
      //权限授予,权限通过
      // if (isShown) {
      //权限被拒绝，但是可以再次请求
      // 2024/8/23 提示用户再次申请权限
      callbackGranted();
      // } else {
      //权限被拒绝，并且不能再次请求
      // 2024/8/23 提示用户再次申请权限
      // }
    } else if (status.isDenied) {
      //权限被拒绝，但是可以再次请求
      LoggerTool.logMy("$logCatTag 权限被拒绝，但可以再次请求。其实也即是：用户拒绝了权限请求");

      //showDialogPermissionAndroidSingle(messageSingle: message, permissionSingle: permission, grantedSingle: callbackGranted);
      // await permission.request().then((value) {
      //   if (value.isGranted) {
      //     //权限通过
      //     callbackGranted();
      //   } else {
      //     //权限被拒绝
      //     // showDialogPermissionAndroidSingle(
      //     //   messageSingle: message, //
      //     //   permissionSingle: permission, //
      //     //   grantedSingle: callbackGranted, //
      //     // );
      //   }
      // });

      await permission.onGrantedCallback(() {
        callbackGranted();
      }).onDeniedCallback(() {
        showMessageBottomLikeAndroid("${permission.toString()}:$permission_open_setting", isLong: false);
        openAppSettings();
      }).request();
      // showPermissionRequestDialog('您拒绝了申请权限，但是该应用需要该权限，继续吗', permission, false);
    } else if (status.isRestricted) {
      //系统限制了访问权限。
      LoggerTool.logMy("$logCatTag 系统限制了访问权限");

      openAppSettings();
    } else if (status.isLimited) {
      //临时权限授予
      LoggerTool.logMy("$logCatTag 临时权限授予");
      //TODO 2024/8/24 临时授予权限，怎么处理？
      openAppSettings();
    } else if (status.isPermanentlyDenied) {
      //权限被永久拒绝，只能通过系统设置更改。
      LoggerTool.logMy("$logCatTag 权限被永久拒绝，只能通过系统设置更改");
      openAppSettings();

      // openAppSettings();
    } else {
      LoggerTool.logMy("$logCatTag 过滤到权限之外,那么再次申请}");
      //requestPermission(permission);
      //showDialogPermissionAndroidSingle(messageToUser, permission);
    }
  }

  //请求对应的单个权限，需要打开系统设置
  // static void _requestPermissionSingle(Permission permission) async {
  //   //发起权限申请
  //   PermissionStatus status = await permission.request();
  //   // 返回权限申请的状态 status
  //   Logger.logMy("$logCatTag 单个权限申请_权限状态：${status.toString()}");
  //
  //   if (status.isPermanentlyDenied) {
  //     showMessageBottomLikeAndroid(permanentlyDenied);
  //     openAppSettings();
  //   }
  // }

  ///检查权限
  static void requestPermissionAndroidList(
      List<Permission> permissionList,
      String message, //
      VoidCallback callbackGranted, //所有的都同意
      {VoidCallback? callbackDenied}) async {
    bool flag = true;
    Permission? permissionCurrent;

    for (var permissionElement in permissionList) {
      var status = await permissionElement.status;
      if (!status.isGranted) {
        flag = false;
        permissionCurrent = permissionElement;
        break;
      }
    }

    if (!flag) {
      LoggerTool.logMy("$logCatTag 发现有权限未允许");

      PermissionStatus permissionStatusForCheck = await _requestPermissionList(permissionList);

      if (permissionStatusForCheck.isGranted) {
        LoggerTool.logMy("$logCatTag -多权限申请--isGranted--isGranted");
        (!ObjectUtil.isEmpty(callbackGranted)) ? callbackGranted.call() : () {}();
      } else if (permissionStatusForCheck.isDenied) {
        LoggerTool.logMy("$logCatTag -多权限申请--发现有权限未允许--isDenied");
        //----------------------------------------------------------------------------------------------------------------------
        // if (permissionCurrent != null) {
        //   //String name = permissionCurrent.toString();
        //   Logger.logMy("$logCatTag 发现有权限未允许--isDenied--permissionCurrent不是空->" + permissionCurrent.toString());
        //   showDialogPermissionAndroidSingle(
        //     messageSingle: message, //
        //     permissionSingle: permissionCurrent, //
        //     grantedSingle: callbackGranted, //
        //   );
        // } else {
        //   Logger.logMy("$logCatTag 发现有权限未允许--isDenied-但是showDialogPermissionAndroidSingle未执行");
        // }
        //----------------------------------------------------------------------------------------------------------------------

        //showDialogPermissionAndroidList(permissions: permissionList, messageToUser: message, doGranted: callbackGranted);
        permissionCurrent?.onGrantedCallback(() {
          callbackGranted.call();
        }).onDeniedCallback(() {
          showMessageBottomLikeAndroid("${permissionCurrent.toString()}:$permission_open_setting", isLong: false);
          openAppSettings();
        }).request();
      } else if (permissionStatusForCheck.isPermanentlyDenied) {
        LoggerTool.logMy("$logCatTag 多权限申请，权限被永久拒绝，只能通过系统设置更改");

        bool? isShown = await permissionCurrent?.shouldShowRequestRationale;

        if (permissionCurrent != null) {
          showMessageBottomLikeAndroid("${permissionCurrent.toString()}:$permission_open_setting", isLong: false);
          Future.delayed(const Duration(seconds: 2), () {
            //onOpenSetting != null ? onOpenSetting() : () {}();
            openAppSettings();
          });
        }
      } else if (permissionStatusForCheck.isRestricted) {
        LoggerTool.logMy("$logCatTag permissionStatusForCheck.isRestricted");
        //IOS单独处理
        //onOpenSetting != null ? onOpenSetting() : () {}();
        openAppSettings();
      } else if (permissionStatusForCheck.isLimited) {
        LoggerTool.logMy("$logCatTag 多权限申请，临时权限授予");
        //IOS单独处理
        //onOpenSetting != null ? onOpenSetting() : () {}();
        openAppSettings();
      } else {
        //showDialogPermissionAndroidList(messageToUser, permissionList);
      }
    }
  }

  //申请权限
  static Future<PermissionStatus> _requestPermissionList(List<Permission> permissionList) async {
    Map<Permission, PermissionStatus> statuses = await permissionList.request();
    PermissionStatus currentPermissionStatus = PermissionStatus.granted;

    statuses.forEach((key, value) {
      if (!value.isGranted) {
        currentPermissionStatus = value;
        return;
      }
    });
    return currentPermissionStatus;
  }

  //直接一次申请完成，不做检查，
  // static Future<PermissionStatus> _requestPermissionListFull(List<Permission> permissionList) async {
  //
  //   Map<Permission, PermissionStatus> statuses = await permissionList.request();
  //   PermissionStatus currentPermissionStatus = PermissionStatus.granted;
  //
  //   statuses.forEach((key, value) {
  //     if (!value.isGranted) {
  //       currentPermissionStatus = value;
  //       return;
  //     }
  //   });
  //   return currentPermissionStatus;
  // }

  //勿删代码：将来有空优化
  // static showDialogVersion(
  //     {VoidCallback? cancelCallBack, //
  //     required VoidCallback middleCallBack, //
  //     required VoidCallback confirmCallBack}) {
  //   showAlertDialogDownLodAPK(
  //     title: "版本更新",
  //     message: "检测到新版本,请下载更新~",
  //     margin: const EdgeInsets.only(left: 20, right: 20),
  //     content: const SizedBox.shrink(),
  //     confirmText: market_server_down, //应用市场更新
  //     middleText: owner_server_down,
  //     cancelText: not_update,
  //     confirm: () {
  //       dismissAlertDialog();
  //       confirmCallBack();
  //     },
  //     middle: () {
  //       dismissAlertDialog();
  //       middleCallBack();
  //     },
  //     cancel: () {
  //       dismissAlertDialog();
  //       //cancelCallBack;
  //     },
  //   );
  // }

  /// 用于非首页的-弹出更新的提示框
  static void showUpdateDialogAndroid({required BuildContext mContext, required String downLoadUrlCurr, required String newVersion, required ProgressDialog progressDialogAndroid}) {
    AppManager.isShowUpload = true;
    showAlertDialogThreeButton(
      title: "检测到新版本",
      message: "是否升级到$newVersion版本？",
      margin: const EdgeInsets.only(left: 20, right: 20),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            child: RichText(
              text: const TextSpan(children: [
                TextSpan(
                  text: "",
                  // text: "1. 新增了优惠券批量审核的功能\n2. 重构了客户关怀界面xxxx
                  style: TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
                ),
              ]),
            ),
          ),
        ],
      ),
      confirmText: market_server_down,
      middleText: owner_server_down,
      cancelText: "以后再说",
      buttonVertical: true,
      confirm: () async {
        dismissAlertDialog();
        // AppManager.isShowUpload = false;
        if (Platform.isAndroid) AppVersionManager.openAndroidMarket();
      },
      middle: () {
        dismissAlertDialog();
        // AppManager.isShowUpload = false;
        CommonTools.requestPermissionAndroidSingle(
            permission: Permission.storage,
            message: permission_content_storage, //
            callbackGranted: () {
              //第一种下载方式：可用
              //methodDownLoadApkByDio(downLoadUrlCurr,mContext);
              //第二种下载方式：可用
              methodDownLoadApkByFlutterDownLoader(mContext, downLoadUrlCurr, progressDialogAndroid);
            },
            callbackDenied: () {
              //CommonTools.showDialogPermissionAndroid("我们需要访问您文件访问权限callbackDenied", Permission.storage);
            });
      },
      cancel: () {
        dismissAlertDialog();
        // AppManager.isShowUpload = false;
      },
    );
    // }
  }

  //获取系统的版本号
  static Future<String> getOsVersion() async {
    final deviceInfo = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final info = await deviceInfo.androidInfo;
        return 'Android ${info.version.release}#${info.version.sdkInt}';
      }
      if (Platform.isIOS) {
        final info = await deviceInfo.iosInfo;
        return 'iOS ${info.systemVersion}';
      }
      return '未知系统';
    } catch (e) {
      return '获取系统版本失败';
    }
  }

  //第一种下载方式flutter_DownLoader
  static Future<void> methodDownLoadApkByFlutterDownLoader(BuildContext context, String downLoadUrl, ProgressDialog? progressDialogAndroid) async {
    try {
      String downLoadDirPath = await FileUtilsMy.getDownLoadDirPath();
      String completeDirPath = await FileUtilsMy.getCompleteDirPath();
      Directory downLoadDir = Directory(downLoadDirPath);
      if (!downLoadDir.existsSync()) {
        await downLoadDir.create();
      }

      FileUtilsMy.getCompleteDirPath().then((completePath) {
        StorageUtils.createDir(completePath);
      });

      String fileNameFromDownLoadUrl = DateUtil.getNowDateStr() + StringUtils.splitPathName(downLoadUrl ?? "");
      //logger.d("fileName-即将下载的文件名->$fileNameFromDownLoadUrl");
      String? apkNameShort = StringUtils.splitApkNameWithDateTime(fileNameFromDownLoadUrl.toString() ?? "");
      String completeFileName = "$completeDirPath/${apkNameShort.toString()}";
      File fileCompleteApk = FileUtilsMy.readFile(completeFileName);
      //logger.d("fileCompleteApk-寻找的已下载文件是->${fileCompleteApk.absolute.path}");

      if (!ObjectUtil.isEmpty(fileCompleteApk)) {
        if (fileCompleteApk.existsSync()) {
          //logger.d("${fileCompleteApk.path}文件已存在");

          //"${apkNameShort.toString()}已下载完毕，是否安装？
          StringBuffer stringBuffer = StringBuffer();
          stringBuffer.write("【");
          stringBuffer.write(apkNameShort.toString());
          stringBuffer.write("】");
          stringBuffer.write("已下载，是否安装？");

          showAlertDialogThreeButton(
            title: titleTips,
            message: stringBuffer.toString(),
            margin: const EdgeInsets.only(left: 20, right: 20),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  child: RichText(
                    text: const TextSpan(children: [
                      TextSpan(
                        text: "",
                        // text: "1. 新增了优惠券批量审核的功能\n2. 重构了客户关怀界面xxxx
                        style: TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
            confirmText: "立即安装",
            middleText: "重新下载",
            cancelText: "以后再说",
            buttonVertical: true,
            confirm: () async {
              //dismissAlertDialog();
              SmartDialog.dismiss(force: true);
              //Navigator.pop(context); // 关闭对话框
              try {
                AppInstaller.installApk(fileCompleteApk.absolute.path.toString());
              } on Exception catch (e) {
                if (!ObjectUtil.isEmpty(e)) {
                  logger.w(" catch Exception =>${e.toString()}");
                  ErrorLogUtils.addLogSingle(fun: "methodDownLoadApkByFlutterDownLoader", error: "下载安装报错$e");
                }
              }
            },
            middle: () {
              dismissAlertDialog();
              //取消
              SmartDialog.dismiss(force: true);
              //如果重新下载就要先清空【complete】内的所有文件
              FileUtilsMy.deleteFileData(fileCompleteApk.absolute.path.toString());
              _executeDownApkByFlutterDownLoader(context, downLoadDir, downLoadUrl, fileNameFromDownLoadUrl, progressDialogAndroid);
            },
            cancel: () {
              dismissAlertDialog();
            },
          );
        } else {
          //logger.d("${fileCompleteApk.path}文件不存在");
          if (context.mounted) {
            _executeDownApkByFlutterDownLoader(context, downLoadDir, downLoadUrl, fileNameFromDownLoadUrl, progressDialogAndroid);
          }
        }
      } else {
        if (context.mounted) {
          _executeDownApkByFlutterDownLoader(context, downLoadDir, downLoadUrl, fileNameFromDownLoadUrl, progressDialogAndroid);
        }
      }
    } catch (e) {
      logger.i("$logCatTag catch：${e.toString()}");
    }
  }

  //开始执行下载
  static _executeDownApkByFlutterDownLoader(
      BuildContext context, //
      Directory savedDir, //
      String downLoadUrl, //
      String fileNameFromDownLoadUrl, //
      ProgressDialog? progressDialogAndroid) async {
    String taskIdMy = (await FlutterDownloader.enqueue(
      url: downLoadUrl,
      savedDir: savedDir.path,
      showNotification: true,
      saveInPublicStorage: false,
      fileName: fileNameFromDownLoadUrl,
      // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    ))!;

    //如果在外部，取消或者暂停下载能用到，所以暂时存起来，
    localStorageWrite(keyTaskId, taskIdMy);
    localStorageWrite(keyApkName, fileNameFromDownLoadUrl); //存入的是下载链接内的长名称

    if (!ObjectUtil.isEmpty(progressDialogAndroid)) {
      progressDialogAndroid!.show(
          max: 100,
          msg: ("${StringUtils.splitApkNameWithDateTime(fileNameFromDownLoadUrl).toString()}下载中") ?? newVersionDownLoading,
          //
          progressBgColor: TdColors.brand,
          progressType: ProgressType.determinate,
          // progressType: ProgressDialogType.download,
          cancel: Cancel(
            cancelClicked: () async {
              /// ex: cancel the download
              progressDialogAndroid.close();
              await FlutterDownloader.remove(taskId: taskIdMy, shouldDeleteContent: true);
            },
          ),
          completed: Completed(
              completedMsg: completedMessage,
              // completedImage:  const AssetImage(AssetsRes.GREEN_SELECTED),//自定义完成图片
              completionDelay: 2500));
    } else {
      await Future.delayed(const Duration(seconds: 1));
      if (context.mounted) {
        ProgressDialog? progressDialogAndroid = ProgressDialog(context: context);
        progressDialogAndroid.show(
            max: 100,
            msg: ("${StringUtils.splitApkNameWithDateTime(fileNameFromDownLoadUrl).toString()}下载中") ?? newVersionDownLoading,
            progressBgColor: TdColors.brand,
            progressType: ProgressType.determinate,
            // progressType: ProgressDialogType.download,
            cancel: Cancel(
              cancelClicked: () async {
                /// ex: cancel the download
                progressDialogAndroid.close();
                await FlutterDownloader.remove(taskId: taskIdMy, shouldDeleteContent: true);
              },
            ),
            completed: Completed(
                completedMsg: completedMessage,
                // completedImage:  const AssetImage(AssetsRes.GREEN_SELECTED),//自定义完成图片
                completionDelay: 2500));
      }
    }
  }

  /*static isHasFile(String copyToCompleteDirPath) async {

    List<FileSystemEntity> entities = await FileUtilsMy.listFolder(copyToCompleteDirPath);
    if(!ObjectUtil.isEmptyList(entities)){
      for(FileSystemEntity entity in entities){
        if(entity is File){
          if(){

          }
        }
      }
    }

  }*/

  //第二种下载方式
  static methodDownLoadApkByDio(String downLoadUrlFromServer, context) async {
    String downLoadDirPath = (await FileUtilsMy.getDownLoadDirPath());
    String completeDirPath = (await FileUtilsMy.getCompleteDirPath());
    Directory downLoadDir = Directory(downLoadDirPath);
    Directory completeDir = Directory(completeDirPath);

    if (!downLoadDir.existsSync()) {
      // Logger.logMy("$logCatTag directory文件夹不存在：${savedDir.path.toString()}");
      await downLoadDir.create(recursive: false);
    } else {
      // Logger.logMy("$logCatTag directory文件夹已存在：${savedDir.path.toString()}");
      List<FileSystemEntity> entities = await FileUtilsMy.listFolder(downLoadDir.path);
      // Logger.logMy("$logCatTag Listed folder contents：$entities}");
      //判断文件是否存在，如果存在直接安装，如果不存在则重新下载
      if (entities.isNotEmpty) {
        for (FileSystemEntity entity in entities) {
          if (entity is File) {
            String fileName = entity.path.split('/').last;
            //Logger.logMy("$logCatTag fileName：${fileName.toString()}");
            if (fileName == StringUtils.splitPathName(downLoadUrlFromServer)) {
              // Logger.logMy("$logCatTag 存在,那么删除x它");
              await entity.delete();
            } else {
              // Logger.logMy("$logCatTag 不存在,那么放过准备下载");
            }
          }
        }
      }
    }

    //同步创建一个下载完毕的文件夹路径,用来检测有最新包已经下载完毕。
    // StringBuffer copyToCompleteDir = StringBuffer();
    // copyToCompleteDir.write(saveDirDoc.toString());
    // copyToCompleteDir.write("/");
    // copyToCompleteDir.write(dirComplete);

    FileUtilsMy.getCompleteDirPath().then((completePath) {
      logger.d("completePath=>$completePath");
      StorageUtils.createDir(completePath);
    });

    String fileNameFromDownLoadUrlWithDateTime = DateUtil.getNowDateStr() + StringUtils.splitPathName(downLoadUrlFromServer ?? "");
    //logger.d("fileName-即将下载的文件名->$fileNameFromDownLoadUrl");
    //2025年8月1日15:18:58 我打印的日志
    //sourceFile->/data/user/0/<包名>/app_flutter/downLoad/2025-08-01 15:11:15应用名86.apk
    String? apkNameShort = StringUtils.splitApkNameWithDateTime(fileNameFromDownLoadUrlWithDateTime.toString() ?? "");
    String completeFileName = "$completeDirPath/$apkNameShort";
    File fileCompleteApk = FileUtilsMy.readFile(completeFileName);
    //logger.d("fileCompleteApk-寻找的已下载文件是->${fileCompleteApk.absolute.path}");

    if (!ObjectUtil.isEmpty(fileCompleteApk)) {
      if (fileCompleteApk.existsSync()) {
        //logger.d("${fileCompleteApk.path}文件已存在");

        //"${apkNameShort.toString()}已下载完毕，是否安装？
        StringBuffer stringBuffer = StringBuffer();
        stringBuffer.write("【");
        stringBuffer.write(apkNameShort.toString());
        stringBuffer.write("】");
        stringBuffer.write("已下载，是否安装？");

        showAlertDialogThreeButton(
          title: titleTips,
          message: stringBuffer.toString(),
          margin: const EdgeInsets.only(left: 20, right: 20),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                      text: "",
                      // text: "1. 新增了优惠券批量审核的功能\n2. 重构了客户关怀界面xxxx
                      style: TextStyle(fontSize: 16, color: Colors.black, height: 1.5),
                    ),
                  ]),
                ),
              ),
            ],
          ),
          confirmText: "立即安装",
          middleText: "重新下载",
          cancelText: "以后再说",
          buttonVertical: true,
          confirm: () async {
            //dismissAlertDialog();
            SmartDialog.dismiss(force: true);
            //Navigator.pop(context); // 关闭对话框
            try {
              AppInstaller.installApk(fileCompleteApk.absolute.path.toString());
            } on Exception catch (e) {
              if (!ObjectUtil.isEmpty(e)) {
                logger.w(" catch Exception =>${e.toString()}");
                ErrorLogUtils.addLogSingle(fun: "AppInstaller.installApk", error: "methodDownLoadApkByDio安装apk失败");
              }
            }
          },
          middle: () {
            dismissAlertDialog();
            //取消
            SmartDialog.dismiss(force: true);
            //如果重新下载就要先清空【complete】内的所有文件
            FileUtilsMy.deleteFileData(fileCompleteApk.absolute.path.toString());
            _executeDownApkByDio(context, downLoadDir, completeDir, apkNameShort, downLoadUrlFromServer, fileNameFromDownLoadUrlWithDateTime);
          },
          cancel: () {
            dismissAlertDialog();
          },
        );
      } else {
        //logger.d("${fileCompleteApk.path}文件不存在");
        _executeDownApkByDio(context, downLoadDir, completeDir, apkNameShort, downLoadUrlFromServer, fileNameFromDownLoadUrlWithDateTime);
      }
    } else {
      _executeDownApkByDio(context, downLoadDir, completeDir, apkNameShort, downLoadUrlFromServer, fileNameFromDownLoadUrlWithDateTime);
    }
  }

  static _executeDownApkByDio(
      context, //
      Directory downLoadDir, //
      Directory completeDir, //
      apkNameShort, //
      downLoadUrlFromServer, //
      fileNameFromDownLoadUrlWithDateTime) {
    //
    //String fileNameShort = StringUtils.splitPathName(downLoadUrlFromServer);
    localStorageWrite(keyApkName, fileNameFromDownLoadUrlWithDateTime); //存入的是下载链接内的长名称

    CancelToken cancelTokenOut = CancelToken();
    cancelDown() {
      if (!ObjectUtil.isEmpty(cancelTokenOut)) {
        //logger.d("即将取消下载");
        cancelTokenOut.cancel();
      }
    }

    ProgressDialog progressDialogAndroid = ProgressDialog(context: context);
    progressDialogAndroid.show(
        max: 100,
        msg: "$apkNameShort下载中" ?? newVersionDownLoading,
        progressBgColor: TdColors.brand,
        progressType: ProgressType.determinate,
        // progressType: ProgressDialogType.download,
        cancel: Cancel(
          cancelClicked: () async {
            /// ex: cancel the download
            //logger.d("点击取消下载");
            cancelDown.call();
          },
        ),
        completed: Completed(
            completedMsg: completedMessage,
            // completedImage:  const AssetImage(AssetsRes.GREEN_SELECTED),//自定义完成图片
            completionDelay: 2500));

    CommonRequest.downloadFile(
        downLoadUrlFromServer,
        downLoadDir.absolute.path, //
        fileNameFromDownLoadUrlWithDateTime, //
        cancelToken: cancelTokenOut, onReceiveProgress: (
      int count,
      int total,
    ) async {
      int progress = (((count / total) * 100).toInt());
      Future.delayed(const Duration(seconds: 5), () {
        progressDialogAndroid.update(value: progress);
      });

      if (progress == 100) {
        //---------------------------------------------------------------------------------------------------------
        StringBuffer stringBuffer = StringBuffer();
        stringBuffer.write(downLoadDir.absolute.path);
        stringBuffer.write("/");
        stringBuffer.write(fileNameFromDownLoadUrlWithDateTime); //下载的文件名用长名称，存储用短名称。
        //---------------------------------------------------------------------------------------------------------
        //String? apkNameShort = StringUtils.splitApkNameWithDateTime(fileNameFromDownLoadUrlWithDateTime.toString() ?? "");
        if (!ObjectUtil.isEmptyString(apkNameShort)) {
          //logger.d("执行短名称拷贝apkNameShort-->$apkNameShort");
          FileUtilsMy.copyFile(stringBuffer.toString(), "${completeDir.absolute.path}/$apkNameShort");
        } else {
          String? downLoadUrlCurr = localStorageRead<String>(app_update_android_download_url);
          String? apkShortName = StringUtils.splitPathName(downLoadUrlCurr ?? "");
          if (!ObjectUtil.isEmptyString(downLoadUrlCurr)) {
            //logger.d("走到取出downLoadUrlCurr之中的短名称");
            FileUtilsMy.copyFile(stringBuffer.toString(), "${completeDir.absolute.path}/$apkShortName");
          }
        }
        //---------------------------------------------------------------------------------------------------------
        //可用，将来再研究
        // final res = await InstallPlugin.install(stringBuffer.toString());
        //final res = await InstallPlugin.install(stringBuffer.toString());
        //final res = AppInstaller.installApk(stringBuffer.toString());
        try {
          AppInstaller.installApk(stringBuffer.toString());
        } on Exception catch (e) {
          if (!ObjectUtil.isEmpty(e)) {
            logger.w("dio下载安装 报错=>${e.toString()}");
            ErrorLogUtils.addLogSingle(fun: "installApk", error: "dio下载安装$e");
          }
        }
        //Logger.logMy("res,res-$stringBuffer");
        //如果给安装完毕提示，就放开，一般不需要。
        // showMessageBottomLikeAndroid("install apk ${res['isSuccess'] == true ? 'success' : 'fail:${res['errorMessage'] ?? ''}'}", isLong: false);
      }
    });
  }

  //弹窗或者底部布局需要移除一个安全距离的
  static double bottomPadding(BuildContext mContext) {
    return MediaQuery.of(mContext).padding.bottom;
  }

  //重新修改图片的下载路径
  static String imagePathReset({required String imagePathCurrent, required String imagePathFull}) {
    String imageLoadPathResult = "";
    if (StringUtils.isNullOrEmpty(imagePathCurrent)) {
      //imagePathCurrent = imagePathFull;
      imageLoadPathResult = imagePathFull;
    } else {
      String lastChar = imagePathCurrent.substring(imagePathCurrent.length - 1, imagePathCurrent.length);
      if (lastChar == "/") {
        imageLoadPathResult = imagePathFull;
      }
    }
    return imageLoadPathResult;
  }

  //限制文本款之中仅仅录入数字
  /*static inputNumberOnly() {
    return <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];
  }*/

  //限制只能录入double类型的过滤掉特殊符号
  /*static inputDoubleOnly() {
    return <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))];
  }*/

  // // 允许输入数字和字母和空格 同时这个表达式也是控制不能输入【特殊字符的】表达式
  /*static inputNumberAndLetterOnly() {
    return <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))];
  }*/

  //处理携带空字符串的标题
  static String titleExtra({required String extra, required String def}) {
    String titleResult = def;
    if (!TextUtil.isEmpty(extra)) {
      if (extra != nullChar) {
        titleResult = extra;
      } else {
        titleResult = def;
      }
    } else {
      titleResult = def;
    }
    return titleResult;
  }

  ///@description 对工具类的json打印做个格式化
  static String? prettyJsonString(dynamic value) {
    String jsonString = jsonEncode(value);
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String prettyJsonString = encoder.convert(jsonDecode(jsonString));
    final pattern = RegExp('.{1,800}');
    pattern.allMatches(prettyJsonString).forEach((match) {
      //debugPrint(match.group(0));
    });
    return value == null ? null : prettyJsonString;
  }

  ///@description 简单版格式化json
  static String? prettyJsonStringSimple(dynamic value) {
    try {
      String jsonString = jsonEncode(value);
      JsonEncoder encoder = const JsonEncoder.withIndent('  ');
      String prettyJsonString = encoder.convert(jsonDecode(jsonString));
      return value == null ? null : prettyJsonString;
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.d(" catch Exception =>${e.toString()}");
      }
    }
    return null;
  }


  ///----------------------------------------------------------


  //复制剪切板
  static void copyClipboard(String content, {VoidCallback? callback, String? messageToUser}) {
    if (!ObjectUtil.isEmptyString(content)) {
      Clipboard.setData(ClipboardData(text: content));
      if (!ObjectUtil.isEmptyString(messageToUser)) {
        showMessage(messageToUser!);
      } else {
        showMessage("复制成功");
      }

      if (callback != null) {
        callback.call();
      }
    } else {
      showMessageBottomLikeAndroid(actionAbNormal, isLong: false);
    }
  }

  //日期追加周几周几
  static String timeWithWeek(String? currentTime) {
    StringBuffer stringBufferReminderTime = StringBuffer();
    //默认的
    String? currentResultTime = currentTime;
    if (!ObjectUtil.isEmpty(currentResultTime)) {
      DateTime? dateTime = DateUtil.getDateTime(currentResultTime!);
      String weekDay = DateUtil.getWeekday(dateTime, languageCode: LocaleType.zh.name);
      String? time = DateUtil.formatDateStr(currentResultTime, format: DateFormats.y_mo_d);
      stringBufferReminderTime.write(time);
      stringBufferReminderTime.write(" ");
      stringBufferReminderTime.write(weekDay);
    } else {
      currentResultTime = "";
    }
    return stringBufferReminderTime.toString();
  }

  //Get.find异常捕获不到，代码执行tryCatch无效。
  static T? getFindMy<T>() {
    try {
      return Get.find<T>();
    } catch (e) {
      logger.e('Failed to find dependency: $e');
      ErrorLogUtils.addLogSingle(fun: "getFindMy", error: "getFindMy报错$e");
      return null;
    }
  }

  //通过tag获取
  static T? getFindMyByTag<T>({required String tagSelf}) {
    try {
      return Get.find<T>(tag: tagSelf);
    } catch (e) {
      logger.e('Failed to find dependency getFindMyByTag: $e');
      ErrorLogUtils.addLogSingle(fun: "getFindMyByTag", error: "getFindMyByTag$e");
      return null;
    }
  }

  //获取年月日
  static String getYearMonthDay(Map<String, dynamic> selected) {
    return '${selected['year'].toString().padLeft(4, '0')}-${selected['month'].toString().padLeft(2, '0')}-${selected['day'].toString().padLeft(2, '0')}';
  }

  //代码勿删！！！计算时间戳的重要代码
  static String printTimeDifference(DateTime startTime, DateTime endTime) {
    String daysDifferenceResultForReminder = "";
    // 计算两个时间点之间的差异
    Duration difference = endTime.difference(startTime);
    // 获取天数
    int days = difference.inDays;
    // 从总秒数中减去完整的天数对应的秒数，得到剩余的秒数
    int secondsLeft = difference.inSeconds - days * Duration.secondsPerDay;
    // 从剩余的秒数中计算小时数
    int hours = secondsLeft ~/ Duration.secondsPerHour;
    // 更新剩余秒数
    secondsLeft -= hours * Duration.secondsPerHour;
    // 从剩余的秒数中计算分钟数
    int minutes = secondsLeft ~/ Duration.secondsPerMinute;
    // 更新剩余秒数
    secondsLeft -= minutes * Duration.secondsPerMinute;
    // 剩余的就是秒数
    int seconds = secondsLeft;

    if (days == 0) {
      daysDifferenceResultForReminder = "$hours小时$minutes分钟$seconds秒";
    } else {
      daysDifferenceResultForReminder = "$days天$hours小时$minutes分钟$seconds秒";
    }
    return daysDifferenceResultForReminder;
    // 打印结果
    //print('$days 天 $hours 小时 $minutes 分钟 $seconds 秒');
  }

  //单独的仅仅计算天数的方法
  static String printTimeDifferenceDaySingle(DateTime startTime, DateTime endTime) {
    //
    String daysDifferenceResultForReminder = "";
    // 计算两个时间点之间的差异
    Duration difference = endTime.difference(startTime);
    // 获取天数
    int days = difference.inDays;
    //
    // 从总秒数中减去完整的天数对应的秒数，得到剩余的秒数
    // int secondsLeft = difference.inSeconds - days * Duration.secondsPerDay;
    // 从剩余的秒数中计算小时数
    // int hours = secondsLeft ~/ Duration.secondsPerHour;
    // 更新剩余秒数
    // secondsLeft -= hours * Duration.secondsPerHour;
    // 从剩余的秒数中计算分钟数
    // int minutes = secondsLeft ~/ Duration.secondsPerMinute;
    // 更新剩余秒数
    // secondsLeft -= minutes * Duration.secondsPerMinute;
    // 剩余的就是秒数
    // int seconds = secondsLeft;

    if (days == 0) {
      daysDifferenceResultForReminder = "0天";
    } else {
      daysDifferenceResultForReminder = "$days天";
      // daysDifferenceResultForReminder = "$days天$hours小时$minutes分钟$seconds秒";
    }
    return daysDifferenceResultForReminder;
    // 打印结果
    //print('$days 天 $hours 小时 $minutes 分钟 $seconds 秒');
  }


  //中国的手机号码通常是11位数字，并且以13、14、15、16、17、18或19开头。下面是一个简单的函数，用于检查输入的字符串是否符合这些规则：
  bool isValidPhoneNumber(String phoneNumber) {
    // 定义中国手机号码的正则表达式模式
    String pattern = r'^1[3-9]\d{9}$';
    RegExp regExp = RegExp(pattern);

    // 测试输入的电话号码是否匹配模式
    return regExp.hasMatch(phoneNumber);
  }


  //展示服务器现实的报错信息封装
  static showErrorAlertServer(ResponseAnalyzed result) {
    if (!ObjectUtil.isEmpty(result.message)) {
      if (result.message is String) {
        // showMessageBottomLikeAndroid(result.message!, isLong: true);
        showAlertMessage(result.message!);
      }
    } else {
      // showMessageBottomLikeAndroid(actionAbNormal, isLong: true);
      showAlertMessage(actionAbNormal);
    }
  }

  //有的接口只返回半截图片路径，需要拼接前缀
  static List<String> imageUrlHalfAddUrlPrefix({required String? urlPrefix, required List<String> imageUrlListHasHalfUrl}) {
    //复检问题项携带的图片
    List<String> tempFileListString = [];
    //
    for (String halfImageUrl in imageUrlListHasHalfUrl) {
      StringBuffer stringBuffer = StringBuffer();
      //图片前缀
      // String? currentUrlPrefix = fileItem.urlPrefix ?? "";
      //需要上传的仅仅是图片的一部分，
      // String? currentHalfImageUrl = fileItem.fileUrl ?? "";
      //
      if (!ObjectUtil.isEmptyString(urlPrefix)) {
        stringBuffer.write(urlPrefix);
      }

      //最好做个判断，万一后台改为携带前缀的
      if (!ObjectUtil.isEmptyString(halfImageUrl)) {
        if (!halfImageUrl.startsWith(httpStartWithPrefix)) {
          stringBuffer.write(halfImageUrl);
        }
      }
      //
      tempFileListString.add(stringBuffer.toString());
    }
    // logger.d("转换半截路径之后-tempFileListString-=>${CommonTools.prettyJsonStringSimple(tempFileListString)}");
    return tempFileListString;
  }

  //预备做压缩改造
  _cameraPickerAndroidSimpleTools(context, {required Function(dynamic value) complete}) async {
    String saveDirDoc = (await FileUtilsMy.getDownLoadDirPath());
    final savedDir = Directory(saveDirDoc);
    // Logger.logMy("$logCatTag savedDir：${savedDir.path.toString()}");
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }

    executeXFileSimple() async {
      try {
        final ImagePicker picker = ImagePicker();
        // 调用系统相机应用
        final XFile? photo = await picker.pickImage(source: ImageSource.camera, imageQuality: 70);

        if (photo != null) {
          // LoggerTool.logMy("android平台--photo.path==>${photo.path}");
          //第一种方式-文件名字比较长
          //String fileNameComplete = DateUtil.getNowDateMs().toString() + StringUtils.splitPathName(photo.path ?? "");
          //第二种方式
          //String fileNameComplete = StringUtils.splitPathName(photo.path ?? "");
          //String fileNameComplete = DateUtil.formatDate(DateTime.now(), format: timeFormatDateTooLong2);
          // LoggerTool.logMy("目标路径fileNameComplete->$fileNameComplete");
          try {
            //原始图片
            // File fileFrom = File(photo.path);
            // File fileTo = File("${savedDir.path}/$fileNameComplete");
            //
            LoggerTool.logMy("android平台--fileFrom==>${photo.path.toString()}");
            // LoggerTool.logMy("android平台--fileFrom==>${fileFrom.toString()}");
            // LoggerTool.logMy("android平台--fileTo==>${fileTo.toString()}");

            //不做任何处理直接上传
            complete([photo.path]);

            //压缩之后存储？
            //String fileNameCompress = DateUtil.getNowDateMs().toString() + StringUtils.splitPathName(photo.path ?? "");
            //String time = DateUtil.getNowDateStr();
            /*String timeFormat = DateUtil.formatDate(DateTime.now(), format: timeFormatDateTooLong2);
            String fileNameCompress = "${savedDir.path}/$timeFormat$jpegStr";
            // LoggerTool.logMy("压缩图片之后的fileNameCompress->$fileNameCompress");
            //图片压缩
            Uint8List uint8ListInit = await photo.readAsBytes();
            //Uint8List result =  ImageTool.compressImageForExecuteXFile(uint8ListInit,targetQuality:0.6);
            //ImageTool.saveUint8ListToFile(ImageTool.compressImageForExecuteXFile(uint8ListInit, targetQuality: 0.6), fileNameCompress);
            ImageTool.saveUint8ListToFile(ImageTool.compressImageForExecuteXFile(uint8ListInit, targetQuality: 0.6), fileNameCompress).then((_) {
              LoggerTool.logMy("压缩图片完毕的fileNameCompress->$fileNameCompress");
              complete([fileNameCompress]);
            });*/
            //
          } on Exception catch (e) {
            if (!ObjectUtil.isEmpty(e)) {
              logger.d(" catch Exception =>${e.toString()}");
              ErrorLogUtils.addLogSingle(fun: "android文件拷贝", error: "拷贝失败${e.toString()}");
            }
          }
        } else {
          LoggerTool.logMy("android平台--photo是空值");
        }
      } on Exception catch (e) {
        if (!ObjectUtil.isEmpty(e)) {
          LoggerTool.logMy(" catch Exception =>${e.toString()}");
          ErrorLogUtils.addLogSingle(fun: "android during taking picture", error: "executeXFile保存失败${e.toString()}");
        }
      }
    }

    List<Permission> permissions;
    if (AppManager.osSdkIntForAndroid < ANDROID_OS_SDK_33) {
      permissions = [Permission.camera, Permission.storage];
    } else {
      permissions = [Permission.camera, Permission.manageExternalStorage];
    }

    BaseController baseController = BaseController();
    bool hasPermissionNotAllow = await baseController.checkPermissionAndroidList(permissions);
    if (hasPermissionNotAllow) {
      showMessageBottomLikeAndroid("存储权限未打开", isLong: false);
      CommonTools.showDialogPermissionAndroidList(
          permissions: permissions,
          messageToUser: permission_content_camera_storage,
          doGranted: () {
            executeXFileSimple();
          });
    } else {
      LoggerTool.logMy("存储权限----已放开");
      executeXFileSimple();
    }
  }

  //相册选择-主要目的为了压缩图片--多图限制好像不管用
  /*assetPickerAndroidSimple(context, max, {required Function(dynamic value) complete}) async {
    LoggerTool.logMy("android平台--max==>${max.toString()}");
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> gallery = await picker.pickMultiImage(limit: max, imageQuality: 70);
      if (!ObjectUtil.isEmpty(gallery)) {
        try {
          LoggerTool.logMy("android平台-gallery相册选择-==>${gallery.toList().toString()}");

          List<XFile> tempList = gallery.toList();
          for (XFile file in tempList) {
            LoggerTool.logMy("android平台--file==>${file.path.toString()}");
          }
          complete([gallery.toList()]);
        } on Exception catch (e) {
          if (!ObjectUtil.isEmpty(e)) {
            logger.d(" catch Exception =>${e.toString()}");
            ErrorLogUtils.addLogSingle(fun: "_cameraPickerAndroidSimple", error: "android执行上传失败${e.toString()}");
          }
        }
      }
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.d(" catch Exception =>${e.toString()}");
        ErrorLogUtils.addLogSingle(fun: "xxxx", error: "xxx 报错$e");
      }
    }
  }*/

  //代码勿删--方法内部有一种拷贝思想
  /*Future<void>  cameraPickerAndroidTools11(context, {required Function(dynamic value) complete}) async {
    //
    String saveDirDoc = (await FileUtilsMy.getDownLoadDirPath());
    final savedDir = Directory(saveDirDoc);
    // Logger.logMy("$logCatTag savedDir：${savedDir.path.toString()}");
    if (!savedDir.existsSync()) {
      await savedDir.create();
    }
    //
    executeXFile() async {
      try {
        final ImagePicker picker = ImagePicker();
        // 调用系统相机应用
        final XFile? photo = await picker.pickImage(source: ImageSource.camera);

        if (photo != null) {
          // LoggerTool.logMy("android平台--photo.path==>${photo.path}");
          //第一种方式-文件名字比较长
          //String fileNameComplete = DateUtil.getNowDateMs().toString() + StringUtils.splitPathName(photo.path ?? "");
          //第二种方式
          String fileNameComplete = StringUtils.splitPathName(photo.path ?? "");
          // LoggerTool.logMy("目标路径fileNameComplete->$fileNameComplete");
          try {
            //原始图片
            File fileFrom = File(photo.path);
            File fileTo = File("${savedDir.path}/$fileNameComplete");
            //
            LoggerTool.logMy("android平台--fileFrom==>${fileFrom.toString()}");
            LoggerTool.logMy("android平台--fileTo==>${fileTo.toString()}");
            //压缩之后存储？
            await photo.saveTo(fileTo.path);
            //图片压缩
            complete([fileTo.path]);
            //
          } on Exception catch (e) {
            if (!ObjectUtil.isEmpty(e)) {
              logger.d(" catch Exception =>${e.toString()}");
              ErrorLogUtils.addLogSingle(fun: "android文件拷贝", error: "拷贝失败${e.toString()}");
            }
          }
        } else {
          LoggerTool.logMy("android平台--photo是空值");
        }
      } on Exception catch (e) {
        if (!ObjectUtil.isEmpty(e)) {
          LoggerTool.logMy(" catch Exception =>${e.toString()}");
          ErrorLogUtils.addLogSingle(fun: "android during taking picture", error: "executeXFile保存失败${e.toString()}");
        }
      }
    }

    List<Permission> permissions;
    if (AppManager.osSdkIntForAndroid < ANDROID_OS_SDK_33) {
      permissions = [Permission.camera, Permission.storage];
    } else {
      permissions = [Permission.camera, Permission.manageExternalStorage];
    }

    BaseController baseController = BaseController();
    bool hasPermissionNotAllow = await baseController.checkPermissionAndroidList(permissions);
    if (hasPermissionNotAllow) {
      showMessageBottomLikeAndroid("存储权限未打开", isLong: false);
      CommonTools.showDialogPermissionAndroidList(
          permissions: permissions,
          messageToUser: permission_content_camera_storage,
          doGranted: () {
            executeXFile();
          });
    } else {
      LoggerTool.logMy("存储权限----已放开");
      executeXFile();
    }
  }*/

  //格式化到小数点后两位
  static String numberFormatDecimal(Decimal number) {
    // Decimal number = Decimal.parse("123.456");
    NumberFormat currencyFormatter = NumberFormat('#,##0.00', 'en_US');
    String numberStr = currencyFormatter.format(number.toDouble());
    //logger.d("numberFormatDecimal=>$numberStr");
    return numberStr;
  }

//勿删-将来有空研究
// methodDownLoadFull() {
//   CommonTools.requestStoragePermission().then((_) async {
//     // 弹出升级弹窗
//     methodDownLoadContent();
//   });
// }

// Future<void> _pauseDownload(TaskInfo task) async {
//   await FlutterDownloader.pause(taskId: task.taskId!);
// }

// Future<void> _resumeDownload(TaskInfo task) async {
//   final newTaskId = await FlutterDownloader.resume(taskId: task.taskId!);
// }

// Future<void> _retryDownload(TaskInfo task) async {
//   final newTaskId = await FlutterDownloader.retry(taskId: task.taskId!);
// }

// Future<bool> _openDownloadedFile(TaskInfo? task) async {
//   final taskId = task?.taskId;
//   if (taskId == null) {
//     return false;
//   }
//
//   return FlutterDownloader.open(taskId: taskId);
// }

// Future<void> _delete(TaskInfo task) async {
//   await FlutterDownloader.remove(
//     taskId: task.taskId!,
//     shouldDeleteContent: true,
//   );
//   await _prepare();
//   setState(() {});
// }
}
