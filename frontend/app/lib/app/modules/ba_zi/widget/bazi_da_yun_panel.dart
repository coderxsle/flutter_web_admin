import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/global.dart';
import '../../zhouyi/algorithm/shi_shen_util.dart';
import 'bazi_row_card.dart';

/// 大运面板：12 步干支各带起运年龄与年份，点选某步展开该步对应的 10 个流年。
///
/// 流年与流月同层，但流年按「该步交运那年」起步，所以要用 [daYunTime] 解析年份
/// 去 [liuNianList] 里定位，不能按下标硬套。
class BaziDaYunPanel extends StatefulWidget {
  const BaziDaYunPanel({
    super.key,
    required this.daYun,
    required this.daYunTime,
    required this.liuNianList,
    required this.birthYear,
    required this.dayGan,
  });

  final List<String> daYun;
  final List<String> daYunTime;
  final List<String> liuNianList;

  /// 出生公历年，用来算起运年龄
  final int birthYear;

  /// 日干，用来给大运与流年标十神
  final String dayGan;

  @override
  State<BaziDaYunPanel> createState() => _BaziDaYunPanelState();
}

class _BaziDaYunPanelState extends State<BaziDaYunPanel> {
  /// 当前展开的大运步下标，-1 表示全部收起
  int _selected = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.daYun.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 6.w,
          runSpacing: 6.h,
          children: [
            for (var i = 0; i < widget.daYun.length; i++) _buildStep(context, i),
          ],
        ),
        if (_selected >= 0 && _selected < widget.daYun.length) ...[
          SizedBox(height: 8.h),
          _buildLiuNian(context, _selected),
        ],
      ],
    );
  }

  Widget _buildStep(BuildContext context, int index) {
    final on = index == _selected;
    final note = _stepNote(index);
    final shiShen = _shiShenOf(widget.daYun[index]);
    return GestureDetector(
      onTap: () => setState(() => _selected = on ? -1 : index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: on ? TdColors.brand : TdColors.brandLight,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.daYun[index],
              style: blackBoldStyle()
                  .copyWith(color: on ? TdColors.white : TdColors.brand),
            ),
            if (shiShen.isNotEmpty)
              Text(
                shiShen,
                style: blackStyle(font: 12.sp)
                    .copyWith(color: on ? TdColors.white : kBaziRed),
              ),
            if (note.isNotEmpty)
              Text(
                note,
                style: greyStyle(font: 12.sp)
                    .copyWith(color: on ? TdColors.white : TdColors.grey153),
              ),
          ],
        ),
      ),
    );
  }

  /// 干支相对日干的十神简称；与日干同气时标「元」
  String _shiShenOf(String ganzhi) {
    if (ganzhi.isEmpty) return '';
    if (ganzhi.substring(0, 1) == widget.dayGan) return '元';
    return ShiShenUtil.of(widget.dayGan, ganzhi);
  }

  /// 「8岁 1998」，年份取自该步交运时间
  String _stepNote(int index) {
    final year = _yearOf(
      index < widget.daYunTime.length ? widget.daYunTime[index] : '',
    );
    if (year <= 0) return '';
    return '${year - widget.birthYear}岁 $year';
  }

  Widget _buildLiuNian(BuildContext context, int stepIndex) {
    final startYear = _yearOf(
      stepIndex < widget.daYunTime.length ? widget.daYunTime[stepIndex] : '',
    );
    final items = <Widget>[];
    for (var i = 0; i < 10; i++) {
      final year = startYear + i;
      final idx = year - widget.birthYear;
      if (idx < 0 || idx >= widget.liuNianList.length) break;
      items.add(_buildLiuNianCell(year, widget.liuNianList[idx]));
    }
    if (items.isEmpty) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.daYun[stepIndex]}运 · 流年',
            style: greyStyle(font: 12.sp),
          ),
          SizedBox(height: 4.h),
          Wrap(spacing: 6.w, runSpacing: 4.h, children: items),
        ],
      ),
    );
  }

  Widget _buildLiuNianCell(int year, String ganzhi) {
    final shiShen = _shiShenOf(ganzhi);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            ganzhi,
            style: blackBoldStyle(),
          ),
          Text('$year', style: greyStyle(font: 12.sp)),
          if (shiShen.isNotEmpty)
            Text(shiShen, style: blackStyle(font: 12.sp).copyWith(color: kBaziRed)),
        ],
      ),
    );
  }

  /// 从「1998年05月12日10时」取前 4 位，取不到返回 0
  static int _yearOf(String time) {
    if (time.length < 4) return 0;
    return int.tryParse(time.substring(0, 4)) ?? 0;
  }
}
