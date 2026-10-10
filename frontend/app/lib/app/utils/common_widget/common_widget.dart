// ignore_for_file: non_constant_identifier_names
import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/app/utils/styles/paddings.dart';
import 'package:auto_shop_server/res/assets_res.dart';
import 'package:auto_shop_server/common/widgets/common.dart';
import 'package:auto_shop_server/common/widgets/divider_line_light.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../global.dart';

//2025/5/6 我新增了一个textStyleMy用来给右侧字体【稍微放大或者改变颜色】用的
Widget navigatorItem(String text, {required VoidCallback? onTap,double? fontSizeMy}) {
  return TextButton(onPressed: onTap, child: Text(text, style: whiteStyle(font: fontSizeMy??14.h)));
}

Widget navigatorIcon(IconData? icon, {required VoidCallback? onTap}) {
  return IconButton(onPressed: onTap, icon: Icon(icon, size: 32, color: Colors.white));
}

PopupMenuItem popupItem({String imageName = "", String title = ""}) {
  return PopupMenuItem(
    value: title,
    padding: const EdgeInsets.fromLTRB(8, 2, 8, 2).r,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (imageName.isNotEmpty) Image.asset(imageName, width: 28.h, height: 28.h),
        if (imageName.isNotEmpty) SizedBox(width: 10.h),
        Text(title, style: TextStyle(color: Colors.black, fontSize: 14.sp)),
      ],
    ),
  );
}

PopupMenuButton popupButton(BuildContext? context, List<PopupMenuItem> items, //
    {required PopupMenuItemSelected onSelected,
    EdgeInsetsGeometry? paddingLTRB}) {
  return PopupMenuButton(
    color: Colors.white,
    surfaceTintColor: Colors.white,
    shadowColor: Colors.black,
    offset: const Offset(0, 48),
    enableFeedback: true,
    icon: const Icon(Icons.add, size: 32, color: Colors.white),
    itemBuilder: (BuildContext context) => items,
    onSelected: (value) {
      Get.back();
      onSelected(value);
    },
    onOpened: () {
      showModalBottomSheet(
        context: context!,
        backgroundColor: Colors.transparent,
        builder: (BuildContext builder) {
          return GestureDetector(
            onTap: () => Navigator.pop(context),
            child: PopupMenuButton(
              color: Colors.white,
              surfaceTintColor: Colors.white,
              shadowColor: Colors.black,
              offset: const Offset(0, 48),
              itemBuilder: (BuildContext context) => items,
              onSelected: onSelected,
              // padding: paddingLTRB??EdgeInsets.zero,
              // padding: EdgeInsets.all(60)
            ),
          );
        },
      );
    },
    onCanceled: () => Get.back(),
  );
}

// 分割线
Widget dividerLine({double left = 0, double right = 0, double height = 0, double thickness = 0.4, Color color = Colors.black26}) {
  return Divider(indent: left, endIndent: right, thickness: thickness, height: height, color: color);
}

//浅色的线条-横向的线条
Widget dividerLineLight({double left = 0, double right = 0, double height = 0, double thickness = 0.4, Color color = Colors.black12}) {
  return Divider(indent: left, endIndent: right, thickness: thickness, height: height, color: color);
}

//浅色的线条-竖向的线条
Widget dividerLineLightVertical({double top = 0, double bottom = 0, double width = 0, double thickness = 0.4, Color color = Colors.black12}) {
  return VerticalDivider(indent: top, endIndent: bottom, thickness: thickness, width: width, color: color);
}

// cell 第0行和最后一行添加圆角
// decoration: BoxDecorationRadius.topRadius(color: TdColors.brand),
@Deprecated(
  'Use `BoxDecorationRadius.topRadius(),` instead. '
  'Use `BoxDecorationRadius.bottomRadius(color: TdColors.brand),` instead. '
  '此功能在 v1.6.0 之后已弃用',
)
cellDecoration({required int index, int length = 0, Color? color}) {
  if (length == 1) {
    // 只有一行
    // debugPrint("只有一行");
    return BoxDecoration(
      color: color ?? Colors.white,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );
  } else if (index == 0) {
    // 多行中的第一行
    // debugPrint("多行中的第一行");
    BorderRadius top = const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8));
    return BoxDecoration(color: color ?? Colors.white, borderRadius: top);
  } else if (index == length - 1) {
    // 多行中的最后一行
    // debugPrint("多行中的最后一行");
    BorderRadius bottom = const BorderRadius.only(
      bottomLeft: Radius.circular(8),
      bottomRight: Radius.circular(8),
    );
    return BoxDecoration(color: color ?? Colors.white, borderRadius: bottom);
  } else {
    // 多行中的中间行
    // debugPrint("多行中的中间行");
    return BoxDecoration(color: color ?? Colors.white);
  }
}

