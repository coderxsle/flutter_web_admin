import 'dart:convert';

import 'package:flutter_web_server/src/common/page_response.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/services/zhongyi/zhongyi_audit.dart';
import 'package:flutter_web_server/src/services/zhongyi/zhongyi_rules.dart';
import 'package:flutter_web_server/src/services/zhongyi/zhongyi_patient_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 中医处方模板核心业务：租户隔离、个人/共享范围、药品引用校验及软删除。
class ZhongyiPrescriptionTemplateService {
  ZhongyiPrescriptionTemplateService._();

  static const List<String> _templateFields = [
    'name',
    'scope',
    'category',
    'sourceType',
    'sourceId',
    'doctorId',
    'syndrome',
    'efficacy',
    'doses',
    'items',
    'dailyFrequency',
    'administrationMethod',
    'decoctionInstruction',
    'dietRestrictions',
    'notes',
    'isActive',
  ];

  static Future<PageResponse> list(Session session, {int page = 1, int pageSize = 10, String? name}) =>
      _guard(() async {
        final actor = await _actor(session);
        final tenantId = ZhongyiPatientService.tenantIdOf(session);
        final safePage = page <= 0 ? 1 : page;
        final size = pageSize.clamp(1, 100).toInt();
        final normalizedName = _clean(name);
        Expression where(ZhongyiPrescriptionTemplateTable table) {
          Expression filter = table.tenantId.equals(tenantId) & table.deleted.equals(false);
          filter = filter & (table.scope.notEquals('personal') | table.creator.equals(actor.creator));
          if (normalizedName != null) filter = filter & table.name.like('%$normalizedName%');
          return filter;
        }

        final rows = await ZhongyiPrescriptionTemplate.db.find(
          session,
          where: where,
          limit: size,
          offset: (safePage - 1) * size,
          orderByList: (table) => [table.updateTime.desc(), table.id.desc()],
        );
        final total = await ZhongyiPrescriptionTemplate.db.count(session, where: where);
        return PageResponse.restPage(
          data: [for (final row in rows) await _toMapWithItems(session, row, actor: actor)],
          page: safePage,
          pageSize: size,
          total: total,
        );
      });

  static Future<Map<String, dynamic>> detail(Session session, int id) => _guard(() async {
    final actor = await _actor(session);
    final row = await _findAccessible(session, id, actor);
    return _toMapWithItems(session, row, actor: actor);
  });

  static Future<Map<String, dynamic>> create(Session session, Map<String, dynamic> body) => _guard(() async {
    final actor = await _actor(session);
    final tenantId = ZhongyiPatientService.tenantIdOf(session);
    final name = _requiredText(body, 'name');
    final scope = _optionalText(body['scope']) ?? 'personal';
    _validateScope(scope);
    if (scope != 'personal' && !actor.superuser) {
      throw const RestException.forbidden('只有管理员可以创建共享模板');
    }
    final items = _readItems(body['items']);
    final doses = _intValue(body['doses']) ?? 7;
    if (doses < 1 || doses > 60) throw const RestException.badRequest('剂数必须在 1 至 60 之间');
    final now = DateTime.now();
    late final int createdId;
    final created = await session.db.transaction((transaction) async {
      final validItems = await _validateItems(session, tenantId, items, transaction);
      final row = ZhongyiPrescriptionTemplate(
        tenantId: tenantId,
        name: name,
        scope: scope,
        category: _optionalText(body['category']) ?? 'herb_decoction',
        sourceType: _optionalText(body['sourceType']),
        sourceId: _intValue(body['sourceId']),
        doctorId: _intValue(body['doctorId']),
        syndrome: _optionalText(body['syndrome']),
        efficacy: _optionalText(body['efficacy']),
        doses: doses,
        itemsJson: jsonEncode(validItems),
        dailyFrequency: _optionalText(body['dailyFrequency']),
        administrationMethod: _optionalText(body['administrationMethod']),
        decoctionInstruction: _optionalText(body['decoctionInstruction']),
        dietRestrictions: _optionalText(body['dietRestrictions']),
        notes: _optionalText(body['notes']),
        isActive: _boolValue(body['isActive']) ?? true,
        creator: actor.creator,
        updater: actor.creator,
        createTime: now,
        updateTime: now,
      );
      final inserted = await ZhongyiPrescriptionTemplate.db.insertRow(session, row, transaction: transaction);
      await _replaceItems(session, inserted.id!, validItems, actor.creator, transaction);
      createdId = inserted.id!;
      return _toMapWithItems(session, inserted, transaction: transaction, actor: actor);
    });
    await ZhongyiAudit.record(
      session,
      type: ZhongyiAudit.typePrescriptionTemplate,
      action: 'create',
      bizId: createdId,
      after: created,
    );
    return created;
  });

