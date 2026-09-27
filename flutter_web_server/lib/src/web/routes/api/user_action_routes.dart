import 'package:flutter_web_server/src/services/system/user_service.dart';
import 'package:flutter_web_server/src/web/routes/api/rest_delegate_utils.dart';
import 'package:flutter_web_server/src/web/routes/api/serverpod_envelope.dart';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

/// 用户资源的**业务动作**路由（B 档）。
///
/// 与 `user_rest_delegate.dart` 的分工：delegate 负责那套固定形状的 CRUD
/// （列表 / 详情 / 新增 / 更新 / 删除），本文件负责**套不进 CRUD 模板的单点动作**。
/// 两者共用 `RestActionRoute`/`BaseRestRoute` 的鉴权、信封、状态码与异常兜底，
/// 也都调用**同一个** [UserService]。
///
/// | 动作 | REST |
/// |---|---|
/// | 当前登录用户信息 | `GET /api/user/info` |
/// | 当前登录用户菜单 | `GET /api/user/routes` |
/// | 重置密码 | `POST /api/user/reset-password` |
///
/// ## 为什么这三条挂在 `/api/user/...` 下，而不是另起资源
///
/// 它们是「当前登录用户」/「一批用户」的**属性与动作**，语义上从属于 `/api/user`，
/// 路径嵌套最直观。技术上也没问题 —— relic 的 `PathTrie` 匹配时**字面量段优先于
/// 参数段**，所以 `GET /api/user/info` 会命中 `info` 这个字面节点，而不是被
/// CRUD 那套的 `GET /:id` 吃掉（`pathId()` 对 `"info"` 本来也会 400）。
///
/// ⚠️ 路径参数名必须沿用 **`:id`**，不能起 `:userId` ——
/// `PathTrie._build` 在同一层遇到不同参数名会直接抛
/// `Conflicting parameter names at the same level`。这一点有测试钉住。
Map<String, RestActionRoute> userActionRoutes({UserService? service}) {
  const envelope = ServerpodEnvelopeBuilder();
  final userService = service ?? UserService();

  return {
    // GET /api/user/info —— 当前登录用户的完整信息
    // （基础信息 + 岗位 + 角色 + 权限 + 菜单）。
    //
    // 注意它取的是 `session.authenticated` 对应的用户，**没有入参** ——
    // 也就是说不能拿它查别人，这是这个接口一直以来的边界。
    '/api/user/info': RestActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async =>
          ensureOk(await userService.getUserInfo(session)),
    ),

    // GET /api/user/routes —— 当前登录用户的路由树（前端动态路由用）。
    //
    // 超级管理员返回全部启用菜单；普通用户按角色关联菜单返回；
    // 只含目录(1)与菜单(2)，按钮(3)被过滤。
    '/api/user/routes': RestActionRoute(
      methods: const {Method.get},
      envelope: envelope,
      handler: (session, request) async =>
          ensureOk(await userService.getUserRoutes(session)),
    ),

    // POST /api/user/reset-password —— 批量重置为固定初始密码 `asdf1234`。
    //
    // 请求体：`{"ids": [1, 2, 3]}`（兼容 `{"id": 1}` 单个的写法）。
    //
    // ⚠️ 返回的是**汇总**而不是 404：`UserService.resetPassword` 在「一个都没命中」
    // 时也返回成功，data 里是 `{total, successCount: 0, notFoundCount, defaultPassword}`。
    // 这里保持原样 —— 批量接口里「部分命中」是正常结果，逐条报 404 反而不好用。
    '/api/user/reset-password': RestActionRoute(
      methods: const {Method.post},
      envelope: envelope,
      handler: (session, request) async {
        final body = await request.jsonObjectBody();
        final ids = requiredIntList(body, 'ids', aliases: const ['id']);
        return ensureOk(await userService.resetPassword(session, ids));
      },
    ),
  };
}

/// 把 [userActionRoutes] 挂到 Web Server 上。
void registerUserActionRoutes(Serverpod pod, {UserService? service}) {
  userActionRoutes(service: service).forEach((path, route) {
    pod.webServer.addRoute(route, path);
  });
}