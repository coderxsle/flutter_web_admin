import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/app/utils/common_widget/my_material_button.dart';
import 'package:auto_shop_server/common/widgets/item_wrap_widget_with_click.dart';
import 'package:auto_shop_server/common/widgets/row_main_align_spaceBetween.dart';

///@description 一个通用的在主页界面出现的左侧时间选择器
///@updateTime 2025/2/19 11:02
class TimeSelectWidget extends StatelessWidget {
  //点击选中日期的点击事件
  final VoidCallback onClickSelectTime;
  //点击重置时间的逻辑
  final VoidCallback onClickResetTime;
  //添加需要被监听的子view
  final Widget rxSubView;
  //设置距离顶部或者其他间距
  final EdgeInsetsGeometry? marginMy;

  const TimeSelectWidget({
    super.key,
    required this.onClickSelectTime,
    required this.onClickResetTime,
    required this.rxSubView,
    //是可选的
    this.marginMy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: marginMy??const EdgeInsets.fromLTRB(4, 0, 0, 0),
      // color: Colors.yellow,
      decoration: BoxDecoration(
        color: Colors.white,
        // color: Colors.yellow,
        borderRadius: BorderRadius.circular(borderRadius_search_two),
      ),
      child: RowMainAlignSpaceBetween(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 1, 0, 1),
            child: MyMaterialButton(
              color: Colors.grey[100],
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(borderRadius_search),bottomLeft: Radius.circular(borderRadius_search)),
              onPressed: onClickSelectTime,
              child: Container(
                color: Colors.white,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                height: 36,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 6),
                    const Icon(Icons.arrow_drop_down, size: 22, color: TdColors.grey85),
                    //需要被监听的view
                    rxSubView,
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
            child: ItemWrapWidgetWithClick(
                text: "重置",
                borderRadiusMy: 22.0,
                borderColor: Colors.grey[300]!,
                paddingMy: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                textStyleMy: greyStyle85(font: font_12),
                clickSate: false,
                index: 0,
                //onTap: () => controller.resetTime()
                onTap: onClickResetTime),
          )
          //代码勿删！！！如果【重置】按钮动态展示，就用下面代码
          /*Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 6, 0),
                          child: Obx(() => Visibility(
                            visible: !ObjectUtil.isEmptyString(controller.rxSearchTimeHistory?.value),
                            child: ItemWrapWidgetWithClick(
                                text: "重置",
                                borderRadiusMy: 22.0,
                                borderColor: Colors.grey[300]!,
                                paddingMy: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                                textStyleMy: greyStyle85(font: font_12),
                                clickSate: false,
                                index: 0,
                                onTap: () => controller.resetTime()),
                          )),
                        )*/
        ],
      ),
    );
  }
}
