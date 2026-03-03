import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/shared.dart';
import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';
import 'package:serverpod_auth_idp_server/core.dart';

const _loginRsaPrivateKeyPath = 'config/keys/login_rsa_private.pem';

/// 用户相关接口：负责返回当前登录用户的信息、角色、菜单、权限等
class UserEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;


  /// 创建后台管理员用户
  ///
  /// [password] 参数为前端使用登录公钥进行 RSA-OAEP(SHA-256) 加密后再 Base64 编码的密文，
  /// 这里会先解密得到明文密码，再写入 sys_user.password（目前采用明文存储，与种子数据保持一致）。
  Future<CommonResponse> add(Session session, String username, String nickname, String password, [String? email]) async {
  try {
    // 1. 仅允许已登录用户创建新用户
    final authInfo = session.authenticated;
    if (authInfo == null) {
      return CommonResponse(code: ResultCode.failed.code, message: '未登录，无法创建用户');
    }

    // 2. 检查用户名是否已存在，包括禁用的用户。应该考虑一下是否需要包括了已经删除的用户
    final existUser = await SysUser.db.findFirstRow(
      session,
      where: (t) => t.username.equals(username) & t.deleted.equals(false),
    );
    if (existUser != null) {
      return CommonResponse(code: ResultCode.failed.code, message: '用户名已存在');
    }

    // 3. 解密前端传来的密码密文，得到明文密码
    final plainPassword = await _decryptLoginPassword(password);

    // 4. 创建 AuthUser（注册时调用一次）
    final authUser = await AuthServices.instance.authUsers.create(session);

    // 5. 创建对应的 UserProfile
    final userProfile = UserProfileData(fullName: nickname, email: email);
    await AuthServices.instance.userProfiles.createUserProfile(session, authUser.id, userProfile);

    // 6. 创建业务用户，并关联 authUserId
    final now = DateTime.now();
    final newUser = SysUser(
      tenantId: 0,
      deptId: 1,
      username: username,
      phone: null,
      password: plainPassword,
      nickname: nickname,
      gender: 3,
      email: email,
      avatar: null,
      remark: '系统创建用户',
      status: 1,
      isSuperuser: false,
      deleted: false,
      loginIp: null,
      loginTime: null,
      authUserId: authUser.id, // 关键：存储与 AuthUser 的关联
      updater: session.authenticated!.userIdentifier,
      updateTime: now,
      creator: session.authenticated!.userIdentifier,
      createTime: now,
    );

    final inserted = await SysUser.db.insertRow(session, newUser);

    // 返回时隐藏密码字段
    return CommonResponse.success(inserted.copyWith(password: null));
  } catch (e) {
    return CommonResponse(code: ResultCode.failed.code, message: '创建用户失败：$e');
  }
}


  /// 获取用户列表
  ///
  /// [tenantId] 租户ID
  /// [deptId] 部门ID（支持查询该部门及其所有子部门）
  /// [username] 用户名
  /// [nickname] 昵称
  /// [phone] 手机号
  /// [email] 邮箱
  /// 返回值：用户列表
  Future<CommonResponse> getList(Session session, [int? tenantId = 0, int? deptId, String? username, String? nickname, String? phone, String? email, int? status = 1]) async {
    try {
      final authInfo = session.authenticated;
      if (authInfo == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      // deptId 传入时，先展开为「本部门 + 所有子孙部门」ID 集合
      Set<int>? deptIds;
      if (deptId != null) {
        deptIds = await _collectDeptAndChildrenIds(session, deptId, tenantId: tenantId);
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
          if (tenantId != null) {
            filter = filter & t.tenantId.equals(tenantId);
          }

          // deptId：过滤本部门 + 所有子孙部门
          if (deptIds != null) {
            filter = filter & t.deptId.inSet(deptIds);
          }

          // username：仅当不为 null 且不为空字符串时过滤
          if (username != null && username.isNotEmpty) {
            filter = filter & t.username.like('%$username%');
          }

          // nickname：仅当不为 null 且不为空字符串时过滤
          if (nickname != null && nickname.isNotEmpty) {
            filter = filter & t.nickname.like('%$nickname%');
          }

          // phone：仅当不为 null 且不为空字符串时过滤
          if (phone != null && phone.isNotEmpty) {
            filter = filter & t.phone.equals(phone);
          }

          // email：仅当不为 null 且不为空字符串时过滤
          if (email != null && email.isNotEmpty) {
            filter = filter & t.email.equals(email);
          }

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

  /// 解密登录/创建用户时的密码密文
  Future<String> _decryptLoginPassword(String passwordCipherBase64) async {
    try {
      final file = File(_loginRsaPrivateKeyPath);
      if (!await file.exists()) {
        throw Exception('登录私钥文件不存在');
      }
      final privateKeyPem = await file.readAsString();
      final privateKey = RSAKeyParser.parsePrivateKeyFromPem(privateKeyPem);

      final oaep = RSAOAEP(hash: SHA256Digest());
      // rsa_oaep_dart 的 decryptString 接收 Base64 编码的密文字符串并返回明文字符串
      return oaep.decryptString(passwordCipherBase64, privateKey);
    } catch (e) {
      throw Exception('密码解密失败: $e');
    }
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
        'title': menu.name,
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
        'breadcrumb': _parseBreadcrumb(menu.breadcrumb),
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

  /// 解析面包屑导航
  /// [value] 面包屑导航字符串，true 或 1 表示显示，false 或 0 表示不显示
  /// 返回值：true 表示显示，false 表示不显示
  bool _parseBreadcrumb(String? value) {
    if (value == null || value.isEmpty) return true;
    final normalized = value.trim().toLowerCase();
    return normalized == 'true' || normalized == '1';
  }

}
