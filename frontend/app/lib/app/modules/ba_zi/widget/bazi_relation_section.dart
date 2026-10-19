import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/global.dart';
import '../../zhouyi/algorithm/gan_zhi_relation.dart';
import 'bazi_row_card.dart';

/// 干支关系段：按天干 / 地支 / 合会三行列出四柱之间的合冲刑害与合会局。
///
/// 合会（含六合、半合、三合、三会）走蓝，冲刑害走红。
class BaziRelationSection extends StatelessWidget {
  const BaziRelationSection({super.key, required this.relations});

  final List<GanZhiRelationItem> relations;

  /// 分组顺序，取值与 [GanZhiRelationItem.kind] 一致
  static const List<String> kinds = ['天干', '地支', '合会'];

  @override
  Widget build(BuildContext context) {
    final rows = <BaziRowItem>[];
    for (final kind in kinds) {
      final items = relations.where((e) => e.kind == kind).toList();
      if (items.isEmpty) continue;
      rows.add(BaziRowItem(
        title: kind,
        child: Wrap(
          spacing: 6.w,
          runSpacing: 4.h,
          children: [for (final item in items) _chip(item)],
        ),
      ));
    }

    if (rows.isEmpty) {
      return BaziRowCard(
        title: "干支",
        child: BaziTextContent(
          values: const ["四柱之间无明显合冲刑害"],
          colors: [TdColors.grey153],
        ),
      );
    }
    return BaziGroupCard(rows: rows, titleWidth: 44);
  }

  Widget _chip(GanZhiRelationItem item) {
    final color = item.auspicious ? kBaziBlue : kBaziRed;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 0.5),
      ),
      child: Text(
        item.label,
        style: blackStyle(font: 12.sp).copyWith(color: color),
      ),
    );
  }
}
