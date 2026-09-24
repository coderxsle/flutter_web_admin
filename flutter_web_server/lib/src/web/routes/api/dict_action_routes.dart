import 'package:flutter_web_server/src/services/system/dict_service.dart';
import 'package:flutter_web_server/src/web/routes/api/rest_delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 字典域的**业务动作**路由（B 档）。
///
/// | typed 方法 | REST |
/// |---|---|
/// | `getDictData(tenantId)` | `GET /api/dict/options` |
/// | `getDictDataDetail(id, code)` | **已由 A 档 `GET /api/dictData/getDetail?id=` 覆盖** |
///
/// ## 为什么另起 `/api/dict`，而不是塞进 `/api/dictData`
///
/// 这个接口返回的不是「字典数据的行」，而是一张**按类型分组的聚合视图**：
///
/// ```json
/// {"TYPE_A": [{"label":"标签","value":1,"tagProps":{"color":"red"}}], "TYPE_B": [...]}
/// ```
///
/// 它服务的是「把一堆下拉框的候选项一次拿全」这个场景，形状上不属于
/// `sys_dict_data` 资源本身；而且**登录前就要能调**（登录页的字典项）。
/// 所以它是一个独立的只读视图 `/api/dict/options`，与 A 档两个资源平级。
///
/// ## `getDictDataDetail(id, code)` 为什么没有再挂一条
///
/// 它要求 `id` 与 `code` **同时命中**，是 typed 端的历史签名（前端编辑表单手里
/// 正好有 code）。REST 侧的 `GET /api/dictData/getDetail?id=` 只按 id，走的是带
/// **租户 + 软删**过滤的 `DictService.getDictDataDetailById`。
/// 两条路读的是同一行，REST 版只是**更宽松**（少一个校验条件），
/// 再造一条 `?code=` 的重复路由没有意义。差异已记在
/// `docs/rest-api-layer.md` §6.4。
Map<String, RestActionRoute> dictActionRoutes() {
  const envelope = ServerpodEnvelopeBuilder();

  return {
    // GET /api/dict/options?tenantId=1 —— 按字典类型分组的全量字典数据。
    //
    // ⚠️ 与其它动作**不同**，这条必须匿名可访问：
    // typed 侧 `DictEndpoint.getDictData` 标了 `@unauthenticatedClientCall`，
    // 登录页在下发 token 之前就要用它（例如「登录方式」下拉框）。
    // 保持 `requireAuth: true` 会在 handler 之前直接 401，把登录页打残。
    //
    // ⚠️ 租户过滤按**入参** `tenantId` 而不是 `session.tenantId`（登录前没有
    // session）—— 这是 `DictService.getDictData` 里刻意保留的行为，不是漏改；
    // 也正因为匿名可读，不传 `tenantId` 就会返回全部租户的字典项。
    '/api/dict/options': RestActionRoute(
      methods: const {Method.get},
      requireAuth: false,
      envelope: envelope,
      handler: (session, request) async => ensureOk(
        await DictService.getDictData(
          session,
          tenantId: request.queryInt('tenantId'),
        ),
      ),
    ),
  };
}

/// 把 [dictActionRoutes] 挂到 Web Server 上。
void registerDictActionRoutes(Serverpod pod) => dictActionRoutes().forEach(
  (path, route) => pod.webServer.addRoute(route, path),
);
