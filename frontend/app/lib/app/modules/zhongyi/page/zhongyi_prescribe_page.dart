import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/global.dart';
import '../controller/zhongyi_prescribe_controller.dart';
import '../service/zhongyi_domain.dart';
import '../widget/zhongyi_sheet.dart';
import '../widget/zhongyi_ui.dart';

/// 开方结算：选患者 → 添加药品 / 套用模板 → 填单剂用量 → 结算生成账单。
class ZhongyiPrescribePage extends StatefulWidget {
  const ZhongyiPrescribePage({super.key});

  @override
  State<ZhongyiPrescribePage> createState() => _ZhongyiPrescribePageState();
}

class _ZhongyiPrescribePageState extends State<ZhongyiPrescribePage> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _doses = TextEditingController(text: '${ZhongyiPrescribeController.defaultDoses}');

  ZhongyiPrescribeController get controller => Get.find<ZhongyiPrescribeController>();

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _doses.dispose();
    super.dispose();
  }

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
        title: const NavigatorTitle("开方结算"),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 20.h + MediaQuery.paddingOf(context).bottom),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _patientCard(context),
            _pickers(context),
            _lineCard(),
            _notesCard(),
            // 计价卡片已隐藏：合计金额统一到结算记录详情页展示。
            // _summaryCard(),
            SizedBox(height: 8.h),
            Obx(
              () => ZhongyiPrimaryButton(
                text: '结算',
                loading: controller.submitting.value,
                onPressed: () => _submit(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 患者与剂数：输入框统一走 [ZhongyiFormInput]，高度只给下限，不会被文字缩放撑破。
  Widget _patientCard(BuildContext context) {
    return ZhongyiCard(
      children: [
        ZhongyiFormRow(
          label: '患者',
          child: Row(
            children: [
              Expanded(
                child: ZhongyiFormInput(controller: _name, hint: '输入患者姓名', onChanged: controller.setName),
              ),
              SizedBox(width: 8.w),
              SizedBox(
                width: 70.w,
                child: ZhongyiPrimaryButton(text: '选择', height: 40, onPressed: () => _pickPatient(context)),
              ),
            ],
          ),
        ),
        ZhongyiFormRow(
          label: '电话',
          child: ZhongyiFormInput(controller: _phone, hint: '输入联系电话', onChanged: controller.setPhone),
        ),
        ZhongyiFormRow(
          label: '剂数',
          child: ZhongyiFormInput(
            controller: _doses,
            hint: '剂数',
            number: true,
            decimals: 0,
            suffix: '剂',
            onChanged: (value) => controller.setDoses(int.tryParse(value.trim()) ?? 0),
          ),
        ),
      ],
    );
  }

  Widget _pickers(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          Expanded(
            child: ZhongyiPrimaryButton(
              text: '套用模板',
              height: 42,
              variant: TButtonVariant.outline,
              onPressed: () => _pickTemplate(context),
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: ZhongyiPrimaryButton(text: '添加药品', height: 42, onPressed: () => _pickMedicines(context)),
          ),
        ],
      ),
    );
  }

  Widget _lineCard() {
    return Obx(() {
      if (controller.lines.isEmpty) {
        return const ZhongyiCard(children: [ZhongyiEmpty(text: '请选择药品或套用模板')]);
      }
      final summary = controller.summary;
      return ZhongyiCard(
        children: [
          for (var index = 0; index < controller.lines.length; index++)
            _PrescribeLineRow(
              key: ValueKey(controller.lines[index].medicineId),
              line: controller.lines[index],
              index: index,
              shortage: summary.items[index].stockShortage,
              onDelete: () => controller.removeLine(index),
              onDosageChanged: (value) => controller.updateDosage(index, value),
            ),
        ],
      );
    });
  }

  Widget _notesCard() {
    return ZhongyiCard(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: TTextarea(
            hintText: '备注（选填）',
            minLines: 2,
            maxLines: 4,
            onChanged: controller.setNotes,
          ),
        ),
      ],
    );
  }

  // 计价区域已下线，合计金额统一到结算记录详情页展示，保留代码备查。
  // Widget _summaryCard() {
  //   return Obx(() {
  //     final summary = controller.summary;
  //     final empty = controller.lines.isEmpty;
  //     return ZhongyiCard(
  //       padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
  //       divided: false,
  //       children: [
  //         Row(
  //           children: [
  //             Expanded(
  //               child: Text('${controller.lines.length} 味药 · ${controller.doses.value} 剂', style: greyStyle()),
  //             ),
  //             Flexible(
  //               child: Text(
  //                 '合计 ¥${zhongyiAmountText(summary.totalSaleAmount)}',
  //                 style: redThemeBoldStyle(font: 17.sp),
  //                 textAlign: TextAlign.right,
  //                 maxLines: 1,
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 6.h),
  //         Row(
  //           children: [
  //             Expanded(child: Text('成本 ¥${zhongyiAmountText(summary.totalCost)}', style: greyStyle())),
  //             // 字号放大 + 窄屏时毛利串比整行还宽，必须有截断兜底。
  //             Flexible(
  //               child: Text(
  //                 empty
  //                     ? '毛利 -'
  //                     : '毛利 ¥${zhongyiAmountText(summary.grossProfit)}（${zhongyiNumberText(summary.grossMargin)}%）',
  //                 style: greyStyle(),
  //                 textAlign: TextAlign.right,
  //                 maxLines: 1,
  //                 overflow: TextOverflow.ellipsis,
  //               ),
  //             ),
  //           ],
  //         ),
  //         if (!empty && summary.hasShortage) ...[
  //           SizedBox(height: 6.h),
  //           Text('有药味库存不足，无法结算', style: redThemeStyle()),
  //         ],
  //       ],
  //     );
  //   });
  // }

  Future<void> _pickPatient(BuildContext context) async {
    final patient = await pickZhongyiPatient(context, selectedId: controller.selectedPatientId.value);
    if (patient == null) return;
    controller.selectPatient(patient);
    _name.text = controller.patientName;
    _phone.text = controller.patientPhone;
  }

  Future<void> _pickMedicines(BuildContext context) async {
    final medicines =
        await pickZhongyiMedicines(context, selectedIds: controller.lines.map((line) => line.medicineId).toList());
    if (medicines.isNotEmpty) controller.addMedicines(medicines);
  }

  Future<void> _pickTemplate(BuildContext context) async {
    final template = await pickZhongyiTemplate(context, selectedId: controller.selectedTemplate.value?.id ?? 0);
    if (template == null) return;
    await controller.applyTemplate(template);
    if (!mounted) return;
    // 模板自带剂数，输入框要跟着变。
    _doses.text = '${controller.doses.value}';
  }

  Future<void> _submit(BuildContext context) async {
    final billId = await controller.submit();
    if (billId == null) return;
    Get.offNamed(Routes.ZHONGYIBILLINGDETAILPAGE, arguments: billId);
  }
}

