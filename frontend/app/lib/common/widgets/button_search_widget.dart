import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/app/theme/app_theme.dart';
import 'package:auto_shop_server/app/theme/app_text_theme.dart';
import 'package:auto_shop_server/app/utils/common_widget/my_material_button.dart';

///@description 搜索栏右侧的按钮，小按钮，有几个地方用到
class ButtonSearchWidget extends StatelessWidget {
  final String text;
  //设置字号
  final double? fontSize;
  final Color? colorMy;
  final EdgeInsetsGeometry? padding;
  final VoidCallback onPressed;
  final Widget? leftView;
  const ButtonSearchWidget({
    super.key,
    required this.text,
    this.padding,
    required this.onPressed,
    this.fontSize,
    this.leftView,
    this.colorMy,
  });

  @override
  Widget build(BuildContext context) {
    return MyMaterialButton(
      onPressed: onPressed,
      color: colorMy ?? TdColors.brand,
      borderRadius: BorderRadius.circular(22),
      child: Padding(
        padding: padding ?? const EdgeInsets.fromLTRB(10, 4, 10, 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leftView != null) leftView!,
            Text(text, textAlign: TextAlign.center, style: whiteStyle(font: fontSize ?? 13.5)),
          ],
        ),
      ),
    );
  }
}
