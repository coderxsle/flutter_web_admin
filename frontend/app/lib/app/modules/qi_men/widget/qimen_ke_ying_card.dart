import 'package:auto_shop_server/common/widgets/container_with_radius.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/global.dart';

/// 十干克应卡片（对应安卓 list_item_hour_qimen_text.xml）。
///
/// 中 5 宫（[position] == 4）不展示。
class QiMenKeYingCard extends StatelessWidget {
  const QiMenKeYingCard({
    super.key,
    required this.position,
    required this.description1,
    required this.description2,
    this.onTap,
  });

  /// 宫位下标 0-8，下标 4 为中 5 宫
  final int position;

  /// 天盘干 + 地盘干 克应
  final String description1;

  /// 暗干飞支之干 + 地盘干 克应
  final String description2;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ContainerWithRadius(
      margin: EdgeInsets.fromLTRB(0, 0, 0, 8.h),
      padding: EdgeInsets.fromLTRB(12.w, 10.w, 12.w, 10.w),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('第${position + 1}宫', style: blackBoldStyle(font: 15)),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, size: 12, color: TdColors.grey195),
            ],
          ),
          if (description1.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(description1, style: blackStyle(font: 12.5)),
          ],
          if (description2.isNotEmpty) ...[
            SizedBox(height: 4.h),
            Text(description2, style: greyStyle(font: 12.5)),
          ],
        ],
      ),
    );
  }
}
