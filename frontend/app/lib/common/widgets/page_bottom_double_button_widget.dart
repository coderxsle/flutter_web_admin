import 'package:auto_shop_server/app/theme/app_colors.dart';
import 'package:auto_shop_server/common/widgets/divider_line_light.dart';
import 'package:flutter/material.dart';

///@description 页面的底部按钮目前是左右两个,将来再次扩展1个的和3个的
///用在表单底部【重置】【确定】等场景
///@updateTime 2024/11/14 8:42
class PageBottomDoubleButtonWidget extends StatelessWidget {
  final bool? topLine;
  final String textLeft;
  final VoidCallback onClickLeftCallback;
  final String textRight;
  final VoidCallback onClickRightCallback;
  const PageBottomDoubleButtonWidget({
    super.key,
    required this.textLeft,
    required this.onClickLeftCallback,
    required this.textRight,
    required this.onClickRightCallback,
    this.topLine,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 70,
        color: BGColor_white_255,
        child: Column(children: [
          if (topLine ?? false) const DividerLineLight(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: onClickLeftCallback,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(20, 10, 0, 20),
                    padding: const EdgeInsets.fromLTRB(22, 8, 22, 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[300]!,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(textLeft, style: const TextStyle(fontSize: 16, color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: InkWell(
                  onTap: onClickRightCallback,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.fromLTRB(10, 10, 20, 20),
                    padding: const EdgeInsets.fromLTRB(22, 8, 22, 8),
                    decoration: BoxDecoration(
                      color: ThemeColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(textRight, style: const TextStyle(fontSize: 16, color: Font_Color_white_255)),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]));
  }
}
