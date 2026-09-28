import 'package:flutter_web_server/src/common/common.dart';
import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/services/system/dict_service.dart';
import 'package:flutter_web_server/src/web/routes/api/rest_delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

class DictDataRoute extends BaseRoute<SysDictData> {
  DictDataRoute()
    : super(
        envelope: const ServerpodEnvelopeBuilder(),
        actionList: [
          get('/getList', _getList), get('/getDetail', _getDetail), post('/add', _add, successStatus: 201),
          post('/update', _update), post('/delete', _delete), post('/deleteBatch', _deleteBatch),
        ],
      );

  static Future<Object?> _getList(Session session, Request request) async => ensureOk(
    await DictService.getDictDataList(
      session, tenantId: request.queryInt('tenantId'), code: request.queryString('code'),
      name: request.queryString('name'), value: request.queryString('value'), status: request.queryInt('status'),
    ),
  );

  static Future<Object?> _getDetail(Session session, Request request) async =>
      requireFound<SysDictData>(await DictService.getDictDataDetailById(session, request.queryId()), '字典数据');

  static Future<Object?> _add(Session session, Request request) async {
    final body = await request.jsonObjectBody();
    return ensureOk(
      await DictService.addDictData(
        session,
        DictDataRequest(
          tenantId: asIntOrNull(body['tenantId']), code: requiredText(body, 'code'), name: requiredText(body, 'name'),
          value: requiredText(body, 'value'), color: trimmedString(body['color']), sort: asIntOrNull(body['sort']) ?? 0,
          status: asIntOrNull(body['status']) ?? 1, description: trimmedString(body['description']),
        ),
      ),
    );
  }

  static Future<Object?> _update(Session session, Request request) async {
    final body = await request.jsonObjectBody();
    final id = asIntOrNull(body['id']);
    if (id == null || id <= 0) throw const RestException.badRequest('请求体缺少合法的 id');
    final base = requireFound<SysDictData>(await DictService.getDictDataDetailById(session, id), '字典数据');
    return ensureOk(
      await DictService.updateDictData(
        session,
        SysDictData(
          id: id, tenantId: base.tenantId, code: body.containsKey('code') ? requiredText(body, 'code') : base.code,
          name: body.containsKey('name') ? requiredText(body, 'name') : base.name,
          value: body.containsKey('value') ? requiredText(body, 'value') : base.value,
          color: patchText(body, 'color', base.color), sort: patchInt(body, 'sort', base.sort) ?? base.sort,
          status: patchInt(body, 'status', base.status) ?? base.status, description: patchText(body, 'description', base.description),
          deleted: base.deleted, creator: base.creator, createTime: base.createTime, updater: base.updater, updateTime: base.updateTime,
        ),
      ),
    );
  }

  static Future<Object?> _delete(Session session, Request request) async =>
      await DictService.deleteDictData(session, [extractSingleId(await request.jsonObjectBody())]);

  static Future<Object?> _deleteBatch(Session session, Request request) async =>
      batchOf(await DictService.deleteDictData(session, extractIds(await request.jsonObjectBody())));
}
