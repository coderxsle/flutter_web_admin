import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../utils/global.dart';
import '../../zhouyi/algorithm/zhouyi_constants.dart';
import '../../zhouyi/widget/pick_date_time.dart';
import '../../zhouyi/widget/t_row_field.dart';
import '../../zhouyi/widget/t_section_title.dart';
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
        // 姓名输入时键盘会顶起页面，滚动即收起
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(10.w, 6.h, 10.w, 20.h + MediaQuery.paddingOf(context).bottom),
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TSectionTitle("命主信息"),
              _card([
                TInput(
                  initialValue: controller.name.value,
                  onChanged: controller.setName,
                  prefix: TText("姓名", style: blackStyle(font: 15)),
                  hintText: "请输入姓名",
                  borderless: true,
                  style: blackStyle(font: 15),
                ),
                const TDivider(),
                _sexRow(),
                _cardHint("性别决定大运顺逆，请按命主实际性别选择。"),
              ]),
              SizedBox(height: 12.h),
              const TSectionTitle("出生时间（阳历）"),
              _card([
                TCell(
                  title: TText("生辰"),
                  note: TText(_formatBirth(controller.birthTime.value)),
                  arrow: true,
                  onTap: () => _pickBirthTime(context),
                ),
                const TDivider(),
                TCell(
                  title: TText("阴历转阳历"),
                  note: TText("已知阴历生辰？点此换算"),
                  arrow: true,
                  onTap: () => _showLunarDialog(context),
                ),
                _cardHint("请核对公历日期与时辰，时辰不同会直接改变时柱。"),
              ]),
              SizedBox(height: 20.h),
              _buildStartButton(),
            ],
          ),
        ),
      ),
    );
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
  Widget _cardHint(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
      child: Text(text, style: greyStyle(font: 12)),
    );
  }

  Widget _sexRow() {
    return TRowField(
      label: "性别",
      // 不用 TRadioGroup.options：它的 inline 布局内部是 spaceBetween，
      // 会被撑成两端对齐，这里自己摆，间距才收得住
      child: TRadioGroup<int>(
        value: controller.sex.value,
        onChanged: controller.setSex,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const TRadio<int>(
              value: BaziSex.man,
              title: "男",
              variant: TRadioVariant.inline,
            ),
            SizedBox(width: 30.w),
            const TRadio<int>(
              value: BaziSex.woman,
              title: "女",
              variant: TRadioVariant.inline,
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
    final picked = await pickDateTime(context, initial: controller.birthTime.value);
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
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TInput(
                controller: input,
                hintText: "请输入阴历日期，如 20240101",
                inputType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                maxLength: 8,
                autofocus: true,
                style: blackStyle(font: 15),
              ),
              SizedBox(height: 6.h),
              Text(
                "按阴历年、月、日依次输入 8 位数字，换算结果会回填到「生辰」。",
                style: greyStyle(font: 12),
              ),
            ],
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
