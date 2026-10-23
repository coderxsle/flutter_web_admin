import 'dart:convert';

import 'package:flutter_web_server/src/common/common.dart';
import 'package:flutter_web_server/src/services/zhongyi/zhongyi_audit.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 药品主数据、价格历史及库存批次服务。
///
/// 药品的售价、剩余库存与上次进价在读取时现算，不落冗余列。
class ZhongyiInventoryService {
  ZhongyiInventoryService._();

  static const int _defaultPageSize = 20;
  static const int _maximumPageSize = 200;

  /// 选项接口一次最多返回的药品数；超过这个量的诊所需要改成分页，别再加。
  static const int _optionsLimit = 500;

  static const List<String> _medicineFields = [
    'medicineCode',
    'prefix',
    'name',
    'pinyin',
    'category',
    'subcategory',
    'originPlace',
    'properties',
    'functions',
    'indications',
    'commonDosageMin',
    'commonDosageMax',
    'dosageWarning',
    'toxicity',
    'pregnancyCategory',
    'isSpecialManagement',
    'storageRequirements',
    'shelfLifeMonths',
    'description',
    'status',
  ];

  /// 平台切换租户优先，其次是登录 token 中的租户 scope。
  static int tenantIdOf(Session session) {
    final targetTenantId = session.targetTenantId;
    if (targetTenantId != null && targetTenantId > 0) return targetTenantId;
    return session.tenantId;
  }

  static bool _isAuthenticated(Session session) => session.authenticated != null;

  static String? _actor(Session session) => session.authenticated?.userIdentifier;

  static int? _actorId(Session session) => int.tryParse(_actor(session) ?? '');

  /// 校验入库量。
  static double validateStockInQuantity(Object? value) {
    final quantity = _number(value);
    if (quantity == null || !quantity.isFinite || quantity <= 0) {
      throw ArgumentError('入库数量必须是有限正数');
    }
    return quantity;
  }

  /// 校验药品价格，零价允许用于未定价药品。
  static double validateMedicinePrice(Object? value) {
    final price = _number(value);
    if (price == null || !price.isFinite || price < 0) {
      throw ArgumentError('价格必须是有限非负数');
    }
    return price;
  }

  /// 校验库存变更并返回变更后的数量。
  static double stockAfterChange({required num current, required num change}) {
    final before = current.toDouble();
    final delta = change.toDouble();
    final after = before + delta;
    if (!before.isFinite || before < 0 || !delta.isFinite || delta == 0 || !after.isFinite || after < 0) {
      throw ArgumentError('库存变化不合法或库存不足');
    }
    return after;
  }

  /// 药品输出使用 FastapiAdmin 的 snake_case 字段，不暴露租户及删除标记。
  static Map<String, dynamic> medicineToMap(ZhongyiMedicine medicine) => {
    'id': medicine.id,
    'medicineCode': medicine.medicineCode,
    'prefix': medicine.prefix ?? '',
    'name': medicine.name,
    'pinyin': medicine.pinyin ?? '',
    'category': medicine.category,
    'subcategory': medicine.subcategory,
    'originPlace': medicine.originPlace,
    'properties': _decodeProperties(medicine.propertiesJson),
    'functions': medicine.functions,
    'indications': medicine.indications,
    'commonDosageMin': medicine.commonDosageMin,
    'commonDosageMax': medicine.commonDosageMax,
    'dosageWarning': medicine.dosageWarning,
    'toxicity': medicine.toxicity,
    'pregnancyCategory': medicine.pregnancyCategory,
    'isSpecialManagement': medicine.isSpecialManagement,
    'storageRequirements': medicine.storageRequirements,
    'shelfLifeMonths': medicine.shelfLifeMonths,
    'description': medicine.description,
    'status': medicine.status,
    'createdTime': medicine.createTime,
    'updatedTime': medicine.updateTime,
  };

  /// 售价、剩余库存与上次进价：与 FastapiAdmin 一致，读取时从价格表和库存批次现算，不落冗余列。
  static Future<void> hydrateMedicineSummary(
    Session session,
    List<Map<String, dynamic>> items, {
    Transaction? transaction,
  }) async {
    final medicineIds = items.map((item) => item['id']).whereType<int>().toSet();
    if (medicineIds.isEmpty) return;
    final now = DateTime.now();

    final prices = await ZhongyiMedicinePrice.db.find(
      session,
      where: (t) =>
          t.medicineId.inSet(medicineIds) &
          t.deleted.equals(false) &
          t.priceType.equals('retail') &
          (t.effectiveFrom <= now),
      orderByList: (t) => [t.medicineId.asc(), t.effectiveFrom.desc(), t.id.desc()],
      transaction: transaction,
    );
    final latestPrice = <int, ZhongyiMedicinePrice>{};
    for (final price in prices) {
      final effectiveTo = price.effectiveTo;
      if (effectiveTo == null || !effectiveTo.isBefore(now)) latestPrice.putIfAbsent(price.medicineId, () => price);
    }

    final batches = await ZhongyiMedicineInventory.db.find(
      session,
      where: (t) => t.medicineId.inSet(medicineIds) & t.deleted.equals(false),
      orderByList: (t) => [t.medicineId.asc(), t.updateTime.desc(), t.id.desc()],
      transaction: transaction,
    );
    final stockByMedicine = <int, double>{};
    final purchaseByMedicine = <int, double>{};
    for (final batch in batches) {
      if (!batch.isExhausted && batch.qualityStatus == 'qualified') {
        stockByMedicine[batch.medicineId] = (stockByMedicine[batch.medicineId] ?? 0) + batch.quantityG;
      }
      final purchasePrice = batch.purchasePrice;
      if (purchasePrice != null) purchaseByMedicine.putIfAbsent(batch.medicineId, () => purchasePrice);
    }

    for (final item in items) {
      final id = item['id'];
      if (id is! int) continue;
      final price = latestPrice[id];
      item['retailSalePrice'] = price?.salePrice;
      item['retailSaleUnit'] = price?.unit;
      item['latestPurchasePrice'] = purchaseByMedicine[id];
      item['stockQuantityG'] = stockByMedicine[id] ?? 0;
    }
  }

  /// 药品展示名：前缀 + 基名。
  static String medicineDisplayName(ZhongyiMedicine medicine) => '${medicine.prefix ?? ''}${medicine.name}';

