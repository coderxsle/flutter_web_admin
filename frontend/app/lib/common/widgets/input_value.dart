import 'dart:io';

import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/common/widgets/divider_line_light.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputValue extends StatelessWidget {
  final Widget? icon;
  final String? title;
  final TextStyle? titleStyle;
  //录入文本的样式
  final TextStyle? textFieldStyle;
  final String? imageName;
  final String? hintText;
  final double? height;
  final bool? dividerLine; //是否在底部画出一条线条
  //线条两端间距
  final double? linePaddingBoth;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  //文字距离右侧有点远，可以自定义设置右侧近一点
  final EdgeInsetsGeometry? paddingTextField;
  final TextEditingController? tec;
  final String? tecText;
  final TextAlign? textAlign;
  final bool? required;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters; //限制只能输入数字或字母的
  final Function(BuildContext)? onTap;
  final ValueChanged<String>? onChanged;
  final bool? readOnly;
  final BoxDecoration? decoration;
  //文本框的外边样式
  final BoxDecoration? textDecoration;
  final Widget? right;
  final FocusNode? focusNode; //焦点监听
  final TextInputAction? textInputAction; //加一个影响文字
  final ValueChanged<String>? onSubmitted; //文本录入监听的键盘事件

  const InputValue(
    this.title,
    this.hintText, {
    super.key,
    this.icon,
    this.titleStyle,
    this.textFieldStyle,
    this.imageName,
    this.height,
    this.dividerLine,
    this.color,
    this.padding,
    this.tec,
    this.tecText,
    this.textAlign,
    this.required,
    this.keyboardType,
    this.inputFormatters,
    this.onTap,
    this.onChanged,
    this.readOnly,
    this.decoration,
    this.textDecoration,
    this.right,
    this.paddingTextField,
    this.focusNode,
    this.textInputAction,
    this.onSubmitted,
    this.linePaddingBoth,
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      constraints: BoxConstraints(minHeight: (height ?? 44).h),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0.5).r,
      padding: padding ?? const EdgeInsets.fromLTRB(10, 0, 10, 0).r,
      decoration: decoration ??
          BoxDecoration(
            color: color ?? Colors.white,
          ),
      child: _setupSubViews(context),
    );
  }

  Widget _setupSubViews(context) {
    return Column(
      children: [
        Row(
          children: [
            if (required == true) Padding(padding: const EdgeInsets.only(top: 4).r, child: Text("*", style: redBoldStyle())),
            // 优化图标和图片的处理，避免冗余的布局逻辑
            Padding(
              padding: EdgeInsets.fromLTRB(required == true ? 0 : 6, 0, 0, 0).r,
              child: imageName != null && imageName!.isNotEmpty ? Image(image: AssetImage(imageName!), width: 28.h) : icon ?? const SizedBox.shrink(),
            ),

            // 确保 title 不为 null
            if (title != null) Text(title!, style: titleStyle ?? blackStyle()),

            _setupTextField(context),

            // 如果存在右侧的附加组件则显示
            if (right != null) right!,
          ],
        ),
        if (dividerLine ?? false) DividerLineLight(left: linePaddingBoth??0.0,right: linePaddingBoth??0.0),
      ],
    );
  }

  Widget _setupTextField(context) {
    return Expanded(
      child: Container(
        constraints: BoxConstraints(minHeight: (height ?? 44).h),
        decoration: (textDecoration!=null)? textDecoration: null,
        padding: paddingTextField ?? const EdgeInsets.fromLTRB(0, 0, 20, 0).r,
        alignment: Alignment.center, // 确保父容器内部居中
        child: TextField(
          controller: tec ?? TextEditingController(text: tecText??""),
          onTap: () => onTap?.call(context),
          onChanged: onChanged,
          focusNode: focusNode ?? FocusNode(),
          textInputAction: textInputAction ?? (Platform.isIOS ? null : TextInputAction.none),
          autofocus: false,
          readOnly: readOnly ?? false,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters ?? _inputFormatters(), //增加限制仅仅输入数字或者字母
          scrollPhysics: const NeverScrollableScrollPhysics(), // 禁止滚动
          style: textFieldStyle??blackStyle(),
          textAlign: TextAlign.end,
          textAlignVertical: TextAlignVertical.center,
          onSubmitted: onSubmitted ?? (_) {}, //键盘的提交事件
          decoration: InputDecoration(
            isDense: true,
            border: InputBorder.none,
            hintText: hintText ?? " ",
            hintStyle: greyStyle(),
            contentPadding: EdgeInsets.symmetric(vertical: 0), // 垂直居中
          ),
          maxLines: height != null ? 1 : null, // 动态调整高度
        ),
      ),
    );
  }

  List<TextInputFormatter>? _inputFormatters() {
    if (keyboardType == TextInputType.number) {
      return InputValue.getInputFormatters(InputFormatters.numberOnly);
    } else if (keyboardType == TextInputType.numberWithOptions(decimal: true)) {
      return InputValue.getInputFormatters(InputFormatters.doubleOnly);
    }
    // else if (keyboardType == TextInputType.text) {//text让随便输入就行
    //   return InputValue.getInputFormatters(InputFormatters.chineseAndLetterAndNumber);
    // }
    return null;
  }

  //获取限制格式
  static List<TextInputFormatter>? getInputFormatters(InputFormatters inputFormatterType) {
    if (inputFormatterType == InputFormatters.numberOnly) {
      //限制文本框之中仅仅录入数字
      return <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly];
    } else if (inputFormatterType == InputFormatters.doubleOnly) {
      //限制只能录入double类型的过滤掉特殊符号
      return <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))];
    } else if (inputFormatterType == InputFormatters.numberAndLetterOnly) {
      // 允许输入数字和字母和空格 同时这个表达式也是控制不能输入【特殊字符的】表达式
      return <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))];
    } else if (inputFormatterType == InputFormatters.chineseAndLetterAndNumber) {
      //只允许汉字、字母、数字
      return <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]|[\u4e00-\u9fa5]|[0-9]'))];
    } else if (inputFormatterType == InputFormatters.specialCharactersClear) {
      //录入一部分数据之后，再录入一个特殊字符就清除录入信息
      return <TextInputFormatter>[FilteringTextInputFormatter.allow(RegExp(r'^[\u4e00-\u9fa5A-Za-z0-9]+$'))];
    } else if (inputFormatterType == InputFormatters.idCardOnly) {
      // 只允许输入身份证格式（18位，前17位数字，最后一位允许数字或字母X/x）
      return <TextInputFormatter>[_IDCardInputFormatter()];
    }else if (inputFormatterType == InputFormatters.emailOnly) {
      // 只允许输入邮箱格式（简单格式：字母、数字、点、下划线、连字符、@符号）
      return <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'))
      ];
    } else {
      return null;
    }
  }
}

