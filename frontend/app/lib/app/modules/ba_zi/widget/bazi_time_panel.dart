import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/global.dart';
import '../../zhouyi/algorithm/cheng_gu_util.dart';
import '../../zhouyi/algorithm/liu_yue_ri_util.dart';
import '../../zhouyi/algorithm/shi_shen_util.dart';
import 'bazi_row_card.dart';


/// 时间推演段：袁天罡称骨 / 流月 / 流日。
///
/// 流月按节气月自正月起排，流日按公历月逐日排；两者共用同一个浏览年月。
class BaziTimePanel extends StatefulWidget {
  const BaziTimePanel({super.key, required this.dayGan, this.chengGu});

  /// 日干，流月与流日的十神以它为基准
  final String dayGan;

  final ChengGuResult? chengGu;

  @override
  State<BaziTimePanel> createState() => _BaziTimePanelState();
}

class _BaziTimePanelState extends State<BaziTimePanel> {
  /// 流月的节气年与流日的公历年
  late int _year;

  /// 流日的公历月
  late int _month;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _year = now.year;
    _month = now.month;
  }

  @override
  Widget build(BuildContext context) {
    final chengGu = widget.chengGu;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (chengGu != null && !chengGu.isEmpty) _chengGuCard(context, chengGu),
        _liuYueCard(context),
        _liuRiCard(context),
      ],
    );
  }

  // ---------------------------------------------------------------- 称骨
  Widget _chengGuCard(BuildContext context, ChengGuResult cg) {
    return BaziRowCard(
      title: '称骨',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cg.label,
            style: blackBoldStyle().copyWith(color: kBaziRed),
          ),
          SizedBox(height: 2.h),
          Text('四项：${cg.detail}', style: greyStyle(font: 12.sp)),
          SizedBox(height: 4.h),
          Text(cg.text, style: blackStyle()),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------- 流月
  Widget _liuYueCard(BuildContext context) {
    final months = LiuYueUtil.ofYearNumber(_year);
    return BaziRowCard(
      title: '流月',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _stepper(
            context,
            '$_year 年',
            () => _shiftYear(-1),
            () => _shiftYear(1),
          ),
          SizedBox(height: 6.h),
          if (months.isEmpty)
            Text('—', style: greyStyle())
          else
            Wrap(
              spacing: 4.w,
              runSpacing: 4.h,
              children: [
                for (var i = 0; i < months.length; i++)
                  _monthCell(context, i, months[i]),
              ],
            ),
        ],
      ),
    );
  }

  Widget _monthCell(BuildContext context, int index, String ganzhi) {
    final shi = ShiShenUtil.of(widget.dayGan, ganzhi);
    return Container(
      width: 60.w,
      padding: EdgeInsets.symmetric(vertical: 4.h),
      decoration: BoxDecoration(
        color: Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(
            ganzhi,
            style: blackBoldStyle().copyWith(color: kBaziRed),
          ),
          Text(LiuYueUtil.monthName[index], style: greyStyle(font: 12.sp)),
          if (shi.isNotEmpty)
            Text(shi, style: blackStyle(font: 12.sp).copyWith(color: kBaziBlue)),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------- 流日
  Widget _liuRiCard(BuildContext context) {
    final days = LiuRiUtil.ofMonth(_year, _month);
    return BaziRowCard(
      title: '流日',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _stepper(
            context,
            '$_year 年 $_month 月',
            () => _shiftMonth(-1),
            () => _shiftMonth(1),
          ),
          SizedBox(height: 6.h),
          if (days.isEmpty)
            Text('—', style: greyStyle())
          else
            Wrap(
              spacing: 2.w,
              runSpacing: 2.h,
              children: [
                for (var i = 0; i < days.length; i++) _dayCell(context, i + 1, days[i]),
              ],
            ),
        ],
      ),
    );
  }

  Widget _dayCell(BuildContext context, int day, String ganzhi) {
    final shi = ShiShenUtil.of(widget.dayGan, ganzhi);
    return SizedBox(
      width: 60.w,
      child: Column(
        children: [
          Text('$day', style: greyStyle(font: 12.sp)),
          Text(ganzhi, style: blackStyle(font: 12.sp).copyWith(color: kBaziRed)),
          Text(shi, style: blackStyle(font: 12.sp).copyWith(color: kBaziBlue)),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------- 切换
  Widget _stepper(
    BuildContext context,
    String label,
    VoidCallback onPrev,
    VoidCallback onNext,
  ) {
    return Row(
      children: [
        _arrow(Icons.chevron_left, onPrev),
        Expanded(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: blackBoldStyle(),
          ),
        ),
        _arrow(Icons.chevron_right, onNext),
      ],
    );
  }

  Widget _arrow(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Icon(icon, size: 18.w, color: TdColors.grey153),
      ),
    );
  }

  void _shiftYear(int delta) => setState(() => _year += delta);

  void _shiftMonth(int delta) {
    setState(() {
      var m = _month + delta;
      var y = _year;
      if (m < 1) {
        m = 12;
        y -= 1;
      } else if (m > 12) {
        m = 1;
        y += 1;
      }
      _month = m;
      _year = y;
    });
  }
}
