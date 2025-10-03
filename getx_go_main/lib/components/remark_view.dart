
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// ┌──────────────────────────
// |  备注：                   |
// |                          |
// |  请输入备注                |
// └──────────────────────────

class RemarkView extends StatelessWidget {
  final String title;
  final String? hintText;
  final Widget? icon;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? paddingTitle;
  final Decoration? decoration;
  final TextEditingController? controller;
  final FocusNode? focusNode; //2024-10-11增加焦点
  final List<TextInputFormatter>? inputFormatters; //限制只能输入数字或字母的
  final int? maxLines; //限制录入的最大行数
  final TextInputType? keyboardType; //限制软键盘的类型
  final TextStyle? titleStyle;
  final TextStyle? textFieldStyle;//2024-10-31新增内部录入文字的样式
  final TextStyle? hintStyle;
  final Color? bgColor;
  final double? height;
  final bool readOnly;
  final bool? required;

  const RemarkView(
      {super.key,
      this.title = "", //
      this.hintText, //
      required this.controller, //
      this.titleStyle, //
      this.textFieldStyle, //
      this.hintStyle, //
      this.bgColor, //
      this.height, //
      this.readOnly = false, //
      this.padding, //
      this.decoration, //
      this.required, //
      this.margin, //
      this.inputFormatters, //
      this.maxLines, //
      this.keyboardType,
      this.focusNode, //
      this.paddingTitle,
        this.icon}); //

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: decoration ??
          BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
          ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 添加这个属性确保文本左对齐
        children: [
          if (title.isNotEmpty) _setupTitle(),
          Container(
            height: height ?? 64,
            decoration: BoxDecoration(color: bgColor ?? Colors.grey[100], borderRadius: BorderRadius.circular(4)),
            margin: margin ?? const EdgeInsets.fromLTRB(10, 0, 10, 10),
            padding: padding ?? const EdgeInsets.fromLTRB(10, 0, 0, 0),
            alignment: Alignment.topCenter,
            child: TextField(
              readOnly: readOnly,
              autocorrect: false,
              controller: controller,
              focusNode: focusNode,
              decoration: _inputDecoration(),
              keyboardType: keyboardType ?? TextInputType.text, //2024-10-10限制软键盘的类型
              inputFormatters: inputFormatters, //2024-10-10：增加限制仅仅输入数字或者字母
              maxLines: maxLines ?? 10, //2024-10-10：限制录入行数，有列表项的微小型输入框
              minLines: null, // 设置为1来避免最小行数限制导致高度问题
              textAlign: TextAlign.justify,
              style: textFieldStyle??TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _setupTitle() {
    return Padding(
      padding: paddingTitle ?? const EdgeInsets.fromLTRB(10, 10, 10, 4),
      child: Row(
        children: [
          if (required == true) Padding(padding: const EdgeInsets.only(top: 4), child: Text("*", style: TextStyle(color: Colors.red, fontSize: 14))),
          if(icon!=null) icon??const SizedBox.shrink(),
          Text(title, style: titleStyle ?? TextStyle(color: Colors.black, fontSize: 14)),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration() {
    return InputDecoration(
      hintText: hintText ?? "请输入内容",
      contentPadding: padding ?? const EdgeInsets.fromLTRB(0, 10, 2, 2),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.transparent),
      ),
      hintStyle: hintStyle ?? const TextStyle(
        fontSize: 14,
        color: Color.fromRGBO(153, 153, 153, 1),
      ),
      alignLabelWithHint: true,
    );
  }
}