BoxDecorationTopRadius({Color? color}) {
  BorderRadius top = const BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8));
  return BoxDecoration(color: color ?? Colors.white, borderRadius: top);

  // if (length == 1) {
  //   // 只有一行
  //   // debugPrint("只有一行");
  //   return BoxDecoration(
  //     color: color ?? Colors.white,
  //     borderRadius: const BorderRadius.all(Radius.circular(8)),
  //   );
  // } else if (index == 0) {
  //   // 多行中的第一行
  //   // debugPrint("多行中的第一行");
  //   BorderRadius top = const BorderRadius.only(
  //       topLeft: Radius.circular(8), topRight: Radius.circular(8));
  //   return BoxDecoration(color: color ?? Colors.white, borderRadius: top);
  // } else if (index == length - 1) {
  //   // 多行中的最后一行
  //   // debugPrint("多行中的最后一行");
  //   BorderRadius bottom = const BorderRadius.only(
  //     bottomLeft: Radius.circular(8),
  //     bottomRight: Radius.circular(8),
  //   );
  //   return BoxDecoration(color: color ?? Colors.white, borderRadius: bottom);
  // } else {
  //   // 多行中的中间行
  //   // debugPrint("多行中的中间行");
  //   return BoxDecoration(color: color ?? Colors.white);
  // }
}

extension BoxDecorationRadius on BoxDecoration {
  static BoxDecoration topRadius({double? radius, Color? color}) {
    BorderRadius top = BorderRadius.only(topLeft: Radius.circular(radius ?? 8), topRight: Radius.circular(radius ?? 8));
    return BoxDecoration(color: color ?? Colors.white, borderRadius: top);
  }

  static BoxDecoration bottomRadius({double? radius, Color? color}) {
    BorderRadius top = BorderRadius.only(bottomLeft: Radius.circular(radius ?? 8), bottomRight: Radius.circular(radius ?? 8));
    return BoxDecoration(color: color ?? Colors.white, borderRadius: top);
  }

  static allRadius({double? radius, Color? color}) {
    BorderRadius top = BorderRadius.all(Radius.circular(radius ?? 8));
    return BoxDecoration(color: color ?? Colors.white, borderRadius: top);
  }

  //不添加任何边框
  static notRadius({double? radius, Color? color}) {
    BorderRadius zero = const BorderRadius.all(Radius.circular(0.0));
    return BoxDecoration(color: color ?? Colors.white, borderRadius: zero);
  }

  static BoxDecoration? radiusList(int length, int index) {
    if (length == 1) {
      // 只有一行，所有圆角
      return BoxDecorationRadius.allRadius();
    } else if (index == 0) {
      // 第一行，顶部圆角
      return BoxDecorationRadius.topRadius();
    } else if (index == length - 1) {
      // 最后一行，底部圆角
      return BoxDecorationRadius.bottomRadius();
    } else {
      // 中间行，不切圆角
      return null;
    }
  }
}

BoxDecorationBottomRadius({double? radius, Color? color}) {
  BorderRadius top = const BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8));
  return BoxDecoration(color: color ?? Colors.white, borderRadius: top);
}

Widget imageNetwork(String url, {bool? cache, String? failed, double? width, double? height, BoxFit? fit, LoadStateChanged? loadStateChanged, Widget? loading}) {
  return ExtendedImage.network(
    url,
    width: width,
    height: height,
    fit: fit ?? BoxFit.fitHeight,
    cache: cache ?? true,
    // fit: fit ?? BoxFit.cover,
    loadStateChanged: loadStateChanged ??
        (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return Center(child: loading ?? CupertinoActivityIndicator());
            case LoadState.completed:
              return state.completedWidget; // 显示加载成功的图片
            case LoadState.failed:
              // 加载失败时显示的图片
              return Image.asset(failed ?? AssetsRes.PLACEHOLDER_115, width: width, height: height, fit: fit);
            default:
              return null;
          }
        },
  );
}

