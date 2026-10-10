import 'package:auto_shop_server/app/theme/app_text_theme.dart';
import 'package:auto_shop_server/common/widgets/column_with_size_min.dart';
import 'package:auto_shop_server/common/widgets/divider_line_light.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///@description 左右摆开的文本行组件
///@updateTime 2024/12/4 16:28
class RowTextBetweenWidget extends StatelessWidget {
  final String textL; //
  final String textR; //
  final TextStyle? leftStyle;
  final TextStyle? rightStyle;
  final double? height;
  //是否在底部画出一条线条
  final bool? dividerLine;
  //线条两端间距
  final double? linePaddingBoth;
  const RowTextBetweenWidget(
    //左侧文字和右侧文字放在前两位
    this.textL,
    this.textR, {
    super.key,
    this.leftStyle,
    this.rightStyle,
    this.dividerLine,
    this.linePaddingBoth,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: (height ?? 44).h),
      child: ColumnWithSizeMin(
        children: [
          Row(children: [
            Expanded(
              child: Text(textL, style: leftStyle ?? blackStyle()),
            ),
            Text(textR, style: rightStyle ?? greyStyle()),
          ]),
          if (dividerLine ?? false) DividerLineLight(left: linePaddingBoth ?? 0.0, right: linePaddingBoth ?? 0.0),
        ],
      ),
    );
  }
}
