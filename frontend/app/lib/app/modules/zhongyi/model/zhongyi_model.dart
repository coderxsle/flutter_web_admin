/// 中医（中药房）业务实体。
///
/// 字段名沿用 backend/flutter_web_server 的 zhongyi 服务输出（snake_case 的
/// 输出映射见各 Service 的 `xxxToMap`），只保留 App 用得到的字段。
library;

/// 宽容取整：非法值回落 null。
int? zyInt(Object? value) {
  if (value is int) return value;
  if (value is num) return value.isFinite ? value.toInt() : null;
  if (value is String) return int.tryParse(value.trim());
  return null;
}

/// 宽容取小数：非法值回落 null。
double? zyDouble(Object? value) {
  if (value is num) return value.isFinite ? value.toDouble() : null;
  if (value is String) return double.tryParse(value.trim());
  return null;
}

int zyIntOr(Object? value, [int fallback = 0]) => zyInt(value) ?? fallback;

double zyDoubleOr(Object? value, [double fallback = 0]) => zyDouble(value) ?? fallback;

/// 取非空文本，空串与纯空白一律回落 null。
String? zyText(Object? value) {
  if (value == null) return null;
  final text = value.toString().trim();
  return text.isEmpty ? null : text;
}

String zyTextOr(Object? value, [String fallback = '']) => zyText(value) ?? fallback;

bool zyBoolOr(Object? value, [bool fallback = false]) {
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final text = value.trim().toLowerCase();
    if (text == 'true' || text == '1') return true;
    if (text == 'false' || text == '0') return false;
  }
  return fallback;
}

Map<String, dynamic> zyMap(Object? value) => value is Map ? Map<String, dynamic>.from(value) : <String, dynamic>{};

List<Map<String, dynamic>> zyMapList(Object? value) {
  if (value is! List) return const [];
  return value.whereType<Map>().map(zyMap).toList();
}

/// 取字符串数组，非数组与空串一律丢掉。
List<String> zyTextList(Object? value) {
  if (value is! List) return const [];
  return value.map(zyText).whereType<String>().toList();
}

/// 时间字段统一按 `T` 替换空格、截断到秒展示。
String zyTimeText(Object? value) {
  final text = zyText(value);
  if (text == null) return '-';
  final normalized = text.replaceFirst('T', ' ');
  return normalized.length > 19 ? normalized.substring(0, 19) : normalized;
}

/// 分页结果。后端有 PageResponse（`records`）与 patient/template（`items`）两种形状，这里统一。
class ZhongyiPage<T> {
  const ZhongyiPage({this.items = const [], this.total = 0, this.page = 1, this.pageSize = 20});

  final List<T> items;
  final int total;
  final int page;
  final int pageSize;

  bool get hasNext => page * pageSize < total;

  static ZhongyiPage<T> from<T>(Map<String, dynamic> data, T Function(Map<String, dynamic>) build) {
    final raw = data['records'] ?? data['items'] ?? data['list'];
    final items = zyMapList(raw).map(build).toList();
    final page = zyInt(data['page'] ?? data['page_no']) ?? 1;
    final pageSize = zyInt(data['pageSize'] ?? data['page_size']) ?? items.length;
    return ZhongyiPage<T>(
      items: items,
      total: zyInt(data['total']) ?? items.length,
      page: page,
      pageSize: pageSize <= 0 ? items.length : pageSize,
    );
  }
}

/// 药品主数据（对应 ZhongyiInventoryService.medicineToMap）。
class ZhongyiMedicine {
  const ZhongyiMedicine({
    required this.id,
    required this.medicineCode,
    required this.prefix,
    required this.name,
    required this.pinyin,
    required     this.category,
    this.subcategory,
    this.originPlace,
    this.properties = const {},
    this.functions,
    this.indications,
    this.commonDosageMin,
    this.commonDosageMax,
    this.dosageWarning,
    this.toxicity,
    this.pregnancyCategory,
    this.isSpecialManagement = false,
    this.storageRequirements,
    this.shelfLifeMonths,
    this.description,
    this.status = 0,
    this.retailSalePrice,
    this.retailSaleUnit,
    this.latestPurchasePrice,
    this.stockQuantityG = 0,
  });

  final int id;
  final String medicineCode;
  final String prefix;
  final String name;
  final String pinyin;
  final String category;
  final String? subcategory;
  final String? originPlace;

  /// 性味归经，后端存自由 JSON，App 约定 nature / flavor / meridians 三个键。
  final Map<String, dynamic> properties;
  final String? functions;
  final String? indications;
  final double? commonDosageMin;
  final double? commonDosageMax;
  final double? dosageWarning;
  final String? toxicity;
  final String? pregnancyCategory;
  final bool isSpecialManagement;
  final String? storageRequirements;
  final int? shelfLifeMonths;
  final String? description;
  final int status;