/// 一味药的编辑行：药名 + 余量 / 进价，右侧单剂用量与删除。
class _PrescribeLineRow extends StatefulWidget {
  const _PrescribeLineRow({
    super.key,
    required this.line,
    required this.index,
    required this.shortage,
    required this.onDelete,
    required this.onDosageChanged,
  });

  final ZhongyiPrescriptionLine line;
  final int index;
  final double shortage;
  final VoidCallback onDelete;
  final ValueChanged<double> onDosageChanged;

  @override
  State<_PrescribeLineRow> createState() => _PrescribeLineRowState();
}

class _PrescribeLineRowState extends State<_PrescribeLineRow> {
  late final TextEditingController _dosage = TextEditingController(text: _initialText());

  String _initialText() {
    final grams = widget.line.dosageGrams;
    return grams > 0 ? zhongyiNumberText(grams) : '';
  }

  @override
  void dispose() {
    _dosage.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final line = widget.line;
    final stock = zhongyiStockDisplay(line.stockQuantity, line.unit);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(line.name, style: blackBoldStyle(), maxLines: 1, overflow: TextOverflow.ellipsis),
                SizedBox(height: 4.h),
                Text(
                  '余${stock.value}${stock.unit} · 进 ¥${zhongyiNumberText(line.purchasePrice)}/${line.unit}'
                  '${widget.shortage > 0 ? ' · 缺 ${zhongyiNumberText(widget.shortage)}${line.unit}' : ''}',
                  style: widget.shortage > 0 ? redThemeStyle(font: 12.sp) : greyStyle(font: 12.sp),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Text('单剂', style: greyStyle()),
          SizedBox(width: 6.w),
          SizedBox(
            width: 58.w,
            child: ZhongyiFormInput(
              controller: _dosage,
              hint: '0',
              dense: true,
              number: true,
              onChanged: (value) => widget.onDosageChanged(double.tryParse(value.trim()) ?? 0),
            ),
          ),
          SizedBox(width: 4.w),
          Text('g', style: greyStyle()),
          SizedBox(width: 4.w),
          IconButton(
            onPressed: widget.onDelete,
            icon: Icon(Icons.delete_outline, size: 20.w, color: TdColors.brand),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints.tightFor(width: 32.w, height: 32.h),
            tooltip: '删除',
          ),
        ],
      ),
    );
  }
}
