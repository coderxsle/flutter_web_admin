import 'package:auto_shop_server/app/utils/common_widget/common_widget.dart';
import 'package:auto_shop_server/app/utils/strings.dart';
import 'package:flutter/cupertino.dart';
///@description 方块图片 但是有一点四周切小圆角
///@updateTime 2024/12/24 8:48
class ClipRRectImageNetwork extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  const ClipRRectImageNetwork({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: imageNetwork(
          imageUrl ?? placeholder_115, //主图和占位图   // ParamKey.imageTest,
          width: width??50,
          height: height??50,
          fit: BoxFit.cover,
        ));
  }
}