  /// 库存批次输出，字段与 FastapiAdmin 的 InventoryOutSchema 对齐。
  static Map<String, dynamic> inventoryToMap(ZhongyiMedicineInventory inventory, {String? medicineName}) => {
    'id': inventory.id,
    'medicineId': inventory.medicineId,
    'medicineName': medicineName,
    'batchNumber': inventory.batchNumber,
    'supplierId': inventory.supplierId,
    'quantityG': inventory.quantityG,
    'unit': inventory.unit,
    'purchasePrice': inventory.purchasePrice,
    'productionDate': inventory.productionDate,
    'expiryDate': inventory.expiryDate,
    'qualityStatus': inventory.qualityStatus,
    'storageLocation': inventory.storageLocation,
    'isExhausted': inventory.isExhausted,
    'description': inventory.description,
    'status': inventory.status,
    'createdTime': inventory.createTime,
    'updatedTime': inventory.updateTime,
  };

  /// 库存流水输出。
  static Map<String, dynamic> transactionToMap(ZhongyiInventoryTransaction transaction) => {
    'id': transaction.id,
    'medicineId': transaction.medicineId,
    'inventoryId': transaction.inventoryId,
    'batchNumber': transaction.batchNumber,
    'transactionType': transaction.transactionType,
    'quantityChange': transaction.quantityChangeG,
    'quantityBefore': transaction.quantityBeforeG,
    'quantityAfter': transaction.quantityAfterG,
    'remark': transaction.remark,
    'operatorId': transaction.operatorId,
    'transactionTime': transaction.createTime,
  };

  /// 按关键字、分类和状态分页查询药品。
  static Future<CommonResponse> listMedicines(
    Session session, {
    int page = 1,
    int pageSize = _defaultPageSize,
    String? keyword,
    String? name,
    String? medicineCode,
    String? pinyin,
    String? category,
    int? status,
  }) async {
    if (!_isAuthenticated(session)) return CommonResponse.unauthorized();
    try {
      final tenantId = tenantIdOf(session);
      final safePage = _safePage(page);
      final safePageSize = _safePageSize(pageSize);
      final trimmedKeyword = _trimmed(keyword);
      final trimmedName = _trimmed(name);
      final trimmedCode = _trimmed(medicineCode);
      final trimmedPinyin = _trimmed(pinyin);
      final trimmedCategory = _trimmed(category);
      Expression where(ZhongyiMedicineTable t) {
        var filter = t.tenantId.equals(tenantId) & t.deleted.equals(false);
        if (trimmedKeyword != null) {
          final pattern = '%$trimmedKeyword%';
          filter = filter &
              (t.name.like(pattern) |
                  t.prefix.like(pattern) |
                  t.medicineCode.like(pattern) |
                  t.pinyin.like(pattern));
        }
        if (trimmedName != null) filter = filter & t.name.like('%$trimmedName%');
        if (trimmedCode != null) filter = filter & t.medicineCode.like('%$trimmedCode%');
        if (trimmedPinyin != null) filter = filter & t.pinyin.like('%$trimmedPinyin%');
        if (trimmedCategory != null) filter = filter & t.category.equals(trimmedCategory);
        if (status != null) filter = filter & t.status.equals(status);
        return filter;
      }

      final rows = await ZhongyiMedicine.db.find(
        session,
        where: where,
        limit: safePageSize,
        offset: (safePage - 1) * safePageSize,
        orderByList: (t) => [t.pinyin.asc(), t.prefix.asc(), t.name.asc(), t.id.asc()],
      );
      final total = await ZhongyiMedicine.db.count(session, where: where);
      final items = rows.map(medicineToMap).toList();
      await hydrateMedicineSummary(session, items);
      return PageResponse.restPage(data: items, page: safePage, pageSize: safePageSize, total: total);
    } catch (_) {
      return PageResponse.failed('查询药品列表失败');
    }
  }

  /// 获取供处方和库存表单使用的药品选项。
  ///
  /// 列表和选择器只用展示字段，所以单独走一条聚合 SQL：一次往返取回药品、最新零售价
  /// 与余量/最近进价，避免把整行药品连同全部价格历史、全部批次搬回来再在内存里聚合。
  static Future<CommonResponse> medicineOptions(Session session, {String? keyword, String? category}) async {
    if (!_isAuthenticated(session)) return CommonResponse.unauthorized();
    try {
      final search = _trimmed(keyword);
      final trimmedCategory = _trimmed(category);

      final conditions = StringBuffer('m."tenantId" = @tenantId AND m.deleted = false');
      final parameters = <String, Object?>{
        'tenantId': tenantIdOf(session),
        'now': DateTime.now(),
        'limit': _optionsLimit,
      };
      if (search != null) {
        conditions.write(
          ' AND (m.name LIKE @keyword OR m.prefix LIKE @keyword'
          ' OR m."medicineCode" LIKE @keyword OR m.pinyin LIKE @keyword)',
        );
        parameters['keyword'] = '%$search%';
      }
      if (trimmedCategory != null) {
        conditions.write(' AND m.category = @category');
        parameters['category'] = trimmedCategory;
      }

      final result = await session.db.unsafeQuery(
        '''
SELECT m.id, m.prefix, m.name, m.pinyin, m.category,
       m."originPlace" AS origin_place, m.status,
       p."salePrice" AS retail_sale_price, p.unit AS retail_sale_unit,
       s.stock_quantity_g, s.latest_purchase_price
FROM zhongyi_medicine m
LEFT JOIN LATERAL (
  SELECT pr."salePrice", pr.unit
  FROM zhongyi_medicine_price pr
  WHERE pr."medicineId" = m.id
    AND pr."tenantId" = m."tenantId"
    AND pr.deleted = false
    AND pr."priceType" = 'retail'
    AND pr."effectiveFrom" <= @now
    AND (pr."effectiveTo" IS NULL OR pr."effectiveTo" >= @now)
  ORDER BY pr."effectiveFrom" DESC, pr.id DESC
  LIMIT 1
) p ON true
LEFT JOIN LATERAL (
  SELECT COALESCE(SUM(i."quantityG") FILTER (
           WHERE i."isExhausted" = false AND i."qualityStatus" = 'qualified'
         ), 0) AS stock_quantity_g,
         (ARRAY_AGG(i."purchasePrice" ORDER BY i."updateTime" DESC, i.id DESC)
           FILTER (WHERE i."purchasePrice" IS NOT NULL))[1] AS latest_purchase_price
  FROM zhongyi_medicine_inventory i
  WHERE i."medicineId" = m.id AND i.deleted = false
) s ON true
WHERE $conditions
ORDER BY m.pinyin, m.prefix, m.name, m.id
LIMIT @limit
''',
        parameters: QueryParameters.named(parameters),
      );
      return CommonResponse.success([for (final row in result) medicineOptionRow(row.toColumnMap())]);
    } catch (_) {
      return CommonResponse.failed('获取药品选项失败');
    }
  }

