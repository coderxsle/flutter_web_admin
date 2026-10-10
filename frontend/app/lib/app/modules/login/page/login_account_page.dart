import 'dart:async';
import 'dart:io';

import 'package:auto_shop_server/main_api.dart';
import 'package:auto_shop_server/res/assets_res.dart';
import 'package:auto_shop_server/common/widgets/remark_view.dart';
import 'package:auto_shop_server/common/widgets/web_view/web_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http_manager/http_manager.dart';

import '../../../utils/global.dart';
import '../../launching/app_launching.dart';
import '../controller/login_account_controller.dart';

/// 禁止输入空格
const String regexNotNull = "[\\s]";

/// 第一个输入字符不能为空格
const String regexFirstNotNull = r'^(\S){1}';

///仅支持数字
const String regexOnlyNumber = "[0-9]";

///仅支持字母和数字
const String regexOnlyNumberText = "|[a-zA-Z]|[0-9]";

/// 仅支持汉子 [\u4e00-\u9fa5]

class LoginAccountPage extends GetView<LoginAccountController> {
  const LoginAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 添加布局初始化保护
    if (MediaQuery.of(context).size.height == 0) {
      return const SizedBox();
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LayoutBuilder(builder: (context, constraints) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _buildBackgroundImage(),
              SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: (Get.height / 5).h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 30.w),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: BGColor_white_255,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
                            shape: BoxShape.rectangle,
                            boxShadow: [
                              BoxShadow(
                                color: BGColor_grey_225,
                                offset: Offset(0, 5),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            _buildTextFieldBackground(),
                            _buildCheckbox(context),
                            _buildLoginButton(),
                            Platform.isIOS ? buildRegisterContainer() : SizedBox(height: 20.h),
                          ]),
                        ),
                      ),
                      SizedBox(height: 32.h),
                      // 嘻嘻哈哈的按钮
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDemo(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  _buildBackgroundImage() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      child: Image(
        image: const AssetImage(AssetsRes.LOGIN_NAVIGATION),
        fit: BoxFit.fitWidth,
        width: Get.width,
      ),
    );
  }

  Widget _buildTextFieldBackground() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.h, 20.h, 20.h, 0),
      child: Stack(
        children: [
          Text("HELLO! 欢迎登录", style: TextStyle(fontSize: 24.sp, color: Colors.blue, fontWeight: FontWeight.w700)),
          Padding(
              padding: EdgeInsets.only(top: 50.w),
              child: Column(
                children: [
                  setupPhoneNumberTextField(),
                  SizedBox(height: 10.w),
                  setupPasswordTextField(),
                ],
              )),
        ],
      ),
    );
  }

  Widget setupPhoneNumberTextField() {
    return buildTextField("请输入账号或手机号", controller.accountVC, focusNode: controller.accountFocusNode, inputType: TextInputType.text, onChanged: (value) {
      controller.accountIsEditing = value.isEmpty ? true : false;
      controller.canLogin = (value.isNotEmpty && controller.checkboxSelected == true) ? true : false;
      controller.update(["loginHistory"]);
    });
  }

  Widget setupPasswordTextField() {
    return buildTextField("请输入密码", controller.passwordVC, obscureText: true, onChanged: (value) {
      controller.canLogin = (controller.accountVC.text.isNotEmpty && value.length >= 6 && controller.checkboxSelected == true) ? true : false;
      controller.update(["canLogin"]);
    });
  }

  TextField buildTextField(hintText, ctrl, {FocusNode? focusNode, TextInputType? inputType, bool? obscureText, ValueChanged<String>? onChanged}) {
    return TextField(
      maxLines: 1,
      obscureText: obscureText ?? false,
      controller: ctrl,
      keyboardType: inputType,
      focusNode: focusNode,
      style: TextStyle(color: Colors.black, fontSize: Platform.isIOS ? 18.h : 16.h),
      // onChanged: (value) {
      //   _accountIsEditing = value.isEmpty ? true : false;
      //   _canLogin = (value.isNotEmpty && _checkboxSelected == true) ? true : false;
      //   setState(() {});
      // },
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey, fontSize: Platform.isIOS ? 16.h : 14.h),
        contentPadding: EdgeInsets.only(left: 10.w, top: 6.w, right: 6.w, bottom: 5.w),
        enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: 0.5)),
        focusedBorder: const OutlineInputBorder(borderSide: BorderSide(color: ThemeColor, width: 0.5)),
      ),
      // inputFormatters: [
      //   FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      //   FilteringTextInputFormatter.digitsOnly,
      //   phoneInputFormatter(),
      //   LengthLimitingTextInputFormatter(13),
      // ],
      // keyboardType: TextInputType.text,
      // FilteringTextInputFormatter.allow（） (白名单校验)，表示只允许输入符合规则的字符 ;
      // FilteringTextInputFormatter.deny（）（黑名单校验)，除了规定的字符,其他都可以输入;
      // LengthLimitingTextInputFormatter ()，（长度限制）
      // inputFormatters: [
      //   LengthLimitingTextInputFormatter(13),
      //   FilteringTextInputFormatter.allow(
      //     RegExp(regexOnlyNumberText), // 禁止输入空格
      //   )
      // ],
    );
  }

  _buildCheckbox(context) {
    return Row(
      children: [
        Transform.scale(
          scale: 1.1.h, // 调整比例，1.5 表示放大 1.5 倍
          child: Padding(
            padding: EdgeInsets.only(left: 8.w, top: 8.w, bottom: 8.w),
            child: GetBuilder<LoginAccountController>(
                id: "checkbox",
                builder: (controller) {
                  return Checkbox(
                    shape: const CircleBorder(),
                    side: const BorderSide(width: 1, color: ThemeColor),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    // 去掉默认的点击区域大小
                    value: controller.checkboxSelected,
                    activeColor: ThemeColor,
                    onChanged: (value) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      controller.checkboxSelected = value!;
                      controller.canLogin = (controller.accountVC.text.isNotEmpty && controller.passwordVC.text.length >= 6 && controller.checkboxSelected == true) ? true : false;
                      controller.update(["checkbox", "canLogin"]);
                    },
                  );
                }),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(left: 10.w, top: 12.w, bottom: 12.w),
            child: Wrap(
              // crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  "已阅读并同意",
                  style: TextStyle(fontSize: 13.h, color: Colors.black87),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.to(() => const WebViewPage(url: agreementUrl, title: "服务协议"));
                  },
                  child: Text(
                    "《服务协议》",
                    style: TextStyle(fontSize: 13.h, color: Colors.blueAccent),
                  ),
                ),
                Text(
                  "和",
                  style: TextStyle(fontSize: 13.h, color: Colors.black87),
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    Get.to(() => const WebViewPage(url: privacyUrl, title: "隐私政策"));
                  },
                  child: Text(
                    "《隐私政策》",
                    style: TextStyle(fontSize: 13.h, color: Colors.blueAccent),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  //android端审核不用显示注册：2024-9-3
  Widget buildRegisterContainer() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.fromLTRB(0, 15, 0, 20.h),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Get.toNamed("/RegisterPage"),
        child: Text("注册", style: TextStyle(fontSize: 16.h, color: Font_Color_red)),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Container(
      height: 44.h,
      padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => controller.gotoLogin(),
        child: GetBuilder<LoginAccountController>(
            id: "canLogin",
            builder: (controller) {
              return Container(
                decoration: BoxDecoration(
                  color: controller.canLogin == true ? ThemeColor : Colors.black12,
                  borderRadius: const BorderRadius.all(Radius.circular(22)),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text("登录", style: TextStyle(fontSize: 16.h, color: controller.canLogin == true ? Colors.white : Colors.black26)),
              );
            }),
      ),
    );
  }

  // Widget historyAccount() {
  //   return GetBuilder<LoginAccountController>(id: "loginHistory", builder: (controller) {
  //     if (controller.accountIsEditing == true && controller.loginHistory.isNotEmpty){
  //       return Container(
  //         color: Colors.grey[200],
  //         height: 130.h, // 控制ListView的高度
  //         child: Column(
  //           children: [
  //             SizedBox(child: Text("登录历史", style: TextStyle(fontSize: 12.h))),
  //             Expanded(
  //               child: ListView.builder(
  //                 padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
  //                 itemCount: controller.loginHistory.length,
  //                 itemBuilder: (context, index) {
  //                   return GestureDetector(
  //                     child: Container(
  //                         color: Colors.white,
  //                         padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
  //                         margin: const EdgeInsets.fromLTRB(6, 0, 6, 1),
  //                         child: Text(controller.loginHistory[index], style: TextStyle(fontSize: 14.h))),
  //                     onTap: () async {
  //                       FocusScope.of(context).requestFocus(FocusNode());
  //                       controller.accountVC.text = controller.loginHistory[index];
  //                       String pwd = await controller.fillPasswordForAccount(controller.accountVC.text) ?? "";
  //                       controller.passwordVC.text = pwd;
  //                       controller.checkboxSelected = true;
  //                       controller.gotoLogin();
  //                     },
  //                   );
  //                 },
  //               ),
  //             ),
  //           ],
  //         ),
  //       );
  //     }else {
  //       return const SizedBox();
  //     }
  //   });
  // }
}

class GestureDemo extends StatefulWidget {
  const GestureDemo({super.key});

  @override
  GestureDemoState createState() => GestureDemoState();
}

class GestureDemoState extends State<GestureDemo> {
  int _tapCount = 0; // 双指点击计数器
  int _pointerCount = 0; // 手指数量计数器
  Timer? _tapTimer; // 点击计时器
  DateTime _lastTapTime = DateTime.now(); // 上次点击时间戳
  Set<int> _activePointers = {}; // 跟踪活动的触摸点

  void _handleTap() {
    final now = DateTime.now();
    final diff = now.difference(_lastTapTime);
    _lastTapTime = now;

    if (_tapTimer != null && _tapTimer!.isActive) {
      _tapTimer!.cancel();
    }

    // 如果两次点击间隔太长，重置点击计数
    if (diff.inMilliseconds > 300) {
      _tapCount = 0;
    }

    _tapCount++;

    // 使用计时器确保在短时间内完成三次点击
      _tapTimer = Timer(const Duration(milliseconds: 300), () {
        if (_tapCount == 3) {
        // 达到三次点击
          AppLaunching.changeNetworkBaseURL();
          setState(() {});
        debugPrint('双指三连击成功');
        }
      _tapCount = 0; // 重置点击计数
      });
  }

  void _setupHost() {
    final hostVC = TextEditingController(text: "192.168.");
    //史宇航台式机
    // final hostVC = TextEditingController(text: "192.168.0.93:8081");
    //史宇航台式机映射外网为了在汽车园区开发
    // final hostVC = TextEditingController(text: "222.222.17.184:8081");
    showAlertDialog(
        title: "联机调试",
        content: Column(
          children: [
            Text("请输入自定义主机地址\n例如：192.168.0.46:70", style: greyStyle(font: 16)),
            const SizedBox(height: 6),
            RemarkView(title: "", controller: hostVC, height: 32, hintText: "请输入联机地址", bgColor: Colors.grey[100]),
          ],
        ),
        confirm: () async {
          AppLaunching.changeNetworkBaseURL(host: hostVC.text);
          dismissAlertDialog();
          setState(() {});
        },
        confirmText: "开始联调",
        cancelText: "取消联调",
        cancel: () {
          AppLaunching.changeNetworkBaseURL();
          dismissAlertDialog();
          setState(() {});
        });
  }

  void _configProxyPage() {
    final hostVC = TextEditingController(text: "192.168.");
    //shiYuHang台式机
    // final hostVC = TextEditingController(text: "192.168.30.62");
    final portVC = TextEditingController(text: "8888");
    showAlertDialog(
        title: "请输入代理",
        content: Column(
          children: [
            // const SizedBox(height: 10,),
            RemarkView(title: "", controller: hostVC, height: 32, hintText: "请输入代理地址", bgColor: Colors.grey[100]),
            const SizedBox(
              height: 10,
            ),
            RemarkView(title: "", controller: portVC, height: 32, hintText: "请输入端口号", bgColor: Colors.grey[100]),
          ],
        ),
        confirm: () async {
          httpManager.setProxy(host: hostVC.text, port: portVC.text);
          showMessage("代理设置成功");
          dismissAlertDialog();
        },
        confirmText: "开启联机",
        cancelText: "关闭代理",
        cancel: () {
          httpManager.setProxy();
          dismissAlertDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    bool localhost = false;
    final baseUrl = httpManager.baseUrl;
    if (baseUrl.startsWith("http://192.168.") || baseUrl.startsWith("http://222.222.17.184")) {
      localhost = true;
    }
    const title = "双指三连击切换：正式环境 / 测试环境\n\n本按钮仅http://192.168.x.x时显示";
    return Listener(
        onPointerDown: (PointerDownEvent event) {
          _activePointers.add(event.pointer);
          _pointerCount = _activePointers.length;
          
          // 仅当双指触摸时才处理点击事件
          if (_pointerCount == 2) {
            _handleTap();
          }
        },
        onPointerUp: (PointerUpEvent event) {
          _activePointers.remove(event.pointer);
          _pointerCount = _activePointers.length;
        },
        onPointerCancel: (PointerCancelEvent event) {
          _activePointers.remove(event.pointer);
          _pointerCount = _activePointers.length;
        },
        child: Container(
          height: 150,
          alignment: Alignment.center,
          margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          // padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
          // color: localhost ? Colors.green[200] : Colors.transparent,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: localhost ? Colors.green[100] : Colors.transparent,
          ),
          child: localhost
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _button("测试环境", Colors.blueAccent, () {
                          setState(() => AppLaunching.changeNetworkBaseURL(host: baseURLTest));
                        }),
                        _button("正式环境", Colors.green, () {
                          setState(() => AppLaunching.changeNetworkBaseURL(host: baseURL));
                        }),
                        _button("自定义环境", Colors.redAccent, () => _setupHost()),
                        _button("设置代理", Colors.orange, () => _configProxyPage()),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(title, style: blueStyle(font: 12)),
                  ],
                )
              : const Text(""),
        ));
  }

  _button(String title, Color color, VoidCallback? onPressed) {
    return SizedBox(
      height: 32,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Text(title, style: whiteBoldStyle(font: 12)),
      ),
    );
  }
}