Widget imageAsset(String name, {double? width, double? height, BoxFit? fit, LoadStateChanged? loadStateChanged}) {
  return ExtendedImage.asset(
    name,
    width: width,
    height: height,
    fit: fit,
    loadStateChanged: loadStateChanged ??
        (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return const Center(child: CupertinoActivityIndicator());
            case LoadState.completed:
              return state.completedWidget; // 显示加载成功的图片
            case LoadState.failed:
              // 加载失败时显示的图片
              return Image.asset(AssetsRes.PLACEHOLDER_115, width: width, height: height, fit: fit);
            default:
              return null;
          }
        },
  );
}

Widget imageFile(File file, {double? width, double? height, BoxFit? fit, LoadStateChanged? loadStateChanged}) {
  return ExtendedImage.file(
    file,
    width: width,
    height: height,
    fit: fit,
    loadStateChanged: loadStateChanged ??
        (ExtendedImageState state) {
          switch (state.extendedImageLoadState) {
            case LoadState.loading:
              return const Center(child: CupertinoActivityIndicator());
            case LoadState.completed:
              return state.completedWidget; // 显示加载成功的图片
            case LoadState.failed:
              // 加载失败时显示的图片
              return Image.asset(AssetsRes.PLACEHOLDER_115, width: width, height: height, fit: fit);
            default:
              return null;
          }
        },
  );
}

//rfid码用到，其他地方也用到
Widget rowKeyValueTextMy(
  String? key,
  String? value, {
  required TextStyle? keyStyle,
  required TextStyle? valueStyle,
  double? valueWidth,
  double? top,
  double? bottom,
  EdgeInsetsGeometry? padding,
}) {
  return Padding(
    padding: padding ?? EdgeInsets.fromLTRB(0, top ?? 0, 0, bottom ?? 0),
    // child: Row(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text(key??"", style: keyStyle??greyStyle()),
    //     SizedBox(
    //       width: valueWidth,
    //       child: Text(value??"", style: valueStyle??blackStyle())
    //     ),
    //   ],
    // ),
    child: RichText(
        text: TextSpan(children: [
      TextSpan(text: key ?? "", style: keyStyle ?? greyStyle()),
      TextSpan(text: value ?? "", style: valueStyle ?? blackStyle()),
    ])),
  );
}

Widget rowKeyValueText(
  String? key,
  String? value, {
  TextStyle? keyStyle,
  TextStyle? valueStyle,
  double? valueWidth,
  double? top,
  double? bottom,
  EdgeInsetsGeometry? padding,
}) {
  return Padding(
    padding: padding ?? EdgeInsets.fromLTRB(0, top ?? 0, 0, bottom ?? pad4),
    child: Row(
      mainAxisSize: MainAxisSize.min, // 让 Row 适应内容宽度
      crossAxisAlignment: CrossAxisAlignment.center, // key 垂直居中
      children: [
        Text(key ?? "", style: keyStyle ?? greyStyle()),
        Flexible(
          // 使用 Flexible 而不是 Expanded
          fit: FlexFit.loose, // 让 child 适应内容宽度
          child: SizedBox(
            width: valueWidth, // 指定 value 的宽度
            child: Text(
              value ?? "",
              style: valueStyle ?? blackStyle(),
              softWrap: true, // 自动换行
            ),
          ),
        ),
      ],
    ),
  );
}

Widget rowKeyValueBetweenText(String? key, String? value,
    {TextStyle? keyStyle, //
    TextStyle? valueStyle, //
    double? valueWidth, //
    double? top, //
    double? bottom}) {
  //
  return Padding(
    padding: EdgeInsets.fromLTRB(0, top ?? 0, 10, bottom ?? 2),
    child: Row(
      children: [
        Text(
          key ?? "",
          style: keyStyle ?? greyStyle(),
        ),
        Expanded(
          child: RichText(
              textAlign: TextAlign.right,
              text: TextSpan(children: [
                TextSpan(text: value ?? "", style: valueStyle ?? blackStyle()),
              ])),
        ),
      ],
    ),
  );
}

