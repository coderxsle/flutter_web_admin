# 审计缺口登记（TODO）

`sys_operate_log` 目前**只写不读** —— 全仓没有任何 Service 查询它，前端也没有操作日志页。
所以本文这 13 处**暂时不补审计**，只做登记：现在加写入没有任何读取方，只是纯写放大。
等操作日志页（或任何读取方）落地时，先按读取需求定形状，再一次性补完。

代码侧的点位用 `TODO(audit)` 标注，**以标注为准**：

```bash
grep -rn "TODO(audit)" flutter_web_server/lib
```

## 硬约束（无论将来选哪种形状）

- ⚠️ **`password` 绝不能进 `extra`**。`OperateLogWriter.serializeValue` 走的是 `model.toJson()`，
  而 Serverpod 生成的 `toJson()` **包含 `serverOnly` 字段** —— 把 `SysUser` 塞进 `before` / `after`
  等于把密码哈希写进审计表。受影响的是第 13 条（批量重置密码）。
  （对比：`AutoRestCrudDelegate.update` 是**故意**用 `toJson()` 当基线的，那是服务端内存里用，
  不会落库到审计表。）
- 审计写入**不得影响业务**：`OperateLogWriter.write` 内部整段 `try/catch`，补的时候沿用这个口径。
- 已经走 `SystemCrudEngines.*` 的写入**不要**重复补 —— 那些引擎已经注入了 `DbAuditService`
  （见 `crud_engines.dart`）。

## 清单

下表路径相对 `flutter_web_server/lib/src/services/system/`；行号是 **`TODO(audit)` 标注所在行**
（会随重构漂移，以 grep 为准）。

### A. 关联表（11 处，`sys_user_role` / `sys_role_menu`）

| # | 标注位置 | 写入 | 业务含义 |
|---|---|---|---|
| 1 | `user_service.dart:536` | `SysUserRole.updateWhere` | 保存用户时清空其全部角色（软删） |
| 2 | `user_service.dart:559` | `SysUserRole.updateWhere` | 恢复此前被软删的角色关联 |
| 3 | `user_service.dart:590` | `SysUserRole.insert` | 新增角色关联 |
| 4 | `user_service.dart:684` | `SysUserRole.updateWhere` | 删除用户时级联软删角色关联 |
| 5 | `role_service.dart:109` | `SysRoleMenu.updateWhere` | 保存角色授权时取消未勾选的菜单 |
| 6 | `role_service.dart:126` | `SysRoleMenu.db.update` | 恢复此前被软删的菜单授权 |
| 7 | `role_service.dart:144` | `SysRoleMenu.insert` | 新增菜单授权 |
| 8 | `role_service.dart:371` | `SysRoleMenu.updateWhere` | 删除角色时级联软删菜单授权 |
| 9 | `role_service.dart:371` | `SysUserRole.updateWhere` | 删除角色时级联软删用户关联（与 #8 共用一个标注） |
| 10 | `role_service.dart:471` | `SysUserRole.update` | 批量取消用户的角色 |
| 11 | `menu_service.dart:115` | `SysRoleMenu.updateWhere` | 删除菜单时级联软删角色授权 |

### B. 主表但绕过了引擎（2 处）

这两处改的是**主表实体**（不是关联表），所以严格说比 A 类更该有审计。

| # | 标注位置 | 写入 | 业务含义 |
|---|---|---|---|
| 12 | `dict_service.dart:360` | `SysDictData.updateWhere` | 删除字典类型时级联软删其下字典数据（本可走 `_DictDataEngine` 的 `dict_data`） |
| 13 | `user_service.dart:742` | `SysUser.db.update` | 批量重置密码为默认密码 ⚠️ 见上方硬约束 |

## 将来补的时候，两种形状

写入侧的成本**两者一样低**：Serverpod 的 `updateWhere` / `update` 都**返回受影响的行**，
所以「受影响 id 列表」是白拿的，不需要额外查询。

- **形状一（一次业务操作一行）**：`type` = 被影响的表（`user_role` / `role_menu` / `dict_data`），
  `action` = `delete` / `restore` / `insert`，`bizId` = 父实体 id，`extra` 带
  `{affected, affectedIds, reason: 'cascade'}`。日志量与业务操作 1:1，将来要按行追也追得出来。
- **形状二（每个受影响行一行）**：查询最直接（能按 `userId + roleId` 追单行历史），
  但删一个菜单 = N 行，写放大量级最大。

建议先落操作日志页的**查询需求**（支持按什么维度筛、要不要看单行关联历史），再据此二选一。