  /// 零售价、计价单位、上次进价与剩余库存由后端读取时现算，可能为 null。
  final double? retailSalePrice;
  final String? retailSaleUnit;
  final double? latestPurchasePrice;
  final double stockQuantityG;

  /// 展示名：炮制前缀 + 基名，与后端 medicineDisplayName 一致。
  String get fullName => '$prefix$name';

  /// 计价单位，未定价时回落成克。
  String get unit => zyText(retailSaleUnit) ?? 'g';

  double get salePrice => retailSalePrice ?? 0;

  double get purchasePrice => latestPurchasePrice ?? 0;

  /// 后端把 status == 1 视为可用（模板校验要求 1）。
  bool get enabled => status == 1;

  /// 四气，缺省为 null。
  String? get propertyNature => zyText(properties['nature']);

  /// 五味，缺省为空列表。
  List<String> get propertyFlavors => zyTextList(properties['flavor']);

  /// 归经，缺省为空列表。
  List<String> get propertyMeridians => zyTextList(properties['meridians']);

  factory ZhongyiMedicine.fromJson(Map<String, dynamic> json) => ZhongyiMedicine(
        id: zyIntOr(json['id']),
        medicineCode: zyTextOr(json['medicine_code']),
        prefix: zyTextOr(json['prefix']),
        name: zyTextOr(json['name']),
        pinyin: zyTextOr(json['pinyin']),
        category: zyTextOr(json['category']),
        subcategory: zyText(json['subcategory']),
        originPlace: zyText(json['origin_place']),
        properties: zyMap(json['properties']),
        functions: zyText(json['functions']),
        indications: zyText(json['indications']),
        commonDosageMin: zyDouble(json['common_dosage_min']),
        commonDosageMax: zyDouble(json['common_dosage_max']),
        dosageWarning: zyDouble(json['dosage_warning']),
        toxicity: zyText(json['toxicity']),
        pregnancyCategory: zyText(json['pregnancy_category']),
        isSpecialManagement: zyBoolOr(json['is_special_management']),
        storageRequirements: zyText(json['storage_requirements']),
        shelfLifeMonths: zyInt(json['shelf_life_months']),
        description: zyText(json['description']),
        status: zyIntOr(json['status']),
        retailSalePrice: zyDouble(json['retail_sale_price']),
        retailSaleUnit: zyText(json['retail_sale_unit']),
        latestPurchasePrice: zyDouble(json['latest_purchase_price']),
        stockQuantityG: zyDoubleOr(json['stock_quantity_g']),
      );
}

/// 药品价格记录（对应 ZhongyiInventoryService._priceToMap）。
class ZhongyiMedicinePrice {
  const ZhongyiMedicinePrice({
    required this.id,
    required this.priceType,
    required this.unit,
    required this.salePrice,
    this.priceStatus,
    this.effectiveFrom,
    this.effectiveTo,
  });

  final int id;
  final String priceType;
  final String unit;
  final double salePrice;
  final String? priceStatus;

  /// 生效区间，后端按生效时间取最新一条作为当前售价；区间未封闭即仍在生效。
  final String? effectiveFrom;
  final String? effectiveTo;

  bool get active => zyText(effectiveTo) == null;

  factory ZhongyiMedicinePrice.fromJson(Map<String, dynamic> json) => ZhongyiMedicinePrice(
        id: zyIntOr(json['id']),
        priceType: zyTextOr(json['price_type'], 'retail'),
        unit: zyTextOr(json['unit'], 'g'),
        salePrice: zyDoubleOr(json['sale_price']),
        priceStatus: zyText(json['price_status']),
        effectiveFrom: zyText(json['effective_from']),
        effectiveTo: zyText(json['effective_to']),
      );
}

/// 库存批次（对应 ZhongyiInventoryService.inventoryToMap）。
class ZhongyiInventoryBatch {
  const ZhongyiInventoryBatch({
    required this.id,
    required this.medicineId,
    required this.batchNumber,
    this.medicineName,
    this.quantityG = 0,
    this.unit = 'g',
    this.purchasePrice,
    this.productionDate,
    this.expiryDate,
    this.qualityStatus,
    this.storageLocation,
    this.isExhausted = false,
    this.description,
  });

  final int id;
  final int medicineId;
  final String batchNumber;
  final String? medicineName;
  final double quantityG;
  final String unit;
  final double? purchasePrice;
  final String? productionDate;
  final String? expiryDate;
  final String? qualityStatus;
  final String? storageLocation;
  final bool isExhausted;
  final String? description;

