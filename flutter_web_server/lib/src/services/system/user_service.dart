import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/common/common.dart';
import 'package:serverpod/serverpod.dart' as sp;
import 'package:serverpod_auth_idp_server/core.dart';
import 'package:flutter_web_server/src/security/password_hasher.dart';
import 'package:flutter_web_server/src/security/login_password_cipher.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

import 'crud_engines.dart';
import 'crud_query_helpers.dart';
import 'dept_service.dart';

/// 用户相关业务服务: 负责返回当前登录用户的信息、角色、菜单、权限等
/// 
class UserService {
  /// 根据 userIdentifier（通常是 authUserId 的字符串）批量查询用户昵称映射。
  ///
  /// 返回：key = userIdentifier，value = nickname
  static Future<Map<String, String>> getNicknameMapByUserIdentifiers(Session session, Iterable<String?> userIdentifiers) async {
    
    final normalizedIdentifiers = userIdentifiers
        .whereType<String>()
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toSet();

    if (normalizedIdentifiers.isEmpty) {
      return <String, String>{};
    }

    final authUserIds = <UuidValue>{};
    for (final identifier in normalizedIdentifiers) {
      try {
        authUserIds.add(UuidValue.fromString(identifier));
      } catch (_) {  }
    }

    if (authUserIds.isEmpty) {
      return <String, String>{};
    }

    final users = await SysUser.db.find(
      session,
      where: (t) => t.deleted.equals(false) & t.authUserId.inSet(authUserIds),
    );

    return <String, String>{
      for (final u in users)
        if (u.authUserId != null && u.nickname.trim().isNotEmpty)
          u.authUserId.toString(): u.nickname,
    };
  }

  /// 根据 userIdentifier 获取用户昵称。
  ///
  /// 未匹配到昵称时返回 null。
  Future<String?> getNicknameByUserIdentifier(Session session, String? userIdentifier) async {
    final nicknameMap = await getNicknameMapByUserIdentifiers(session, [userIdentifier]);
    return nicknameMap[userIdentifier];
  }
  

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
        // tenantId: session.targetTenantId ?? session.tenantId,
        tenantId: session.tenantId,
        deptId: req.deptId,
        username: req.username,
        phone: req.phone,
        password: hashedPassword,
        nickname: req.nickname,
        gender: req.gender,
        email: req.email,
        avatar: null, 
        type: 2, // 1系统内置 2 自定义用户
        description: req.description,
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

      // 收敛（决策 4）：插入改走 BaseService.create —— 它统一负责
      // setTenantId(resolveTenantId(session)) 与软删字段复位，并触发
      // beforeCreate/afterCreate 钩子与审计链路。
      // 注意 newUser 里已按 session.tenantId 赋过值，这里会被同一套规则重写，
      // 结果一致（仅当平台超管设了 targetTenantId 时会改用目标租户，属修复）。
      final inserted = await SystemCrudEngines.user.create(session, newUser);

