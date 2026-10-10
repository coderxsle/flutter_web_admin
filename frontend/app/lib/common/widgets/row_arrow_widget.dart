import 'package:auto_shop_server/app/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

///@description 右侧箭头小组件
///@updateTime 2024/12/18 14:55
class RowArrowWidget extends StatelessWidget {
  final double? size;
  final Color? colors;
  const RowArrowWidget({
    super.key,
    this.size,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      //Icons.arrow_forward_ios,
      TIcons.chevron_right,
      size: (size ?? 20).h,
      color: colors ?? Font_Color_grey_165,
    );
  }
}
