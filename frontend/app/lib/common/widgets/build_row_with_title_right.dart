import 'package:auto_shop_server/app/theme/app_theme.dart';
import 'package:auto_shop_server/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///@description 标题右侧可以携带小布局的小部件，在BuildRow的基础上增加的titleRight
///@updateTime 2024/10/11 8:20
class BuildRowWithTitleRight extends StatelessWidget {
  final String title;
  final String imageName = "";
  final String? hintText;
  final double? height;
  final Widget? subview;
  final EdgeInsetsGeometry? padding;
  final TextEditingController? vc;
  final bool? valueRequired = false;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final bool readOnly;
  final Decoration? decoration;
  final TextStyle? titleStyle;
  final Widget? titleRight;
  final Widget? right;

  const BuildRowWithTitleRight(
      {super.key,
      required this.title,
      this.padding, //
      this.titleStyle, //
      this.hintText, //
      this.height, //
      this.subview, //
      this.vc, //
      this.keyboardType, //
      this.onChanged, //
      this.onTap, //
      this.decoration, //
      this.titleRight, //
      this.right, //
      required this.readOnly}); //

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.fromLTRB(10, 0, 10, 0),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.6),
      decoration: decoration ??
          const BoxDecoration(
            color: TdColors.white,
            // boxShadow: [BoxShadow(blurRadius: 6, color: BGColor_grey_235)],
          ),
      child: Column(
        children: [
          Row(
            children: [
              if (valueRequired!)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                  child: Text("*", style: redBoldStyle()),
                ),
              if (!valueRequired!) const SizedBox(width: 6),
              if (imageName.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: Image(image: AssetImage(imageName), width: 28),
                ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 2),
              //   child: Text(title!, style: blackStyle()),
              // ),
              Visibility(
                  //如果右侧小布局是空，那么仅仅显示标题
                  visible: titleRight == null,
                  child: Text(title, style: titleStyle ?? blackStyle())),
              Visibility(
                  //如果右侧小布局不是空，那么仅仅显示标题
                  visible: titleRight != null,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start, //
                      crossAxisAlignment: CrossAxisAlignment.center, //
                      children: [
                        Text(title, style: titleStyle ?? blackStyle()), //
                        titleRight ?? SizedBox.shrink(),
                      ])), //
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
              if (right != null) right ?? SizedBox.shrink(),
            ],
          ),
          if (subview != null) subview ?? SizedBox.shrink(),
        ],
      ),
    );
  }
}
