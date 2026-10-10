import 'package:auto_shop_server/app/theme/app_colors.dart';
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/common/widgets/column_with_size_min.dart';
import 'package:auto_shop_server/common/widgets/common.dart';
import 'package:auto_shop_server/common/widgets/row_main_align_spaceBetween.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

///@description 底部有三个按钮的平分
///@updateTime 2024/12/24 14:11
class PageBottomThreeButtonWidgetWithLeftView extends StatelessWidget {
  final bool topLine = true;
  final bool? hasExtraButton; //是否有额外的按钮,如果有额外的按钮，title3和onPressed3是必须要写的
  final bool? hasFirstButton; //是否有第一个按钮
  final bool? hasSecondButton; //是否有第二个按钮
  final String title1;
  final String? title2;
  final String? title3;
  final VoidCallback onPressed1;
  final VoidCallback? onPressed2;
  final VoidCallback? onPressed3;
  final EdgeInsets? paddingButton;
  final Color? bgColor1;
  final Color? bgColor2;
  final Color? bgColor3;
  //按钮布局左侧的布局
  final Widget leftView;

  const PageBottomThreeButtonWidgetWithLeftView({
    super.key,
    this.hasExtraButton,
    this.hasFirstButton,
    this.hasSecondButton,
    required this.title1,
    this.title2,
    this.title3,
    required this.onPressed1,
    this.onPressed2,
    this.onPressed3,
    this.bgColor1,
    this.bgColor2,
    this.bgColor3,
    this.paddingButton,
    required this.leftView,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: BGColor_white_255,
      child: ColumnWithSizeMin(
        children: [
          if (topLine) const DividerLine(),
          RowMainAlignSpaceBetween(children: [
            Expanded(
              flex: 1,
              child: Container(
                height: TabBarHeight,
                width: 100,
                color: Colors.white,
                // padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                margin: const EdgeInsets.only(left: 10),
                child: leftView,
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasFirstButton ?? true)
                    InkWell(
                      onTap: onPressed1,
                      child: Container(
                        height: 40,
                        // margin: const EdgeInsets.fromLTRB(0, 10, 0, 10).r,
                        padding: paddingButton ?? const EdgeInsets.fromLTRB(10, 10, 10, 10).r,
                        decoration: BoxDecoration(
                          color: bgColor1 ?? ThemeColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(title1, style: TextStyle(fontSize: 15.sp, color: Font_Color_white_255)),
                          ],
                        ),
                      ),
                    ),
                  if (hasSecondButton ?? false)
                    InkWell(
                      onTap: onPressed2,
                      child: Container(
                        height: 40,
                        margin: const EdgeInsets.fromLTRB(10, 0, 10, 0).r,
                        padding: paddingButton ?? const EdgeInsets.fromLTRB(10, 10, 10, 10).r,
                        decoration: BoxDecoration(
                          color: bgColor2 ?? ThemeColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(title2 ?? "", style: TextStyle(fontSize: 15.sp, color: Font_Color_white_255)),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(width: 10),
                  // if (hasExtraButton ?? false)--目前暂时没有第三个按钮出现
                  /*InkWell(
                      onTap: onPressed3,
                      child: Container(
                        height: 50,
                        margin: const EdgeInsets.fromLTRB(0, 10, 10, 0).r,
                        padding: padding ?? const EdgeInsets.fromLTRB(10, 10, 10, 10).r,
                        decoration: BoxDecoration(
                          color: bgColor3 ?? ThemeColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(title3 ?? "", style: TextStyle(fontSize: 15.sp, color: Font_Color_white_255)),
                          ],
                        ),
                      ),
                    ),*/
                ],
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