  factory ZhongyiInventoryBatch.fromJson(Map<String, dynamic> json) => ZhongyiInventoryBatch(
        id: zyIntOr(json['id']),
        medicineId: zyIntOr(json['medicine_id']),
        batchNumber: zyTextOr(json['batch_number']),
        medicineName: zyText(json['medicine_name']),
        quantityG: zyDoubleOr(json['quantity_g']),
        unit: zyTextOr(json['unit'], 'g'),
        purchasePrice: zyDouble(json['purchase_price']),
        productionDate: zyText(json['production_date']),
        expiryDate: zyText(json['expiry_date']),
        qualityStatus: zyText(json['quality_status']),
        storageLocation: zyText(json['storage_location']),
        isExhausted: zyBoolOr(json['is_exhausted']),
        description: zyText(json['description']),
      );
}

/// 患者档案摘要（对应 ZhongyiPatientService._toSummary）。
class ZhongyiPatient {
  const ZhongyiPatient({required this.id, required this.name, this.gender, this.birthDate, this.phone, this.source});

  final int id;
  final String name;
  final String? gender;
  final String? birthDate;
  final String? phone;
  final String? source;

  factory ZhongyiPatient.fromJson(Map<String, dynamic> json) => ZhongyiPatient(
        id: zyIntOr(json['id']),
        name: zyTextOr(json['name']),
        gender: zyText(json['gender']),
        birthDate: zyText(json['birth_date']),
        phone: zyText(json['phone']),
        source: zyText(json['source']),
      );
}

/// 处方模板药味（对应 ZhongyiPrescriptionTemplateService._itemToMap）。
class ZhongyiTemplateItem {
  const ZhongyiTemplateItem({
    required this.medicineId,
    this.id,
    this.sortOrder = 0,
    this.role,
    this.dosageGrams = 0,
    this.dosageUnit = 'g',
    this.dosageText,
    this.usageMethod,
    this.isSubstitute = false,
    this.notes,
  });

  final int? id;
  final int medicineId;
  final int sortOrder;
  final String? role;
  final double dosageGrams;
  final String dosageUnit;
  final String? dosageText;
  final String? usageMethod;
  final bool isSubstitute;
  final String? notes;

  Map<String, dynamic> toJson(int index) => {
        'medicine_id': medicineId,
        'sort_order': index,
        'dosage_grams': dosageGrams,
        'dosage_unit': dosageUnit,
        if (zyText(notes) != null) 'notes': notes,
      };

  factory ZhongyiTemplateItem.fromJson(Map<String, dynamic> json) => ZhongyiTemplateItem(
        id: zyInt(json['id']),
        medicineId: zyIntOr(json['medicine_id']),
        sortOrder: zyIntOr(json['sort_order']),
        role: zyText(json['role']),
        dosageGrams: zyDoubleOr(json['dosage_grams']),
        dosageUnit: zyTextOr(json['dosage_unit'], 'g'),
        dosageText: zyText(json['dosage_text']),
        usageMethod: zyText(json['usage_method']),
        isSubstitute: zyBoolOr(json['is_substitute']),
        notes: zyText(json['notes']),
      );
}

/// 处方模板（对应 ZhongyiPrescriptionTemplateService.templateToJsonMaps）。
class ZhongyiTemplate {
  const ZhongyiTemplate({
    required this.id,
    required this.name,
    this.scope = 'personal',
    this.category = 'herb_decoction',
    this.syndrome,
    this.efficacy,
    this.doses = 7,
    this.dailyFrequency,
    this.administrationMethod,
    this.decoctionInstruction,
    this.dietRestrictions,
    this.notes,
    this.isActive = true,
    this.canEdit = false,
    this.items = const [],
    this.updateTime,
  });

  final int id;
  final String name;
  final String scope;
  final String category;
  final String? syndrome;
  final String? efficacy;
  final int doses;
  final String? dailyFrequency;
  final String? administrationMethod;
  final String? decoctionInstruction;
  final String? dietRestrictions;
  final String? notes;
  final bool isActive;

  /// 后端按「协定模板只读；创建者本人或管理员可改」算好的权限位。
  final bool canEdit;
  final List<ZhongyiTemplateItem> items;
  final String? updateTime;

  factory ZhongyiTemplate.fromJson(Map<String, dynamic> json) => ZhongyiTemplate(
        id: zyIntOr(json['id']),
        name: zyTextOr(json['name']),
        scope: zyTextOr(json['scope'], 'personal'),
        category: zyTextOr(json['category'], 'herb_decoction'),
        syndrome: zyText(json['syndrome']),
        efficacy: zyText(json['efficacy']),
        doses: zyIntOr(json['doses'], 7),
        dailyFrequency: zyText(json['daily_frequency']),
        administrationMethod: zyText(json['administration_method']),
        decoctionInstruction: zyText(json['decoction_instruction']),
        dietRestrictions: zyText(json['diet_restrictions']),
        notes: zyText(json['notes']),
        isActive: zyBoolOr(json['is_active'], true),
        canEdit: zyBoolOr(json['can_edit']),
        items: zyMapList(json['items']).map(ZhongyiTemplateItem.fromJson).toList(),
        updateTime: zyText(json['update_time']),
      );
}

