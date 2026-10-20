import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../utils/global.dart';
import '../../zhouyi/algorithm/qimen_calculator.dart';
import '../../zhouyi/widget/pick_date_time.dart';
import '../../zhouyi/widget/t_row_field.dart';
import '../../zhouyi/widget/t_section_title.dart';
import '../controller/qimen_controller.dart';
import '../widget/qimen_method_compare_card.dart';
import '../widget/qimen_year_hint.dart';

/// 奇门遁甲排盘输入页（对应安卓 QiMenMainFragment）。
///
/// 交互流程：
/// 1. 选时间（点「时间」行 → 底部时间滚轮；标题右侧「回到现在」一键回此刻）
/// 2. 选局式（拆补 / 置闰）
/// 3. 选盘式附加项（暗干飞支 / 地盘八神）
/// 4. 「开始排盘」→ 起局后进入结果页
class QiMenInputPage extends GetView<QiMenInputController> {
  const QiMenInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TdColors.pageBg,
      appBar: AppBar(
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: TdColors.white),
                onPressed: () => Get.back(),
              )
            : null,
        title: const NavigatorTitle("时家奇门遁甲排盘"),
      ),
      body: SingleChildScrollView(
        // 与排盘结果页保持一致：拖动即收起键盘
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        // 底部留出 Home Indicator，最后一屏的内容不会压到小白条下面
        padding: EdgeInsets.fromLTRB(
          10.w,
          6.h,
          10.w,
          20.h + MediaQuery.paddingOf(context).bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TSectionTitle("起局时间", trailing: _resetToNow()),
            _buildTimeCard(context),
            SizedBox(height: 10.h),
            // 这个按钮组在小屏幕上会被挤成两行，视觉上不如直接点「公历」行来得自然
            // _buildTimeButtons(context),
            // SizedBox(height: 14.h),
            const TSectionTitle("局式与盘式"),
            _buildParamCard(),
            SizedBox(height: 10.h),
            _buildStartButton(),
            SizedBox(height: 12.h),
            _buildCompareCard(),
          ],
        ),
      ),
    );
  }

  /// 按钮下方的两法用局对比卡，年份跟随所选时间
  Widget _buildCompareCard() {
    return Obx(() => QimenMethodCompareCard(time: controller.selectedTime.value));
  }

  /// 白底圆角卡片
  Widget _card(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: children),
    );
  }

  /// 卡片底部的浅色说明，缩进与上面的行对齐
  // Widget _cardHint(String text) {
  //   return Padding(
  //     padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
  //     child: Text(text, style: greyStyle(font: 12.sp)),
  //   );
  // }

  Widget _buildTimeCard(BuildContext context) {
    return Obx(
      () => _card([
        TCell(
          title: TText("时间"),
          note: TText(_formatDateTime(controller.selectedTime.value)),
          arrow: true,
          onTap: () => _pickTime(context),
        ),
        // 这个不需要写提示
        // _cardHint("点此行或下方「修改时间」都可切换起局时刻。"), 
      ]),
    );
  }

  /// 只把起局时间拨回此刻，不动局式与盘式。
  Widget _resetToNow() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: controller.resetToNow,
      child: Padding(
        padding: EdgeInsets.fromLTRB(8.w, 4.h, 0, 4.h),
        child: Text("回到现在", style: redThemeStyle(font: 13.sp)),
      ),
    );
  }

  Widget _buildParamCard() {
    return Obx(
      () => _card([
        _methodRow(),
        // 年度闰奇提示，年份跟随所选时间；两法对比卡共用同一份年缓存
        QimenYearHint(year: controller.selectedTime.value.year),
        const TDivider(),
        _styleRow(),
        // _cardHint("局式决定局数取法，盘式决定九宫格内是否显示暗干飞支与地盘八神。"),
      ]),
    );
  }

  /// 局式：拆补 / 置闰
  ///
  /// 用 [Wrap] 而不是 [Row]：系统字体放大时换行而不是横向溢出。
  /// 不用 TRadioGroup.options：它的 inline 布局内部是 spaceBetween，
  /// 会被撑成两端对齐，这里自己摆，间距才收得住。
  Widget _methodRow() {
    return TRowField(
      label: "局式",
      child: TRadioGroup<QimenMethod>(
        value: controller.method.value,
        onChanged: controller.setMethod,
        child: Wrap(
          spacing: 30.w,
          runSpacing: 4.h,
          children: const [
            TRadio<QimenMethod>(
              value: QimenMethod.zhirun,
              title: "置闰",
              variant: TRadioVariant.inline,
            ),
            TRadio<QimenMethod>(
              value: QimenMethod.chaibu,
              title: "拆补",
              variant: TRadioVariant.inline,
            ),
          ],
        ),
      ),
    );
  }

  /// 盘式附加项：暗干飞支 / 地盘八神
  Widget _styleRow() {
    return TRowField(
      label: "盘式",
      child: TCheckboxGroup<String>(
        value: [
          if (controller.showAnGan.value) "暗干飞支",
          if (controller.showDiBaShen.value) "地盘八神",
        ],
        direction: Axis.horizontal,
        columns: 2,
        showDivider: false,
        options: const [
          TCheckboxOption(value: "暗干飞支", label: "暗干飞支"),
          TCheckboxOption(value: "地盘八神", label: "地盘八神"),
        ],
        onChanged: (values) {
          controller.setShowAnGan(values.contains("暗干飞支"));
          controller.setShowDiBaShen(values.contains("地盘八神"));
        },
      ),
    );
  }

  Widget _buildTimeButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TButton(
            variant: TButtonVariant.outline,
            size: TButtonSize.medium,
            onPressed: controller.resetToNow,
            style: _outlineButtonStyle,
            child: const Text("当前时间"),
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: TButton(
            variant: TButtonVariant.outline,
            size: TButtonSize.medium,
            onPressed: () => _pickTime(context),
            style: _outlineButtonStyle,
            child: const Text("修改时间"),
          ),
        ),
      ],
    );
  }

  Widget _buildStartButton() {
    return Obx(
      () => TButton(
        colorPreset: TButtonColorPreset.primary,
        onPressed: controller.calculating.value ? null : controller.start,
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll(Size(double.infinity, 46.h)),
          backgroundColor: const WidgetStatePropertyAll(TdColors.brand),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
          ),
        ),
        child: controller.calculating.value
            ? SizedBox(
                width: 20.w,
                height: 20.w,
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text("开始排盘", style: whiteStyle(font: 16.sp)),
      ),
    );
  }

  static ButtonStyle get _outlineButtonStyle => ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size(double.infinity, 42.h)),
        foregroundColor: const WidgetStatePropertyAll(TdColors.brand),
        side: const WidgetStatePropertyAll(BorderSide(color: TdColors.brand)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        ),
      );

  Future<void> _pickTime(BuildContext context) async {
    final picked = await pickDateTime(
      context,
      initial: controller.selectedTime.value,
    );
    if (picked != null) controller.selectedTime.value = picked;
  }

  static String _formatDateTime(DateTime t) {
    String p2(int v) => v.toString().padLeft(2, "0");
    return "${t.year}年${p2(t.month)}月${p2(t.day)}日 "
        "${p2(t.hour)}时${p2(t.minute)}分";
  }
}
