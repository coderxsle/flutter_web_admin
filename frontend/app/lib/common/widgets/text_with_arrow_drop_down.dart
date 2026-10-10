import 'package:auto_shop_server/app/theme/app_text_theme.dart';
import 'package:auto_shop_server/app/utils/common_widget/common_widget.dart';
import 'package:flutter/material.dart';

///@description 顶部类似 popup 的点击菜单，左侧文字右侧箭头
///@updateTime 2024/11/14 14:10
class TextWithArrowDropDown extends StatelessWidget {
  final String? title;
  final VoidCallback onTapCallback;
  const TextWithArrowDropDown({super.key, this.title, required this.onTapCallback});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapCallback,
      child: Row(
        //外部一整条都可以点击
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: rowKeyValueText("", title, //标题内容
                bottom: 0,
                keyStyle: blackStyle(), //
                valueStyle: blackStyle(font: 13.5),
                padding: const EdgeInsets.fromLTRB(6, 0, 0, 0)),
          ),
          const Icon(Icons.arrow_drop_down),
        ],
      ),
    );
  }
}