  /// 选项行转成前端字段；缺的字段前端会走默认值，所以这里只回展示需要的。
  static Map<String, dynamic> medicineOptionRow(Map<String, dynamic> row) => {
    'id': row['id'],
    'prefix': row['prefix'] ?? '',
    'name': row['name'] ?? '',
    'pinyin': row['pinyin'] ?? '',
    'category': row['category'] ?? '',
    'originPlace': row['origin_place'],
    'status': row['status'] ?? 1,
    'retailSalePrice': _number(row['retail_sale_price']),
    'retailSaleUnit': row['retail_sale_unit'],
    'stockQuantityG': _number(row['stock_quantity_g']) ?? 0,
    'latestPurchasePrice': _number(row['latest_purchase_price']),
  };

  /// 药品详情。
  static Future<CommonResponse> medicineDetail(Session session, int id) async {
    if (!_isAuthenticated(session)) return CommonResponse.unauthorized();
    if (id <= 0) return CommonResponse.validateFailed('药品ID不合法');
    try {
      final medicine = await _findMedicine(session, id);
      if (medicine == null) return CommonResponse.failed('药品不存在或已删除');
      final items = [medicineToMap(medicine)];
      await hydrateMedicineSummary(session, items);
      return CommonResponse.success(items.first);
    } catch (_) {
      return CommonResponse.failed('获取药品详情失败');
    }
  }

  /// 创建药品。
  static Future<CommonResponse> createMedicine(Session session, Map<String, dynamic> body) async {
    if (!_isAuthenticated(session)) return CommonResponse.unauthorized();
    late final Map<String, dynamic> fields;
    try {
      fields = _parseMedicineFields(body);
    } on ArgumentError catch (error) {
      return CommonResponse.validateFailed(error.message?.toString());
    }

    try {
      final tenantId = tenantIdOf(session);
      final medicineCode = fields['medicineCode'] as String;
      final duplicate = await ZhongyiMedicine.db.findFirstRow(
        session,
        where: (t) => t.tenantId.equals(tenantId) & t.medicineCode.equals(medicineCode),
      );
      if (duplicate != null) return CommonResponse.failed('药品编码已存在');

      final actor = _actor(session);
      final now = DateTime.now();
      final created = await ZhongyiMedicine.db.insertRow(
        session,
        ZhongyiMedicine(
          tenantId: tenantId,
          medicineCode: medicineCode,
          prefix: fields['prefix'] as String?,
          name: fields['name'] as String,
          pinyin: fields['pinyin'] as String?,
          category: fields['category'] as String,
          subcategory: fields['subcategory'] as String?,
          originPlace: fields['originPlace'] as String?,
          propertiesJson: fields['propertiesJson'] as String?,
          functions: fields['functions'] as String?,
          indications: fields['indications'] as String?,
          commonDosageMin: fields['commonDosageMin'] as double?,
          commonDosageMax: fields['commonDosageMax'] as double?,
          dosageWarning: fields['dosageWarning'] as double?,
          toxicity: fields['toxicity'] as String?,
          pregnancyCategory: fields['pregnancyCategory'] as String?,
          isSpecialManagement: fields['isSpecialManagement'] as bool,
          storageRequirements: fields['storageRequirements'] as String?,
          shelfLifeMonths: fields['shelfLifeMonths'] as int?,
          description: fields['description'] as String?,
          status: fields['status'] as int,
          creator: actor,
          updater: actor,
          createTime: now,
          updateTime: now,
        ),
      );
      final payload = medicineToMap(created);
      await ZhongyiAudit.record(
        session,
        type: ZhongyiAudit.typeMedicine,
        action: 'create',
        bizId: created.id!,
        after: payload,
      );
      return CommonResponse.success(payload, '创建药品成功');
    } catch (_) {
      return CommonResponse.failed('创建药品失败，请检查药品编码是否重复');
    }
  }

  /// 更新药品，未出现在请求体的字段保留原值。
  static Future<CommonResponse> updateMedicine(Session session, int id, Map<String, dynamic> body) async {
    if (!_isAuthenticated(session)) return CommonResponse.unauthorized();
    if (id <= 0) return CommonResponse.validateFailed('药品ID不合法');
    try {
      final tenantId = tenantIdOf(session);
      final now = DateTime.now();
      ZhongyiMedicine? updated;
      Map<String, dynamic>? before;
      String? failure;
      // 行锁必须在事务内；查重和写入同事务，锁才有意义。
      await session.db.transaction((transaction) async {
        final existing = await _findMedicine(session, id, transaction: transaction, lockMode: LockMode.forUpdate);
        if (existing == null) {
          failure = '药品不存在或已删除';
          return;
        }
        before = medicineToMap(existing);

        final fields = _parseMedicineFields(body, existing: existing);
        final medicineCode = fields['medicineCode'] as String;
        final duplicate = await ZhongyiMedicine.db.findFirstRow(
          session,
          where: (t) => t.tenantId.equals(tenantId) & t.medicineCode.equals(medicineCode) & t.id.notEquals(id),
          transaction: transaction,
        );
        if (duplicate != null) {
          failure = '药品编码已存在';
          return;
        }

        final updatedRows = await ZhongyiMedicine.db.updateWhere(
          session,
          where: (t) => t.id.equals(id) & t.tenantId.equals(tenantId) & t.deleted.equals(false),
          columnValues: (t) => _medicineColumns(t, fields, session, now),
          transaction: transaction,
        );
        if (updatedRows.isEmpty) {
          failure = '药品不存在或已删除';
          return;
        }
        updated = updatedRows.first;
      });
      final result = updated;
      if (result == null) return CommonResponse.failed(failure ?? '更新药品失败');
      final payload = medicineToMap(result);
      await ZhongyiAudit.record(
        session,
        type: ZhongyiAudit.typeMedicine,
        action: 'update',
        bizId: id,
        before: before,
        after: payload,
        detail: {'changedFields': ZhongyiAudit.changedFields(body, _medicineFields)},
      );
      return CommonResponse.success(payload, '更新药品成功');
    } on ArgumentError catch (error) {
      return CommonResponse.validateFailed(error.message?.toString());
    } catch (_) {
      return CommonResponse.failed('更新药品失败');
    }
  }