//两端对齐 2024-8-28
Widget rowKeyValueTextJustify(String? key, String? value, {TextStyle? keyStyle, TextStyle? valueStyle, double? valueWidth, double? top, double? bottom}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(0, top ?? 0, 0, bottom ?? 0),
    // child: Row(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text(key??"", style: keyStyle??greyStyle()),
    //     SizedBox(
    //       width: valueWidth,
    //       child: Text(value??"", style: valueStyle??blackStyle())
    //     ),
    //   ],
    // ),
    child: RichText(
        text: TextSpan(children: [
      TextSpan(text: key ?? "", style: greyStyle()),
      TextSpan(text: value ?? "", style: blackStyle()),
    ])),
  );
}

Widget rowKeyValueStatus(String? key, String? value, String? status, {double? top, double? bottom}) {
  return Padding(
    padding: EdgeInsets.fromLTRB(0, top ?? 0, 0, bottom ?? 2),
    child: Row(children: [
      Expanded(
          child: Row(
        children: [
          Text(key ?? "", style: greyStyle()),
          Expanded(child: Text(value ?? "", style: blackStyle())),
          Text(status ?? "", style: redStyle()),
        ],
      )),
    ]),
  );
}

//左右两边都是灰色文字
Widget rowTextBetween_leftGreyRightGrey(String key, String value) {
  return Row(children: [
    //
    Expanded(child: Text(key, style: greyStyle())),
    Text(value, style: greyStyle()),
  ]);
}

//两端对齐，默认左侧是黑色文字，右侧是灰色文字，可以传递左右色值样式
Widget rowTextBetween(
    String key, //
    String value, //
    {TextStyle? leftStyle, //
    TextStyle? rightStyle}) {
  //
  return Row(children: [
    Expanded(child: Text(key, style: leftStyle ?? blackStyle())),
    Text(value, style: rightStyle ?? greyStyle()),
  ]);
}

//右边文字携带下划线，可点击的链接样式
Widget rowKeyValueTextWithLinkClick(String? key, String? value,
    {TextStyle? keyStyle, //
    TextStyle? valueStyle, //
    double? valueWidth, //
    double? top, //
    double? bottom,
    VoidCallback? clickCallBack}) {
  //
  return Padding(
    padding: EdgeInsets.fromLTRB(0, top ?? 0, 0, bottom ?? 0),
    // child: Row(
    //   crossAxisAlignment: CrossAxisAlignment.start,
    //   children: [
    //     Text(key??"", style: keyStyle??greyStyle()),
    //     SizedBox(
    //       width: valueWidth,
    //       child: Text(value??"", style: valueStyle??blackStyle())
    //     ),
    //   ],
    // ),
    child: RichText(
        text: TextSpan(children: [
      TextSpan(text: key ?? "", style: keyStyle ?? greyStyle()),
      TextSpan(
          text: value ?? "",
          style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline, fontWeight: FontWeight.w400) ?? blackStyle(),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              clickCallBack?.call();
            }),
    ])),
  );
}

Widget rowStatusTextBetween(String key, String value) {
  return Row(children: [
    Expanded(child: Text(key, style: blackStyle())),
    Text(value, style: statusStyle()),
  ]);
}

Widget RowArrow({double? size, Color? colors}) {
  return Icon(Icons.arrow_forward_ios, size: (size ?? 16).h, color: colors ?? TdColors.grey195);
}

Widget RowEdit({double? size, Color? colors}) {
  return Icon(Icons.edit_note, size: (size ?? 28).h, color: colors ?? TdColors.grey195);
}

//添加一个向右边的padding和整条点击事件?要不要加一个样式？
Widget RowArrowMy(
    String title, //
    TextStyle? titleStyle, //
    {required bool rightArrow, //右侧箭头是否展示判断
    double? paddingRight, //
    double? size, //
    Color? colors, //
    Function()? onTapListener}) {
  //
  return InkWell(
    onTap: onTapListener,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(title, style: titleStyle ?? blackStyle()),
        rightArrow
            ? Padding(
                padding: (paddingRight == 0.0) ? const EdgeInsets.fromLTRB(0, 0, 0.0, 0) : const EdgeInsets.fromLTRB(0, 0, 6, 0),
                child: Icon(Icons.arrow_forward_ios, size: size ?? 16, color: colors ?? TdColors.grey195),
              )
            : const SizedBox.shrink(),
      ],
    ),
  );
}

