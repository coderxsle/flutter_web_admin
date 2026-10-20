import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';
import 'package:yun_men_yi_pan/app/utils/result_code.dart';

import '../../../utils/global.dart';
import '../http/zhongyi_request.dart';
import '../model/zhongyi_model.dart';
import '../service/zhongyi_domain.dart';
import '../widget/zhongyi_medicine_profile_form.dart';
import '../widget/zhongyi_medicine_stock_panel.dart';
import '../widget/zhongyi_ui.dart';

/// 药品新增 / 编辑：身份头 + 资料 / 库存 / 定价三段。
///
/// 一段对应一类写操作：资料段 submit updateMedicine / createMedicine，库存段
/// submit stock-in 与 adjust，定价段 submit 新增零售价。三段各自校验、各自提交；
/// 未出现在请求体的 key 由后端保留原值，所以每段只提交自己负责的字段。
class ZhongyiMedicineEditPage extends StatefulWidget {
  const ZhongyiMedicineEditPage({super.key});

  @override
  State<ZhongyiMedicineEditPage> createState() => _ZhongyiMedicineEditPageState();
}

class _ZhongyiMedicineEditPageState extends State<ZhongyiMedicineEditPage> {
  /// 段下标：资料 / 库存 / 定价，顺序与 [_tabLabels] 一致。
  static const int _profileTab = 0;
  static const int _stockTab = 1;
  static const int _priceTab = 2;
  static const List<String> _tabLabels = ['资料', '库存', '定价'];
  static const Color _success = Color(0xFF16A34A);

  final _profileKey = GlobalKey<ZhongyiMedicineProfileFormState>();
  final _salePrice = TextEditingController();

  int _medicineId = 0;
  int _tab = _profileTab;
  ZhongyiMedicine? _medicine;
  List<ZhongyiInventoryBatch> _batches = const [];
  List<ZhongyiMedicinePrice> _prices = const [];
  bool _loading = false;
  bool _saving = false;
  bool _pricing = false;
  String? _error;

  /// 资料段或定价段有未提交的改动，返回前要确认。
  bool _dirty = false;

  bool get _isNew => _medicineId == 0;

  @override
  void initState() {
    super.initState();
    _medicineId = zyInt(Get.arguments) ?? 0;
    if (!_isNew) _load();
  }

  @override
  void dispose() {
    _salePrice.dispose();
    super.dispose();
  }

