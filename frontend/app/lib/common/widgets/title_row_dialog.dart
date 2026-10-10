import 'package:auto_shop_server/app/utils/global.dart';
import 'package:auto_shop_server/common/index.dart';
import 'package:get/get.dart';

///@description 弹窗的标题--计划将所有弹窗的标题都用这个统一
///@updateTime 2024/12/20 10:32
class TitleRowDialog extends StatelessWidget {
  final String title;
  final VoidCallback? callBackClose;
  const TitleRowDialog({
    super.key,
    required this.title,
    this.callBackClose,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Text(title, style: greyStyle85(font: 13.5)),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (!ObjectUtil.isEmpty(callBackClose)) {
              callBackClose?.call();
            }

            Get.back();
          },
        ),
      ],
    );
  }
}