/// 创建一行cell
// 一个通用的 analyzing 函数，使用泛型和函数参数
@Deprecated(
  'Use `InputValue()` instead. '
  'Use `RadioButton()` instead. '
  'Use `RemarkView()` instead. '
  '此功能在 v1.6.0 之后已弃用',
)
Widget BuildRow(
    {String? title = "",
    String? subTitle = "",
    String imageName = "",
    String? hintText,
    double? height,
    Widget? subview,
    final EdgeInsetsGeometry? padding,
    TextEditingController? vc,
    bool? valueRequired = false,
    TextInputType? keyboardType,
    ValueChanged<String>? onChanged,
    GestureTapCallback? onTap,
    bool readOnly = false,
    Decoration? decoration,
    final TextStyle? titleStyle,
    final TextStyle? subTitleStyle,
    Widget? right}) {
  return Container(
    padding: padding ?? const EdgeInsets.fromLTRB(10, 0, 10, 0),
    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.6),
    decoration: decoration ??
        const BoxDecoration(
          color: TdColors.white,
          // boxShadow: [BoxShadow(blurRadius: 6, color: BGColor_grey_235)],
        ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (valueRequired!)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                child: Text("*", style: redBoldStyle()),
              ),
            if (!valueRequired) const SizedBox(width: 6),
            if (imageName.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: Image(image: AssetImage(imageName), width: 28),
              ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 2),
            //   child: Text(title!, style: blackStyle()),
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(title!, style: titleStyle ?? blackStyle()),
                //@updateTime 2024/12/18增加一个subTitle
                Visibility(visible: ObjectUtil.isNotEmpty(subTitle), child: Text(subTitle ?? "", style: subTitleStyle ?? greyStyle(font: 12))),
              ],
            ),
            Expanded(
              child: Container(
                height: height ?? 40,
                padding: EdgeInsets.fromLTRB(0, 0, (right != null) ? 10 : 10, 0),
                child: TextField(
                  controller: vc,
                  onChanged: onChanged,
                  onTap: onTap,
                  autofocus: false,
                  readOnly: readOnly,
                  keyboardType: keyboardType,
                  style: blackStyle(),
                  textAlign: TextAlign.end,
                  textAlignVertical: TextAlignVertical.center, // 文字垂直居中
                  scrollPhysics: const NeverScrollableScrollPhysics(), // 禁止滚动
                  decoration: InputDecoration(
                    // contentPadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.symmetric(vertical: ((height ?? 40) - 15.h) / 2, horizontal: 0),
                    border: InputBorder.none,
                    hintText: hintText ?? " ",
                    hintStyle: greyStyle(),
                  ),
                ),
              ),
            ),
            if (right != null) right,
          ],
        ),
        if (subview != null) subview,
      ],
    ),
  );
}

// 创建灰色标题
Widget buildSectionTitle(String title) {
  return Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Text(title,
          style: const TextStyle(
            fontSize: 16,
            color: TdColors.grey85,
          )));
}

// 创建cell分区的标题
creatTitle(String title, {EdgeInsetsGeometry? padding, String? rightTitle, GestureTapCallback? onTap}) {
  return Container(
      padding: padding ?? const EdgeInsets.fromLTRB(0, 0, 0, 0),
      decoration: cellDecoration(index: 0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(title, textAlign: TextAlign.left, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        GestureDetector(
          onTap: onTap,
          child: Text(rightTitle ?? "", style: blackStyle()),
        )
      ]));
}

copyValueRow(String key, String value, String status, {Color? statusColor}) {
  return SizedBox(
    child: GestureDetector(
      onTap: () {
        Clipboard.setData(ClipboardData(text: value));
        Get.snackbar("复制成功", "$key$value", backgroundColor: TdColors.pageBg);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Text(key, style: greyStyle()),
                Flexible(
                  child: Text(
                    value,
                    style: blackStyle(),
                    overflow: TextOverflow.ellipsis, // 避免超出显示
                  ),
                ),
              ],
            ),
          ),
          if (statusColor == null)
            Text(
              status,
              textAlign: TextAlign.end,
              style: statusStyle(),
            ),
          if (statusColor != null)
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 6, 0),
              decoration: BoxDecoration(
                color: statusColor ?? Colors.transparent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomLeft: Radius.circular(15),
                ),
              ),
              child: Text(
                status,
                textAlign: TextAlign.end,
                style: whiteStyle(),
              ),
            ),
        ],
      ),
    ),
  );
}