  /// [silent] 为真时只换数据不切加载态，避免入库等操作把整页顶掉、连带清空段内表单。
  Future<void> _load({bool silent = false}) async {
    if (!silent) {
      setState(() {
        _loading = true;
        _error = null;
      });
    }
    final detail = await ZhongyiRequest.medicineDetail(_medicineId);
    if (!mounted) return;
    if (!detail.success) {
      setState(() {
        _loading = false;
        _error = zyTextOr(detail.message, '药品加载失败');
      });
      return;
    }
    final medicine = ZhongyiMedicine.fromJson(zyMap(detail.data));
    final responses = await Future.wait([
      ZhongyiRequest.inventoryList(pageSize: 100, medicineKeyword: medicine.fullName),
      ZhongyiRequest.medicinePrices(_medicineId),
    ]);
    if (!mounted) return;
    final batchResponse = responses[0];
    final priceResponse = responses[1];
    final items = batchResponse.success
        ? ZhongyiPage.from<ZhongyiInventoryBatch>(zyMap(batchResponse.data), ZhongyiInventoryBatch.fromJson).items
        : <ZhongyiInventoryBatch>[];
    final batches = items.where((batch) => batch.medicineId == _medicineId).toList()
      ..sort((a, b) => a.id.compareTo(b.id));
    setState(() {
      _medicine = medicine;
      _batches = batches;
      _prices = priceResponse.success
          ? zyMapList(priceResponse.data).map(ZhongyiMedicinePrice.fromJson).toList()
          : const [];
      _loading = false;
      _error = null;
    });
    if (!batchResponse.success) showMessage(zyTextOr(batchResponse.message, '库存批次加载失败'));
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !_dirty,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _confirmLeave();
      },
      child: Scaffold(
        backgroundColor: TdColors.pageBg,
        appBar: AppBar(
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: TdColors.white), onPressed: _confirmLeave),
          title: NavigatorTitle(_isNew ? '新增药品' : '药品编辑'),
        ),
        body: _loading ? const ZhongyiLoading() : _body(),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 20.h + MediaQuery.paddingOf(context).bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (_error != null) ...[ZhongyiNotice(_error!), _retryRow()],
          _identityCard(),
          // 新增时还没落库，库存/定价两段没有意义，直接不显示分段。
          if (!_isNew) ...[_tabs(), SizedBox(height: 10.h)],
          _sections(),
        ],
      ),
    );
  }

  Widget _retryRow() {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: ZhongyiPrimaryButton(text: '重新加载', height: 40, onPressed: () => _load()),
    );
  }

  // ===================== 身份头 =====================

  Widget _identityCard() {
    final medicine = _medicine;
    if (medicine == null) {
      return ZhongyiCard(
        padding: EdgeInsets.all(14.w),
        divided: false,
        children: [
          Text('新增药品', style: blackBoldStyle(font: 18.sp)),
          SizedBox(height: 6.h),
          Text('保存基础资料后，即可在「库存」与「定价」里维护入库与售价。', style: greyStyle()),
        ],
      );
    }
    final stock = zhongyiStockDisplay(medicine.stockQuantityG, medicine.unit);
    final property = zhongyiPropertiesText(
      medicine.propertyNature,
      medicine.propertyFlavors,
      medicine.propertyMeridians,
    );
    return ZhongyiCard(
      padding: EdgeInsets.all(14.w),
      divided: false,
      children: [
        Row(
          children: [
            if (medicine.prefix.isNotEmpty) ...[
              ZhongyiPrefixChip(medicine.prefix, height: 26),
              SizedBox(width: 6.w),
            ],
            Expanded(
              child: Text(
                medicine.fullName,
                style: blackBoldStyle(font: 19.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (medicine.isSpecialManagement)
              const ZhongyiStatusTag('特殊管理', colorPreset: TTagColorPreset.warning),
          ],
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Flexible(
              child: Text(
                '${zhongyiCategoryText(medicine.category)} · ${medicine.medicineCode}',
                style: greyStyle(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: 6.w),
            ZhongyiStatusTag(
              medicine.enabled ? '可用' : '停用',
              colorPreset: medicine.enabled ? TTagColorPreset.success : TTagColorPreset.warning,
            ),
          ],
        ),
        if (property != null) ...[
          SizedBox(height: 4.h),
          Text(property, style: greyStyle()),
        ],
        SizedBox(height: 10.h),
        Row(
          children: [
            ZhongyiMetricTile(
              label: '可用余量',
              value: '${zhongyiNumberText(stock.value.toDouble())}${stock.unit}',
              color: medicine.stockQuantityG <= 0 ? TdColors.brand : TdColors.textPrimary,
            ),
            SizedBox(width: 8.w),
            ZhongyiMetricTile(
              label: '零售价',
              value: medicine.retailSalePrice == null
                  ? '未定价'
                  : '¥${zhongyiNumberText(medicine.salePrice)}/${medicine.unit}',
              color: TdColors.brand,
            ),
            SizedBox(width: 8.w),
            ZhongyiMetricTile(
              label: '最近进价',
              value: medicine.latestPurchasePrice == null ? '暂无' : '¥${zhongyiNumberText(medicine.purchasePrice)}',
              color: _success,
            ),
          ],
        ),
      ],
    );
  }

  // ===================== 段控 =====================

  Widget _tabs() {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(color: TdColors.white, borderRadius: BorderRadius.circular(10.w)),
      child: Row(
        children: [
          for (var index = 0; index < _tabLabels.length; index++) _tabButton(index, _tabLabels[index]),
        ],
      ),
    );
  }

  Widget _tabButton(int index, String label) {
    final active = _tab == index;
    // 新增态先落库再谈库存与定价：另两段置灰但仍可点，点了给提示而不是静默失效。
    final locked = _isNew && index != _profileTab;
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _switchTab(index),
        child: Container(
          height: 34.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? TdColors.brand : Colors.transparent,
            borderRadius: BorderRadius.circular(8.w),
          ),
          child: Text(
            label,
            style: blackStyle().copyWith(
              fontWeight: active ? FontWeight.w600 : FontWeight.w400,
              color: active
                  ? TdColors.white
                  : locked
                  ? TdColors.grey153
                  : TdColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  void _switchTab(int tab) {
    if (_isNew && (tab == _stockTab || tab == _priceTab)) {
      showMessage('请先保存基础资料，再维护库存与定价');
      return;
    }
    if (tab == _tab) return;
    setState(() => _tab = tab);
  }

  // ===================== 段内容 =====================

  /// 三段都用 Offstage 保活：切段不销毁 State，资料段没保存的输入不会丢，
  /// 未显示的段也不占高度（Offstage 在无界高度下按 zero 尺寸上报）。
  Widget _sections() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _keepAlive(_profileTab, _profileSection()),
        _keepAlive(_stockTab, _stockSection()),
        _keepAlive(_priceTab, _priceSection()),
      ],
    );
  }

  Widget _keepAlive(int tab, Widget child) => Offstage(offstage: _tab != tab, child: child);

  Widget _profileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ZhongyiMedicineProfileForm(
          key: _profileKey,
          medicine: _medicine,
          onChanged: () {
            if (!_dirty) setState(() => _dirty = true);
          },
        ),
        SizedBox(height: 4.h),
        ZhongyiPrimaryButton(
          text: _isNew ? '创建药品' : '保存资料',
          loading: _saving,
          onPressed: _submitProfile,
        ),
      ],
    );
  }

  Widget _stockSection() {
    return ZhongyiMedicineStockPanel(
      medicineId: _medicineId,
      batches: _batches,
      onStockIn: _stockIn,
      onAdjust: _adjust,
    );
  }

  Widget _priceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [_priceCard(), _priceHistoryCard()],
    );
  }

  Widget _priceCard() {
    final medicine = _medicine;
    final current = medicine == null || medicine.retailSalePrice == null
        ? '未定价'
        : '¥${zhongyiAmountText(medicine.salePrice)} / ${medicine.unit}';
    return ZhongyiCard(
      title: '定价',
      padding: EdgeInsets.only(bottom: 10.h),
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 4.h),
          child: Row(
            children: [
              Text('当前零售价', style: greyStyle()),
              const Spacer(),
              Text(current, style: redThemeStyle(font: 17.sp).copyWith(fontWeight: FontWeight.w800)),
            ],
          ),
        ),
        ZhongyiFormRow(
          label: '新零售价',
          child: ZhongyiFormInput(
            controller: _salePrice,
            hint: '按克计价',
            number: true,
            suffix: '元/g',
            onChanged: (_) {
              if (!_dirty) setState(() => _dirty = true);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 4.h),
          child: Text('保存后后端按生效时间取最新一条作为当前售价，旧价自动封存。', style: greyStyle(font: 12.sp)),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 10.h),
          child: ZhongyiPrimaryButton(text: '确认定价', height: 42, loading: _pricing, onPressed: _submitPrice),
        ),
      ],
    );
  }

  Widget _priceHistoryCard() {
    return ZhongyiCard(
      title: '价格历史',
      padding: EdgeInsets.only(bottom: 4.h),
      children: [
        if (_prices.isEmpty)
          const ZhongyiEmpty(text: '暂无定价记录，先在上面定价')
        else
          for (final price in _prices.take(10)) _priceRow(price),
      ],
    );
  }

  Widget _priceRow(ZhongyiMedicinePrice price) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('¥${zhongyiAmountText(price.salePrice)} / ${price.unit}', style: blackBoldStyle()),
                SizedBox(height: 3.h),
                Text('${zyTimeText(price.effectiveFrom)} 起', style: greyStyle(font: 12.sp)),
              ],
            ),
          ),
          ZhongyiStatusTag(
            price.active ? '生效中' : '已封存',
            colorPreset: price.active ? TTagColorPreset.success : TTagColorPreset.defaultTheme,
          ),
        ],
      ),
    );
  }

  // ===================== 提交 =====================

  Future<void> _submitProfile() async {
    final form = _profileKey.currentState;
    if (form == null) return;
    final invalid = form.validate();
    if (invalid != null) {
      showMessage(invalid);
      return;
    }
    setState(() => _saving = true);
    try {
      final body = form.toBody();
      if (_isNew) {
        // 新增要自己补齐后端不会算的编码，拼音与状态由表单带着。
        body['medicine_code'] = 'M${DateTime.now().millisecondsSinceEpoch}';
        final response = await ZhongyiRequest.createMedicine(body);
        if (!response.success) {
          showMessage(response.message ?? '');
          return;
        }
        _medicineId = ZhongyiMedicine.fromJson(zyMap(response.data)).id;
        _dirty = false;
        showMessage('药品已创建，可继续维护库存与定价');
        await _load(silent: true);
        if (mounted) setState(() => _tab = _stockTab);
        return;
      }
      final response = await ZhongyiRequest.updateMedicine(_medicineId, body);
      if (!response.success) {
        showMessage(response.message ?? '');
        return;
      }
      _dirty = false;
      showMessage('药品资料已保存');
      await _load(silent: true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<bool> _stockIn(Map<String, dynamic> body) async {
    final response = await ZhongyiRequest.stockIn(body);
    showMessage(zyTextOr(response.message, '入库成功'));
    if (!response.success) return false;
    await _load(silent: true);
    return true;
  }

  Future<bool> _adjust(int inventoryId, double quantityChange, String remark) async {
    final response = await ZhongyiRequest.adjustInventory(
      inventoryId: inventoryId,
      quantityChange: quantityChange,
      remark: remark,
    );
    showMessage(zyTextOr(response.message, '调整成功'));
    if (!response.success) return false;
    await _load(silent: true);
    return true;
  }

  Future<void> _submitPrice() async {
    final price = double.tryParse(_salePrice.text.trim());
    if (price == null || price < 0) {
      showMessage('请输入不小于 0 的销售价');
      return;
    }
    showAlertDialog(
      title: '确认定价',
      message: '确定将零售价设置为 ¥${zhongyiNumberText(price)}/g 吗？',
      confirmText: '定价',
      confirm: () async {
        dismissAlertDialog();
        setState(() => _pricing = true);
        try {
          final response = await ZhongyiRequest.createMedicinePrice(_medicineId, salePrice: price, unit: 'g');
          showMessage(zyTextOr(response.message, '定价已保存'));
          if (!response.success) return;
          _dirty = false;
          await _load(silent: true);
        } finally {
          if (mounted) setState(() => _pricing = false);
        }
      },
    );
  }

  /// 返回统一走这里：AppBar 的返回键与系统返回键都要过未保存确认。
  void _confirmLeave() {
    if (!_dirty) {
      Get.back();
      return;
    }
    showAlertDialog(
      title: '放弃修改',
      message: '资料或售价有未保存的改动，确定离开吗？',
      confirmText: '放弃',
      confirm: () {
        dismissAlertDialog();
        setState(() => _dirty = false);
        Get.back();
      },
    );
  }
}