// 解决输入的身份证号超出 18 位后，会自动清空输入内容的问题，这里保留18位后，阻止输入，但不清空！
// 解决输入的身份证号超出 18 位后，会自动清空输入内容的问题，这里保留18位后，阻止输入，但不清空！
// 解决输入的身份证号超出 18 位后，会自动清空输入内容的问题，这里保留18位后，阻止输入，但不清空！
class _IDCardInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // 限制输入为前17位数字，最后一位允许X/x或数字
    final RegExp regex = RegExp(r'^[0-9]{0,17}[0-9Xx]?$');

    // 如果新值符合正则表达式且长度不超过18位，则更新值，否则保持旧值
    if (regex.hasMatch(newValue.text) && newValue.text.length <= 18) {
      return newValue;
    }
    return oldValue; // 超过18位或不符合格式时，保持原输入
  }
}

enum InputFormatters {
  numberOnly, //限制文本框之中仅仅录入数字
  doubleOnly, //限制只能录入double类型的过滤掉特殊符号
  numberAndLetterOnly, //允许输入数字和字母和空格 同时这个表达式也是控制不能输入【特殊字符的】表达式
  chineseAndLetterAndNumber, //允许汉字、字母、数字，但是不能有【特殊字符】
  specialCharactersClear, //录入一部分数据之后，再录入一个特殊字符就清除录入信息
  idCardOnly,               // 限制身份证格式（18位，最后一位允许数字或字母X/x）
  emailOnly,                // 限制输入邮箱格式
}
