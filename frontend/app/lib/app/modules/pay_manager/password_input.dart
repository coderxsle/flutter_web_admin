// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/app/modules/pay_manager/number_keyboard.dart';
import 'package:flutter/material.dart';

import 'password_field.dart';



/// 支付密码  +  自定义键盘
class PasswordInput extends StatefulWidget {
  static const String sName = "enter";
  Function(String value) onChange;
  PasswordInput({super.key, required this.onChange});
  @override
  State<StatefulWidget> createState() {
    return PasswordInputState();
  }
}

class PasswordInputState extends State<PasswordInput> {
 /// 用户输入的密码
  String pwdData = '';

    /*
    GlobalKey：整个应用程序中唯一的键
    ScaffoldState：Scaffold框架的状态
    解释：_scaffoldKey的值是Scaffold框架状态的唯一键
   */
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // VoidCallback：没有参数并且不返回数据的回调
  late VoidCallback _showBottomSheetCallback;

  @override
  void initState() async {
    super.initState();
    _showBottomSheetCallback = _showBottomSheet;
    afterDelay(100, callBack: (){
      _showBottomSheetCallback();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext c) {
    return Container(
      padding: const EdgeInsets.only(top: 35.0),
      width: double.maxFinite,
      child: Column(
        children: [
          const Text('请输入支付密码', 
            style: TextStyle(fontSize: 18.0, color: Color(0xff333333))
          ),
          ///密码框
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: _buildPwd(pwdData),
          ),
        ],
      ),
    );
  }

  // 密码键盘 确认按钮 事件
  void onAffirmButton() {

  }

/// 密码键盘的整体回调，根据不同的按钮事件来进行相应的逻辑实现
  void _onKeyDown(dynamic data) {

    // 如果点击了删除按钮，则将密码进行修改
    if (data.isDelete()) {
      if (pwdData.isNotEmpty) {
        pwdData = pwdData.substring(0, pwdData.length - 1);
        setState(() {});
      }
    } else if (data.isCommit()) {
      // 点击了确定按钮时
      if (pwdData.length != 6) {
        // Fluttertoast.showToast(msg: "密码不足6位，请重试", gravity: ToastGravity.CENTER);
        return;
      }
      onAffirmButton();
    } else if (pwdData.length < 6) {
      // 点击了数字按钮时  将密码进行完整的拼接
      pwdData += data.key;
      setState(() {});
    }
    widget.onChange(pwdData);
  }
  
  /// 底部弹出 自定义键盘  下滑消失
  void _showBottomSheet() {
    setState(() {
      // disable the button  // 禁用按钮
      // _showBottomSheetCallback = null;
      _showBottomSheetCallback = (){};

    });

    /*
      currentState：获取具有此全局键的树中的控件状态
      showBottomSheet：显示持久性的质感设计底部面板
      解释：联系上文，_scaffoldKey是Scaffold框架状态的唯一键，因此代码大意为，
           在Scaffold框架中显示持久性的质感设计底部面板
     */
    _scaffoldKey.currentState?.showBottomSheet((BuildContext context) {
     /// 将自定义的密码键盘作为其child   这里将回调函数传入
      return NumberKeyboard(callback: _onKeyDown);
    }).closed.whenComplete(() {
      if (mounted) {
        setState(() {
          // re-enable the button  // 重新启用按钮
          _showBottomSheetCallback = _showBottomSheet;
        });
      }
    });
  }

  /// 构建 密码输入框  定义了其宽度和高度
  Widget _buildPwd(var pwd) {
    return GestureDetector(
      child: Container(
        width: 320, height: 50.0,
        color: Colors.white,  // 自定义密码输入框的使用
        child: PasswordField(data: pwd),
      ),
      // 用户点击输入框的时候，弹出自定义的键盘
      onTap: () {
        _showBottomSheetCallback();
      },
    );
  }
}

