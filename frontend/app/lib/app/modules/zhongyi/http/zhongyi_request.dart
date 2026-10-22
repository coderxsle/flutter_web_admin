import 'package:http_manager/http_manager.dart';

/// 中医（中药房）接口，与 backend/flutter_web_server 的 zhongyi 路由一一对应。
///
/// 全项目只用 GET / POST：查询走 getAnalyzing，其余（含更新、删除）走 postAnalyzing。
class ZhongyiRequest {
  static const String base = '/api/lxs_zhongyi';

  // ===================== 药品 =====================

  /// 药品分页列表
  static Future<ResponseAnalyzed> medicineList({
    int page = 1,
    int pageSize = 20,
    String? keyword,
    String? name,
    String? pinyin,
    String? category,
  }) async {
    const url = '$base/medicine/list';
    return await httpManager.getAnalyzing(url, params: _query({
      'page': page,
      'pageSize': pageSize,
      'keyword': keyword,
      'name': name,
      'pinyin': pinyin,
      'category': category,
    }));
  }

  /// 药品下拉选项
  static Future<ResponseAnalyzed> medicineOptions({String? keyword, String? category}) async {
    const url = '$base/medicine/options';
    return await httpManager.getAnalyzing(url, params: _query({
      'keyword': keyword,
      'category': category,
    }));
  }

  /// 药品详情
  static Future<ResponseAnalyzed> medicineDetail(int id) async {
    final url = '$base/medicine/detail/$id';
    return await httpManager.getAnalyzing(url);
  }

  /// 新增药品
  static Future<ResponseAnalyzed> createMedicine(Map<String, dynamic> body) async {
    const url = '$base/medicine/create';
    return await httpManager.postAnalyzing(url, params: body);
  }

  /// 修改药品
  static Future<ResponseAnalyzed> updateMedicine(int id, Map<String, dynamic> body) async {
    final url = '$base/medicine/update/$id';
    return await httpManager.postAnalyzing(url, params: body);
  }

  /// 删除药品（批量，伪删除）
  static Future<ResponseAnalyzed> deleteMedicines(List<int> ids) async {
    const url = '$base/medicine/delete';
    return await httpManager.postAnalyzing(url, params: {'ids': ids});
  }

  /// 药品零售价记录
  static Future<ResponseAnalyzed> medicinePrices(int medicineId) async {
    final url = '$base/medicine/$medicineId/prices';
    return await httpManager.getAnalyzing(url);
  }

  /// 新增零售价，后端按生效时间取最新一条作为当前售价
  static Future<ResponseAnalyzed> createMedicinePrice(int medicineId,
      {required double salePrice, required String unit}) async {
    final url = '$base/medicine/$medicineId/prices';
    return await httpManager.postAnalyzing(url, params: {
      'priceType': 'retail',
      'unit': unit,
      'salePrice': salePrice,
      'effectiveFrom': _nowText(),
    });
  }

  // ===================== 炮制前缀 =====================

  /// 前缀字典，由后端 data/zhongyi_prefixes.json 下发
  static Future<ResponseAnalyzed> medicinePrefixes() async {
    const url = '$base/medicine/prefixes';
    return await httpManager.getAnalyzing(url);
  }

  /// 新增炮制前缀
  static Future<ResponseAnalyzed> createMedicinePrefix(String prefix, {String groupTitle = '自定义'}) async {
    const url = '$base/medicine/prefixes';
    return await httpManager.postAnalyzing(url, params: {'prefix': prefix, 'groupTitle': groupTitle});
  }

  // ===================== 库存 =====================

  /// 库存批次分页列表
  static Future<ResponseAnalyzed> inventoryList({
    int page = 1,
    int pageSize = 50,
    String? medicineKeyword,
    String? batchNumber,
    String? qualityStatus,
  }) async {
    const url = '$base/inventory/list';
    return await httpManager.getAnalyzing(url, params: _query({
      'page': page,
      'pageSize': pageSize,
      'medicineKeyword': medicineKeyword,
      'batchNumber': batchNumber,
      'qualityStatus': qualityStatus,
    }));
  }

  /// 入库
  static Future<ResponseAnalyzed> stockIn(Map<String, dynamic> body) async {
    const url = '$base/inventory/stock-in';
    return await httpManager.postAnalyzing(url, params: body);
  }

  /// 调整批次数量，正增负减，后端按流水记账
  static Future<ResponseAnalyzed> adjustInventory({
    required int inventoryId,
    required double quantityChange,
    String? remark,
  }) async {
    const url = '$base/inventory/adjust';
    return await httpManager.postAnalyzing(url, params: {
      'inventoryId': inventoryId,
      'quantityChange': quantityChange,
      'remark': remark,
    });
  }