  /// 批量软删除药品；仍有可用库存的药品不能删除。
  static Future<CommonResponse> deleteMedicines(Session session, List<int> ids) async {
    if (!_isAuthenticated(session)) return CommonResponse.unauthorized();
    final normalizedIds = ids.where((id) => id > 0).toSet().toList();
    if (normalizedIds.isEmpty) return CommonResponse.validateFailed('请选择要删除的药品');

    try {
      final tenantId = tenantIdOf(session);
      final actor = _actor(session);
      final now = DateTime.now();
      final deletedIds = <int>[];
      final deletedSnapshots = <Map<String, dynamic>>[];
      await session.db.transaction((transaction) async {
        for (final id in normalizedIds) {
          final medicine = await _findMedicine(session, id, transaction: transaction, lockMode: LockMode.forUpdate);
          if (medicine == null) continue;
          final batches = await ZhongyiMedicineInventory.db.find(
            session,
            where: (t) => t.medicineId.equals(id) & t.deleted.equals(false),
            transaction: transaction,
          );
          if (batches.any((batch) => batch.quantityG > 0)) continue;
          final changed = await ZhongyiMedicine.db.updateWhere(
            session,
            where: (t) => t.id.equals(id) & t.tenantId.equals(tenantId) & t.deleted.equals(false),
            columnValues: (t) => [t.deleted(true), t.updater(actor), t.updateTime(now)],
            transaction: transaction,
          );
          if (changed.isNotEmpty) {
            deletedIds.add(id);
            deletedSnapshots.add(medicineToMap(medicine));
          }
        }
      });
      for (final snapshot in deletedSnapshots) {
        await ZhongyiAudit.record(
          session,
          type: ZhongyiAudit.typeMedicine,
          action: 'delete',
          bizId: snapshot['id'] as int,
          before: snapshot,
        );
      }
      final blockedCount = normalizedIds.length - deletedIds.length;
      return CommonResponse.success({
        'deletedCount': deletedIds.length,
        'deletedIds': deletedIds,
        'notDeletedCount': blockedCount,
      }, blockedCount == 0 ? '删除药品成功' : '有药品不存在或仍有库存，未删除');
    } catch (_) {
      return CommonResponse.failed('删除药品失败');
    }
  }

  /// 读取指定药品的价格历史。
  static Future<CommonResponse> medicinePriceList(Session session, int medicineId) async {
    if (!_isAuthenticated(session)) return CommonResponse.unauthorized();
    if (medicineId <= 0) return CommonResponse.validateFailed('药品ID不合法');
    try {
      final tenantId = tenantIdOf(session);
      final medicine = await _findMedicine(session, medicineId);
      if (medicine == null) return CommonResponse.failed('药品不存在或已删除');
      final rows = await ZhongyiMedicinePrice.db.find(
        session,
        where: (t) => t.tenantId.equals(tenantId) & t.medicineId.equals(medicineId) & t.deleted.equals(false),
        orderByList: (t) => [t.effectiveFrom.desc(), t.id.desc()],
      );
      return CommonResponse.success(rows.map(_priceToMap).toList());
    } catch (_) {
      return CommonResponse.failed('获取药品价格历史失败');
    }
  }

  /// 新增价格历史并结束之前的开放区间。
  static Future<CommonResponse> createMedicinePrice(Session session, int medicineId, Map<String, dynamic> body) async {
    if (!_isAuthenticated(session)) return CommonResponse.unauthorized();
    if (medicineId <= 0) return CommonResponse.validateFailed('药品ID不合法');
    final price = _number(body['salePrice']);
    final priceType = _trimmed(body['priceType']) ?? 'retail';
    final unit = _trimmed(body['unit']) ?? 'g';
    final effectiveFrom = _dateTime(body['effectiveFrom']) ?? DateTime.now();
    final effectiveTo = _dateTime(body['effectiveTo']);
    if (price == null) return CommonResponse.validateFailed('售价不合法');
    if (_present(body['effectiveFrom']) && _dateTime(body['effectiveFrom']) == null) {
      return CommonResponse.validateFailed('生效时间不合法');
    }
    if (_present(body['effectiveTo']) && effectiveTo == null) {
      return CommonResponse.validateFailed('失效时间不合法');
    }
    if (priceType.length > 30 || unit.isEmpty || unit.length > 20) {
      return CommonResponse.validateFailed('价格类型或计价单位不合法');
    }
    try {
      validateMedicinePrice(price);
      if (effectiveTo != null && !effectiveTo.isAfter(effectiveFrom)) {
        return CommonResponse.validateFailed('失效时间必须晚于生效时间');
      }
    } on ArgumentError catch (error) {
      return CommonResponse.validateFailed(error.message?.toString());
    }

    try {
      final tenantId = tenantIdOf(session);
      final actor = _actor(session);
      final now = DateTime.now();
      ZhongyiMedicinePrice? inserted;
      await session.db.transaction((transaction) async {
        final medicine = await _findMedicine(
          session,
          medicineId,
          transaction: transaction,
          lockMode: LockMode.forUpdate,
        );
        if (medicine == null) return;

        final rows = await ZhongyiMedicinePrice.db.find(
          session,
          where: (t) =>
              t.tenantId.equals(tenantId) &
              t.medicineId.equals(medicineId) &
              t.priceType.equals(priceType) &
              t.unit.equals(unit) &
              t.deleted.equals(false),
          orderByList: (t) => [t.effectiveFrom.desc(), t.id.desc()],
          transaction: transaction,
          lockMode: LockMode.forUpdate,
        );
        if (rows.any((row) => !row.effectiveFrom.isBefore(effectiveFrom))) return;

        final activeBefore = rows.where(
          (row) =>
              row.effectiveFrom.isBefore(effectiveFrom) &&
              (row.effectiveTo == null || row.effectiveTo!.isAfter(effectiveFrom)),
        );
        for (final previous in activeBefore) {
          if (previous.id == null) continue;
          await ZhongyiMedicinePrice.db.updateWhere(
            session,
            where: (t) => t.id.equals(previous.id!) & t.tenantId.equals(tenantId) & t.deleted.equals(false),
            columnValues: (t) => [t.effectiveTo(effectiveFrom), t.updater(actor), t.updateTime(now)],
            transaction: transaction,
          );
        }

        inserted = await ZhongyiMedicinePrice.db.insertRow(
          session,
          ZhongyiMedicinePrice(
            tenantId: tenantId,
            medicineId: medicineId,
            priceType: priceType,
            unit: unit,
            salePrice: price,
            effectiveFrom: effectiveFrom,
            effectiveTo: effectiveTo,
            creator: actor,
            updater: actor,
            createTime: now,
            updateTime: now,
          ),
          transaction: transaction,
        );
      });
      if (inserted == null) {
        return CommonResponse.failed('药品不存在或生效时间早于现有价格记录');
      }
      final pricePayload = _priceToMap(inserted!);
      await ZhongyiAudit.record(
        session,
        type: ZhongyiAudit.typeMedicinePrice,
        action: 'create',
        bizId: inserted!.id!,
        after: pricePayload,
        detail: {'medicineId': medicineId},
      );
      return CommonResponse.success(pricePayload, '新增药品价格成功');
    } catch (_) {
      return CommonResponse.failed('新增药品价格失败');
    }
  }