      if (inserted.id != null) {
        await _saveUserRoles(
          session,
          userId: inserted.id!,
          tenantId: session.tenantId,
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
  Future<CommonResponse> getUserList(Session session, UserListRequest query) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      // deptId 传入时，先展开为「本部门 + 所有子孙部门」ID 集合
      Set<int>? deptIds;
      if (query.deptId != null) {
        deptIds = await _collectDeptAndChildrenIds(session, query.deptId!, tenantId: query.tenantId);
        if (deptIds.isEmpty) {
          // 复用同一套分页收敛规则，避免这里与 buildCrudQuery 的口径漂移
          final emptyQuery = buildCrudQuery(page: query.page, pageSize: query.pageSize);
          return PageResponse.success(
            <Map<String, dynamic>>[],
            page: emptyQuery.page,
            pageSize: emptyQuery.pageSize,
            total: 0,
          );
        }
      }

      // 收敛（决策 4）：分页 / 过滤 / 排序全部交给 BaseService.getList → QueryEngine。
      //
      // ⚠️ 三处刻意的对齐 + 一处刻意的变更：
      //   · 分页上限 100、默认 10
      //     —— 由 buildCrudQuery 的 maxPageSize/defaultPageSize 保住。
      //     QueryEngine 自身是 200/20，若不先收敛会被放大。
      //   · 默认排序 id ASC
      //     —— QueryEngine 在 sort 为空时**不做任何排序**，必须显式传，
      //     否则分页结果顺序不确定（旧实现是 orderByList: [t.id.asc()]）。
      //   · like 只传裸值
      //     —— QueryEngine 内部会拼成 LIKE '%value%'，这里不要再包 %。
      //   · 【行为变更】租户过滤
      //     —— 旧实现只在 query.tenantId != null 时才拼 tenantId 条件，
      //     而 QueryEngine **无条件**按 session.tenantId 过滤。
      //     方向上更正确（真正的多租户隔离），但回归时必须比对 total。
      final crudPage = await SystemCrudEngines.user.getList(
        session,
        buildCrudQuery(
          page: query.page,
          pageSize: query.pageSize,
          // keyword：OR 命中 username / nickname / phone（前端那个单搜索框）。
          keyword: query.keyword,
          filters: [
            // deptId：过滤本部门 + 所有子孙部门
            if (deptIds != null) condIn('deptId', deptIds),
            // username / nickname：模糊匹配；phone / email：精确匹配
            if (query.username != null && query.username!.isNotEmpty)
              condLike('username', query.username!),
            if (query.nickname != null && query.nickname!.isNotEmpty)
              condLike('nickname', query.nickname!),
            if (query.phone != null && query.phone!.isNotEmpty)
              condEq('phone', query.phone),
            if (query.email != null && query.email!.isNotEmpty)
              condEq('email', query.email),
            // status：**空值不过滤** 只有留空才能同时看到正常 + 禁用用户。
            if (query.status != null && query.status!.isNotEmpty)
              condEq('status', int.tryParse(query.status!)),
          ],
          sort: [sortAsc('id')],
        ),
      );

      // 部门名由后端反查后随行返回，前端不再拿部门树做本地 join。
      final deptNames = await DeptService.getNameMapByIds(
        session,
        crudPage.data.map((user) => user.deptId),
      );

      // 前端需要根据 disabled 控制是否可编辑/删除：
      // 约定：disabled = true 表示系统内置用户（不可编辑、不可删除），与角色模块保持一致。
      //
      // 注意：SysUser.type 标注了 !persist，数据库中没有该列，
      // 从 DB 读出的值恒为默认值 2，因此这里不能以 type 作为判定依据。
      // 统一改用已落库的真实字段 isSuperuser 判定，并派生 type 供前端「类型」列展示。
      //
      // 分页响应契约与 role_service.getRoleUsers 保持一致：
      // data = {records, total, page, pageSize, totalPage}（见 PageResponse.toJson）
      return crudPageResponse(crudPage, (user) {
        final isBuiltIn = user.isSuperuser || user.type == 1;
        final json = user.toJsonForProtocol();
        json['type'] = isBuiltIn ? 1 : 2;
        json['disabled'] = isBuiltIn;
        json['deptName'] = deptNames[user.deptId];
        return json;
      });
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '获取用户列表失败：$e');
    }
  }



  /// 收集指定部门及其所有子孙部门 ID（BFS）
  ///
  /// 一次取回全部部门（按 tenant 过滤）后在内存里建 `parentId → children` 映射再走 BFS。
  /// 原来是逐节点 `SysDept.db.find`，即「每个部门一次查询」——45 个部门就是 45 次往返。
  Future<Set<int>> _collectDeptAndChildrenIds(Session session, int rootDeptId, {int? tenantId}) async {
    final allDepts = await SysDept.db.find(
      session,
      where: (d) {
        Expression filter = d.deleted.equals(false);
        if (tenantId != null) {
          filter = filter & d.tenantId.equals(tenantId);
        }
        return filter;
      },
    );

    // parentId 在模型里是 `int?, default = 0`，根部门的 parentId 是 0 而不是 null
    final childrenOf = <int, List<int>>{};
    for (final dept in allDepts) {
      final deptId = dept.id;
      final parentId = dept.parentId;
      if (deptId == null || parentId == null) {
        continue;
      }
      (childrenOf[parentId] ??= <int>[]).add(deptId);
    }

    final visited = <int>{};
    final queue = <int>[rootDeptId];

    while (queue.isNotEmpty) {
      final currentDeptId = queue.removeAt(0);
      if (!visited.add(currentDeptId)) {
        continue;
      }
      queue.addAll(childrenOf[currentDeptId] ?? const <int>[]);
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
      user: UserInfo.fromJson(user.toJsonForProtocol()),
      posts: postsList.map((p) => p.name).toList(),
      roles: rolesList.map((r) => r.name).toList(),
      permissions: permissions,
      menus: menusList.map((m) => Menu.fromJson(m.toJsonForProtocol())).toList(),
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
            t.sort.asc(),
            t.id.asc(),
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
            t.sort.asc(),
            t.id.asc(),
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



  // /// 更新用户信息
  // ///
  // /// [req] 用户信息（需包含 id）
  Future<CommonResponse> update(Session session, UserRequest params) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse.failed('未登录');
      }

      final userId = params.id;
      if (userId == null || userId <= 0) {
        return CommonResponse.failed('参数不合法：用户ID不能为空');
      }

      // 收敛（决策 4）：读取基线改走 BaseService.get（含租户 + 软删过滤）。
      final existing = await SystemCrudEngines.user.get(session, userId);
      if (existing == null) {
        return CommonResponse.failed('用户不存在或已删除');
      }

      final username = params.username.trim();
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
        tenantId: existing.tenantId,
        roleIds: params.roleIds,
        operator: authInfo.userIdentifier,
        clearExisting: true,
      );

      existing.tenantId = existing.tenantId;
      existing.deptId = params.deptId;
      existing.username = username;
      existing.nickname = params.nickname;
      existing.phone = params.phone;
      existing.gender = params.gender;
      existing.email = params.email;
      existing.description = params.description;
      existing.status = params.status;

      // // 仅在前端传入新密码时更新密码
      // if (req.password.trim().isNotEmpty) {
      //   final plainPassword = await LoginPasswordCipher.decrypt(req.password);
      //   existing.password = PasswordHasher.hashPassword(plainPassword);
      // }

      existing.updater = authInfo.userIdentifier;
      existing.updateTime = DateTime.now();

      // 收敛（决策 4）：写回改走 BaseService.update —— 它会先按
      // id + tenantId + deleted=false 复核基线（不存在则抛 StateError），
      // 再 setTenantId / 复位软删标记后写回，并触发 beforeUpdate/afterUpdate 与审计。
      final updated = await SystemCrudEngines.user.update(session, existing);
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
      // TODO(audit): 未记审计（缺口 #1：清空该用户全部角色）—— 见 docs/audit-gaps.md
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
      // TODO(audit): 未记审计（缺口 #2：恢复被软删的角色关联）—— 见 docs/audit-gaps.md
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
    // TODO(audit): 未记审计（缺口 #3：新增角色关联）—— 见 docs/audit-gaps.md
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

      // 收敛（决策 4）：详情改走 BaseService.get —— 它按 session.tenantId + deleted=false
      // 过滤。旧实现只判 deleted、不过滤租户，属多租户隔离缺口
      // （详见 crud_engines.dart 顶部说明）。
      final user = await SystemCrudEngines.user.get(session, id);
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
      final deptNames = await DeptService.getNameMapByIds(session, [user.deptId]);
      detail['deptName'] = deptNames[user.deptId];
      detail['roleIds'] = roleIds.toList();
      detail['roles'] = roles.map((e) => e.toJsonForProtocol()).toList();

      return CommonResponse.success(detail);
    } catch (e) {
      return CommonResponse.failed('获取用户详情失败：$e');
    }
  }

  /// 删除用户（软删除）
  ///
  /// REST 层 `POST /api/user/delete` 与 Flutter 端点共用。
  /// - 系统内置用户（`isSuperuser`）不允许删除
  /// - 走软删除：`deleted = true`，与 `AutoCrudService.delete` 的口径保持一致
  /// - 因为 `existing` 是从数据库读出来的整行，`updateRow` 整行写回不会
  ///   误伤 `password` / `authUserId` 这些前端拿不到的字段
  /// - **级联**软删 `sys_user_role`（见方法内注释）
  Future<CommonResponse> delete(Session session, int id) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse.failed('未登录');
      }
      if (id <= 0) {
        return CommonResponse.failed('参数不合法：id 必须大于 0');
      }

      // 收敛（决策 4）：读取基线改走 BaseService.get（含租户 + 软删过滤）。
      final existing = await SystemCrudEngines.user.get(session, id);
      if (existing == null) {
        return CommonResponse.failed('用户不存在或已删除');
      }
      if (existing.isSuperuser) {
        return CommonResponse.failed('系统内置用户不允许删除');
      }

      // 收敛（决策 4）：软删改走 BaseService.delete —— 它内部 setDeleted(true) 后
      // updateRow，并触发 beforeDelete / afterDelete 与审计链路。
      //
      // ⚠️ 两点必须留意：
      // 1. BaseService.delete 只收 id、拿不到实体，**不维护** updater / updateTime，
      //    而原实现会写这两个字段 —— 所以先用 update 落这两个字段，再交给 delete 做软删。
      // 2. 顺序不可颠倒：CrudService.update 里有 `setDeleted(data, false)`，
      //    若先软删再 update，deleted 会被复位成 false。
      final now = DateTime.now();
      existing
        ..updater = authInfo.userIdentifier
        ..updateTime = now;
      await SystemCrudEngines.user.update(session, existing);

      final deleted = await SystemCrudEngines.user.delete(session, id);
      if (deleted == null) {
        return CommonResponse.failed('用户不存在或已删除');
      }

      // 级联软删角色关联（跨资源的关联清理，保持手写，与 role.delete 同口径）——
      // 否则删用户会在 sys_user_role 留孤儿行。按租户收窄，避免误伤同 id 的其它租户。
      // 批量删走 delegate 的默认逐条 remove，最终也落到这里，故两条路都覆盖。
      // TODO(audit): 未记审计（缺口 #4：删用户时级联软删角色关联）—— 见 docs/audit-gaps.md
      await SysUserRole.db.updateWhere(
        session,
        columnValues: (t) => [
          t.deleted(true),
          t.updater(authInfo.userIdentifier),
          t.updateTime(now),
        ],
        where: (t) =>
            t.userId.equals(id) &
            t.tenantId.equals(existing.tenantId) &
            t.deleted.equals(false),
      );

      return CommonResponse.success(null, '删除成功');
    } catch (e) {
      return CommonResponse.failed('删除用户失败：$e');
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
      // TODO(audit): 未记审计（缺口 #13：批量重置密码为默认密码）—— 见 docs/audit-gaps.md
      // ⚠️ 补的时候**绝不能**把 SysUser 塞进 before/after：toJson() 含 serverOnly 的 password。
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
