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
                  color: Font_Color_grey_195,
                ),
            ],
          ),
        ),
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
    final rowCount = (values.length + 3) ~/ 4;
    return Column(
      children: [
        for (var row = 0; row < rowCount; row++)
          Row(
            children: [
              for (var col = 0; col < 4; col++)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 1.h),
                    child: Text(
                      _valueAt(row * 4 + col),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: _colorAt(row * 4 + col),
                      ),
                    ),
                  ),
                ),
            ],
          ),
      ],
    );
  }

  String _valueAt(int index) =>
      index < values.length ? values[index] : '';

  Color _colorAt(int index) {
    if (colors == null || index >= colors!.length) return Font_Color_Black_34;
    return colors![index];
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
                    : Font_Color_Black_34,
                fontWeight: bold ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
      ],
    );
  }
}
