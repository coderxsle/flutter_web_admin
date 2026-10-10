// import 'dart:async';
// import 'package:flutter/material.dart';
// import '../../app/utils/global.dart';
//
// class CountDownButton extends StatefulWidget {
//   final Function? onTimerFinish;
//   final Function? onTap;
//   const CountDownButton({super.key, this.onTimerFinish, this.onTap});
//
//   @override
//   State<StatefulWidget> createState() => CountDownButtonState();
// }
//
// class CountDownButtonState extends State<CountDownButton> {
//   late Timer _timer;
//   int _countdownTime = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//         onPressed: () {
//           widget.onTap!();
//         },
//         style: ElevatedButton.styleFrom(
//           foregroundColor: _countdownTime == 0 ? ThemeColor : BGColor_grey_201,
//           //change background color of button
//           disabledBackgroundColor: Colors.white,
//           //change text color of button
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(25),
//           ),
//         ),
//         child: Text(
//           _countdownTime > 0 ? '$_countdownTime后重新获取' : '获取验证码',
//           style: const TextStyle(
//             fontSize: 14,
//             color: BGColor_white_255,
//           ),
//         ),
//     );
//   }
//
//   startCountdownTimer() {
//     if (_countdownTime == 0) {
//       setState(() {
//         _countdownTime = 60;
//       });
//     }
//
//     //开始倒计时
//     // startCountdownTimer();
//
//     _timer = Timer.periodic(
//         const Duration(seconds: 1), (Timer timer) {
//           if (_countdownTime < 1) {
//               widget.onTimerFinish!();
//               _timer.cancel();
//             } else {
//               _countdownTime = _countdownTime - 1;
//             }
//             setState(() { });
//         });
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _timer.cancel();
//   }
// }