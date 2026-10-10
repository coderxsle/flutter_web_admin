import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/app/theme/app_text_theme.dart';

///@description 带边框线的小标签
///@updateTime 2024/12/7 10:31
class TagSmallOutline extends StatelessWidget {
  final String tagName;
  final double? fontSize;
  const TagSmallOutline({super.key, required this.tagName, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 1, 6, 1),
      margin: const EdgeInsets.fromLTRB(0, 0, 4, 0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!, width: 0.5),
        color: Colors.grey[100],
        //borderRadius: BorderRadius.circular(10.0),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Center(
          child: Text(
        tagName,
        style: greyStyle85(font: fontSize ?? font_11),
      )),
    );
  }
}
//如果左侧携带图标就用左右布局
// child: Row(
// mainAxisAlignment: MainAxisAlignment.start,
// crossAxisAlignment: CrossAxisAlignment.center,
// mainAxisSize: MainAxisSize.min,
// children: [
// //Icon(Icons.sell_outlined, size: 18, color: Colors.grey[350]!),
// Center(
// child: Text(
// tagName,
// style: greyStyle85(font: fontSize ?? font_11),
// )),
// ],
// ),
