import 'package:auto_shop_server/app/theme/app_theme.dart';
import 'package:auto_shop_server/app/theme/app_text_theme.dart';
import 'package:auto_shop_server/app/utils/common_widget/common_widget.dart';
import 'package:auto_shop_server/common/widgets/row_main_align_center.dart';
import 'package:auto_shop_server/common/widgets/row_main_align_start.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///@description 顶部类似 popup 的点击菜单，左侧文字右侧箭头
///@updateTime 2024/11/14 14:10
/////@timeUpdate 2025/7/2 携带外部的背景框 的下拉选择按钮。
class TextWithArrowDropDownWithBackground extends StatelessWidget {
  final String? title;
  final VoidCallback onTapCallback;
  const TextWithArrowDropDownWithBackground({super.key, this.title, required this.onTapCallback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapCallback,
      child: RowMainAlignCenter(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: TdColors.pageBg,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: Colors.grey.shade100, width: 1),
            ),
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: RowMainAlignStart(children: [
              rowKeyValueText(
                "",
                title,
                bottom: 0,
                keyStyle: blackStyle(),
                valueStyle: blackStyle(font: 13.5),
                padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
              ),
              const Icon(Icons.arrow_drop_down),
            ]),
          ),
        ],
      ),
    );
  }
}
