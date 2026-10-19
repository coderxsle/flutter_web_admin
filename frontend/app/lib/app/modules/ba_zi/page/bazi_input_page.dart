import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../utils/global.dart';
import '../../zhouyi/algorithm/zhouyi_constants.dart';
import '../../zhouyi/algorithm/solar_time_util.dart';
import '../../zhouyi/widget/pick_date_time.dart';
import '../../zhouyi/widget/t_row_field.dart';
import '../../zhouyi/widget/t_section_title.dart';
import '../controller/bazi_controller.dart';
import '../widget/bazi_history_section.dart';

/// 四柱八字排盘输入页（对应安卓 BaZiFragment）。
///
/// 交互流程：
/// 1. 填姓名（可空）
/// 2. 选生辰（阳历，点击行 → 底部时间滚轮）；没有公历生辰时可改用甲子历直录
/// 3. 选性别（男 / 女，决定大运顺逆）
/// 4. 可选：出生地经度（真太阳时校正）、夜子时
/// 5. 「开始排盘」→ 起四柱后进入结果页
/// 6. 近期排过的话，下方直接列出历史记录，点击可回看
class BaziInputPage extends GetView<BaziInputController> {
  const BaziInputPage({super.key});

  /// 甲子历录入的四行标题，与 controller.pillars 的下标一一对应
  static const List<String> _pillarLabels = ['年柱', '月柱', '日柱', '时柱'];

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
                  prefix: TText("姓名", style: blackStyle()),
                  hintText: "请输入姓名",
                  borderless: true,
                  style: blackStyle(),
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
                  title: TText("出生地经度"),
                  note: TText(_longitudeNote()),
                  arrow: true,
                  onTap: () => _showCityPicker(context),
                ),
                const TDivider(),
                TRowField(
                  label: "夜子时",
                  expand: false,
                  child: TSwitch(
                    value: controller.yeZiShi.value,
                    onChanged: controller.setYeZiShi,
                  ),
                ),
                _cardHint("经度用于真太阳时校正；夜子时开启后，23 时之后日柱归前一日。"),
              ]),
              SizedBox(height: 12.h),
              const TSectionTitle("或：甲子历录入"),
              _card([
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
                  child: Row(
                    children: [
                      for (var i = 0; i < _pillarLabels.length; i++)
                        Expanded(child: _pillarCell(context, i)),
                    ],
                  ),
                ),
                _cardHint(
                  "没有公历生辰（或只知八字）时用这里：四柱填全后「开始排盘」即按甲子历直录。",
                  trailing: controller.pillarsFilled == 0
                      ? null
                      : GestureDetector(
                          onTap: controller.clearPillars,
                          child: Text("清空", style: redThemeStyle(font: 12.sp)),
                        ),
                ),
              ]),
              if (controller.history.isNotEmpty) ...[
                SizedBox(height: 12.h),
                BaziHistorySection(
                  records: controller.history,
                  onOpen: controller.openRecord,
                  onRemove: (record) => controller.removeRecord(record.id),
                ),
              ],
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

  /// 卡片底部的浅色说明，缩进与上面的行对齐；[trailing] 靠右，放次要操作
  Widget _cardHint(String text, {Widget? trailing}) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(text, style: greyStyle(font: 12.sp))),
          if (trailing != null) ...[
            SizedBox(width: 8.w),
            trailing,
          ],
        ],
      ),
    );
  }

  /// 甲子历的某一柱，点开选六十甲子
  Widget _pillarCell(BuildContext context, int index) {
    final value = controller.pillars[index];
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _pickPillar(context, index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(_pillarLabels[index], style: greyStyle(font: 12.sp)),
          SizedBox(height: 6.h),
          Text(
            value.isEmpty ? "未选" : value,
            style: value.isEmpty
                ? greyStyle()
                : blackStyle(),
          ),
        ],
      ),
    );
  }

  /// 从六十甲子里挑一柱；标题栏的「清空」用于抹掉该柱
  void _pickPillar(BuildContext context, int index) {
    // handle 要传给面板内的干支标签做关闭，而 show 的返回值此刻还没拿到
    late TPopupHandle handle;
    handle = TPopup.show(
      context,
      options: TPopupOptions.bottom(
        height: 520.h,
        headerBuilder: (ctx, close) => TPopupHeader(
          title: Text("选择${_pillarLabels[index]}"),
          cancelButton: TButton(
            size: TButtonSize.small,
            variant: TButtonVariant.text,
            onPressed: () {
              controller.setPillar(index, '');
              close();
            },
            child: const Text("清空"),
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 20.h),
          child: Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: [
              for (final ganzhi in ZhouyiConst.liuShiJiaZi)
                _ganzhiChip(() => handle.close(), index, ganzhi),
            ],
          ),
        ),
      ),
    );
  }

  Widget _ganzhiChip(VoidCallback close, int index, String ganzhi) {
    final selected = controller.pillars[index] == ganzhi;
    return GestureDetector(
      onTap: () {
        controller.setPillar(index, ganzhi);
        close();
      },
      child: Container(
        width: 42.w,
        padding: EdgeInsets.symmetric(vertical: 6.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? TdColors.brand : TdColors.pageBg,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          ganzhi,
          style: blackStyle().copyWith(
            color: selected ? TdColors.white : TdColors.textPrimary,
          ),
        ),
      ),
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
            : Text(
                controller.pillarsComplete ? "按甲子历排盘" : "开始排盘",
                style: whiteStyle(font: 16.sp),
              ),
      ),
    );
  }

  Future<void> _pickBirthTime(BuildContext context) async {
    final picked = await pickDateTime(context, initial: controller.birthTime.value);
    if (picked != null) controller.birthTime.value = picked;
  }

  /// 经度行的副标题：未设经度即按北京时间起盘
  String _longitudeNote() {
    final lng = controller.longitude.value;
    if (lng == null) return "未校正，按北京时间";
    return "${lng.toStringAsFixed(1)}° ${SolarTimeUtil.describe(lng)}";
  }

  /// 选出生地经度，或选「不校正」清空
  void _showCityPicker(BuildContext context) {
    // handle 要传给面板内的城市标签做关闭，而 show 的返回值此刻还没拿到
    late TPopupHandle handle;
    handle = TPopup.show(
      context,
      options: TPopupOptions.bottom(
        // 面板不传 height 时固定 240，城市 chip 折 8 行装不下，给足高度并由下方滚动兜底
        height: 600.h,
        headerBuilder: (ctx, close) => TPopupHeader(
          title: const Text("出生地经度"),
          cancelButton: TButton(
            size: TButtonSize.small,
            variant: TButtonVariant.text,
            onPressed: () {
              controller.setLongitude(null);
              close();
            },
            child: const Text("不校正"),
          ),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  for (final entry in SolarTimeUtil.cities.entries)
                    _cityChip(
                      () => handle.close(),
                      entry.key,
                      entry.value,
                    ),
                ],
              ),
              SizedBox(height: 10.h),
              Text(
                "按出生地经度与东经 120° 的差值校正出生时间，偏东调快、偏西调慢。",
                style: greyStyle(font: 12.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _cityChip(VoidCallback close, String city, double lng) {
    final selected = controller.longitude.value == lng;
    return GestureDetector(
      onTap: () {
        controller.setLongitude(lng);
        close();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: selected ? TdColors.brand : TdColors.pageBg,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          "$city ${lng.toStringAsFixed(1)}",
          style: blackStyle().copyWith(
            color: selected ? TdColors.white : TdColors.textPrimary,
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
