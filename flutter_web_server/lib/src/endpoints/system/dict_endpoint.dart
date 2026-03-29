import 'package:serverpod/serverpod.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:flutter_web_server/src/services/system/dict_service.dart';

/// 字典管理接口
///
/// - 字典类型：sys_dict_type
/// - 字典数据：sys_dict_data
/// - 提供基础的增删改查能力
class DictEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  /// 获取字典数据（按字典类型分组）
  ///
  /// 返回数据格式：{ "TYPE": [{"label":"xxx","value":1,"tagProps":{...}}] }
  @unauthenticatedClientCall
  Future<CommonResponse> getDictData(Session session, {int? tenantId}) async {
    return DictService.getDictData(session, tenantId: tenantId);
  }

//* ********************************************************************************************************************* */

  /// 获取字典类型列表
  ///
  /// [tenantId] 租户ID
  /// [name] 字典名称（模糊匹配）
  /// [type] 字典类型（模糊匹配）
  /// [status] 状态（0=停用 1=正常）
  /// 返回值：字典类型列表
  Future<CommonResponse> getDictCodeList(Session session, {int? tenantId, String? name, String? code, String? status}) async {
    return DictService.getDictCodeList(session, tenantId: tenantId, name: name, code: code, status: status);
  } 

  /// 获取字典类型详情
  ///
  /// [id] 字典类型ID
  /// 返回值：字典类型详情
  Future<CommonResponse> getDictCodeDetail(Session session, int id) async {
    return DictService.getDictCodeDetail(session, id);
  }


  /// 新增字典类型
  ///
  /// [req] 字典类型信息
  Future<CommonResponse> addDictCode(Session session, DictCodeRequest req) async {
    return DictService.addDictCode(session, req);
  }



  /// 更新字典类型
  ///
  /// [req] 字典类型信息（需包含 id）
  Future<CommonResponse> updateDictCode(Session session, DictCodeRequest req) async {
    return DictService.updateDictCode(session, req);
  }

  /// 删除字典类型（软删除，支持批量）
  ///
  /// [ids] 字典类型ID列表
  /// 返回值：处理结果汇总
  Future<CommonResponse> deleteDictCode(Session session, List<int> ids) async {
    return DictService.deleteDictCode(session, ids);
  }


  /// 获取字典数据列表
  ///
  /// [tenantId] 租户ID
  /// [dictType] 字典类型编码
  /// [name] 字典名称（模糊匹配）
  /// [value] 字典键值（模糊匹配）
  /// [status] 状态（0=停用 1=正常）
  /// 返回值：字典数据列表
  Future<CommonResponse> getDictDataList(Session session, {int? tenantId, String? code, String? name, String? value, int? status}) async {
    return DictService.getDictDataList(session, tenantId: tenantId, code: code, name: name, value: value, status: status);
  }

  /// 新增字典数据
  ///
  /// [req] 字典数据信息
  Future<CommonResponse> addDictData(Session session, DictDataRequest req) async {
    return DictService.addDictData(session, req);
  }

  /// 更新字典数据
  ///
  /// [req] 字典数据信息（需包含 id）
  Future<CommonResponse> updateDictData(Session session, SysDictData req) async {
    return DictService.updateDictData(session, req);
  }

  /// 删除字典数据（软删除，支持批量）
  ///
  /// [ids] 字典数据ID列表
  /// 返回值：处理结果汇总
  Future<CommonResponse> deleteDictData(Session session, List<int> ids) async {
    return DictService.deleteDictData(session, ids);
  }

  /// 获取字典数据详情
  ///
  /// [id] 字典数据ID
  /// [code] 字典数据编码
  /// 返回值：字典类型详情
  Future<CommonResponse> getDictDataDetail(Session session, int id, String code) async {
    return DictService.getDictDataDetail(session, id, code);
  }

}
