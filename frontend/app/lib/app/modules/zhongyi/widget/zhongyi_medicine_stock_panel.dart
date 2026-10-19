import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../utils/global.dart';
import '../model/zhongyi_model.dart';
import '../service/zhongyi_domain.dart';
import 'zhongyi_ui.dart';

/// 库存段：余量总览 + 批次清单 + 入库 + 调整。
///
/// 校验、loading、表单清理都在段内完成，网络请求交给调用方；
/// 回调整理好后返回是否成功，段内据此决定要不要清空表单。
class ZhongyiMedicineStockPanel extends StatefulWidget {
  const ZhongyiMedicineStockPanel({
    super.key,
    required this.medicineId,
    required this.batches,
    required this.onStockIn,
    required this.onAdjust,
  });

  final int medicineId;
  final List<ZhongyiInventoryBatch> batches;
  final Future<bool> Function(Map<String, dynamic> body) onStockIn;
  final Future<bool> Function(int inventoryId, double quantityChange, String remark) onAdjust;

  @override
  State<ZhongyiMedicineStockPanel> createState() => ZhongyiMedicineStockPanelState();
}

class ZhongyiMedicineStockPanelState extends State<ZhongyiMedicineStockPanel> {
  final _quantity = TextEditingController();
  final _purchasePrice = TextEditingController();
  final _batchNumber = TextEditingController();
  final _storageLocation = TextEditingController();
  final _stockRemark = TextEditingController();

  final _adjustQuantity = TextEditingController();
  final _adjustRemark = TextEditingController(text: zhongyiAdjustReasons.first);

  DateTime? _productionDate;
  DateTime? _expiryDate;
  String _qualityStatus = 'qualified';
  int _selectedBatchId = 0;
  bool _stocking = false;
  bool _adjusting = false;

  @override
  void initState() {
    super.initState();
    _batchNumber.text = _newBatchNumber();
    _selectedBatchId = _firstBatchId();
  }

  @override
  void didUpdateWidget(covariant ZhongyiMedicineStockPanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 父级刷新后批次可能被换掉，选中项失效时回落到第一个批次。
    if (!widget.batches.any((batch) => batch.id == _selectedBatchId)) {
      _selectedBatchId = _firstBatchId();
    }
  }

  @override
  void dispose() {
    for (final controller in [
      _quantity,
      _purchasePrice,
      _batchNumber,
      _storageLocation,
      _stockRemark,
      _adjustQuantity,
      _adjustRemark,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [_summaryCard(), _batchCard(), _stockInCard(), _adjustCard()],
    );
  }

  // ===================== 总览与清单 =====================

  Widget _summaryCard() {
    final total = zhongyiBatchStockTotal(widget.batches);
    final stock = zhongyiStockDisplay(total, 'g');
    return ZhongyiCard(
      padding: EdgeInsets.all(14.w),
      divided: false,
      children: [
        Row(
          children: [
            ZhongyiMetricTile(
              label: '可用余量',
              value: '${zhongyiNumberText(stock.value.toDouble())}${stock.unit}',
              color: total <= 0 ? TdColors.brand : TdColors.textPrimary,
            ),
            SizedBox(width: 8.w),
            ZhongyiMetricTile(label: '批次数', value: '${widget.batches.length}'),
          ],
        ),
        SizedBox(height: 8.h),
        Text('余量只统计质检合格且未耗尽的批次。', style: greyStyle(font: 12.sp)),
      ],
    );
  }

  Widget _batchCard() {
    return ZhongyiCard(
      title: '库存批次',
      padding: EdgeInsets.only(bottom: 4.h),
      children: [
        if (widget.batches.isEmpty)
          const ZhongyiEmpty(text: '暂无批次，先在下面入库')
        else
          for (final batch in widget.batches) _batchRow(batch),
      ],
    );
  }

  /// 批次行即调整目标选择器，选中态用浅底标出。
  Widget _batchRow(ZhongyiInventoryBatch batch) {
    final stock = zhongyiStockDisplay(batch.quantityG, batch.unit);
    final selected = batch.id == _selectedBatchId;
    final location = zyText(batch.storageLocation);
    final expiry = zyText(batch.expiryDate);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => setState(() => _selectedBatchId = batch.id),
      child: Container(
        color: selected ? TdColors.brandLight : null,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    batch.batchNumber,
                    style: blackBoldStyle(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (selected) ...[const ZhongyiStatusTag('调整目标'), SizedBox(width: 5.w)],
                ZhongyiStatusTag(
                  zhongyiQualityText(batch.qualityStatus),
                  colorPreset: _qualityPreset(batch.qualityStatus),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              '余${zhongyiNumberText(stock.value.toDouble())}${stock.unit}'
              ' · 进¥${batch.purchasePrice == null ? '-' : zhongyiNumberText(batch.purchasePrice!)}'
              ' · ${location ?? '未标库位'}',
              style: greyStyle(font: 12.sp),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (expiry != null) ...[
              SizedBox(height: 2.h),
              Text('效期 ${zyTimeText(expiry)}', style: greyStyle(font: 12.sp)),
            ],
          ],
        ),
      ),
    );
  }

