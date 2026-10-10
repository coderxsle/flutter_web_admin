import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/app/theme/app_text_theme.dart';
import 'package:auto_shop_server/app/utils/common_widget/build_row.dart';
import 'package:auto_shop_server/common/widgets/row_main_align_start.dart';

///@description 左侧小星星必填项
///@updateTime 2024/12/22 10:33
class TextStarWidget extends StatelessWidget {
  const TextStarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Text("*", style: redBoldStyle()),
    );
  }
}

///@description 携带小星号的标题内容
///@updateTime 2024/12/22 10:48
class BuildTitleWithStartWidget extends StatelessWidget {
  final String title;
  final TextStyle? titleStyle;
  //是否要小星星
  final bool? isWithStar;
  const BuildTitleWithStartWidget({
    super.key,
    required this.title,
    this.titleStyle,
    this.isWithStar,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 6),
      child: RowMainAlignStart(
        children: [
          //默认是添加星星的，特殊情况可以不要
          if (isWithStar ?? true) TextStarWidget(),
          BuildTitle(
            title: title,
            titleStyle: titleStyle ?? blackStyle(font: font_12),
            padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
            firstRadius: false,
          ),
        ],
      ),
    );
  }
}
