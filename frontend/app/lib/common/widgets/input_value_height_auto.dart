import 'package:auto_shop_server/app/utils/common_widget/logger.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/common/widgets/divider_line_light.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///@description 这一行的高度随着后边内容的增多动态增高
///@updateTime 2024/10/15 17:12
class InputValueHeightAuto extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final TextStyle? titleStyle;
  final String? imageName;
  final String? hintText;
  final double? height;
  // final int maxLine;.
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final TextEditingController tec;
  final TextAlign? textAlign;
  final bool? required;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters; //限制只能输入数字或字母的
  final ValueChanged<String>? onChanged;
  final bool? readOnly;
  final BoxDecoration? decoration;
  final Widget? right;
  final bool? dividerLine;

  const InputValueHeightAuto(
    this.title, //
    this.hintText, //
    {
    super.key, //
    this.icon, //
    this.titleStyle, //
    this.imageName, //
    this.height, //
    this.color, //
    this.padding, //
    required this.tec, //
    this.textAlign, //
    this.required, //
    this.keyboardType, //
    this.inputFormatters, //
    this.onChanged, //
    this.readOnly, //
    this.decoration, //
    this.right,
    this.dividerLine,
  }); //

  @override
  Widget build(BuildContext context) {
    return buildContainer();
  }

  Container buildContainer() {
    try {
      int maxLine = 1;
      if (!ObjectUtil.isEmptyString(tec.text)) {
        maxLine = _getMaxLines(tec.text.toString().trim());
      } else {
        maxLine = 1;
      }
      //logger.d("maxLine-行数是->$maxLine");
      //单行
      Container container44 = Container(
        height: 44,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.4),
        padding: padding ?? const EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: decoration ??
            BoxDecoration(
              color: color ?? Colors.white,
            ),
        child: _setupSubViews(maxLine),
      );

      Container containerAuto = Container(
        height: maxLine * 26,
        margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.4),
        padding: padding ?? const EdgeInsets.fromLTRB(10, 0, 10, 0),
        decoration: decoration ??
            BoxDecoration(
              color: color ?? Colors.white,
            ),
        child: _setupSubViews(maxLine),
      );

      if (maxLine == 1) {
        return container44;
      } else {
        return containerAuto;
      }
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.w(" catch Exception =>${e.toString()}");
      }
    }
    return Container();
  }

  Widget _setupSubViews(int maxLine) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (required == true) Padding(padding: const EdgeInsets.only(top: 4), child: Text("*", style: redBoldStyle())),
            // 优化图标和图片的处理，避免冗余的布局逻辑
            Padding(
              padding: EdgeInsets.fromLTRB(required == true ? 0 : 6, 0, 0, 0),
              child: imageName != null && imageName!.isNotEmpty ? Image(image: AssetImage(imageName!), width: 28) : icon ?? const SizedBox.shrink(),
            ),
            // 确保 title 不为 null
            if (title != null) Text(title!, style: titleStyle ?? blackStyle()),
            _setupTextField(maxLine),
            // 如果存在右侧的附加组件则显示
            if (right != null) right!,
          ],
        ),
        if (dividerLine ?? false) const DividerLineLight(),
      ],
    );
  }

  Widget _setupTextField(int maxLine) {
    return Expanded(
      child: Container(
        height: maxLine == 1 ? 44 : maxLine * 26,
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        alignment: const Alignment(0, 0),
        child: TextField(
          controller: tec,
          onChanged: onChanged,
          autofocus: false,
          readOnly: readOnly ?? false,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters, //增加限制仅仅输入数字或者字母
          scrollPhysics: const NeverScrollableScrollPhysics(), // 禁止滚动
          style: blackStyle(),
          textAlign: TextAlign.end,
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            hintText: hintText ?? " ",
            hintStyle: greyStyle(),
          ),
          minLines: 1, //最小高度
          maxLines: ObjectUtil.isEmptyString(tec.text) ? 1 : _getMaxLines(tec.text), // 动态调整高度
        ),
      ),
    );
  }

  //动态获取maxLines
  int _getMaxLines(String textStr) {
    int lineIntValue = 1;
    /*int maxLine = 1;
    if (textStr.toString().trim().length > 16) {
      return maxLine + 1;
    } else if (textStr.toString().trim().length > 16 * 2) {
      return maxLine + 2;
    } else if (textStr.toString().trim().length > 16 * 3) {
      return maxLine + 3;
    } else if (textStr.toString().trim().length > 16 * 4) {
      return maxLine + 4;
    } else if (textStr.toString().trim().length > 16 * 5) {
      return maxLine + 5;
    }*/
    try {
      if (!ObjectUtil.isEmptyString(textStr)) {
        //double lineDoubleValue = textStr.toString().trim().length / 16;
        double lineDoubleValue = textStr.toString().trim().length / 14;
        lineIntValue = lineDoubleValue.toInt();
        if (lineIntValue < 1) {
          lineIntValue = 1;
        }
        logger.d("lineIntValue-内层-$lineIntValue");
      } else {
        //logger.d("lineIntValue-$lineIntValue");
        return lineIntValue;
      }
    } on Exception catch (e) {
      if (!ObjectUtil.isEmpty(e)) {
        logger.w("getMaxLines catch Exception =>${e.toString()}");
      }
      return lineIntValue;
    }
    return lineIntValue;
  }
}
