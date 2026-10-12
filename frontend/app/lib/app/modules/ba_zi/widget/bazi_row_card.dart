import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/global.dart';

/// 八字「乾造/坤造」十神与干支配色（安卓 Color.rgb(211, 47, 47)）
const Color kBaziRed = Color(0xFFD32F2F);

/// 八字地支、起运配色（安卓 Color.rgb(25, 118, 210)）
const Color kBaziBlue = Color(0xFF1976D2);

/// 八字纳音配色（安卓 Color.rgb(124, 77, 255)）
const Color kBaziPurple = Color(0xFF7C4DFF);

/// 八字结果页的一行栏目（左侧标题 + 右侧内容）。
class BaziRowCard extends StatelessWidget {
  const BaziRowCard({
    super.key,
    required this.title,
    required this.child,
    this.titleWidth = 76,
    this.arrow = false,
    this.onTap,
  });

  final String title;
  final Widget child;
  final double titleWidth;
  final bool arrow;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: titleWidth.w,
                child: Text(title, style: blackBoldStyle(font: 14)),
              ),
              Expanded(child: child),
              if (arrow)
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 12,
                  color: TdColors.grey195,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 四柱表里的一行：可带左侧行标签，取值与列一一对应。
class BaziTableRow {
  const BaziTableRow({this.label, required this.values, this.colors});

  /// 左侧行标签，如「十神」；为 null 时不显示
  final String? label;

  final List<String> values;

  /// 与 [values] 一一对应的颜色；缺省项用正文黑
  final List<Color>? colors;

  Color colorAt(int index) =>
      (colors != null && index < colors!.length) ? colors![index] : TdColors.textPrimary;
}

/// 四柱表：等分列 + 可选列头 + 可选行标签。
///
/// 列宽等分，所以某一列文字再长也不会把其它列挤歪；同一张表里各行的列位置恒定对齐。
class BaziPillarTable extends StatelessWidget {
  const BaziPillarTable({
    super.key,
    required this.rows,
    this.headers,
    this.labelWidth = 30,
  });

  final List<BaziTableRow> rows;

  /// 列头，如 ['年柱','月柱','日柱','时柱']；为 null 则不出表头行
  final List<String>? headers;

  /// 左侧行标签列宽；传 0 则不出标签列
  final double labelWidth;

  @override
  Widget build(BuildContext context) {
    final headers = this.headers;
    final columns = headers?.length ?? (rows.isEmpty ? 0 : rows.first.values.length);

    return Column(
      children: [
        if (headers != null) _buildRow(headers, null, columns, isHeader: true),
        for (var i = 0; i < rows.length; i++)
          _buildRow(
            rows[i].values,
            rows[i],
            columns,
            isHeader: false,
            isLast: i == rows.length - 1,
          ),
      ],
    );
  }

  Widget _buildRow(
    List<String> values,
    BaziTableRow? data,
    int columns, {
    required bool isHeader,
    bool isLast = false,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: isHeader ? 3.h : 4.h),
      decoration: BoxDecoration(
        border: isLast
            ? null
            : const Border(bottom: BorderSide(color: Color(0xFFEDEDED), width: 0.5)),
      ),
      child: Row(
        children: [
          if (labelWidth > 0)
            SizedBox(
              width: labelWidth.w,
              child: Text(
                isHeader ? '' : (data?.label ?? ''),
                style: greyStyle(font: 11),
              ),
            ),
          for (var i = 0; i < columns; i++)
            Expanded(
              child: Text(
                i < values.length ? values[i] : '',
                textAlign: TextAlign.center,
                style: isHeader
                    ? greyStyle(font: 12)
                    : TextStyle(fontSize: 14.sp, color: data?.colorAt(i) ?? TdColors.textPrimary),
              ),
            ),
        ],
      ),
    );
  }
}

/// 四列网格内容（对应安卓 SiZhuBaZiGridContentAdapter）。
class BaziGridContent extends StatelessWidget {
  const BaziGridContent({super.key, required this.values, this.colors});

  final List<String> values;

  /// 与 [values] 一一对应的颜色；缺省项用默认黑
  final List<Color>? colors;

  @override
  Widget build(BuildContext context) {
    return BaziPillarTable(
      rows: [BaziTableRow(values: values, colors: colors)],
      labelWidth: 0,
    );
  }
}

/// 纵向多行文本内容（对应安卓 SiZhuBaZiContentAdapter）。
class BaziTextContent extends StatelessWidget {
  const BaziTextContent({
    super.key,
    required this.values,
    this.colors,
    this.bold = false,
  });

  final List<String> values;
  final List<Color>? colors;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < values.length; i++)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            child: Text(
              values[i],
              style: TextStyle(
                fontSize: 14.sp,
                color: (colors != null && i < colors!.length)
                    ? colors![i]
                    : TdColors.textPrimary,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
      ],
    );
  }
}

/// 十二宫：每宫一列，自上而下为 天干 / 地支 / 宫名两字。
///
/// 整表套一层 FittedBox 等比缩放，窄屏不会溢出，且四行的列位置始终对齐。
class BaziShiErGongTable extends StatelessWidget {
  const BaziShiErGongTable({super.key, required this.gongs, this.cellWidth = 16});

  /// 每项 4 个字符：天干 + 地支 + 宫名两字
  final List<String> gongs;

  final double cellWidth;

  static const List<String> _rowLabels = ['天干', '地支', '宫名', ''];

  @override
  Widget build(BuildContext context) {
    if (gongs.isEmpty) return const SizedBox.shrink();
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var row = 0; row < 4; row++) _buildRow(row),
        ],
      ),
    );
  }

  Widget _buildRow(int row) {
    // 前两行（天干 / 地支）蓝、后两行（宫名）红
    final color = row < 2 ? kBaziBlue : kBaziRed;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          SizedBox(
            width: 28.w,
            child: Text(_rowLabels[row], style: greyStyle(font: 11)),
          ),
          for (final gong in gongs)
            SizedBox(
              width: cellWidth.w,
              child: Text(
                row < gong.length ? gong[row] : '',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14.sp, color: color),
              ),
            ),
        ],
      ),
    );
  }
}

/// 大运八步：每个干支一个小标签，自动换行，不再用空格拼成一长串。
class BaziDaYunWrap extends StatelessWidget {
  const BaziDaYunWrap({super.key, required this.daYun});

  final List<String> daYun;

  @override
  Widget build(BuildContext context) {
    if (daYun.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 6.w,
      runSpacing: 6.h,
      children: [
        for (final step in daYun)
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: TdColors.brandLight,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              step,
              style: TextStyle(fontSize: 14.sp, color: TdColors.brand, fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }
}
