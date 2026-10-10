import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../utils/global.dart';
import '../../zhouyi/algorithm/zhouyi_constants.dart';
import '../../zhouyi/widget/t_datetime_picker.dart';
import '../controller/bazi_controller.dart';

/// 四柱八字排盘输入页（对应安卓 BaZiFragment）。
///
/// 交互流程：
/// 1. 填姓名（可空）
/// 2. 选生辰（阳历，点击行 → 底部时间滚轮）
/// 3. 选性别（男 / 女，决定大运顺逆）
/// 4. 可选：阴历转阳历（输入 8 位阴历日期 → 回填生辰）
/// 5. 「开始排盘」→ 起四柱后进入结果页
class BaziInputPage extends GetView<BaziInputController> {
  const BaziInputPage({super.key});

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
        title: const NavigatorTitle("四柱八字排盘"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildFormCard(context),
            SizedBox(height: 12.h),
            _buildStartButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Obx(
        () => Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: TInput(
                initialValue: controller.name.value,
                onChanged: controller.setName,
                hintText: "尊姓大名",
                borderless: true,
                style: blackStyle(font: 15),
              ),
            ),
            const TDivider(),
            TFormRow(
              label: "生辰（阳历）",
              value: _formatBirth(controller.birthTime.value),
              onTap: () => _pickBirthTime(context),
            ),
            const TDivider(),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 6.h),
              child: Row(
                children: [
                  Text("性别", style: blackStyle(font: 15)),
                  SizedBox(width: 16.w),
                  TRadioGroup<int>(
                    value: controller.sex.value,
                    onChanged: controller.setSex,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TRadio<int>(
                          value: BaziSex.man,
                          title: "男",
                          variant: TRadioVariant.inline,
                        ),
                        SizedBox(width: 30.w),
                        TRadio<int>(
                          value: BaziSex.woman, 
                          title: "女",
                          variant: TRadioVariant.inline,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const TDivider(),
            TFormRow(
              label: "阴历转阳历",
              value: "点击输入阴历日期",
              onTap: () => _showLunarDialog(context),
            ),
          ],
        ),
      ),
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
            : Text("开始排盘", style: whiteStyle(font: 16)),
      ),
    );
  }

  Future<void> _pickBirthTime(BuildContext context) async {
    final picked = await showTDateTimePicker(
      context: context,
      initial: controller.birthTime.value,
      title: "选择生辰",
      withSecond: false,
    );
    if (picked != null) controller.birthTime.value = picked;
  }

  /// 输入阴历日期转阳历（对应安卓 convertCalendarDialog）
  void _showLunarDialog(BuildContext context) {
    final input = TextEditingController();

    void submit(VoidCallback close) {
      final text = input.text.trim();
      if (text.length != 8) {
        showMessage("请输入 8 位阴历日期，如 20240101");
        return;
      }
      final solar = controller.lunarToSolar(text);
      if (solar == null) {
        showMessage("该阴历日期不支持或输入有误");
        return;
      }
      controller.birthTime.value = solar;
      close();
      showMessage("已转换为 ${_formatBirth(solar)}");
    }

    TPopup.show(
      context,
      options: TPopupOptions.bottom(
        headerBuilder: (ctx, close) => TPopupHeader(
          title: const Text("阴历转阳历"),
          cancelButton: TButton(
            size: TButtonSize.small,
            variant: TButtonVariant.text,
            onPressed: close,
            child: const Text("取消"),
          ),
          confirmButton: TButton(
            size: TButtonSize.small,
            variant: TButtonVariant.text,
            onPressed: () => submit(close),
            child: const Text("确定"),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 8.h),
          child: TInput(
            controller: input,
            hintText: "请输入阴历日期，如 20240101",
            inputType: TextInputType.number,
            maxLength: 8,
            style: blackStyle(font: 15),
          ),
        ),
      ),
    );
  }

  static String _formatBirth(DateTime t) {
    String p2(int v) => v.toString().padLeft(2, "0");
    return "${t.year}年${p2(t.month)}月${p2(t.day)}日 "
        "${p2(t.hour)}时${p2(t.minute)}分";
  }
}
