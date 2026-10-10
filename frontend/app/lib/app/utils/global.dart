// ignore_for_file: constant_identifier_names
import 'package:auto_shop_server/base/common_request.dart';
import 'package:auto_shop_server/app/utils/app_manager.dart';
import 'package:auto_shop_server/app/utils/styles/paddings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '/app/theme/app_text_theme.dart';

export 'package:auto_shop_server/app/utils/common_widget/my_dialog.dart';

export '/app/theme/app_colors.dart';
export '/app/theme/app_text_theme.dart';
export '/app/utils/common_widget/common_widget.dart';
export '/app/utils/common_widget/load_state.dart';
export '/app/utils/strings.dart';
export '/common/widgets/navigator_title.dart';



const bool Simulator = false;

// 屏幕宽高
double screenWidth(BuildContext context) => MediaQuery.of(context).size.width;
double screenHeight(BuildContext context) => MediaQuery.of(context).size.height;
// 顶部
double navigationH(BuildContext context) => MediaQuery.of(context).padding.top;
// 底部
double tabBarH(BuildContext context) => MediaQuery.of(context).padding.bottom;

/*顶部安全区域远离高度*/
const TopSafeHeight = 44.0;
/*底部安全区域远离高度*/
const BottomSafeHeight = 30.0;
/*状态栏高度*/
const StatusBarHeight = 44.0;
/*导航栏高度*/
const NavBarHeight = 44 + TopSafeHeight;
/*TabBar高度*/
const TabBarHeight = 40.0 + BottomSafeHeight;




// 状态栏字体白色
const SystemUiOverlayStyle light = SystemUiOverlayStyle(
  systemNavigationBarColor: Color(0xFF000000),
  systemNavigationBarDividerColor: null,
  statusBarColor: null,
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.light,
  statusBarBrightness: Brightness.dark,
);


//  状态栏字体黑色
const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
  systemNavigationBarColor: Color(0xFF000000),
  systemNavigationBarDividerColor: null,
  statusBarColor: null,
  systemNavigationBarIconBrightness: Brightness.light,
  statusBarIconBrightness: Brightness.dark,
  statusBarBrightness: Brightness.light,
);

const gender = ["","男","女","保密"];

//统一阴影
const MyButtonBoxShadow = BoxShadow(blurRadius: 8, spreadRadius: 1, color: Colors.grey,offset:Offset(3,3));


// double value = 2.00;
// print(value.price());      // 输出: "2.0"（默认保留1位小数）
extension DoubleFormatting on double? {
  @Deprecated(
    '建议使用 `priceString(value)` 方法，这样可以避免使用 ?? 运算符，处理 null 的问题'
    ' value.price() ?? "0.0" '
  )
  String price([int decimalPlaces = 1]) {
    if (this == null) return "0.0";
    String formatted = this!.toStringAsFixed(decimalPlaces);
    return formatted.endsWith('.0' * decimalPlaces)
        ? formatted.substring(0, formatted.length - (decimalPlaces + 1))
        : formatted;
  }
}

// int value = 3;
// print(value.price(3));     // 传入3 输出: "3.000"（保留3位小数）
// 一个通用的 analyzing 函数，使用泛型和函数参数
extension IntFormatting on int? {
  @Deprecated(
      '建议使用 `priceString(value)` 方法，这样可以避免使用 ?? 运算符，处理 null 的问题'
          ' value.price() ?? "0.0" '
  )
  String price([int decimalPlaces = 1]) {
    if (this == null) return "0.0";
    String formatted = this!.toDouble().toStringAsFixed(decimalPlaces); // 转为 double 以支持小数
    return formatted.endsWith('.0' * decimalPlaces)
        ? formatted.substring(0, formatted.length - (decimalPlaces + 1))
        : formatted;
  }
}

// num value = 5;
// print(value.price(0));     // 输出: "5"（不保留小数）

extension NumFormatting on num? {
  @Deprecated(
      '建议使用 `priceString(value)` 方法，这样可以避免使用 ?? 运算符，处理 null 的问题'
          ' value.price() ?? "0.0" '
  )
  String price([int decimalPlaces = 1]) {
    if (this == null) return "0.0";
    String formatted = this!.toStringAsFixed(decimalPlaces);
    return formatted.endsWith('.0' * decimalPlaces)
        ? formatted.substring(0, formatted.length - (decimalPlaces + 1))
        : formatted;
  }
}


// 返回一个价格字符串，方便展示
// value 为 null 时，返回 "0.0"
// decimalPlaces 默认为 1 保留 1 位小数
String priceString(dynamic value, {int decimalPlaces = 2, bool isEmpty = false}) {
  // 如果传入的值为 null 或空字符串，返回默认的 "0.0"
  if (value == null || (value is String && value.trim().isEmpty)) {
    return isEmpty ? "" : "0.0";
  }

  // 尝试将 String 类型的值转换为数字
  if (value is String) {
    value = double.tryParse(value) ?? 0.0; // 如果无法转换，则默认为 0.0
  }

  // 检查并格式化数字类型
  if (value is int || value is double || value is num) {
    String formatted = value.toStringAsFixed(decimalPlaces);
    // 去掉末尾多余的小数位
      var newValue = formatted.endsWith('.${'0' * decimalPlaces}')
        ? formatted.substring(0, formatted.length - (decimalPlaces + 1))
        : isEmpty ? "" : formatted;
    return newValue;
  }

  // 非预期类型，抛出异常或返回默认值
  throw ArgumentError("Invalid input type. Expected int, double, num, or String.");
}

