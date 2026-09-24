import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_shared/flutter_web_shared.dart';
import 'package:flutter_web_server/src/services/system/dict_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

import 'rest_delegate_utils.dart';

/// 字典类型资源 `/api/dict-code` 的 REST delegate。
///
/// 与 typed `DictEndpoint` 共用 [DictService]。
///
/// ## 这个资源的两个特殊点
///
/// 1. **列表不分页**（同 `dict-data`）：typed 返回全表（现网 9 条），
///    分页会悄悄截断字典类型。顺带一提，列表里的 `creator` / `updater`
///    已经被 Service 从 `userIdentifier` 翻译成**用户昵称**了。
/// 2. **`code` 不可修改**：见 [update] 的注释。
class DictCodeRestDelegate extends RestCrudDelegate<SysDictCode> {
  /// `GET /api/dict-code/getList` —— 列表（**非分页**）。
  ///
  /// query：`tenantId` / `name`（模糊）/ `code`（模糊）/ `status`。
  @override
  Future<Object?> list(Session session, Request request) async => ensureOk(
    await DictService.getDictCodeList(
      session,
      tenantId: request.queryInt('tenantId'),
      name: request.queryString('name'),
      code: request.queryString('code'),
      status: request.queryString('status'),
    ),
  );

  /// `GET /api/dict-code/getDetail?id=` —— 详情。
  @override
  Future<Object?> detail(Session session, int id) async => requireFound<SysDictCode>(
    await DictService.getDictCodeDetail(session, id),
    '字典类型',
  );

  /// `POST /api/dict-code/add` —— 新增，成功返回 201。
  @override
  Future<Object?> create(Session session, Map<String, dynamic> body) async =>
      ensureOk(
        await DictService.addDictCode(
          session,
          DictCodeRequest(
            tenantId: asIntOrNull(body['tenantId']) ?? 0,
            name: requiredText(body, 'name'),
            code: requiredText(body, 'code'),
            status: asIntOrNull(body['status']) ?? 1,
            description: trimmedString(body['description']),
          ),
        ),
      );

  /// `POST /api/dict-code/update` —— 更新（PATCH 语义，`id` 在 body 里）。
  ///
  /// ⚠️ **`code` 定为不可变**。两个理由叠在一起：
  /// * `DictService.updateDictCode` 是**按 `req.code` 反查记录**的（不是按 id），
  ///   传一个不存在的 code 进去会得到「字典类型不存在或已删除」这种误导性 400；
  /// * `sys_dict_data.code` 是引用它的，改了编码会让底下所有字典数据变孤儿。
  ///
  /// 所以请求体里带了与当前值不同的 `code` → 直接 400，而不是让它悄悄失败。
  @override
  Future<Object?> update(
    Session session,
    int id,
    Map<String, dynamic> body,
  ) async {
    final base = requireFound<SysDictCode>(
      await DictService.getDictCodeDetail(session, id),
      '字典类型',
    );

    final requestedCode = trimmedString(body['code']);
    if (requestedCode != null && requestedCode != base.code) {
      throw const RestApiException.badRequest(
        '字典类型编码不可修改：sys_dict_data 通过 code 引用它，'
        '且更新的定位也是按 code 反查。如需换编码请新建字典类型再迁移数据',
      );
    }

    return ensureOk(
      await DictService.updateDictCode(
        session,
        DictCodeRequest(
          // 反查靠 code，必须回填基线值
          code: base.code,
          name: body.containsKey('name')
              ? requiredText(body, 'name')
              : base.name,
          status: patchInt(body, 'status', base.status) ?? base.status,
          description: patchText(body, 'description', base.description),
          tenantId: base.tenantId ?? 0,
        ),
      ),
    );
  }

  /// `POST /api/dict-code/delete` —— 软删除单条。
  ///
  /// ⚠️ Service 会**级联**软删该类型下的所有 `sys_dict_data`
  /// （跨资源的关联清理，不属于本资源 CRUD，保持手写在那一边）。
  @override
  Future<void> remove(Session session, int id) async => ensureDeleted(
    await DictService.deleteDictCode(session, [id]),
    '字典类型',
  );

  /// `POST /api/dict-code/deleteBatch` —— 批量软删除，body `{"ids":[…]}`。
  @override
  Future<CrudBatchResult> removeBatch(Session session, List<int> ids) async =>
      batchOf(await DictService.deleteDictCode(session, ids));
}
