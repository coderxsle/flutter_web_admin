import 'dart:io';

import 'package:auto_shop_server/common/common_tools.dart';
import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/utils/common_widget/base_controller.dart';
import 'package:auto_shop_server/app/utils/constant_api.dart';
import 'package:auto_shop_server/app/modules/login/model/user_account.dart';
import 'package:auto_shop_server/res/assets_res.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unrelated_type_equality_checks
import 'package:http_manager/result_analyzed.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import '../../../utils/global.dart';
import '../../../utils/result_code.dart';
import '../request/mine_request.dart';
import 'modify_user_Info_page.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({super.key});

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  final _sepater = const Divider(height: 0.0, indent: 0.0, color: Colors.black26);

  UserAccount? _userInfo;
  String _qrcodeUrl = "";

  @override
  void initState() {
    super.initState();
    _userInfo = AppManager.userAccount;
    _getQRCode();
  }

  _getQRCode() async {
    var result = await getUserQRCode();
    if (result.success) {
      _qrcodeUrl = result.data["url"];
    }
    setState(() {});
  }

  // 修改头像
  Future _modifyUserIconHttp(String imagePath) async {
    showLoadingMessage("正在处理请稍等");
    var uid = AppManager.userAccount!.customerId!.toInt();
    ResponseAnalyzed result = await modifyUserIconHttp(uid, imagePath: imagePath);
    if (result.code == ResultCode.success) {
      if (!mounted) {
        return;
      }
      // 刷新界面
      UserAccount? account = AppManager.userAccount;
      account?.photoUrl = result.data["url"];
      AppManager.userAccount = account;
      AppManager.sendBroadcast(kHomeRefresh);
    }
    _userInfo = AppManager.userAccount;
    dismissLoading();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const NavigatorTitle('我的资料'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: BGColor_white_255),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _setUpBody(),
    );
  }

  Widget _setUpBody() {
    if (_userInfo == null) return Container();
    String sexStr = '保密';
    if (_userInfo!.sex == 1) {
      sexStr = '男';
    } else if (_userInfo!.sex == 2) {
      sexStr = '女';
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: ListView(
            shrinkWrap: true, // 根据内容大小而变
            physics: const NeverScrollableScrollPhysics(),
            children: [
              ListTile(
                contentPadding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('头像', style: blackStyle()),
                  Container(
                    alignment: Alignment.topLeft,
                    child: ClipOval(
                      child: imageNetwork(_userInfo!.photoUrl!, failed: AssetsRes.FACEID_IMAGE, width: 64, height: 64, fit: BoxFit.cover),
                    ),
                  ),
                ]),
                trailing: const Icon(Icons.keyboard_arrow_right, size: 16.0),
                dense: true,
                onTap: () {
                  showMaterialModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return buildAlert();
                      });
                },
              ),
              _sepater,
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('姓名', style: blackStyle()),
                  Text(
                    _userInfo!.trueName!,
                    textAlign: TextAlign.right,
                    style: blackStyle(),
                  )
                ]),
                trailing: const Icon(Icons.keyboard_arrow_right, size: 16.0),
                dense: true,
                onTap: () {
                  // ModifyUserInfoPage
                  Get.toNamed('/ModifyUserInfoPage', arguments: UpdateType.truename)?.then((value) {
                    _userInfo = AppManager.userAccount;
                    setState(() {});
                  });
                },
              ),
              _sepater,
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('昵称', style: blackStyle()),
                  Text(
                    _userInfo!.nickName!,
                    textAlign: TextAlign.right,
                    style: blackStyle(),
                  )
                ]),
                trailing: const Icon(Icons.keyboard_arrow_right, size: 16.0),
                dense: true,
                onTap: () {
                  // ModifyUserInfoPage
                  Get.toNamed('/ModifyUserInfoPage', arguments: UpdateType.nickname)?.then((value) {
                    _userInfo = AppManager.userAccount;
                    setState(() {});
                  });
                },
              ),
              _sepater,
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('姓名', style: blackStyle()),
                  Text(
                    _userInfo!.trueName!,
                    textAlign: TextAlign.right,
                    style: blackStyle(),
                  )
                ]),
                trailing: const Icon(Icons.keyboard_arrow_right, size: 16.0),
                dense: true,
                onTap: () {
                  Get.toNamed('/ModifyUserInfoPage', arguments: UpdateType.truename)?.then((value) {
                    _userInfo = AppManager.userAccount;
                    setState(() {});
                  });
                },
              ),
              _sepater,
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  Text('性别', style: blackStyle()),
                  Text(
                    sexStr,
                    textAlign: TextAlign.right,
                    style: blackStyle(),
                  )
                ]),
                trailing: const Icon(Icons.keyboard_arrow_right, size: 16.0),
                dense: true,
                onTap: () {
                  showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return CupertinoActionSheet(
                          message: const Text('选择性别'),
                          actions: [
                            CupertinoActionSheetAction(
                                child: const Text('男'),
                                onPressed: () {
                                  modifyUserInfo({"sex": 1}).then((success) {
                                    _userInfo?.sex = 1;
                                    AppManager.userAccount = _userInfo;
                                    setState(() {});
                                  });
                                  Get.back();
                                }),
                            CupertinoActionSheetAction(
                                child: const Text('女'),
                                onPressed: () {
                                  modifyUserInfo({"sex": 2}).then((success) {
                                    _userInfo?.sex = 2;
                                    AppManager.userAccount = _userInfo;
                                    setState(() {});
                                  });
                                  Get.back();
                                }),
                            CupertinoActionSheetAction(
                                child: const Text('保密'),
                                onPressed: () {
                                  modifyUserInfo({"sex": 3}).then((success) {
                                    _userInfo?.sex = 3;
                                    AppManager.userAccount = _userInfo;
                                    setState(() {});
                                  });
                                  Get.back();
                                }),
                          ],
                          cancelButton: CupertinoActionSheetAction(onPressed: () => Navigator.pop(context), isDestructiveAction: true, child: const Text('取消')),
                        );
                      });
                },
              ),
              _sepater,
              ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 5.0),
                title: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Text('我的二维码', style: blackStyle()),
                      Text(
                        _userInfo!.occupation!,
                        textAlign: TextAlign.right,
                        style: blackStyle(),
                      )
                    ]),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Image.network(_qrcodeUrl, width: 150, height: 150, fit: BoxFit.cover, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                        return SizedBox(
                          height: 64,
                          width: 64,
                          child: Image.asset(
                            AssetsRes.PLACEHOLDER_115,
                            fit: BoxFit.cover,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                //trailing: const Icon(Icons.keyboard_arrow_right, size: 16.0),
                // dense: true,
                // onTap: () {
                //   Get.toNamed('/ModifyUserInfoPage', arguments: UpdateType.occupation)?.then((value) {
                //     _userInfo = AppManager.userAccount;
                //     setState(() {});
                //   });
                // },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 弹出框
  Widget buildAlert() {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: const Text(
              "请选择图片上传方式",
              style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            height: 10,
            color: Colors.grey[100],
            alignment: Alignment.center,
            child: const SizedBox(),
          ),
          photoButton(),
          dividerLine(),
          cameraButton(),
          Container(
            height: 10,
            color: Colors.grey[100],
            alignment: Alignment.center,
            child: const SizedBox(),
          ),
          cancelButton(),
        ],
      ),
    );
  }

  // 相机
  Widget cameraButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      //onTap: Platform.isIOS?clickOpenCamera:clickOpenCameraForAndroid,
      onTap: () => {Platform.isIOS ? clickOpenCamera() : clickOpenCameraForAndroid()},
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: const Text(
          "相机拍照",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }

  // 照片图库
  Widget photoButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      // onTap: Platform.isIOS?clickOpenGallery:clickOpenGalleryForAndroid,
      onTap: () => {Platform.isIOS ? clickOpenGallery() : clickOpenGalleryForAndroid()},
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: const Text(
          "相册选取",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
    );
  }

  // 取消弹出框
  Widget cancelButton() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Get.back();
      },
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: const Text("取消", style: TextStyle(fontSize: 18, color: Colors.red)),
      ),
    );
  }

  //携带平台的判断
  clickOpenCameraForAndroid() async {
    //动态权限处理
    List<Permission> permissions;

    if(AppManager.osSdkIntForAndroid<ANDROID_OS_SDK_33) {
      permissions = [Permission.camera,Permission.storage];
    }else {
      permissions = [Permission.camera,Permission.manageExternalStorage];
    }

    BaseController baseController = BaseController();
    bool hasPermissionNotAllow = await baseController.checkPermissionAndroidList(permissions);
    if (hasPermissionNotAllow) {
      CommonTools.showDialogPermissionAndroidList(
          permissions: permissions,
          messageToUser: permission_content_camera_storage,
          doGranted: () {
            clickOpenCamera();
          });
    } else {
      clickOpenCamera();
    }
  }

  clickOpenGalleryForAndroid() async {

    List<Permission> permissions;
    if(AppManager.osSdkIntForAndroid<ANDROID_OS_SDK_33) {
      permissions = [Permission.storage];
    }else {
      permissions = [Permission.manageExternalStorage];
    }

    BaseController baseController = BaseController();
    bool hasPermissionNotAllow = await baseController.checkPermissionAndroidList(permissions);
    if (hasPermissionNotAllow) {
      CommonTools.showDialogPermissionAndroidList(
          permissions: permissions,
          messageToUser: permission_content_camera_album_storage,
          doGranted: () {
            clickOpenGallery();
          });
    } else {
      clickOpenGallery();
    }
  }

  //打开相机的逻辑，获取拍照权限用到
  clickOpenCamera() async {
    Get.back();
    AssetEntity? assets = await CameraPicker.pickFromCamera(context);
    assets?.file.then((value) async {
      await _modifyUserIconHttp(value!.path);
      setState(() {});
    });
  }

  //打开相册的逻辑，因为获取图片的权限，所以需要异步处理
  clickOpenGallery() async {
    Get.back();
    final config = AssetPickerConfig(maxAssets: 1, requestType: RequestType.common, specialPickerType: SpecialPickerType.wechatMoment);
    final List<AssetEntity>? assets = await AssetPicker.pickAssets(context, pickerConfig: config);
    for (var i = 0; i < assets!.length; i++) {
      var asset = assets[i];
      asset.file.then((value) async {
        await _modifyUserIconHttp(value!.path);
        setState(() {});
      });
    }
  }
}
