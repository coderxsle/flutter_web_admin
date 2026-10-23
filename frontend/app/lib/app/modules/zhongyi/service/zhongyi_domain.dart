import 'package:pinyin/pinyin.dart';

import '../model/zhongyi_model.dart';

/// 中药房的开方计价与展示规则，与参考实现 utils/pharmacy.ts 的计算口径一致。

/// 一条开方明细：药品信息 + 本方可编辑的单剂用量。
class ZhongyiPrescriptionLine {
  ZhongyiPrescriptionLine({
    required this.medicineId,
    required this.name,
    required this.unit,
    required this.purchasePrice,
    required this.salePrice,
    required this.stockQuantity,
    this.dosageGrams = 0,
  });

  final int medicineId;

  /// 展示名，含炮制前缀。
  final String name;
  final String unit;
  final double purchasePrice;
  final double salePrice;
  final double stockQuantity;

  /// 单剂用量（克），由用户填写。
  double dosageGrams;

  factory ZhongyiPrescriptionLine.fromMedicine(ZhongyiMedicine medicine) => ZhongyiPrescriptionLine(
        medicineId: medicine.id,
        name: medicine.fullName,
        unit: medicine.unit,
        purchasePrice: medicine.purchasePrice,
        salePrice: medicine.salePrice,
        stockQuantity: medicine.stockQuantityG,
      );
}

/// 按剂数摊开后的明细：总用量、成本与售价、缺口。
class ZhongyiCalculatedLine {
  const ZhongyiCalculatedLine({
    required this.line,
    required this.totalQuantity,
    required this.costAmount,
    required this.saleAmount,
    required this.stockShortage,
  });

  final ZhongyiPrescriptionLine line;
  final double totalQuantity;
  final double costAmount;
  final double saleAmount;
  final double stockShortage;

  bool get shortage => stockShortage > 0;
}

/// 整方汇总。
class ZhongyiPrescriptionSummary {
  const ZhongyiPrescriptionSummary({
    required this.items,
    required this.totalCost,
    required this.totalSaleAmount,
    required this.grossProfit,
    required this.grossMargin,
    required this.hasShortage,
  });

  final List<ZhongyiCalculatedLine> items;
  final double totalCost;
  final double totalSaleAmount;
  final double grossProfit;
  final double grossMargin;
  final bool hasShortage;
}

/// 金额与数量按参考实现保留两位/三位，避免浮点误差累积。
double zhongyiMoney(double value) => (value * 100).round() / 100;

double zhongyiQuantity(double value) => (value * 1000).round() / 1000;

ZhongyiPrescriptionSummary calculatePrescription(List<ZhongyiPrescriptionLine> lines, int doses) {
  final safeDoses = doses > 0 ? doses : 0;
  final items = lines.map((line) {
    final totalQuantity = zhongyiQuantity(line.dosageGrams * safeDoses);
    final shortage = totalQuantity - line.stockQuantity;
    return ZhongyiCalculatedLine(
      line: line,
      totalQuantity: totalQuantity,
      costAmount: zhongyiMoney(totalQuantity * line.purchasePrice),
      saleAmount: zhongyiMoney(totalQuantity * line.salePrice),
      stockShortage: shortage > 0 ? zhongyiQuantity(shortage) : 0,
    );
  }).toList();

  final totalCost = zhongyiMoney(items.fold<double>(0, (sum, item) => sum + item.costAmount));
  final totalSale = zhongyiMoney(items.fold<double>(0, (sum, item) => sum + item.saleAmount));
  final profit = zhongyiMoney(totalSale - totalCost);
  return ZhongyiPrescriptionSummary(
    items: items,
    totalCost: totalCost,
    totalSaleAmount: totalSale,
    grossProfit: profit,
    grossMargin: totalSale > 0 ? zhongyiMoney(profit / totalSale * 100) : 0,
    hasShortage: items.any((item) => item.shortage),
  );
}

/// 转成后端 billing/create 需要的明细：后端认 relationType / relationId（不是 reference*）。
List<Map<String, dynamic>> toBillItems(ZhongyiPrescriptionSummary summary, int doses) {
  return summary.items.map((item) {
    final line = item.line;
    final quantity = item.totalQuantity.ceil();
    return <String, dynamic>{
      'itemType': 'medicine',
      'itemName': line.name,
      'quantity': quantity < 1 ? 1 : quantity,
      'unitPrice': line.salePrice,
      'relationType': 'medicine',
      'relationId': line.medicineId,
      'specification': '${zhongyiNumberText(line.dosageGrams)}${line.unit} x $doses剂',
      'unit': line.unit,
    };
  }).toList();
}