  static Future<Map<String, dynamic>> update(Session session, int id, Map<String, dynamic> body) => _guard(() async {
    final actor = await _actor(session);
    final tenantId = ZhongyiPatientService.tenantIdOf(session);
    final snapshot = await session.db.transaction((transaction) async {
      final template = await ZhongyiPrescriptionTemplate.db.findFirstRow(
        session,
        where: (table) => table.id.equals(id) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
        transaction: transaction,
      );
      if (template == null) throw const RestException.notFound('处方模板不存在');
      _ensureManageable(template, actor);
      final before = await _toMapWithItems(session, template, transaction: transaction, actor: actor);
      if (body.containsKey('name')) template.name = _requiredText(body, 'name');
      if (body.containsKey('scope')) {
        final scope = _optionalText(body['scope']) ?? 'personal';
        _validateScope(scope);
        if (scope != 'personal' && !actor.superuser) {
          throw const RestException.forbidden('只有管理员可以设置共享模板');
        }
        template.scope = scope;
      }
      if (body.containsKey('category')) template.category = _optionalText(body['category']) ?? 'herb_decoction';
      if (body.containsKey('sourceType')) template.sourceType = _optionalText(body['sourceType']);
      if (body.containsKey('sourceId')) template.sourceId = _intValue(body['sourceId']);
      if (body.containsKey('doctorId')) template.doctorId = _intValue(body['doctorId']);
      if (body.containsKey('syndrome')) template.syndrome = _optionalText(body['syndrome']);
      if (body.containsKey('efficacy')) template.efficacy = _optionalText(body['efficacy']);
      if (body.containsKey('doses')) {
        final doses = _intValue(body['doses']);
        if (doses == null || doses < 1 || doses > 60) {
          throw const RestException.badRequest('剂数必须在 1 至 60 之间');
        }
        template.doses = doses;
      }
      if (body.containsKey('items')) {
        final validItems = await _validateItems(session, tenantId, _readItems(body['items']), transaction);
        template.itemsJson = jsonEncode(validItems);
        await _replaceItems(session, template.id!, validItems, actor.creator, transaction);
      }
      if (body.containsKey('dailyFrequency')) template.dailyFrequency = _optionalText(body['dailyFrequency']);
      if (body.containsKey('administrationMethod')) {
        template.administrationMethod = _optionalText(body['administrationMethod']);
      }
      if (body.containsKey('decoctionInstruction')) {
        template.decoctionInstruction = _optionalText(body['decoctionInstruction']);
      }
      if (body.containsKey('dietRestrictions')) template.dietRestrictions = _optionalText(body['dietRestrictions']);
      if (body.containsKey('notes')) template.notes = _optionalText(body['notes']);
      if (body.containsKey('isActive')) template.isActive = _boolValue(body['isActive']) ?? false;
      template.updater = actor.creator;
      template.updateTime = DateTime.now();
      final updated = await ZhongyiPrescriptionTemplate.db.updateRow(session, template, transaction: transaction);
      final after = await _toMapWithItems(session, updated, transaction: transaction, actor: actor);
      return (before: before, after: after);
    });
    await ZhongyiAudit.record(
      session,
      type: ZhongyiAudit.typePrescriptionTemplate,
      action: 'update',
      bizId: id,
      before: snapshot.before,
      after: snapshot.after,
      detail: {'changedFields': ZhongyiAudit.changedFields(body, _templateFields)},
    );
    return snapshot.after;
  });

