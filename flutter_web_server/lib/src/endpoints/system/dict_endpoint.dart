import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/shared.dart';
import 'package:serverpod_auth_idp_server/core.dart';

/// 字典管理接口
///
/// - 字典类型：sys_dict_type
/// - 字典数据：sys_dict_data
/// - 提供基础的增删改查能力
class DictEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// 获取字典数据（按字典类型分组）
  ///
  /// 返回数据格式：{ "TYPE": [{"label":"xxx","value":1,"tagProps":{...}}] }
  @unauthenticatedClientCall
  Future<CommonResponse> getDictData(Session session, {int? tenantId}) async {
    try {
      // final authInfo = session.authenticated;
      // if (authInfo == null) {
      //   return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      // }

      final rows = await SysDictData.db.find(
        session,
        where: (t) {
          Expression filter = t.deleted.equals(false);
          if (tenantId != null) {
            filter = filter & t.tenantId.equals(tenantId);
          }
          return filter;
        },
        orderByList: (t) => [Order(column: t.code), Order(column: t.sort), Order(column: t.id)],
      );

      final Map<String, List<Map<String, dynamic>>> result = {};
      for (final row in rows) {
        final dictType = row.code;
        if (dictType.isEmpty) {
          continue;
        }
        final item = <String, dynamic>{'label': row.name, 'value': row.value};
        if (row.color != null && row.color!.trim().isNotEmpty) {
          item['tagProps'] = {'color': row.color};
        }
        result.putIfAbsent(dictType, () => []).add(item);
      }

      return CommonResponse.success(result);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '获取字典数据失败：$e');
    }
  }

