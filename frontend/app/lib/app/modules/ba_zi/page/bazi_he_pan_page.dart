import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../utils/global.dart';
import '../../zhouyi/algorithm/he_pan_util.dart';
import '../../zhouyi/algorithm/wang_shuai_util.dart';
import '../../zhouyi/algorithm/wu_xing_util.dart';
import '../../zhouyi/algorithm/zhouyi_models.dart';
import '../../zhouyi/widget/t_section_title.dart';
import '../widget/bazi_row_card.dart';

/// 合盘页入参：两副已排好的盘 + 各自的称呼与性别。
class BaziHePanArgs {
  const BaziHePanArgs({
    required this.aHead,
    required this.aName,
    required this.aSex,
    required this.bHead,
    required this.bName,
    required this.bSex,
  });

  final ZYHourQimenHeadModel aHead;
  final String aName;
  final int aSex;

  final ZYHourQimenHeadModel bHead;
  final String bName;
  final int bSex;
}

/// 合盘结果页：两造对照 + 六项判词 + 总评分。
class BaziHePanPage extends StatefulWidget {
  const BaziHePanPage({super.key});

  @override
  State<BaziHePanPage> createState() => _BaziHePanPageState();
}

class _BaziHePanPageState extends State<BaziHePanPage> {
  BaziHePanArgs? _args;
  HePanResult? _result;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is! BaziHePanArgs) return;
    _args = args;
    _result = _compare(args);
  }

  @override
  Widget build(BuildContext context) {
    final args = _args;
    final result = _result;
    if (args == null || result == null) return _buildInvalid();

    return Scaffold(
      backgroundColor: TdColors.pageBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
          onPressed: () => Get.back(),
        ),
        title: const NavigatorTitle("合盘"),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(
              10.w, 8.h, 10.w, 22.h + MediaQuery.paddingOf(context).bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _scoreCard(result),
              const TSectionTitle("两造"),
              BaziGroupCard(
                titleWidth: 56,
                rows: [
                  BaziRowItem(
                    title: _short(args.aName),
                    child: BaziTextContent(
                      values: [
                        '${_sexLabel(args.aSex)}　${_siZhu(args.aHead)}',
                        '日主 ${_dayGan(args.aHead)}'
                            '（${WuXingUtil.ganOf(_dayGan(args.aHead))}）'
                            '　喜用 ${_elements(args.aHead.wangShuai)}',
                      ],
                      colors: const [kBaziBlue, kBaziBlue],
                    ),
                  ),
                  BaziRowItem(
                    title: _short(args.bName),
                    child: BaziTextContent(
                      values: [
                        '${_sexLabel(args.bSex)}　${_siZhu(args.bHead)}',
                        '日主 ${_dayGan(args.bHead)}'
                            '（${WuXingUtil.ganOf(_dayGan(args.bHead))}）'
                            '　喜用 ${_elements(args.bHead.wangShuai)}',
                      ],
                      colors: const [kBaziRed, kBaziRed],
                    ),
                  ),
                ],
              ),
              const TSectionTitle("逐项判词"),
              BaziGroupCard(
                titleWidth: 110,
                rows: [
                  for (final item in result.items)
                    BaziRowItem(
                      title: item.title,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.detail,
                            style: blackStyle(),
                          ),
                          Text(
                            '${item.point > 0 ? '+' : ''}${item.point} 分',
                            style: blackStyle(font: 12.sp).copyWith(
                              color: item.point > 0
                                  ? kBaziRed
                                  : (item.point < 0
                                      ? kBaziGreen
                                      : TdColors.grey153),
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w),
                child: Text(
                  '合盘只看两造之间的生合冲刑与用神互补，年支主相处、月支主共事、'
                  '日支主居家，日干为两造的性情底色。分数是这几项的加减合计，'
                  '供参考比对，不是婚配结论。',
                  style: greyStyle(font: 12.sp),
                ),
              ),
            ],
          ),
        ),
    );
  }

  /// 总分卡：大号分数 + 档位 + 一句话总评
  Widget _scoreCard(HePanResult result) {
    final color = _scoreColor(result.score);
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                '${result.score}',
                style: blackBoldStyle(font: 34.sp).copyWith(color: color),
              ),
              Text('合盘分', style: greyStyle(font: 12.sp)),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        result.level,
                        style: blackBoldStyle().copyWith(color: color),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(result.summary, style: blackStyle()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInvalid() {
    return Scaffold(
      backgroundColor: TdColors.pageBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
          onPressed: () => Get.back(),
        ),
        title: const NavigatorTitle("合盘"),
      ),
      body: Center(
        child: Text("合盘参数丢失，请返回后重新选择。", style: greyStyle()),
      ),
    );
  }

  /// 两造的旺衰缺一不可，缺了就退化成可算的部分
  static HePanResult _compare(BaziHePanArgs args) {
    final aWang = args.aHead.wangShuai ??
        WangShuaiUtil.judge(_dayGan(args.aHead), _pillars(args.aHead));
    final bWang = args.bHead.wangShuai ??
        WangShuaiUtil.judge(_dayGan(args.bHead), _pillars(args.bHead));

    return HePanUtil.compare(
      aPillars: _pillars(args.aHead),
      aWang: aWang,
      bPillars: _pillars(args.bHead),
      bWang: bWang,
      aName: _short(args.aName),
      bName: _short(args.bName),
      aNayin: args.aHead.siZhuNaYin.isEmpty ? '' : args.aHead.siZhuNaYin[0],
      bNayin: args.bHead.siZhuNaYin.isEmpty ? '' : args.bHead.siZhuNaYin[0],
    );
  }

  static List<String> _pillars(ZYHourQimenHeadModel h) =>
      [h.yearGanzhi, h.monthGanzhi, h.dayGanzhi, h.hourGanzhi];

  static String _siZhu(ZYHourQimenHeadModel h) => _pillars(h).join(' ');

  static String _dayGan(ZYHourQimenHeadModel h) =>
      h.dayGanzhi.isEmpty ? '' : h.dayGanzhi.substring(0, 1);

  static String _sexLabel(int sex) => sex == 1 ? '乾造' : '坤造';

  static String _short(String name) => name.isEmpty ? '未命名' : name;

  static String _elements(WangShuaiResult? ws) =>
      ws == null || ws.xiYong.isEmpty ? '—' : ws.xiYong.join('、');

  static Color _scoreColor(int score) {
    if (score >= 72) return kBaziRed;
    if (score >= 58) return kBaziOrange;
    return kBaziGreen;
  }
}
