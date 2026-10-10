import 'package:flutter/material.dart';



/// 自定义密码 键盘
///  支符密码  用于 密码输入框和键盘之间进行通信
class KeyEvent {
 ///  当前点击的按钮所代表的值
  String key;
  KeyEvent(this.key);
  bool isDelete() => key == "del";
  bool isCommit() => key == "commit";
}

class NumberKeyboard extends StatefulWidget {
  final callback;
  const NumberKeyboard({super.key, this.callback});

  @override
  State<NumberKeyboard> createState() => _NumberKeyboardState();
}

class _NumberKeyboardState extends State<NumberKeyboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// 定义 确定 按钮 接口  暴露给调用方
  ///回调函数执行体
  var backMethod;
  void onCommitChange() {
    widget.callback(KeyEvent("commit"));
  }

  void onOneChange(BuildContext cont) {
    widget.callback(KeyEvent("1"));
  }

  void onTwoChange(BuildContext cont) {
    widget.callback(KeyEvent("2"));
  }

  void onThreeChange(BuildContext cont) {
    widget.callback(KeyEvent("3"));
  }

  void onFourChange(BuildContext cont) {
    widget.callback(KeyEvent("4"));
  }

  void onFiveChange(BuildContext cont) {
    widget.callback(KeyEvent("5"));
  }

  void onSixChange(BuildContext cont) {
    widget.callback(KeyEvent("6"));
  }

  void onSevenChange(BuildContext cont) {
    widget.callback(KeyEvent("7"));
  }

  void onEightChange(BuildContext cont) {
    widget.callback(KeyEvent("8"));
  }

  void onNineChange(BuildContext cont) {
    widget.callback(KeyEvent("9"));
  }

  void onZeroChange(BuildContext cont) {
    widget.callback(KeyEvent("0"));
  }

  /// 点击删除
  void onDeleteChange() {
    widget.callback(KeyEvent("del"));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _scaffoldKey,
      width: double.infinity,
      height: 280,
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            height: 44,
            color: Colors.white,
            alignment: Alignment.center,
            child: const Text(
              '下滑隐藏',
              style: TextStyle(fontSize: 12.0, color: Color(0xff999999)),
            ),
          ),

          ///  键盘主体
          Column(
            children: <Widget>[
              ///  第一行
              Row(
                children: <Widget>[
                  KeybordNumberButton(
                      text: '1', onChange: (val) => onOneChange(context)),
                  KeybordNumberButton(
                      text: '2', onChange: (val) => onTwoChange(context)),
                  KeybordNumberButton(
                      text: '3', onChange: (val) => onThreeChange(context)),
                ],
              ),

              ///  第二行
              Row(
                children: <Widget>[
                  KeybordNumberButton(
                      text: '4', onChange: (val) => onFourChange(context)),
                  KeybordNumberButton(
                      text: '5', onChange: (val) => onFiveChange(context)),
                  KeybordNumberButton(
                      text: '6', onChange: (val) => onSixChange(context)),
                ],
              ),

              ///  第三行
              Row(
                children: <Widget>[
                  KeybordNumberButton(
                      text: '7', onChange: (val) => onSevenChange(context)),
                  KeybordNumberButton(
                      text: '8', onChange: (val) => onEightChange(context)),
                  KeybordNumberButton(
                      text: '9', onChange: (val) => onNineChange(context)),
                ],
              ),

              ///  第四行
              Row(
                children: <Widget>[
                  KeybordNumberButton(text: '确定', onChange: (val) => onCommitChange()),
                  KeybordNumberButton(text: '0', onChange: (val) => onZeroChange(context)),
                  KeybordNumberButton(text: '删除', onChange: (val) => onDeleteChange()),

                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}


///  自定义 键盘 按钮
class KeybordNumberButton extends StatefulWidget {
///  按钮显示的文本内容
  String text;
 ///  按钮 点击事件的回调函数
  final onChange;
  KeybordNumberButton({super.key, required this.text, this.onChange});

  @override
  State<StatefulWidget> createState() {
    return KeybordNumberButtonState();
  }
}

class KeybordNumberButtonState extends State<KeybordNumberButton> {
  ///回调函数执行体
  var backMethod;

  void back() {
    widget.onChange('$backMethod');
  }

  @override
  Widget build(BuildContext context) {

 /// 获取当前屏幕的总宽度，从而得出单个按钮的宽度
    MediaQueryData mediaQuery = MediaQuery.of(context);
    var screenWidth = mediaQuery.size.width;

    return SizedBox(
        height:50.0,
        width: screenWidth / 3,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom( 
            side: const BorderSide(
              width: 0.5, color: Colors.black12
              
            ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          ),
         // 按钮点击事件
          onPressed: back,
          child: Text(
            widget.text,
            style: const TextStyle(color: Color(0xff333333), fontSize: 20.0),
          ),
        ));
  }
}

