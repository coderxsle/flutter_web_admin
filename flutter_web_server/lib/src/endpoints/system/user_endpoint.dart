import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/shared.dart';
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:flutter_web_server/src/security/password_hasher.dart';
import 'package:flutter_web_server/src/security/login_password_cipher.dart';

/// 用户相关接口：负责返回当前登录用户的信息、角色、菜单、权限等
class UserEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// 创建后台管理员用户
  ///
  /// [req.password] 参数为前端使用登录公钥进行 RSA-OAEP(SHA-256) 加密后再 Base64 编码的密文，
  /// 这里会先解密得到明文密码，再使用 PBKDF2-HMAC-SHA256 哈希后写入 sys_user.password。
  Future<CommonResponse> add(Session session, UserRequest req) async {
    try {
      // 1. 仅允许已登录用户创建新用户
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录，无法创建用户');
      }

      // 2. 检查用户名是否已存在，包括禁用的用户。应该考虑一下是否需要包括了已经删除的用户
      final existUser = await SysUser.db.findFirstRow(
        session,
        where: (t) => t.username.equals(req.username) & t.deleted.equals(false),
      );
      if (existUser != null) {
        return CommonResponse(code: ResultCode.failed.code, message: '用户名已存在');
      }

      // 3. 解密前端传来的密码密文，并进行不可逆哈希
      final plainPassword = await LoginPasswordCipher.decrypt(req.password!);
      final hashedPassword = PasswordHasher.hashPassword(plainPassword);

      // 4. 创建 AuthUser（注册时调用一次）
      final authUser = await AuthServices.instance.authUsers.create(session);

      // 5. 创建对应的 UserProfile
      final userProfile = UserProfileData(fullName: req.nickname, email: req.email);
      await AuthServices.instance.userProfiles.createUserProfile(session, authUser.id, userProfile);

      // 6. 创建业务用户，并关联 authUserId
      final now = DateTime.now();
      final newUser = SysUser(
        tenantId: req.tenantId,
        deptId: req.deptId,
        username: req.username,
        phone: req.phone,
        password: hashedPassword,
        nickname: req.nickname,
        gender: req.gender,
        email: req.email,
        avatar: null, 
        type: 2, // 1系统内置 2 自定义用户
        remark: req.remark,
        status: req.status,
        isSuperuser: false,
        deleted: false,
        loginIp: null,
        loginTime: null,
        authUserId: authUser.id, // 关键：存储与 AuthUser 的关联
        updater: authInfo.userIdentifier,
        updateTime: now,
        creator: authInfo.userIdentifier,
        createTime: now,
      );

      final inserted = await SysUser.db.insertRow(session, newUser);

      if (inserted.id != null) {
        await _saveUserRoles(
          session,
          userId: inserted.id!,
          tenantId: req.tenantId,
          roleIds: req.roleIds,
          operator: authInfo.userIdentifier,
          clearExisting: false,
        );
      }

      // 返回时隐藏密码字段
      return CommonResponse.success(inserted.copyWith(password: null));
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '创建用户失败：$e');
    }
  }

  /// 获取用户列表
  ///
  /// [req] 用户列表查询参数
  /// 返回值：用户列表
  Future<CommonResponse> getList(Session session, UserListRequest req) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      // deptId 传入时，先展开为「本部门 + 所有子孙部门」ID 集合
      Set<int>? deptIds;
      if (req.deptId != null) {
        deptIds = await _collectDeptAndChildrenIds(session, req.deptId!, tenantId: req.tenantId);
        if (deptIds.isEmpty) {
          return CommonResponse.success(<SysUser>[]);
        }
      }

      final list = await SysUser.db.find(
        session,
        where: (t) {
          // 必须条件：deleted = false
          Expression filter = t.deleted.equals(false);

          // tenantId：仅当不为 null 时过滤
          if (req.tenantId != null) {
            filter = filter & t.tenantId.equals(req.tenantId);
          }

          // deptId：过滤本部门 + 所有子孙部门
          if (deptIds != null) {
            filter = filter & t.deptId.inSet(deptIds);
          }

          // username：仅当不为 null 且不为空字符串时过滤
          if (req.username != null && req.username!.isNotEmpty) {
            filter = filter & t.username.like('%${req.username!}%');
          }

          // nickname：仅当不为 null 且不为空字符串时过滤
          if (req.nickname != null && req.nickname!.isNotEmpty) {
            filter = filter & t.nickname.like('%${req.nickname!}%');
          }

          // phone：仅当不为 null 且不为空字符串时过滤
          if (req.phone != null && req.phone!.isNotEmpty) {
            filter = filter & t.phone.equals(req.phone);
          }

          // email：仅当不为 null 且不为空字符串时过滤
          if (req.email != null && req.email!.isNotEmpty) {
            filter = filter & t.email.equals(req.email);
          }

          // status：仅当不为 null 时过滤
          filter = filter & t.status.equals(int.tryParse(req.status)??1);

          return filter;
        },
        orderByList: (t) => [
          Order(column: t.id),
        ],
      );

      return CommonResponse.success(list);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '获取用户列表失败：$e');
    }
  }

  /// 收集指定部门及其所有子孙部门 ID（BFS）
  Future<Set<int>> _collectDeptAndChildrenIds(Session session, int rootDeptId, {int? tenantId}) async {
    final visited = <int>{};
    final queue = <int>[rootDeptId];

    while (queue.isNotEmpty) {
      final currentDeptId = queue.removeAt(0);
      if (!visited.add(currentDeptId)) {
        continue;
      }

      final children = await SysDept.db.find(
        session,
        where: (d) {
          Expression filter = d.deleted.equals(false) & d.parentId.equals(currentDeptId);
          if (tenantId != null) {
            filter = filter & d.tenantId.equals(tenantId);
          }
          return filter;
        },
      );

      for (final child in children) {
        final childId = child.id;
        if (childId != null && !visited.contains(childId)) {
          queue.add(childId);
        }
      }
    }

    return visited;
  }

  /// 获取当前登录管理员的完整信息（基础信息 + 岗位 + 角色 + 权限 + 菜单）
  Future<CommonResponse> getUserInfo(Session session) async {
    final authInfo = session.authenticated;
    if (authInfo == null) {
      return CommonResponse(code: ResultCode.failed.code, message: '未登录');
    }

    // 1. 查询用户
    final authUserId = authInfo.authUserId;
    final user = await SysUser.db.findFirstRow(
      session,
      where: (t) => t.authUserId.equals(authUserId) & t.deleted.equals(false),
    );
    if (user == null || user.deleted) {
      return CommonResponse(code: ResultCode.failed.code, message: '用户不存在或已被删除');
    }

    // 2. 获取用户角色
    final userRoles = await SysUserRole.db.find(session, where: (t) => t.userId.equals(user.id!) & t.deleted.equals(false));
    final roleIds = userRoles.map((r) => r.roleId).toSet();

    final rolesList = roleIds.isEmpty
        ? <SysRole>[]
        : await SysRole.db.find(session, where: (t) => t.id.inSet(roleIds) & t.deleted.equals(false));

    // 3. 根据角色获取菜单和权限
    List<SysMenu> menusList = <SysMenu>[];
    List<String> permissions = <String>[];
    if (roleIds.isNotEmpty) {
      final roleMenus = await SysRoleMenu.db.find(session, where: (t) => t.roleId.inSet(roleIds) & t.deleted.equals(false));
      final menuIds = roleMenus.map((m) => m.menuId).toSet();
      if (menuIds.isNotEmpty) {
        menusList = await SysMenu.db.find(session, where: (t) => t.id.inSet(menuIds) & t.deleted.equals(false));
        permissions = menusList.map((m) => m.permission).toSet().toList();
      }
    }

    // 4. 获取用户岗位
    final userPosts = await SysUserPost.db.find(session, where: (t) => t.userId.equals(user.id!) & t.deleted.equals(false));
    final postIds = userPosts.map((p) => p.postId).toSet();
    final postsList = postIds.isEmpty
        ? <SysPost>[]
        : await SysPost.db.find(session, where: (t) => t.id.inSet(postIds) & t.deleted.equals(false));

    // 5. 组装响应
    final userInfo = UserInfoResponse(
      user: user,
      posts: postsList.map((p) => p.name).toList(),
      roles: rolesList.map((r) => r.name).toList(),
      permissions: permissions,
      menus: menusList,
    );
    return CommonResponse.success(userInfo);
  }

  /// 获取用户路由（树形结构）
  ///
  /// - 超级管理员：返回所有正常状态菜单
  /// - 普通用户：按角色关联菜单返回
  /// - 仅返回目录(type=1)和菜单(type=2)，过滤按钮(type=3)
  /// - 结果按 parentId 组装为 children 树
  Future<CommonResponse> getUserRoutes(Session session) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final user = await SysUser.db.findFirstRow(session, where: (t) => t.authUserId.equals(authInfo.authUserId) & t.deleted.equals(false));
      if (user == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '用户不存在或已被删除');
      }

      final userRoles = await SysUserRole.db.find(session, where: (t) => t.userId.equals(user.id!) & t.deleted.equals(false));
      final roleIds = userRoles.map((e) => e.roleId).toSet();

      final rolesList = roleIds.isEmpty
          ? <SysRole>[]
          : await SysRole.db.find(session, where: (t) => t.id.inSet(roleIds) & t.deleted.equals(false));
      final roleNames = rolesList.map((r) => r.name).toList();

      List<SysMenu> menus;
      if (user.isSuperuser) {
        menus = await SysMenu.db.find(session, where: (t) => t.status.equals(1) & t.deleted.equals(false),
          orderByList: (t) => [
            Order(column: t.sort),
            Order(column: t.id),
          ],
        );
      } else {
        if (roleIds.isEmpty) {
          return CommonResponse.success(<Map<String, dynamic>>[]);
        }

        final roleMenus = await SysRoleMenu.db.find(session, where: (t) => t.roleId.inSet(roleIds) & t.deleted.equals(false));
        final menuIds = roleMenus.map((e) => e.menuId).toSet();

        if (menuIds.isEmpty) {
          return CommonResponse.success(<Map<String, dynamic>>[]);
        }

        menus = await SysMenu.db.find(session, where: (t) => t.id.inSet(menuIds) & t.status.equals(1) & t.deleted.equals(false),
          orderByList: (t) => [
            Order(column: t.sort),
            Order(column: t.id),
          ],
        );
      }

      final menuList = menus.where((m) => m.type == 1 || m.type == 2).toList();
      final routes = _buildRouteTree(menuList, roleNames);
      return CommonResponse.success(routes);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '获取用户路由失败：$e');
    }
  }

  /// 构建用户路由树
  ///
  /// [menus] 菜单列表
  /// [roleNames] 角色名称列表
  /// [parentId] 父菜单ID
  /// 返回值：路由树列表
  List<Map<String, dynamic>> _buildRouteTree(List<SysMenu> menus, List<String> roleNames, {int parentId = 0}) {
    final tree = <Map<String, dynamic>>[];

    for (final menu in menus) {
      if (menu.parentId != parentId) {
        continue;
      }

      final route = <String, dynamic>{
        'id': (menu.id ?? 0).toString(),
        'parentId': menu.parentId.toString(),
        'type': menu.type,
        'title': menu.title,
        'path': menu.path ?? '',
        'component': menu.component ?? '',
        'icon': menu.icon ?? '',
        'redirect': menu.redirect ?? '',
        'activeMenu': menu.activeMenu ?? '',
        'permission': menu.permission,
        'roles': roleNames,
        'sort': menu.sort,
        'status': menu.status,
        'hidden': !menu.visible,
        'alwaysShow': menu.alwaysShow,
        'breadcrumb': menu.breadcrumb,
        'keepAlive': menu.keepAlive,
        'showInTabs': menu.showInTabs,
        'affix': menu.affix,
      };

      final children = _buildRouteTree(menus, roleNames, parentId: menu.id ?? 0);
      route['children'] = children;
      tree.add(route);
    }

    return tree;
  }

  /// 删除用户（软删除，支持批量）
  ///
  /// [ids] 用户ID列表
  /// 返回值：处理结果汇总
  Future<CommonResponse> delete(Session session, List<int> ids) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final normalizedIds = ids.where((id) => id > 0).toSet().toList();
      if (normalizedIds.isEmpty) {
        return CommonResponse.failed('参数不合法：ids 不能为空，且元素必须大于 0');
      }

      final users = await SysUser.db.find(
        session,
        where: (t) => t.id.inSet(normalizedIds.toSet()) & t.deleted.equals(false),
      );

      if (users.isEmpty) {
        return CommonResponse.success({
          'total': normalizedIds.length,
          'successCount': 0,
          'notFoundCount': normalizedIds.length,
        });
      }

      final now = DateTime.now();
      for (final user in users) {
        user.deleted = true;
        user.updater = authInfo.userIdentifier;
        user.updateTime = now;
      }
      await SysUser.db.update(session, users);

      return CommonResponse.success({
        'total': normalizedIds.length,
        'successCount': users.length,
        'notFoundCount': normalizedIds.length - users.length,
      });
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '删除用户失败：$e');
    }
  }

  /// 更新用户信息
  ///
  /// [req] 用户信息（需包含 id）
  Future<CommonResponse> update(Session session, UserRequest req) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse.failed('未登录');
      }

      final userId = req.id;
      if (userId == null || userId <= 0) {
        return CommonResponse.failed('参数不合法：用户ID不能为空');
      }

      final existing = await SysUser.db.findFirstRow(
        session,
        where: (t) => t.id.equals(userId) & t.deleted.equals(false),
      );
      if (existing == null) {
        return CommonResponse.failed('用户不存在或已删除');
      }

      final username = req.username.trim();
      if (username.isEmpty) {
        return CommonResponse.failed('用户名不能为空');
      }

      if (username != existing.username) {
        final duplicated = await SysUser.db.findFirstRow(
          session,
          where: (t) =>
              t.username.equals(username) &
              t.deleted.equals(false) &
              t.id.notEquals(userId),
        );
        if (duplicated != null) {
          return CommonResponse.failed('用户名已存在');
        }
      }

      await _saveUserRoles(
        session,
        userId: userId,
        tenantId: req.tenantId,
        roleIds: req.roleIds,
        operator: authInfo.userIdentifier,
        clearExisting: true,
      );

      existing.tenantId = req.tenantId;
      existing.deptId = req.deptId;
      existing.username = username;
      existing.nickname = req.nickname;
      existing.phone = req.phone;
      existing.gender = req.gender;
      existing.email = req.email;
      existing.remark = req.remark;
      existing.status = req.status;

      // // 仅在前端传入新密码时更新密码
      // if (req.password.trim().isNotEmpty) {
      //   final plainPassword = await LoginPasswordCipher.decrypt(req.password);
      //   existing.password = PasswordHasher.hashPassword(plainPassword);
      // }

      existing.updater = authInfo.userIdentifier;
      existing.updateTime = DateTime.now();

      final updated = await SysUser.db.updateRow(session, existing);
      return CommonResponse.success(updated.copyWith(password: null));
    } catch (e) {
      return CommonResponse.failed('更新用户失败：$e');
    }
  }

  Future<void> _saveUserRoles(
    Session session, {
    required int userId,
    required int tenantId,
    required List<int>? roleIds,
    required String operator,
    required bool clearExisting,
  }) async {
    if (roleIds == null) {
      return;
    }

    final normalizedRoleIds = roleIds.where((id) => id > 0).toSet();
    final now = DateTime.now();

    if (clearExisting) {
      await SysUserRole.db.updateWhere(
        session,
        columnValues: (t) => [
          t.deleted(true),
          t.updater(operator),
          t.updateTime(now),
        ],
        where: (t) => t.userId.equals(userId) & t.deleted.equals(false),
      );
    }

    if (normalizedRoleIds.isEmpty) {
      return;
    }

    final existingRoles = await SysUserRole.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.roleId.inSet(normalizedRoleIds),
    );
    final existingRoleIds = existingRoles.map((e) => e.roleId).toSet();

    if (existingRoleIds.isNotEmpty) {
      await SysUserRole.db.updateWhere(
        session,
        columnValues: (t) => [
          t.deleted(false),
          t.updater(operator),
          t.updateTime(now),
        ],
        where: (t) => t.userId.equals(userId) & t.roleId.inSet(existingRoleIds),
      );
    }

    final newRoleIds = normalizedRoleIds.difference(existingRoleIds);
    if (newRoleIds.isEmpty) {
      return;
    }

    final newUserRoles = newRoleIds
        .map(
          (roleId) => SysUserRole(
            tenantId: tenantId,
            userId: userId,
            roleId: roleId,
            creator: operator,
            createTime: now,
            updater: operator,
            updateTime: now,
            deleted: false,
          ),
        )
        .toList();
    await SysUserRole.db.insert(session, newUserRoles);
  }

  /// 获取用户详情（含角色信息）
  ///
  /// [id] 用户ID
  Future<CommonResponse> getDetail(Session session, int id) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse.failed('未登录');
      }

      if (id <= 0) {
        return CommonResponse.failed('参数不合法：id 必须大于 0');
      }

      final user = await SysUser.db.findFirstRow(
        session,
        where: (t) => t.id.equals(id) & t.deleted.equals(false),
      );
      if (user == null) {
        return CommonResponse.failed('用户不存在或已删除');
      }

      final userRoles = await SysUserRole.db.find(
        session,
        where: (t) => t.userId.equals(id) & t.deleted.equals(false),
      );
      final roleIds = userRoles.map((e) => e.roleId).toSet();
      final roles = roleIds.isEmpty
          ? <SysRole>[]
          : await SysRole.db.find(session, where: (t) => t.id.inSet(roleIds) & t.deleted.equals(false));

      final detail = user.copyWith(password: null).toJsonForProtocol();
      detail['roleIds'] = roleIds.toList();
      detail['roles'] = roles.map((e) => e.toJsonForProtocol()).toList();

      return CommonResponse.success(detail);
    } catch (e) {
      return CommonResponse.failed('获取用户详情失败：$e');
    }
  }

  /// 重置密码（支持批量）
  ///
  /// 将目标用户密码统一重置为固定初始密码：`asdf1234`。
  /// [ids] 用户ID列表
  /// 返回值：处理结果汇总
  Future<CommonResponse> resetPassword(Session session, List<int> ids) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse.failed('未登录');
      }

      final normalizedIds = ids.where((id) => id > 0).toSet().toList();
      if (normalizedIds.isEmpty) {
        return CommonResponse.failed('参数不合法：ids 不能为空，且元素必须大于 0');
      }

      final users = await SysUser.db.find(
        session,
        where: (t) => t.id.inSet(normalizedIds.toSet()) & t.deleted.equals(false),
      );

      if (users.isEmpty) {
        return CommonResponse.success({
          'total': normalizedIds.length,
          'successCount': 0,
          'notFoundCount': normalizedIds.length,
          'defaultPassword': 'asdf1234',
        });
      }

      final hashedPassword = PasswordHasher.hashPassword('asdf1234');
      final now = DateTime.now();
      for (final user in users) {
        user.password = hashedPassword;
        user.updater = authInfo.userIdentifier;
        user.updateTime = now;
      }
      await SysUser.db.update(session, users);

      return CommonResponse.success({
        'total': normalizedIds.length,
        'successCount': users.length,
        'notFoundCount': normalizedIds.length - users.length,
        'defaultPassword': 'asdf1234',
      });
    } catch (e) {
      return CommonResponse.failed('重置密码失败：$e');
    }
  }


  

}

