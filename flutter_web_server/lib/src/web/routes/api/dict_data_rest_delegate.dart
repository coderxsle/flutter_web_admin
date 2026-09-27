import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:flutter_web_server/src/common/common.dart';
import 'package:flutter_web_server/src/services/system/dict_service.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

import 'rest_delegate_utils.dart';

/// 字典数据资源 `/api/dictData` 的 REST delegate。
///
/// 业务（唯一性校验、字典类型存在性校验、软删、审计）全部在 [DictService]，
/// 本类**只做 HTTP ↔ Service 翻译**。
///
/// ## 这个资源的三个特殊点
///
/// 1. **列表不分页**：本资源列表返回**全表**（现网 24 条）。
///    换成分页会把字典数据悄悄截断，所以 `list` 直接返回 Service 的
///    `CommonResponse`（非 [RestPage] 载荷 → 走普通成功信封）。
/// 2. **`sort` 必填**：生成模型 `DictDataRequest.sort` 是 `required int`
///    （模型里没有默认值），缺了构造函数会直接抛 → 500。这里兜成 0。
/// 3. **详情只按 id**：旧实现要求 `id` 与 `code` 同时命中；
///    REST 侧用新增的 `getDictDataDetailById`（见那边的方法注释）。
class DictDataRestDelegate extends RestCrudDelegate<SysDictData> {
  /// `GET /api/dictData/getList` —— 列表（**非分页**）。
  ///
  /// query 与 Service 入参一一对应：
  /// `tenantId` / `code`（字典类型编码，精确匹配）/ `name`（模糊）/
  /// `value`（模糊）/ `status`。
  @override
  Future<Object?> list(Session session, Request request) async => ensureOk(
    await DictService.getDictDataList(
      session,
      tenantId: request.queryInt('tenantId'),
      code: request.queryString('code'),
      name: request.queryString('name'),
      value: request.queryString('value'),
      status: request.queryInt('status'),
    ),
  );

  /// `GET /api/dictData/getDetail?id=` —— 详情。
  @override
  Future<Object?> detail(Session session, int id) async =>
      requireFound<SysDictData>(
        await DictService.getDictDataDetailById(session, id),
        '字典数据',
      );

  /// `POST /api/dictData/add` —— 新增，成功返回 201。
  ///
  /// [`code`] 必须是已存在的字典类型编码，否则 Service 返回 400。
  @override
  Future<Object?> create(Session session, Map<String, dynamic> body) async =>
      ensureOk(
        await DictService.addDictData(
          session,
          DictDataRequest(
            tenantId: asIntOrNull(body['tenantId']),
            code: requiredText(body, 'code'),
            name: requiredText(body, 'name'),
            value: requiredText(body, 'value'),
            color: trimmedString(body['color']),
            // ⚠️ `sort` 在生成模型里是 required（无默认值），必须显式给。
            sort: asIntOrNull(body['sort']) ?? 0,
            status: asIntOrNull(body['status']) ?? 1,
            description: trimmedString(body['description']),
          ),
        ),
      );

  /// `POST /api/dictData/update` —— 更新（PATCH 语义，`id` 在 body 里）。
  ///
  /// ⚠️ 必须先读基线：`DictService.updateDictData` 会把
  /// `name / value / code / color / description / status / sort` **全部按入参
  /// 重写**（缺字段就等于写 null / 默认值），所以 body 里没出现的字段
  /// 要从基线补回来，否则一次改名会把 `description` 清空。
  ///
  /// 与 `dictCode` 不同，这里的 `code`（所属字典类型）**允许改**：
  /// Service 是「按 id 找基线 + 按新 code 查重」，改挂到另一个字典类型下是
  /// 被显式支持的。
  @override
  Future<Object?> update(
    Session session,
    int id,
    Map<String, dynamic> body,
  ) async {
    final base = requireFound<SysDictData>(
      await DictService.getDictDataDetailById(session, id),
      '字典数据',
    );

    return ensureOk(
      await DictService.updateDictData(
        session,
        SysDictData(
          id: id,
          tenantId: base.tenantId,
          code: body.containsKey('code')
              ? requiredText(body, 'code')
              : base.code,
          name: body.containsKey('name')
              ? requiredText(body, 'name')
              : base.name,
          value: body.containsKey('value')
              ? requiredText(body, 'value')
              : base.value,
          color: patchText(body, 'color', base.color),
          sort: patchInt(body, 'sort', base.sort) ?? base.sort,
          status: patchInt(body, 'status', base.status) ?? base.status,
          description: patchText(body, 'description', base.description),
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

  /// `POST /api/dictData/delete` —— 软删除单条。
  @override
  Future<void> remove(Session session, int id) async =>
      ensureDeleted(await DictService.deleteDictData(session, [id]), '字典数据');

  /// `POST /api/dictData/deleteBatch` —— 批量软删除，body `{"ids":[…]}`。
  @override
  Future<CrudBatchResult> removeBatch(Session session, List<int> ids) async =>
      batchOf(await DictService.deleteDictData(session, ids));
}