  static Future<Map<String, dynamic>> setStatus(Session session, int id, Map<String, dynamic> body) => _guard(() async {
    final actor = await _actor(session);
    final tenantId = ZhongyiPatientService.tenantIdOf(session);
    final isActive = _boolValue(body['isActive']);
    if (isActive == null) throw const RestException.badRequest('is_active 必须是布尔值');
    final snapshot = await session.db.transaction((transaction) async {
      final template = await ZhongyiPrescriptionTemplate.db.findFirstRow(
        session,
        where: (table) => table.id.equals(id) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
        transaction: transaction,
      );
      if (template == null) throw const RestException.notFound('处方模板不存在');
      _ensureManageable(template, actor);
      final previousActive = template.isActive;
      template.isActive = isActive;
      template.updater = actor.creator;
      template.updateTime = DateTime.now();
      final updated = await ZhongyiPrescriptionTemplate.db.updateRow(session, template, transaction: transaction);
      final row = await _toMapWithItems(session, updated, transaction: transaction, actor: actor);
      return (previousActive: previousActive, row: row);
    });

    await ZhongyiAudit.record(
      session,
      type: ZhongyiAudit.typePrescriptionTemplate,
      action: 'set_status',
      bizId: id,
      before: {'isActive': snapshot.previousActive},
      after: {'isActive': isActive},
    );
    return snapshot.row;
  });

  static Future<Map<String, dynamic>> delete(Session session, List<int> ids) => _guard(() async {
    final actor = await _actor(session);
    final tenantId = ZhongyiPatientService.tenantIdOf(session);
    final idSet = ids.toSet();
    final deletedSnapshots = <Map<String, dynamic>>[];
    final result = await session.db.transaction((transaction) async {
      final templates = await ZhongyiPrescriptionTemplate.db.find(
        session,
        where: (table) => table.id.inSet(idSet) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
        transaction: transaction,
      );
      for (final template in templates) {
        _ensureManageable(template, actor);
        deletedSnapshots.add({'id': template.id, 'name': template.name, 'scope': template.scope});
        template.deleted = true;
        template.updater = actor.creator;
        template.updateTime = DateTime.now();
        await ZhongyiPrescriptionTemplate.db.updateRow(session, template, transaction: transaction);
      }
      return {'deletedCount': templates.length};
    });
    for (final snapshot in deletedSnapshots) {
      await ZhongyiAudit.record(
        session,
        type: ZhongyiAudit.typePrescriptionTemplate,
        action: 'delete',
        bizId: snapshot['id'] as int,
        before: snapshot,
      );
    }
    return result;
  });

  static Future<ZhongyiPrescriptionTemplate> _findAccessible(
    Session session,
    int id,
    ({String creator, bool superuser}) actor,
  ) async {
    final tenantId = ZhongyiPatientService.tenantIdOf(session);
    final row = await ZhongyiPrescriptionTemplate.db.findFirstRow(
      session,
      where: (table) => table.id.equals(id) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
    );
    if (row == null || (row.scope == 'personal' && row.creator != actor.creator && !actor.superuser)) {
      throw const RestException.notFound('处方模板不存在');
    }
    return row;
  }

  static Future<List<Map<String, dynamic>>> _validateItems(
    Session session,
    int tenantId,
    List<dynamic> items,
    Transaction transaction,
  ) async {
    List<Map<String, dynamic>> normalized;
    try {
      normalized = ZhongyiRules.validateTemplateItems(items).map(_templateItem).toList();
    } on ArgumentError {
      throw const RestException.badRequest('药品组成无效：每味药需填写药品 ID 和正数剂量');
    }
    if (normalized.isEmpty) throw const RestException.badRequest('处方模板至少需要一味药');
    final medicineIds = normalized.map((item) => item['medicineId'] as int).toSet();
    final medicines = await ZhongyiMedicine.db.find(
      session,
      where: (table) => table.id.inSet(medicineIds) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
      transaction: transaction,
    );
    if (medicines.length != medicineIds.length || medicines.any((medicine) => medicine.status != 1)) {
      throw const RestException.badRequest('处方模板引用了不存在或已停用的药品');
    }
    return normalized;
  }

