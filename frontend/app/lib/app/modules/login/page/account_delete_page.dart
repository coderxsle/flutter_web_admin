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

class DeleteAccountPage extends StatefulWidget {
  const DeleteAccountPage({super.key});

  @override
  State<DeleteAccountPage> createState() => _DeleteAccountPageState();
}

class _DeleteAccountPageState extends State<DeleteAccountPage> {

  //验证码
  final TextEditingController _codeNumberController = TextEditingController();

  //短信验证码按钮标题
  String _sendMessageTitle = '获取验证码';
  Timer? _timer;
  int _countdownTime = 0;

  @override
  void initState() {
    super.initState();
  }


  /// 获取验证码
  // Future _pubVillageV1SmsGetAppLoginSmsCodeHttp(String phone) async {
  //   showLoadingMessage("正在获取验证码...");
  //   ResultAnalyzed result = await PubVillageV1SmsGetAppLoginSmsCode(phone: phone);
  //   dismissLoading();
  //   if (result.code == ResultCode.success) {
  //     //   {"codeLength": 4, "time": 120, "timeUnit": "SECONDS" }
  //     /// 开启重新获取验证码的倒计时
  //     startCountdownTimer(result.data['time']);
  //   }
  // }

  /// 提交删除账号
  Future _authV1CustomerCancelCustomerHttp() async {
    String code = _codeNumberController.text;
    ResponseAnalyzed result = await AuthV1CustomerCancelCustomerHttp(uuid: AppManager.uuid, verificationCode: code);
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
                // _pubVillageV1SmsGetAppLoginSmsCodeHttp(isExist);
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
      }
    });
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
          title: const NavigatorTitle("删除账号"),
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
                padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
                child: const Text("确认注销当前账户", style: TextStyle(fontSize: 18)),
              ), // 标题-绑定新号码
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                child: const Text("注销账号并删除该账号的所有数据，注销成功后将无法登录，请谨慎操作。", style: TextStyle(color: Font_Color_grey_153, fontSize: 14)),
              ),
              Container(
                alignment: Alignment.centerLeft,
                // padding: const EdgeInsets.fromLTRB(20, 20, 10, 10),
                padding: const EdgeInsets.fromLTRB(0, 20, 10, 0),
                child: Text(AppManager.userAccount!.phone!.replaceFirst(RegExp(r'\d{4}'), '****', 3), style: const TextStyle(fontSize: 26)),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.fromLTRB(0, 20, 10, 10),
                child: const Text("短信验证码", style: TextStyle(fontSize: 18)),
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
                          var phone = AppManager.userAccount!.phone!;
                          // _pubVillageV1SmsGetAppLoginSmsCodeHttp(phone);
                        },
                        child: Container(
                          decoration: const BoxDecoration(
                            color: ThemeColor, // 蓝色
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Text(
                              _sendMessageTitle,
                              style: const TextStyle(fontSize: 15, color: Colors.white)
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
                    _authV1CustomerCancelCustomerHttp();
                  },
                  child:Container(
                    decoration:const BoxDecoration(
                      color: ThemeColor,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    alignment: Alignment.center,
                    padding:const EdgeInsets.fromLTRB(15, 15, 15, 15),
                    child : const Text("确认删除",style: TextStyle(fontSize: 15,color: Colors.white),),
                  ),
                ),
              )
            ],
          ),
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
