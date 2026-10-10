import 'package:auto_shop_server/app/theme/app_colors.dart';
import 'package:auto_shop_server/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

//九宫格列表条目，有选中和未选中两种状态并带描边。
class ButtonTextClickChangeColorWithRadius extends StatelessWidget {
  final int? index;
  //需要自定义内容高度时传入
  final double? height;
  final String? text;
  final bool state;
  final double? fontSize;
  final Alignment? alignment; //如果是流式布局不需要这个，如果是九宫格类型的
  // final bool? isGridView; //，如果是九宫格类型的是有一个位置的-默认是九宫格类型
  const ButtonTextClickChangeColorWithRadius({
    super.key,
    this.index,
    this.text,
    required this.state,
    this.alignment = Alignment.center,
    // this.isGridView,
    this.fontSize,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: height ?? 30,
        decoration: BoxDecoration(
          //color: state ? ThemeColor : Colors.grey[100],
          //color: state ? BGColor_red_253_232_232 : Colors.grey[100],
          // color: state ? Colors.redAccent[100]! : Colors.grey[50],
          color: state ? BGColor_red_253_232_232 : Colors.grey[50],
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            //color: state ? Colors.redAccent : Colors.grey[300]!,
            //color: state ? Font_Color_red : Colors.grey[300]!,
            color: state ? Colors.redAccent[100]! : Colors.grey[300]!,
            width: state ? 1.0 : 0.8, // 边框宽度选中和未选中不同
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min, // 子元素根据内容调整大小
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  child: Text(
                    text ?? "",
                    textAlign: TextAlign.center,
                    //style: TextStyle(fontSize: fontSize ?? 14, color: state ? Colors.white : Colors.black),
                    //style: TextStyle(fontSize: fontSize ?? 14, color: state ? Colors.black : Colors.blueGrey),
                    style: state ? blackStyle(font: fontSize ?? 14) : greyStyle85(font: fontSize ?? 14),
                  )),
            ),
          ],
        ),
      ),
    );
  }
  //中间通用的小条目
  /*Text _item() {
    return Text(
      text ?? "",
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: fontSize ?? 14, color: state ? Colors.white : Colors.black),
    );
  }*/
}
