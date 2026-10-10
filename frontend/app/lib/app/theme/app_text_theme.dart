import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

whiteStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: Font_Color_white_255);
whiteBoldStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: Font_Color_white_255);

greenStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: Colors.green);
greenBoldStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: Colors.green);

greyStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: Font_Color_grey_153);
greyBoldStyle({double? font}) => TextStyle(fontSize: font, fontWeight: FontWeight.bold, color: Font_Color_grey_153);

//分享页面用的灰色字体
greyStyle85({double? font}) => TextStyle(fontSize: font??14.5.sp, color: Font_Color_grey_85);
greyBoldStyle85({double? font}) => TextStyle(fontSize: font, fontWeight: FontWeight.bold, color: Font_Color_grey_85);

//灰色 颜色更浅一些
greyStyle135({double? font}) => TextStyle(fontSize: font??14.5.sp, color: Font_Color_grey_135);
greyBoldStyle135({double? font}) => TextStyle(fontSize: font, fontWeight: FontWeight.bold, color: Font_Color_grey_135);

redThemeStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: ThemeColor);
redThemeBoldStyle({double? font}) => TextStyle(fontSize: font, fontWeight: FontWeight.bold, color: ThemeColor);

blackStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: Font_Color_Black_34);
blackBoldStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: Font_Color_Black_34);

//斜体字
blackStyleItalic({double? font}) => TextStyle(fontSize: font??14.5.sp, color: Font_Color_Black_34,fontStyle: FontStyle.italic);
blackBoldStyleItalic({double? font}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: Font_Color_Black_34,fontStyle: FontStyle.italic);

//筛选条件的小文字
blackStyleDropdown({double? font}) => TextStyle(fontSize: font??10.5.sp, color: Font_Color_Black_34);
blackStyleDropdown11({double? font}) => TextStyle(fontSize: font??11.5.sp, color: Font_Color_Black_34);
// blackBoldStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: Font_Color_Black_34);

redStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: Font_Color_red);
redBoldStyle({double? font,}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: Font_Color_red);
//携带字符间间距
redBoldStyleWithLetterSpacing({double? font,double? letterSpacing}) => TextStyle(
  fontSize: font??14.5.sp,
  fontWeight: FontWeight.bold,
  color: Font_Color_red,
  letterSpacing: letterSpacing??1.2,);

blueStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: const Color.fromRGBO(5, 33, 245, 1));
blueBoldStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: const Color.fromRGBO(5, 33, 245, 1));

statusStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: Font_Color_red);
statusBoldStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: Font_Color_red);

orangeStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: Font_Orange_dark);
orangeBoldStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: Font_Orange_light);
