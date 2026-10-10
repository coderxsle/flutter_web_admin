import 'dart:async';

import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http_manager/result_analyzed.dart';

import '../../../utils/global.dart';
import '../../../utils/result_code.dart';
import '../http/account_request.dart';

class ModifyPhoneNumberPage extends StatefulWidget {
  const ModifyPhoneNumberPage({super.key});

  @override
  State<ModifyPhoneNumberPage> createState() => _ModifyPhoneNumberPageState();
}

class _ModifyPhoneNumberPageState extends State<ModifyPhoneNumberPage> {

  //手机号码
  final TextEditingController _phoneNumberController = TextEditingController();
  //验证码
  final TextEditingController _codeNumberController = TextEditingController();
  // 可以获取验证码
  bool _canGetCode = false;

  //短信验证码按钮标题
  String _sendMessageTitle = '获取验证码';
  Timer? _timer;
  int _countdownTime = 0;

  /// 验证手机号是否可以修改
  Future _AuthV1CustomerVerifyPhoneForAppHttp() async {
    // ResponseAnalyzed result = await AuthV1CustomerVerifyPhoneForApp(phone: _phoneNumberController.text);
    // if (result.code == ResultCode.success) {
    //   if (result.data is Map) {
    //     if ((result.data as Map).containsKey('isExist')) {
    //       String isExist = result.data['isExist'].toString();
    //       if (result.data['isExist'] == 3) {
    //         _PubVillageV1SmsSendSmsCodeHttp(isExist);
    //       }else if (result.data['isExist'] == 2) {
    //         String desc = result.data['desc'];
    //         // 弹框提示，是否确定修改的操作
    //         showTipMessageToUser(desc, isExist);
    //       }else { /// result.data['isExist'] <= 1
    //         showMessage(result.data['desc']);
    //       }
    //     }
    //   }
    // }else {
    //
    // }
  }

  /// 获取验证码
  Future _PubVillageV1SmsSendSmsCodeHttp(String isExist) async {
    // showLoadingMessage("正在获取验证码...");
    // String _phone = _phoneNumberController.text;
    // ResponseAnalyzed result = await PubVillageV1SmsSendSmsCode(phone: _phone, isExist: isExist, uuid: AppManager.uuid);
    // dismissLoading();
    // if (result.code == ResultCode.success) {
    //   //   {"codeLength": 4, "time": 120, "timeUnit": "SECONDS" }
    //   /// 开启重新获取验证码的倒计时
    //   startCountdownTimer(result.data['time']);
    // }else {
    //   if (result.isExposedToUser) {
    //     /// 判断结果码是否面向用户
    //     result.show();
    //   }
    // }
  }

  /// 提交修改手机号
  Future authV1CustomerModifyPhoneForAppHttp() async {
    String phone = _phoneNumberController.text;
    String code = _codeNumberController.text;
    ResponseAnalyzed result = await AuthV1CustomerModifyPhoneForApp(phone: phone, uuid: AppManager.uuid, verificationCode: code);
    if (result.code == ResultCode.success) {
      /// 手机号修改成功后，需要退出当前的登录状态
      AppManager.signOut();
    }
  }

