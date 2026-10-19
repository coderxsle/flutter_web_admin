import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../utils/global.dart';
import '../../zhouyi/algorithm/shen_sha_tables.dart';
import 'bazi_row_card.dart';

/// 华盖专属强调色（土黄），与吉神蓝、凶神红区分开
const Color kBaziBrown = Color(0xFF6D4C41);
const Color kBaziBrownBg = Color(0xFFFFF3E0);

/// 神煞段：每柱一行列出命中的神煞标签，命中华盖的柱单独标色。
///
/// 标签可点，弹出该神煞释义；底部给出去重后的完整清单。
class BaziShenShaSection extends StatelessWidget {
  const BaziShenShaSection({
    super.key,
    required this.shenSha,
    required this.summary,
    this.headers = const ['年柱', '月柱', '日柱', '时柱'],
  });

  /// 四柱各自命中的神煞，顺序为年/月/日/时
  final List<List<String>> shenSha;

  /// 去重汇总，仅用于底部清单
  final List<String> summary;

  final List<String> headers;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < headers.length; i++) {
      final names = i < shenSha.length ? shenSha[i] : const <String>[];
      if (i > 0) rows.add(_divider());
      rows.add(_pillarRow(context, headers[i], names));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: rows),
        ),
        if (summary.isNotEmpty) ...[
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Text(
              '共 ${summary.length} 项：${summary.join('、')}',
              style: greyStyle(font: 12.sp),
            ),
          ),
        ],
      ],
    );
  }

  Widget _divider() => Divider(
        height: 0.5,
        thickness: 0.5,
        indent: 12,
        endIndent: 12,
        color: Color(0xFFEDEDED),
      );

  Widget _pillarRow(BuildContext context, String pillar, List<String> names) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 34.w,
            child: Text(pillar, style: blackBoldStyle()),
          ),
          Expanded(
            child: names.isEmpty
                ? Text('—', style: greyStyle())
                : Wrap(
                    spacing: 6.w,
                    runSpacing: 4.h,
                    children: [
                      for (final name in names) _tag(context, name),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _tag(BuildContext context, String name) {
    final huaGai = name == '华盖';
    final ji = ShenShaTables.jiShen.contains(name);
    final fg = huaGai ? kBaziBrown : (ji ? kBaziBlue : kBaziRed);
    final bg = huaGai ? kBaziBrownBg : (ji ? TdColors.blueBg : TdColors.redBg);

    return GestureDetector(
      onTap: () => _showMeaning(context, name),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(4),
          border: huaGai ? Border.all(color: kBaziBrown, width: 0.5) : null,
        ),
        child: Text(
          name,
          style: blackStyle(font: 12.sp).copyWith(
            color: fg,
            fontWeight: huaGai ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  void _showMeaning(BuildContext context, String name) {
    TPopup.show(
      context,
      options: TPopupOptions.bottom(
        headerBuilder: (ctx, close) => TPopupHeader(
          title: Text(name),
          confirmButton: TButton(
            size: TButtonSize.small,
            variant: TButtonVariant.text,
            onPressed: close,
            child: const Text('知道了'),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 20.h),
          child: Text(
            ShenShaTables.meaning[name] ?? '暂无释义。',
            style: blackStyle(),
          ),
        ),
      ),
    );
  }
}
