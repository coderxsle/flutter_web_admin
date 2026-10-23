import 'package:flutter_web_server/src/common/common.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/services/system/dept_service.dart';
import 'package:flutter_web_server/src/services/system/permission_service.dart';
import 'package:flutter_web_server/src/web/routes/api/delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

class DeptRoute extends BaseRoute<SysDept> {
  DeptRoute()
    : super(
        envelope: const ServerpodEnvelopeBuilder(),
        actionList: [
          get('/getList', PermissionService.guard(_readPerms, _getList)),
          get('/getDetail', PermissionService.guard(_readPerms, _getDetail)),
          post('/add', PermissionService.guard(_writePerms, _add), successStatus: 201),
          post('/update', PermissionService.guard(_writePerms, _update)),
          post('/delete', PermissionService.guard(_writePerms, _delete)),
          post('/deleteBatch', PermissionService.guard(_writePerms, _deleteBatch)),
        ],
      );

  /// 用户管理页的部门树和表单下拉要用部门数据，读接口对「用户管理」也开放。
  static const _readPerms = ['menu:system:dept', 'menu:system:user'];
  static const _writePerms = ['menu:system:dept'];

  static Future<Object?> _getList(Session session, Request request) async => ensureOk(
        await DeptService.getList(session, status: request.queryString('status'), name: request.queryString('name')),
      );

  static Future<Object?> _getDetail(Session session, Request request) async =>
      requireFound<SysDept>(await DeptService.getDetail(session, request.queryId()), '部门');

  static Future<Object?> _add(Session session, Request request) async =>
      ensureOk(await DeptService.add(session, _toRequest(await request.jsonObjectBody())));

  static Future<Object?> _update(Session session, Request request) async {
    final body = await request.jsonObjectBody();
    final id = asIntOrNull(body['id']);
    if (id == null || id <= 0) throw const RestException.badRequest('请求体缺少合法的 id');
    final base = requireFound<SysDept>(await DeptService.getDetail(session, id), '部门');
    return ensureOk(await DeptService.update(session, _toRequest(body, base: base)));
  }

  static Future<Object?> _delete(Session session, Request request) async {
    final id = extractSingleId(await request.jsonObjectBody());
    return await DeptService.delete(session, [id]);
  }

  static Future<Object?> _deleteBatch(Session session, Request request) async =>
      batchOf(await DeptService.delete(session, extractIds(await request.jsonObjectBody())));

  static DeptRequest _toRequest(Map<String, dynamic> body, {SysDept? base}) {
    if (base == null) {
      return DeptRequest(
        parentId: asIntOrNull(body['parentId']), name: requiredText(body, 'name'), sort: asIntOrNull(body['sort']),
        status: asIntOrNull(body['status']), description: trimmedString(body['description']),
      );
    }
    return DeptRequest(
      id: base.id, tenantId: base.tenantId, parentId: patchInt(body, 'parentId', base.parentId) ?? 0,
      name: body.containsKey('name') ? requiredText(body, 'name') : base.name ?? '', sort: patchInt(body, 'sort', base.sort),
      status: patchInt(body, 'status', base.status), description: patchText(body, 'description', base.description),
    );
  }
}