//* ********************************************************************************************************************* */




  /// 获取字典类型列表
  ///
  /// [tenantId] 租户ID
  /// [name] 字典名称（模糊匹配）
  /// [type] 字典类型（模糊匹配）
  /// [status] 状态（0=停用 1=正常）
  /// 返回值：字典类型列表
  Future<CommonResponse> getDictCodeList(Session session, {int? tenantId, String? name, String? code, int? status}) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final trimmedName = name?.trim();
      final trimmedCode = code?.trim();

      final list = await SysDictCode.db.find(
        session,
        where: (t) {
          Expression filter = t.deleted.equals(false);

          if (tenantId != null) {
            filter = filter & t.tenantId.equals(tenantId);
          }

          if (trimmedName != null && trimmedName.isNotEmpty) {
            filter = filter & t.name.like('%$trimmedName%');
          }

          if (trimmedCode != null && trimmedCode.isNotEmpty) {
            filter = filter & t.code.like('%$trimmedCode%');
          }

          if (status != null) {
            filter = filter & t.status.equals(status);
          }

          return filter;
        },
        orderByList: (t) => [Order(column: t.id)],
      );

      return CommonResponse.success(list);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '获取字典类型失败：$e');
    }
  }



  /// 获取字典类型详情
  ///
  /// [id] 字典类型ID
  /// 返回值：字典类型详情
  Future<CommonResponse> getDictCodeDetail(Session session, int id) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      if (id <= 0) {
        return CommonResponse.failed('参数不合法：id 必须大于 0');
      }

      final dictCode = await SysDictCode.db.findFirstRow(
        session,
        where: (t) => t.id.equals(id) & t.deleted.equals(false),
      );

      if (dictCode == null) {
        return CommonResponse.failed('字典类型不存在或已删除');
      }

      return CommonResponse.success(dictCode);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '获取字典类型详情失败：$e');
    }
  }


  /// 新增字典类型
  ///
  /// [req] 字典类型信息
  Future<CommonResponse> addDictCode(Session session, SysDictCode req) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final name = req.name.trim();
      final code = req.code.trim();
      if (name.isEmpty || code.isEmpty) {
        return CommonResponse.failed('字典名称和类型不能为空');
      }

      final duplicated = await SysDictCode.db.findFirstRow(session, where: (t) => t.code.equals(code) & t.deleted.equals(false));
      if (duplicated != null) {
        return CommonResponse.failed('字典类型已存在');
      }

      final now = DateTime.now();
      final entity = SysDictCode(
        tenantId: req.tenantId,
        name: name,
        code: code,
        status: req.status,
        remark: req.remark,
        creator: authInfo.userIdentifier,
        createTime: now,
        updater: authInfo.userIdentifier,
        updateTime: now,
        deleted: false,
      );

      final inserted = await SysDictCode.db.insertRow(session, entity);
      return CommonResponse.success(inserted);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '新增字典类型失败：$e');
    }
  }



  /// 更新字典类型
  ///
  /// [req] 字典类型信息（需包含 id）
  Future<CommonResponse> updateDictCode(Session session, int id, String code, String name, int status, String remark) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse.failed('未登录');
      }

      final existing = await SysDictCode.db.findFirstRow(session, where: (t) => t.id.equals(id) & t.deleted.equals(false));
      if (existing == null) {
        return CommonResponse.failed('字典类型不存在或已删除');
      }

      final trimmedCode = code.trim();
      final trimmedName = name.trim();
      if (trimmedName.isEmpty || trimmedCode.isEmpty) {
        return CommonResponse.failed('字典名称和类型不能为空');
      }

      if (trimmedCode != existing.code) {
        final duplicated = await SysDictCode.db.findFirstRow(
          session,
          where: (t) => t.code.equals(trimmedCode) & t.deleted.equals(false),
        );
        if (duplicated != null) {
          return CommonResponse.failed('字典类型已存在');
        }
      }
      
      // 获取用户的租户ID
      final user = await SysUser.db.findFirstRow(session, where: (t) => t.authUserId.equals(authInfo.authUserId) & t.deleted.equals(false));
      if (user == null) {
        return CommonResponse.failed('用户不存在或已删除');
      }

      existing.tenantId =user.tenantId;
      existing.name = trimmedName;
      existing.code = trimmedCode;
      existing.status = status;
      existing.remark = remark;
      existing.updater = user.nickname;
      existing.updateTime = DateTime.now();

      final updated = await SysDictCode.db.updateRow(session, existing);
      return CommonResponse.success(updated);
    } catch (e) {
      return CommonResponse.failed('更新字典类型失败：$e');
    }
  }

  /// 删除字典类型（软删除，支持批量）
  ///
  /// [ids] 字典类型ID列表
  /// 返回值：处理结果汇总
  Future<CommonResponse> deleteDictCode(Session session, List<int> ids) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final normalizedIds = ids.where((id) => id > 0).toSet().toList();
      if (normalizedIds.isEmpty) {
        return CommonResponse.failed('参数不合法：ids 不能为空，且元素必须大于 0');
      }

      final types = await SysDictCode.db.find(session, where: (t) => t.id.inSet(normalizedIds.toSet()) & t.deleted.equals(false));

      if (types.isEmpty) {
        return CommonResponse.success({'total': normalizedIds.length, 'successCount': 0, 'notFoundCount': normalizedIds.length});
      }

      final now = DateTime.now();
      for (final type in types) {
        type.deleted = true;
        type.updater = authInfo.userIdentifier;
        type.updateTime = now;
      }
      await SysDictCode.db.update(session, types);

      final dictTypes = types.map((e) => e.code).where((e) => e.isNotEmpty).toSet();
      if (dictTypes.isNotEmpty) {
        await SysDictData.db.updateWhere(
          session,
          columnValues: (t) => [t.deleted(true), t.updater(authInfo.userIdentifier), t.updateTime(now)],
          where: (t) => t.code.inSet(dictTypes) & t.deleted.equals(false),
        );
      }

      return CommonResponse.success({
        'total': normalizedIds.length,
        'successCount': types.length,
        'notFoundCount': normalizedIds.length - types.length,
      });
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '删除字典类型失败：$e');
    }
  }






  /// 获取字典数据列表
  ///
  /// [tenantId] 租户ID
  /// [dictType] 字典类型编码
  /// [name] 字典名称（模糊匹配）
  /// [value] 字典键值（模糊匹配）
  /// [status] 状态（0=停用 1=正常）
  /// 返回值：字典数据列表
  Future<CommonResponse> getDictDataList(Session session, {int? tenantId, String? code, String? name, String? value, int? status}) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final trimmedCode = code?.trim();
      final trimmedName = name?.trim();
      final trimmedValue = value?.trim();

      final list = await SysDictData.db.find(
        session,
        where: (t) {
          Expression filter = t.deleted.equals(false);

          if (tenantId != null) {
            filter = filter & t.tenantId.equals(tenantId);
          }

          if (trimmedCode != null && trimmedCode.isNotEmpty) {
            filter = filter & t.code.equals(trimmedCode);
          }

          if (trimmedName != null && trimmedName.isNotEmpty) {
            filter = filter & t.name.like('%$trimmedName%');
          }

          if (trimmedValue != null && trimmedValue.isNotEmpty) {
            filter = filter & t.value.like('%$trimmedValue%');
          }

          if (status != null) {
            filter = filter & t.status.equals(status);
          }

          return filter;
        },
        orderByList: (t) => [Order(column: t.sort), Order(column: t.id)],
      );

      return CommonResponse.success(list);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '获取字典数据失败：$e');
    }
  }

  /// 新增字典数据
  ///
  /// [req] 字典数据信息
  Future<CommonResponse> addDictData(Session session, SysDictData req) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final name = req.name.trim();
      final value = req.value.trim();
      final code = req.code.trim();

      if (name.isEmpty || value.isEmpty || code.isEmpty) {
        return CommonResponse.failed('字典名称、键值、类型不能为空');
      }

      final dictTypeRow = await SysDictCode.db.findFirstRow(session, where: (t) => t.code.equals(code) & t.deleted.equals(false));
      if (dictTypeRow == null) {
        return CommonResponse.failed('字典类型不存在');
      }

      final duplicatedName = await SysDictData.db.findFirstRow(
        session,
        where: (t) => t.code.equals(code) & t.name.equals(name) & t.deleted.equals(false),
      );
      if (duplicatedName != null) {
        return CommonResponse.failed('字典名称已存在');
      }

      final duplicatedValue = await SysDictData.db.findFirstRow(
        session,
        where: (t) => t.code.equals(code) & t.value.equals(value) & t.deleted.equals(false),
      );
      if (duplicatedValue != null) {
        return CommonResponse.failed('字典键值已存在');
      }

      final now = DateTime.now();
      final entity = SysDictData(
        tenantId: req.tenantId,
        name: name,
        value: value,
        code: code,
        color: req.color,
        remark: req.remark,
        status: req.status,
        sort: req.sort,
        creator: authInfo.userIdentifier,
        createTime: now,
        updater: authInfo.userIdentifier,
        updateTime: now,
        deleted: false,
      );

      final inserted = await SysDictData.db.insertRow(session, entity);
      return CommonResponse.success(inserted);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '新增字典数据失败：$e');
    }
  }

  /// 更新字典数据
  ///
  /// [req] 字典数据信息（需包含 id）
  Future<CommonResponse> updateDictData(Session session, SysDictData req) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse.failed('未登录');
      }

      final id = req.id;
      if (id == null || id <= 0) {
        return CommonResponse.failed('参数不合法：字典数据ID不能为空');
      }

      final existing = await SysDictData.db.findFirstRow(session, where: (t) => t.id.equals(id) & t.deleted.equals(false));
      if (existing == null) {
        return CommonResponse.failed('字典数据不存在或已删除');
      }

      final name = req.name.trim();
      final value = req.value.trim();
      final dictType = req.code.trim();

      if (name.isEmpty || value.isEmpty || dictType.isEmpty) {
        return CommonResponse.failed('字典名称、键值、类型不能为空');
      }

      final dictTypeRow = await SysDictCode.db.findFirstRow(session, where: (t) => t.code.equals(dictType) & t.deleted.equals(false));
      if (dictTypeRow == null) {
        return CommonResponse.failed('字典类型不存在');
      }

      if (name != existing.name || dictType != existing.code) {
        final duplicatedName = await SysDictData.db.findFirstRow(
          session,
          where: (t) => t.code.equals(dictType) & t.name.equals(name) & t.deleted.equals(false) & t.id.notEquals(id),
        );
        if (duplicatedName != null) {
          return CommonResponse.failed('字典名称已存在');
        }
      }

      if (value != existing.value || dictType != existing.code) {
        final duplicatedValue = await SysDictData.db.findFirstRow(
          session,
          where: (t) => t.code.equals(dictType) & t.value.equals(value) & t.deleted.equals(false) & t.id.notEquals(id),
        );
        if (duplicatedValue != null) {
          return CommonResponse.failed('字典键值已存在');
        }
      }

      existing.tenantId = req.tenantId;
      existing.name = name;
      existing.value = value;
      existing.code = dictType;
      existing.color = req.color;
      existing.remark = req.remark;
      existing.status = req.status;
      existing.sort = req.sort;
      existing.updater = authInfo.userIdentifier;
      existing.updateTime = DateTime.now();

      final updated = await SysDictData.db.updateRow(session, existing);
      return CommonResponse.success(updated);
    } catch (e) {
      return CommonResponse.failed('更新字典数据失败：$e');
    }
  }

  /// 删除字典数据（软删除，支持批量）
  ///
  /// [ids] 字典数据ID列表
  /// 返回值：处理结果汇总
  Future<CommonResponse> deleteDictData(Session session, List<int> ids) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final normalizedIds = ids.where((id) => id > 0).toSet().toList();
      if (normalizedIds.isEmpty) {
        return CommonResponse.failed('参数不合法：ids 不能为空，且元素必须大于 0');
      }

      final rows = await SysDictData.db.find(session, where: (t) => t.id.inSet(normalizedIds.toSet()) & t.deleted.equals(false));

      if (rows.isEmpty) {
        return CommonResponse.success({'total': normalizedIds.length, 'successCount': 0, 'notFoundCount': normalizedIds.length});
      }

      final now = DateTime.now();
      for (final row in rows) {
        row.deleted = true;
        row.updater = authInfo.userIdentifier;
        row.updateTime = now;
      }
      await SysDictData.db.update(session, rows);

      return CommonResponse.success({
        'total': normalizedIds.length,
        'successCount': rows.length,
        'notFoundCount': normalizedIds.length - rows.length,
      });
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '删除字典数据失败：$e');
    }
  }










  
  /// 获取字典数据详情
  ///
  /// [id] 字典数据ID
  /// [code] 字典数据编码
  /// 返回值：字典类型详情
  Future<CommonResponse> getDictDataDetail(Session session, int id, String code) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      if (id <= 0) {
        return CommonResponse.failed('参数不合法：id 必须大于 0');
      }

      final dictCode = await SysDictData.db.findFirstRow(
        session,
        where: (t) => t.id.equals(id) & t.code.equals(code) & t.deleted.equals(false),
      );

      if (dictCode == null) {
        return CommonResponse.failed('字典数据不存在或已删除');
      }

      return CommonResponse.success(dictCode);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '获取字典数据详情失败：$e');
    }
  }

}
