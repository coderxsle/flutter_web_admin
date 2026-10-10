import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/app/utils/common_widget/search_in_dialog_preview.dart';
import 'package:auto_shop_server/common/widgets/divider_line_light.dart';
import 'package:auto_shop_server/common/widgets/page_bottom_double_button_widget.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

//做预览用的搜索栏
///@updateTime 2024/11/13 19:30
class BottomSheetDialogWrapWithSearchPreview extends StatelessWidget {
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
  final ValueChanged<String> callbackHookKeyWord;
  //
  const BottomSheetDialogWrapWithSearchPreview({
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
            child: SearchInDialogPreviewWidget(
              callbackSearchPage: () {
                //TODO 2025/3/19 跳转到搜索列表页面：
                //携带已勾选的内容
                //点击页面跳转到搜索
              },
            ),
          ),
        ),
        const DividerLineLight(),
        // const SizedBox(height: 1),
        bodyView,
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