  // ===================== 患者 =====================

  /// 患者分页列表
  static Future<ResponseAnalyzed> patientList({int page = 1, int pageSize = 50, String? keyword}) async {
    const url = '$base/patient/list';
    return await httpManager.getAnalyzing(url, params: _query({
      'page': page,
      'pageSize': pageSize,
      'keyword': keyword,
    }));
  }

  /// 新建患者
  static Future<ResponseAnalyzed> createPatient({required String name, String? phone}) async {
    const url = '$base/patient/create';
    return await httpManager.postAnalyzing(url, params: _query({
      'name': name,
      'phone': phone,
      'source': 'manual',
    }));
  }

  // ===================== 处方模板 =====================

  /// 模板分页列表
  static Future<ResponseAnalyzed> templateList({int page = 1, int pageSize = 20, String? name}) async {
    const url = '$base/prescription-template/list';
    return await httpManager.getAnalyzing(url, params: _query({
      'page': page,
      'pageSize': pageSize,
      'name': name,
    }));
  }

  /// 模板详情
  static Future<ResponseAnalyzed> templateDetail(int id) async {
    final url = '$base/prescription-template/detail/$id';
    return await httpManager.getAnalyzing(url);
  }

  /// 新建模板
  static Future<ResponseAnalyzed> createTemplate(Map<String, dynamic> body) async {
    const url = '$base/prescription-template/create';
    return await httpManager.postAnalyzing(url, params: body);
  }

  /// 修改模板
  static Future<ResponseAnalyzed> updateTemplate(int id, Map<String, dynamic> body) async {
    final url = '$base/prescription-template/update/$id';
    return await httpManager.postAnalyzing(url, params: body);
  }

  /// 启用 / 停用模板
  static Future<ResponseAnalyzed> setTemplateStatus(int id, {required bool isActive}) async {
    final url = '$base/prescription-template/$id/status';
    return await httpManager.postAnalyzing(url, params: {'isActive': isActive});
  }

  /// 删除模板（批量，伪删除）
  static Future<ResponseAnalyzed> deleteTemplates(List<int> ids) async {
    const url = '$base/prescription-template/delete';
    return await httpManager.postAnalyzing(url, params: {'ids': ids});
  }

  // ===================== 收费账单 =====================

  /// 账单分页列表
  static Future<ResponseAnalyzed> billingList(
      {int page = 1, int pageSize = 20, String? billNo, String? patientName}) async {
    const url = '$base/billing/list';
    return await httpManager.getAnalyzing(url, params: _query({
      'page': page,
      'pageSize': pageSize,
      'billNo': billNo,
      'patientName': patientName,
    }));
  }

  /// 账单详情
  static Future<ResponseAnalyzed> billingDetail(int id) async {
    final url = '$base/billing/detail/$id';
    return await httpManager.getAnalyzing(url);
  }

  /// 开单
  static Future<ResponseAnalyzed> createBill({
    required int patientId,
    required String billingStage,
    required List<Map<String, dynamic>> items,
    String? remark,
  }) async {
    const url = '$base/billing/create';
    return await httpManager.postAnalyzing(url, params: _query({
      'patientId': patientId,
      'billingStage': billingStage,
      'items': items,
      'remark': remark,
    }));
  }

  /// 收款
  static Future<ResponseAnalyzed> payBill(int id, {required String channel, required double amount}) async {
    final url = '$base/billing/$id/pay';
    return await httpManager.postAnalyzing(url, params: {
      'channel': channel,
      'amount': amount,
    });
  }

  /// 取消账单
  static Future<ResponseAnalyzed> cancelBill(int id) async {
    final url = '$base/billing/$id/cancel';
    return await httpManager.postAnalyzing(url);
  }

  /// 删除账单（批量，伪删除）
  static Future<ResponseAnalyzed> deleteBills(List<int> ids) async {
    const url = '$base/billing/delete';
    return await httpManager.postAnalyzing(url, params: {'ids': ids});
  }

  // ===================== 内部 =====================

  /// 丢掉 null / 空串，避免把「未填」当成查询条件传给后端
  static Map<String, dynamic> _query(Map<String, dynamic> source) {
    final result = <String, dynamic>{};
    source.forEach((key, value) {
      if (value == null) return;
      if (value is String && value.trim().isEmpty) return;
      result[key] = value;
    });
    return result;
  }

  static String _nowText() {
    final now = DateTime.now();
    String p2(int value) => value.toString().padLeft(2, '0');
    return '${now.year}-${p2(now.month)}-${p2(now.day)} ${p2(now.hour)}:${p2(now.minute)}:${p2(now.second)}';
  }
}
