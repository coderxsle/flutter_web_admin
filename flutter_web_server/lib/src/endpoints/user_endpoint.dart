import 'dart:io';

import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/shared.dart';
import 'package:rsa_oaep_dart/rsa_oaep_dart.dart';

const _loginRsaPrivateKeyPath = 'config/keys/login_rsa_private.pem';

/// 用户相关接口：负责返回当前登录用户的信息、角色、菜单、权限等
class UserEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;


  /// 创建后台管理员用户
  ///
  /// [password] 参数为前端使用登录公钥进行 RSA-OAEP(SHA-256) 加密后再 Base64 编码的密文，
  /// 这里会先解密得到明文密码，再写入 sys_user.password（目前采用明文存储，与种子数据保持一致）。
  Future<CommonResponse> createUser(Session session, String username, String nickname, String password) async {
    try {
      // 1. 仅允许已登录用户创建新用户（可按需再加 isSuperuser 校验）
      final authData = session.authenticated;
      if (authData == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录，无法创建用户');
      }

      // 2. 检查用户名是否已存在
      final existUser = await SysUser.db.findFirstRow(
        session,
        where: (t) => t.username.equals(username) & t.deleted.equals(false),
      );
      if (existUser != null) {
        return CommonResponse(code: ResultCode.failed.code, message: '用户名已存在');
      }

      // 3. 解密前端传来的密码密文，得到明文密码
      final plainPassword = await _decryptLoginPassword(password);

      // 4. 创建用户（与 init.sql 中的示例保持风格相近）
      final now = DateTime.now();
      final newUser = SysUser(
        tenantId: 0,
        deptId: 1,
        username: username,
        phone: null,
        password: plainPassword,
        nickname: nickname,
        gender: 0,
        email: null,
        avatar: null,
        remark: '系统创建用户',
        status: 0, // 0: 启用（参考 init.sql 中示例）
        isSuperuser: false,
        deleted: false,
        loginIp: null,
        loginTime: null,
        updater: authData.userIdentifier,
        updateTime: now,
        creator: authData.userIdentifier,
        createTime: now,
      );

      final inserted = await SysUser.db.insertRow(session, newUser);

      // 返回时隐藏密码字段
      return CommonResponse.success(inserted.copyWith(password: null));
    } catch (e, stackTrace) {
      session.log('创建用户失败: $e\n$stackTrace');
      return CommonResponse(code: ResultCode.failed.code, message: '创建用户失败：$e');
    }
  }


  /// 获取当前登录管理员的完整信息（基础信息 + 岗位 + 角色 + 权限 + 菜单）
  ///
  Future<CommonResponse> getUserInfo(Session session) async {
    try {
      final authData = session.authenticated;
      if (authData == null) {
        return CommonResponse(code: ResultCode.failed.code, message: '未登录');
      }

      final userId = int.parse(authData.userIdentifier);

      // 1. 查询用户
      final user = await SysUser.db.findById(session, userId);
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
      final data = LoginResponse(
        user: user.copyWith(password: null),
        posts: postsList.map((p) => p.name).toList(),
        roles: rolesList.map((r) => r.name).toList(),
        permissions: permissions,
        menus: menusList,
      );

      return CommonResponse.success(data);
    } catch (e) {
      return CommonResponse(
        code: ResultCode.failed.code,
        message: '获取用户信息失败：$e',
      );
    }
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
}


