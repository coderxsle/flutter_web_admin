import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/global.dart';
import '../../zhouyi/widget/t_labeled_input.dart';
import '../../zhouyi/widget/t_section_title.dart';
import '../controller/qimen_controller.dart';
import '../service/qimen_record_sync.dart';
import '../widget/qimen_grid_panel.dart';
import '../widget/qimen_info_panel.dart';
import '../widget/qimen_ke_ying_card.dart';
import 'shigan_keying_page.dart';

/// 奇门遁甲排盘结果页（对应安卓 HourQimenActivity）。
///
/// 版面自上而下：起局信息 → 九宫格盘面 → 占事/卦解/反馈 → 十干克应列表。
class QiMenResultPage extends StatefulWidget {
  const QiMenResultPage({super.key});

  @override
  State<QiMenResultPage> createState() => _QiMenResultPageState();
}

class _QiMenResultPageState extends State<QiMenResultPage> {
  late final QiMenResultArgs _args;

  final _zhanShi = TextEditingController();
  final _beiZhu = TextEditingController();
  final _feedback = TextEditingController();

  @override
  void initState() {
    super.initState();
    _args = Get.arguments as QiMenResultArgs;
    // 历史回看时把上次的占事/卦解/反馈填回去，保存才不会把它们覆盖成空
    _zhanShi.text = _args.question;
    _beiZhu.text = _args.interpretation;
    _feedback.text = _args.feedback;
  }

  @override
  void dispose() {
    _zhanShi.dispose();
    _beiZhu.dispose();
    _feedback.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = _args.model;
    return Scaffold(
      backgroundColor: TdColors.pageBg,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
          onPressed: () => Get.back(),
        ),
        title: const NavigatorTitle("时家奇门遁甲排盘"),
        actions: [
          TextButton(
            onPressed: _save,
            child: Text("保存", style: whiteStyle()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        // 底部留出 Home Indicator，十干克应最后一张卡不会被压到小白条下面
        padding: EdgeInsets.fromLTRB(
          10.w,
          6.h,
          10.w,
          20.h + MediaQuery.paddingOf(context).bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const TSectionTitle("起局信息"),
            // 头部六行是黑/蓝/红混合小字，落在白底上才拉得开层次
            Container(
              padding: EdgeInsets.fromLTRB(12.w, 10.h, 12.w, 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: QiMenInfoPanel(model: model),
            ),
            SizedBox(height: 12.h),
            QiMenGridPanel(
              model: model,
              method: _args.method,
              showAnGan: _args.showAnGan,
              showDiBaShen: _args.showDiBaShen,
            ),
            SizedBox(height: 14.h),
            TLabeledInput(
              label: "占事",
              hintText: "所测何事…",
              controller: _zhanShi,
              minLines: 1,
              maxLines: 3,
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
            SizedBox(height: 6.h),
            _buildKeYingSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildKeYingSection() {
    final model = _args.model;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TSectionTitle("十干克应"),
        for (var i = 0; i < 9; i++)
          // 中 5 宫不展示（安卓 HourQimenTextAdapter 同款处理）
          if (i != 4)
            QiMenKeYingCard(
              position: i,
              description1: _at(model.shiGanKeYing1, i),
              description2: _at(model.shiGanKeYing2, i),
              onTap: () => Get.toNamed(
                Routes.SHIGANKEYINGPAGE,
                arguments: ShiGanKeyingArgs(
                  title: "第${i + 1}宫",
                  description1: _at(model.shiGanKeYing1, i),
                  description2: _at(model.shiGanKeYing2, i),
                ),
              ),
            ),
      ],
    );
  }

  static String _at(List<String> list, int index) =>
      index >= 0 && index < list.length ? list[index] : "";

  /// 占事/卦解/反馈写回同一条记录
  Future<void> _save() async {
    final ok = await QimenRecordSync.saveNotes(
      clientKey: _args.clientKey,
      chartTime: _args.chartTime,
      method: _args.method,
      showAnGan: _args.showAnGan,
      showDiBaShen: _args.showDiBaShen,
      model: _args.model,
      question: _zhanShi.text,
      interpretation: _beiZhu.text,
      feedback: _feedback.text,
    );
    showMessage(ok ? "已保存" : "保存失败，请检查网络后重试");
  }
}
