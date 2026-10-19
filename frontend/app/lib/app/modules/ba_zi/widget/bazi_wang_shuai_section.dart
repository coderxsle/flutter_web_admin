import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/global.dart';
import '../../zhouyi/algorithm/wang_shuai_util.dart';
import 'bazi_row_card.dart';
import 'bazi_wu_xing_chart.dart';

/// 旺衰与格局段：格局 / 人元司令 / 同党异党 / 日主强弱 / 喜用忌神。
///
/// 喜忌取扶抑法：同党过半作偏强论，喜克泄耗；不足则喜生扶。
class BaziWangShuaiSection extends StatelessWidget {
  const BaziWangShuaiSection({
    super.key,
    required this.result,
    this.geJu = '',
    this.monthZhi = '',
    this.renYuan = '',
    this.renYuanDays,
  });

  final WangShuaiResult result;

  /// 格局名，如「七杀格」
  final String geJu;

  /// 月支，用于格局的取法说明
  final String monthZhi;

  /// 人元司令天干
  final String renYuan;

  /// 交节后的天数，用于人元司令说明
  final double? renYuanDays;

  @override
  Widget build(BuildContext context) {
    return BaziGroupCard(
      titleWidth: 44,
      rows: [
        BaziRowItem(title: '格局', child: _text(_geJuText())),
        BaziRowItem(title: '人元', child: _text(_renYuanText())),
        BaziRowItem(title: '同党', child: _text(_partyText(true))),
        BaziRowItem(title: '异党', child: _text(_partyText(false))),
        BaziRowItem(
          title: '强弱',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${result.level}　${result.supportLabel}',
                style: blackStyle(),
              ),
              SizedBox(height: 4.h),
              _partyBar(),
            ],
          ),
        ),
        BaziRowItem(title: '喜用', child: _chips(result.xiYong)),
        BaziRowItem(title: '忌神', child: _chips(result.jiShen)),
      ],
    );
  }

  Widget _text(String value) =>
      Text(value, style: blackStyle());

  String _geJuText() {
    if (geJu.isEmpty) return '—';
    final benQi = GeJuUtil.benQi[monthZhi];
    if (benQi == null) return geJu;
    return '$geJu（月令$monthZhi，本气$benQi）';
  }

  String _renYuanText() {
    if (renYuan.isEmpty) return '—';
    final days = renYuanDays;
    if (days == null || days < 0) return '$renYuan 司令';
    return '$renYuan 司令（交节后 ${days.toStringAsFixed(1)} 天）';
  }

  /// 同党或异党的分组明细
  String _partyText(bool same) {
    final keys = same ? const ['比劫', '印'] : const ['食伤', '财', '官杀'];
    final detail = keys.map((k) => '$k ${result.party[k] ?? 0}').join(' · ');
    final count = same ? result.sameCount : result.otherCount;
    final percent = same
        ? result.samePercent
        : '${(100 - result.sameRatio * 100).toStringAsFixed(1)}%';
    return '$detail　共 $count · $percent';
  }

  /// 同党（蓝）与异党（红）的占比条
  Widget _partyBar() {
    final same = result.sameCount;
    final other = result.otherCount;
    if (same + other == 0) return const SizedBox.shrink();
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: SizedBox(
        height: 8.h,
        child: Row(
          children: [
            if (same > 0)
              Expanded(flex: same, child: Container(color: kBaziBlue)),
            if (other > 0)
              Expanded(flex: other, child: Container(color: kBaziRed)),
          ],
        ),
      ),
    );
  }

  /// 五行标签，沿用五行统计的颜色
  Widget _chips(List<String> elements) {
    if (elements.isEmpty) {
      return Text('—', style: greyStyle());
    }
    return Wrap(
      spacing: 6.w,
      runSpacing: 4.h,
      children: [
        for (final e in elements)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: _color(e).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: _color(e).withValues(alpha: 0.35), width: 0.5),
            ),
            child: Text(
              e,
              style: blackBoldStyle(font: 12.sp).copyWith(color: _color(e)),
            ),
          ),
      ],
    );
  }

  Color _color(String element) =>
      BaziWuXingChart.colors[element] ?? TdColors.grey153;
}
