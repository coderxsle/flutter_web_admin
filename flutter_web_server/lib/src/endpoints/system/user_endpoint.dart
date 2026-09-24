import 'package:flutter_web_server/src/services/system/user_service.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:serverpod/serverpod.dart';

/// 用户相关接口：负责返回当前登录用户的信息、角色、菜单、权限等。
///
/// ## ⚠️ 本类已「退裸」（S5 退役）
///
/// 它原先继承 `BaseEndpoint<SysUser, SysUserTable>`（业务版基类），从那里
/// **继承**来 6 条 HTTP 路由：
///
/// | 继承来的 typed 路由 | 退役后由谁提供 |
/// |---|---|
/// | `POST /user/getList` | `GET /api/user`（REST） |
/// | `POST /user/update` | `PUT\|POST /api/user/:id` |
/// | `POST /user/delete` | `DELETE /api/user/:id` |
/// | `POST /user/deleteBatch` | `DELETE /api/user` |
/// | `POST /user/addByJsonParams` | —— 已随基类删除 |
/// | `POST /user/updateByJsonParams` | —— 已随基类删除 |
///
/// 这些能力现在唯一由 REST 表现层提供（`web/routes/api/user_rest_delegate.dart`
/// ＋ `user_action_routes.dart`），**两边共用同一个 [UserService]**。
/// 留着 typed 版本只会变成「两套等价实现互相漂移」，所以一并退役。
///
/// 下面保留的 7 个方法都是**业务特定**的（套不进 CRUD 模板），每个都注明了
/// REST 侧的对应路由。
class UserEndpoint extends Endpoint {
  final UserService userService = UserService();

  /// 创建后台管理员用户 —— REST: `POST /api/user`
  ///
  /// [req.password] 参数为前端使用登录公钥进行 RSA-OAEP(SHA-256) 加密后再 Base64 编码的密文，
  /// 这里会先解密得到明文密码，再使用 PBKDF2-HMAC-SHA256 哈希后写入 sys_user.password。
  ///
  /// ⚠️ 形参名是 `req`，所以 typed 的请求体要写成 `{"req": {...}}`
  /// （REST 那边是**平铺** body）。形参名一旦改动必须重新 `serverpod generate`。
  Future<CommonResponse> add(Session session, dynamic req) async {
    return userService.add(session, req);
  }

  /// 获取用户列表 —— REST: `GET /api/user?...`
  ///
  /// [query] 用户列表查询参数
  /// 返回值：用户列表
  Future<CommonResponse> getUserList(Session session, UserListRequest query) async {
    return userService.getUserList(session, query);
  }

  /// 获取当前登录管理员的完整信息（基础信息 + 岗位 + 角色 + 权限 + 菜单）
  /// —— REST: `GET /api/user/info`
  Future<CommonResponse> getUserInfo(Session session) async {
    return userService.getUserInfo(session);
  }

  /// 获取用户路由（树形结构） —— REST: `GET /api/user/routes`
  ///
  /// - 超级管理员：返回所有正常状态菜单
  /// - 普通用户：按角色关联菜单返回
  /// - 仅返回目录(type=1)和菜单(type=2)，过滤按钮(type=3)
  /// - 结果按 parentId 组装为 children 树
  Future<CommonResponse> getUserRoutes(Session session) async {
    return userService.getUserRoutes(session);
  }

  /// 更新用户信息 —— REST: `PUT|POST /api/user/:id`
  ///
  /// [params] 用户信息（需包含 id）
  Future<CommonResponse> userUpdate(Session session, UserRequest params) async {
    return userService.update(session, params);
  }

  /// 获取用户详情（含角色信息） —— REST: `GET /api/user/:id`
  ///
  /// [id] 用户ID
  Future<CommonResponse> getDetail(Session session, int id) async {
    return userService.getDetail(session, id);
  }

  /// 重置密码（支持批量） —— REST: `POST /api/user/reset-password`
  ///
  /// 将目标用户密码统一重置为固定初始密码：`asdf1234`。
  /// [ids] 用户ID列表
  /// 返回值：处理结果汇总
  Future<CommonResponse> resetPassword(Session session, List<int> ids) async {
    return userService.resetPassword(session, ids);
  }
}
