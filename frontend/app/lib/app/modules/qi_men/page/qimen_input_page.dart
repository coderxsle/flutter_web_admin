import 'package:auto_shop_server/app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../utils/global.dart';
import '../../zhouyi/algorithm/qimen_calculator.dart';
import '../../zhouyi/widget/t_datetime_picker.dart';
import '../controller/qimen_controller.dart';

/// 奇门遁甲排盘输入页（对应安卓 QiMenMainFragment）。
///
/// 交互流程：
/// 1. 选时间（点击「公历」行或「修改时间」按钮 → 底部时间滚轮）
/// 2. 选局式（拆补 / 置闰）
/// 3. 选盘式附加项（暗干飞支 / 地盘八神）
/// 4. 「开始排盘」→ 起局后进入结果页
class QiMenInputPage extends GetView<QiMenInputController> {
  const QiMenInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: BGColor_white_255),
          onPressed: () => Get.back(),
        ),
        title: const NavigatorTitle("时1家奇门遁甲排盘"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildParamCard(context),
            SizedBox(height: 12.h),
            _buildTimeButtons(context),
            SizedBox(height: 12.h),
            _buildStartButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildParamCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Obx(
        () => Column(
          children: [
            TFormRow(
              label: "公历",
              value: _formatDateTime(controller.selectedTime.value),
              onTap: () => _pickTime(context),
            ),
            const TDivider(),
            _labeled(
              "局式",
              TRadioGroup<String>(
                value: controller.method.value == QimenMethod.chaibu
                    ? "拆补"
                    : "置闰",
                direction: Axis.horizontal,
                columns: 2,
                options: const [
                  TRadioOption(value: "拆补", label: "拆补"),
                  TRadioOption(value: "置闰", label: "置闰"),
                ],
                onChanged: (value) => controller.setMethod(
                  value == "拆补" ? QimenMethod.chaibu : QimenMethod.zhirun,
                ),
              ),
            ),
            const TDivider(),
            _labeled(
              "盘式",
              TCheckboxGroup<String>(
                value: [
                  if (controller.showAnGan.value) "暗干飞支",
                  if (controller.showDiBaShen.value) "地盘八神",
                ],
                direction: Axis.horizontal,
                columns: 2,
                options: const [
                  TCheckboxOption(value: "暗干飞支", label: "暗干飞支"),
                  TCheckboxOption(value: "地盘八神", label: "地盘八神"),
                ],
                onChanged: (values) {
                  controller.setShowAnGan(values.contains("暗干飞支"));
                  controller.setShowDiBaShen(values.contains("地盘八神"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _labeled(String label, Widget child) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 6.h),
      child: Row(
        children: [
          Text(label, style: blackStyle(font: 15)),
          SizedBox(width: 16.w),
          Expanded(child: child),
        ],
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
        colorScheme: TButtonColorScheme.primary,
        onPressed: controller.calculating.value ? null : controller.start,
        style: ButtonStyle(
          minimumSize: WidgetStatePropertyAll(Size(double.infinity, 46.h)),
          backgroundColor: const WidgetStatePropertyAll(ThemeColor),
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
            : Text("开始排盘", style: whiteStyle(font: 16)),
      ),
    );
  }

  static ButtonStyle get _outlineButtonStyle => ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size(double.infinity, 42.h)),
        foregroundColor: const WidgetStatePropertyAll(ThemeColor),
        side: const WidgetStatePropertyAll(BorderSide(color: ThemeColor)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(21)),
        ),
      );

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTDateTimePicker(
      context: context,
      initial: controller.selectedTime.value,
      title: "选择时间",
    );
    if (picked != null) controller.selectedTime.value = picked;
  }

  static String _formatDateTime(DateTime t) {
    String p2(int v) => v.toString().padLeft(2, "0");
    return "${t.year}年${p2(t.month)}月${p2(t.day)}日 "
        "${p2(t.hour)}时${p2(t.minute)}分${p2(t.second)}秒";
  }
}
