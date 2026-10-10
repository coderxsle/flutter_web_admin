
import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/app/utils/common_widget/search_in_dialog.dart';
import 'package:auto_shop_server/common/widgets/divider_line_light.dart';
import 'package:auto_shop_server/common/widgets/page_bottom_double_button_widget.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//目前它是和 showMaterialModalBottomSheet 配套使用的。
//@updateTime 2025/2/18但是这种有扩展，这种有搜索框能力而且有点击事件回调，要比普通的BottomDialogWrap更复杂
///@description 底部内部装载九宫格弹窗的九宫格右上角有个小叉号，这是一个空壳子，装载子view
///@updateTime 2024/11/13 19:30
class BottomDialogWrapWithSearch extends StatelessWidget {
  //加一个跳转标志为了做关闭或者刷新其他操作预留
  final int fromWhere;
  //弹窗标题
  final String title;
  final TextStyle? titleStyle;
  //左侧按钮的文字
  final String? leftButtonText;
  //右侧按钮的文字
  final String? rightButtonText;
  //中间的view，由外部传入
  final Widget bodyView;
  //底部的view
  final bool? bottomView;
  final VoidCallback? leftHookCallback;
  final VoidCallback? rightHookCallback;
  //关闭按钮的监听:这个监听是可有可无的。有的弹窗用到，有的用不到。
  final VoidCallback? closeCallBack;
  //搜索关键字的回调，这个回调是必须有的，因为这个弹窗是和搜索相关的。
  // final Function(String) callbackHookKeyWord;
  final ValueChanged<String> callbackHookKeyWord;
  const BottomDialogWrapWithSearch({
    super.key,
    required this.fromWhere,
    required this.title,
    required this.bodyView,
    required this.bottomView,
    required this.callbackHookKeyWord,
    this.leftButtonText,
    this.rightButtonText,
    this.leftHookCallback,
    this.rightHookCallback,
    this.closeCallBack,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleRow(title),
        const DividerLineLight(),
        //中间的搜索框，从本地数据库搜索
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
          child: SizedBox(
            height: 36,
            width: Get.width,
            child: SearchInDialogWidget(
              onChanged: (String textKeyWord) {
                if (textKeyWord.isNotEmpty) {
                  //如果将来拦截空搜索，这里可用
                  callbackHookKeyWord(textKeyWord);
                } else {
                  showMessageBottomLikeAndroid(please_input_keyWords, isLong: false);
                }
              }, callbackNull: (String textKeyWordNull) {
                //TODO 2025/2/18 如果搜索值内容是空，如何处理？直接还原列表内的原始数据
                callbackHookKeyWord(textKeyWordNull);
            },
            ),
          ),
        ),
        const DividerLineLight(),
        // const SizedBox(height: 1),
        bodyView,
        // const SizedBox(height: 1),
        //bottomView ?? SizedBox.shrink(),
        if (bottomView ?? false)
          PageBottomDoubleButtonWidget(
            topLine: true,
            textLeft: leftButtonText ?? "",
            onClickLeftCallback: leftHookCallback ?? () {},
            textRight: rightButtonText ?? "",
            onClickRightCallback: rightHookCallback ?? () {},
          ),
      ],
    );
  }

  Row _titleRow(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.all(12.0), child: Text(title, style: titleStyle ?? greyStyle85(font: 13.5))),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (!ObjectUtil.isEmpty(closeCallBack)) {
              closeCallBack?.call();
            }
          },
        ),
      ],
    );
  }
}
