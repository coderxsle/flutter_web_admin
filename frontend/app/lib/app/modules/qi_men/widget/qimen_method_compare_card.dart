import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../utils/global.dart';
import '../../zhouyi/algorithm/qimen_method_compare.dart';
import '../../zhouyi/algorithm/zy_datetime_model.dart';

/// 局数不同的强调色（TDesign warning）
const Color _kDiffColor = Color(0xFFE37318);

/// 阴阳遁不同的强调色（TDesign error）
const Color _kDunDiffColor = Color(0xFFD54941);

/// 未选中页签底色
const Color _kChipGrey = Color(0xFFF3F3F3);

/// 输入页底部的两法用局对比卡：对照 / 概览 / 明细 三视图，可左右滑动切换。
class QimenMethodCompareCard extends StatefulWidget {
  const QimenMethodCompareCard({super.key, required this.time});

  /// 当前所选时间，其年份决定统计范围
  final DateTime time;

  @override
  State<QimenMethodCompareCard> createState() => _QimenMethodCompareCardState();
}

class _QimenMethodCompareCardState extends State<QimenMethodCompareCard> {
  static const List<String> _titles = ['对照', '概览', '明细', '表格'];
  static const List<String> _monthNames = [
    '一', '二', '三', '四', '五', '六', '七', '八', '九', '十', '十一', '十二',
  ];

  final PageController _page = PageController();
  int _index = 0;
  QimenYearCompare? _compare;

  @override
  void initState() {
    super.initState();
    _loadYear(widget.time.year);
  }

