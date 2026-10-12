import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/global.dart';

/// 排盘页的单行表单：左侧标签 + 右侧控件。
/// [expand] 为 false 时控件按内容宽度收缩，不会被拉到行的另一端。
class TRowField extends StatelessWidget {
  const TRowField({
    super.key,
    required this.label,
    required this.child,
    this.expand = true,
    this.padding,
  });

  final String label;
  final Widget child;
  final bool expand;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 6.h),
      child: Row(
        children: [
          Text(label, style: blackStyle(font: 15)),
          SizedBox(width: 16.w),
          if (expand) Expanded(child: child) else child,
        ],
      ),
    );
  }
}
