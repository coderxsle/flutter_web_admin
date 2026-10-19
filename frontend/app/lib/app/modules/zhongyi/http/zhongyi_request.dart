import 'dart:convert';

import 'package:yun_men_yi_pan/app/utils/result_code.dart';
import 'package:dio/dio.dart';
import 'package:http_manager/http_manager.dart';

import '../model/zhongyi_model.dart';

/// 中医业务接口前缀，与 backend/flutter_web_server 的 zhongyi 路由表一一对应。
const String zhongyiApiBase = '/api/lxs_zhongyi';

/// 归一化后的接口结果：只关心成败、给用户看的文案和 data。
class ZhongyiResponse {
  const ZhongyiResponse({required this.success, this.message = '', this.data});

  final bool success;
  final String message;
  final dynamic data;

  Map<String, dynamic> get mapData => zyMap(data);

  List<Map<String, dynamic>> get listData => zyMapList(data);
}

/// 中医（中药房）REST 接口封装。
///
/// 统一走 http_manager（带 Authorization: Bearer），因此物流层与登录态完全共用；
/// 后端 PUT/DELETE 两种方法 http_manager 没有封装，这里直接用它的 dio 实例发，
/// 响应仍交回 [ResponseAnalyzed] 解析，保持一套解析规则。
class ZhongyiRequest {
  ZhongyiRequest._();

  // ===================== 药品 =====================

  static Future<ZhongyiResponse> medicineList({
    int pageNo = 1,
    int pageSize = 20,
    String? keyword,
    String? name,
    String? pinyin,
    String? category,
  }) =>
      _send(httpManager.getAnalyzing('$zhongyiApiBase/medicine/list',
          params: _query({
            'page_no': pageNo,
            'page_size': pageSize,
            'keyword': keyword,
            'name': name,
            'pinyin': pinyin,
            'category': category,
          })));

  static Future<ZhongyiResponse> medicineOptions({String? keyword, String? category}) =>
      _send(httpManager.getAnalyzing('$zhongyiApiBase/medicine/options',
          params: _query({
            'keyword': keyword,
            'category': category,
          })));

  static Future<ZhongyiResponse> medicineDetail(int id) =>
      _send(httpManager.getAnalyzing('$zhongyiApiBase/medicine/detail/$id'));

  static Future<ZhongyiResponse> createMedicine(Map<String, dynamic> body) =>
      _send(httpManager.postAnalyzing('$zhongyiApiBase/medicine/create', params: body));

  static Future<ZhongyiResponse> updateMedicine(int id, Map<String, dynamic> body) =>
      _send(_request('PUT', '$zhongyiApiBase/medicine/update/$id', body));

  static Future<ZhongyiResponse> deleteMedicines(List<int> ids) =>
      _send(_request('DELETE', '$zhongyiApiBase/medicine/delete', {'ids': ids}));

  static Future<ZhongyiResponse> medicinePrices(int medicineId) =>
      _send(httpManager.getAnalyzing('$zhongyiApiBase/medicine/$medicineId/prices'));

  /// 新增一条零售价，后端按生效时间取最新一条作为当前售价。
  static Future<ZhongyiResponse> createMedicinePrice(int medicineId,
          {required double salePrice, required String unit}) =>
      _send(httpManager.postAnalyzing('$zhongyiApiBase/medicine/$medicineId/prices', params: {
        'price_type': 'retail',
        'unit': unit,
        'sale_price': salePrice,
        'effective_from': _nowText(),
      }));

  // ===================== 炮制前缀 =====================

  /// 前缀字典由后端 data/zhongyi_prefixes.json 下发。
  static Future<ZhongyiResponse> medicinePrefixes() =>
      _send(httpManager.getAnalyzing('$zhongyiApiBase/medicine/prefixes'));

  static Future<ZhongyiResponse> createMedicinePrefix(String prefix, {String groupTitle = '自定义'}) =>
      _send(httpManager.postAnalyzing('$zhongyiApiBase/medicine/prefixes',
          params: {'prefix': prefix, 'group_title': groupTitle}));

  // ===================== 库存 =====================

  static Future<ZhongyiResponse> inventoryList({
    int pageNo = 1,
    int pageSize = 50,
    String? medicineKeyword,
    String? batchNumber,
    String? qualityStatus,
  }) =>
      _send(httpManager.getAnalyzing('$zhongyiApiBase/inventory/list',
          params: _query({
            'page_no': pageNo,
            'page_size': pageSize,
            'medicine_keyword': medicineKeyword,
            'batch_number': batchNumber,
            'quality_status': qualityStatus,
          })));

  static Future<ZhongyiResponse> stockIn(Map<String, dynamic> body) =>
      _send(httpManager.postAnalyzing('$zhongyiApiBase/inventory/stock-in', params: body));

  /// 调整批次数量，正增负减，后端按流水记账。
  static Future<ZhongyiResponse> adjustInventory({
    required int inventoryId,
    required double quantityChange,
    String? remark,
  }) =>
      _send(httpManager.postAnalyzing('$zhongyiApiBase/inventory/adjust', params: {
        'inventory_id': inventoryId,
        'quantity_change': quantityChange,
        'remark': remark,
      }));

  // ===================== 患者 =====================