  /// 分页查询库存批次。
  static Future<CommonResponse> listInventory(
    Session session, {
    int page = 1,
    int pageSize = _defaultPageSize,
    String? medicineKeyword,
    String? batchNumber,
    String? qualityStatus,
    DateTime? expiryDateStart,
    DateTime? expiryDateEnd,
  }) async {
    if (!_isAuthenticated(session)) return CommonResponse.unauthorized();
    try {
      final tenantId = tenantIdOf(session);
      final safePage = _safePage(page);
      final safePageSize = _safePageSize(pageSize);
      final medicineSearch = _trimmed(medicineKeyword);
      final trimmedBatch = _trimmed(batchNumber);
      final trimmedQuality = _trimmed(qualityStatus);
      Set<int>? medicineIds;
      if (medicineSearch != null) {
        final matchingMedicines = await ZhongyiMedicine.db.find(
          session,
          where: (t) =>
              t.tenantId.equals(tenantId) &
              t.deleted.equals(false) &
              (t.name.like('%$medicineSearch%') |
                  t.prefix.like('%$medicineSearch%') |
                  t.pinyin.like('%$medicineSearch%') |
                  t.medicineCode.like('%$medicineSearch%')),
          limit: _maximumPageSize,
        );
        medicineIds = matchingMedicines.map((row) => row.id).whereType<int>().toSet();
        if (medicineIds.isEmpty) {
          return PageResponse.restPage(data: const [], page: safePage, pageSize: safePageSize, total: 0);
        }
      }
      Expression where(ZhongyiMedicineInventoryTable t) {
        var filter = t.deleted.equals(false);
        if (medicineIds != null) filter = filter & t.medicineId.inSet(medicineIds);
        if (trimmedBatch != null) filter = filter & t.batchNumber.like('%$trimmedBatch%');
        if (trimmedQuality != null) filter = filter & t.qualityStatus.equals(trimmedQuality);
        if (expiryDateStart != null) filter = filter & (t.expiryDate >= expiryDateStart);
        if (expiryDateEnd != null) filter = filter & (t.expiryDate <= expiryDateEnd);
        return filter;
      }

      final rows = await ZhongyiMedicineInventory.db.find(
        session,
        where: where,
        limit: safePageSize,
        offset: (safePage - 1) * safePageSize,
        orderByList: (t) => [t.updateTime.desc(), t.id.desc()],
      );
      final total = await ZhongyiMedicineInventory.db.count(session, where: where);
      final names = await _medicineNamesByIds(session, rows.map((row) => row.medicineId).toSet());
      return PageResponse.restPage(
        data: rows.map((row) => inventoryToMap(row, medicineName: names[row.medicineId])).toList(),
        page: safePage,
        pageSize: safePageSize,
        total: total,
      );
    } catch (_) {
      return PageResponse.failed('查询库存列表失败');
    }
  }

  /// 单个库存批次详情。
  static Future<CommonResponse> inventoryDetail(Session session, int id) async {
    if (!_isAuthenticated(session)) return CommonResponse.unauthorized();
    if (id <= 0) return CommonResponse.validateFailed('库存批次ID不合法');
    try {
      final inventory = await _findInventory(session, id);
      if (inventory == null) return CommonResponse.failed('库存批次不存在或已删除');
      final names = await _medicineNamesByIds(session, {inventory.medicineId});
      return CommonResponse.success(inventoryToMap(inventory, medicineName: names[inventory.medicineId]));
    } catch (_) {
      return CommonResponse.failed('获取库存详情失败');
    }
  }