/// 账单明细（对应 ZhongyiBillingService._billingItemJson）。
class ZhongyiBillItem {
  const ZhongyiBillItem({
    required this.id,
    this.itemType,
    this.itemName = '',
    this.quantity = 0,
    this.unitPrice = 0,
    this.amount = 0,
    this.referenceType,
    this.referenceId,
    this.specification,
    this.unit,
  });

  final int id;
  final String? itemType;
  final String itemName;
  final int quantity;
  final double unitPrice;
  final double amount;
  final String? referenceType;
  final int? referenceId;
  final String? specification;
  final String? unit;

  factory ZhongyiBillItem.fromJson(Map<String, dynamic> json) => ZhongyiBillItem(
        id: zyIntOr(json['id']),
        itemType: zyText(json['item_type']),
        itemName: zyTextOr(json['item_name']),
        quantity: zyIntOr(json['quantity'], 1),
        unitPrice: zyDoubleOr(json['unit_price']),
        amount: zyDoubleOr(json['amount']),
        referenceType: zyText(json['reference_type']),
        referenceId: zyInt(json['reference_id']),
        specification: zyText(json['specification']),
        unit: zyText(json['unit']),
      );
}

/// 退款记录（对应 ZhongyiBillingService._refundJson）。后端 status 为数字。
class ZhongyiRefund {
  const ZhongyiRefund({
    required this.id,
    this.refundNo = '',
    this.refundAmount = 0,
    this.refundReason,
    this.status = 0,
    this.requestedAt,
    this.completedAt,
  });

  final int id;
  final String refundNo;
  final double refundAmount;
  final String? refundReason;
  final int status;
  final String? requestedAt;
  final String? completedAt;

  factory ZhongyiRefund.fromJson(Map<String, dynamic> json) => ZhongyiRefund(
        id: zyIntOr(json['id']),
        refundNo: zyTextOr(json['refund_no']),
        refundAmount: zyDoubleOr(json['refund_amount']),
        refundReason: zyText(json['refund_reason']),
        status: zyIntOr(json['status']),
        requestedAt: zyText(json['requested_at']),
        completedAt: zyText(json['completed_at']),
      );
}

/// 收费账单（对应 ZhongyiBillingService.billJson，明细与退款按需带上）。
class ZhongyiBill {
  const ZhongyiBill({
    required this.id,
    required this.billNo,
    required this.patientId,
    this.patientName,
    this.billingStage = 'treatment',
    this.totalAmount = 0,
    this.paidAmount = 0,
    this.refundedAmount = 0,
    this.paymentStatus = 'unpaid',
    this.status = 1,
    this.remark,
    this.createTime,
    this.items = const [],
    this.refunds = const [],
  });

  final int id;
  final String billNo;
  final int patientId;
  final String? patientName;
  final String billingStage;
  final double totalAmount;
  final double paidAmount;
  final double refundedAmount;
  final String paymentStatus;

  /// 后端账单 status：1 正常、0 已取消。
  final int status;
  final String? remark;
  final String? createTime;
  final List<ZhongyiBillItem> items;
  final List<ZhongyiRefund> refunds;

  double get payableAmount {
    final value = totalAmount - paidAmount;
    return value > 0 ? value : 0;
  }

  bool get cancelled => status == 0;

  /// 仅未支付且未取消的账单可以收款或作废，与后端 canPay/cancelBill 一致。
  bool get canPay =>
      !cancelled && paymentStatus != 'paid' && paymentStatus != 'refunding' && paymentStatus != 'refunded';

  bool get canCancel => !cancelled && paidAmount <= 0;

  String patientLabel() => zyText(patientName) ?? '患者$patientId';

  factory ZhongyiBill.fromJson(Map<String, dynamic> json) => ZhongyiBill(
        id: zyIntOr(json['id']),
        billNo: zyTextOr(json['bill_no']),
        patientId: zyIntOr(json['patient_id']),
        patientName: zyText(json['patient_name']),
        billingStage: zyTextOr(json['billing_stage'], 'treatment'),
        totalAmount: zyDoubleOr(json['total_amount']),
        paidAmount: zyDoubleOr(json['paid_amount']),
        refundedAmount: zyDoubleOr(json['refunded_amount']),
        paymentStatus: zyTextOr(json['payment_status'], 'unpaid'),
        status: zyIntOr(json['status'], 1),
        remark: zyText(json['remark'] ?? json['notes']),
        createTime: zyText(json['create_time'] ?? json['created_time']),
        items: zyMapList(json['items']).map(ZhongyiBillItem.fromJson).toList(),
        refunds: zyMapList(json['refunds']).map(ZhongyiRefund.fromJson).toList(),
      );
}
