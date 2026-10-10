
import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:flutter/material.dart';
import 'package:http_manager/result_analyzed.dart';

import '../../../utils/global.dart';
import '../../../utils/result_code.dart';
import '../../mine/request/mine_request.dart';

class ModifyPasswordPage extends StatefulWidget {
  const ModifyPasswordPage({super.key});

  @override
  State<ModifyPasswordPage> createState() => _ModifyPasswordPageState();
}

class _ModifyPasswordPageState extends State<ModifyPasswordPage> {

  final _oldC = TextEditingController();
  final _newC = TextEditingController();
  final _affirmC = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  void _changeFunc() async {
    if (_oldC.text.isEmpty) {
      showMessage('旧密码不能为空~');
      return;
    }
    if (_newC.text.isEmpty) {
      showMessage('新密码不能为空~');
      return;
    }
    if (_affirmC.text.isEmpty) {
      showMessage('确认密码不能为空~');
      return;
    }
    if (_oldC.text.isNotEmpty && _newC.text.isNotEmpty && _affirmC.text.isNotEmpty) {
      if (_newC.text.length < 8 || _affirmC.text.length < 8) {
        showMessage('新密码不得少于8位！');
        return;
      }
      if (_newC.text != _affirmC.text) {
        showMessage('两次密码输入不一致！');
        return;
      }

      debugPrint(_oldC.text);
      showLoadingMessage("正在提交...");
      validatePassword(_oldC.text).then((value) async {
        debugPrint(_oldC.text);
        if (value.code == ResultCode.success) {
          ResponseAnalyzed result = await modifyPassword(_oldC.text, _newC.text, _affirmC.text);
          if (result.code == ResultCode.success) {
            showMessage("密码修改成功");
            AppManager.signOut();
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const NavigatorTitle("修改密码"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: BGColor_white_255),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Column(
          children: [
            Container(
              height: 180.0,
              padding: const EdgeInsets.all(10.0),
              child: Card(
                elevation: 0.0, //设置阴影
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0))),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      TextField(
                        controller: _oldC,
                        decoration: const InputDecoration(
                          hintText: "请填写旧密码",
                          hintStyle:
                          TextStyle(color: Color(0xFF999999), fontSize: 14.0),
                          prefixIcon: Text('旧密码'),
                          prefixIconConstraints: BoxConstraints(minWidth: 50),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFDEDEDE)),
                          ),
                        ),
                      ),
                      TextField(
                        controller: _newC,
                        decoration: const InputDecoration(
                          hintText: '请输入新密码',
                          hintStyle:
                          TextStyle(color: Color(0xFF999999), fontSize: 14.0),
                          prefixIcon: Text('新密码'),
                          prefixIconConstraints: BoxConstraints(minWidth: 50),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFFDEDEDE)),
                          ),
                        ),
                      ),
                      TextField(
                        controller: _affirmC,
                        decoration: const InputDecoration(
                          hintText: '请再次输入新密码',
                          hintStyle:
                          TextStyle(color: Color(0xFF999999), fontSize: 14.0),
                          prefixIcon: Text('确认密码  '),
                          prefixIconConstraints: BoxConstraints(minWidth: 50),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(children: [
              const SizedBox(width: 15.0),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                width: 350,
                child: const Text(
                    '密码必须是8-16位英文字母、数字、字符组合，\n不能是纯数字',
                    maxLines: 2,
                    style: TextStyle(fontSize: 14.0, color: Color(0xFF666666))),
              )
            ]),
            const SizedBox(height: 40.0),
            SizedBox(
                width: 340.0,
                height: 40.0,
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(ThemeColor),
                        elevation: WidgetStateProperty.all(0.0),
                        shape: WidgetStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22)))),
                    onPressed: () => _changeFunc(),
                    child: const Text('确认修改'))),
          ],
        ),
    );
  }

}

