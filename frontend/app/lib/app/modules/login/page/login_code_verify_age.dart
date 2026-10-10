import 'dart:async';

import 'package:f_verification_box/f_verification_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/global.dart';

class LoginCodeVerifyPage extends StatefulWidget {
  const LoginCodeVerifyPage({super.key});

  @override
  LoginCodeVerifyPageState createState() => LoginCodeVerifyPageState();
}

class LoginCodeVerifyPageState extends State<LoginCodeVerifyPage> {


  //手机号码
  String _phoneNum = '';
  var _data;
  int _codeLength = 4;

  //短信验证码按钮标题
  String _sendMessageTitle = '重新获取验证码' ;
  Timer? _timer;
  int _countdownTime = 120;


  @override
  void initState() {
    super.initState();
    _phoneNum = Get.arguments["phone"];
    _data = Get.arguments["data"];

    try{
      _codeLength = _data["codeLength"];
      _countdownTime = _data['time'];
    }catch(e){
      _codeLength = 4;
      _countdownTime = 120;
    }
    startCountdownTimer();

  }

  @override
  void dispose() {
    try{ _timer!.cancel(); }catch(_) { }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      right: true,
      bottom: false,
      left: true,
      top: false,
      child: Scaffold(
          appBar: AppBar(
            title: const Text(""),
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, size: 28, color: Font_Color_Black_34),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body:GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(35, 100, 35, 5),
                    child: const Text("输入验证码", style: TextStyle(fontSize: 30, color: Color.fromRGBO(34, 34, 34, 1),fontWeight: FontWeight.w500),),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(35, 0, 35, 0),
                    child: Text("验证码已发送至: $_phoneNum", style: const TextStyle(fontSize: 18, color: Font_Color_grey_85),),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 30),
                    child: VerificationBox(
                      textStyle: const TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
                      type: VerificationBoxItemType.underline,
                      showCursor: true,
                      count: _codeLength,
                      onChanged: (e) {
                        debugPrint(e);
                      },
                      onSubmitted: (str, clear) async {
                        // login(str);
                      },
                    ),
                  ),

                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(35, 22, 23, 0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        if(_countdownTime == 0){
                          // _PubVillageV1SmsGetAppLoginSmsCodeHttp();
                        }else {
                          showMessage("请稍等...");
                        }
                      },
                      child: Text(_sendMessageTitle, style: TextStyle(fontSize: 20, color: (_countdownTime == 0) ? ThemeColor : const Color.fromRGBO(120, 120, 120, 1))),
                    ),
                  ),
                  const SizedBox(height: 1),
                  // Container(
                  //   padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                  //   alignment: Alignment.centerLeft,
                  //   child: GestureDetector(
                  //     behavior: HitTestBehavior.opaque,
                  //     onTap: (){
                  //       Get.toNamed("/LoginPassWordPage");
                  //     },
                  //     child: Container(
                  //       padding: const EdgeInsets.fromLTRB(0, 0, 10, 13),
                  //       child:const Text("使用密码登录",style: TextStyle(fontSize: 15,color: Color.fromRGBO(51, 51, 51, 1)),),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          )
      ),
    );
  }

  void startCountdownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer){
      if(mounted){
        setState(() {
          if (_countdownTime < 1) {
            _timer!.cancel();
          } else {
            _countdownTime = _countdownTime - 1;
            _sendMessageTitle = '$_countdownTime 秒后可重新获取验证码';
            if (_countdownTime == 0) {
              _sendMessageTitle = '重新获取验证码';
            }
          }
        });
      }
    });
  }

}