  static Map<String, dynamic> _templateItem(Map<String, dynamic> item) => {
    'medicineId': item['medicineId'],
    'sortOrder': item['sortOrder'],
    if (_optionalText(item['role']) != null) 'role': _optionalText(item['role']),
    'dosageGrams': item['dosageGrams'],
    'dosageUnit': item['dosageUnit'],
    if (_optionalText(item['dosageText']) != null) 'dosageText': _optionalText(item['dosageText']),
    if (_optionalText(item['usageMethod']) != null) 'usageMethod': _optionalText(item['usageMethod']),
    'isSubstitute': _boolValue(item['isSubstitute']) ?? false,
    if (_intValue(item['substituteForId']) != null) 'substituteForId': _intValue(item['substituteForId']),
    if (_optionalText(item['notes']) != null) 'notes': _optionalText(item['notes']),
  };

  static Future<Map<String, dynamic>> _toMapWithItems(
    Session session,
    ZhongyiPrescriptionTemplate template, {
    Transaction? transaction,
    ({String creator, bool superuser})? actor,
  }) async {
    final rows = await ZhongyiPrescriptionTemplateItem.db.find(
      session,
      where: (table) => table.templateId.equals(template.id!) & table.deleted.equals(false),
      orderByList: (table) => [table.sortOrder.asc(), table.id.asc()],
      transaction: transaction,
    );
    final items = rows.isEmpty ? _legacyItems(template.itemsJson) : rows.map(_itemToMap).toList();
    return templateToJsonMaps(template, items, actor: actor);
  }

  /// Public pure projection used by API tests and by callers that already loaded item rows.
  static Map<String, dynamic> templateToJson(
    ZhongyiPrescriptionTemplate template,
    List<ZhongyiPrescriptionTemplateItem> items,
  ) => templateToJsonMaps(template, items.map(_itemToMap).toList());

  static Map<String, dynamic> templateToJsonMaps(
    ZhongyiPrescriptionTemplate template,
    List<dynamic> items, {
    ({String creator, bool superuser})? actor,
  }) =>
      {
        'id': template.id,
        'name': template.name,
        'scope': template.scope,
        'category': template.category,
        'sourceType': template.sourceType,
        'sourceId': template.sourceId,
        'doctorId': template.doctorId,
        'syndrome': template.syndrome,
        'efficacy': template.efficacy,
        'doses': template.doses,
        'dailyFrequency': template.dailyFrequency,
        'administrationMethod': template.administrationMethod,
        'decoctionInstruction': template.decoctionInstruction,
        'dietRestrictions': template.dietRestrictions,
        'notes': template.notes,
        'isActive': template.isActive,
        'creator': template.creator,
        'updater': template.updater,
        if (actor != null) 'canEdit': _canManage(template, actor),
        'items': items,
        'createTime': template.createTime,
        'updateTime': template.updateTime,
      };

  static Map<String, dynamic> _itemToMap(ZhongyiPrescriptionTemplateItem item) => {
    'id': item.id,
    'templateId': item.templateId,
    'medicineId': item.medicineId,
    'sortOrder': item.sortOrder,
    if (item.role != null) 'role': item.role,
    'dosageGrams': item.dosageGrams,
    'dosageUnit': item.dosageUnit,
    if (item.dosageText != null) 'dosageText': item.dosageText,
    if (item.usageMethod != null) 'usageMethod': item.usageMethod,
    'isSubstitute': item.isSubstitute,
    if (item.substituteForId != null) 'substituteForId': item.substituteForId,
    if (item.notes != null) 'notes': item.notes,
  };

  static List<dynamic> _legacyItems(String value) {
    try {
      final decoded = jsonDecode(value);
      return decoded is List ? decoded : const <dynamic>[];
    } on FormatException {
      return const <dynamic>[];
    }
  }