/// iOS 6 嵌入式圆角视图
Widget FilletView({EdgeInsetsGeometry? padding, EdgeInsetsGeometry? margin, Color? color, Widget? child}) {
  return Container(
    color: color,
    padding: padding,
    margin: margin,
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(Radius.circular(6.0)),
    ),
    child: child ?? Container(height: 1),
  );
}

Widget buildButton(String title, {Color? color, VoidCallback? onPressed}) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? TdColors.brand,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title, style: whiteStyle()),
        ],
      ),
    ),
  );
}

// 页面底部添加一个长按钮
Widget pageBottomButton({required String title, bool topLine = true, required VoidCallback onPressed}) {
  return Container(
    height: Platform.isIOS ? 80 : 80, //android设备暂时写80，80更稳妥
    color: TdColors.white,
    margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
    child: Column(children: [
      if (topLine) const DividerLine(),
      Padding(
        padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
        child: MaterialButton(
            height: 40,
            color: TdColors.brand,
            // padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            onPressed: onPressed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22), // 设置圆角半径
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: whiteStyle()),
              ],
            )
            // child: Text(title, style: whiteStyle()),
            ),
      ),
    ]),
  );
}

// 页面底部右侧添加一个按钮 bottomNavigationBar: pageBottomRightButton(...),
Widget pageBottomRightButton({
  Widget left = const SizedBox(),
  required String title,
  bool topLine = true,
  required VoidCallback onPressed,
  double? height,
}) {
  return Container(
    height: TabBarHeight,
    color: TdColors.white,
    child: Column(children: [
      Offstage(offstage: !topLine, child: dividerLine()),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(margin: const EdgeInsets.only(left: 10, top: 10, right: 10).r, child: left),
          GestureDetector(
            onTap: onPressed,
            child: Container(
              height: height ?? 40,
              padding: const EdgeInsets.only(left: 20, right: 20),
              margin: const EdgeInsets.only(top: 10, right: 15).r,
              decoration: BoxDecoration(
                color: TdColors.brand,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: whiteStyle()),
                ],
              ),
            ),
          ),
        ],
      ),
    ]),
  );
}

//在右侧有两个
// 页面底部右侧添加2个按钮 bottomNavigationBar: pageBottomRightButton(...),
Widget pageBottomRightTwoButton({
  Widget left = const SizedBox(),
  required String textLeft,
  required String textRight,
  required VoidCallback onPressedLeft,
  required VoidCallback onPressedRight,
  double? height,
  bool topLine = true,
}) {
  return Container(
    height: TabBarHeight,
    color: TdColors.white,
    child: Column(children: [
      Offstage(offstage: !topLine, child: dividerLine()),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 8),
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: left,
          ),
          //右侧是两个按钮，两个布局
          Row(
            children: [
              //左侧的重置按钮
              InkWell(
                onTap: onPressedLeft,
                child: Container(
                  // height: height ?? 38,
                  padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                  margin: const EdgeInsets.only(top: 10, right: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(19),
                    //borderRadius: BorderRadius.
                  ),
                  child: Center(
                    child: Text(textLeft, style: blackStyle()),
                  ),
                ),
              ),
              //右侧的确定按钮
              InkWell(
                onTap: onPressedRight,
                child: Container(
                  // height: height ?? 38,
                  padding: const EdgeInsets.fromLTRB(20, 2, 20, 2),
                  margin: const EdgeInsets.only(top: 10, right: 15),
                  decoration: BoxDecoration(
                    color: TdColors.brand,
                    borderRadius: BorderRadius.circular(19),
                  ),
                  child: Center(
                    child: Text(textRight, style: whiteStyle()),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    ]),
  );
}

// 页面底部价格和添加一个按钮
bottomPriceButton({String? priceName, String? price, String? buttonName, required VoidCallback onPressed}) {
  return pageBottomRightButton(
    left: Container(
      alignment: Alignment.centerRight,
      width: Get.width - 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(priceName ?? "费用共计：", style: blackStyle()),
          Text(price ?? "0.0", style: redBoldStyle(font: 20)),
          const SizedBox(width: 4),
          Text("元", style: blackStyle()),
        ],
      ),
    ),
    title: buttonName ?? "保存",
    onPressed: onPressed,
  );
}

// 页面底部添加两个按钮--如果有额外的按钮，那么需要放开一个
Widget pageBottomDoubleButton({
  bool topLine = true,
  required String title1, //
  required VoidCallback onPressed1, //
  required String title2,
  required VoidCallback onPressed2,
  required bool? hasExtraButton, //是否有额外的按钮,如果有额外的按钮，title3和onPressed3是必须要写的
  Color? bgColor1,
  bgColor2,
  String? title3, //2024-10-22新增
  EdgeInsets? padding,
  VoidCallback? onPressed3, //2024-10-22新增
}) {
  return Container(
      color: TdColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (topLine) const DividerLine(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: onPressed1,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 12, 0, 30).r,
                  padding: padding ?? const EdgeInsets.fromLTRB(30, 10, 30, 10).r,
                  decoration: BoxDecoration(
                    color: bgColor1 ?? TdColors.brand,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title1, style: TextStyle(fontSize: 15.sp, color: TdColors.white)),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: onPressed2,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 12, 0, 30).r,
                  padding: padding ?? const EdgeInsets.fromLTRB(30, 10, 30, 10).r,
                  decoration: BoxDecoration(
                    color: bgColor2 ?? TdColors.brand,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(title2, style: TextStyle(fontSize: 15.sp, color: TdColors.white)),
                    ],
                  ),
                ),
              ),
              if (hasExtraButton ?? false)
                GestureDetector(
                  onTap: onPressed3,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 12, 0, 30).r,
                    padding: padding ?? const EdgeInsets.fromLTRB(30, 10, 30, 10).r,
                    decoration: BoxDecoration(
                      color: TdColors.brand,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(title3 ?? "", style: TextStyle(fontSize: 15.sp, color: TdColors.white)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ],
      ));
}

