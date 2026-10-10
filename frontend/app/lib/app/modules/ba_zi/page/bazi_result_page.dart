import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/global.dart';
import '../../zhouyi/algorithm/zhouyi_constants.dart';
import '../../zhouyi/algorithm/zhouyi_models.dart';
import '../../zhouyi/widget/t_labeled_input.dart';
import '../controller/bazi_controller.dart';
import '../widget/bazi_row_card.dart';

/// 四柱八字排盘结果页（对应安卓 SiZhuBaZiActivity）。
///
/// 栏目自上而下：命主 / 公历 / 农历 / 节气 / 乾造（坤造）/ 纳音 / 藏干 /
/// 12宫 / 起运 / 交运 / 大运，末尾为卦解与反馈输入区。
class BaziResultPage extends StatefulWidget {
  const BaziResultPage({super.key});

  @override
  State<BaziResultPage> createState() => _BaziResultPageState();
}

class _BaziResultPageState extends State<BaziResultPage> {
  late final BaziResultArgs _args;

  final _beiZhu = TextEditingController();
  final _feedback = TextEditingController();

  @override
  void initState() {
    super.initState();
    _args = Get.arguments as BaziResultArgs;
  }

  @override
  void dispose() {
    _beiZhu.dispose();
    _feedback.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final head = _args.head;
    final isMan = _args.sex == BaziSex.man;

    return Scaffold(
      backgroundColor: TdColors.pageBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
          onPressed: () => Get.back(),
        ),
        title: const NavigatorTitle("四柱八字排盘"),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BaziRowCard(
              title: "命主",
              child: BaziTextContent(values: [head.siZhuName]),
            ),
            BaziRowCard(
              title: "公历",
              child: BaziTextContent(values: [head.siZhuYangLi]),
            ),
            BaziRowCard(
              title: "农历",
              child: BaziTextContent(values: [head.nongli]),
            ),
            BaziRowCard(
              title: "节气",
              child: BaziTextContent(
                values: [
                  "${head.jieQi}${head.jieQiTime}",
                  "${head.zhongqi}${head.zhongQiTime}",
                ],
              ),
            ),
            BaziRowCard(
              title: isMan ? "乾造" : "坤造",
              child: BaziGridContent(
                values: _qianZaoValues(head),
                colors: _qianZaoColors(head),
              ),
            ),
            BaziRowCard(
              title: "纳音",
              child: BaziGridContent(
                values: head.siZhuNaYin,
                colors: List<Color>.filled(head.siZhuNaYin.length, kBaziPurple),
              ),
            ),
            BaziRowCard(
              title: "藏干",
              child: BaziGridContent(
                values: [
                  ...head.cangGanArray,
                  ...head.cangGanLiuQinArray,
                ],
                colors: List<Color>.generate(
                  head.cangGanArray.length + head.cangGanLiuQinArray.length,
                  (i) => i < head.cangGanArray.length ? kBaziRed : kBaziBlue,
                ),
              ),
            ),
            BaziRowCard(
              title: "12宫",
              child: BaziTextContent(
                values: _shiErGongRows(head),
                colors: const [kBaziBlue, kBaziBlue, kBaziRed, kBaziRed],
              ),
            ),
            BaziRowCard(
              title: "起运",
              child: BaziTextContent(
                values: ["命主于出生后 ${head.qiYunTime} 起运"],
                colors: const [kBaziBlue],
              ),
            ),
            BaziRowCard(
              title: "交运",
              child: BaziTextContent(
                values: ["命主于公历 ${head.jiaoYunTime} 交运"],
                colors: const [kBaziRed],
              ),
            ),
            BaziRowCard(
              title: "大运",
              child: BaziTextContent(
                values: [_daYunText(head)],
                bold: true,
              ),
            ),
            SizedBox(height: 8.h),
            TLabeledInput(
              label: "卦解/断语",
              hintText: "记录断语、分析思路…",
              controller: _beiZhu,
              minLines: 2,
              maxLines: 6,
            ),
            SizedBox(height: 12.h),
            TLabeledInput(
              label: "反馈/应验",
              hintText: "事情结束后，补充实际结果与应验情况…",
              controller: _feedback,
              minLines: 2,
              maxLines: 6,
            ),
          ],
        ),
      ),
    );
  }

  /// 乾造/坤造 12 项：四柱十神 + 天干 + 地支
  static List<String> _qianZaoValues(ZYHourQimenHeadModel h) {
    final liuQin = h.riGanLiuQinList;
    String liuQinAt(int i) => i < liuQin.length ? liuQin[i] : '';

    final ganzhi = [h.yearGanzhi, h.monthGanzhi, h.dayGanzhi, h.hourGanzhi];
    final top = ganzhi.map((s) => _charAt(s, 0)).toList();
    final bottom = ganzhi.map((s) => _charAt(s, 1)).toList();

    return [
      liuQinAt(0),
      liuQinAt(1),
      "日元",
      liuQinAt(3),
      ...top,
      ...bottom,
    ];
  }

  /// 前 4 项（十神）红、后 8 项（干支）蓝
  static List<Color> _qianZaoColors(ZYHourQimenHeadModel h) => List<Color>.generate(
        12,
        (i) => i < 4 ? kBaziRed : kBaziBlue,
      );

  /// 12 宫拆成 4 行：天干 / 地支 / 宫名首字 / 宫名次字
  static List<String> _shiErGongRows(ZYHourQimenHeadModel h) => List.generate(
        4,
        (row) => h.shiErGongArray.map((s) => _charAt(s, row)).join('  '),
      );

  /// 大运前 8 步，空格连接
  static String _daYunText(ZYHourQimenHeadModel h) {
    final count = h.daYun.length < 8 ? h.daYun.length : 8;
    return h.daYun.take(count).join(' ');
  }

  static String _charAt(String value, int index) =>
      index < value.length ? value[index] : '';
}