//标准Http错误尾随
const HTTP_ERROR_STRING = '请求失败，请检查网络或重新刷新';

Future<dynamic> afterDelay(int milliseconds, {required Function() callBack}) async {
  return await Future.delayed(Duration(milliseconds: milliseconds), ()=>callBack());
}

// 判断刘海屏，返回true表示是刘海屏
isNotchScreen(BuildContext context) {
  if (AppManager.deviceModel == "iPad") {
    return false;
  }
  var width = screenWidth(context);
  var height = screenHeight(context);
  var notchValue = width / height * 100;
  if (notchValue == 216 || notchValue == 46) {
    return true;
  }
  return false;
}

// 手机号输入分段
TextInputFormatter phoneInputFormatter() {
  return TextInputFormatter.withFunction((oldValue, newValue) {
    String text = newValue.text;
    //获取光标左边的文本
    final positionStr = (text.substring(0, newValue.selection.baseOffset)).replaceAll(RegExp(r"\s+\b|\b\s"), "");
    //计算格式化后的光标位置
    int length = positionStr.length;
    var position = 0;
    if (length <= 3) {
      position = length;
    } else if (length <= 7) {
      // 因为前面的字符串里面加了一个空格
      position = length + 1;
    } else if (length <= 11) {
      // 因为前面的字符串里面加了两个空格
      position = length + 2;
    } else {
      // 号码本身为 11 位数字，因多了两个空格，故为 13
      position = 13;
    }
    //这里格式化整个输入文本
    text = text.replaceAll(RegExp(r"\s+\b|\b\s"), "");
    var string = "";
    for (int i = 0; i < text.length; i++) {
      // 这里第 4 位，与第 8 位，我们用空格填充
      if (i == 3 || i == 7) {
        if (text[i] != " ") {
          string = "$string ";
        }
      }
      string += text[i];
    }
    return TextEditingValue(
      text: string,
      selection: TextSelection.fromPosition(TextPosition(offset: position, affinity: TextAffinity.upstream)),
    );
  });
}


/// 手机号脱敏
extension PhoneNumberDesensitizer on String {
  String get desensitized {
    RegExp regExp = RegExp(r'^(\d{3})\d{4}(\d{4})$');
    RegExpMatch? match = regExp.firstMatch(this);

    if (match != null) {
      String prefix = match.group(1)!;
      String suffix = match.group(2)!;

      String desensitizedNumber = '$prefix****$suffix';
      return desensitizedNumber;
    } else {
      return this;
    }
  }
}

// 拨打电话
void callUpWithPhoneNumber(String phone) async {
  if (phone.isEmpty) { return; }
  var url = Uri.parse('tel:$phone');
  if (await canLaunchUrl(url)) {
    await launchUrl(url, webViewConfiguration: const WebViewConfiguration(enableJavaScript: true));
  } else {
    throw '手机号异常，不能拨打电话';
  }
}

// 打开拨号页面
Future<void> openDialer(String phone) async {
  if (phone.isEmpty) return;

  final Uri url = Uri(scheme: 'tel', path: phone);
  print('URL: $url');  // 打印 URL 以检查格式

  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw '无法打开拨号页面';
  }
}


///@description 携带电话号码并且上传服务器的代码
Widget createPhoneRow(String key, String? phone, {bool phoneHide = true, EdgeInsetsGeometry? padding, TextAlign? textAlign}) {
  phone = phone ?? "";
  return Padding(
    padding: padding?? EdgeInsets.fromLTRB(0, 0, 0, pad4),
    child: Row(
      mainAxisSize: MainAxisSize.min, // 让 Row 适应内容宽度
      crossAxisAlignment: CrossAxisAlignment.center, // key 垂直居中
        children: [
        Text(key, style: greyStyle()),
        GestureDetector(
          onTap: () {
            // callUpWithPhoneNumber(phone!);
            openDialer(phone??"");
            CommonRequest.addCallHistory(AppManager.userAccount?.communityId, phone ?? "", 1);
          },
          child: Text(phoneHide ? phone.desensitized : phone, style: blueStyle(), textAlign: textAlign)
        ),
      ]
    ),
  );
}

///@description 在右边展示电话号码的行组件
Widget createPhoneRowRight(String key, String? phone, {bool phoneHide = true, EdgeInsetsGeometry? padding}) {
  phone = phone ?? "";
  return Padding(
    padding: padding ?? EdgeInsets.only(right: 10, bottom: 4).r,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween, // 将子组件分散对齐
      children: [
        Text(key, style: greyStyle()),
        GestureDetector(
          onTap: () {
            openDialer(phone ?? "");
            CommonRequest.addCallHistory(AppManager.userAccount?.communityId, phone ?? "", 1);
          },
          child: Text(
            phoneHide ? phone.desensitized : phone, 
            style: blueStyle(),
          )
        ),
      ]
    ),
  );
}


