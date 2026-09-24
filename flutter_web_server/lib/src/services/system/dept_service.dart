import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';

import 'crud_engines.dart';

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

      // 收敛（决策 4）：全表查询走 findAllByEngine（引擎负责租户 + 软删）。
      //
      // ⚠️ 行为变更：上面的方法注释写「按租户过滤，默认系统租户」，
      // 但旧实现**完全没有租户条件** —— 收敛后才真正按 session.tenantId 过滤，
      // 与注释、与 BaseService 口径一致。
      final rows = await findAllByEngine(
        SystemCrudEngines.dept,
        session,
        where: (t) {
          final conditions = <Expression>[
            if (trimmedName != null && trimmedName.isNotEmpty)
              t.name.like('%$trimmedName%'),
            if (trimmedStatus != null && trimmedStatus.isNotEmpty)
              t.status.equals(int.tryParse(trimmedStatus)),
          ];
          if (conditions.isEmpty) return null;
          return conditions.reduce((a, b) => a & b);
        },
        orderByList: (t) => [
          t.parentId.asc(),
          t.sort.asc(),
          t.id.asc(),
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

      // 收敛（决策 4）：插入走 BaseService.create。
      final inserted = await SystemCrudEngines.dept.create(session, dept);
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

      // 收敛（决策 4）：读取基线改走 BaseService.get（含租户 + 软删过滤）。
      final existing = await SystemCrudEngines.dept.get(session, req.id!);
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

      // 收敛（决策 4）：写回走 BaseService.update（先按 id+tenantId+deleted=false 复核基线）。
      // ⚠️ 上面那行 `existing.tenantId = req.tenantId` 会被 update 内部的
      // setTenantId(resolveTenantId(session)) 覆盖成**当前登录租户**
      // —— 不能再通过入参把部门改挂到别的租户下（更安全）。
      final updated = await SystemCrudEngines.dept.update(session, existing);
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

      // 收敛（决策 4）：详情改走 BaseService.get（含租户 + 软删过滤）。
      final dept = await SystemCrudEngines.dept.get(session, id);

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

      // 收敛（决策 4）：软删走 BaseService.deleteBatch，统计直接取 CrudBatchResult。
      //
      // ⚠️ 行为变更：deleteBatch 只收 id、拿不到实体，**不维护**
      // updater / updateTime（原实现在这里会写这两个字段）。
      final batch = await SystemCrudEngines.dept.deleteBatch(session, normalizedIds);

      // 直接把 CrudBatchResult 交出去（不再手抄成 {total, successCount,
      // notFoundCount} 的 Map）：REST 侧 `POST /deleteBatch` 的响应契约需要
      // `successIds` / `failedIds` 供前端逐条提示，抄一半的 Map 会让那两个
      // 字段恒为空 —— 前端 user/index.vue 的「N 条不存在」就是这么没显示出来的。
      return CommonResponse.success(batch);
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
