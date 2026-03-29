import 'package:flutter_web_server/src/services/system/dept_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';

class DeptEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// 获取部门树（按租户过滤，默认系统租户）
  /// 返回结构：id、parentId、name、sort、status、createTime、description、children
  Future<CommonResponse> getList(Session session, {String? status, String? name}) async {
    return DeptService.getList(session, status: status, name: name);
  }
  
  /// 新增部门
  ///
  /// [req] 部门信息
  Future<CommonResponse> add(Session session, DeptRequest req) async {
    return DeptService.add(session, req);
  }

  Future<CommonResponse> update(Session session, DeptRequest req) async {
    return DeptService.update(session, req);
  }

  /// 获取部门详情
  ///
  /// [id] 部门ID
  /// 返回值：部门详情
  Future<CommonResponse> getDetail(Session session, int id) async {
    return DeptService.getDetail(session, id);
  }

  /// 删除部门（软删除，支持批量）
  ///
  /// [ids] 部门ID列表
  /// 返回值：处理结果汇总
  Future<CommonResponse> delete(Session session, List<int> ids) async {
    return DeptService.delete(session, ids);
  }

}

