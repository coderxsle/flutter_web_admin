import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/global.dart';
import '../../zhouyi/algorithm/bazi_calculator.dart';
import '../../zhouyi/algorithm/solar_time_util.dart';
import '../../zhouyi/algorithm/wang_shuai_util.dart';
import '../../zhouyi/algorithm/wu_xing_util.dart';
import '../../zhouyi/algorithm/yun_shi_util.dart';
import '../../zhouyi/algorithm/zhouyi_constants.dart';
import '../../zhouyi/algorithm/zhouyi_models.dart';
import '../../zhouyi/widget/t_labeled_input.dart';
import '../../zhouyi/widget/t_section_title.dart';
import '../controller/bazi_controller.dart';
import '../page/bazi_he_pan_page.dart';
import '../service/bazi_display_settings.dart';
import '../service/bazi_record_store.dart';
import '../widget/bazi_da_yun_panel.dart';
import '../widget/bazi_relation_section.dart';
import '../widget/bazi_row_card.dart';
import '../widget/bazi_shen_sha_section.dart';
import '../widget/bazi_time_panel.dart';
import '../widget/bazi_wang_shuai_section.dart';
import '../widget/bazi_wu_xing_chart.dart';
import '../widget/bazi_yun_shi_chart.dart';

/// 四柱八字排盘结果页（对应安卓 SiZhuBaZiActivity）。
///
/// 版面自上而下：基本信息 / 四柱 / 神煞 / 宫位与运程 / 卦解与反馈。
class BaziResultPage extends StatefulWidget {
  const BaziResultPage({super.key});

  @override
  State<BaziResultPage> createState() => _BaziResultPageState();
}

class _BaziResultPageState extends State<BaziResultPage> {
  /// 四柱表的列头，四张表共用，列宽一致才能上下对齐
  static const List<String> _pillarHeaders = ['年柱', '月柱', '日柱', '时柱'];

  /// 参数非法时为 null，此时 build 走错误态而不是直接崩
  BaziResultArgs? _args;

  /// 对应的本地记录，用于存回卦解与反馈
  BaziRecord? _record;

  final GlobalKey _captureKey = GlobalKey();

  final _beiZhu = TextEditingController();
  final _feedback = TextEditingController();

  /// 显示设置，进页时从本地读一次
  BaziDisplaySettings _settings = BaziDisplaySettings();

  @override
  void initState() {
    super.initState();
    _settings = BaziDisplaySettings.load();

    final args = Get.arguments;
    if (args is! BaziResultArgs) return;
    _args = args;

    final record = args.recordId == null ? null : BaziRecordStore.find(args.recordId!);
    if (record != null) {
      _record = record;
      _beiZhu.text = record.beiZhu;
      _feedback.text = record.feedback;
    }
  }