  /// 入库：按药品、批号和供应商累加批次，并写入一条 stock_in 流水。
  static Future<CommonResponse> stockIn(Session session, Map<String, dynamic> body) async {
    if (!_isAuthenticated(session)) return CommonResponse.unauthorized();
    final medicineId = _integer(body['medicineId']);
    final batchNumber = _trimmed(body['batchNumber']);
    final unit = _trimmed(body['unit']) ?? 'g';
    final quantity = _number(body['quantityG']);
    final purchasePrice = body['purchasePrice'] == null ? null : _number(body['purchasePrice']);
    final productionDate = _dateTime(body['productionDate']);
    final expiryDate = _dateTime(body['expiryDate']);
    final supplierId = body['supplierId'] == null ? null : _integer(body['supplierId']);
    if (medicineId == null || medicineId <= 0 || batchNumber == null || batchNumber.length > 100) {
      return CommonResponse.validateFailed('药品ID或批号不合法');
    }
    if (unit.length > 10) return CommonResponse.validateFailed('单位长度不能超过10');
    if (quantity == null) return CommonResponse.validateFailed('入库数量不合法');
    if (_present(body['purchasePrice']) && purchasePrice == null) {
      return CommonResponse.validateFailed('采购价不合法');
    }
    if (_present(body['supplierId']) && supplierId == null) {
      return CommonResponse.validateFailed('供应商ID不合法');
    }
    if (_present(body['productionDate']) && productionDate == null) {
      return CommonResponse.validateFailed('生产日期不合法');
    }
    if (_present(body['expiryDate']) && expiryDate == null) {
      return CommonResponse.validateFailed('有效期不合法');
    }
    try {
      validateStockInQuantity(quantity);
      if (purchasePrice != null) validateMedicinePrice(purchasePrice);
    } on ArgumentError catch (error) {
      return CommonResponse.validateFailed(error.message?.toString());
    }

    try {
      final tenantId = tenantIdOf(session);
      final actor = _actor(session);
      final actorId = _actorId(session);
      final remark = _trimmed(body['remark']);
      final now = DateTime.now();
      ZhongyiMedicineInventory? result;
      String? medicineName;
      double? beforeQuantity;
      double? afterQuantity;
      var deletedBatchConflict = false;
      await session.db.transaction((transaction) async {
        final medicine = await _findMedicine(
          session,
          medicineId,
          transaction: transaction,
          lockMode: LockMode.forUpdate,
        );
        if (medicine == null) return;
        medicineName = medicineDisplayName(medicine);

        final existing = await _findBatch(
          session,
          medicineId: medicineId,
          batchNumber: batchNumber,
          supplierId: supplierId,
          transaction: transaction,
          lockMode: LockMode.forUpdate,
        );
        if (existing?.deleted ?? false) {
          deletedBatchConflict = true;
          return;
        }

        final before = existing?.quantityG ?? 0;
        final after = stockAfterChange(current: before, change: quantity);
        beforeQuantity = before;
        afterQuantity = after;
        final qualityStatus = _trimmed(body['qualityStatus']) ?? existing?.qualityStatus ?? 'qualified';
        final storageLocation = _trimmed(body['storageLocation']) ?? existing?.storageLocation;
        if (existing == null) {
          result = await ZhongyiMedicineInventory.db.insertRow(
            session,
            ZhongyiMedicineInventory(
              medicineId: medicineId,
              batchNumber: batchNumber,
              supplierId: supplierId,
              quantityG: after,
              unit: unit,
              purchasePrice: purchasePrice,
              productionDate: productionDate,
              expiryDate: expiryDate,
              qualityStatus: qualityStatus,
              storageLocation: storageLocation,
              isExhausted: false,
              description: _trimmed(body['description']),
              status: 1,
              creator: actor,
              updater: actor,
              createTime: now,
              updateTime: now,
            ),
            transaction: transaction,
          );
        } else {
          final changed = await ZhongyiMedicineInventory.db.updateWhere(
            session,
            where: (t) => t.id.equals(existing.id!) & t.deleted.equals(false),
            columnValues: (t) => [
              t.quantityG(after),
              t.unit(unit),
              t.purchasePrice(purchasePrice ?? existing.purchasePrice),
              t.productionDate(productionDate ?? existing.productionDate),
              t.expiryDate(expiryDate ?? existing.expiryDate),
              t.qualityStatus(qualityStatus),
              t.storageLocation(storageLocation),
              t.isExhausted(false),
              t.updater(actor),
              t.updateTime(now),
            ],
            transaction: transaction,
          );
          if (changed.isEmpty) return;
          result = changed.first;
        }
        await _recordInventoryChange(
          session,
          transaction: transaction,
          tenantId: tenantId,
          medicineId: medicineId,
          inventoryId: result!.id,
          batchNumber: batchNumber,
          transactionType: 'stock_in',
          quantityChange: quantity,
          quantityBefore: before,
          quantityAfter: after,
          remark: remark ?? '药品入库',
          actor: actor,
          actorId: actorId,
          now: now,
        );
      });
      final created = result;
      if (created == null) {
        return CommonResponse.failed(deletedBatchConflict ? '该批次已有删除记录，不能重复使用批号' : '药品不存在');
      }
      await ZhongyiAudit.record(
        session,
        type: ZhongyiAudit.typeInventory,
        action: 'stock_in',
        bizId: created.id!,
        before: {'quantityG': beforeQuantity},
        after: {'quantityG': afterQuantity},
        detail: {'medicineId': medicineId, 'batchNumber': batchNumber, 'quantityChange': quantity},
      );
      return CommonResponse.success(inventoryToMap(created, medicineName: medicineName), '入库成功');
    } on ArgumentError catch (error) {
      return CommonResponse.validateFailed(error.message?.toString());
    } catch (_) {
      return CommonResponse.failed('入库失败');
    }
  }

  /// 调整批次数量；负库存校验、流水与批次同事务提交，用量归零时标记已耗尽。
  static Future<CommonResponse> adjustInventory(Session session, Map<String, dynamic> body) async {
    if (!_isAuthenticated(session)) return CommonResponse.unauthorized();
    final inventoryId = _integer(body['inventoryId']);
    final change = _number(body['quantityChange']);
    if (inventoryId == null || inventoryId <= 0) return CommonResponse.validateFailed('库存批次ID不合法');
    if (change == null) return CommonResponse.validateFailed('库存变化量不合法');

    try {
      final tenantId = tenantIdOf(session);
      final actor = _actor(session);
      final actorId = _actorId(session);
      final now = DateTime.now();
      ZhongyiMedicineInventory? result;
      String? medicineName;
      int? auditedMedicineId;
      String? auditedBatchNumber;
      double? beforeQuantity;
      double? afterQuantity;
      await session.db.transaction((transaction) async {
        final initial = await _findInventory(session, inventoryId, transaction: transaction);
        if (initial == null) return;
        final medicine = await _findMedicine(
          session,
          initial.medicineId,
          transaction: transaction,
          lockMode: LockMode.forUpdate,
        );
        if (medicine == null) return;
        medicineName = medicineDisplayName(medicine);
        final inventory = await _findInventory(
          session,
          inventoryId,
          transaction: transaction,
          lockMode: LockMode.forUpdate,
        );
        if (inventory == null) return;
        final before = inventory.quantityG;
        final after = stockAfterChange(current: before, change: change);
        auditedMedicineId = medicine.id;
        auditedBatchNumber = inventory.batchNumber;
        beforeQuantity = before;
        afterQuantity = after;
        final changed = await ZhongyiMedicineInventory.db.updateWhere(
          session,
          where: (t) => t.id.equals(inventoryId) & t.deleted.equals(false),
          columnValues: (t) => [
            t.quantityG(after),
            if (after <= 0) t.isExhausted(true),
            t.updater(actor),
            t.updateTime(now),
          ],
          transaction: transaction,
        );
        if (changed.isEmpty) return;
        result = changed.first;
        await _recordInventoryChange(
          session,
          transaction: transaction,
          tenantId: tenantId,
          medicineId: medicine.id!,
          inventoryId: inventoryId,
          batchNumber: inventory.batchNumber,
          transactionType: 'adjust',
          quantityChange: change,
          quantityBefore: before,
          quantityAfter: after,
          remark: _trimmed(body['remark']) ?? '库存盘点调整',
          actor: actor,
          actorId: actorId,
          now: now,
        );
      });
      final adjusted = result;
      if (adjusted == null) return CommonResponse.failed('库存批次或关联药品不存在');
      await ZhongyiAudit.record(
        session,
        type: ZhongyiAudit.typeInventory,
        action: 'adjust',
        bizId: inventoryId,
        before: {'quantityG': beforeQuantity},
        after: {'quantityG': afterQuantity},
        detail: {'medicineId': auditedMedicineId, 'batchNumber': auditedBatchNumber, 'quantityChange': change},
      );
      return CommonResponse.success(inventoryToMap(adjusted, medicineName: medicineName), '库存调整成功');
    } on ArgumentError catch (error) {
      return CommonResponse.validateFailed(error.message?.toString());
    } catch (_) {
      return CommonResponse.failed('库存调整失败');
    }
  }

