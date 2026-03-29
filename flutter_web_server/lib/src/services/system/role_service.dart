import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';

/// 角色相关服务
class RoleService {
  
  /// 获取角色列表
  ///
  /// 当前根据 `sys_role` 表返回所有「未删除」的角色记录，
  /// 如需按租户或状态过滤，可后续扩展参数。
  static Future<CommonResponse> getList(Session session) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final roles = await SysRole.db.find(
        session,
        where: (t) => t.deleted.equals(false),
        orderByList: (t) => [
          Order(column: t.sort),
          Order(column: t.id),
        ],
      );

      // 前端需要根据 type 控制是否可编辑：
      // 约定：type = 1 为系统内置角色（不可编辑），type = 2 为自定义角色（可编辑）
      final list = roles.map((role) {
        final json = role.toJsonForProtocol();
        json['disabled'] = role.type == 1;

        // 
        // 处理时间格式：统一转为本地时间字符串，方便前端展示
        // json['createTime'] = DateTimeFormatter.format(role.createTime);
        // json['updateTime'] = DateTimeFormatter.format(role.updateTime);

        return json;
      }).toList();

      return CommonResponse.success(list);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '获取角色列表失败：$e');
    }
  }

  /// 获取角色已分配的菜单和API集合
  /// 
  /// [roleId] 角色ID
  /// 返回值：菜单ID列表
  static Future<CommonResponse> getRoleMenuIds(Session session, int roleId) async {
    final roleMenus = await SysRoleMenu.db.find(session, where: (t) => t.roleId.equals(roleId) & t.deleted.equals(false));
    return CommonResponse.success(roleMenus.map((e) => e.menuId).toSet().toList());
  }

  /// 保存角色权限（菜单）
  ///
  /// [roleId] 角色ID
  /// [menuIds] 菜单ID列表
  /// 返回值：保存结果与生效数量
  static Future<CommonResponse> saveRolePermissions(Session session, int roleId, List<int> menuIds) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse.failed('未登录');
      }

      if (roleId <= 0) {
        return CommonResponse.failed('参数不合法：roleId 必须大于 0');
      }

      final role = await SysRole.db.findFirstRow(
        session,
        where: (t) => t.id.equals(roleId) & t.deleted.equals(false),
      );
      if (role == null) {
        return CommonResponse.failed('角色不存在或已删除');
      }

      final normalizedMenuIds = menuIds.where((id) => id > 0).toSet();
      final validMenus = normalizedMenuIds.isEmpty
          ? <SysMenu>[]
          : await SysMenu.db.find(
              session,
              where: (t) => t.id.inSet(normalizedMenuIds) & t.deleted.equals(false),
            );

      final validMenuIds = validMenus.map((e) => e.id).whereType<int>().toSet();
      final invalidMenuIds = normalizedMenuIds.where((id) => !validMenuIds.contains(id)).toList();

      final now = DateTime.now();

      final existingRoleMenus = validMenuIds.isEmpty
          ? <SysRoleMenu>[]
          : await SysRoleMenu.db.find(
              session,
              where: (t) => t.roleId.equals(roleId) & t.menuId.inSet(validMenuIds),
            );

      final existingMenuIds = existingRoleMenus.map((e) => e.menuId).toSet();
      final toRestore = existingRoleMenus.where((e) => e.deleted).toList();
      final toInsertMenuIds = validMenuIds.where((id) => !existingMenuIds.contains(id)).toSet();

      await SysRoleMenu.db.updateWhere(
        session,
        columnValues: (t) => [
          t.deleted(true),
          t.updater(authInfo.userIdentifier),
          t.updateTime(now),
        ],
        where: (t) => t.roleId.equals(roleId) & t.menuId.notInSet(validMenuIds) & t.deleted.equals(false),
      );

      if (toRestore.isNotEmpty) {
        for (final item in toRestore) {
          item.deleted = false;
          item.updater = authInfo.userIdentifier;
          item.updateTime = now;
        }
        await SysRoleMenu.db.update(session, toRestore);
      }

      if (toInsertMenuIds.isNotEmpty) {
        final newRows = toInsertMenuIds.map((menuId) {
          return SysRoleMenu(
            id: null,
            tenantId: role.tenantId,
            roleId: roleId,
            menuId: menuId,
            creator: authInfo.userIdentifier,
            createTime: now,
            updater: authInfo.userIdentifier,
            updateTime: now,
            deleted: false,
          );
        }).toList();
        await SysRoleMenu.db.insert(session, newRows);
      }

      return CommonResponse.success({
        'roleId': roleId,
        'savedCount': validMenuIds.length,
        'invalidMenuIds': invalidMenuIds,
      });
    } catch (e) {
      return CommonResponse.failed('保存角色权限失败：$e');
    }
  }

  /// 获取角色的用户列表（支持分页与昵称搜索）
  ///
  /// [roleId] 角色ID
  /// [pageNum] 页码（从1开始）
  /// [pageSize] 每页条数
  /// [nickname] 昵称关键词（模糊匹配）
  /// 返回值：分页用户列表
  static Future<CommonResponse> getRoleUsers(Session session, int roleId, {int page = 1, int pageSize = 20, String? nickname}) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final safePageNum = page < 1 ? 1 : page;
      final safePageSize = pageSize < 1 ? 20 : (pageSize > 200 ? 200 : pageSize);

      // 1) 先获取角色关联的用户ID集合
      final roleUsers = await SysUserRole.db.find(session, where: (t) => t.roleId.equals(roleId) & t.deleted.equals(false));

      final userIds = roleUsers.map((e) => e.userId).toSet();
      if (userIds.isEmpty) {
        return PageResponse.success(
          <Map<String, dynamic>>[],
          page: safePageNum,
          pageSize: safePageSize,
          total: 0,
        );
      }

      // 2) 构建用户过滤条件（角色内 + 未删除 + 用户名模糊）
      Expression whereBuilder(SysUserTable t) {
        Expression filter = t.id.inSet(userIds) & t.deleted.equals(false);

        if (nickname != null && nickname.trim().isNotEmpty) {
          final keyword = nickname.trim();
          filter = filter & t.nickname.like('%$keyword%');
        }

        return filter;
      }

      // 3) 查询总数
      final total = await SysUser.db.count(session, where: whereBuilder);
      if (total == 0) {
        return PageResponse.success(
          <Map<String, dynamic>>[],
          page: safePageNum,
          pageSize: safePageSize,
          total: 0,
        );
      }

      // 4) 分页查询用户
      final users = await SysUser.db.find(
        session,
        where: whereBuilder,
        limit: safePageSize,
        offset: (safePageNum - 1) * safePageSize,
        orderByList: (t) => [
          Order(column: t.id),
        ],
      );

      // 5）返回分页用户列表
      return PageResponse.success(
        users,
        page: safePageNum,
        pageSize: safePageSize,
        total: total,
      );
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '获取角色用户列表失败：$e');
    }
  }
  

  /// 获取角色详情
  ///
  /// [id] 角色ID
  /// 返回值：角色详情
  static Future<CommonResponse> getDetail(Session session, int id) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      if (id <= 0) {
        return CommonResponse.failed('参数不合法：id 必须大于 0');
      }

      final role = await SysRole.db.findFirstRow(
        session,
        where: (t) => t.id.equals(id) & t.deleted.equals(false),
      );

      if (role == null) {
        return CommonResponse.failed('角色不存在或已删除');
      }

      return CommonResponse.success(role);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '获取角色详情失败：$e');
    }
  }

  /// 更新角色信息
  ///
  /// [req] 角色信息（需包含 id）
  static Future<CommonResponse> update(Session session, SysRole req) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse.failed('未登录');
      }

      final roleId = req.id;
      if (roleId == null || roleId <= 0) {
        return CommonResponse.failed('参数不合法：角色ID不能为空');
      }

      final existing = await SysRole.db.findFirstRow(
        session,
        where: (t) => t.id.equals(roleId) & t.deleted.equals(false),
      );
      if (existing == null) {
        return CommonResponse.failed('角色不存在或已删除');
      }

      final name = req.name.trim();
      final code = req.code.trim();
      if (name.isEmpty || code.isEmpty) {
        return CommonResponse.failed('角色名称和编码不能为空');
      }

      final tenantId = req.tenantId;

      if (name != existing.name || tenantId != existing.tenantId) {
        final duplicatedName = await SysRole.db.findFirstRow(
          session,
          where: (t) =>
              t.name.equals(name) &
              t.tenantId.equals(tenantId) &
              t.deleted.equals(false) &
              t.id.notEquals(roleId),
        );
        if (duplicatedName != null) {
          return CommonResponse.failed('角色名称已存在');
        }
      }

      if (code != existing.code || tenantId != existing.tenantId) {
        final duplicatedCode = await SysRole.db.findFirstRow(
          session,
          where: (t) =>
              t.code.equals(code) &
              t.tenantId.equals(tenantId) &
              t.deleted.equals(false) &
              t.id.notEquals(roleId),
        );
        if (duplicatedCode != null) {
          return CommonResponse.failed('角色编码已存在');
        }
      }

      existing.tenantId = tenantId;
      existing.name = name;
      existing.code = code;
      existing.sort = req.sort;
      existing.dataScope = req.dataScope;
      existing.dataScopeDeptIds = req.dataScopeDeptIds;
      existing.status = req.status;
      existing.type = req.type;
      existing.description = req.description;
      existing.menus = req.menus;
      existing.apis = req.apis;
      existing.updater = authInfo.userIdentifier;
      existing.updateTime = DateTime.now();

      final updated = await SysRole.db.updateRow(session, existing);
      return CommonResponse.success(updated);
    } catch (e) {
      return CommonResponse.failed('更新角色失败：$e');
    }
  }

  /// 删除角色（软删除，支持批量）
  ///
  /// [ids] 角色ID列表
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

      final roles = await SysRole.db.find(
        session,
        where: (t) => t.id.inSet(normalizedIds.toSet()) & t.deleted.equals(false),
      );

      if (roles.isEmpty) {
        return CommonResponse.success({
          'total': normalizedIds.length,
          'successCount': 0,
          'notFoundCount': normalizedIds.length,
        });
      }

      final now = DateTime.now();
      for (final role in roles) {
        role.deleted = true;
        role.updater = authInfo.userIdentifier;
        role.updateTime = now;
      }
      await SysRole.db.update(session, roles);

      final roleIds = roles.map((e) => e.id).whereType<int>().toSet();
      if (roleIds.isNotEmpty) {
        await SysRoleMenu.db.updateWhere(
          session,
          columnValues: (t) => [
            t.deleted(true),
            t.updater(authInfo.userIdentifier),
            t.updateTime(now),
          ],
          where: (t) => t.roleId.inSet(roleIds) & t.deleted.equals(false),
        );

        await SysUserRole.db.updateWhere(
          session,
          columnValues: (t) => [
            t.deleted(true),
            t.updater(authInfo.userIdentifier),
            t.updateTime(now),
          ],
          where: (t) => t.roleId.inSet(roleIds) & t.deleted.equals(false),
        );
      }

      return CommonResponse.success({
        'total': normalizedIds.length,
        'successCount': roles.length,
        'notFoundCount': normalizedIds.length - roles.length,
      });
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '删除角色失败：$e');
    }
  }

  /// 取消用户的角色分配，支持批量操作（软删除，幂等）
  ///
  /// [roleId] 角色ID
  /// [userIds] 用户ID列表
  /// 返回值：处理结果汇总
  static Future<CommonResponse> cancelUserRoles(Session session, int roleId, List<int> userIds) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      if (roleId <= 0) {
        return CommonResponse.failed('参数不合法：roleId 必须大于 0');
      }

      final normalizedUserIds = userIds.where((id) => id > 0).toSet().toList();
      if (normalizedUserIds.isEmpty) {
        return CommonResponse.failed('参数不合法：userIds 不能为空，且元素必须大于 0');
      }

      // 1) 校验角色是否存在
      final role = await SysRole.db.findFirstRow(
        session,
        where: (t) => t.id.equals(roleId) & t.deleted.equals(false),
      );
      if (role == null) {
        return CommonResponse.failed('角色不存在或已删除');
      }

      // 2) 获取有效用户ID
      final validUsers = await SysUser.db.find(
        session,
        where: (t) => t.id.inSet(normalizedUserIds.toSet()) & t.deleted.equals(false),
      );
      final validUserIds = validUsers.map((e) => e.id).whereType<int>().toSet();
      final invalidUserIds = normalizedUserIds.where((id) => !validUserIds.contains(id)).toList();

      if (validUserIds.isEmpty) {
        return CommonResponse.success({
          'roleId': roleId,
          'total': normalizedUserIds.length,
          'successCount': 0,
          'alreadyUnassignedCount': 0,
          'invalidUserIds': invalidUserIds,
        });
      }

      // 3) 查询当前有效的角色用户关联
      final roleUsers = await SysUserRole.db.find(
        session,
        where: (t) => t.roleId.equals(roleId) & t.userId.inSet(validUserIds) & t.deleted.equals(false),
      );

      final assignedUserIds = roleUsers.map((e) => e.userId).toSet();
      final alreadyUnassignedUserIds = validUserIds.where((id) => !assignedUserIds.contains(id)).toList();

      // 4) 批量软删除
      if (roleUsers.isNotEmpty) {
        final now = DateTime.now();
        for (final item in roleUsers) {
          item.deleted = true;
          item.updater = authInfo.userIdentifier;
          item.updateTime = now;
        }
        await SysUserRole.db.update(session, roleUsers);
      }

      return CommonResponse.success({
        'roleId': roleId,
        'total': normalizedUserIds.length,
        'successCount': roleUsers.length,
        'alreadyUnassignedCount': alreadyUnassignedUserIds.length,
        'invalidUserIds': invalidUserIds,
      });
    } catch (e) {
      return CommonResponse.failed('批量取消用户角色失败: $e');
    }
  }



}