  @override
  void dispose() {
    _beiZhu.dispose();
    _feedback.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = _args;
    if (args == null) return _buildInvalid();

    final head = args.head;
    final isMan = args.sex == BaziSex.man;

    return Scaffold(
      backgroundColor: TdColors.pageBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
          onPressed: () => Get.back(),
        ),
        title: const NavigatorTitle("四柱八字排盘"),
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: TdColors.white),
            tooltip: "显示设置",
            onPressed: _showDisplaySettings,
          ),
          IconButton(
            icon: const Icon(Icons.copy_all, color: TdColors.white),
            tooltip: "复制排盘文本",
            onPressed: () => _copyText(head, args),
          ),
          IconButton(
            icon: const Icon(Icons.download, color: TdColors.white),
            tooltip: "保存画面到相册",
            onPressed: _capture,
          ),
        ],
      ),
      body: RepaintBoundary(
          key: _captureKey,
          child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.fromLTRB(10.w, 6.h, 10.w, 22.h + MediaQuery.paddingOf(context).bottom),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TSectionTitle("基本信息"),
              BaziRowCard(
                title: isMan ? "乾造" : "坤造",
                child: BaziTextContent(
                  values: [
                    args.name.isEmpty ? "未命名" : args.name,
                  ],
                ),
              ),
              BaziGroupCard(
                rows: [
                  BaziRowItem(
                    title: "公历",
                    child: BaziTextContent(values: [_birthLabel(args)]),
                  ),
                  if (head.nongli.isNotEmpty)
                    BaziRowItem(
                      title: "农历",
                      child: BaziTextContent(values: [head.nongli]),
                    ),
                  if (head.jieQi.isNotEmpty)
                    BaziRowItem(
                      title: "节气",
                      child: BaziTextContent(
                        values: [
                          "${head.jieQi}${head.jieQiTime}",
                          "${head.zhongqi}${head.zhongQiTime}",
                        ],
                      ),
                    ),
                  if (args.yeZiShi || args.longitude != null)
                    BaziRowItem(
                      title: "取时",
                      child: BaziTextContent(
                        values: [
                          if (args.yeZiShi) "夜子时：23 时后日柱归前一日",
                          if (args.longitude != null)
                            "真太阳时：${args.longitude!.toStringAsFixed(1)}° "
                                "${SolarTimeUtil.describe(args.longitude!)}",
                        ],
                        colors: const [kBaziBlue, kBaziBlue],
                      ),
                    ),
                ],
              ),
              if (_isPillarInput)
                BaziRowCard(
                  title: "提示",
                  child: const BaziTextContent(
                    values: ["本盘由甲子历直录四柱，没有公历生辰。农历、节气、人元司令、称骨与大运起运都依赖真实时刻，故不显示。"],
                    colors: [kBaziRed],
                  ),
                ),
              const TSectionTitle("四柱"),
              BaziRowCard(
                title: isMan ? "乾造" : "坤造",
                child: BaziPillarTable(
                  headers: _pillarHeaders,
                  rows: _qianZaoRows(head, _settings),
                ),
              ),
              if (_onJiaoJieDay)
                BaziRowCard(
                  title: "提示",
                  child: BaziTextContent(
                    values: ["生于${head.jieQi}当天（${head.jieQiTime}），月柱正处于换月临界，请核对出生时刻。"],
                    colors: const [kBaziRed],
                  ),
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
              BaziRowCard(
                title: "空亡",
                child: BaziPillarTable(
                  headers: _pillarHeaders,
                  rows: [
                    BaziTableRow(
                      label: "空亡",
                      values: [head.yearEmpty, head.monthEmpty, head.dayEmpty, head.hourEmpty],
                      colors: List<Color>.filled(4, kBaziPurple),
                    ),
                  ],
                ),
              ),
              if (head.isWuBuYuShi())
                BaziRowCard(
                  title: "时格",
                  child: const BaziTextContent(
                    values: ["时干克日干，为五不遇时"],
                    colors: [kBaziRed],
                  ),
                ),
              if (_settings.relation) ...[
                const TSectionTitle("干支关系"),
                BaziRelationSection(relations: head.ganZhiRelation),
              ],
              if (_settings.wuXing) ...[
                const TSectionTitle("五行"),
                BaziRowCard(
                  title: "五行",
                  child: BaziWuXingChart(
                    count: head.wuXingCount,
                    dayGanWuXing: WuXingUtil.ganOf(_dayGan),
                  ),
                ),
              ],
              if (_settings.wangShuai && head.wangShuai != null) ...[
                const TSectionTitle("旺衰格局"),
                BaziWangShuaiSection(
                  result: head.wangShuai!,
                  geJu: head.geJu,
                  monthZhi: _monthZhi,
                  renYuan: head.renYuan,
                  renYuanDays: head.renYuanDays,
                ),
              ],
              if (_settings.shenSha) ...[
                const TSectionTitle("神煞"),
                BaziShenShaSection(
                  shenSha: head.shenShaArray,
                  summary: head.shenShaSummary,
                ),
              ],
              const TSectionTitle("宫位与运程"),
              BaziGroupCard(
                rows: [
                  if (head.taiYuan.isNotEmpty)
                    BaziRowItem(
                      title: "胎元",
                      child: BaziTextContent(
                        values: [head.taiYuan],
                        colors: const [kBaziPurple],
                      ),
                    ),
                  if (head.mingGong.isNotEmpty)
                    BaziRowItem(
                      title: "命宫",
                      child: BaziTextContent(
                        values: [head.mingGong],
                        colors: const [kBaziPurple],
                      ),
                    ),
                  if (head.shenGong.isNotEmpty)
                    BaziRowItem(
                      title: "身宫",
                      child: BaziTextContent(
                        values: [head.shenGong],
                        colors: const [kBaziPurple],
                      ),
                    ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
                child: Text(
                  "命宫取十四/二十六减法、身宫取月时两支相加，两宫天干以年干五虎遁配出。",
                  style: greyStyle(font: 12),
                ),
              ),
              if (head.shiErGongArray.isNotEmpty)
                BaziRowCard(
                  title: "12宫",
                  child: BaziShiErGongTable(gongs: head.shiErGongArray),
                ),
              if (head.daYun.isNotEmpty) ...[
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
                  child: BaziDaYunPanel(
                    daYun: head.daYun,
                    daYunTime: head.daYunTime,
                    liuNianList: head.liuNianList,
                    birthYear: _birthYear,
                    dayGan: _dayGan,
                  ),
                ),
              ],
              if (_settings.yunShi && head.wangShuai != null) ...[
                const TSectionTitle("运势曲线"),
                BaziRowCard(
                  title: "大运",
                  child: BaziYunShiChart(
                    scores: YunShiUtil.list(head.daYun,
                        dayGan: _dayGan, wangShuai: head.wangShuai!),
                    labels: head.daYun,
                    rowLabels: [
                      for (final t in head.daYunTime)
                        t.length >= 4 ? '${t.substring(0, 4)}起' : '',
                    ],
                  ),
                ),
                if (_recentLiuNian.isNotEmpty)
                  BaziRowCard(
                    title: "流年",
                    child: BaziYunShiChart(
                      scores: [for (final e in _recentLiuNian) e.$2],
                      labels: [for (final e in _recentLiuNian) e.$2.ganzhi],
                      rowLabels: [for (final e in _recentLiuNian) '${e.$1}'],
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
                  child: Text(
                    "分数按用神法折算：运干与运支藏干落在喜用记正、落在忌神记负，50 为分界。"
                    "红为偏吉、橙为欠佳、绿为偏凶。",
                    style: greyStyle(font: 12),
                  ),
                ),
              ],
              if (_settings.timePanel) ...[
                const TSectionTitle("时间推演"),
                BaziTimePanel(dayGan: _dayGan, chengGu: head.chengGu),
              ],
              const TSectionTitle("合盘"),
              BaziRowCard(
                title: "合婚",
                arrow: true,
                onTap: _showPartnerPicker,
                child: Text(
                  "选一名命主与当前盘比较生合冲刑与用神互补",
                  style: greyStyle(font: 13),
                ),
              ),
              BaziRowCard(
                title: "术语",
                arrow: true,
                onTap: () => Get.toNamed(Routes.BAZIGLOSSARYPAGE),
                child: Text(
                  "十神、格局、长生、神煞等名词的释义，可检索",
                  style: greyStyle(font: 13),
                ),
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
              if (_record != null) ...[
                SizedBox(height: 12.h),
                _buildTagEditor(),
              ],
              SizedBox(height: 16.h),
              _buildActions(),
            ],
          ),
          ),
      ),
    );
  }

  /// 显示设置面板：段落开关与四柱行开关
  void _showDisplaySettings() {
    TPopup.show(
      context,
      options: TPopupOptions.bottom(
        height: 600.h,
        headerBuilder: (ctx, close) => TPopupHeader(
          title: const Text('显示设置'),
          confirmButton: TButton(
            size: TButtonSize.small,
            variant: TButtonVariant.text,
            onPressed: close,
            child: const Text('完成'),
          ),
        ),
        child: StatefulBuilder(
          builder: (context, setSheetState) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 4.h, 16.w, 24.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const TDivider(),
                  _settingsGroup('段落'),
                  _settingsSwitch(setSheetState, '神煞', _settings.shenSha,
                      (v) => _settings.shenSha = v),
                      const TDivider(),
                  _settingsSwitch(setSheetState, '五行', _settings.wuXing,
                      (v) => _settings.wuXing = v),
                      const TDivider(),
                  _settingsSwitch(setSheetState, '旺衰格局', _settings.wangShuai,
                      (v) => _settings.wangShuai = v),
                      const TDivider(),
                  _settingsSwitch(setSheetState, '运势曲线', _settings.yunShi,
                      (v) => _settings.yunShi = v),
                      const TDivider(),
                  _settingsSwitch(setSheetState, '干支关系', _settings.relation,
                      (v) => _settings.relation = v),
                      const TDivider(),
                  _settingsSwitch(setSheetState, '时间推演', _settings.timePanel,
                      (v) => _settings.timePanel = v),
                      const TDivider(),
                  _settingsGroup('四柱表'),
                  _settingsSwitch(setSheetState, '十神行', _settings.rowShiShen,
                      (v) => _settings.rowShiShen = v),
                      const TDivider(),
                  _settingsSwitch(setSheetState, '长生行', _settings.rowChangSheng,
                      (v) => _settings.rowChangSheng = v),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _settingsGroup(String title) => Padding(
        padding: EdgeInsets.only(top: 8.h, bottom: 4.h),
        child: Text(title, style: greyBoldStyle(font: 13)),
      );

  Widget _settingsSwitch(
    StateSetter setSheetState,
    String label,
    bool value,
    void Function(bool) onChanged,
  ) {
    return SizedBox(
      height: 44.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: blackStyle(font: 15)),
          TSwitch(
            value: value,
            onChanged: (v) {
              onChanged(v);
              _settings.save();
              setSheetState(() {});
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  /// 命例标签：可加可删，标签会写回本地记录供检索
  Widget _buildTagEditor() {
    final tags = _record?.tags ?? const <String>[];

    return BaziRowCard(
      title: "标签",
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: tags.isEmpty
                ? Text("点右侧 + 添加，便于按标签检索命例",
                    style: greyStyle(font: 13))
                : Wrap(
                    spacing: 6.w,
                    runSpacing: 4.h,
                    children: [
                      for (final tag in tags)
                        GestureDetector(
                          onTap: () => _removeTag(tag),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 6.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: TdColors.brandLight,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '#$tag',
                              style: TextStyle(
                                  fontSize: 12.sp, color: TdColors.brand),
                            ),
                          ),
                        ),
                    ],
                  ),
          ),
          GestureDetector(
            onTap: _addTag,
            child: Padding(
              padding: EdgeInsets.only(left: 6.w),
              child: Icon(Icons.add_circle_outline,
                  size: 18.w, color: TdColors.brand),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addTag() async {
    final controller = TextEditingController();
    final tag = await Get.dialog<String>(
      AlertDialog(
        title: const Text("添加标签"),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 10,
          decoration: const InputDecoration(hintText: "如：工作、婚恋、应验"),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text("取消")),
          TextButton(
            onPressed: () => Get.back(result: controller.text.trim()),
            child: const Text("添加"),
          ),
        ],
      ),
    );

    final record = _record;
    if (tag == null || tag.isEmpty || record == null) return;
    if (record.tags.contains(tag)) {
      showMessage("标签已存在");
      return;
    }
    record.tags = [...record.tags, tag];
    await BaziRecordStore.upsert(record);
    if (!mounted) return;
    setState(() {});
  }

  Future<void> _removeTag(String tag) async {
    final record = _record;
    if (record == null) return;
    record.tags = record.tags.where((t) => t != tag).toList();
    await BaziRecordStore.upsert(record);
    if (!mounted) return;
    setState(() {});
  }

  /// 保存卦解/反馈 + 返回重排
  Widget _buildActions() {
    return Row(
      children: [
        Expanded(
          child: TButton(
            colorPreset: TButtonColorPreset.primary,
            onPressed: _save,
            style: ButtonStyle(
              minimumSize: WidgetStatePropertyAll(Size(double.infinity, 44.h)),
              backgroundColor: const WidgetStatePropertyAll(TdColors.brand),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
              ),
            ),
            child: Text("保存卦解", style: whiteStyle(font: 15)),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: TButton(
            onPressed: () => Get.back(),
            style: ButtonStyle(
              minimumSize: WidgetStatePropertyAll(Size(double.infinity, 44.h)),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
              ),
            ),
            child: Text("重新排盘", style: blackStyle(font: 15)),
          ),
        ),
      ],
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
        title: const NavigatorTitle("四柱八字排盘"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 44.w, color: TdColors.grey153),
              SizedBox(height: 12.h),
              Text("排盘数据丢失，请返回后重新排盘。", style: greyStyle(font: 14)),
            ],
          ),
        ),
      ),
    );
  }

  /// 卦解与反馈写回本地记录
  Future<void> _save() async {
    final record = _record;
    if (record == null) {
      showMessage("本条排盘没有可写的记录");
      return;
    }
    record.beiZhu = _beiZhu.text.trim();
    record.feedback = _feedback.text.trim();
    await BaziRecordStore.upsert(record);
    showMessage("已保存");
  }

  /// 复制结构化文本，便于粘到笔记或对话里
  Future<void> _copyText(ZYHourQimenHeadModel head, BaziResultArgs args) async {
    await Clipboard.setData(ClipboardData(text: _exportText(head, args)));
    showMessage("排盘文本已复制");
  }

  /// 把当前画面存到相册
  Future<void> _capture() async {
    try {
      if (Platform.isAndroid) {
        await Permission.storage.request();
      }
      final boundary =
          _captureKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
      if (boundary == null) return;
      final image = await boundary.toImage(pixelRatio: 2.5);
      final data = await image.toByteData(format: ui.ImageByteFormat.png);
      if (data == null) {
        showMessage("生成图片失败");
        return;
      }
      final result = await ImageGallerySaverPlus.saveImage(
        data.buffer.asUint8List(),
        name: 'bazi_${DateTime.now().millisecondsSinceEpoch}',
      );
      final ok = result == true ||
          (result is Map && result['isSuccess'] == true) ||
          (result is String && result.isNotEmpty);
      showMessage(ok ? "已保存到相册" : "保存失败");
    } catch (e) {
      showMessage("保存失败：$e");
    }
  }

  /// 出生年月日时，与起盘时实际使用的时间一致；甲子历盘没有公历生辰
  String _birthLabel(BaziResultArgs args) {
    final t = args.head.dateTimes;
    if (t.length < 5) return "甲子历直录（无公历生辰）";
    return "${t[0]}年${t[1]}月${t[2]}日 ${t[3]}时${t[4]}分";
  }

  /// 是否为甲子历直录的盘：没有公历时间，节气、称骨与大运都算不出来
  bool get _isPillarInput => (_args?.head.dateTimes.length ?? 0) < 5;

  /// 组合导出文本
  String _exportText(ZYHourQimenHeadModel head, BaziResultArgs args) {
    final b = StringBuffer()
      ..writeln('四柱八字排盘')
      ..writeln('命主：${args.name.isEmpty ? '未命名' : args.name}'
          '（${args.sex == BaziSex.man ? '男' : '女'}）')
      ..writeln('公历：${_birthLabel(args)}');
    if (head.nongli.isNotEmpty) b.writeln('农历：${head.nongli}');
    if (head.jieQi.isNotEmpty) {
      b
        ..writeln('节气：${head.jieQi}${head.jieQiTime}')
        ..writeln('中气：${head.zhongqi}${head.zhongQiTime}');
    }
    if (args.yeZiShi) b.writeln('夜子时：23 时后日柱归前一日');
    if (args.longitude != null) {
      b.writeln('真太阳时：${args.longitude!.toStringAsFixed(1)}° '
          '${SolarTimeUtil.describe(args.longitude!)}');
    }

    void tableRow(String name, List<String> values) {
      b.writeln('$name\t${values.join('\t')}');
    }

    b
      ..writeln()
      ..writeln('【四柱】')
      ..writeln('\t${_pillarHeaders.join('\t')}');
    for (final row in _qianZaoRows(head, _settings)) {
      tableRow(row.label ?? '', row.values);
    }
    tableRow('纳音', head.siZhuNaYin);
    tableRow('藏干', head.cangGanArray);
    tableRow('十神', head.cangGanLiuQinArray);
    tableRow('空亡', [head.yearEmpty, head.monthEmpty, head.dayEmpty, head.hourEmpty]);
    if (head.isWuBuYuShi()) b.writeln('时格：时干克日干，为五不遇时');

    b.writeln();
    b.writeln('【干支关系】');
    if (head.ganZhiRelation.isEmpty) {
      b.writeln('四柱之间无明显合冲刑害');
    } else {
      for (final r in head.ganZhiRelation) {
        b.writeln('${r.kind}　${r.label}');
      }
    }

    b.writeln();
    b.writeln('【五行】${WuXingUtil.elements.map((e) => '$e${head.wuXingCount[e] ?? 0}').join('　')}');

    final ws = head.wangShuai;
    if (ws != null) {
      final benQi = GeJuUtil.benQi[_monthZhi] ?? '';
      b
        ..writeln()
        ..writeln('【旺衰格局】')
        ..writeln('格局：${head.geJu}'
            '${head.geJu.isEmpty ? '' : '（月令$_monthZhi，本气$benQi）'}')
        ..writeln('人元：${head.renYuan} 司令'
            '（交节后 ${head.renYuanDays.toStringAsFixed(1)} 天）')
        ..writeln('同党：比劫 ${ws.party['比劫']} · 印 ${ws.party['印']}'
            '　共 ${ws.sameCount} · ${ws.samePercent}')
        ..writeln('异党：食伤 ${ws.party['食伤']} · 财 ${ws.party['财']} · '
            '官杀 ${ws.party['官杀']}　共 ${ws.otherCount}')
        ..writeln('强弱：${ws.level}　${ws.supportLabel}')
        ..writeln('喜用：${ws.xiYong.isEmpty ? '—' : ws.xiYong.join('、')}')
        ..writeln('忌神：${ws.jiShen.isEmpty ? '—' : ws.jiShen.join('、')}');
    }
    b.writeln();
    b.writeln('【神煞】');
    for (var i = 0; i < _pillarHeaders.length; i++) {
      final names = i < head.shenShaArray.length ? head.shenShaArray[i] : const <String>[];
      b.writeln('${_pillarHeaders[i]}：${names.isEmpty ? '无' : names.join('、')}');
    }

    b
      ..writeln()
      ..writeln('【宫位与运程】')
      ..writeln('胎元：${head.taiYuan}')
      ..writeln('命宫：${head.mingGong}')
      ..writeln('身宫：${head.shenGong}');
    if (head.shiErGongArray.isNotEmpty) {
      b.writeln('12宫：${head.shiErGongArray.join('　')}');
    }
    if (head.daYun.isNotEmpty) {
      b
        ..writeln('起运：命主于出生后 ${head.qiYunTime} 起运')
        ..writeln('交运：命主于公历 ${head.jiaoYunTime} 交运')
        ..writeln('大运：');
      for (var i = 0; i < head.daYun.length; i++) {
        final time = i < head.daYunTime.length ? head.daYunTime[i] : '';
        final year = time.length >= 4 ? time.substring(0, 4) : '';
        b.writeln('  ${head.daYun[i]}${year.isEmpty ? '' : '  $year 年起'}');
      }
    }

    final cg = head.chengGu;
    if (cg != null && !cg.isEmpty) {
      b
        ..writeln()
        ..writeln('【称骨】')
        ..writeln('${cg.label}（${cg.detail}）')
        ..writeln(cg.text);
    }

    final beiZhu = _beiZhu.text.trim();
    final feedback = _feedback.text.trim();
    if (beiZhu.isNotEmpty) {
      b.writeln();
      b.writeln('【卦解/断语】');
      b.writeln(beiZhu);
    }
    if (feedback.isNotEmpty) {
      b.writeln();
      b.writeln('【反馈/应验】');
      b.writeln(feedback);
    }

    return b.toString();
  }

  /// 以今年为中心的十年流年；甲子历盘没有流年表，返回空
  List<(int, YunShiScore)> get _recentLiuNian {
    final head = _args?.head;
    final ws = head?.wangShuai;
    if (head == null || ws == null || head.liuNianList.isEmpty) return const [];
    final birthYear = _birthYear;
    if (birthYear <= 0) return const [];

    final start = DateTime.now().year - 4;
    final out = <(int, YunShiScore)>[];
    for (var y = start; y < start + 10; y++) {
      final idx = y - birthYear;
      if (idx < 0 || idx >= head.liuNianList.length) continue;
      out.add((
        y,
        YunShiUtil.of(head.liuNianList[idx], dayGan: _dayGan, wangShuai: ws),
      ));
    }
    return out;
  }

  // ---------------------------------------------------------------- 合盘
  /// 挑一名合盘对象：只从历史命例里选
  void _showPartnerPicker() {
    final others =
        BaziRecordStore.all().where((r) => r.id != _record?.id).toList();

    late TPopupHandle handle;
    handle = TPopup.show(
      context,
      options: TPopupOptions.bottom(
        height: 560.h,
        headerBuilder: (ctx, close) => TPopupHeader(
          title: const Text("选择合盘对象"),
          confirmButton: TButton(
            size: TButtonSize.small,
            variant: TButtonVariant.text,
            onPressed: close,
            child: const Text("关闭"),
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          children: [
            for (final record in others)
              _pickerRow(
                icon: record.isPillarInput
                    ? Icons.grid_view
                    : Icons.person_outline,
                title: record.name.isEmpty ? "未命名" : record.name,
                subtitle: record.birthLabel,
                onTap: () {
                  handle.close();
                  _openHePanWith(record);
                },
              ),
            if (others.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 14.h),
                child: Text(
                  "还没有别的命例，先新建一个排盘再回来合盘。",
                  textAlign: TextAlign.center,
                  style: greyStyle(font: 13),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _pickerRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    // TPopup 面板没有 Material 祖先，InkWell 得自己套一个
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            children: [
              Icon(icon, size: 20.w, color: TdColors.brand),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: blackStyle(font: 15)),
                    SizedBox(height: 2.h),
                    Text(subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: greyStyle(font: 12)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right,
                  size: 18.w, color: TdColors.grey153),
            ],
          ),
        ),
      ),
    );
  }

  /// 用已有的历史记录当对方
  void _openHePanWith(BaziRecord record) {
    try {
      final four = record.pillars ?? const <String>[];
      final head = record.isPillarInput
          ? BaziCalculator().fromPillars(
              yearGanzhi: four[0],
              monthGanzhi: four[1],
              dayGanzhi: four[2],
              hourGanzhi: four[3],
              mingZhuName: record.name,
            )
          : BaziCalculator().calculate(
              record.toDateTime(),
              sex: record.sex,
              yeZiShi: record.yeZiShi,
              mingZhuName: record.name,
            );
      _goHePan(bHead: head, bName: record.name, bSex: record.sex);
    } catch (e) {
      showMessage("对方排盘失败：$e");
    }
  }

  void _goHePan({
    required ZYHourQimenHeadModel bHead,
    required String bName,
    required int bSex,
  }) {
    final args = _args;
    if (args == null) return;
    Get.toNamed(
      Routes.BAZIHEPANPAGE,
      arguments: BaziHePanArgs(
        aHead: args.head,
        aName: args.name,
        aSex: args.sex,
        bHead: bHead,
        bName: bName,
        bSex: bSex,
      ),
    );
  }

  /// 出生日是否恰逢交节，月柱处于换月临界
  ///
  /// 两个时间串都是「yyyy年MM月dd日…」，取前 11 位比日期即可。
  bool get _onJiaoJieDay {
    final birth = _args?.head.siZhuYangLi ?? '';
    final jieQi = _args?.head.jieQiTime ?? '';
    if (birth.length < 11 || jieQi.length < 11) return false;
    return birth.substring(0, 11) == jieQi.substring(0, 11);
  }

  /// 出生公历年，用于推算各步大运的起运年龄
  int get _birthYear {
    final t = _args?.head.dateTimes ?? const <String>[];
    return t.isEmpty ? 0 : int.tryParse(t[0]) ?? 0;
  }

  /// 日干，大运与流年的十神都以它为基准
  String get _dayGan {
    final day = _args?.head.dayGanzhi ?? '';
    return day.isEmpty ? '' : day.substring(0, 1);
  }

  /// 月支，格局以月令本气取
  String get _monthZhi {
    final m = _args?.head.monthGanzhi ?? '';
    return m.length < 2 ? '' : m.substring(1, 2);
  }

  /// 乾造/坤造若干行：十神 / 天干 / 地支 / 长生，各占一列
  static List<BaziTableRow> _qianZaoRows(
    ZYHourQimenHeadModel h,
    BaziDisplaySettings settings,
  ) {
    final liuQin = h.riGanLiuQinList;
    String liuQinAt(int i) => i < liuQin.length ? liuQin[i] : '';

    final ganzhi = [h.yearGanzhi, h.monthGanzhi, h.dayGanzhi, h.hourGanzhi];

    return [
      if (settings.rowShiShen)
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
      if (settings.rowChangSheng && h.changShengArray.isNotEmpty)
        BaziTableRow(
          label: "长生",
          values: h.changShengArray,
          colors: List<Color>.filled(h.changShengArray.length, kBaziPurple),
        ),
    ];
  }

  static String _charAt(String value, int index) =>
      index < value.length ? value[index] : '';
}