  static Future<ZhongyiResponse> patientList({int pageNo = 1, int pageSize = 50, String? keyword}) =>
      _send(httpManager.getAnalyzing('$zhongyiApiBase/patient/list',
          params: _query({
            'page_no': pageNo,
            'page_size': pageSize,
            'keyword': keyword,
          })));

  static Future<ZhongyiResponse> createPatient({required String name, String? phone}) =>
      _send(httpManager.postAnalyzing('$zhongyiApiBase/patient/create',
          params: _query({
            'name': name,
            'phone': phone,
            'source': 'manual',
          })));

  // ===================== 处方模板 =====================

  static Future<ZhongyiResponse> templateList({int pageNo = 1, int pageSize = 20, String? name}) =>
      _send(httpManager.getAnalyzing('$zhongyiApiBase/prescription-template/list',
          params: _query({
            'page_no': pageNo,
            'page_size': pageSize,
            'name': name,
          })));

  static Future<ZhongyiResponse> templateDetail(int id) =>
      _send(httpManager.getAnalyzing('$zhongyiApiBase/prescription-template/detail/$id'));

  static Future<ZhongyiResponse> createTemplate(Map<String, dynamic> body) =>
      _send(httpManager.postAnalyzing('$zhongyiApiBase/prescription-template/create', params: body));

  static Future<ZhongyiResponse> updateTemplate(int id, Map<String, dynamic> body) =>
      _send(_request('PUT', '$zhongyiApiBase/prescription-template/update/$id', body));

  static Future<ZhongyiResponse> setTemplateStatus(int id, {required bool isActive}) => _send(
      httpManager.postAnalyzing('$zhongyiApiBase/prescription-template/$id/status', params: {'is_active': isActive}));

  static Future<ZhongyiResponse> deleteTemplates(List<int> ids) =>
      _send(httpManager.postAnalyzing('$zhongyiApiBase/prescription-template/delete', params: {'ids': ids}));

  // ===================== 收费账单 =====================

  static Future<ZhongyiResponse> billingList(
          {int pageNo = 1, int pageSize = 20, String? billNo, String? patientName}) =>
      _send(httpManager.getAnalyzing('$zhongyiApiBase/billing/list',
          params: _query({
            'page_no': pageNo,
            'page_size': pageSize,
            'bill_no': billNo,
            'patient_name': patientName,
          })));

  static Future<ZhongyiResponse> billingDetail(int id) =>
      _send(httpManager.getAnalyzing('$zhongyiApiBase/billing/detail/$id'));

  static Future<ZhongyiResponse> createBill({
    required int patientId,
    required String billingStage,
    required List<Map<String, dynamic>> items,
    String? remark,
  }) =>
      _send(httpManager.postAnalyzing('$zhongyiApiBase/billing/create',
          params: _query({
            'patient_id': patientId,
            'billing_stage': billingStage,
            'items': items,
            'remark': remark,
          })));

  static Future<ZhongyiResponse> payBill(int id, {required String channel, required double amount}) =>
      _send(httpManager.postAnalyzing('$zhongyiApiBase/billing/$id/pay', params: {
        'channel': channel,
        'amount': amount,
      }));

  static Future<ZhongyiResponse> cancelBill(int id) =>
      _send(httpManager.postAnalyzing('$zhongyiApiBase/billing/$id/cancel'));

  // ===================== 内部 =====================

  /// 丢掉 null / 空串，避免把「未填」当成查询条件传给后端。
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

  static Future<ResponseAnalyzed> _request(String method, String path, Map<String, dynamic> body) async {
    final options = Options(contentType: Headers.jsonContentType);
    final data = jsonEncode(body);
    final response = switch (method) {
      'PUT' => await httpManager.dio.put(path, data: data, options: options),
      'DELETE' => await httpManager.dio.delete(path, data: data, options: options),
      _ => await httpManager.dio.post(path, data: data, options: options),
    };
    return ResponseAnalyzed.analyzingAndCheckup(response);
  }

  static Future<ZhongyiResponse> _send(Future<ResponseAnalyzed> future) async {
    final result = _normalize(await future);
    if (result.code == ResultCode.success) {
      return ZhongyiResponse(success: true, message: result.message ?? '', data: result.data);
    }
    return ZhongyiResponse(success: false, message: _messageOf(result), data: result.data);
  }

  /// 后端失败信封只有 code/message（没有 data），http_manager 认不出来时会退化成
  /// HTTP 状态码，这里把 body 里的业务码读回来，再交给项目统一的响应检查入口。
  static ResponseAnalyzed _normalize(ResponseAnalyzed raw) {
    if (raw.code == ResultCode.success) return raw;
    final body = raw.data;
    if (body is! Map) return raw;
    final bodyCode = body['code']?.toString();
    if (bodyCode == null || bodyCode == raw.code) return raw;

    final fixed = ResponseAnalyzed(code: bodyCode, message: zyText(body['message']), data: body['data'] ?? body);
    ResponseAnalyzedExtension.checkAnalyzing(fixed);
    return fixed;
  }

  static String _messageOf(ResponseAnalyzed result) {
    final body = result.data;
    final fromBody = body is Map ? zyText(body['message']) : null;
    final message = fromBody ?? zyText(result.message);
    return message ?? '操作失败，请稍后重试';
  }
}
