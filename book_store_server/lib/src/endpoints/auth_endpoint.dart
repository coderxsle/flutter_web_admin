import 'package:serverpod/serverpod.dart';
import 'package:book_store_server/src/generated/protocol.dart';
import 'package:book_store_shared/book_store_shared.dart';

class AuthEndpoint extends Endpoint {


  /// 管理员登录
  Future<CommonResponse> adminLogin(Session session, String username, String password) async {
    try {
      final user = await SysUser.db.findFirstRow(session,
        where: (t) => t.username.equals(username) & t.deleted.equals(false),
      );

      // 1. 验证用户名和密码
      if (user == null) return CommonResponse(code: ResultCode.failed.code, message: '用户不存在');

      // 2. 验证密码（实际项目中应该使用加密后的密码比较）
      if (user.password != password) return CommonResponse(code: ResultCode.failed.code, message: '密码错误');
      
      // 3. 更新最后登录时间
      await SysUser.db.updateRow(session, user.copyWith(loginTime: DateTime.now()));

      // 4. 生成 token
      final token = 'admin_token_${DateTime.now().millisecondsSinceEpoch}'; 

      // 5. 获取用户角色和权限
      final userRoles = await SysUserRole.db.find(
        session,
        where: (t) => t.userId.equals(user.id!) & t.deleted.equals(false),
      );
      
      List<String> roles = [];
      List<String> permissions = [];
      
      if (userRoles.isNotEmpty) {
        // 获取角色信息
        final roleIds = userRoles.map((ur) => ur.roleId).toSet();
        final rolesList = await SysRole.db.find(
          session,
          where: (t) => t.id.inSet(roleIds) & t.deleted.equals(false),
        );
        roles = rolesList.map((r) => r.name).toList();
        
        // 获取角色对应的菜单权限
        final roleMenus = await SysRoleMenu.db.find(
          session,
          where: (t) => t.roleId.inSet(roleIds) & t.deleted.equals(false),
        );
        
        if (roleMenus.isNotEmpty) {
          final menuIds = roleMenus.map((rm) => rm.menuId).toSet();
          final menus = await SysMenu.db.find(
            session,
            where: (t) => t.id.inSet(menuIds) & t.deleted.equals(false),
          );
          permissions = menus.map((m) => m.permission).toList();
        }
      }

      // 6. 返回登录响应
      final data = LoginResponse(
        token: token,
        userId: user.id.toString(),
        username: user.username,
        avatar: user.avatar,
        roles: roles,
        permissions: permissions,
      );

      // return CommonResponse(code: ResultCode.success.code, message: ResultCode.success.message, data: data);
      return CommonResponse.success(data);

    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '登录失败：$e');
    }
  }

  /// 客户登录
  Future<CommonResponse> customerLogin(Session session, String username, String password) async {
    try {
      // 1. 验证用户名和密码
      final customer = await Customer.db.findFirstRow(
        session,
        where: (t) => t.userName.equals(username) & (t.status.equals(0)),
      );
      if (customer == null) return CommonResponse(code: ResultCode.failed.code, message: '用户不存在或已被禁用');
      
      // 2. 验证密码（实际项目中应该使用加密后的密码比较）
      if (customer.password != password) return CommonResponse(code: ResultCode.failed.code, message: '密码错误');

      // 3. 更新最后登录时间
      await Customer.db.updateRow(
        session,
        customer.copyWith(updateTime: DateTime.now()),
      );
      // 4. 生成 token 并保存到 session

      // 3. 生成 token（AuthKey）并登录用户
      // final authKey = await session.db.signInUser(customer.id!);

    // 4. 将 token 存入 session 的 `serverpod_auth`（推荐）
    // session.setSessionVariable('auth_token', authKey.key);
      // session.updateAuthenticated(session.authenticated);


      // 5. 返回用户信息
      return CommonResponse(code: ResultCode.success.code, message: ResultCode.success.message, data: customer);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '登录失败：$e');
    }
  }

  /// 获取用户信息（根据 token 中的用户类型返回对应信息）
  Future<CommonResponse> getUserInfo(Session session) async {
    try {
      final authData = await session.authenticated;
      if (authData == null) return CommonResponse(code: ResultCode.failed.code, message: '未登录');

      final userId = int.parse(authData.userIdentifier);
      final authId = authData.authId;

      if (authId == null) return CommonResponse(code: ResultCode.failed.code, message: '无效的登录信息');

      switch (authId) {
        case 'admin':
          final user = await SysUser.db.findById(session, userId);
          if (user == null) return CommonResponse(code: ResultCode.failed.code, message: '用户不存在');
          return CommonResponse(code: ResultCode.success.code, message: ResultCode.success.message, data: user);
        case 'customer':
          final customer = await Customer.db.findById(session, userId);
          if (customer == null) return CommonResponse(code: ResultCode.failed.code, message: '用户不存在');
          return CommonResponse(code: ResultCode.success.code, message: ResultCode.success.message, data: customer);
        default:
          return CommonResponse(code: ResultCode.failed.code, message: '未知的用户类型');
      }
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '获取用户信息失败：$e');
    }
  }

  /// 刷新 token（统一处理管理员和客户的 token 刷新）
  Future<CommonResponse> refreshToken(Session session) async {
    try {
      final authData = await session.authenticated;
      
      if (authData == null) return CommonResponse(code: ResultCode.failed.code, message: '未登录');

      final userId = int.parse(authData.userIdentifier);
      final authId = authData.authId;

      if (authId == null) return CommonResponse(code: ResultCode.failed.code, message: '无效的登录信息');

      // 验证用户是否存在且状态正常
      switch (authId) {
        case 'admin':
          final user = await SysUser.db.findById(session, userId);
          if (user == null || user.deleted) return CommonResponse(code: ResultCode.failed.code, message: '用户不存在或已被删除');
          break;
        case 'customer':
          final customer = await Customer.db.findById(session, userId);
          if (customer == null || customer.status != 0) return CommonResponse(code: ResultCode.failed.code, message: '用户不存在或已被禁用');
          break;
        default:
          return CommonResponse(code: ResultCode.failed.code, message: '未知的用户类型');
      }

      // 生成新的 token
      final newToken = '${authId}_token_${DateTime.now().millisecondsSinceEpoch}';
      return CommonResponse(code: ResultCode.success.code, message: ResultCode.success.message, data: newToken);
    } catch (e) {
      return CommonResponse(code: ResultCode.failed.code, message: '刷新token失败：$e');
    }
  }
} 