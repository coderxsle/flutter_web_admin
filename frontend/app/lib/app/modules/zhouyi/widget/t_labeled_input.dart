import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../utils/global.dart';

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
        Row(
          children: [
            Container(
              width: 3.w,
              height: 13.h,
              decoration: BoxDecoration(
                color: ThemeColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 6.w),
            Text(label, style: blackBoldStyle(font: 14)),
          ],
        ),
        SizedBox(height: 6.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          child: TInput.multiline(
            controller: controller,
            onChanged: onChanged,
            hintText: hintText,
            minLines: minLines,
            maxLines: maxLines,
            style: blackStyle(font: 14),
            decoration: const InputDecoration(
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}
