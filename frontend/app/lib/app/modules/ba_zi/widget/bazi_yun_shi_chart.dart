import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/global.dart';
import '../../zhouyi/algorithm/yun_shi_util.dart';
import 'bazi_row_card.dart';

/// 运势折线图：横轴为各步运，纵轴为 0~100 的运势分，50 为基准线。
///
/// 分值由 [YunShiUtil] 按用神法算出。点位颜色分三档 ——
/// 偏吉（≥65）红、欠佳（35~64）橙、偏凶（<35）绿，与涨跌配色无关，
/// 只表示「这步运对本命是扶还是抑」。
class BaziYunShiChart extends StatelessWidget {
  const BaziYunShiChart({
    super.key,
    required this.scores,
    this.labels = const [],
    this.rowLabels = const [],
    this.plotHeight = 150,
  });

  final List<YunShiScore> scores;

  /// 每个点下方的第一行小字，通常是干支
  final List<String> labels;

  /// 每个点下方的第二行小字，通常是年份
  final List<String> rowLabels;

  final double plotHeight;

  /// 每个点的横向占位
  static const double step = 46;

  @override
  Widget build(BuildContext context) {
    if (scores.isEmpty) return Text('—', style: greyStyle(font: 14.sp));

    return LayoutBuilder(
      builder: (context, constraints) {
        final n = scores.length;
        // 点多了就横向滚动，点位不压缩，否则一年一个字看不清
        final width = math.max(constraints.maxWidth, n * step.w);
        final colWidth = width / n;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: width,
                height: plotHeight.h,
                child: CustomPaint(
                  painter: _YunShiPainter(scores: scores),
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  for (var i = 0; i < n; i++)
                    SizedBox(
                      width: colWidth,
                      child: _labelAt(i),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _labelAt(int i) {
    final main = i < labels.length ? labels[i] : '';
    final sub = i < rowLabels.length ? rowLabels[i] : '';
    return Column(
      children: [
        if (main.isNotEmpty)
          Text(
            main,
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: blackBoldStyle(font: 12.sp).copyWith(color: kBaziRed),
          ),
        if (sub.isNotEmpty)
          Text(
            sub,
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: greyStyle(font: 12.sp),
          ),
      ],
    );
  }
}

class _YunShiPainter extends CustomPainter {
  _YunShiPainter({required this.scores});

  final List<YunShiScore> scores;

  /// 上下留白，给分数标签腾位置
  static const double _padV = 12;

  /// 纵轴刻度
  static const List<int> _ticks = [0, 25, 50, 75, 100];

  /// 分档配色：偏吉红、欠佳橙、偏凶绿
  static Color colorOf(int score) {
    if (score >= 65) return kBaziRed;
    if (score >= 35) return kBaziOrange;
    return kBaziGreen;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final n = scores.length;
    if (n == 0) return;

    final colWidth = size.width / n;
    final plotHeight = size.height - _padV * 2;

    double xAt(int i) => colWidth * (i + 0.5);
    double yAt(int score) =>
        _padV + (1 - score / 100) * plotHeight;

    final grid = Paint()
      ..color = const Color(0xFFEDEDED)
      ..strokeWidth = 0.5;
    for (final tick in _ticks) {
      canvas.drawLine(
        Offset(0, yAt(tick)),
        Offset(size.width, yAt(tick)),
        grid,
      );
    }

    // 基准线：50 分，加粗一档
    final baseline = Paint()
      ..color = TdColors.grey153.withValues(alpha: 0.55)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(0, yAt(YunShiUtil.base)),
      Offset(size.width, yAt(YunShiUtil.base)),
      baseline,
    );

    if (n > 1) {
      final path = Path()..moveTo(xAt(0), yAt(scores[0].score));
      for (var i = 1; i < n; i++) {
        path.lineTo(xAt(i), yAt(scores[i].score));
      }
      canvas.drawPath(
        path,
        Paint()
          ..color = kBaziBlue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5
          ..strokeJoin = StrokeJoin.round,
      );
    }

    for (var i = 0; i < n; i++) {
      final score = scores[i].score;
      final center = Offset(xAt(i), yAt(score));
      final color = colorOf(score);
      canvas.drawCircle(center, 3.5, Paint()..color = color);

      _text(
        canvas,
        '$score',
        center + Offset(0, -14.h),
        blackStyle(font: 12.sp).copyWith(color: color),
      );
    }
  }

  void _text(Canvas canvas, String value, Offset center, TextStyle style) {
    final painter = TextPainter(
      text: TextSpan(text: value, style: style),
      textDirection: TextDirection.ltr,
    )..layout();
    painter.paint(
      canvas,
      Offset(center.dx - painter.width / 2, center.dy - painter.height / 2),
    );
  }

  @override
  bool shouldRepaint(_YunShiPainter oldDelegate) =>
      !identical(oldDelegate.scores, scores);
}
