import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/app/utils/styles/paddings.dart';
import 'package:auto_shop_server/common/widgets/divider_line_light.dart';
import 'package:auto_shop_server/common/widgets/row_arrow_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectValue extends StatelessWidget {
  final Widget? icon;
  //图标的间距格式
  final EdgeInsetsGeometry? paddingIcon;
  final String? title;
  final String? value;
  final TextStyle? titleStyle;
  //@updateTime 2024/12/16新增一个文本的展示样式
  final TextStyle? textFieldStyle;
  final String? imageName;
  final String? hintText;
  final double? height;
  final bool? dividerLine;
  final double? dividerPaddingBoth;
  final Color? color;
  final TextEditingController? tec;
  final GestureTapCallback onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? paddingTextField;
  final TextAlign? textAlign;
  final bool? required;
  final BoxDecoration? decoration;
  final Widget? right;

  const SelectValue(
    this.title,
    this.hintText, {
    super.key,
    this.icon,
    this.paddingIcon,
    this.imageName,
    this.titleStyle,
    this.textFieldStyle,
    this.height,
    this.color,
    this.padding,
    this.tec,
    this.textAlign,
    this.required,
    this.decoration,
    this.right,
    this.value,
    required this.onTap,
    this.dividerLine,
    this.paddingTextField,
    this.dividerPaddingBoth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.4).r,
      padding: padding ?? const EdgeInsets.fromLTRB(10, 0, 10, 0).r,
      decoration: decoration ??
          BoxDecoration(
            color: color ?? Colors.white,
          ),
      child: setupSubViews(),
    );
  }

  Widget setupSubViews() {
    return Column(
      children: [
        Row(
          children: [
            //原始代码
            //if (required != null) Padding(padding: const EdgeInsets.only(top: 4), child: Text("*", style: redBoldStyle())),
            if (required == true) Padding(padding: const EdgeInsets.only(top: 4).r, child: Text("*", style: redBoldStyle())),
            // 优化图标和图片的处理，避免冗余的布局逻辑
            Padding(
              padding: paddingIcon??EdgeInsets.fromLTRB(required == true ? 0 : 6, 0, 2, 0).r,
              child: imageName != null && imageName!.isNotEmpty ? Image(image: AssetImage(imageName!), width: 28.h) : icon ?? const SizedBox.shrink(),
            ),

            // 确保 title 不为 null
            if (title != null) Text(title!, style: titleStyle ?? blackStyle()),

            setupTextField(),

            // 如果存在右侧的附加组件则显示
            right ?? const RowArrowWidget(),
          ],
        ),
        if (dividerLine ?? false) DividerLineLight(left: dividerPaddingBoth ?? pad10, right: dividerPaddingBoth ?? pad10),
      ],
    );
  }

  Widget setupTextField() {
    return Expanded(
      child: Container(
        constraints: BoxConstraints(
          minHeight: (height ?? 44).h,
        ),
        padding: paddingTextField ?? const EdgeInsets.fromLTRB(0, 0, 0, 0), //2024-11-14 改动向右的间距可调
        alignment: const Alignment(0, 0),
        child: TextField(
          controller: tec,
          onTap: onTap,
          readOnly: true,
          autofocus: false,
          minLines: 1, // 最小一行
          maxLines: 2, // 最大10行
          style: textFieldStyle ?? blackStyle(),
          textAlign: TextAlign.end,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            hintText: hintText ?? " ",
            hintStyle: greyStyle(),
          ),
        ),
      ),
    );
  }
}
