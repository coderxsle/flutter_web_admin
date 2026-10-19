import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/global.dart';
import '../../zhouyi/algorithm/wu_xing_util.dart';

/// 五行统计条形图：每条长度按该五行个数占最大值的比例。
class BaziWuXingChart extends StatelessWidget {
  const BaziWuXingChart({
    super.key,
    required this.count,
    this.dayGanWuXing,
  });

  /// 五行个数（木火土金水）
  final Map<String, int> count;

  /// 日主五行，用于结语
  final String? dayGanWuXing;

  static const Map<String, Color> colors = {
    '木': Color(0xFF4CAF50),
    '火': Color(0xFFE53935),
    '土': Color(0xFFA1713B),
    '金': Color(0xFF9E9E9E),
    '水': Color(0xFF1E88E5),
  };

  @override
  Widget build(BuildContext context) {
    if (count.isEmpty) return const SizedBox.shrink();
    final maxValue = count.values.isEmpty
        ? 0
        : count.values.reduce((a, b) => a > b ? a : b);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final element in WuXingUtil.elements)
          _buildBar(element, maxValue),
        SizedBox(height: 6.h),
        Text(_summary(), style: greyStyle(font: 12.sp)),
      ],
    );
  }

  Widget _buildBar(String element, int maxValue) {
    final value = count[element] ?? 0;
    final color = colors[element] ?? TdColors.grey153;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        children: [
          SizedBox(
            width: 20.w,
            child: Text(
              element,
              style: blackBoldStyle().copyWith(color: color),
            ),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final ratio = maxValue == 0 ? 0.0 : value / maxValue;
                // 有条目时至少留 4px，避免数值很小时看不见
                final width = value == 0 ? 0.0 : constraints.maxWidth * ratio;
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: width < 4 && value > 0 ? 4 : width,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 6.w),
          SizedBox(
            width: 16.w,
            child: Text(
              '$value',
              textAlign: TextAlign.right,
              style: blackStyle(),
            ),
          ),
        ],
      ),
    );
  }

  String _summary() {
    final parts = <String>[];
    if (dayGanWuXing != null && dayGanWuXing!.isNotEmpty) {
      parts.add('日主$dayGanWuXing');
    }

    final strong = WuXingUtil.strongest(count);
    if (strong.isNotEmpty && strong.length < WuXingUtil.elements.length) {
      parts.add('以${strong.join('、')}为多');
    }

    final missing = WuXingUtil.missing(count);
    if (missing.isNotEmpty) {
      parts.add('${missing.join('、')}全无');
    } else {
      final weak = WuXingUtil.weakest(count);
      if (weak.isNotEmpty && weak.length < WuXingUtil.elements.length) {
        parts.add('${weak.join('、')}最少');
      }
    }

    return parts.isEmpty ? '五行分布均匀。' : '${parts.join('，')}。';
  }
}
