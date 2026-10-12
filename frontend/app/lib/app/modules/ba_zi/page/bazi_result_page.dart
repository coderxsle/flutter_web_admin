import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/global.dart';
import '../../zhouyi/algorithm/zhouyi_constants.dart';
import '../../zhouyi/algorithm/zhouyi_models.dart';
import '../../zhouyi/widget/t_labeled_input.dart';
import '../../zhouyi/widget/t_section_title.dart';
import '../controller/bazi_controller.dart';
import '../widget/bazi_row_card.dart';

/// 四柱八字排盘结果页（对应安卓 SiZhuBaZiActivity）。
///
/// 三段：基本信息 / 四柱 / 宫位与运程，末尾为卦解与反馈输入区。
class BaziResultPage extends StatefulWidget {
  const BaziResultPage({super.key});

  @override
  State<BaziResultPage> createState() => _BaziResultPageState();
}

class _BaziResultPageState extends State<BaziResultPage> {
  /// 四柱表的列头，四张表共用，列宽一致才能上下对齐
  static const List<String> _pillarHeaders = ['年柱', '月柱', '日柱', '时柱'];

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
        padding: EdgeInsets.fromLTRB(10.w, 6.h, 10.w, 20.h + MediaQuery.paddingOf(context).bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TSectionTitle("基本信息"),
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
            const TSectionTitle("四柱"),
            BaziRowCard(
              title: isMan ? "乾造" : "坤造",
              child: BaziPillarTable(headers: _pillarHeaders, rows: _qianZaoRows(head)),
            ),
            BaziRowCard(
              title: "纳音",
              child: BaziPillarTable(
                headers: _pillarHeaders,
                rows: [
                  BaziTableRow(
                    values: head.siZhuNaYin,
                    colors: List<Color>.filled(head.siZhuNaYin.length, kBaziPurple),
                  ),
                ],
              ),
            ),
            BaziRowCard(
              title: "藏干",
              child: BaziPillarTable(
                headers: _pillarHeaders,
                rows: [
                  BaziTableRow(
                    label: "藏干",
                    values: head.cangGanArray,
                    colors: List<Color>.filled(head.cangGanArray.length, kBaziRed),
                  ),
                  BaziTableRow(
                    label: "十神",
                    values: head.cangGanLiuQinArray,
                    colors: List<Color>.filled(head.cangGanLiuQinArray.length, kBaziBlue),
                  ),
                ],
              ),
            ),
            const TSectionTitle("宫位与运程"),
            BaziRowCard(
              title: "12宫",
              child: BaziShiErGongTable(gongs: head.shiErGongArray),
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
              child: BaziDaYunWrap(daYun: _daYunSteps(head)),
            ),
            SizedBox(height: 12.h),
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

  /// 乾造/坤造三行：十神 / 天干 / 地支，各占一列
  static List<BaziTableRow> _qianZaoRows(ZYHourQimenHeadModel h) {
    final liuQin = h.riGanLiuQinList;
    String liuQinAt(int i) => i < liuQin.length ? liuQin[i] : '';

    final ganzhi = [h.yearGanzhi, h.monthGanzhi, h.dayGanzhi, h.hourGanzhi];

    return [
      BaziTableRow(
        label: "十神",
        values: [liuQinAt(0), liuQinAt(1), "日元", liuQinAt(3)],
        colors: List<Color>.filled(4, kBaziRed),
      ),
      BaziTableRow(
        label: "天干",
        values: ganzhi.map((s) => _charAt(s, 0)).toList(),
        colors: List<Color>.filled(4, kBaziBlue),
      ),
      BaziTableRow(
        label: "地支",
        values: ganzhi.map((s) => _charAt(s, 1)).toList(),
        colors: List<Color>.filled(4, kBaziBlue),
      ),
    ];
  }

  /// 大运前 8 步
  static List<String> _daYunSteps(ZYHourQimenHeadModel h) {
    final count = h.daYun.length < 8 ? h.daYun.length : 8;
    return h.daYun.take(count).toList();
  }

  static String _charAt(String value, int index) =>
      index < value.length ? value[index] : '';
}
