import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/global.dart';
import '../../zhouyi/algorithm/qimen_method_compare.dart';

/// 「局式」下方的一句话年度提示：该年置闰法有无闰奇、差异都打哪儿来。
///
/// 定高显示，加载中与算完的高度一致，年份切换时不跳动。
class QimenYearHint extends StatefulWidget {
  const QimenYearHint({super.key, required this.year});

  final int year;

  @override
  State<QimenYearHint> createState() => _QimenYearHintState();
}

class _QimenYearHintState extends State<QimenYearHint> {
  static const Color _kHintBg = Color.fromARGB(121, 215, 215, 215);

  QimenYearCompare? _compare;

  @override
  void initState() {
    super.initState();
    _load(widget.year);
  }

  @override
  void didUpdateWidget(QimenYearHint oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.year != widget.year) _load(widget.year);
  }

  /// 全年扫描约百毫秒，放到首帧之后再算，结果与对比卡共用同一份年缓存
  void _load(int year) {
    if (_compare?.year == year) return;
    setState(() => _compare = null);
    Future<void>.delayed(Duration.zero, () {
      if (!mounted) return;
      final result = QimenMethodCompare.ofYear(year);
      if (!mounted) return;
      if (widget.year != result.year) {
        _load(widget.year);
        return;
      }
      setState(() => _compare = result);
    });
  }

  @override
  Widget build(BuildContext context) {
    final compare = _compare;
    return Container(
      height: 22.h,
      margin: EdgeInsets.fromLTRB(8.w, 0, 8.w, 4.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      decoration: BoxDecoration(
        color: _kHintBg,
        borderRadius: BorderRadius.circular(6.w),
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        compare == null ? '年度闰奇情况计算中…' : _hint(compare),
        style: greyStyle(font: 12.sp),
      ),
    );
  }

  /// 差异时辰要么出于闰奇，要么出于超神接气，两种年景分开说
  String _hint(QimenYearCompare compare) {
    if (compare.leapCount == 0) {
      return '${compare.year} 年无闰奇，${compare.shichenDiff} 个差异时辰全部来自超神接气';
    }
    return '${compare.year} 年 ${compare.leapCount} 次闰奇（${compare.leapText}），'
        '${compare.leapShichenDiff} 个差异时辰落在闰奇期';
  }
}
