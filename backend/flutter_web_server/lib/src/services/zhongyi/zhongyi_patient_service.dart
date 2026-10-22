import 'package:flutter_web_server/src/common/page_response.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/services/zhongyi/zhongyi_audit.dart';
import 'package:flutter_web_server/src/services/zhongyi/zhongyi_rules.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 患者档案业务服务。
///
/// 列表返回完整患者档案字段；PHI 读写审计仅保存记录 ID、动作、租户、操作者与时间，
/// 不留存字段快照。
class ZhongyiPatientService {
  ZhongyiPatientService._();

  /// 审计只记录这些字段是否被改过，不落字段值。
  static const List<String> _auditableFields = [
    'name',
    'gender',
    'birthDate',
    'phone',
    'idCard',
    'address',
    'occupation',
    'bloodType',
    'emergencyContact',
    'emergencyPhone',
    'allergyHistory',
    'medicalHistory',
    'familyHistory',
    'constitution',
    'source',
  ];

  static int tenantIdOf(Session session) {
    final target = session.targetTenantId;
    if (target != null && target > 0) return target;
    return session.tenantId;
  }

  static Future<PageResponse> list(
    Session session, {
    int page = 1,
    int pageSize = 10,
    String? keyword,
    String? name,
    String? phone,
    String? gender,
  }) => _guard(() async {
    final tenantId = tenantIdOf(session);
    final safePage = page <= 0 ? 1 : page;
    final size = pageSize.clamp(1, 100);
    final normalizedKeyword = _clean(keyword);
    final normalizedName = _clean(name);
    final normalizedPhone = _clean(phone);
    final normalizedGender = _genderValue(gender);
    final actor = await _actor(session);
    return session.db.transaction((transaction) async {
      Expression where(ZhongyiPatientTable table) {
        Expression filter = table.tenantId.equals(tenantId) & table.deleted.equals(false);
        if (normalizedKeyword != null) {
          filter = filter & (table.name.like('%$normalizedKeyword%') | table.phone.like('%$normalizedKeyword%'));
        }
        if (normalizedName != null) filter = filter & table.name.like('%$normalizedName%');
        if (normalizedPhone != null) filter = filter & table.phone.like('%$normalizedPhone%');
        if (normalizedGender != null) filter = filter & table.gender.equals(normalizedGender);
        return filter;
      }

      final patients = await ZhongyiPatient.db.find(
        session,
        where: where,
        orderByList: (table) => [table.createTime.desc(), table.id.desc()],
        limit: size,
        offset: (safePage - 1) * size,
        transaction: transaction,
      );
      final total = await ZhongyiPatient.db.count(session, where: where, transaction: transaction);
      await _recordAccess(session, transaction, tenantId, actor, action: 'list');
      return PageResponse.restPage(
        data: patients.map(_toSummary).toList(),
        page: safePage,
        pageSize: size,
        total: total,
      );
    });
  });

  static Future<Map<String, dynamic>> detail(Session session, int id) => _guard(() async {
    final tenantId = tenantIdOf(session);
    final actor = await _actor(session);
    return session.db.transaction((transaction) async {
      final patient = await ZhongyiPatient.db.findFirstRow(
        session,
        where: (table) => table.id.equals(id) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
        transaction: transaction,
      );
      if (patient == null) throw const RestException.notFound('患者档案不存在');
      await _recordAccess(session, transaction, tenantId, actor, patientId: id, action: 'detail');
      return _toDetail(patient);
    });
  });

  static Future<Map<String, dynamic>> create(Session session, Map<String, dynamic> body) => _guard(() async {
    final tenantId = tenantIdOf(session);
    final actor = await _actor(session);
    final now = DateTime.now();
    final patient = ZhongyiPatient(
      tenantId: tenantId,
      name: _requiredText(body, 'name'),
      gender: _genderValue(body['gender']?.toString()) ?? 3,
      birthDate: _dateValue(body['birthDate']),
      phone: _optionalText(body, 'phone'),
      idCard: _optionalText(body, 'id_card'),
      address: _optionalText(body, 'address'),
      occupation: _optionalText(body, 'occupation'),
      bloodType: _optionalText(body, 'blood_type'),
      emergencyContact: _optionalText(body, 'emergency_contact'),
      emergencyPhone: _optionalText(body, 'emergency_phone'),
      allergyHistory: _optionalText(body, 'allergy_history'),
      medicalHistory: _optionalText(body, 'medical_history'),
      familyHistory: _optionalText(body, 'family_history'),
      constitution: _optionalText(body, 'constitution'),
      source: _optionalText(body, 'source') ?? 'manual',
      creator: actor.creator,
      updater: actor.creator,
      createTime: now,
      updateTime: now,
    );
    final created = await session.db.transaction((transaction) async {
      final inserted = await ZhongyiPatient.db.insertRow(session, patient, transaction: transaction);
      await _recordAccess(session, transaction, tenantId, actor, patientId: inserted.id, action: 'create');
      return _toDetail(inserted);
    });
    await ZhongyiAudit.record(session, type: ZhongyiAudit.typePatient, action: 'create', bizId: created['id'] as int);
    return created;
  });

