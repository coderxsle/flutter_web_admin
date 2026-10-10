import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/app/theme/app_text_theme.dart';

///@description 从common_widget之中抽取的目的是为了换行的
///@updateTime 2024/12/4 14:09
class RowKeyValueTextWidget extends StatelessWidget {
  final String? textLeft;
  final String? textRight;
  final TextStyle? keyStyle;
  final TextStyle? valueStyle;
  final double? valueWidth;
  final double? top;
  final double? bottom;
  final EdgeInsetsGeometry? padding;
  final double? font;
  //右侧间距的空白区域
  final double? rightBlank;
  const RowKeyValueTextWidget({
    super.key,
    this.keyStyle,
    this.valueStyle,
    this.valueWidth,
    this.top,
    this.bottom,
    this.textLeft,
    this.textRight,
    this.padding,
    this.font,
    required this.rightBlank,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      //padding: padding ?? EdgeInsets.fromLTRB(0, top ?? 0, 0, bottom ?? pad4),
      padding: padding ?? EdgeInsets.fromLTRB(0, top ?? 0, 0, bottom ?? 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // 让 Row 适应内容宽度
        crossAxisAlignment: CrossAxisAlignment.center, // key 垂直居中
        children: [
          Text(textLeft ?? "", style: keyStyle ?? greyStyle()),
          // FractionallySizedBox(
          //maxWidth: MediaQuery.of(context).size.width - 90,
          //child: Text("${modelItem!.carBrandName} ${modelItem!.carSeriesName} ${modelItem?.vehicleName}", style: blackBoldStyle(font: font_13)),
          LimitedBox(
            maxWidth: MediaQuery.of(context).size.width - rightBlank! ?? 98.0,
            child: Text(textRight ?? "", style: valueStyle ?? blackStyle(font: font ?? font_12)),
          ),
          /*Flexible(
            // 使用 Flexible 而不是 Expanded
            fit: FlexFit.loose, // 让 child 适应内容宽度
            child: SizedBox(
              width: valueWidth, // 指定 value 的宽度
              child: Text(
                textRight ?? "",
                style: valueStyle ?? blackStyle(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true, // 自动换行
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
