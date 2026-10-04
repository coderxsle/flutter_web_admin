import 'dart:convert';

import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/services/zhongyi/zhongyi_rules.dart';
import 'package:flutter_web_server/src/services/zhongyi/zhongyi_patient_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 中医处方模板核心业务：租户隔离、个人/共享范围、药品引用校验及软删除。
class ZhongyiPrescriptionTemplateService {
  ZhongyiPrescriptionTemplateService._();

  static Future<Map<String, dynamic>> list(Session session, {int page = 1, int pageSize = 10, String? name}) =>
      _guard(() async {
        final actor = await _actor(session);
        final tenantId = ZhongyiPatientService.tenantIdOf(session);
        final pageNo = page <= 0 ? 1 : page;
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
          offset: (pageNo - 1) * size,
          orderByList: (table) => [table.updateTime.desc(), table.id.desc()],
        );
        final total = await ZhongyiPrescriptionTemplate.db.count(session, where: where);
        return {
          'page_no': pageNo,
          'page_size': size,
          'total': total,
          'has_next': pageNo * size < total,
          'items': [for (final row in rows) await _toMapWithItems(session, row)],
        };
      });

  static Future<Map<String, dynamic>> detail(Session session, int id) => _guard(() async {
    final actor = await _actor(session);
    final row = await _findAccessible(session, id, actor);
    return _toMapWithItems(session, row);
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
    return session.db.transaction((transaction) async {
      final validItems = await _validateItems(session, tenantId, items, transaction);
      final row = ZhongyiPrescriptionTemplate(
        tenantId: tenantId,
        name: name,
        scope: scope,
        category: _optionalText(body['category']) ?? 'herb_decoction',
        sourceType: _optionalText(body['source_type']),
        sourceId: _intValue(body['source_id']),
        doctorId: _intValue(body['doctor_id']),
        syndrome: _optionalText(body['syndrome']),
        efficacy: _optionalText(body['efficacy']),
        doses: doses,
        itemsJson: jsonEncode(validItems),
        dailyFrequency: _optionalText(body['daily_frequency']),
        administrationMethod: _optionalText(body['administration_method']),
        decoctionInstruction: _optionalText(body['decoction_instruction']),
        dietRestrictions: _optionalText(body['diet_restrictions']),
        notes: _optionalText(body['notes']),
        isActive: _boolValue(body['is_active']) ?? true,
        creator: actor.creator,
        updater: actor.creator,
        createTime: now,
        updateTime: now,
      );
      final inserted = await ZhongyiPrescriptionTemplate.db.insertRow(session, row, transaction: transaction);
      await _replaceItems(session, inserted.id!, validItems, actor.creator, transaction);
      return _toMapWithItems(session, inserted, transaction: transaction);
    });
  });

  static Future<Map<String, dynamic>> update(Session session, int id, Map<String, dynamic> body) => _guard(() async {
    final actor = await _actor(session);
    final tenantId = ZhongyiPatientService.tenantIdOf(session);
    return session.db.transaction((transaction) async {
      final template = await ZhongyiPrescriptionTemplate.db.findFirstRow(
        session,
        where: (table) => table.id.equals(id) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
        transaction: transaction,
      );
      if (template == null) throw const RestException.notFound('处方模板不存在');
      _ensureManageable(template, actor);
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
      if (body.containsKey('source_type')) template.sourceType = _optionalText(body['source_type']);
      if (body.containsKey('source_id')) template.sourceId = _intValue(body['source_id']);
      if (body.containsKey('doctor_id')) template.doctorId = _intValue(body['doctor_id']);
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
      if (body.containsKey('daily_frequency')) template.dailyFrequency = _optionalText(body['daily_frequency']);
      if (body.containsKey('administration_method')) {
        template.administrationMethod = _optionalText(body['administration_method']);
      }
      if (body.containsKey('decoction_instruction')) {
        template.decoctionInstruction = _optionalText(body['decoction_instruction']);
      }
      if (body.containsKey('diet_restrictions')) template.dietRestrictions = _optionalText(body['diet_restrictions']);
      if (body.containsKey('notes')) template.notes = _optionalText(body['notes']);
      if (body.containsKey('is_active')) template.isActive = _boolValue(body['is_active']) ?? false;
      template.updater = actor.creator;
      template.updateTime = DateTime.now();
      final updated = await ZhongyiPrescriptionTemplate.db.updateRow(session, template, transaction: transaction);
      return _toMapWithItems(session, updated, transaction: transaction);
    });
  });

  static Future<Map<String, dynamic>> setStatus(Session session, int id, Map<String, dynamic> body) => _guard(() async {
    final actor = await _actor(session);
    final tenantId = ZhongyiPatientService.tenantIdOf(session);
    final isActive = _boolValue(body['is_active']);
    if (isActive == null) throw const RestException.badRequest('is_active 必须是布尔值');
    return session.db.transaction((transaction) async {
      final template = await ZhongyiPrescriptionTemplate.db.findFirstRow(
        session,
        where: (table) => table.id.equals(id) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
        transaction: transaction,
      );
      if (template == null) throw const RestException.notFound('处方模板不存在');
      _ensureManageable(template, actor);
      template.isActive = isActive;
      template.updater = actor.creator;
      template.updateTime = DateTime.now();
      final updated = await ZhongyiPrescriptionTemplate.db.updateRow(session, template, transaction: transaction);
      return _toMapWithItems(session, updated, transaction: transaction);
    });
  });

  static Future<Map<String, dynamic>> delete(Session session, List<int> ids) => _guard(() async {
    final actor = await _actor(session);
    final tenantId = ZhongyiPatientService.tenantIdOf(session);
    final idSet = ids.map<int?>((id) => id).toSet();
    return session.db.transaction((transaction) async {
      final templates = await ZhongyiPrescriptionTemplate.db.find(
        session,
        where: (table) => table.id.inSet(idSet) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
        transaction: transaction,
      );
      for (final template in templates) {
        _ensureManageable(template, actor);
        template.deleted = true;
        template.updater = actor.creator;
        template.updateTime = DateTime.now();
        await ZhongyiPrescriptionTemplate.db.updateRow(session, template, transaction: transaction);
      }
      return {'deleted_count': templates.length};
    });
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
    final medicineIds = normalized.map<int?>((item) => item['medicine_id'] as int).toSet();
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
    'medicine_id': item['medicine_id'],
    'sort_order': item['sort_order'],
    if (_optionalText(item['role']) != null) 'role': _optionalText(item['role']),
    'dosage_grams': item['dosage_grams'],
    'dosage_unit': item['dosage_unit'],
    if (_optionalText(item['dosage_text']) != null) 'dosage_text': _optionalText(item['dosage_text']),
    if (_optionalText(item['usage_method']) != null) 'usage_method': _optionalText(item['usage_method']),
    'is_substitute': _boolValue(item['is_substitute']) ?? false,
    if (_intValue(item['substitute_for_id']) != null) 'substitute_for_id': _intValue(item['substitute_for_id']),
    if (_optionalText(item['notes']) != null) 'notes': _optionalText(item['notes']),
  };

  static Future<Map<String, dynamic>> _toMapWithItems(
    Session session,
    ZhongyiPrescriptionTemplate template, {
    Transaction? transaction,
  }) async {
    final rows = await ZhongyiPrescriptionTemplateItem.db.find(
      session,
      where: (table) => table.templateId.equals(template.id!) & table.deleted.equals(false),
      orderByList: (table) => [table.sortOrder.asc(), table.id.asc()],
      transaction: transaction,
    );
    final items = rows.isEmpty ? _legacyItems(template.itemsJson) : rows.map(_itemToMap).toList();
    return templateToJsonMaps(template, items);
  }

  /// Public pure projection used by API tests and by callers that already loaded item rows.
  static Map<String, dynamic> templateToJson(
    ZhongyiPrescriptionTemplate template,
    List<ZhongyiPrescriptionTemplateItem> items,
  ) => templateToJsonMaps(template, items.map(_itemToMap).toList());

  static Map<String, dynamic> templateToJsonMaps(ZhongyiPrescriptionTemplate template, List<dynamic> items) => {
    'id': template.id,
    'name': template.name,
    'scope': template.scope,
    'category': template.category,
    'source_type': template.sourceType,
    'source_id': template.sourceId,
    'doctor_id': template.doctorId,
    'syndrome': template.syndrome,
    'efficacy': template.efficacy,
    'doses': template.doses,
    'daily_frequency': template.dailyFrequency,
    'administration_method': template.administrationMethod,
    'decoction_instruction': template.decoctionInstruction,
    'diet_restrictions': template.dietRestrictions,
    'notes': template.notes,
    'is_active': template.isActive,
    'creator': template.creator,
    'updater': template.updater,
    'items': items,
    'create_time': template.createTime.toIso8601String(),
    'update_time': template.updateTime.toIso8601String(),
  };

  static Map<String, dynamic> _itemToMap(ZhongyiPrescriptionTemplateItem item) => {
    'id': item.id,
    'template_id': item.templateId,
    'medicine_id': item.medicineId,
    'sort_order': item.sortOrder,
    if (item.role != null) 'role': item.role,
    'dosage_grams': item.dosageGrams,
    'dosage_unit': item.dosageUnit,
    if (item.dosageText != null) 'dosage_text': item.dosageText,
    if (item.usageMethod != null) 'usage_method': item.usageMethod,
    'is_substitute': item.isSubstitute,
    if (item.substituteForId != null) 'substitute_for_id': item.substituteForId,
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
          medicineId: item['medicine_id'] as int,
          sortOrder: _intValue(item['sort_order']) ?? index,
          role: _optionalText(item['role']),
          dosageGrams: (item['dosage_grams'] as num).toDouble(),
          dosageUnit: _optionalText(item['dosage_unit']) ?? 'g',
          dosageText: _optionalText(item['dosage_text']),
          usageMethod: _optionalText(item['usage_method']),
          isSubstitute: _boolValue(item['is_substitute']) ?? false,
          substituteForId: _intValue(item['substitute_for_id']),
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

  static Future<({String creator, bool superuser})> _actor(Session session) async {
    final auth = session.authenticated;
    if (auth == null) throw const RestException.unauthorized();
    final user = await SysUser.db.findFirstRow(
      session,
      where: (table) => table.authUserId.equals(auth.authUserId) & table.deleted.equals(false),
    );
    return (creator: user?.username ?? auth.authUserId.toString(), superuser: user?.isSuperuser ?? false);
  }

  static void _ensureManageable(ZhongyiPrescriptionTemplate template, ({String creator, bool superuser}) actor) {
    if (template.scope == 'agreed') throw const RestException.forbidden('协定处方模板不可直接修改');
    if (template.scope == 'personal' && template.creator != actor.creator) {
      throw const RestException.forbidden('无权修改此处方模板');
    }
    if (template.scope == 'public' && !actor.superuser) {
      throw const RestException.forbidden('只有管理员可以修改公共模板');
    }
  }

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
