import 'package:auto_shop_server/app/theme/app_theme.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/common/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///@description 底部有三个按钮的平分---暂时没有地方用，无法测试
///@updateTime 2024/12/24 14:11
class PageBottomThreeButtonWidgetSpace extends StatelessWidget {
  final bool topLine = true;
  final bool? hasExtraButton; //是否有额外的按钮,如果有额外的按钮，title3和onPressed3是必须要写的
  final bool? hasTwoButton; //是否是两个按钮
  final String title1; //
  final String? title2;
  final String? title3; //2024-10-22新增
  final VoidCallback onPressed1; //
  final VoidCallback? onPressed2;
  final VoidCallback? onPressed3; //2024-10-22新增
  final EdgeInsets? padding;
  final Color? bgColor1;
  final Color? bgColor2;
  final Color? bgColor3;
//  按钮布局左侧的布局
  // final Widget left;

  const PageBottomThreeButtonWidgetSpace({
    super.key,
    this.hasExtraButton,
    this.hasTwoButton,
    required this.title1,
    this.title2,
    this.title3,
    required this.onPressed1,
    this.onPressed2,
    this.onPressed3,
    this.bgColor1,
    this.bgColor2,
    this.bgColor3,
    this.padding,
    // required this.left,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        color: TdColors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (topLine) const DividerLine(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: onPressed1,
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(0, 12, 0, 30).r,
                    padding: padding ?? const EdgeInsets.fromLTRB(30, 10, 30, 10).r,
                    decoration: BoxDecoration(
                      color: bgColor1 ?? TdColors.brand,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(title1, style: TextStyle(fontSize: 15.sp, color: TdColors.white)),
                      ],
                    ),
                  ),
                ),
                if (hasTwoButton ?? false)
                  InkWell(
                    onTap: onPressed2,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 12, 0, 30).r,
                      padding: padding ?? const EdgeInsets.fromLTRB(30, 10, 30, 10).r,
                      decoration: BoxDecoration(
                        color: bgColor2 ?? TdColors.brand,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(title2??"", style: TextStyle(fontSize: 15.sp, color: TdColors.white)),
                        ],
                      ),
                    ),
                  ),
                if (hasExtraButton ?? false)
                  InkWell(
                    onTap: onPressed3,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(0, 12, 0, 30).r,
                      padding: padding ?? const EdgeInsets.fromLTRB(30, 10, 30, 10).r,
                      decoration: BoxDecoration(
                        color: bgColor3 ?? TdColors.brand,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(title3 ?? "", style: TextStyle(fontSize: 15.sp, color: TdColors.white)),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ));
  }
}
