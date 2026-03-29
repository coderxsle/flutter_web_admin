import 'package:flutter_web_server/src/services/system/menu_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';

class MenuEndpoint extends Endpoint {
  /// 添加菜单接口
  Future<CommonResponse> add(Session session, MenuRequest req) async {
    return MenuService.add(session, req);
  }


  /// 删除菜单（软删除，支持批量）
  ///
  /// [ids] 菜单ID列表
  /// 返回值：处理结果汇总
  Future<CommonResponse> delete(Session session, List<int> ids) async {
    return MenuService.delete(session, ids);
  }


  /// 更新菜单信息
  ///
  /// [req] 菜单信息（需包含 id）
  Future<CommonResponse> update(Session session, MenuRequest req) async {
    return MenuService.update(session, req);
  }


  /// 获取当前登录用户的菜单树（合并用户所有角色的菜单）
  ///
  /// 返回值：菜单树列表
  Future<CommonResponse> getMenuOptions(Session session) async {
    return MenuService.getMenuOptions(session);
  }


  /// 获取菜单列表
  ///
  /// [name] 菜单名称（模糊匹配）
  /// [status] 菜单状态（1=启用，0=停用）
  /// 返回值：菜单列表（按 sort、id 升序）
  Future<CommonResponse> getList(Session session, [String? name, String? status]) async {
    return MenuService.getList(session, name, status);
  }


  /// 获取菜单详情
  ///
  /// [id] 菜单ID
  /// 返回值：菜单详情
  Future<CommonResponse> getDetail(Session session, int id) async {
    return MenuService.getDetail(session, id);
  }


}
