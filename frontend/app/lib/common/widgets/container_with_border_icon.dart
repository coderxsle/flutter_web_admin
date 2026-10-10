import 'package:auto_shop_server/app/theme/app_theme.dart';
import 'package:auto_shop_server/app/theme/app_text_theme.dart';
import 'package:flutter/material.dart';

import '../../app/utils/global.dart';

///@description 添加图标的有背景的时间图标。一般用在时间上，也可以用在其他
///@updateTime 2024/12/26 16:45
class ContainerWithBorderIcon extends StatelessWidget {
  //放在左侧的整块文字追加前缀
  final String textLeftPrefix;
  final String textRightValue;
  final bool? isHasBorder;
  //是否需要左侧图标
  final bool? isHasIcon;
  final Color? color;
  final TextStyle? valueTextStyle;
  const ContainerWithBorderIcon({
    super.key,
    required this.textLeftPrefix,
    required this.textRightValue,
    required this.isHasBorder,
    this.isHasIcon,
    this.color,
    this.valueTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
      margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      decoration: BoxDecoration(
        border: isHasBorder ?? false ? Border.all(color: Colors.grey[300]!, width: 0.5) : null,
        color: color ?? Colors.grey[100],
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if(isHasIcon??true)
          Icon(Icons.alarm_outlined, size: 18, color: (textRightValue.isNotEmpty && (textRightValue != stepHasNotPlan)) ? TdColors.brand : Colors.grey[350]),
          const SizedBox(width: 2),
          rowKeyValueText(
            textLeftPrefix, //是前缀
            textRightValue,
            keyStyle: greyStyle85(font: 11.5),
            valueStyle: valueTextStyle ?? greyStyle85(font: 11.5),
            top: 0,
            bottom: 0,
          ),
          const SizedBox(width: 2),
          //rowKeyValueText(textLeft, textRight, keyStyle: greyStyle85(font: 12), valueStyle: greyStyle85(font: 12), top: 0, bottom: 0,),
        ],
      ),
    );
  }
}