  static Future<Map<String, dynamic>> update(Session session, int id, Map<String, dynamic> body) => _guard(() async {
    final tenantId = tenantIdOf(session);
    final actor = await _actor(session);
    final result = await session.db.transaction((transaction) async {
      final patient = await ZhongyiPatient.db.findFirstRow(
        session,
        where: (table) => table.id.equals(id) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
        transaction: transaction,
      );
      if (patient == null) throw const RestException.notFound('患者档案不存在');
      if (body.containsKey('name')) patient.name = _requiredText(body, 'name');
      if (body.containsKey('gender')) patient.gender = _genderValue(body['gender']?.toString()) ?? 3;
      if (body.containsKey('birthDate')) patient.birthDate = _dateValue(body['birthDate']);
      if (body.containsKey('phone')) patient.phone = _optionalText(body, 'phone');
      if (body.containsKey('idCard')) patient.idCard = _optionalText(body, 'id_card');
      if (body.containsKey('address')) patient.address = _optionalText(body, 'address');
      if (body.containsKey('occupation')) patient.occupation = _optionalText(body, 'occupation');
      if (body.containsKey('bloodType')) patient.bloodType = _optionalText(body, 'blood_type');
      if (body.containsKey('emergencyContact')) patient.emergencyContact = _optionalText(body, 'emergency_contact');
      if (body.containsKey('emergencyPhone')) patient.emergencyPhone = _optionalText(body, 'emergency_phone');
      if (body.containsKey('allergyHistory')) patient.allergyHistory = _optionalText(body, 'allergy_history');
      if (body.containsKey('medicalHistory')) patient.medicalHistory = _optionalText(body, 'medical_history');
      if (body.containsKey('familyHistory')) patient.familyHistory = _optionalText(body, 'family_history');
      if (body.containsKey('constitution')) patient.constitution = _optionalText(body, 'constitution');
      if (body.containsKey('source')) patient.source = _optionalText(body, 'source');
      patient.updater = actor.creator;
      patient.updateTime = DateTime.now();
      final updated = await ZhongyiPatient.db.updateRow(session, patient, transaction: transaction);
      await _recordAccess(session, transaction, tenantId, actor, patientId: id, action: 'update');
      return _toDetail(updated);
    });
    await ZhongyiAudit.record(
      session,
      type: ZhongyiAudit.typePatient,
      action: 'update',
      bizId: id,
      detail: {'changedFields': ZhongyiAudit.changedFields(body, _auditableFields)},
    );
    return result;
  });

  static Future<Map<String, dynamic>> delete(Session session, List<int> ids) => _guard(() async {
    final tenantId = tenantIdOf(session);
    final actor = await _actor(session);
    final idSet = ids.map<int?>((id) => id).toSet();
    final deletedIds = <int>[];
    final result = await session.db.transaction((transaction) async {
      final patients = await ZhongyiPatient.db.find(
        session,
        where: (table) => table.id.inSet(idSet) & table.tenantId.equals(tenantId) & table.deleted.equals(false),
        transaction: transaction,
      );
      final now = DateTime.now();
      for (final patient in patients) {
        patient.deleted = true;
        patient.updater = actor.creator;
        patient.updateTime = now;
        await ZhongyiPatient.db.updateRow(session, patient, transaction: transaction);
        await _recordAccess(session, transaction, tenantId, actor, patientId: patient.id, action: 'delete');
        if (patient.id != null) deletedIds.add(patient.id!);
      }
      return {'deletedCount': patients.length};
    });
    for (final deletedId in deletedIds) {
      await ZhongyiAudit.record(session, type: ZhongyiAudit.typePatient, action: 'delete', bizId: deletedId);
    }
    return result;
  });

