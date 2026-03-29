import 'package:flutter_web_server/src/services/system/role_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';

/// 规则相关接口
///
/// 当前仅提供一个基础的列表查询接口，后续可以根据具体业务补充
/// 创建、编辑、删除等方法，并接入真实数据库模型。
class RoleEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// 获取角色列表
  ///
  /// 当前根据 `sys_role` 表返回所有「未删除」的角色记录，
  /// 如需按租户或状态过滤，可后续扩展参数。
  Future<CommonResponse> getList(Session session) async {
    return RoleService.getList(session);
  }

  /// 获取角色已分配的菜单和API集合
  /// 
  /// [roleId] 角色ID
  /// 返回值：菜单ID列表
  Future<CommonResponse> getRoleMenuIds(Session session, int roleId) async {
    return RoleService.getRoleMenuIds(session, roleId);
  }

  /// 保存角色权限（菜单）
  ///
  /// [roleId] 角色ID
  /// [menuIds] 菜单ID列表
  /// 返回值：保存结果与生效数量
  Future<CommonResponse> saveRolePermissions(Session session, int roleId, List<int> menuIds) async {
    return RoleService.saveRolePermissions(session, roleId, menuIds);
  }

  /// 获取角色的用户列表（支持分页与昵称搜索）
  ///
  /// [roleId] 角色ID
  /// [pageNum] 页码（从1开始）
  /// [pageSize] 每页条数
  /// [nickname] 昵称关键词（模糊匹配）
  /// 返回值：分页用户列表
  Future<CommonResponse> getRoleUsers(Session session, int roleId, {int page = 1, int pageSize = 20, String? nickname}) async {
    return RoleService.getRoleUsers(session, roleId, page: page, pageSize: pageSize, nickname: nickname);
  }
  

  /// 获取角色详情
  ///
  /// [id] 角色ID
  /// 返回值：角色详情
  Future<CommonResponse> getDetail(Session session, int id) async {
    return RoleService.getDetail(session, id);
  }

  /// 更新角色信息
  ///
  /// [req] 角色信息（需包含 id）
  Future<CommonResponse> update(Session session, SysRole req) async {
    return RoleService.update(session, req);
  }

  /// 删除角色（软删除，支持批量）
  ///
  /// [ids] 角色ID列表
  /// 返回值：处理结果汇总
  Future<CommonResponse> delete(Session session, List<int> ids) async {
    return RoleService.delete(session, ids);
  }

  /// 取消用户的角色分配，支持批量操作（软删除，幂等）
  ///
  /// [roleId] 角色ID
  /// [userIds] 用户ID列表
  /// 返回值：处理结果汇总
  Future<CommonResponse> cancelUserRoles(Session session, int roleId, List<int> userIds) async {
    return RoleService.cancelUserRoles(session, roleId, userIds);
  }





  
}

