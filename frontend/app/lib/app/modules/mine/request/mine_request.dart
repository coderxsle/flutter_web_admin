import 'dart:convert';

import 'package:common_utils/common_utils.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:http_manager/http_manager.dart';

// 修改用户信息/昵称/性别/情感状况/星座/....
Future<ResponseAnalyzed> modifyUserInfo(Map<String, dynamic> param) async {
  String url = "/auth/v1/customerInfo/updateCustomerInfo";
  return await httpManager.postAnalyzing(url, params: param);
}

// 修改头像
modifyUserIconHttp(int customerId, {String imagePath = '', }) async {
  String url = "/auth/v1/customerInfo/uploadPhoto";
  var timestamp = DateTime.now().millisecondsSinceEpoch;
  String timeStr = DateUtil.formatDateMs(timestamp, format: DateFormats.full);
  var img = await MultipartFile.fromFile(imagePath, filename: "$timeStr.png");
  FormData formData = FormData.fromMap({
    "customerId": customerId,
    "imageFile": img,
  });
  var response = await httpManager.upload(url, formData);
  return await ResponseAnalyzed.analyzingAndCheckup(response);
}

// 修改密码前先验证旧密码
Future<ResponseAnalyzed> validatePassword(String password) async {
  const url = '/auth/v1/tenement/customer/validatePassword';
  final md5Pass = md5.convert(utf8.encode(password));
  final pacryptPass = base64Encode(utf8.encode(md5Pass.toString()));
  Map<String, dynamic> param = {'password': pacryptPass};
  debugPrint("param.toString()");
  debugPrint(param.toString());
  return await httpManager.postAnalyzing(url, params: param);
}

// 修改密码
Future<ResponseAnalyzed> modifyPassword(String oldpwd, String newpwd, String affirm) async {
  String url = '/auth/v1/tenement/customer/updatePassword';
  final oldpsMd5Pass = md5.convert(utf8.encode(oldpwd));
  final pacryptOldPass = base64Encode(utf8.encode(oldpsMd5Pass.toString()));
  final newpsMd5Pass = md5.convert(utf8.encode(newpwd));
  final pacryptNewPass = base64Encode(utf8.encode(newpsMd5Pass.toString()));
  final affirmMd5Pass = md5.convert(utf8.encode(affirm));
  final pacryptAffirmPass = base64Encode(utf8.encode(affirmMd5Pass.toString()));
  Map<String, dynamic> param = {
    'oldPassword': pacryptOldPass,
    'password': pacryptNewPass,
    'password2': pacryptAffirmPass
  };
  return await httpManager.postAnalyzing(url, params: param);
}

// 获取员工二维码
Future<ResponseAnalyzed> getUserQRCode() async {
  String url = "/auth/v1/customer/getGenerateUrlLinkImgCode";
  return await httpManager.getAnalyzing(url);
}
