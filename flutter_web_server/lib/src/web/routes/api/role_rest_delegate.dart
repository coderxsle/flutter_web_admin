import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/services/system/role_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

import 'rest_delegate_utils.dart';

/// 角色资源 `/api/role` 的 REST delegate。
///
/// 业务实现全部在 [RoleService]，本类只做 HTTP ↔ Service 翻译。
///
/// ## 这个资源的三个特殊点
///
/// 1. **没有「新增」**：业务侧本就没有这个动作，REST 侧不该凭空
///    造一个业务动作出来，所以注册时传 `enableCreate: false` ——
///    `POST /api/role/add` 不注册，命中 **404**（这一组路由是「一动作一路径」，
///    路径上一条路由都没有就是 404，不是方法不允许）。
///    [create] 仍必须实现（接口要求），只作为「路由配置被改错」的兜底。
/// 2. **列表是「平铺 + 注入 `disabled`」**：`RoleService.getList` 给每条记录
///    加了 `disabled: type == 1`（系统内置角色不可编辑）。这是后端服务层注入
///    的字段，前端 `useTable` 与 `selectAll` 都读它。
/// 3. **更新是「全量覆盖」**：`RoleService.update` 把
///    `tenantId / name / code / sort / dataScope / dataScopeDeptIds /
///    status / type / description / menus / apis` 全按入参重写，
///    所以 PATCH 必须先从基线补齐（见 [update]）。
class RoleRestDelegate extends RestCrudDelegate<SysRole> {
  /// `GET /api/role/getList` —— 角色列表（**非分页**，含 `disabled`）。
  ///
  /// 角色列表**不接受任何过滤参数**，这里保持一致
  /// （不假装支持 `keyword` / `status`，免得前端以为能用）。
  @override
  Future<Object?> list(Session session, Request request) async =>
      ensureOk(await RoleService.getList(session));

  /// `GET /api/role/getDetail?id=` —— 详情。
  @override
  Future<Object?> detail(Session session, int id) async =>
      requireFound<SysRole>(await RoleService.getDetail(session, id), '角色');

  /// `POST /api/role/add`
  @override
  Future<Object?> create(Session session, Map<String, dynamic> body) async {
    throw const RestException(405, '角色不支持新增：本资源未注册 add 路由', code: 405);
  }

  /// `POST /api/role/update` —— 更新（PATCH 语义，`id` 在 body 里）。
  ///
  /// ⚠️ `menus` / `apis` 必须从基线带过去：它们是 `sys_role` 上的
  /// `ColumnSerializable`（JSON 列），`RoleService.update` 会
  /// `existing.menus = req.menus` —— 不传就等于把角色的菜单/接口清空。
  ///
  /// ⚠️ `tenantId` 会参与 Service 内的**重名/重码判重**
  /// （那两个校验刻意按入参租户判，不走引擎）。传基线租户，语义保持不变。
  @override
  Future<Object?> update(
    Session session,
    int id,
    Map<String, dynamic> body,
  ) async {
    final base = requireFound<SysRole>(
      await RoleService.getDetail(session, id),
      '角色',
    );

    return ensureOk(
      await RoleService.update(
        session,
        SysRole(
          id: id,
          tenantId: patchInt(body, 'tenantId', base.tenantId) ?? base.tenantId,
          name: body.containsKey('name')
              ? requiredText(body, 'name')
              : base.name,
          code: body.containsKey('code')
              ? requiredText(body, 'code')
              : base.code,
          sort: patchInt(body, 'sort', base.sort) ?? base.sort,
          type: patchInt(body, 'type', base.type) ?? base.type,
          dataScope:
              patchInt(body, 'dataScope', base.dataScope) ?? base.dataScope,
          dataScopeDeptIds: patchIntList(
            body,
            'dataScopeDeptIds',
            base.dataScopeDeptIds,
          ),
          menus: base.menus,
          apis: base.apis,
          description: patchText(body, 'description', base.description),
          status: patchInt(body, 'status', base.status) ?? base.status,
          // 以下元数据 Service 不使用，从基线带过去只为满足生成模型的必填项。
          deleted: base.deleted,
          creator: base.creator,
          createTime: base.createTime,
          updater: base.updater,
          updateTime: base.updateTime,
        ),
      ),
    );
  }

  /// `POST /api/role/delete` —— 软删除单条。
  ///
  /// ⚠️ Service 会**级联**软删 `sys_role_menu` 与 `sys_user_role` 两个关联表
  /// （跨资源的关联清理，保持手写在那一边）。
  @override
  Future<void> remove(Session session, int id) async =>
      ensureDeleted(await RoleService.delete(session, [id]), '角色');

  /// `POST /api/role/deleteBatch` —— 批量软删除，body `{"ids":[…]}`。
  @override
  Future<CrudBatchResult> removeBatch(Session session, List<int> ids) async =>
      batchOf(await RoleService.delete(session, ids));
}
