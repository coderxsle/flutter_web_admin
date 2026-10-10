import 'package:auto_shop_server/app/theme/app_colors.dart';
import 'package:auto_shop_server/app/theme/app_text_theme.dart';
import 'package:auto_shop_server/common/widgets/row_main_align_center.dart';
import 'package:flutter/material.dart';

//适用于小表单，的提交按钮
class ButtonSubmit extends StatelessWidget {
  final String? buttonText;
  final VoidCallback onClick;
  const ButtonSubmit({super.key, this.buttonText, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 6),
      child: ElevatedButton(
        onPressed: onClick,
        style: ElevatedButton.styleFrom(
          backgroundColor: ThemeColor,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        ),
        child: RowMainAlignCenter(
          children: [
            Text(buttonText ?? '提 交', style: whiteStyle(font: 14.5)),
          ],
        ),
      ),
    );
  }
}
