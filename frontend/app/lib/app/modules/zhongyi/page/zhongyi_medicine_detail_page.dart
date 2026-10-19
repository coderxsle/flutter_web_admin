import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/global.dart';
import '../http/zhongyi_request.dart';
import '../model/zhongyi_model.dart';
import '../service/zhongyi_domain.dart';
import '../widget/zhongyi_ui.dart';

/// 药品详情：只读展示基础资料与用药信息。
///
/// 入库、定价、库存调整都在编辑页，这里只负责「看清这味药是什么、还有多少」。
class ZhongyiMedicineDetailPage extends StatefulWidget {
  const ZhongyiMedicineDetailPage({super.key});

  @override
  State<ZhongyiMedicineDetailPage> createState() => _ZhongyiMedicineDetailPageState();
}

class _ZhongyiMedicineDetailPageState extends State<ZhongyiMedicineDetailPage> {
  int _medicineId = 0;
  ZhongyiMedicine? _medicine;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _medicineId = zyInt(Get.arguments) ?? 0;
    _load();
  }

  Future<void> _load() async {
    if (_medicineId <= 0) {
      setState(() => _loading = false);
      return;
    }
    setState(() => _loading = true);
    final response = await ZhongyiRequest.medicineDetail(_medicineId);
    if (!mounted) return;
    setState(() {
      _loading = false;
      _medicine = response.success ? ZhongyiMedicine.fromJson(response.mapData) : null;
    });
    if (!response.success) showMessage(response.message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TdColors.pageBg,
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: TdColors.white), onPressed: () => Get.back()),
        title: const NavigatorTitle('药品详情'),
        actions: [
          if (_medicine != null)
            TextButton(
              onPressed: () =>
                  Get.toNamed(Routes.ZHONGYIMEDICINEEDITPAGE, arguments: _medicineId)?.then((_) => _load()),
              child: Text('编辑', style: whiteStyle()),
            ),
        ],
      ),
      body: _body(),
    );
  }

  Widget _body() {
    if (_loading) return const ZhongyiLoading();
    final medicine = _medicine;
    if (medicine == null) return const ZhongyiEmpty(text: '未找到药品');

    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 20.h + MediaQuery.paddingOf(context).bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _summaryCard(medicine),
          _stats(medicine),
          _baseCard(medicine),
          _usageCard(medicine),
        ],
      ),
    );
  }

  Widget _summaryCard(ZhongyiMedicine medicine) {
    return ZhongyiCard(
      padding: EdgeInsets.all(16.w),
      divided: false,
      children: [
        if (medicine.isSpecialManagement) ...[
          Row(children: [const ZhongyiStatusTag('特殊管理', colorPreset: TTagColorPreset.warning)]),
          SizedBox(height: 8.h),
        ],
        Text(medicine.fullName, style: blackBoldStyle(font: 20.sp)),
        SizedBox(height: 4.h),
        Text(
          '${zhongyiCategoryText(medicine.category)} · ${medicine.medicineCode}',
          style: greyStyle(),
        ),
      ],
    );
  }

  /// 三格统计：库存不足走红色，售价走品牌色，进价走绿色。
  Widget _stats(ZhongyiMedicine medicine) {
    final stock = zhongyiStockDisplay(medicine.stockQuantityG, medicine.unit);
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: Row(
        children: [
          _statTile('当前库存', '${zhongyiNumberText(stock.value.toDouble())}${stock.unit}',
              medicine.stockQuantityG <= 0 ? TdColors.brand : TdColors.textPrimary),
          SizedBox(width: 8.w),
          _statTile('最近进价', '¥${zhongyiAmountText(medicine.purchasePrice)}', const Color(0xFF16A34A)),
          SizedBox(width: 8.w),
          _statTile('零售价', '¥${zhongyiAmountText(medicine.salePrice)}', TdColors.brand),
        ],
      ),
    );
  }

  Widget _statTile(String label, String value, Color color) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
        decoration: BoxDecoration(color: TdColors.white, borderRadius: BorderRadius.circular(12.w)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: greyStyle(font: 12.sp)),
            SizedBox(height: 6.h),
            Text(value,
                style: blackStyle().copyWith(fontWeight: FontWeight.w800, color: color),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  Widget _baseCard(ZhongyiMedicine medicine) {
    return ZhongyiCard(
      title: '基础信息',
      children: [
        ZhongyiKeyValueRow(label: '炮制前缀', value: zyText(medicine.prefix) ?? '-'),
        ZhongyiKeyValueRow(label: '拼音', value: zyText(medicine.pinyin) ?? '-'),
        ZhongyiKeyValueRow(label: '分类', value: zhongyiCategoryText(medicine.category)),
        ZhongyiKeyValueRow(label: '子分类', value: zyText(medicine.subcategory) ?? '-'),
        ZhongyiKeyValueRow(label: '产地', value: zyText(medicine.originPlace) ?? '-'),
        ZhongyiKeyValueRow(label: '药品编码', value: medicine.medicineCode),
        ZhongyiKeyValueRow(label: '状态', value: zhongyiMedicineStatusText(medicine.status)),
        ZhongyiKeyValueRow(label: '特殊管理', value: medicine.isSpecialManagement ? '是' : '否'),
      ],
    );
  }

  Widget _usageCard(ZhongyiMedicine medicine) {
    return ZhongyiCard(
      title: '用药信息',
      children: [
        ZhongyiKeyValueRow(
            label: '常用剂量', value: zhongyiDosageText(medicine.commonDosageMin, medicine.commonDosageMax) ?? '-'),
        ZhongyiKeyValueRow(
            label: '剂量警告',
            value: medicine.dosageWarning == null ? '-' : '${zhongyiNumberText(medicine.dosageWarning!)}g'),
        ZhongyiKeyValueRow(label: '毒性', value: zyText(medicine.toxicity) ?? '-'),
        ZhongyiKeyValueRow(label: '孕妇用药', value: zyText(medicine.pregnancyCategory) ?? '-'),
        ZhongyiKeyValueRow(
            label: '保质期', value: medicine.shelfLifeMonths == null ? '-' : '${medicine.shelfLifeMonths} 个月'),
        ZhongyiKeyValueRow(label: '功效', value: zyText(medicine.functions) ?? '-'),
        ZhongyiKeyValueRow(label: '储存要求', value: zyText(medicine.storageRequirements) ?? '-'),
        ZhongyiKeyValueRow(label: '主治', value: zyText(medicine.indications) ?? '-'),
        ZhongyiKeyValueRow(label: '备注', value: zyText(medicine.description) ?? '-'),
      ],
    );
  }
}