// 页面底部添加两个按钮,去掉横线
Widget pageBottomDoubleButtonMy({bool topLine = false, required String textLeft, required VoidCallback onClickLeftCallback, required String textRight, required VoidCallback onClickRightCallback}) {
  return Container(
      height: 70,
      color: TdColors.white,
      child: Column(children: [
        if (topLine) const DividerLineLight(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onClickLeftCallback,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                padding: const EdgeInsets.fromLTRB(30, 6, 30, 6),
                decoration: BoxDecoration(
                  color: TdColors.brand,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(textLeft, style: const TextStyle(fontSize: 16, color: TdColors.white)),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: onClickRightCallback,
              child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 25),
                padding: const EdgeInsets.fromLTRB(30, 6, 30, 6),
                decoration: BoxDecoration(
                  color: TdColors.brand,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(textRight, style: const TextStyle(fontSize: 16, color: TdColors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ]));
}

Widget checkBox({String? title, String? item1, item2, bool? value1, value2, valueRequired, required Function(dynamic)? item1OnTap, required Function(dynamic)? item2OnTap}) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(0, 4, 2, 0).r,
        child: Text(valueRequired == true ? "*" : "  ", style: redBoldStyle()),
      ),
      Text(title!, style: blackStyle()),
      const SizedBox(width: 5),
      Expanded(
        child: Row(
          children: [
            Row(
              children: [
                Transform.scale(
                  scale: 1.2.r,
                  child: SizedBox(
                    width: 32,
                    height: 32,
                    child: Checkbox(
                      shape: const CircleBorder(),
                      // 这⾥就是圆形
                      side: const BorderSide(width: 1, color: Color.fromRGBO(151, 151, 151, 1)),
                      value: value1,
                      activeColor: TdColors.brand,
                      //选中时的颜色
                      onChanged: (value) => item1OnTap!(value),
                    ),
                  ),
                ),
                Text(item1!, style: blackStyle()),
              ],
            ),
            SizedBox(width: 25.w),
            if (item2 != null)
              Row(
                children: [
                  Transform.scale(
                    scale: 1.2.r,
                    child: SizedBox(
                      width: 32,
                      height: 32,
                      child: Checkbox(
                          shape: const CircleBorder(),
                          // 这⾥就是圆形
                          side: const BorderSide(width: 1, color: Color.fromRGBO(151, 151, 151, 1)),
                          value: value2,
                          activeColor: TdColors.brand,
                          //选中时的颜色
                          onChanged: (value) => item2OnTap!(value)),
                    ),
                  ),
                  Text(item2, style: blackStyle()),
                ],
              )
          ],
        ),
      )
    ],
  );
}
