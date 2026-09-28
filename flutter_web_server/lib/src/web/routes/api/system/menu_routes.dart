import 'package:flutter_web_server/src/common/common.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/services/system/menu_service.dart';
import 'package:flutter_web_server/src/web/routes/api/rest_delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

class MenuRoute extends BaseRoute<SysMenu> {
  MenuRoute()
    : super(
        envelope: const ServerpodEnvelopeBuilder(),
        actionList: [
          get('/getList', _getList),
          get('/getDetail', _getDetail),
          post('/add', _add, successStatus: 201),
          post('/update', _update),
          post('/delete', _delete),
          post('/deleteBatch', _deleteBatch),
          get('/options', _options),
        ],
      );

  static Future<Object?> _getList(Session session, Request request) async => ensureOk(
        await MenuService.getList(session, request.queryString('name'), request.queryString('status')),
      );

  static Future<Object?> _getDetail(Session session, Request request) async =>
      requireFound<SysMenu>(await MenuService.getDetail(session, request.queryId()), '菜单');

  static Future<Object?> _add(Session session, Request request) async =>
      ensureOk(await MenuService.add(session, _toRequest(await request.jsonObjectBody())));

  static Future<Object?> _update(Session session, Request request) async {
    final body = await request.jsonObjectBody();
    final id = asIntOrNull(body['id']);
    if (id == null || id <= 0) throw const RestException.badRequest('请求体缺少合法的 id');
    final base = requireFound<SysMenu>(await MenuService.getDetail(session, id), '菜单');
    return ensureOk(await MenuService.update(session, _toRequest(body, base: base)));
  }

  static Future<Object?> _delete(Session session, Request request) async {
    final id = extractSingleId(await request.jsonObjectBody());
    return await MenuService.delete(session, [id]);
  }

  static Future<Object?> _deleteBatch(Session session, Request request) async =>
      batchOf(await MenuService.delete(session, extractIds(await request.jsonObjectBody())));

  static Future<Object?> _options(Session session, Request request) async => ensureOk(await MenuService.getMenuOptions(session));

  static MenuRequest _toRequest(Map<String, dynamic> body, {SysMenu? base}) {
    if (base == null) {
      return MenuRequest(
        title: requiredText(body, 'title'), type: requiredInt(body, 'type'), permission: trimmedString(body['permission']) ?? '',
        sort: asIntOrNull(body['sort']), parentId: asIntOrNull(body['parentId']), breadcrumb: asBoolOrNull(body['breadcrumb']),
        path: trimmedString(body['path']), icon: trimmedString(body['icon']), component: trimmedString(body['component']),
        componentName: trimmedString(body['componentName']), redirect: trimmedString(body['redirect']), status: asIntOrNull(body['status']),
        visible: asBoolOrNull(body['visible']), keepAlive: asBoolOrNull(body['keepAlive']), alwaysShow: asBoolOrNull(body['alwaysShow']),
        activeMenu: trimmedString(body['activeMenu']), showInTabs: asBoolOrNull(body['showInTabs']), affix: asBoolOrNull(body['affix']),
      );
    }
    return MenuRequest(
      id: base.id, title: body.containsKey('title') ? requiredText(body, 'title') : base.title,
      type: patchInt(body, 'type', base.type) ?? base.type, permission: patchText(body, 'permission', base.permission) ?? '',
      sort: patchInt(body, 'sort', base.sort) ?? 0, parentId: patchInt(body, 'parentId', base.parentId) ?? 0,
      breadcrumb: patchBool(body, 'breadcrumb', base.breadcrumb) ?? true, path: patchText(body, 'path', base.path) ?? '',
      icon: patchText(body, 'icon', base.icon), component: patchText(body, 'component', base.component),
      componentName: patchText(body, 'componentName', base.componentName), redirect: patchText(body, 'redirect', base.redirect),
      status: patchInt(body, 'status', base.status) ?? 1, visible: patchBool(body, 'visible', base.visible) ?? true,
      keepAlive: patchBool(body, 'keepAlive', base.keepAlive) ?? true, alwaysShow: patchBool(body, 'alwaysShow', base.alwaysShow) ?? true,
      activeMenu: patchText(body, 'activeMenu', base.activeMenu), showInTabs: patchBool(body, 'showInTabs', base.showInTabs) ?? true,
      affix: patchBool(body, 'affix', base.affix) ?? false,
    );
  }
}
