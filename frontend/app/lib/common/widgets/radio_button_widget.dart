import 'package:auto_shop_server/common/index.dart';
import 'package:auto_shop_server/app/theme/app_theme.dart';
import 'package:auto_shop_server/app/theme/app_text_theme.dart';

///@description 添加通用的单选按钮的样式在几个radiobutton之中
///@updateTime 2024/10/25 16:24
class RadioButtonWidget extends StatelessWidget {
  final String label;
  final bool checkValue;
  final VoidCallback onChanged;

  const RadioButtonWidget({super.key, required this.label, required this.checkValue, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 30,
          height: 30,
          child: Checkbox(
            shape: const CircleBorder(),
            side: const BorderSide(width: 1, color: Color.fromRGBO(151, 151, 151, 1)),
            value: checkValue,
            activeColor: TdColors.brand,
            onChanged: (bool? checked) {
              if (checked == true) {
                onChanged.call();
              }
            },
          ),
        ),
        Text(label, style: blackStyle()),
      ],
    );
  }
}
