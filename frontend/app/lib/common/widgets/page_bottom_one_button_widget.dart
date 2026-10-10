import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/common/widgets/common.dart';

import '../../app/utils/global.dart';
///@description 页面底部单个按钮
///@updateTime 2024/12/3 11:04
class PageBottomOneButtonWidget extends StatelessWidget {
  final String title;
  final bool topLine;
  final VoidCallback onPressed;
  const PageBottomOneButtonWidget({
    super.key,
    required this.title,
    required this.topLine,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Platform.isIOS ? 80 : 80, //android设备暂时写80，80更稳妥
      color: BGColor_white_255,
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Column(children: [
        if (topLine ?? true) const DividerLine(),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 30, 0),
          child: MaterialButton(
              height: 40,
              color: ThemeColor,
              // padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              onPressed: onPressed,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22), // 设置圆角半径
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: whiteStyle()),
                ],
              )
              // child: Text(title, style: whiteStyle()),
              ),
        ),
      ]),
    );
  }
}
