import 'dart:convert';

import 'package:flutter_web_server/src/services/zhongyi/zhongyi_inventory_service.dart';
import 'package:flutter_web_server/src/services/zhongyi/zhongyi_permissions.dart';
import 'package:flutter_web_server/src/web/routes/api/delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 药品与库存核心接口，路径兼容 FastapiAdmin 的 /lxs_zhongyi REST 契约。
Map<String, ActionRoute> zhongyiMedicineInventoryRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    '/api/lxs_zhongyi/medicine/list': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      requireAuth: true,
      requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.medicineList],
      handler: (session, request) => ZhongyiInventoryService.listMedicines(
        session,
        page: request.queryInt('page') ?? 1,
        pageSize: request.queryInt('pageSize') ?? 20,
        keyword: request.queryString('keyword'),
        name: request.queryString('name'),
        medicineCode: request.queryString('medicineCode'),
        pinyin: request.queryString('pinyin'),
        category: request.queryString('category'),
        status: request.queryInt('status'),
      ),
    ),
    '/api/lxs_zhongyi/medicine/options': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      requireAuth: true,
      requiredPermissions: const [ZhongyiPermissions.module],
      handler: (session, request) => ZhongyiInventoryService.medicineOptions(
        session,
        keyword: request.queryString('keyword') ?? request.queryString('name'),
        category: request.queryString('category'),
      ),
    ),
    '/api/lxs_zhongyi/medicine/detail/:id': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      requireAuth: true,
      requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.medicineList],
      handler: (session, request) async =>
          ensureOk(await ZhongyiInventoryService.medicineDetail(session, request.pathId())),
    ),
    '/api/lxs_zhongyi/medicine/create': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      requireAuth: true,
      requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.medicineCreate],
      successStatus: 201,
      handler: (session, request) async =>
          ensureOk(await ZhongyiInventoryService.createMedicine(session, await request.jsonObjectBody())),
    ),
    '/api/lxs_zhongyi/medicine/update/:id': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      requireAuth: true,
      requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.medicineUpdate],
      handler: (session, request) async => ensureOk(
        await ZhongyiInventoryService.updateMedicine(session, request.pathId(), await request.jsonObjectBody()),
      ),
    ),
    '/api/lxs_zhongyi/medicine/delete': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      requireAuth: true,
      requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.medicineDelete],
      handler: (session, request) async =>
          ensureOk(await ZhongyiInventoryService.deleteMedicines(session, await _idsBody(request))),
    ),
    '/api/lxs_zhongyi/medicine/:id/prices': ActionRoute.byMethod(
      envelope: envelope,
      requireAuth: true,
      requiredPermissions: const [ZhongyiPermissions.module],
      permissions: {
        Method.get: const [ZhongyiPermissions.module, ZhongyiPermissions.medicineList],
        Method.post: const [ZhongyiPermissions.module, ZhongyiPermissions.medicineUpdate],
      },
      handlers: {
        Method.get: (session, request) async =>
            ensureOk(await ZhongyiInventoryService.medicinePriceList(session, request.pathId())),
        Method.post: (session, request) async => ensureOk(
          await ZhongyiInventoryService.createMedicinePrice(session, request.pathId(), await request.jsonObjectBody()),
        ),
      },
    ),
    '/api/lxs_zhongyi/inventory/list': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      requireAuth: true,
      requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.inventoryList],
      handler: (session, request) => ZhongyiInventoryService.listInventory(
        session,
        page: request.queryInt('page') ?? 1,
        pageSize: request.queryInt('pageSize') ?? 20,
        medicineKeyword: request.queryString('medicineKeyword'),
        batchNumber: request.queryString('batchNumber'),
        qualityStatus: request.queryString('qualityStatus'),
        expiryDateStart: _queryDate(request, 'expiryDateStart'),
        expiryDateEnd: _queryDate(request, 'expiryDateEnd'),
      ),
    ),
    '/api/lxs_zhongyi/inventory/detail/:id': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      requireAuth: true,
      requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.inventoryList],
      handler: (session, request) async =>
          ensureOk(await ZhongyiInventoryService.inventoryDetail(session, request.pathId())),
    ),
    '/api/lxs_zhongyi/inventory/stock-in': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      requireAuth: true,
      requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.inventoryStockIn],
      successStatus: 201,
      handler: (session, request) async =>
          ensureOk(await ZhongyiInventoryService.stockIn(session, await request.jsonObjectBody())),
    ),
    '/api/lxs_zhongyi/inventory/adjust': ActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      requireAuth: true,
      requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.inventoryAdjust],
      handler: (session, request) async =>
          ensureOk(await ZhongyiInventoryService.adjustInventory(session, await request.jsonObjectBody())),
    ),
    '/api/lxs_zhongyi/inventory/transaction/list': ActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      requireAuth: true,
      requiredPermissions: const [ZhongyiPermissions.module, ZhongyiPermissions.inventoryList],
      handler: (session, request) => ZhongyiInventoryService.inventoryTransactions(
        session,
        page: request.queryInt('page') ?? 1,
        pageSize: request.queryInt('pageSize') ?? 20,
        medicineId: request.queryInt('medicineId'),
        transactionType: request.queryString('transactionType'),
        dateStart: _queryDate(request, 'dateStart'),
        dateEnd: _queryDate(request, 'dateEnd'),
      ),
    ),
  };
}

DateTime? _queryDate(Request request, String key) {
  final value = request.queryString(key);
  if (value == null) return null;
  final parsed = DateTime.tryParse(value);
  if (parsed == null) throw RestException.badRequest('查询参数 $key 必须是合法日期');
  return parsed;
}

Future<List<int>> _idsBody(Request request) async {
  final raw = await request.readAsString();
  dynamic decoded;
  try {
    decoded = jsonDecode(raw);
  } on FormatException catch (error) {
    throw RestException.badRequest('请求体不是合法 JSON：${error.message}');
  }
  final rawIds = switch (decoded) {
    final List<dynamic> values => values,
    final Map values => values['ids'] ?? values['id'],
    _ => null,
  };
  final ids = switch (rawIds) {
    final List<dynamic> values => values.map(_positiveInt).whereType<int>().toSet().toList(),
    final Object single => [_positiveInt(single)].whereType<int>().toList(),
    _ => const <int>[],
  };
  if (ids.isEmpty) throw const RestException.badRequest('ids 必须包含至少一个正整数');
  return ids;
}

int? _positiveInt(Object? value) {
  final parsed = switch (value) {
    final num number when number.isFinite && number % 1 == 0 => number.toInt(),
    final String text => int.tryParse(text.trim()),
    _ => null,
  };
  return parsed != null && parsed > 0 ? parsed : null;
}
