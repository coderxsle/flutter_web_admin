import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/global.dart';
import '../../zhouyi/widget/t_labeled_input.dart';
import '../controller/qimen_controller.dart';
import '../widget/qimen_grid_panel.dart';
import '../widget/qimen_info_panel.dart';
import '../widget/qimen_ke_ying_card.dart';
import 'shigan_keying_page.dart';

/// 奇门遁甲排盘结果页（对应安卓 HourQimenActivity）。
///
/// 版面自上而下：头部信息 → 九宫格盘面 → 占事/卦解/反馈 → 十干克应列表。
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
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            QiMenInfoPanel(model: model),
            SizedBox(height: 10.h),
            QiMenGridPanel(
              model: model,
              method: _args.method,
              showAnGan: _args.showAnGan,
              showDiBaShen: _args.showDiBaShen,
            ),
            SizedBox(height: 16.h),
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
              maxLines: 5,
            ),
            SizedBox(height: 12.h),
            TLabeledInput(
              label: "反馈/应验",
              hintText: "事情结束后，补充实际结果与应验情况…",
              controller: _feedback,
              minLines: 2,
              maxLines: 5,
            ),
            SizedBox(height: 16.h),
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
        Row(
          children: [
            Container(
              width: 3.w,
              height: 13.h,
              decoration: BoxDecoration(
                color: TdColors.brand,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(width: 6.w),
            Text("十干克应", style: blackBoldStyle(font: 14)),
          ],
        ),
        SizedBox(height: 8.h),
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
}