  TTagColorPreset _qualityPreset(String? status) => switch (status) {
        'qualified' => TTagColorPreset.success,
        'pending' => TTagColorPreset.warning,
        'unqualified' => TTagColorPreset.danger,
        _ => TTagColorPreset.defaultTheme,
      };

  // ===================== 入库 =====================

  Widget _stockInCard() {
    return ZhongyiCard(
      title: '入库',
      padding: EdgeInsets.only(bottom: 4.h),
      children: [
        ZhongyiFormRow(
          label: '入库数量',
          child: ZhongyiFormInput(
            controller: _quantity,
            hint: '本次入库量',
            number: true,
            suffix: 'g',
            onChanged: (_) => setState(() {}),
          ),
        ),
        ZhongyiFormRow(
          label: '进货价',
          child: ZhongyiFormInput(
            controller: _purchasePrice,
            hint: '选填',
            number: true,
            suffix: '元/g',
            onChanged: (_) => setState(() {}),
          ),
        ),
        ZhongyiFormRow(
          label: '批号',
          child: Row(
            children: [
              Expanded(child: ZhongyiFormInput(controller: _batchNumber, hint: '批号')),
              SizedBox(width: 6.w),
              SizedBox(
                width: 64.w,
                child: ZhongyiPrimaryButton(
                  text: '新批号',
                  height: 40,
                  variant: TButtonVariant.outline,
                  onPressed: () => setState(() => _batchNumber.text = _newBatchNumber()),
                ),
              ),
            ],
          ),
        ),
        ZhongyiFormRow(
          label: '库位',
          child: ZhongyiFormInput(controller: _storageLocation, hint: '例:甲柜2层3号'),
        ),
        const ZhongyiFieldLabel('质检状态'),
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 6.h),
          child: ZhongyiChipGroup(
            options: [for (final option in zhongyiQualityOptions) option.label],
            selected: {zhongyiQualityText(_qualityStatus)},
            onTap: (label) => setState(() {
              for (final option in zhongyiQualityOptions) {
                if (option.label == label) _qualityStatus = option.value;
              }
            }),
          ),
        ),
        _dateRow(label: '生产日期', value: _productionDate, onTap: () => _pickDate(production: true), onClear: () => setState(() => _productionDate = null)),
        _dateRow(label: '有效期至', value: _expiryDate, onTap: () => _pickDate(production: false), onClear: () => setState(() => _expiryDate = null)),
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('入库备注', style: greyStyle()),
              SizedBox(height: 5.h),
              ZhongyiFormInput(controller: _stockRemark, hint: '选填', maxLines: 2),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 8.h, 12.w, 10.h),
          child: ZhongyiPrimaryButton(
            text: '确认入库',
            height: 42,
            loading: _stocking,
            onPressed: _submitStockIn,
          ),
        ),
      ],
    );
  }

  Widget _dateRow({
    required String label,
    required DateTime? value,
    required VoidCallback onTap,
    required VoidCallback onClear,
  }) {
    return ZhongyiFormRow(
      label: label,
      child: ZhongyiFormPicker(
        value: value == null ? null : _dateText(value),
        hint: '选填',
        onTap: onTap,
        trailing: value == null ? null : ZhongyiClearButton(onTap: onClear),
      ),
    );
  }

  // ===================== 调整 =====================

  Widget _adjustCard() {
    final batch = _selectedBatch;
    final after = _afterQuantity;
    return ZhongyiCard(
      title: '库存调整',
      padding: EdgeInsets.only(bottom: 4.h),
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 4.h),
          child: Text(
            batch == null
                ? '请先入库，再选择要调整的批次。'
                : '调整目标：${batch.batchNumber} · 当前余${zhongyiNumberText(batch.quantityG)}${batch.unit}',
            style: greyStyle(),
          ),
        ),
        ZhongyiFormRow(
          label: '调整数量',
          child: ZhongyiFormInput(
            controller: _adjustQuantity,
            hint: '正增负减',
            number: true,
            signed: true,
            suffix: 'g',
            onChanged: (_) => setState(() {}),
          ),
        ),
        const ZhongyiFieldLabel('调整原因'),
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 0, 12.w, 6.h),
          child: ZhongyiChipGroup(
            options: zhongyiAdjustReasons,
            selected: {_adjustRemark.text},
            onTap: (value) => setState(() => _adjustRemark.text = value),
          ),
        ),
        ZhongyiFormRow(
          label: '自定义',
          child: ZhongyiFormInput(
            controller: _adjustRemark,
            hint: '调整原因',
            onChanged: (_) => setState(() {}),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 4.h),
          child: Text(
            _afterText(after),
            style: blackStyle().copyWith(
              color: after == null ? TdColors.brand : const Color(0xFF16A34A),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 4.h, 12.w, 10.h),
          child: ZhongyiPrimaryButton(
            text: '确认调整',
            height: 42,
            loading: _adjusting,
            onPressed: after == null ? null : _submitAdjust,
          ),
        ),
      ],
    );
  }

  ZhongyiInventoryBatch? get _selectedBatch {
    for (final batch in widget.batches) {
      if (batch.id == _selectedBatchId) return batch;
    }
    return null;
  }

  /// 调整后的余量；数量不合法或会调成负数时返回 null，按钮直接置灰不等后端报错。
  double? get _afterQuantity {
    final batch = _selectedBatch;
    final change = _readNumber(_adjustQuantity);
    if (batch == null || change == null || change == 0) return null;
    final after = batch.quantityG + change;
    return after < 0 ? null : after;
  }

  /// 预览文案区分「还没填数量」和「填了但会调成负数」，两种情况的下一步动作不一样。
  String _afterText(double? after) {
    if (after != null) return '调整后余量：${zhongyiNumberText(after)}g';
    final change = _readNumber(_adjustQuantity);
    if (change == null || change == 0) return '调整后余量：—（正增负减，数量不能为 0）';
    return '调整后余量：—（库存不足，不能调成负数）';
  }

  // ===================== 交互 =====================

  Future<void> _pickDate({required bool production}) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: production ? (_productionDate ?? now) : (_expiryDate ?? now.add(const Duration(days: 365))),
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(now.year + 30),
    );
    if (picked == null || !mounted) return;
    setState(() {
      if (production) {
        _productionDate = picked;
      } else {
        _expiryDate = picked;
      }
    });
  }

  Future<void> _submitStockIn() async {
    final quantity = _readNumber(_quantity);
    if (quantity == null || quantity <= 0) {
      showMessage('请输入大于 0 的入库数量');
      return;
    }
    final price = _readNumber(_purchasePrice);
    if (_purchasePrice.text.trim().isNotEmpty && (price == null || price < 0)) {
      showMessage('进货价必须是不小于 0 的数字');
      return;
    }
    if (_productionDate != null && _expiryDate != null && _expiryDate!.isBefore(_productionDate!)) {
      showMessage('有效期不能早于生产日期');
      return;
    }
    setState(() => _stocking = true);
    try {
      final ok = await widget.onStockIn({
        'medicine_id': widget.medicineId,
        'batch_number': _batchNumber.text.trim().isEmpty ? _newBatchNumber() : _batchNumber.text.trim(),
        'quantity_g': quantity,
        'unit': 'g',
        'purchase_price': price,
        'quality_status': _qualityStatus,
        'storage_location': _storageLocation.text.trim(),
        'production_date': _productionDate == null ? null : _dateText(_productionDate!),
        'expiry_date': _expiryDate == null ? null : _dateText(_expiryDate!),
        'description': _stockRemark.text.trim(),
        'remark': 'App入库',
      });
      if (!ok || !mounted) return;
      // 批号保留，方便同一批连续入库；换批走上面的「新批号」。
      _quantity.clear();
      _purchasePrice.clear();
      _storageLocation.clear();
      _stockRemark.clear();
      _productionDate = null;
      _expiryDate = null;
    } finally {
      if (mounted) setState(() => _stocking = false);
    }
  }

  Future<void> _submitAdjust() async {
    final batch = _selectedBatch;
    final change = _readNumber(_adjustQuantity);
    final after = _afterQuantity;
    if (batch == null || change == null || after == null) {
      showMessage('请选择批次并填写合法的调整数量');
      return;
    }
    showAlertDialog(
      title: '确认调整',
      message: '${batch.batchNumber} 余量将调整为 ${zhongyiNumberText(after)}g，确定吗？',
      confirmText: '调整',
      confirm: () async {
        dismissAlertDialog();
        setState(() => _adjusting = true);
        try {
          final remark = _adjustRemark.text.trim();
          final ok = await widget.onAdjust(batch.id, change, remark.isEmpty ? 'App库存调整' : remark);
          if (!ok || !mounted) return;
          _adjustQuantity.clear();
        } finally {
          if (mounted) setState(() => _adjusting = false);
        }
      },
    );
  }

  int _firstBatchId() => widget.batches.isEmpty ? 0 : widget.batches.first.id;

  String _newBatchNumber() => 'INIT${DateTime.now().millisecondsSinceEpoch}';

  String _dateText(DateTime value) {
    String p2(int input) => input.toString().padLeft(2, '0');
    return '${value.year}-${p2(value.month)}-${p2(value.day)}';
  }

  double? _readNumber(TextEditingController controller) {
    final text = controller.text.trim();
    return text.isEmpty ? null : double.tryParse(text);
  }
}
