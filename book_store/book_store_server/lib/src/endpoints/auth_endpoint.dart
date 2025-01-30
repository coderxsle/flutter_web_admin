import 'package:serverpod/serverpod.dart';
import 'package:book_store_shared/book_store_shared.dart';
import 'package:book_store_server/src/generated/protocol.dart';

class AuthEndpoint extends Endpoint {
  /// 管理员登录
  Future<CommonResult<SysUser>> adminLogin(Session session, String username, String password) async {
    try {
      // 1. 验证用户名和密码
      final user = await SysUser.db.findFirstRow(session,
        where: (t) => t.username.equals(username) & t.isDeleted.equals(false),
      );
      if (user == null) {
        return CommonResult.failed('用户不存在');
      }
      // 2. 验证密码（实际项目中应该使用加密后的密码比较）
      if (user.password != password) {
        return CommonResult.failed('密码错误');
      }
      // 3. 更新最后登录时间
      await SysUser.db.updateRow(
        session,
        user.copyWith(loginTime: DateTime.now()),
      );
      // 4. 生成 token 并保存到 session
      // session.authenticationData = {
      //   'userId': user.id,
      //   'userType': 'admin',
      // };
      // 5. 返回用户信息
      return CommonResult.success(user);
    } catch (e) {
      return CommonResult.failed('登录失败：$e');
    }
  }

  /// 客户登录
  Future<CommonResult<Customer>> customerLogin(Session session, String username, String password) async {
    try {
      // 1. 验证用户名和密码
      final customer = await Customer.db.findFirstRow(
        session,
        where: (t) => t.userName.equals(username) & (t.status.equals(0)),
      );
      if (customer == null) {
        return CommonResult.failed('用户不存在或已被禁用');
      }
      // 2. 验证密码（实际项目中应该使用加密后的密码比较）
      if (customer.password != password) {
        return CommonResult.failed('密码错误');
      }
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
      return CommonResult.success(customer);
    } catch (e) {
      return CommonResult.failed('登录失败：$e');
    }
  }

  /// 获取用户信息（根据 token 中的用户类型返回对应信息）
  Future<CommonResult<dynamic>> getUserInfo(Session session) async {
    try {
      var authData;
      // final authData = AuthenticationInfo(1, {'userType': 'admin'}); 
      if (authData == null) {
        return CommonResult.failed('未登录');
      }

      final userId = authData['userId'] as int?;
      final userType = authData['userType'] as String?;

      if (userId == null || userType == null) {
        return CommonResult.failed('无效的登录信息');
      }

      switch (userType) {
        case 'admin':
          final user = await SysUser.db.findById(session, userId);
          if (user == null) {
            return CommonResult.failed('用户不存在');
          }
          return CommonResult.success(user);
        case 'customer':
          final customer = await Customer.db.findById(session, userId);
          if (customer == null) {
            return CommonResult.failed('用户不存在');
          }
          return CommonResult.success(customer);
        default:
          return CommonResult.failed('未知的用户类型');
      }
    } catch (e) {
      return CommonResult.failed('获取用户信息失败：$e');
    }
  }

  /// 刷新 token（统一处理管理员和客户的 token 刷新）
  Future<CommonResult<String>> refreshToken(Session session) async {
    try {
      // final authData = session.authenticationData;
      var authData;
      if (authData == null) {
        return CommonResult.failed('未登录');
      }

      final userId = authData['userId'] as int?;
      final userType = authData['userType'] as String?;

      if (userId == null || userType == null) {
        return CommonResult.failed('无效的登录信息');
      }

      // 验证用户是否存在且状态正常
      switch (userType) {
        case 'admin':
          final user = await SysUser.db.findById(session, userId);
          if (user == null || user.isDeleted) {
            return CommonResult.failed('用户不存在或已被删除');
          }
          break;
        case 'customer':
          final customer = await Customer.db.findById(session, userId);
          if (customer == null || customer.status != 0) {
            return CommonResult.failed('用户不存在或已被禁用');
          }
          break;
        default:
          return CommonResult.failed('未知的用户类型');
      }

      // 生成新的 token
      final newToken = '${userType}_token_${DateTime.now().millisecondsSinceEpoch}';
      return CommonResult.success(newToken);
    } catch (e) {
      return CommonResult.failed('刷新token失败：$e');
    }
  }
} 