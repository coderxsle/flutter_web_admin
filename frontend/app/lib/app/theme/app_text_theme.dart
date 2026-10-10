import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_theme.dart';

TextStyle whiteStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: TdColors.white);
TextStyle whiteBoldStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: TdColors.white);

TextStyle greenStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: Colors.green);
TextStyle greenBoldStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: Colors.green);

TextStyle greyStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: TdColors.grey153);
TextStyle greyBoldStyle({double? font}) => TextStyle(fontSize: font, fontWeight: FontWeight.bold, color: TdColors.grey153);

//分享页面用的灰色字体
TextStyle greyStyle85({double? font}) => TextStyle(fontSize: font??14.5.sp, color: TdColors.grey85);
TextStyle greyBoldStyle85({double? font}) => TextStyle(fontSize: font, fontWeight: FontWeight.bold, color: TdColors.grey85);

//灰色 颜色更浅一些
TextStyle greyStyle135({double? font}) => TextStyle(fontSize: font??14.5.sp, color: TdColors.grey135);
TextStyle greyBoldStyle135({double? font}) => TextStyle(fontSize: font, fontWeight: FontWeight.bold, color: TdColors.grey135);

TextStyle redThemeStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: TdColors.brand);
TextStyle redThemeBoldStyle({double? font}) => TextStyle(fontSize: font, fontWeight: FontWeight.bold, color: TdColors.brand);

TextStyle blackStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: TdColors.textPrimary);
TextStyle blackBoldStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: TdColors.textPrimary);

//斜体字
TextStyle blackStyleItalic({double? font}) => TextStyle(fontSize: font??14.5.sp, color: TdColors.textPrimary,fontStyle: FontStyle.italic);
TextStyle blackBoldStyleItalic({double? font}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: TdColors.textPrimary,fontStyle: FontStyle.italic);

//筛选条件的小文字
TextStyle blackStyleDropdown({double? font}) => TextStyle(fontSize: font??10.5.sp, color: TdColors.textPrimary);
TextStyle blackStyleDropdown11({double? font}) => TextStyle(fontSize: font??11.5.sp, color: TdColors.textPrimary);
// blackBoldStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: TdColors.textPrimary);

TextStyle redStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: TdColors.red);
TextStyle redBoldStyle({double? font,}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: TdColors.red);
//携带字符间间距
TextStyle redBoldStyleWithLetterSpacing({double? font,double? letterSpacing}) => TextStyle(
  fontSize: font??14.5.sp,
  fontWeight: FontWeight.bold,
  color: TdColors.red,
  letterSpacing: letterSpacing??1.2,);

TextStyle blueStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: TdColors.blue);
TextStyle blueBoldStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: TdColors.blue);

TextStyle statusStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: TdColors.red);
TextStyle statusBoldStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: TdColors.red);

TextStyle orangeStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, color: TdColors.orange);
TextStyle orangeBoldStyle({double? font}) => TextStyle(fontSize: font??14.5.sp, fontWeight: FontWeight.bold, color: TdColors.orangeLight);
