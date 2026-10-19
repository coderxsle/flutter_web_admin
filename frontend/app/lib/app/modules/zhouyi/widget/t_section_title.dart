import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/global.dart';

/// 排盘页统一的栏目标题：品牌色竖条 + 加粗标题，右侧可选小动作。
class TSectionTitle extends StatelessWidget {
  const TSectionTitle(this.label, {super.key, this.trailing});

  final String label;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(2.w, 6.h, 2.w, 8.h),
      child: Row(
        children: [
          Container(
            width: 3.w,
            height: 14.h,
            decoration: BoxDecoration(
              color: TdColors.brand,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 6.w),
          Text(label, style: blackBoldStyle()),
          if (trailing != null) ...[const Spacer(), trailing!],
        ],
      ),
    );
  }
}
