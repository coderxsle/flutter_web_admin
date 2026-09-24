import 'package:flutter_web_server/src/generated/protocol.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

// 用户资源在 REST 层的目标形态 —— **就这一行**。
//
// 本文件目前**没有注册**（`server.dart` 里还没挂），存在的意义是：
// 让 `dart analyze` 用**真实模型** `SysUser` 证明这句抽象编译通过，
// 而不是只在单元测试的假模型上成立。
//
// 注册只需在 `registerApiRoutes` 里加一行：
//
// ```dart
// pod.registerCrud<SysUser>('/api/user');
// ```
//
// 或按你的写法挂载本类：
//
// ```dart
// pod.webServer.addRoute(UserRestRoute(), '/api/user');
// ```
//
// 两种写法产出同一套路由：
//
// ```
// GET     /api/user                列表
// GET     /api/user/:id            详情
// POST    /api/user                新增（201）
// PUT     /api/user/:id            更新
// PATCH   /api/user/:id            更新
// DELETE  /api/user/:id            删除
// DELETE  /api/user                批量删除（body {"ids":[…]})
// POST    /api/user/update         更新（POST 兼容形式）
// POST    /api/user/delete         删除（POST 兼容形式）
// ```
//
// ⚠️ **但这只是「零代码版本」，语义是退化的**。空类体走的是
// `AutoCrudDelegate`（通用 ORM CRUD），它不认识用户资源的 5 处特殊逻辑：
//
// 1. 列表要注入 `disabled`（「系统内置不可编辑」标记）
// 2. `deptId` 要展开部门子树
// 3. `UserListRequest` 的 9 个专用过滤字段
// 4. `password` 必须是 RSA 密文（通用版本会当成明文直接落库）
// 5. `roleIds` 在 `sys_user_role` 关联表，通用版本会**静默丢弃**
//
// 所以真正的用户资源要走「自定义 delegate」那条路 —— 见迁移方案 S2。
// 空类体适合的是**新建的、单表的、无关联**的资源。
//
// 需要特殊逻辑时，只覆写要改的动作，其余（路由、参数解析、HTTP 语义映射、
// OPTIONS 预检）仍然全自动：
//
// ```dart
// class UserRestDelegate extends RestCrudDelegate<SysUser> {
//   final UserService _service = UserService();
//
//   @override
//   Future<Object?> list(Session session, Request request) =>
//       _service.getUserList(session, UserListRequest(...));
//
//   @override
//   Future<SysUser> detail(Session session, int id) => ...;
//   // create / update / remove / removeBatch 同理，转发给 UserService
// }
// ```
class UserRestRoute extends BaseRestRoute<SysUser> {}
