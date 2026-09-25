-- =============================================================================
-- 租户 1 测试种子（用于验证「跨租户过滤」）
-- =============================================================================
-- 目的：造一个 tenantId = 1 的可登录账号，验证 session.tenantId 真的把查询收窄。
--
-- ⚠️ 先理解 tenantId 是怎么来的（这决定了为什么必须改 sys_user.tenantId）：
--    AuthService.login 读 `sys_user.tenantId`，**> 0 时**才把它塞进 JWT 的 scopes
--    （`services/system/auth_service.dart:45-48`：`Scope('tenantId:${user.tenantId}')`）。
--    而 `session.tenantId`（`serverpod_crud` 的 SessionExtension）**只解析 JWT scope**
--    里名为 `tenantId:<n>` 的那一条，解析不到就返回 **0**。
--    所以：光给别的表加 tenantId 没用，必须让**登录账号自己的 sys_user.tenantId > 0**。
--
-- ⚠️ 两个「全局唯一」约束要注意（不是按租户）：
--    `sys_user_username_unique` / `sys_user_phone_unique` / `sys_user_auth_user_unique`
--    → 租户 1 的账号必须用**没被占用的** username / phone。
--
-- ⚠️ id 段约定：本脚本用 **90001** 这一档给测试租户（`sys_user_id_seq` 当前 19、
--    `sys_dept_id_seq` 当前 11318，都远低于 90001，不会撞）。真跑业务时序列会持续增长，
--    90001 这档留给测试数据，不要用。
--
-- 幂等：三段都用 ON CONFLICT DO NOTHING，重复执行不报错。
-- 账号：username = t1.admin   password = asdf1234（与种子用户同一个 PBKDF2 哈希）
-- =============================================================================

BEGIN;

-- 1) 认证用户（serverpod_auth_core_user）
INSERT INTO "serverpod_auth_core_user"
  ("id", "createdAt", "scopeNames", "blocked")
VALUES
  ('019e0000-0001-7000-8000-000000000001'::uuid, now(), '[]'::json, false)
ON CONFLICT ("id") DO NOTHING;

-- 2) 用户资料（serverpod_auth_core_profile）
INSERT INTO "serverpod_auth_core_profile"
  ("id", "authUserId", "userName", "fullName", "email", "createdAt", "imageId")
VALUES
  ('019e0001-0001-7000-8000-000000000001'::uuid,
   '019e0000-0001-7000-8000-000000000001'::uuid,
   't1.admin', '租户1管理员', 't1.admin@example.com', now(), NULL)
ON CONFLICT ("id") DO NOTHING;

-- 3) 租户 1 的部门（让 dept 树也能量出「1 个 vs 45 个」的差异）
INSERT INTO "sys_dept"
  ("id", "tenantId", "parentId", "name", "sort", "status", "description",
   "deleted", "creator", "createTime", "updater", "updateTime")
VALUES
  (90001, 1, 0, '租户1测试部门', 1, 1, '跨租户过滤验证用',
   false, '019e0000-0001-7000-8000-000000000001'::uuid, now(),
          '019e0000-0001-7000-8000-000000000001'::uuid, now())
ON CONFLICT ("id") DO NOTHING;

-- 4) 租户 1 的业务用户
--    password 与 sys_user_init.sql 里所有种子用户同一个哈希 → 明文 asdf1234
INSERT INTO "sys_user"
  ("id", "tenantId", "authUserId", "deptId", "postIds", "username", "password",
   "nickname", "phone", "gender", "email", "avatar", "description", "status",
   "isSuperuser", "deleted", "loginIp", "loginTime", "updater", "updateTime",
   "creator", "createTime")
VALUES
  (90001, 1, '019e0000-0001-7000-8000-000000000001'::uuid, 90001, '[]',
   't1.admin',
   'pbkdf2_sha256$100000$lOaV2jHTxGKnYTh920XWyQ==$Zxvp027jrR3LcFHBSkeLDUemN1Ys0g0XHxNmQ0HKmSc=',
   '租户1管理员', '13900000001', 1, 't1.admin@example.com', NULL,
   '跨租户过滤验证账号（tenantId=1）', 1,
   false, false, NULL, NULL,
   '019e0000-0001-7000-8000-000000000001'::uuid, now(),
   '019e0000-0001-7000-8000-000000000001'::uuid, now())
ON CONFLICT ("id") DO NOTHING;

COMMIT;

-- =============================================================================
-- 验证：应该各返回 1 行
-- =============================================================================
-- select id, username, "tenantId", "deptId" from sys_user where id = 90001;
-- select id, name, "tenantId"          from sys_dept where id = 90001;

-- =============================================================================
-- 清理（验证完想还原时执行）
-- =============================================================================
-- BEGIN;
-- DELETE FROM "sys_user"                 WHERE id = 90001;
-- DELETE FROM "sys_dept"                 WHERE id = 90001;
-- DELETE FROM "serverpod_auth_core_profile" WHERE id = '019e0001-0001-7000-8000-000000000001'::uuid;
-- DELETE FROM "serverpod_auth_core_user"    WHERE id = '019e0000-0001-7000-8000-000000000001'::uuid;
-- COMMIT;

-- =============================================================================
-- 跑完之后怎么判定「跨租户过滤生效」
-- =============================================================================
-- 用 t1.admin / asdf1234 登录拿 token 后（REST：GET /api/auth/publicKey → 加密 → POST /api/auth/login）：
--   GET /api/user/getList      → total 应该是 **1**（只有它自己；租户 0 的 15 个看不到）
--   GET /api/dept/getList      → 应该是 **1 个节点的树**（不是 45）
--   GET /api/menu/getList      → **0**（菜单全是租户 0 的）
--   GET /api/role/getList      → **0**
-- 对照：admin（tenantId=0）看到 user total=15 / dept 45 / menu 121 / role 11。
-- 两边数字不同 → 过滤生效；两边一样 → 引擎没按 session.tenantId 收窄（是缺陷）。
--
-- ⚠️ `/api/dict/options` 是 `@unauthenticatedClientCall`（登录前用、拿不到 session），
--    **刻意**保留「按入参过滤」而不是按 session.tenantId —— 它不参与上面的判定。