// 需要考虑要不要抽出一个独立的按钮
Widget createButton(String title, {Color? bgColor, Color? fontColor, GestureTapCallback? onTap}) {
  return Container(
    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0).r,
    child: ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), // 设置圆角为10
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add, size: 20.r, color: fontColor),
          SizedBox(width: 8.w),
          Text(title, style: TextStyle(fontSize: 16.sp, color: fontColor)),
        ],
      ),
    ),
  );
}


/// 获取网页的url
// _getWebPageUrl(String url, HttpMethod method) async {
//   var param = {
//     "communityId" : AppManager.userAccount!.communityId!,
//     "userToken" : AppManager.userAccount!.userToken!,
//     "appShareType" : "AutoSteward",
//   };
//   var response = await httpManager.postAnalyzing(url, params: param);
//   return analyzingAndCheckup(response);
// }

// 请求网页地址，再加载网页
// Future<dynamic> pushWebPage(BuildContext context, {String routeName='/WebViewPage', String url = "", HttpMethod method = HttpMethod.get, Map<String,dynamic>? otherParams}) async {
//   var param = <String,dynamic>{
//     "appShareType" : "AutoSteward",
//     "communityId" : AppManager.userAccount!.communityId!,
//     // "showBar" : showBar, // 是否显示网页自己的返回按钮导航栏
//     // "statusBarHeight" : showBar ? (isNotchScreen(context) ? "44" : "20") : "0",
//     // "actionBarHeight" : "44",
//     // 只有家装团购需要，其余不用，全部不传。
//   };

//   if(otherParams!=null){
//     param.addAll(otherParams);
//   }

//   if (url.startsWith("/")) {
//     ResponseAnalyzed result = await _getWebPageUrl(url, method);
//     param["url"] = result.data;
//   }else if (url.startsWith("http")){
//     param["url"] = url;
//   }
//   Get.toNamed(routeName, arguments: param);
// }


// Widget buildAlert(BuildContext context) {
//   return Container(
//     height: 300,
//     decoration: const BoxDecoration(
//       color: Colors.white,
//       borderRadius: BorderRadius.all(Radius.circular(20.0)),
//     ),
//     padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
//     child: Column(
//       children: [
//         Container(
//           alignment: Alignment.center,
//           padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
//           child: const Text("请选择分享到",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500),),
//         ),
//         Container(
//           height: 10,
//           color: Colors.grey[100],
//           alignment: Alignment.center,
//           child: const SizedBox(),
//         ),
//         _wechatButton(),
//         const Divider(height: 1,color: Colors.grey,),
//         _wechat_timelineButton(),
//         Container(
//           height: 10,
//           color: Colors.grey[100],
//           alignment: Alignment.center,
//           child: const SizedBox(),
//         ),
//         _cancelButton(context),
//       ],
//     ),
//   );
// }
// void share(dynamic message, WeChatScene scene) {
//   String linkUrl = message["shareLink"];
//   String imageUrl = message["shareImg"];
//   var model = WeChatShareWebPageModel(
//     linkUrl,
//     title: message["shareTitle"],
//     thumbnail: WeChatImage.network(imageUrl),
//     scene: scene,
//   );
//   Fluwx().share(model);
// }
// Widget _wechatButton() {
//   return GestureDetector(
//     behavior: HitTestBehavior.opaque,
//     onTap: () async{
//       // 好友 SESSION, TIMELINE 朋友圈share
//       share("shareData", WeChatScene.session);
//     },
//     child: Container(
//       alignment: Alignment.centerLeft,
//       padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//       child: const Row(
//         children: [
//           Image(image: AssetImage(AssetsRes.WECHAT), width: 45),
//           SizedBox(width: 10),
//           Text("微信", style: TextStyle(fontSize: 18,color: Colors.black),),
//         ],
//       ),
//     ),
//   );
// }
// Widget _wechat_timelineButton() {
//   return GestureDetector(
//       behavior: HitTestBehavior.opaque,
//       onTap: () async {
//         // 好友 SESSION, TIMELINE 朋友圈share
//         share("shareData", WeChatScene.timeline);
//       },
//       child: Container(
//         alignment: Alignment.centerLeft,
//         padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//         child: const Row(
//           children: [
//             Image(image: AssetImage(AssetsRes.WECHAT_TIMELINE), width: 45),
//             SizedBox(width: 10),
//             Text("微信朋友圈", style: TextStyle(fontSize: 18,color: Colors.black),),
//           ],
//         ),
//       ));
// }
// Widget _cancelButton(BuildContext context) {
//   return GestureDetector(
//     behavior: HitTestBehavior.opaque,
//     onTap: (){
//       Get.back();
//     },
//     child: Container(
//       alignment: Alignment.center,
//       padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
//       child:const Text("取消", style: TextStyle(fontSize: 18,color: Colors.red),),
//     ),
//   );
// }
