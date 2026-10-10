import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/app/utils/global.dart';

///@description 在右侧有两个按钮的布局而且左侧也有文字布局的
///@updateTime 2024/12/3 17:16
class PageButtonBottomRightTwo extends StatelessWidget {
  // Widget left = const SizedBox();
  final String textLeft;
  final String textRight;
  final double? height;
  final bool topLine;
  final VoidCallback onPressedLeft;
  final VoidCallback onPressedRight;
  //按钮布局左侧的布局
  final Widget left;

  const PageButtonBottomRightTwo({
    super.key,
    required this.textLeft,
    required this.textRight,
    required this.onPressedLeft,
    required this.onPressedRight,
    this.height,
    required this.topLine,
    required this.left,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: TabBarHeight,
      color: TdColors.white,
      child: Column(children: [
        Offstage(offstage: !topLine, child: dividerLine()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8),
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: left,
            ),
            //右侧是两个按钮，两个布局
            Row(
              children: [
                //左侧的重置按钮
                InkWell(
                  onTap: onPressedLeft,
                  child: Container(
                    // height: height ?? 38,
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                    margin: const EdgeInsets.only(top: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(19),
                    ),
                    child: Center(
                      child: Text(textLeft, style: blackStyle()),
                    ),
                  ),
                ),
                //右侧的确定按钮
                InkWell(
                  onTap: onPressedRight,
                  child: Container(
                    // height: height ?? 38,
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                    margin: const EdgeInsets.only(top: 10, right: 15),
                    decoration: BoxDecoration(
                      color: TdColors.brand,
                      borderRadius: BorderRadius.circular(19),
                    ),
                    child: Center(
                      child: Text(textRight, style: whiteStyle()),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ]),
    );
  }
}
