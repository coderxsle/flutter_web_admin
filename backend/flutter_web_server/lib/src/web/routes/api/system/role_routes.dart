import 'package:flutter_web_server/src/common/common.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/services/system/role_service.dart';
import 'package:flutter_web_server/src/web/routes/api/delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

class RoleRoute extends BaseRoute<SysRole> {
  RoleRoute()
    : super(
        enableCreate: false,
        envelope: const ServerpodEnvelopeBuilder(),
        actionList: [
          get('/getList', _getList),
          get('/getDetail', _getDetail),
          post('/update', _update),
          post('/delete', _delete),
          post('/deleteBatch', _deleteBatch),
          get('/:id/menu-ids', _menuIds),
          get('/:id/users', _users),
          post('/:id/users/remove', _removeUsers),
          put('/:id/menus', _saveMenus),
          post('/:id/menus', _saveMenus),
        ],
      );

  static Future<Object?> _getList(Session session, Request request) async => ensureOk(await RoleService.getList(session));

  static Future<Object?> _getDetail(Session session, Request request) async =>
      requireFound<SysRole>(await RoleService.getDetail(session, request.queryId()), '角色');

  static Future<Object?> _update(Session session, Request request) async {
    final body = await request.jsonObjectBody();
    final id = asIntOrNull(body['id']);
    if (id == null || id <= 0) throw const RestException.badRequest('请求体缺少合法的 id');
    final base = requireFound<SysRole>(await RoleService.getDetail(session, id), '角色');
    return ensureOk(
      await RoleService.update(
        session,
        SysRole(
          id: id, tenantId: patchInt(body, 'tenantId', base.tenantId) ?? base.tenantId,
          name: body.containsKey('name') ? requiredText(body, 'name') : base.name,
          code: body.containsKey('code') ? requiredText(body, 'code') : base.code,
          sort: patchInt(body, 'sort', base.sort) ?? base.sort, type: patchInt(body, 'type', base.type) ?? base.type,
          dataScope: patchInt(body, 'dataScope', base.dataScope) ?? base.dataScope,
          dataScopeDeptIds: patchIntList(body, 'dataScopeDeptIds', base.dataScopeDeptIds), menus: base.menus, apis: base.apis,
          description: patchText(body, 'description', base.description), status: patchInt(body, 'status', base.status) ?? base.status,
          deleted: base.deleted, creator: base.creator, createTime: base.createTime, updater: base.updater, updateTime: base.updateTime,
        ),
      ),
    );
  }

  static Future<Object?> _delete(Session session, Request request) async {
    final id = extractSingleId(await request.jsonObjectBody());
    return await RoleService.delete(session, [id]);
  }

  static Future<Object?> _deleteBatch(Session session, Request request) async =>
      batchOf(await RoleService.delete(session, extractIds(await request.jsonObjectBody())));

  static Future<Object?> _menuIds(Session session, Request request) async =>
      ensureOk(await RoleService.getRoleMenuIds(session, request.pathId()));

  static Future<Object?> _users(Session session, Request request) async => ensureOk(
        await RoleService.getRoleUsers(
          session, request.pathId(), page: request.queryInt('page') ?? 1,
          pageSize: request.queryInt('pageSize') ?? request.queryInt('page_size') ?? QueryDTO.defaultPageSize,
          nickname: request.queryString('nickname'),
        ),
      );

  static Future<Object?> _removeUsers(Session session, Request request) async {
    final body = await request.jsonObjectBody();
    return ensureOk(await RoleService.cancelUserRoles(session, request.pathId(), requiredIntList(body, 'userIds')));
  }

  static Future<Object?> _saveMenus(Session session, Request request) async {
    final body = await request.jsonObjectBody();
    return ensureOk(await RoleService.saveRolePermissions(session, request.pathId(), _menuIdsOf(body)));
  }

  static List<int> _menuIdsOf(Map<String, dynamic> body) {
    if (!body.containsKey('menuIds') && !body.containsKey('menu_ids')) {
      throw const RestException.badRequest('参数不合法：menuIds 不能为空');
    }
    return normalizedIntList(body.containsKey('menuIds') ? body['menuIds'] : body['menu_ids']);
  }
}
