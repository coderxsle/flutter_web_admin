import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:flutter_web_server/src/services/system/dept_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

import 'rest_delegate_utils.dart';

/// 部门资源 `/api/dept` 的 REST delegate。
///
/// 与 typed `DeptEndpoint` 共用 [DeptService]。
///
/// ## 这个资源的两个特殊点
///
/// 1. **列表返回树、不分页**：`DeptService.getList` 返回 `nodeMap` 建好的
///    部门树（现网 45 节点）。`RestCrudDelegate.list` 允许返回非 [RestPage]
///    载荷，正好用在这。
/// 2. **删除是批量语义**：Service 只有 `delete(ids)`，单条删除就是
///    长度为 1 的批量删；⚠️ 「一条都没命中」时它**仍然返回成功**
///    （data 里 `successCount: 0`），所以 404 得自己判（见 [remove]）。
class DeptRestDelegate extends RestCrudDelegate<SysDept> {
  /// `GET /api/dept` —— 部门树（**非分页**）。
  ///
  /// query：`name`（模糊）/ `status`（0 停用 1 正常）。
  @override
  Future<Object?> list(Session session, Request request) async => ensureOk(
    await DeptService.getList(
      session,
      status: request.queryString('status'),
      name: request.queryString('name'),
    ),
  );

  /// `GET /api/dept/:id` —— 详情。
  @override
  Future<Object?> detail(Session session, int id) async => requireFound<SysDept>(
    await DeptService.getDetail(session, id),
    '部门',
  );

  /// `POST /api/dept` —— 新增，成功返回 201。`name` 必填。
  @override
  Future<Object?> create(Session session, Map<String, dynamic> body) async =>
      ensureOk(await DeptService.add(session, _toRequest(body)));

  /// `PUT|PATCH /api/dept/:id` —— 更新（PATCH 语义）。
  ///
  /// ⚠️ 回填基线的原因与菜单相同：`DeptService.update` 会把
  /// `parentId / name / sort / status / description` 全量按入参重写。
  @override
  Future<Object?> update(
    Session session,
    int id,
    Map<String, dynamic> body,
  ) async {
    final base = requireFound<SysDept>(
      await DeptService.getDetail(session, id),
      '部门',
    );
    return ensureOk(await DeptService.update(session, _toRequest(body, base: base)));
  }

  /// `DELETE /api/dept/:id` —— 软删除。
  @override
  Future<void> remove(Session session, int id) async => ensureDeleted(
    await DeptService.delete(session, [id]),
    '部门',
  );

  /// `DELETE /api/dept` —— 批量软删除，body `{"ids":[…]}`。
  @override
  Future<int> removeBatch(Session session, List<int> ids) async => successCountOf(
    ensureOk(await DeptService.delete(session, ids)),
  );

  /// 把 HTTP body 翻译成 [DeptRequest]。[base] 为 PATCH 基线（新增时 null）。
  ///
  /// ⚠️ 新增路径**刻意不传 `tenantId`**：`DeptRequest.tenantId` 有默认值 0，
  /// 而 `BaseService.create` 会按 `session.tenantId` 重新打标（`targetTenantId`
  /// 优先）。也就是说租户归属由登录态决定，不该由请求体决定。
  DeptRequest _toRequest(Map<String, dynamic> body, {SysDept? base}) {
    if (base == null) {
      return DeptRequest(
        parentId: asIntOrNull(body['parentId']),
        name: requiredText(body, 'name'),
        sort: asIntOrNull(body['sort']),
        status: asIntOrNull(body['status']),
        description: trimmedString(body['description']),
      );
    }

    return DeptRequest(
      id: base.id,
      tenantId: base.tenantId,
      parentId: patchInt(body, 'parentId', base.parentId) ?? 0,
      name: body.containsKey('name')
          ? requiredText(body, 'name')
          : base.name ?? '',
      sort: patchInt(body, 'sort', base.sort),
      status: patchInt(body, 'status', base.status),
      description: patchText(body, 'description', base.description),
    );
  }
}