  /// 查询库存变动流水。
  static Future<CommonResponse> inventoryTransactions(
    Session session, {
    int page = 1,
    int pageSize = _defaultPageSize,
    int? medicineId,
    String? transactionType,
    DateTime? dateStart,
    DateTime? dateEnd,
  }) async {
    if (!_isAuthenticated(session)) return CommonResponse.unauthorized();
    try {
      final tenantId = tenantIdOf(session);
      final safePage = _safePage(page);
      final safePageSize = _safePageSize(pageSize);
      final trimmedType = _trimmed(transactionType);
      Expression where(ZhongyiInventoryTransactionTable t) {
        var filter = t.tenantId.equals(tenantId) & t.deleted.equals(false);
        if (medicineId != null && medicineId > 0) filter = filter & t.medicineId.equals(medicineId);
        if (trimmedType != null) filter = filter & t.transactionType.equals(trimmedType);
        if (dateStart != null) filter = filter & (t.createTime >= dateStart);
        if (dateEnd != null) filter = filter & (t.createTime <= dateEnd);
        return filter;
      }

      final rows = await ZhongyiInventoryTransaction.db.find(
        session,
        where: where,
        limit: safePageSize,
        offset: (safePage - 1) * safePageSize,
        orderByList: (t) => [t.createTime.desc(), t.id.desc()],
      );
      final total = await ZhongyiInventoryTransaction.db.count(session, where: where);
      return PageResponse.restPage(
        data: rows.map(transactionToMap).toList(),
        page: safePage,
        pageSize: safePageSize,
        total: total,
      );
    } catch (_) {
      return PageResponse.failed('查询库存流水失败');
    }
  }

  static Future<ZhongyiMedicine?> _findMedicine(
    Session session,
    int id, {
    Transaction? transaction,
    LockMode? lockMode,
  }) => ZhongyiMedicine.db.findFirstRow(
    session,
    where: (t) => t.id.equals(id) & t.tenantId.equals(tenantIdOf(session)) & t.deleted.equals(false),
    transaction: transaction,
    lockMode: lockMode,
  );

  static Future<ZhongyiMedicineInventory?> _findInventory(
    Session session,
    int id, {
    Transaction? transaction,
    LockMode? lockMode,
  }) => ZhongyiMedicineInventory.db.findFirstRow(
    session,
    where: (t) => t.id.equals(id) & t.deleted.equals(false),
    transaction: transaction,
    lockMode: lockMode,
  );

  /// 按 (药品, 批号, 供应商) 定位批次，与表的唯一索引一致；不过滤软删除以便识别批号冲突。
  static Future<ZhongyiMedicineInventory?> _findBatch(
    Session session, {
    required int medicineId,
    required String batchNumber,
    required int? supplierId,
    Transaction? transaction,
    LockMode? lockMode,
  }) => ZhongyiMedicineInventory.db.findFirstRow(
    session,
    where: (t) => t.medicineId.equals(medicineId) & t.batchNumber.equals(batchNumber) & t.supplierId.equals(supplierId),
    transaction: transaction,
    lockMode: lockMode,
  );

  /// 批量取药品展示名，供库存输出回填 medicine_name。
  static Future<Map<int, String>> _medicineNamesByIds(Session session, Set<int> ids) async {
    if (ids.isEmpty) return const {};
    final rows = await ZhongyiMedicine.db.find(session, where: (t) => t.id.inSet(ids));
    return {
      for (final row in rows)
        if (row.id != null) row.id!: medicineDisplayName(row),
    };
  }

  static Future<void> _recordInventoryChange(
    Session session, {
    required Transaction transaction,
    required int tenantId,
    required int medicineId,
    required int? inventoryId,
    required String batchNumber,
    required String transactionType,
    required double quantityChange,
    required double quantityBefore,
    required double quantityAfter,
    required String remark,
    required String? actor,
    required int? actorId,
    required DateTime now,
  }) async {
    await ZhongyiInventoryTransaction.db.insertRow(
      session,
      ZhongyiInventoryTransaction(
        tenantId: tenantId,
        medicineId: medicineId,
        inventoryId: inventoryId,
        batchNumber: batchNumber,
        transactionType: transactionType,
        quantityChangeG: quantityChange,
        quantityBeforeG: quantityBefore,
        quantityAfterG: quantityAfter,
        remark: remark,
        operatorId: actorId,
        creator: actor,
        updater: actor,
        createTime: now,
        updateTime: now,
      ),
      transaction: transaction,
    );
  }

  static Map<String, dynamic> _priceToMap(ZhongyiMedicinePrice price) => {
    'id': price.id,
    'medicineId': price.medicineId,
    'priceType': price.priceType,
    'unit': price.unit,
    'salePrice': price.salePrice,
    'effectiveFrom': price.effectiveFrom,
    'effectiveTo': price.effectiveTo,
    'createdTime': price.createTime,
    'updatedTime': price.updateTime,
  };

  static List<ColumnValue> _medicineColumns(
    ZhongyiMedicineUpdateTable t,
    Map<String, dynamic> fields,
    Session session,
    DateTime now,
  ) {
    final actor = _actor(session);
    return [
      t.medicineCode(fields['medicineCode'] as String),
      t.prefix(fields['prefix'] as String?),
      t.name(fields['name'] as String),
      t.pinyin(fields['pinyin'] as String?),
      t.category(fields['category'] as String),
      t.subcategory(fields['subcategory'] as String?),
      t.originPlace(fields['originPlace'] as String?),
      t.propertiesJson(fields['propertiesJson'] as String?),
      t.functions(fields['functions'] as String?),
      t.indications(fields['indications'] as String?),
      t.commonDosageMin(fields['commonDosageMin'] as double?),
      t.commonDosageMax(fields['commonDosageMax'] as double?),
      t.dosageWarning(fields['dosageWarning'] as double?),
      t.toxicity(fields['toxicity'] as String?),
      t.pregnancyCategory(fields['pregnancyCategory'] as String?),
      t.isSpecialManagement(fields['isSpecialManagement'] as bool),
      t.storageRequirements(fields['storageRequirements'] as String?),
      t.shelfLifeMonths(fields['shelfLifeMonths'] as int?),
      t.description(fields['description'] as String?),
      t.status(fields['status'] as int),
      t.updater(actor),
      t.updateTime(now),
    ];
  }

