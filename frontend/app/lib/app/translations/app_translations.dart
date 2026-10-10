import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'en_US/en_us.dart';
import 'zh_CN/zh_cn.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': en,
    'zh_CN': zhCN,
  };

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('zh', 'CN'),
  ];
  static const fallbackLocale = Locale('en');
}
