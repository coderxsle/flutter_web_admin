import 'dart:math' as math;

import 'package:flutter_web_server/src/common/common.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 科室与员工目录服务。
///
/// 本服务直接使用 Serverpod 查询，但每次读、更新和软删除均显式约束当前会话租户及
/// `deleted = false`。请求中的 `tenant_id` 从不参与租户选择。
class ZhongyiDirectoryService {
  ZhongyiDirectoryService._();

  static int tenantIdOf(Session session) {
    final targetTenantId = session.targetTenantId;
    return targetTenantId != null && targetTenantId > 0 ? targetTenantId : session.tenantId;
  }

  static Future<CommonResponse> listDepartments(
    Session session, {
    int? pageNo,
    int? pageSize,
    String? name,
    String? code,
    bool? isActive,
  }) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();

    try {
      final tenantId = tenantIdOf(session);
      final (safePage, safeSize) = _page(pageNo, pageSize);
      final normalizedName = _trimmed(name);
      final normalizedCode = _trimmed(code);

      Expression where(ZhongyiDepartmentTable t) {
        final conditions = <Expression>[_departmentScope(t, tenantId)];
        if (normalizedName != null) conditions.add(t.name.like('%$normalizedName%'));
        if (normalizedCode != null) conditions.add(t.code.like('%$normalizedCode%'));
        if (isActive != null) conditions.add(t.isActive.equals(isActive));
        return conditions.reduce((left, right) => left & right);
      }

      final rows = await ZhongyiDepartment.db.find(
        session,
        where: where,
        orderByList: (t) => [t.sortOrder.asc(), t.id.asc()],
        limit: safeSize,
        offset: (safePage - 1) * safeSize,
      );
      final total = await ZhongyiDepartment.db.count(session, where: where);

      return CommonResponse.success({
        'page_no': safePage,
        'page_size': safeSize,
        'total': total,
        'has_next': safePage * safeSize < total,
        'items': rows.map(departmentToJson).toList(growable: false),
      });
    } catch (_) {
      return CommonResponse.failed('获取科室列表失败');
    }
  }

  static Future<CommonResponse> departmentTree(Session session, {String? name, String? code, bool? isActive}) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();

    try {
      final tenantId = tenantIdOf(session);
      final normalizedName = _trimmed(name);
      final normalizedCode = _trimmed(code);
      final rows = await ZhongyiDepartment.db.find(
        session,
        where: (t) {
          final conditions = <Expression>[_departmentScope(t, tenantId)];
          if (normalizedName != null) conditions.add(t.name.like('%$normalizedName%'));
          if (normalizedCode != null) conditions.add(t.code.like('%$normalizedCode%'));
          if (isActive != null) conditions.add(t.isActive.equals(isActive));
          return conditions.reduce((left, right) => left & right);
        },
        orderByList: (t) => [t.sortOrder.asc(), t.id.asc()],
      );

      return CommonResponse.success(buildDepartmentTree(rows));
    } catch (_) {
      return CommonResponse.failed('获取科室树失败');
    }
  }

  static Future<CommonResponse> departmentDetail(Session session, int id) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();
    if (id <= 0) return CommonResponse.validateFailed('科室ID必须是正整数');

    try {
      final tenantId = tenantIdOf(session);
      final row = await ZhongyiDepartment.db.findFirstRow(
        session,
        where: (t) => _departmentScope(t, tenantId) & t.id.equals(id),
      );
      return row == null ? CommonResponse.failed('科室不存在或已删除') : CommonResponse.success(departmentToJson(row));
    } catch (_) {
      return CommonResponse.failed('获取科室详情失败');
    }
  }

  static Future<CommonResponse> createDepartment(Session session, Map<String, dynamic> body) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();

    final name = _trimmed(body['name']);
    final code = _trimmed(body['code']);
    if (name == null || name.length > 100) return CommonResponse.validateFailed('科室名称不能为空且不能超过100字');
    if (code == null || code.length > 50) return CommonResponse.validateFailed('科室编码不能为空且不能超过50字');

    final parentId = body.containsKey('parent_id') ? _parentId(body['parent_id']) : 0;
    final sortOrder = body.containsKey('sort_order') ? _integer(body['sort_order']) : 0;
    final isActive = body.containsKey('is_active') ? _boolean(body['is_active']) : true;
    final phone = body.containsKey('phone') ? _trimmed(body['phone']) : null;
    final description = body.containsKey('description') ? _trimmed(body['description']) : null;
    if (parentId == null) return CommonResponse.validateFailed('上级科室ID不合法');
    if (sortOrder == null) return CommonResponse.validateFailed('排序必须是整数');
    if (isActive == null) return CommonResponse.validateFailed('启用状态不合法');
    if (!_validNullableText(phone, maxLength: 20)) return CommonResponse.validateFailed('联系电话不能超过20字');
    if (!_validNullableText(description, maxLength: 500)) return CommonResponse.validateFailed('备注不能超过500字');

    try {
      final tenantId = tenantIdOf(session);
      if (await _departmentDuplicate(session, tenantId, 'name', name)) {
        return CommonResponse.failed('科室名称已存在');
      }
      if (await _departmentDuplicate(session, tenantId, 'code', code)) {
        return CommonResponse.failed('科室编码已存在');
      }
      if (parentId != 0 && await _findDepartment(session, tenantId, parentId) == null) {
        return CommonResponse.failed('上级科室不存在或已删除');
      }

      final now = DateTime.now();
      final actor = session.authenticated!.userIdentifier;
      final inserted = await ZhongyiDepartment.db.insertRow(
        session,
        ZhongyiDepartment(
          tenantId: tenantId,
          name: name,
          code: code,
          parentId: parentId,
          sortOrder: sortOrder,
          isActive: isActive,
          phone: phone,
          description: description,
          deleted: false,
          creator: actor,
          createTime: now,
          updater: actor,
          updateTime: now,
        ),
      );
      return CommonResponse.success(departmentToJson(inserted));
    } catch (_) {
      return CommonResponse.failed('创建科室失败');
    }
  }

  static Future<CommonResponse> updateDepartment(Session session, int id, Map<String, dynamic> body) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();
    if (id <= 0) return CommonResponse.validateFailed('科室ID必须是正整数');

    try {
      final tenantId = tenantIdOf(session);
      final current = await _findDepartment(session, tenantId, id);
      if (current == null) return CommonResponse.failed('科室不存在或已删除');

      final name = body.containsKey('name') ? _trimmed(body['name']) : current.name;
      final code = body.containsKey('code') ? _trimmed(body['code']) : current.code;
      if (name == null || name.length > 100) return CommonResponse.validateFailed('科室名称不能为空且不能超过100字');
      if (code == null || code.length > 50) return CommonResponse.validateFailed('科室编码不能为空且不能超过50字');

      final parentId = body.containsKey('parent_id') ? _parentId(body['parent_id']) : current.parentId ?? 0;
      final sortOrder = body.containsKey('sort_order') ? _integer(body['sort_order']) : current.sortOrder;
      final isActive = body.containsKey('is_active') ? _boolean(body['is_active']) : current.isActive;
      final phone = body.containsKey('phone') ? _trimmed(body['phone']) : current.phone;
      final description = body.containsKey('description') ? _trimmed(body['description']) : current.description;
      if (parentId == null) return CommonResponse.validateFailed('上级科室ID不合法');
      if (sortOrder == null) return CommonResponse.validateFailed('排序必须是整数');
      if (isActive == null) return CommonResponse.validateFailed('启用状态不合法');
      if (!_validNullableText(phone, maxLength: 20)) return CommonResponse.validateFailed('联系电话不能超过20字');
      if (!_validNullableText(description, maxLength: 500)) return CommonResponse.validateFailed('备注不能超过500字');
      if (parentId == id) return CommonResponse.failed('科室不能设为自己的上级');
      if (parentId != 0 && await _findDepartment(session, tenantId, parentId) == null) {
        return CommonResponse.failed('上级科室不存在或已删除');
      }
      if (parentId != 0 && await _isDescendant(session, tenantId, id, parentId)) {
        return CommonResponse.failed('不能将科室移动到自己的下级科室');
      }
      if (await _departmentDuplicate(session, tenantId, 'name', name, exceptId: id)) {
        return CommonResponse.failed('科室名称已存在');
      }
      if (await _departmentDuplicate(session, tenantId, 'code', code, exceptId: id)) {
        return CommonResponse.failed('科室编码已存在');
      }

      final now = DateTime.now();
      final actor = session.authenticated!.userIdentifier;
      await ZhongyiDepartment.db.updateWhere(
        session,
        columnValues: (t) => [
          t.name(name),
          t.code(code),
          t.parentId(parentId),
          t.sortOrder(sortOrder),
          t.isActive(isActive),
          t.phone(phone),
          t.description(description),
          t.updater(actor),
          t.updateTime(now),
        ],
        where: (t) => _departmentScope(t, tenantId) & t.id.equals(id),
      );

      final updated = await _findDepartment(session, tenantId, id);
      return updated == null ? CommonResponse.failed('科室不存在或已删除') : CommonResponse.success(departmentToJson(updated));
    } catch (_) {
      return CommonResponse.failed('更新科室失败');
    }
  }

  static Future<CommonResponse> deleteDepartments(Session session, List<int> ids) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();
    final normalizedIds = ids.where((id) => id > 0).toSet();
    if (normalizedIds.isEmpty) return CommonResponse.validateFailed('科室ID列表不能为空');

    try {
      final tenantId = tenantIdOf(session);
      final rows = await ZhongyiDepartment.db.find(
        session,
        where: (t) => _departmentScope(t, tenantId) & t.id.inSet(normalizedIds),
      );
      if (rows.length != normalizedIds.length) return CommonResponse.failed('部分科室不存在或已删除');

      final children = await ZhongyiDepartment.db.find(
        session,
        where: (t) => _departmentScope(t, tenantId) & t.parentId.inSet(normalizedIds),
      );
      if (children.any((child) => !normalizedIds.contains(child.id))) {
        return CommonResponse.failed('科室存在下级科室，请先删除下级科室');
      }

      final now = DateTime.now();
      final actor = session.authenticated!.userIdentifier;
      await ZhongyiDepartment.db.updateWhere(
        session,
        columnValues: (t) => [t.deleted(true), t.updater(actor), t.updateTime(now)],
        where: (t) => _departmentScope(t, tenantId) & t.id.inSet(normalizedIds),
      );
      return CommonResponse.success({'deleted_count': rows.length});
    } catch (_) {
      return CommonResponse.failed('删除科室失败');
    }
  }

  static Future<CommonResponse> listStaff(
    Session session, {
    int? pageNo,
    int? pageSize,
    String? employeeCode,
    int? departmentId,
    bool? isDoctor,
    bool? isPharmacist,
    String? professionalTitle,
  }) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();

    try {
      final tenantId = tenantIdOf(session);
      final (safePage, safeSize) = _page(pageNo, pageSize);
      final normalizedCode = _trimmed(employeeCode);
      final normalizedTitle = _trimmed(professionalTitle);

      Expression where(ZhongyiStaffTable t) {
        final conditions = <Expression>[_staffScope(t, tenantId)];
        if (normalizedCode != null) conditions.add(t.employeeCode.like('%$normalizedCode%'));
        if (normalizedTitle != null) conditions.add(t.professionalTitle.like('%$normalizedTitle%'));
        if (departmentId != null) conditions.add(t.departmentId.equals(departmentId));
        if (isDoctor != null) conditions.add(t.isDoctor.equals(isDoctor));
        if (isPharmacist != null) conditions.add(t.isPharmacist.equals(isPharmacist));
        return conditions.reduce((left, right) => left & right);
      }

      final rows = await ZhongyiStaff.db.find(
        session,
        where: where,
        orderByList: (t) => [t.id.desc()],
        limit: safeSize,
        offset: (safePage - 1) * safeSize,
      );
      final total = await ZhongyiStaff.db.count(session, where: where);
      return CommonResponse.success({
        'page_no': safePage,
        'page_size': safeSize,
        'total': total,
        'has_next': safePage * safeSize < total,
        'items': rows.map(staffToJson).toList(growable: false),
      });
    } catch (_) {
      return CommonResponse.failed('获取员工列表失败');
    }
  }

  static Future<CommonResponse> staffDetail(Session session, int id) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();
    if (id <= 0) return CommonResponse.validateFailed('员工ID必须是正整数');

    try {
      final tenantId = tenantIdOf(session);
      final row = await ZhongyiStaff.db.findFirstRow(session, where: (t) => _staffScope(t, tenantId) & t.id.equals(id));
      return row == null ? CommonResponse.failed('员工不存在或已删除') : CommonResponse.success(staffToJson(row));
    } catch (_) {
      return CommonResponse.failed('获取员工详情失败');
    }
  }

  static Future<CommonResponse> createStaff(Session session, Map<String, dynamic> body) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();

    final userId = _positiveInteger(body['user_id']);
    final employeeCode = _trimmed(body['employee_code']);
    if (userId == null) return CommonResponse.validateFailed('user_id 必须是正整数');
    if (employeeCode == null || employeeCode.length > 50) {
      return CommonResponse.validateFailed('员工编号不能为空且不能超过50字');
    }

    final departmentId = body.containsKey('department_id') ? _optionalPositiveInteger(body['department_id']) : null;
    final professionalTitle = _trimmed(body['professional_title']);
    final licenseNumber = _trimmed(body['license_number']);
    final specialization = _trimmed(body['specialization']);
    final introduction = _trimmed(body['introduction']);
    final description = _trimmed(body['description']);
    final isDoctor = body.containsKey('is_doctor') ? _boolean(body['is_doctor']) : false;
    final isPharmacist = body.containsKey('is_pharmacist') ? _boolean(body['is_pharmacist']) : false;
    final consultationFee = body.containsKey('consultation_fee') ? _nonNegativeDouble(body['consultation_fee']) : 0.0;
    if (body.containsKey('department_id') && body['department_id'] != null && departmentId == null) {
      return CommonResponse.validateFailed('科室ID不合法');
    }
    if (!_validNullableText(professionalTitle, maxLength: 100)) return CommonResponse.validateFailed('职称不能超过100字');
    if (!_validNullableText(licenseNumber, maxLength: 100)) return CommonResponse.validateFailed('执业证号不能超过100字');
    if (!_validNullableText(specialization, maxLength: 200)) return CommonResponse.validateFailed('专长不能超过200字');
    if (!_validNullableText(description, maxLength: 500)) return CommonResponse.validateFailed('备注不能超过500字');
    if (isDoctor == null || isPharmacist == null) return CommonResponse.validateFailed('员工岗位标记不合法');
    if (consultationFee == null) return CommonResponse.validateFailed('诊金必须是非负有限数值');

    try {
      final tenantId = tenantIdOf(session);
      if (await _findUser(session, tenantId, userId) == null) return CommonResponse.failed('系统用户不存在或已删除');
      if (departmentId != null && await _findDepartment(session, tenantId, departmentId) == null) {
        return CommonResponse.failed('科室不存在或已删除');
      }
      if (await _staffDuplicate(session, tenantId, 'user', userId)) {
        return CommonResponse.failed('该系统用户已关联其他员工');
      }
      if (await _staffDuplicate(session, tenantId, 'employee_code', employeeCode)) {
        return CommonResponse.failed('员工编号已存在');
      }

      final now = DateTime.now();
      final actor = session.authenticated!.userIdentifier;
      final inserted = await ZhongyiStaff.db.insertRow(
        session,
        ZhongyiStaff(
          tenantId: tenantId,
          userId: userId,
          departmentId: departmentId,
          employeeCode: employeeCode,
          professionalTitle: professionalTitle,
          licenseNumber: licenseNumber,
          specialization: specialization,
          isDoctor: isDoctor,
          isPharmacist: isPharmacist,
          consultationFee: consultationFee,
          introduction: introduction,
          description: description,
          deleted: false,
          creator: actor,
          createTime: now,
          updater: actor,
          updateTime: now,
        ),
      );
      return CommonResponse.success(staffToJson(inserted));
    } catch (_) {
      return CommonResponse.failed('创建员工失败');
    }
  }

  static Future<CommonResponse> updateStaff(Session session, int id, Map<String, dynamic> body) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();
    if (id <= 0) return CommonResponse.validateFailed('员工ID必须是正整数');

    try {
      final tenantId = tenantIdOf(session);
      final current = await _findStaff(session, tenantId, id);
      if (current == null) return CommonResponse.failed('员工不存在或已删除');

      final userId = body.containsKey('user_id') ? _positiveInteger(body['user_id']) : current.userId;
      final employeeCode = body.containsKey('employee_code') ? _trimmed(body['employee_code']) : current.employeeCode;
      if (userId == null) return CommonResponse.validateFailed('user_id 必须是正整数');
      if (employeeCode == null || employeeCode.length > 50) {
        return CommonResponse.validateFailed('员工编号不能为空且不能超过50字');
      }

      final departmentId = body.containsKey('department_id')
          ? _optionalPositiveInteger(body['department_id'])
          : current.departmentId;
      final professionalTitle = body.containsKey('professional_title')
          ? _trimmed(body['professional_title'])
          : current.professionalTitle;
      final licenseNumber = body.containsKey('license_number')
          ? _trimmed(body['license_number'])
          : current.licenseNumber;
      final specialization = body.containsKey('specialization')
          ? _trimmed(body['specialization'])
          : current.specialization;
      final introduction = body.containsKey('introduction') ? _trimmed(body['introduction']) : current.introduction;
      final description = body.containsKey('description') ? _trimmed(body['description']) : current.description;
      final isDoctor = body.containsKey('is_doctor') ? _boolean(body['is_doctor']) : current.isDoctor;
      final isPharmacist = body.containsKey('is_pharmacist') ? _boolean(body['is_pharmacist']) : current.isPharmacist;
      final consultationFee = body.containsKey('consultation_fee')
          ? _nonNegativeDouble(body['consultation_fee'])
          : current.consultationFee;

      if (body.containsKey('department_id') && body['department_id'] != null && departmentId == null) {
        return CommonResponse.validateFailed('科室ID不合法');
      }
      if (!_validNullableText(professionalTitle, maxLength: 100)) return CommonResponse.validateFailed('职称不能超过100字');
      if (!_validNullableText(licenseNumber, maxLength: 100)) return CommonResponse.validateFailed('执业证号不能超过100字');
      if (!_validNullableText(specialization, maxLength: 200)) return CommonResponse.validateFailed('专长不能超过200字');
      if (!_validNullableText(description, maxLength: 500)) return CommonResponse.validateFailed('备注不能超过500字');
      if (isDoctor == null || isPharmacist == null) return CommonResponse.validateFailed('员工岗位标记不合法');
      if (consultationFee == null) return CommonResponse.validateFailed('诊金必须是非负有限数值');

      if (await _findUser(session, tenantId, userId) == null) return CommonResponse.failed('系统用户不存在或已删除');
      if (departmentId != null && await _findDepartment(session, tenantId, departmentId) == null) {
        return CommonResponse.failed('科室不存在或已删除');
      }
      if (await _staffDuplicate(session, tenantId, 'user', userId, exceptId: id)) {
        return CommonResponse.failed('该系统用户已关联其他员工');
      }
      if (await _staffDuplicate(session, tenantId, 'employee_code', employeeCode, exceptId: id)) {
        return CommonResponse.failed('员工编号已存在');
      }

      final now = DateTime.now();
      final actor = session.authenticated!.userIdentifier;
      await ZhongyiStaff.db.updateWhere(
        session,
        columnValues: (t) => [
          t.userId(userId),
          t.departmentId(departmentId),
          t.employeeCode(employeeCode),
          t.professionalTitle(professionalTitle),
          t.licenseNumber(licenseNumber),
          t.specialization(specialization),
          t.isDoctor(isDoctor),
          t.isPharmacist(isPharmacist),
          t.consultationFee(consultationFee),
          t.introduction(introduction),
          t.description(description),
          t.updater(actor),
          t.updateTime(now),
        ],
        where: (t) => _staffScope(t, tenantId) & t.id.equals(id),
      );
      final updated = await _findStaff(session, tenantId, id);
      return updated == null ? CommonResponse.failed('员工不存在或已删除') : CommonResponse.success(staffToJson(updated));
    } catch (_) {
      return CommonResponse.failed('更新员工失败');
    }
  }

  static Future<CommonResponse> deleteStaff(Session session, List<int> ids) async {
    if (session.authenticated == null) return CommonResponse.unauthorized();
    final normalizedIds = ids.where((id) => id > 0).toSet();
    if (normalizedIds.isEmpty) return CommonResponse.validateFailed('员工ID列表不能为空');

    try {
      final tenantId = tenantIdOf(session);
      final rows = await ZhongyiStaff.db.find(
        session,
        where: (t) => _staffScope(t, tenantId) & t.id.inSet(normalizedIds),
      );
      if (rows.length != normalizedIds.length) return CommonResponse.failed('部分员工不存在或已删除');

      final now = DateTime.now();
      final actor = session.authenticated!.userIdentifier;
      await ZhongyiStaff.db.updateWhere(
        session,
        columnValues: (t) => [t.deleted(true), t.updater(actor), t.updateTime(now)],
        where: (t) => _staffScope(t, tenantId) & t.id.inSet(normalizedIds),
      );
      return CommonResponse.success({'deleted_count': rows.length});
    } catch (_) {
      return CommonResponse.failed('删除员工失败');
    }
  }

  static List<Map<String, dynamic>> buildDepartmentTree(List<ZhongyiDepartment> rows) {
    final orderedRows = [...rows]
      ..sort((left, right) {
        final bySort = left.sortOrder.compareTo(right.sortOrder);
        return bySort != 0 ? bySort : (left.id ?? 0).compareTo(right.id ?? 0);
      });
    final nodes = <int, Map<String, dynamic>>{};
    for (final row in orderedRows) {
      final id = row.id;
      if (id == null) continue;
      nodes[id] = {...departmentToJson(row), 'children': <Map<String, dynamic>>[]};
    }

    final roots = <Map<String, dynamic>>[];
    for (final row in orderedRows) {
      final id = row.id;
      if (id == null) continue;
      final node = nodes[id]!;
      final parentId = row.parentId;
      final parent = parentId == null || parentId <= 0 ? null : nodes[parentId];
      if (parent == null || parentId == id) {
        roots.add(node);
      } else {
        (parent['children'] as List<Map<String, dynamic>>).add(node);
      }
    }

    // Damaged legacy data may contain a cycle with no root. Expose any still-unreachable
    // node as a root so the tree endpoint never silently drops an otherwise visible row.
    final reachable = <int>{};
    void visit(Map<String, dynamic> node) {
      final id = node['id'] as int;
      if (!reachable.add(id)) return;
      for (final child in node['children'] as List<Map<String, dynamic>>) {
        visit(child);
      }
    }

    for (final root in roots) {
      visit(root);
    }
    for (final row in orderedRows) {
      final id = row.id;
      if (id != null && !reachable.contains(id)) {
        final root = nodes[id]!;
        roots.add(root);
        visit(root);
      }
    }
    _sortTreeNodes(roots);
    return roots;
  }

  static Map<String, dynamic> departmentToJson(ZhongyiDepartment row) => {
    'id': row.id,
    'name': row.name,
    'code': row.code,
    'parent_id': row.parentId,
    'sort_order': row.sortOrder,
    'is_active': row.isActive,
    'phone': row.phone,
    'description': row.description,
    'create_time': row.createTime,
    'update_time': row.updateTime,
  };

  static Map<String, dynamic> staffToJson(ZhongyiStaff row) => {
    'id': row.id,
    'user_id': row.userId,
    'department_id': row.departmentId,
    'employee_code': row.employeeCode,
    'professional_title': row.professionalTitle,
    'license_number': row.licenseNumber,
    'specialization': row.specialization,
    'is_doctor': row.isDoctor,
    'is_pharmacist': row.isPharmacist,
    'consultation_fee': row.consultationFee,
    'introduction': row.introduction,
    'description': row.description,
    'create_time': row.createTime,
    'update_time': row.updateTime,
  };

  static Expression _departmentScope(ZhongyiDepartmentTable table, int tenantId) =>
      table.tenantId.equals(tenantId) & table.deleted.equals(false);

  static Expression _staffScope(ZhongyiStaffTable table, int tenantId) =>
      table.tenantId.equals(tenantId) & table.deleted.equals(false);

  static Future<ZhongyiDepartment?> _findDepartment(Session session, int tenantId, int id) =>
      ZhongyiDepartment.db.findFirstRow(session, where: (t) => _departmentScope(t, tenantId) & t.id.equals(id));

  static Future<ZhongyiStaff?> _findStaff(Session session, int tenantId, int id) =>
      ZhongyiStaff.db.findFirstRow(session, where: (t) => _staffScope(t, tenantId) & t.id.equals(id));

  static Future<SysUser?> _findUser(Session session, int tenantId, int id) => SysUser.db.findFirstRow(
    session,
    where: (t) => t.tenantId.equals(tenantId) & t.deleted.equals(false) & t.id.equals(id),
  );

  static Future<bool> _departmentDuplicate(
    Session session,
    int tenantId,
    String field,
    String value, {
    int? exceptId,
  }) async {
    final found = await ZhongyiDepartment.db.findFirstRow(
      session,
      where: (t) {
        Expression condition = _departmentScope(t, tenantId);
        condition = condition & (field == 'name' ? t.name.equals(value) : t.code.equals(value));
        if (exceptId != null) condition = condition & t.id.notEquals(exceptId);
        return condition;
      },
    );
    return found != null;
  }

  static Future<bool> _staffDuplicate(
    Session session,
    int tenantId,
    String field,
    Object value, {
    int? exceptId,
  }) async {
    final found = await ZhongyiStaff.db.findFirstRow(
      session,
      where: (t) {
        Expression condition = _staffScope(t, tenantId);
        condition =
            condition & (field == 'user' ? t.userId.equals(value as int) : t.employeeCode.equals(value as String));
        if (exceptId != null) condition = condition & t.id.notEquals(exceptId);
        return condition;
      },
    );
    return found != null;
  }

  static Future<bool> _isDescendant(Session session, int tenantId, int ancestorId, int candidateId) async {
    final rows = await ZhongyiDepartment.db.find(session, where: (t) => _departmentScope(t, tenantId));
    final childrenByParent = <int, List<int>>{};
    for (final row in rows) {
      final id = row.id;
      final parentId = row.parentId;
      if (id == null || parentId == null || parentId <= 0) continue;
      (childrenByParent[parentId] ??= <int>[]).add(id);
    }

    final visited = <int>{};
    final queue = <int>[ancestorId];
    while (queue.isNotEmpty) {
      final current = queue.removeAt(0);
      if (!visited.add(current)) continue;
      if (current == candidateId) return true;
      queue.addAll(childrenByParent[current] ?? const <int>[]);
    }
    return false;
  }

  static (int, int) _page(int? pageNo, int? pageSize) {
    final page = pageNo == null || pageNo < 1 ? 1 : pageNo;
    final requestedSize = pageSize == null || pageSize < 1 ? QueryDTO.defaultPageSize : pageSize;
    final size = math.min(requestedSize, CrudConfig.maxPageSize);
    return (page, size);
  }

  static String? _trimmed(Object? value) {
    if (value == null) return null;
    final result = value.toString().trim();
    return result.isEmpty ? null : result;
  }

  static bool _validNullableText(String? value, {required int maxLength}) => value == null || value.length <= maxLength;

  static int? _integer(Object? value) {
    if (value is int) return value;
    if (value is num && value.isFinite && value == value.roundToDouble()) return value.toInt();
    return int.tryParse(value?.toString() ?? '');
  }

  static int? _positiveInteger(Object? value) {
    final parsed = _integer(value);
    return parsed != null && parsed > 0 ? parsed : null;
  }

  static int? _optionalPositiveInteger(Object? value) => value == null ? null : _positiveInteger(value);

  static int? _parentId(Object? value) {
    if (value == null) return 0;
    final parsed = _integer(value);
    return parsed != null && parsed >= 0 ? parsed : null;
  }

  static bool? _boolean(Object? value) => switch (value) {
    final bool boolean => boolean,
    final num number when number == 0 || number == 1 => number == 1,
    final String text when text.trim().toLowerCase() == 'true' || text.trim() == '1' => true,
    final String text when text.trim().toLowerCase() == 'false' || text.trim() == '0' => false,
    _ => null,
  };

  static double? _nonNegativeDouble(Object? value) {
    final parsed = value is num ? value.toDouble() : double.tryParse(value?.toString() ?? '');
    return parsed != null && parsed.isFinite && parsed >= 0 ? parsed : null;
  }

  static void _sortTreeNodes(List<Map<String, dynamic>> nodes) {
    nodes.sort((left, right) {
      final bySort = (left['sort_order'] as int).compareTo(right['sort_order'] as int);
      return bySort != 0 ? bySort : (left['id'] as int).compareTo(right['id'] as int);
    });
    for (final node in nodes) {
      _sortTreeNodes(node['children'] as List<Map<String, dynamic>>);
    }
  }
}