  static Map<String, dynamic> _parseMedicineFields(Map<String, dynamic> body, {ZhongyiMedicine? existing}) {
    String? readText(String key, {String? fallback}) => body.containsKey(key) ? _trimmed(body[key]) : fallback;

    final medicineCode = readText('medicineCode', fallback: existing?.medicineCode);
    final name = readText('name', fallback: existing?.name);
    final category = readText('category', fallback: existing?.category);
    if (medicineCode == null || medicineCode.length > 50) {
      throw ArgumentError('药品编码不能为空且不能超过50个字符');
    }
    if (name == null || name.length > 20) {
      throw ArgumentError('药品名称不能为空且不能超过20个字符');
    }
    if (category == null || category.length > 20) {
      throw ArgumentError('药品分类不能为空且不能超过20个字符');
    }

    final prefix = readText('prefix', fallback: existing?.prefix);
    if ((prefix?.length ?? 0) > 5) throw ArgumentError('炮制前缀不能超过5个字符');
    final dosageMin = _fieldNumber(body, 'commonDosageMin', existing?.commonDosageMin);
    final dosageMax = _fieldNumber(body, 'commonDosageMax', existing?.commonDosageMax);
    final dosageWarning = _fieldNumber(body, 'dosageWarning', existing?.dosageWarning);
    if ((dosageMin != null && dosageMin < 0) || (dosageMax != null && dosageMax < 0)) {
      throw ArgumentError('常用剂量不能为负数');
    }
    if (dosageMin != null && dosageMax != null && dosageMin > dosageMax) {
      throw ArgumentError('常用剂量下限不能大于上限');
    }
    if (dosageWarning != null && dosageWarning < 0) throw ArgumentError('剂量警戒值不能为负数');

    final properties = _fieldProperties(body, existing?.propertiesJson);
    final statusValue = body.containsKey('status') ? _integer(body['status']) : existing?.status ?? 0;
    if (statusValue == null || (statusValue != 0 && statusValue != 1)) {
      throw ArgumentError('药品状态不合法');
    }
    final special = body.containsKey('isSpecialManagement')
        ? _boolean(body['isSpecialManagement'])
        : existing?.isSpecialManagement ?? false;
    if (special == null) throw ArgumentError('特殊管理标记不合法');
    final shelfLifeMonths = _fieldInt(body, 'shelfLifeMonths', existing?.shelfLifeMonths);
    if (shelfLifeMonths != null && shelfLifeMonths < 0) throw ArgumentError('保质期不能为负数');

    return <String, dynamic>{
      'medicineCode': medicineCode,
      'prefix': prefix,
      'name': name,
      'pinyin': readText('pinyin', fallback: existing?.pinyin),
      'category': category,
      'subcategory': readText('subcategory', fallback: existing?.subcategory),
      'originPlace': readText('originPlace', fallback: existing?.originPlace),
      'propertiesJson': properties,
      'functions': readText('functions', fallback: existing?.functions),
      'indications': readText('indications', fallback: existing?.indications),
      'commonDosageMin': dosageMin,
      'commonDosageMax': dosageMax,
      'dosageWarning': dosageWarning,
      'toxicity': readText('toxicity', fallback: existing?.toxicity),
      'pregnancyCategory': readText('pregnancyCategory', fallback: existing?.pregnancyCategory),
      'isSpecialManagement': special,
      'storageRequirements': readText('storageRequirements', fallback: existing?.storageRequirements),
      'shelfLifeMonths': shelfLifeMonths,
      'description': readText('description', fallback: existing?.description),
      'status': statusValue,
    };
  }

  static String? _fieldProperties(Map<String, dynamic> body, String? fallback) {
    final key = body.containsKey('properties')
        ? 'properties'
        : body.containsKey('propertiesJson')
        ? 'propertiesJson'
        : null;
    if (key == null) return fallback;
    final raw = body[key];
    if (raw == null || raw.toString().trim().isEmpty) return null;
    if (raw is Map) {
      try {
        return jsonEncode(raw.map((key, value) => MapEntry(key.toString(), value)));
      } on JsonUnsupportedObjectError {
        throw ArgumentError('性味归经必须是有效的 JSON 对象');
      }
    }
    try {
      final decoded = jsonDecode(raw.toString());
      if (decoded is! Map) throw ArgumentError('性味归经必须是 JSON 对象');
      return jsonEncode(decoded);
    } on FormatException {
      throw ArgumentError('性味归经必须是有效的 JSON 对象');
    }
  }

  static double? _fieldNumber(Map<String, dynamic> body, String key, double? fallback) {
    if (!body.containsKey(key)) return fallback;
    final raw = body[key];
    if (raw == null || raw.toString().trim().isEmpty) return null;
    final value = _number(raw);
    if (value == null || !value.isFinite) throw ArgumentError('$key 必须是有限数字');
    return value;
  }

  static int? _fieldInt(Map<String, dynamic> body, String key, int? fallback) {
    if (!body.containsKey(key)) return fallback;
    final raw = body[key];
    if (raw == null || raw.toString().trim().isEmpty) return null;
    final value = _integer(raw);
    if (value == null) throw ArgumentError('$key 必须是整数');
    return value;
  }

  static dynamic _decodeProperties(String? source) {
    if (source == null || source.isEmpty) return null;
    try {
      final value = jsonDecode(source);
      return value is Map ? value : null;
    } on FormatException {
      return null;
    }
  }

  static int _safePage(int value) => value < 1 ? 1 : value;

  static int _safePageSize(int value) => value.clamp(1, _maximumPageSize);

  static String? _trimmed(Object? value) {
    if (value == null) return null;
    final result = value.toString().trim();
    return result.isEmpty ? null : result;
  }

  /// 空字符串按「未传」处理，前端可选字段留空时不报错。
  static bool _present(Object? value) => _trimmed(value) != null;

  static double? _number(Object? value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString().trim() ?? '');
  }

  static int? _integer(Object? value) {
    if (value is int) return value;
    if (value is num && value.isFinite && value % 1 == 0) return value.toInt();
    return int.tryParse(value?.toString().trim() ?? '');
  }

  static bool? _boolean(Object? value) => switch (value) {
    final bool result => result,
    final num result => result != 0,
    final String result => switch (result.trim().toLowerCase()) {
      'true' || '1' => true,
      'false' || '0' => false,
      _ => null,
    },
    _ => null,
  };

  static DateTime? _dateTime(Object? value) {
    if (value is DateTime) return value;
    final text = _trimmed(value);
    return text == null ? null : DateTime.tryParse(text);
  }
}