/// 数字去掉多余小数位：7.0 → 7，7.50 → 7.5。
String zhongyiNumberText(double value) {
  if (value == value.roundToDouble()) return value.toInt().toString();
  return value.toString();
}

/// 金额展示，保留两位。
String zhongyiAmountText(double value) => value.toStringAsFixed(2);

// ===================== 展示映射 =====================

/// 余量展示：克数超过 1000 换算成 kg，与参考实现一致。
({num value, String unit}) zhongyiStockDisplay(double quantity, String unit) {
  if (unit.toLowerCase() == 'g' && quantity > 1000) {
    final kg = quantity / 1000;
    return (value: kg == kg.roundToDouble() ? kg.toInt() : (kg * 10).round() / 10, unit: 'kg');
  }
  return (value: quantity == quantity.roundToDouble() ? quantity.toInt() : quantity, unit: unit);
}

/// 服务端不返回排序用拼音时，取字符串里首个拉丁字母做索引。
String zhongyiMedicineInitial(ZhongyiMedicine medicine) {
  final raw = medicine.pinyin.trim().toLowerCase();
  final match = RegExp('[a-z]').firstMatch(raw);
  if (match == null) return '#';
  final initial = raw.substring(match.start, match.start + 1).toUpperCase();
  return RegExp('^[A-Z]\$').hasMatch(initial) ? initial : '#';
}

const String _indexLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

/// 药品按拼音首字母分组，返回到组内顺序保持后端返回顺序。
List<({String index, List<ZhongyiMedicine> items})> groupMedicinesByIndex(List<ZhongyiMedicine> medicines) {
  final buckets = <String, List<ZhongyiMedicine>>{};
  for (final medicine in medicines) {
    buckets.putIfAbsent(zhongyiMedicineInitial(medicine), () => []).add(medicine);
  }
  final keys = [..._indexLetters.split(''), '#'].where(buckets.containsKey).toList();
  return keys.map((key) => (index: key, items: buckets[key]!)).toList();
}

String zhongyiStageText(String? stage) => switch (stage) {
      'registration' => '挂号',
      'treatment' => '诊疗',
      _ => zyText(stage) ?? '-',
    };

String zhongyiPaymentStatusText(String? status) => switch (status) {
      'unpaid' => '未支付',
      'partially_paid' => '部分支付',
      'paid' => '已支付',
      'partially_refunded' => '部分退款',
      'refunding' => '退款中',
      'refunded' => '已退款',
      _ => zyText(status) ?? '-',
    };

/// 后端账单 status：1 正常、0 已取消。
String zhongyiBillStatusText(int status) => status == 0 ? '已取消' : '正常';

String zhongyiScopeText(String? scope) => switch (scope) {
      'public' => '公共模板',
      'agreed' => '协定模板',
      _ => '个人模板',
    };

/// 后端退款 status：0 待审批、1 已批准、2 已完成。
String zhongyiRefundStatusText(int status) => switch (status) {
      0 => '待审批',
      1 => '已批准',
      2 => '已完成',
      _ => '未知状态',
    };

String zhongyiChannelText(String? channel) => switch (channel) {
      'cash' => '现金',
      'wechat' => '微信',
      'alipay' => '支付宝',
      'bank_card' => '银行卡',
      _ => zyText(channel) ?? '-',
    };

String zhongyiQualityText(String? status) => switch (status) {
      'qualified' => '合格',
      'unqualified' => '不合格',
      'pending' => '待检',
      _ => zyText(status) ?? '-',
    };

const List<({String value, String label})> zhongyiPayChannels = [
  (value: 'cash', label: '现金'),
  (value: 'wechat', label: '微信'),
  (value: 'alipay', label: '支付宝'),
  (value: 'bank_card', label: '银行卡'),
];

const List<({String value, String label})> zhongyiTemplateScopes = [
  (value: 'personal', label: '个人模板'),
  (value: 'public', label: '公共模板'),
  (value: 'agreed', label: '协定模板'),
];

/// 后端 updateMedicine/createMedicine 对炮制前缀的长度上限。
const int zhongyiPrefixMaxLength = 5;

/// 拼音库词组词典的错读（大黄→daihuang、玄参→xuancan、大血藤→daxieteng）；
/// 键按最长匹配生效，值为该词的标准拼音。
const Map<String, String> _pinyinFixes = {
  '大黄炭': 'dahuangtan',
  '生大黄': 'shengdahuang',
  '熟大黄': 'shudahuang',
  '酒大黄': 'jiudahuang',
  '大血藤': 'daxueteng',
  '大黄': 'dahuang',
  '红参': 'hongshen',
  '玄参': 'xuanshen',
  '参须': 'shenxu',
};

