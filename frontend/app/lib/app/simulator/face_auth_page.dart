// import 'dart:async';
// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:auto_shop_server/app/utils/global.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../Base/app_manager.dart';
// import '../../login/page/login_account_page.dart';
// import '../../app_launching/loacal_storage.dart';
// import 'package:native_auth/native_auth.dart';
//
//
//
// class FaceAuthPage extends StatefulWidget {
//   const FaceAuthPage({super.key});
//   @override
//   State<FaceAuthPage> createState() => _FaceAuthPageState();
// }
//
// class _FaceAuthPageState extends State<FaceAuthPage> {
//   final String _help = "为了确保数据安全，需要进行身份验证，请使用生物验证。";
//   String _userName = " ";
//   @override
//   void initState() {
//     super.initState();
//
//     Future.delayed(const Duration(milliseconds: 300)).then((onValue) {
//       _userName = "身份信息获取中...";
//       setState(() {});
//     }).then((value) {
//       Future.delayed(const Duration(milliseconds: 500)).then((onValue) {
//         // _userName = "${AppManager.userAccount!.phone!.replaceFirst(RegExp(r'\d{4}'), '****', 3)}  您好！";
//         // _userName = "${AppManager.userAccount!.customerActors!.first.actorName}  您好！";
//         _userName = "${AppManager.userAccount!.trueName}  您好！";
//         setState(() {});
//       }).then((value) {
//         // Future.delayed(const Duration(milliseconds: 1200)).then((onValue) async {
//         //   auth();
//         // });
//       });
//     });
//   }
//
//   Future<void> auth() async {
//     debugPrint("等待生物认证...");
//     final response = await Auth.isAuthenticate(description: _help);
//     if (response == AuthResult.auth) {
//       // AppManager.auth = true;
//       debugPrint("生物认证成功！");
//       await localStorageWrite("native_auth", true);
//       // await Future.delayed(const Duration(milliseconds: 300));
//       afterDelay(300, callBack: (){
//         Get.offAll(const LoginAccountPage(), bindings: LoginAccountBinding(), arguments: "local_face_auth_login", transition: Transition.noTransition);
//         // Get.offAll(() => const LoginAccountPage(), bindings: LoginAccountBinding(), arguments: "local_face_auth_login", transition: Transition.noTransition);
//       });
//
//     } else if (response == AuthResult.noAuth) {
//       // 取消认证，回到登录界面
//       debugPrint("生物认证 AuthResult.noAuth！");
//       // AppManager.auth = false;
//       await localStorageWrite("native_auth", false);
//     } else {
//       debugPrint("生物认证失败！");
//     }
//   }
//
//   setupSubViews() {
//     return Container(
//       padding: const EdgeInsets.fromLTRB(30, 100, 30, 30),
//       color: Colors.white,
//       child: Column(
//         children: [
//           ClipOval(
//             child: Image.network(AppManager.userAccount!.photoUrl!, width: 100, height: 100, fit: BoxFit.cover, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
//               return SizedBox(
//                 height: 100,
//                 width: 100,
//                 child: Image.asset(
//                   AssetsRes.FACEID_IMAGE,
//                   fit: BoxFit.cover,
//                 ),
//               );
//             }),
//           ),
//           // Text(_userName, style: const TextStyle(fontSize: 25)
//           Container(
//             // width: 200, height: 55,
//             margin: const EdgeInsets.fromLTRB(30, 15, 30, 30),
//             color: Colors.transparent,
//             child: DefaultTextStyle(
//               style: const TextStyle(color: Colors.black, fontSize: 28),
//               child: AnimatedTextKit(
//                 totalRepeatCount: 3,
//                 // isRepeatingAnimation: false,
//                 pause: const Duration(milliseconds: 0),
//                 animatedTexts: [
//                   TypewriterAnimatedText(_userName, cursor: "", speed: const Duration(milliseconds: 35)),
//                 ],
//                 onFinished: () {
//                   auth();
//                 },
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 50,
//           ),
//           GestureDetector(
//             behavior: HitTestBehavior.opaque,
//             onTap: () {
//               auth();
//             },
//             child: const Column(
//               children: [
//                 SizedBox(
//                     width: 60,
//                     height: 60,
//                     child: Image(
//                       image: AssetImage(AssetsRes.IC_FACEID),
//                       fit: BoxFit.fill,
//                     )),
//                 Text("点击进行生物验证登录", style: TextStyle(fontSize: 18, color: Colors.blue)),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 50,
//           ),
//           GestureDetector(
//             behavior: HitTestBehavior.opaque,
//             onTap: () async {
//               await localStorageWrite("native_auth", true);
//               Get.offAllNamed("/LoginAccountPage");
//             },
//             child: const Text("使用密码登录", style: TextStyle(fontSize: 18, color: Colors.blue)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return setupSubViews();
//   }
// }
