import 'dart:async';

import 'package:auto_shop_server/res/assets_res.dart';
import 'package:flutter/material.dart';

import '../../../utils/global.dart';

class AccountRegisterPage extends StatefulWidget {
  const AccountRegisterPage({super.key});

  @override
  State<AccountRegisterPage> createState() => _AccountRegisterPageState();
}

class _AccountRegisterPageState extends State<AccountRegisterPage> {
  /// 记录-姓名
  final TextEditingController _nameVC = TextEditingController();
  /// 记录-手机号
  final TextEditingController _phoneVC = TextEditingController();
  /// 记录-邀请码
  final TextEditingController _invitecodeVC = TextEditingController();
  /// 记录-验证码
  final TextEditingController _verificationCodeVC = TextEditingController();

  final bool _switchValue = false;
  final String _isIncludeCommunity = "1";
  // 短信验证码按钮标题
  String _sendMessageTitle = '获取验证码';
  Timer? _timer;
  int _countdownTime = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const NavigatorTitle("注册"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            children: _isIncludeCommunity == "1" ? communityBuild() : areaBuild(),
          ),
        ),
    );
  }

// Request

  /// 提交添加房产信息
  Future _PubVillageV1LoginSignInHttp(Map<String, dynamic>? param) async {
    // showLoadingMessage("正在提交");
    // ResponseAnalyzed result = await PubVillageV1LoginSignIn(param);
    // dismissLoading();
    // if (result.code == ResultCode.success) {
    //   showMessage("注册成功！");
    //   Get.back();
    // }
  }

  /// 获取验证码
  // Future _pubVillageV1SmsGetAppSignInSmsCodeHttp(String phone) async {
  //   showLoadingMessage("正在获取验证码...");
  //   ResponseAnalyzed result = await PubVillageV1SmsGetAppSignInSmsCode(phone: phone);
  //   dismissLoading();
  //   if (result.code == ResultCode.success) {
  //     //   {"codeLength": 4, "time": 120, "timeUnit": "SECONDS" }
  //     /// 开启重新获取验证码的倒计时
  //     startCountdownTimer(result.data['time']);
  //   }
  // }

  /// 提交
  _submit() {
    if (_nameVC.text.isEmpty) {
      showMessage("请填写姓名");
      return;
    }else if (_phoneVC.text.isEmpty) {
      showMessage("请填写手机号");
      return;
    }
    if (_verificationCodeVC.text.isEmpty) {
      showMessage("请输入验证码");
      return;
    }

    Map<String, dynamic>? param = {
      "name": _nameVC.text,
      "phone": _phoneVC.text,
      "familyName": _nameVC.text,
      "familyPhone": _phoneVC.text,
      "isDefault": _switchValue,
      "recommendCode": _invitecodeVC.text,
      "verificationCode":_verificationCodeVC.text,
    };
    _PubVillageV1LoginSignInHttp(param);
  }

// Widget
  /// 城区端需要填写的数据界面
  List<Widget> communityBuild() {
    return [
      BuildRow(
          imageName: AssetsRes.XINGMING, hintText: "请输入您的姓名", vc: _nameVC, onChanged: (String text) {
            // setState(() { });
          }), // 姓名
      BuildRow(
          imageName: AssetsRes.SHOUJIHAO, hintText: "请输入您的手机号", vc: _phoneVC, onChanged: (String text) {

          }), // 手机号
      SubmitButton(),// 提交按钮
    ];
  }

  /// 乡镇端需要填写的数据界面
  List<Widget> areaBuild() {
    return [
      BuildRow(imageName: AssetsRes.XINGMING, hintText: "请输入您的姓名", vc: _nameVC, onChanged: (String text) {

      }), // 姓名
      BuildRow(imageName: AssetsRes.XINGMING, hintText: "请输入您的手机号", vc: _phoneVC, onChanged: (String text) {

      }), // 手机号
      SubmitButton(), // 提交按钮
    ];
  }

  /// 提交按钮
  Widget SubmitButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 50, 20, 50),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: (){
          _submit();
        },
        child:Container(
          height: 48,
          alignment: Alignment.center,
          decoration:const BoxDecoration(
            color: TdColors.brand,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child : const Text("提交注册",style: TextStyle(fontSize: 18, color: Colors.white),),
        ),
      ),
    );
  }

  /// 验证码倒计时(倒计时结束后可重新获取)
  void startCountdownTimer(int second) {
    _countdownTime = second;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(mounted){
        setState(() {
          if (_countdownTime < 1) {
            _timer!.cancel();
          } else {
            _countdownTime = _countdownTime - 1;
            _sendMessageTitle = '$_countdownTime 秒';
            if (_countdownTime == 0) {
              _sendMessageTitle = '获取验证码';
            }
          }
        });
        setState(() {});
      }
    });
  }

  /// 创建一行cell
  Widget BuildRow({String imageName = "", String? hintText, TextEditingController? vc,
    ValueChanged<String>? onChanged, GestureTapCallback? onTap, bool readOnly = false,
    Widget right = const SizedBox(height: 1)}) {
    return Container(
      // color: TdColors.white,
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 0),
      // margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Row(
        children: [
          Image(image: AssetImage(imageName), width: 20),
          Expanded(flex: 1, child: TextField(
                controller: vc, onChanged: onChanged, onTap: onTap,
                autofocus: true, readOnly: readOnly,
                style: const TextStyle(fontSize: 16, color: Colors.black),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(left: 15),
                  // border: InputBorder.none,
                  hintText: hintText,
                  // enabledBorder: const UnderlineInputBorder(
                  //   borderSide: BorderSide(
                  //       color: Colors.grey,
                  //       width: .25,
                  //       style: BorderStyle.solid),
                  // ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: .25, style: BorderStyle.solid),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: .25, style: BorderStyle.solid),
                  ),
                ),
              )),
          right,
        ],
      ),
    );
  }
}
