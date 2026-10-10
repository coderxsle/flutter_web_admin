import 'package:auto_shop_server/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

//可点击的文字按钮，例如筛选九宫格里的条目
class ButtonTextClickChangeColorWithRadiusGrid extends StatelessWidget {
  final int? index;
  final String? text;
  final bool state;
  final double? fontSize;
  final Alignment? alignment; //如果是流式布局不需要这个，如果是九宫格类型的
  final bool? isGridView; //，如果是九宫格类型的是有一个位置的-默认是九宫格类型
  const ButtonTextClickChangeColorWithRadiusGrid({
    super.key,
    this.index,
    this.text,
    required this.state,
    this.alignment = Alignment.center,
    this.isGridView,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: 34,
        // padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
        alignment: (isGridView ?? true) ? Alignment.center : null,
        decoration: BoxDecoration(
          //color: state ? TdColors.brand : Colors.grey[100],
          color: state ? TdColors.brand : Colors.grey[100],
          // color: state ? Colors.red[300] : Colors.grey[100],
          borderRadius: BorderRadius.circular(17.0),
        ),
        child: (isGridView ?? true) ? _item() : Padding(padding: EdgeInsets.fromLTRB(12, 0, 12, 0), child: _item()),
      ),
    );
  }

  //中间通用的小条目
  Text _item() {
    return Text(
      text ?? "",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: fontSize ?? 14, color: state ? Colors.white : Colors.black),
    );
  }
}
