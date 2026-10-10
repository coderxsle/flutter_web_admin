import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/global.dart';

class LoginPassWordPage extends StatefulWidget {
  const LoginPassWordPage({super.key});

  @override
  LoginPassWordPageState createState() => LoginPassWordPageState();
}

class LoginPassWordPageState extends State<LoginPassWordPage> {

  //手机号码
  final TextEditingController _passwordController = TextEditingController();
  bool _visibility = true;
  //可以获取验证码
  bool _canLogin = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(""),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.clear,color: Colors.black,),
            onPressed: (){
              Get.back();
            },
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
                  padding: const EdgeInsets.fromLTRB(23, 18, 23, 47),
                  child: const Text("输入密码",style: TextStyle(fontSize: 22,color: Color.fromRGBO(34, 34, 34, 1),fontWeight: FontWeight.w500),),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(23, 0, 23, 13),
                  child: const Text("密码",style: TextStyle(fontSize: 13,color: Color.fromRGBO(120, 120, 120, 1)),),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(23, 0, 23, 0),
                  child: TextField(
                    decoration: InputDecoration(
                      // isCollapsed: true,
                      contentPadding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      hintText: '请输入密码',
                      hintStyle: const TextStyle(color: Colors.grey,fontSize: 18),
                      suffix: IconButton(
                        icon: Icon(_visibility ? Icons.visibility_off : Icons.visibility,color: const Color.fromRGBO(201, 201, 201, 1),size: 20,),
                        onPressed: (){
                          setState(() {
                            _visibility = !_visibility;
                          });
                        },
                      )
                    ),
                    controller: _passwordController,
                    obscureText:_visibility,
                    autocorrect:false,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.black,fontSize: 18),
                    onChanged: (e){
                      if(e.length > 6){
                        setState(() {
                          _canLogin = true;
                        });
                      }else{
                        setState(() {
                          _canLogin = false;
                        });
                      }

                    },
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  color: const Color.fromRGBO(216, 216, 216, 1),
                  height: 1,
                  margin: const EdgeInsets.fromLTRB(23, 17, 23, 17),
                  child: const SizedBox(),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(22, 0, 22, 0),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      if(_passwordController.text == ""){
                        showMessage("请输入密码");
                        return;
                      }

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: _canLogin ? const Color.fromRGBO(86, 180, 252, 1) : const Color.fromRGBO(229, 228, 233, 1),
                        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(10, 13, 10, 13),
                      child: Text("立刻登录",style: TextStyle(fontSize: 15,color: _canLogin ? Colors.white : const Color.fromRGBO(153, 153, 153, 1)),),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(22, 23, 22, 0),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      Get.back();
                    },
                    child: const Text("使用验证码登录",style: TextStyle(fontSize: 15,color: Color.fromRGBO(51, 51, 51, 1)),),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}