import 'package:flutter_web_server/src/common/common.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/services/system/dict_service.dart';
import 'package:flutter_web_server/src/web/routes/api/delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

class DictCodeRoute extends BaseRoute<SysDictCode> {
  DictCodeRoute()
    : super(
        envelope: const ServerpodEnvelopeBuilder(),
        actionList: [
          get('/getList', _getList), get('/getDetail', _getDetail), post('/add', _add, successStatus: 201),
          post('/update', _update), post('/delete', _delete), post('/deleteBatch', _deleteBatch),
        ],
      );

  static Future<Object?> _getList(Session session, Request request) async => ensureOk(
        await DictService.getDictCodeList(
          session, tenantId: request.queryInt('tenantId'), name: request.queryString('name'),
          code: request.queryString('code'), status: request.queryString('status'),
        ),
      );

  static Future<Object?> _getDetail(Session session, Request request) async =>
      requireFound<SysDictCode>(await DictService.getDictCodeDetail(session, request.queryId()), '字典类型');

  static Future<Object?> _add(Session session, Request request) async {
    final body = await request.jsonObjectBody();
    return ensureOk(
      await DictService.addDictCode(
        session,
        DictCodeRequest(
          tenantId: asIntOrNull(body['tenantId']) ?? 0, name: requiredText(body, 'name'), code: requiredText(body, 'code'),
          status: asIntOrNull(body['status']) ?? 1, description: trimmedString(body['description']),
        ),
      ),
    );
  }

  static Future<Object?> _update(Session session, Request request) async {
    final body = await request.jsonObjectBody();
    final id = asIntOrNull(body['id']);
    if (id == null || id <= 0) throw const RestException.badRequest('请求体缺少合法的 id');
    final base = requireFound<SysDictCode>(await DictService.getDictCodeDetail(session, id), '字典类型');
    final requestedCode = trimmedString(body['code']);
    if (requestedCode != null && requestedCode != base.code) {
      throw const RestException.badRequest('字典类型编码不可修改：sys_dict_data 通过 code 引用它，且更新的定位也是按 code 反查。如需换编码请新建字典类型再迁移数据');
    }
    return ensureOk(
      await DictService.updateDictCode(
        session,
        DictCodeRequest(
          code: base.code, name: body.containsKey('name') ? requiredText(body, 'name') : base.name,
          status: patchInt(body, 'status', base.status) ?? base.status, description: patchText(body, 'description', base.description),
          tenantId: base.tenantId ?? 0,
        ),
      ),
    );
  }

  static Future<Object?> _delete(Session session, Request request) async =>
      await DictService.deleteDictCode(session, [extractSingleId(await request.jsonObjectBody())]);

  static Future<Object?> _deleteBatch(Session session, Request request) async =>
      batchOf(await DictService.deleteDictCode(session, extractIds(await request.jsonObjectBody())));
}
