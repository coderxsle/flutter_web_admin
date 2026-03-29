// import 'package:flutter_web_server/src/services/system/user_service.dart';
// import 'package:serverpod/serverpod.dart';
// import 'package:flutter_web_shared/flutter_web_shared.dart';

// /// 用户相关接口：负责返回当前登录用户的信息、角色、菜单、权限等
// class UserEndpoint extends Endpoint {
//   @override
//   bool get requireLogin => true;

//   /// 创建后台管理员用户
//   ///
//   /// [req.password] 参数为前端使用登录公钥进行 RSA-OAEP(SHA-256) 加密后再 Base64 编码的密文，
//   /// 这里会先解密得到明文密码，再使用 PBKDF2-HMAC-SHA256 哈希后写入 sys_user.password。
//   Future<CommonResponse> add(Session session, UserRequest req) async {
//     return UserService.add(session, req);
//   }

//   /// 获取用户列表
//   ///
//   /// [req] 用户列表查询参数
//   /// 返回值：用户列表
//   Future<CommonResponse> getList(Session session, UserListRequest req) async {
//     return UserService.getList(session, req);
//   }


//   /// 获取当前登录管理员的完整信息（基础信息 + 岗位 + 角色 + 权限 + 菜单）
//   Future<CommonResponse> getUserInfo(Session session) async {
//     return UserService.getUserInfo(session);
//   }

//   /// 获取用户路由（树形结构）
//   ///
//   /// - 超级管理员：返回所有正常状态菜单
//   /// - 普通用户：按角色关联菜单返回
//   /// - 仅返回目录(type=1)和菜单(type=2)，过滤按钮(type=3)
//   /// - 结果按 parentId 组装为 children 树
//   Future<CommonResponse> getUserRoutes(Session session) async {
//     return UserService.getUserRoutes(session);
//   }

//   /// 删除用户（软删除，支持批量）
//   ///
//   /// [ids] 用户ID列表
//   /// 返回值：处理结果汇总
//   Future<CommonResponse> delete(Session session, List<int> ids) async {
//     return UserService.delete(session, ids);
//   }

//   /// 更新用户信息
//   ///
//   /// [req] 用户信息（需包含 id）
//   Future<CommonResponse> update(Session session, UserRequest req) async {
//     return UserService.update(session, req);
//   }

//   /// 获取用户详情（含角色信息）
//   ///
//   /// [id] 用户ID
//   Future<CommonResponse> getDetail(Session session, int id) async {
//     return UserService.getDetail(session, id);
//   }

//   /// 重置密码（支持批量）
//   ///
//   /// 将目标用户密码统一重置为固定初始密码：`asdf1234`。
//   /// [ids] 用户ID列表
//   /// 返回值：处理结果汇总
//   Future<CommonResponse> resetPassword(Session session, List<int> ids) async {
//     return UserService.resetPassword(session, ids);
//   }

  

// }

