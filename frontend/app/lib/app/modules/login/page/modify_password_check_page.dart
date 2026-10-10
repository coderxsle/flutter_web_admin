import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/global.dart';


class ModifyPasswordCheckPage extends StatefulWidget {
  const ModifyPasswordCheckPage({super.key});

  @override
  State<ModifyPasswordCheckPage> createState() => _ModifyPasswordCheckPageState();
}

class _ModifyPasswordCheckPageState extends State<ModifyPasswordCheckPage> {

  //手机号码
  final TextEditingController _phoneController = TextEditingController();
  //验证码
  final TextEditingController _codeController = TextEditingController();
  // 可以获取验证码
  bool _canGetCode = false;

  //短信验证码按钮标题
  String _sendMessageTitle = '获取验证码';
  Timer? _timer;
  int _countdownTime = 0;

  /// 获取验证码
  // Future _PubVillageV1SmsSendSmsCodeHttp(String isExist) async {
  //   String _phone = _phoneController.text;
  //   AnalyzedResult result = await PubVillageV1SmsSendSmsCode(phone: _phone, isExist: isExist, uuid: MainUuid);
  //   if (result.code == ResultCode.success) {
  //     //   {"codeLength": 4, "time": 120, "timeUnit": "SECONDS" }
  //     /// 开启重新获取验证码的倒计时
  //     startCountdownTimer(result.data['time']);
  //   }
  // }

  /// 提交修改密码
  // Future AuthV1CustomerModifyPhoneForAppHttp() async {
  //   String phone = _phoneController.text;
  //   String code = _codeController.text;
  //   AnalyzedResult result = await AuthV1CustomerModifyPhoneForApp(phone: phone, uuid: MainUuid, verificationCode: code);
  //   if (result.code == ResultCode.success) {
  //     /// 手机号修改成功后，需要退出当前的登录状态
  //     Main_UserData?.signOut();
  //   }
  // }

  /// 验证码倒计时(倒计时结束后可重新获取)
  void startCountdownTimer(int second) {
    _countdownTime = second;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      print('_canGetCode = $_canGetCode, _countdownTime = $_countdownTime');
      bool phoneNumber = _phoneController.text.length == 11 ? true : false;
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
          title: const NavigatorTitle("修改登录密码"),
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
                child: const Text("请验证手机号", style: TextStyle(fontSize: 20)),
              ), // 标题-请验证手机号
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
                  controller: _phoneController,
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
                      controller: _codeController,
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
                          if(_phoneController.text == ""){
                            showMessage("请输入手机号");
                            return;
                          }
                          // 验证手机是否存在
                          // _PubVillageV1SmsSendSmsCodeHttp();
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
                          child: Text(_sendMessageTitle,
                              style: TextStyle( fontSize: 15,
                                  color: _canGetCode ? Colors.white : const Color.fromRGBO(153, 153, 153, 1)
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
                    if(_codeController.text.isEmpty){
                      showMessage("请输入验证码");
                      return;
                    }
                    // AuthV1CustomerModifyPhoneForAppHttp();
                  },
                  child:Container(
                    decoration:const BoxDecoration(
                      color: ThemeColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    alignment: Alignment.center,
                    padding:const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child : const Text("去修改",style: TextStyle(fontSize: 15,color: Colors.white),),
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
