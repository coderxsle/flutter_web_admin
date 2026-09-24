import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:flutter_web_server/src/services/system/menu_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

import 'rest_delegate_utils.dart';

/// 菜单资源 `/api/menu` 的 REST delegate。
///
/// 与 typed `MenuEndpoint` 共用 [MenuService]。
///
/// ## 这个资源的三个特殊点
///
/// 1. **列表返回树、不分页**：`MenuService.getList` 返回的是
///    `_buildMenuListTree` 的结果（现网 121 节点），不是平铺列表。
///    `RestCrudDelegate.list` 允许返回非 [RestPage] 载荷，正好用在这。
/// 2. **更新是「全量覆盖 + 默认值」**：`MenuService.update` 对每个字段写的是
///    `req.x ?? 0 / '' / 1 / true`。也就是说 `MenuRequest` 里留 null
///    **不等于**「不改」，而是「被重置成默认值」。所以 PATCH 必须逐字段回填
///    基线，见 [_toRequest]。
/// 3. **`type` 必填**：生成模型 `MenuRequest.type` 是 `required int`（模型里
///    没有默认值），新增时缺了会直接抛 → 500。
class MenuRestDelegate extends RestCrudDelegate<SysMenu> {
  /// `GET /api/menu/getList` —— 菜单树（**非分页**）。
  ///
  /// query：`name`（按 title 模糊）/ `status`（0 停用 1 正常）。
  @override
  Future<Object?> list(Session session, Request request) async => ensureOk(
    await MenuService.getList(
      session,
      request.queryString('name'),
      request.queryString('status'),
    ),
  );

  /// `GET /api/menu/getDetail?id=` —— 详情。
  @override
  Future<Object?> detail(Session session, int id) async => requireFound<SysMenu>(
    await MenuService.getDetail(session, id),
    '菜单',
  );

  /// `POST /api/menu/add` —— 新增，成功返回 201。`title` 与 `type` 必填。
  @override
  Future<Object?> create(Session session, Map<String, dynamic> body) async =>
      ensureOk(await MenuService.add(session, _toRequest(body)));

  /// `POST /api/menu/update` —— 更新（PATCH 语义，`id` 在 body 里）。
  @override
  Future<Object?> update(
    Session session,
    int id,
    Map<String, dynamic> body,
  ) async {
    final base = requireFound<SysMenu>(
      await MenuService.getDetail(session, id),
      '菜单',
    );
    return ensureOk(await MenuService.update(session, _toRequest(body, base: base)));
  }

  /// `POST /api/menu/delete` —— 软删除单条。
  @override
  Future<void> remove(Session session, int id) async => ensureDeleted(
    await MenuService.delete(session, [id]),
    '菜单',
  );

  /// `POST /api/menu/deleteBatch` —— 批量软删除，body `{"ids":[…]}`。
  @override
  Future<CrudBatchResult> removeBatch(Session session, List<int> ids) async =>
      batchOf(await MenuService.delete(session, ids));

  /// 把 HTTP body 翻译成 [MenuRequest]。
  ///
  /// [base] 为 PATCH 的基线（新增时传 `null`）。
  ///
  /// ⚠️ 回填基线是为了绕开 `MenuService.update` 的默认值语义：
  /// 那边对**每个**字段都用 `req.x ?? 默认值`，所以只要 `MenuRequest` 里
  /// 是 null，就会被写成 `0` / `''` / `true`。要「不改」就必须显式给旧值。
  MenuRequest _toRequest(Map<String, dynamic> body, {SysMenu? base}) {
    if (base == null) {
      return MenuRequest(
        title: requiredText(body, 'title'),
        type: requiredInt(body, 'type'),
        permission: trimmedString(body['permission']) ?? '',
        sort: asIntOrNull(body['sort']),
        parentId: asIntOrNull(body['parentId']),
        breadcrumb: asBoolOrNull(body['breadcrumb']),
        path: trimmedString(body['path']),
        icon: trimmedString(body['icon']),
        component: trimmedString(body['component']),
        componentName: trimmedString(body['componentName']),
        redirect: trimmedString(body['redirect']),
        status: asIntOrNull(body['status']),
        visible: asBoolOrNull(body['visible']),
        keepAlive: asBoolOrNull(body['keepAlive']),
        alwaysShow: asBoolOrNull(body['alwaysShow']),
        activeMenu: trimmedString(body['activeMenu']),
        showInTabs: asBoolOrNull(body['showInTabs']),
        affix: asBoolOrNull(body['affix']),
      );
    }

    return MenuRequest(
      id: base.id,
      title: body.containsKey('title')
          ? requiredText(body, 'title')
          : base.title,
      type: patchInt(body, 'type', base.type) ?? base.type,
      permission: patchText(body, 'permission', base.permission) ?? '',
      sort: patchInt(body, 'sort', base.sort) ?? 0,
      parentId: patchInt(body, 'parentId', base.parentId) ?? 0,
      breadcrumb: patchBool(body, 'breadcrumb', base.breadcrumb) ?? true,
      path: patchText(body, 'path', base.path) ?? '',
      icon: patchText(body, 'icon', base.icon),
      component: patchText(body, 'component', base.component),
      componentName: patchText(body, 'componentName', base.componentName),
      redirect: patchText(body, 'redirect', base.redirect),
      status: patchInt(body, 'status', base.status) ?? 1,
      visible: patchBool(body, 'visible', base.visible) ?? true,
      keepAlive: patchBool(body, 'keepAlive', base.keepAlive) ?? true,
      alwaysShow: patchBool(body, 'alwaysShow', base.alwaysShow) ?? true,
      activeMenu: patchText(body, 'activeMenu', base.activeMenu),
      showInTabs: patchBool(body, 'showInTabs', base.showInTabs) ?? true,
      affix: patchBool(body, 'affix', base.affix) ?? false,
    );
  }
}