  static Future<void> _replaceItems(
    Session session,
    int templateId,
    List<Map<String, dynamic>> items,
    String actor,
    Transaction transaction,
  ) async {
    final existing = await ZhongyiPrescriptionTemplateItem.db.find(
      session,
      where: (table) => table.templateId.equals(templateId) & table.deleted.equals(false),
      transaction: transaction,
    );
    final now = DateTime.now();
    for (final item in existing) {
      item.deleted = true;
      item.updater = actor;
      item.updateTime = now;
      await ZhongyiPrescriptionTemplateItem.db.updateRow(session, item, transaction: transaction);
    }
    for (var index = 0; index < items.length; index++) {
      final item = items[index];
      await ZhongyiPrescriptionTemplateItem.db.insertRow(
        session,
        ZhongyiPrescriptionTemplateItem(
          templateId: templateId,
          medicineId: item['medicineId'] as int,
          sortOrder: _intValue(item['sortOrder']) ?? index,
          role: _optionalText(item['role']),
          dosageGrams: (item['dosageGrams'] as num).toDouble(),
          dosageUnit: _optionalText(item['dosageUnit']) ?? 'g',
          dosageText: _optionalText(item['dosageText']),
          usageMethod: _optionalText(item['usageMethod']),
          isSubstitute: _boolValue(item['isSubstitute']) ?? false,
          substituteForId: _intValue(item['substituteForId']),
          notes: _optionalText(item['notes']),
          creator: actor,
          updater: actor,
          createTime: now,
          updateTime: now,
        ),
        transaction: transaction,
      );
    }
  }

  /// 归属标识统一用 sys_user.id：用户名可改、可能重复，老数据存的也是数字 id。
  static Future<({String creator, bool superuser})> _actor(Session session) async {
    final auth = session.authenticated;
    if (auth == null) throw const RestException.unauthorized();
    final user = await SysUser.db.findFirstRow(
      session,
      where: (table) => table.authUserId.equals(auth.authUserId) & table.deleted.equals(false),
    );
    return (creator: user?.id?.toString() ?? auth.authUserId.toString(), superuser: user?.isSuperuser ?? false);
  }

  static void _ensureManageable(ZhongyiPrescriptionTemplate template, ({String creator, bool superuser}) actor) {
    if (template.scope == 'agreed') throw const RestException.forbidden('协定处方模板不可直接修改');
    if (!_canManage(template, actor)) {
      throw const RestException.forbidden('只有创建者或管理员可以修改此处方模板');
    }
  }

  /// 协定模板永久只读；其余模板创建者本人或管理员可改。
  static bool _canManage(ZhongyiPrescriptionTemplate template, ({String creator, bool superuser}) actor) =>
      template.scope != 'agreed' && (template.creator == actor.creator || actor.superuser);

  static List<dynamic> _readItems(Object? value) {
    if (value is List) return value;
    throw const RestException.badRequest('药品组成必须为数组');
  }

  static void _validateScope(String scope) {
    if (!const {'personal', 'public', 'agreed'}.contains(scope)) {
      throw const RestException.badRequest('适用范围不合法');
    }
  }

  static String _requiredText(Map<String, dynamic> body, String key) {
    final text = _optionalText(body[key]);
    if (text == null) throw RestException.badRequest('$key 不能为空');
    return text;
  }

  static String? _optionalText(Object? value) {
    if (value == null) return null;
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }

  static String? _clean(String? value) => _optionalText(value);

  static int? _intValue(Object? value) => switch (value) {
    final int v => v,
    final num v when v.isFinite && v % 1 == 0 => v.toInt(),
    final String v => int.tryParse(v.trim()),
    _ => null,
  };

  static bool? _boolValue(Object? value) => switch (value) {
    final bool v => v,
    final num v => v != 0,
    final String v => switch (v.trim().toLowerCase()) {
      'true' || '1' || 'yes' => true,
      'false' || '0' || 'no' => false,
      _ => null,
    },
    _ => null,
  };

  static Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on RestException {
      rethrow;
    } catch (_) {
      throw const RestException(500, '处方模板处理失败', code: 500);
    }
  }
}
