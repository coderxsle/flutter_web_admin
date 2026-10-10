import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenAdapter {
  static width(num value) => value.w;
  static height(num value) => value.h;
  static fontSize(num value) => value.sp;
  static screenWidht() => ScreenUtil().screenWidth;
  static screenHeight() => ScreenUtil().screenHeight;
}