  @override
  void didUpdateWidget(QimenMethodCompareCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.time.year != widget.time.year) _loadYear(widget.time.year);
  }

  @override
  void dispose() {
    _page.dispose();
    super.dispose();
  }

  /// 全年扫描约百毫秒，放到首帧之后再算，结果按年缓存
  void _loadYear(int year) {
    if (_compare?.year == year) return;
    setState(() => _compare = null);
    Future<void>.delayed(Duration.zero, () {
      if (!mounted) return;
      final result = QimenMethodCompare.ofYear(year);
      if (!mounted) return;
      if (widget.time.year != result.year) {
        _loadYear(widget.time.year);
        return;
      }
      setState(() => _compare = result);
    });
  }

  void _goto(int index) => _page.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildHeader(),
          const TDivider(),
          SizedBox(
            height: 256.h,
            child: PageView(
              controller: _page,
              onPageChanged: (i) => setState(() => _index = i),
              children: [
                _buildCompare(),
                _buildOverview(),
                _buildDetail(),
                _buildTable(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 页签用 Expanded 平分剩余宽度，标题栏与页签同一行也不会溢出
  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 4.h),
      child: Row(
        children: [
          Text('两法用局对比', style: blackStyle(font: 14.sp)),
          SizedBox(width: 6.w),
          Text('${widget.time.year}', style: greyStyle(font: 12.sp)),
          SizedBox(width: 8.w),
          for (var i = 0; i < _titles.length; i++) _buildTab(i),
        ],
      ),
    );
  }

  Widget _buildTab(int index) {
    final active = _index == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _goto(index),
        child: Container(
          margin: EdgeInsets.only(left: 4.w),
          padding: EdgeInsets.symmetric(vertical: 4.h),
          decoration: BoxDecoration(
            color: active ? TdColors.brand : _kChipGrey,
            borderRadius: BorderRadius.circular(6.w),
          ),
          child: Center(
            child: Text(
              _titles[index],
              style: active ? whiteStyle(font: 12.sp) : greyStyle(font: 12.sp),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 视图一：所选时刻两法对照
  // ---------------------------------------------------------------------------

  Widget _buildCompare() {
    final snapshot = QimenMethodCompare.at(
      ZYDatetimeModel.fromDateTime(widget.time),
    );
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 12.h, 8.w, 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildJuRow('拆补法', snapshot.chaibuJu),
          SizedBox(height: 10.h),
          _buildJuRow('置闰法', snapshot.zhirunJu),
          const Spacer(),
          _buildVerdict(snapshot),
        ],
      ),
    );
  }

  Widget _buildJuRow(String label, String ju) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 52.w,
          padding: EdgeInsets.symmetric(vertical: 2.h),
          decoration: BoxDecoration(
            color: _kChipGrey,
            borderRadius: BorderRadius.circular(4.w),
          ),
          child: Center(child: Text(label, style: greyStyle(font: 12.sp))),
        ),
        SizedBox(width: 10.w),
        Expanded(child: Text(ju, style: blackBoldStyle(font: 14.sp))),
      ],
    );
  }

  Widget _buildVerdict(QimenMethodSnapshot snapshot) {
    final String text;
    final Color color;
    if (snapshot.same) {
      text = '两法一致，此刻起局相同';
      color = TdColors.grey153;
    } else if (snapshot.dunDiffers) {
      text = '阴阳遁亦不同，盘面差异最大';
      color = _kDunDiffColor;
    } else {
      text = '两法所行之局不同，盘面不一致';
      color = _kDiffColor;
    }
    return Row(
      children: [
        Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 6.w),
        Text(text, style: blackStyle(font: 12.sp).copyWith(color: color)),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 视图二：全年概览
  // ---------------------------------------------------------------------------

  Widget _buildOverview() {
    final compare = _compare;
    if (compare == null) return _buildLoading();
    final counts = _monthCounts(compare);
    final maxCount = counts.reduce((a, b) => a > b ? a : b);
    return Padding(
      padding: EdgeInsets.fromLTRB(8.w, 12.h, 8.w, 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildMetric('${compare.dayDiff}', '天用局不同'),
              _buildMetric('${compare.shichenDiff}', '个时辰'),
              _buildMetric('${compare.segments.length}', '段差异'),
            ],
          ),
          SizedBox(height: 14.h),
          Text('各月差异时辰', style: greyStyle(font: 12.sp)),
          SizedBox(height: 6.h),
          Expanded(child: _buildMonthBars(counts, maxCount)),
        ],
      ),
    );
  }

  Widget _buildMetric(String value, String label) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(value, style: blackBoldStyle(font: 20.sp)),
          SizedBox(height: 2.h),
          Text(label, style: greyStyle(font: 12.sp)),
        ],
      ),
    );
  }

  /// 把每段差异时辰按公历月归集
  List<int> _monthCounts(QimenYearCompare compare) {
    final counts = List<int>.filled(13, 0);
    for (final segment in compare.segments) {
      var day = segment.startDay;
      var shichen = segment.startShichen;
      for (var i = 0; i < segment.shichenCount; i++) {
        counts[day.month]++;
        if (shichen == QimenMethodCompare.shichenHours.length - 1) {
          day = day.add(const Duration(days: 1));
          shichen = 0;
        } else {
          shichen++;
        }
      }
    }
    return counts;
  }

  Widget _buildMonthBars(List<int> counts, int maxCount) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var m = 1; m <= 12; m++)
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  counts[m] == 0 ? '' : '${counts[m]}',
                  style: greyStyle(font: 12.sp),
                  maxLines: 1,
                ),
                SizedBox(height: 2.h),
                Container(
                  height: counts[m] == 0
                      ? 1.h
                      : (66.h * counts[m] / maxCount).clamp(2.h, 66.h),
                  margin: EdgeInsets.symmetric(horizontal: 2.w),
                  decoration: BoxDecoration(
                    color: counts[m] == 0 ? _kChipGrey : TdColors.brand,
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                ),
                SizedBox(height: 3.h),
                Text(_monthNames[m - 1], style: greyStyle(font: 12.sp)),
              ],
            ),
          ),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // 视图三：差异段明细
  // ---------------------------------------------------------------------------

  Widget _buildDetail() {
    final compare = _compare;
    if (compare == null) return _buildLoading();
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 12.h),
      itemCount: compare.segments.length,
      separatorBuilder: (_, __) => Divider(height: 1.h, color: _kChipGrey),
      itemBuilder: (_, i) => _buildSegmentRow(compare.segments[i], i + 1),
    );
  }

  Widget _buildSegmentRow(QimenMethodDiffSegment segment, int index) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 22.w,
            child: Text('$index', style: greyStyle(font: 12.sp)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(_rangeText(segment), style: blackBoldStyle(font: 13.sp)),
                    SizedBox(width: 8.w),
                    Text('${segment.shichenCount} 时辰', style: greyStyle(font: 12.sp)),
                    if (segment.dunDiffers) ...[
                      SizedBox(width: 6.w),
                      Text(
                        '跨遁',
                        style: blackStyle(font: 12.sp)
                            .copyWith(color: _kDunDiffColor),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 3.h),
                Text('拆补 ${segment.chaibuJu}', style: greyStyle(font: 12.sp)),
                Text('置闰 ${segment.zhirunJu}', style: greyStyle(font: 12.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _rangeText(QimenMethodDiffSegment segment) {
    String md(DateTime d) =>
        '${d.month.toString().padLeft(2, '0')}月${d.day.toString().padLeft(2, '0')}日';
    String sc(int i) => '${QimenMethodCompare.shichenNames[i]}时';
    return '${md(segment.startDay)}${sc(segment.startShichen)}'
        ' ~ ${md(segment.endDay)}${sc(segment.endShichen)}';
  }

  // ---------------------------------------------------------------------------
  // 视图四：差异段表格
  // ---------------------------------------------------------------------------

  /// 表格各列宽度配比：区间 / 时辰 / 拆补 / 置闰
  static const int _colRange = 30;
  static const int _colCount = 13;
  static const int _colJu = 40;

  Widget _buildTable() {
    final compare = _compare;
    if (compare == null) return _buildLoading();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(8.w, 5.h, 8.w, 3.h),
          child: Row(
            children: [
              _tableCell('区间', _colRange, greyBoldStyle(font: 12.sp), center: true),
              _tableCell('时辰', _colCount, greyBoldStyle(font: 12.sp), center: true),
              _tableCell('拆补', _colJu, greyBoldStyle(font: 12.sp), center: true),
              _tableCell('置闰', _colJu, greyBoldStyle(font: 12.sp), center: true),
            ],
          ),
        ),
        const Divider(height: 1, color: _kChipGrey),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            itemCount: compare.segments.length,
            separatorBuilder: (_, __) =>
                Divider(height: 1.h, color: _kChipGrey),
            itemBuilder: (_, i) => _buildTableRow(compare.segments[i]),
          ),
        ),
      ],
    );
  }

  Widget _buildTableRow(QimenMethodDiffSegment segment) {
    final chaibu =
        QimenMethodCompare.juCompact(segment.chaibuJu, segment.chaibuJuEnd);
    final zhirun =
        QimenMethodCompare.juCompact(segment.zhirunJu, segment.zhirunJuEnd);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _tableCell(_tableRange(segment), _colRange,
              blackBoldStyle(font: 12.sp),
              maxLines: 2),
          _tableCell('${segment.shichenCount}', _colCount, greyStyle(font: 12.sp),
              center: true),
          _tableCell(chaibu, _colJu, greyStyle(font: 12.sp), maxLines: 2),
          _tableCell(
            segment.dunDiffers ? '$zhirun ★跨遁' : zhirun,
            _colJu,
            segment.dunDiffers
                ? blackStyle(font: 12.sp).copyWith(color: _kDunDiffColor)
                : greyStyle(font: 12.sp),
            maxLines: 2,
          ),
        ],
      ),
    );
  }

  Widget _tableCell(
    String text,
    int flex,
    TextStyle style, {
    bool center = false,
    int maxLines = 1,
  }) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: style,
        textAlign: center ? TextAlign.center : TextAlign.left,
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  /// 同日只写一个日期，跨日写成「6-19 ~ 6-21」；不补前导零，省列宽
  String _tableRange(QimenMethodDiffSegment segment) {
    String md(DateTime d) => '${d.month}-${d.day}';
    final start = md(segment.startDay);
    if (segment.startDay == segment.endDay) {
      return '$start ${QimenMethodCompare.shichenNames[segment.startShichen]}时';
    }
    return '$start ~ ${md(segment.endDay)}';
  }

  Widget _buildLoading() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 14.w,
            height: 14.w,
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
          SizedBox(width: 8.w),
          Text('全年比对计算中…', style: greyStyle(font: 12.sp)),
        ],
      ),
    );
  }
}
