import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../utils/global.dart';
import 't_section_title.dart';

/// 基于 tdesign [TInput] 封装的多行备注输入块。
///
/// tdesign 的 [TInput] 只提供输入本体，没有「红色竖条标题 + 多行白底输入区」
/// 这种排盘页常见版式，这里补齐版式。
class TLabeledInput extends StatelessWidget {
  const TLabeledInput({
    super.key,
    required this.label,
    this.hintText,
    this.controller,
    this.minLines = 2,
    this.maxLines,
    this.onChanged,
  });

  final String label;
  final String? hintText;
  final TextEditingController? controller;
  final int minLines;
  final int? maxLines;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TSectionTitle(label),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TInput(
            controller: controller,
            onChanged: onChanged,
            hintText: hintText,
            minLines: minLines,
            maxLines: maxLines,
            borderless: true,
            style: blackStyle(font: 14),
          ),
        ),
      ],
    );
  }
}
