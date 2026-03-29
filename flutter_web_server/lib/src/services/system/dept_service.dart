import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';

class DeptService {
  /// 获取部门树（按租户过滤，默认系统租户）
  /// 返回结构：id、parentId、name、sort、status、createTime、description、children
  static Future<CommonResponse> getList(Session session, {String? status, String? name}) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final trimmedName = name?.trim();
      final trimmedStatus = status?.trim();

      final rows = await SysDept.db.find(
        session,
        where: (t) {
          Expression filter = t.deleted.equals(false);
          if (trimmedName != null && trimmedName.isNotEmpty) {
            filter = filter & t.name.like('%$trimmedName%');
          }
          if (trimmedStatus != null && trimmedStatus.isNotEmpty) {
            filter = filter & t.status.equals(int.tryParse(trimmedStatus));
          }
          return filter;
        },
        orderByList: (t) => [
          Order(column: t.parentId),
          Order(column: t.sort),
          Order(column: t.id),
        ],
      );

      final nodeMap = <int, Map<String, dynamic>>{};
      final roots = <Map<String, dynamic>>[];

      for (final row in rows) {
        final id = row.id;
        if (id == null) continue;

        nodeMap[id] = {
          'id': id,
          'parentId': row.parentId,
          'name': row.name ?? '',
          'sort': row.sort ?? 0,
          'status': row.status ?? 0,
          'createTime': row.createTime,
          'description': row.description,
        };
      }

      for (final row in rows) {
        final id = row.id;
        if (id == null) continue;

        final node = nodeMap[id];
        if (node == null) continue;

        final parentId = row.parentId;
        if (parentId == null || !nodeMap.containsKey(parentId)) {
          roots.add(node);
        } else {
          (nodeMap[parentId]!['children'] ??= <Map<String, dynamic>>[]).add(node);
        }
      }

      _sortTree(roots);
      return CommonResponse.success(roots);
    } catch (e) {
      return CommonResponse(
        code: ResultCode.failed.code,
        message: '获取部门列表失败：$e',
      );
    }
  }

  
  /// 新增部门
  ///
  /// [req] 部门信息
  static Future<CommonResponse> add(Session session, DeptRequest req) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final name = req.name.trim();
      if (name.isEmpty) {
        return CommonResponse.failed('部门名称不能为空');
      }

      final now = DateTime.now();
      final dept = SysDept(
        id: null,
        tenantId: req.tenantId,
        parentId: req.parentId,
        name: name,
        sort: req.sort,
        status: req.status,
        description: req.description,
        creator: authInfo.userIdentifier,
        createTime: now,
        updater: authInfo.userIdentifier,
        updateTime: now,
        deleted: false,
      );

      final inserted = await SysDept.db.insertRow(session, dept);
      return CommonResponse.success(inserted);
    } catch (e) {
      return CommonResponse.failed('新增部门失败：$e');
    }
  }

  /// 更新部门信息
  ///
  /// [req] 部门信息（需包含 id）
  static Future<CommonResponse> update(Session session, DeptRequest req) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse.failed('未登录');
      }

      if (req.id == null || req.id! <= 0) {
        return CommonResponse.failed('参数不合法：部门ID不能为空');
      }

      final existing = await SysDept.db.findFirstRow(
        session,
        where: (t) => t.id.equals(req.id) & t.deleted.equals(false),
      );
      if (existing == null) {
        return CommonResponse.failed('部门不存在或已删除');
      }

      final name = req.name.trim();
      if (name.isEmpty) {
        return CommonResponse.failed('部门名称不能为空');
      }

      existing.tenantId = req.tenantId;
      existing.parentId = req.parentId;
      existing.name = name;
      existing.sort = req.sort;
      existing.status = req.status;
      existing.description = req.description;
      existing.updater = authInfo.userIdentifier;
      existing.updateTime = DateTime.now();

      final updated = await SysDept.db.updateRow(session, existing);
      return CommonResponse.success(updated);
    } catch (e) {
      return CommonResponse.failed('更新部门失败：$e');
    }
  }

  /// 获取部门详情
  ///
  /// [id] 部门ID
  /// 返回值：部门详情
  static Future<CommonResponse> getDetail(Session session, int id) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      if (id <= 0) {
        return CommonResponse.failed('参数不合法：id 必须大于 0');
      }

      final dept = await SysDept.db.findFirstRow(
        session,
        where: (t) => t.id.equals(id) & t.deleted.equals(false),
      );

      if (dept == null) {
        return CommonResponse.failed('部门不存在或已删除');
      }

      return CommonResponse.success(dept);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '获取部门详情失败：$e');
    }
  }

  /// 删除部门（软删除，支持批量）
  ///
  /// [ids] 部门ID列表
  /// 返回值：处理结果汇总
  static Future<CommonResponse> delete(Session session, List<int> ids) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final normalizedIds = ids.where((id) => id > 0).toSet().toList();
      if (normalizedIds.isEmpty) {
        return CommonResponse.failed('参数不合法：ids 不能为空，且元素必须大于 0');
      }

      final depts = await SysDept.db.find(
        session,
        where: (t) => t.id.inSet(normalizedIds.toSet()) & t.deleted.equals(false),
      );

      if (depts.isEmpty) {
        return CommonResponse.success({
          'total': normalizedIds.length,
          'successCount': 0,
          'notFoundCount': normalizedIds.length,
        });
      }

      final now = DateTime.now();
      for (final dept in depts) {
        dept.deleted = true;
        dept.updater = authInfo.userIdentifier;
        dept.updateTime = now;
      }
      await SysDept.db.update(session, depts);

      return CommonResponse.success({
        'total': normalizedIds.length,
        'successCount': depts.length,
        'notFoundCount': normalizedIds.length - depts.length,
      });
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '删除部门失败：$e');
    }
  }

  static void _sortTree(List<Map<String, dynamic>> nodes) {
    nodes.sort((a, b) {
      final sortA = (a['sort'] as int?) ?? 0;
      final sortB = (b['sort'] as int?) ?? 0;
      if (sortA != sortB) return sortA.compareTo(sortB);
      final idA = a['id']?.toString() ?? '';
      final idB = b['id']?.toString() ?? '';
      return idA.compareTo(idB);
    });

    for (final node in nodes) {
      final children = node['children'] as List<Map<String, dynamic>>? ?? const [];
      if (children.isNotEmpty) {
        _sortTree(children);
      }
    }
  }
}