/// 基名转拼音：只吃基名（炮制前缀单列，不进拼音），并修正词典错读。
String zhongyiPinyinOf(String name) {
  final text = name.trim();
  if (text.isEmpty) return '';

  final keys = _pinyinFixes.keys.toList()..sort((a, b) => b.length.compareTo(a.length));
  if (!keys.any(text.contains)) return _rawPinyin(text);

  final buffer = StringBuffer();
  var plain = StringBuffer();
  void flushPlain() {
    if (plain.isEmpty) return;
    buffer.write(_rawPinyin(plain.toString()));
    plain = StringBuffer();
  }

  var index = 0;
  while (index < text.length) {
    String? matched;
    for (final key in keys) {
      if (text.startsWith(key, index)) {
        matched = key;
        break;
      }
    }
    if (matched == null) {
      plain.write(text[index]);
      index++;
      continue;
    }
    flushPlain();
    buffer.write(_pinyinFixes[matched]);
    index += matched.length;
  }
  flushPlain();
  return buffer.toString();
}

String _rawPinyin(String text) => PinyinHelper.getPinyinE(
      text,
      separator: '',
      defPinyin: '',
      format: PinyinFormat.WITHOUT_TONE,
    ).toLowerCase().replaceAll(RegExp('[^a-z]'), '');

/// 药品分类候选，仅作输入建议；后端只校验非空与长度。
const List<String> zhongyiMedicineCategories = ['herb', 'mineral', 'animal', 'other'];

String zhongyiCategoryText(String? category) => switch (category) {
      'herb' => '植物药',
      'mineral' => '矿物药',
      'animal' => '动物药',
      'other' => '其他',
      _ => zyText(category) ?? '未分类',
    };

/// 药品状态：后端 1 为可用。
String zhongyiMedicineStatusText(int status) => status == 1 ? '可用' : '停用';

/// 常用剂量区间展示，未设置返回 null。
String? zhongyiDosageText(double? min, double? max) {
  if (min == null && max == null) return null;
  if (min != null && max != null) return '${zhongyiNumberText(min)}-${zhongyiNumberText(max)}g';
  if (min != null) return '${zhongyiNumberText(min)}g 起';
  return '不超过 ${zhongyiNumberText(max!)}g';
}

// ===================== 药品属性选项 =====================

/// 药品分类选项，值与后端枚举一致；展示中文复用 [zhongyiCategoryText]。
const List<({String value, String label})> zhongyiCategoryOptions = [
  (value: 'herb', label: '植物药'),
  (value: 'mineral', label: '矿物药'),
  (value: 'animal', label: '动物药'),
  (value: 'other', label: '其他'),
];

/// 四气，单选。
const List<String> zhongyiNatureOptions = ['寒', '凉', '平', '温', '热'];

/// 五味，多选。
const List<String> zhongyiFlavorOptions = ['辛', '甘', '酸', '苦', '咸', '涩', '淡'];

/// 归经，多选。十二经。
const List<String> zhongyiMeridianOptions = [
  '心',
  '肝',
  '脾',
  '肺',
  '肾',
  '胃',
  '胆',
  '大肠',
  '小肠',
  '膀胱',
  '三焦',
  '心包',
];

/// 性味归经摘要，例如「温 · 辛、甘 · 归肺、脾经」；三项都空返回 null。
String? zhongyiPropertiesText(String? nature, List<String> flavors, List<String> meridians) {
  final parts = <String>[
    if (zyText(nature) != null) nature!,
    if (flavors.isNotEmpty) flavors.join('、'),
    if (meridians.isNotEmpty) '归${meridians.join('、')}经',
  ];
  return parts.isEmpty ? null : parts.join(' · ');
}

/// 质检状态选项，值与后端枚举一致。
const List<({String value, String label})> zhongyiQualityOptions = [
  (value: 'qualified', label: '合格'),
  (value: 'pending', label: '待检'),
  (value: 'unqualified', label: '不合格'),
];

/// 库存调整的常用原因，仍允许自定义。
const List<String> zhongyiAdjustReasons = [
  '自然损耗(挥发、破碎、虫蛀)',
  '受潮',
  '盘盈',
  '盘亏',
  '过期报废',
];

/// 批次余量合计。口径与后端 hydrateMedicineSummary 一致：只累计未耗尽且质检合格的批次。
double zhongyiBatchStockTotal(Iterable<ZhongyiInventoryBatch> batches) {
  var total = 0.0;
  for (final batch in batches) {
    if (!batch.isExhausted && batch.qualityStatus == 'qualified') total += batch.quantityG;
  }
  return total;
}