  static Map<String, dynamic> _toSummary(ZhongyiPatient patient) => ZhongyiRules.patientSummary({
    'id': patient.id,
    'name': patient.name,
    'gender': patient.gender,
    'birthDate': _dateString(patient.birthDate),
    'phone': patient.phone,
    'idCard': patient.idCard,
    'address': patient.address,
    'occupation': patient.occupation,
    'bloodType': patient.bloodType,
    'emergencyContact': patient.emergencyContact,
    'emergencyPhone': patient.emergencyPhone,
    'allergyHistory': patient.allergyHistory,
    'medicalHistory': patient.medicalHistory,
    'familyHistory': patient.familyHistory,
    'constitution': patient.constitution,
    'source': patient.source,
    'createTime': patient.createTime,
    'updateTime': patient.updateTime,
  });

  static Map<String, dynamic> _toDetail(ZhongyiPatient patient) => {
    'id': patient.id,
    'name': patient.name,
    'gender': patient.gender,
    'birthDate': _dateString(patient.birthDate),
    'phone': patient.phone,
    'idCard': patient.idCard,
    'address': patient.address,
    'occupation': patient.occupation,
    'bloodType': patient.bloodType,
    'emergencyContact': patient.emergencyContact,
    'emergencyPhone': patient.emergencyPhone,
    'allergyHistory': patient.allergyHistory,
    'medicalHistory': patient.medicalHistory,
    'familyHistory': patient.familyHistory,
    'constitution': patient.constitution,
    'source': patient.source,
    'createTime': patient.createTime,
    'updateTime': patient.updateTime,
  };

  static Future<({int? id, String creator})> _actor(Session session, {Transaction? transaction}) async {
    final auth = session.authenticated;
    if (auth == null) throw const RestException.unauthorized();
    final user = await SysUser.db.findFirstRow(
      session,
      where: (table) => table.authUserId.equals(auth.authUserId) & table.deleted.equals(false),
      transaction: transaction,
    );
    return (id: user?.id, creator: user?.username ?? auth.authUserId.toString());
  }

  static Future<void> _recordAccess(
    Session session,
    Transaction transaction,
    int tenantId,
    ({int? id, String creator}) actor, {
    int? patientId,
    required String action,
  }) async {
    await ZhongyiPatientAccessLog.db.insertRow(
      session,
      ZhongyiPatientAccessLog(
        tenantId: tenantId,
        patientId: patientId,
        action: action,
        actorId: actor.id,
        creator: actor.creator,
        updater: actor.creator,
      ),
      transaction: transaction,
    );
  }

  static Future<T> _guard<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on RestException {
      rethrow;
    } catch (_) {
      // Avoid echoing query parameters or patient content through REST or server logs.
      throw const RestException(500, '患者资料处理失败', code: 500);
    }
  }

  static String _requiredText(Map<String, dynamic> body, String key) {
    final text = _optionalText(body, key);
    if (text == null) throw RestException.badRequest('$key 不能为空');
    return text;
  }

  static String? _optionalText(Map<String, dynamic> body, String key) {
    final value = body[key];
    if (value == null) return null;
    final text = value.toString().trim();
    return text.isEmpty ? null : text;
  }

  static String? _clean(String? value) {
    final text = value?.trim();
    return text == null || text.isEmpty ? null : text;
  }

  static int? _genderValue(String? value) {
    final normalized = _clean(value)?.toLowerCase();
    if (normalized == null) return null;
    switch (normalized) {
      case '1':
      case 'male':
        return 1;
      case '2':
      case 'female':
        return 2;
      case '3':
      case 'other':
      case 'secret':
        return 3;
      default:
        throw const RestException.badRequest('性别必须为 1（男）、2（女）或 3（保密）');
    }
  }

  static DateTime? _dateValue(Object? value) {
    final text = value?.toString().trim();
    if (text == null || text.isEmpty) return null;
    final parsed = DateTime.tryParse(text);
    if (parsed == null) throw const RestException.badRequest('出生日期格式不正确');
    return DateTime.utc(parsed.year, parsed.month, parsed.day);
  }

  /// 纯日期字段，按原值取年月日（不做时区转换）。
  static String? _dateString(DateTime? date) {
    if (date == null) return null;
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