  /// 弹出提示框，选择操作流程
  showTipMessageToUser(String desc, String isExist) {
    showDialog(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('温馨提示',style: TextStyle(fontSize: 17),),
          content: Container(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
            child: Text(desc),
          ),
          actions:<Widget>[
            CupertinoDialogAction(
              child: const Text('取消',style: TextStyle(color: Color.fromRGBO(215, 85, 82,  1)),),
              onPressed: () {
                Get.back();
              },
            ),
            CupertinoDialogAction(
              child: const Text('确定'),
              onPressed: () async {
                Get.back();
                /// 获取验证码
                _PubVillageV1SmsSendSmsCodeHttp(isExist);
              },
            ),
          ],
        );
      },
    );
  }
  /// 验证码倒计时(倒计时结束后可重新获取)
  void startCountdownTimer(int second) {
    _countdownTime = second;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print('_canGetCode = $_canGetCode, _countdownTime = $_countdownTime');
      bool phoneNumber = _phoneNumberController.text.length == 11 ? true : false;
      _canGetCode = (phoneNumber && _countdownTime == 0) ? true : false;
      if(mounted){
        setState(() {
          if (_countdownTime < 1) {
            _timer!.cancel();
          } else {
            _countdownTime = _countdownTime - 1;
            _sendMessageTitle = '$_countdownTime 秒';
            if (_countdownTime == 0) {
              _sendMessageTitle = '获取验证码';
              _canGetCode = (phoneNumber && _countdownTime == 0) ? true : false;
              // print('_canGetCode = $_canGetCode, _countdownTime = $_countdownTime');
            }
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const NavigatorTitle("修改手机号"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: BGColor_white_255),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        alignment: Alignment.centerLeft,
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              // padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
              padding: const EdgeInsets.fromLTRB(0, 20, 10, 10),
              child: const Text("绑定新号码", style: TextStyle(fontSize: 20)),
            ), // 标题-绑定新号码
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: TextField(
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(15, 0, 0, 0),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  icon: Text("+86", style: TextStyle(fontSize: 18,color: Colors.black),),
                  hintText: '请输入手机号',
                  hintStyle: TextStyle(color: Colors.grey,fontSize: 18),
                ),
                controller: _phoneNumberController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                  // FilteringTextInputFormatter.digitsOnly
                  LengthLimitingTextInputFormatter(11),
                ],
                autocorrect:false,

                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.black,fontSize: 18),
                onChanged: (e){
                  setState(() {
                    _canGetCode = e.length == 11 ? true : false;
                  });
                },
              ),
            ), // 输入框-请输入手机号
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(0, 20, 10, 10),
              child: const Text("短信验证码", style: TextStyle(fontSize: 20)),
            ), // 标题-短信验证码
            Row(
              children: [
                Container(
                  color: Colors.white,
                  width: screenWidth(context) / 2 - 10,
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  // margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                  child: TextField(
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: '请输入验证码',
                      hintStyle: TextStyle(color: Colors.grey,fontSize: 18),
                    ),
                    controller: _codeNumberController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      // FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(11),
                    ],
                    autocorrect:false,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(color: Colors.black,fontSize: 18),
                    onChanged: (e){
                      _canGetCode = e.length == 11 ? true : false;
                    },
                  ),
                ), // 输入框-请输入短信验证码
                Container(
                  width: screenWidth(context) / 2 - 40,
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () async{
                      FocusScope.of(context).requestFocus(FocusNode());
                      if(_phoneNumberController.text == ""){
                        showMessage("请输入手机号");
                        return;
                      }
                      // 验证手机是否存在
                      _AuthV1CustomerVerifyPhoneForAppHttp();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _canGetCode
                            ? const Color.fromRGBO(86, 180, 252, 1) // 蓝色
                            : const Color.fromRGBO(229, 228, 233, 1), // 灰色
                        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text(
                        _sendMessageTitle,
                        style: TextStyle(
                            fontSize: 15,
                            color: _canGetCode
                                ? Colors.white
                                : const Color.fromRGBO(153, 153, 153, 1)
                        )
                      ),
                    )
                  ), // 按钮-获取验证码
                ), // 按钮-获取验证码
              ],
            ), // 输入框-短信验证码 + 按钮-获取验证码
            Container(
              padding: const EdgeInsets.fromLTRB(12, 50, 12, 40),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: (){
                  if(_codeNumberController.text.isEmpty){
                    showMessage("请输入验证码");
                    return;
                  }
                  authV1CustomerModifyPhoneForAppHttp();
                },
                child:Container(
                  decoration:const BoxDecoration(
                    color: ThemeColor,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  alignment: Alignment.center,
                  padding:const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  child : const Text("提交",style: TextStyle(fontSize: 15,color: Colors.white),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    try{ _timer!.cancel(); }catch(_) { }
    super.dispose();
  }
}
