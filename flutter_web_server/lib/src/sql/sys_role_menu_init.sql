-- sys_role_menu 初始化数据（角色-菜单菜单权限关联）
-- 说明：
-- 1. 依赖于 sys_role_init.sql 和 sys_menu_init.sql 已经插入的基础数据
-- 2. 更贴近真实场景的默认分配策略：
--    - SUPER_ADMIN：全量菜单（包含按钮/权限点 type=3）
--    - SYSTEM_ADMIN：系统管理 + 基础通用页面
--    - TECH_PLATFORM_LEAD：通用页面 + 文档/示例/多级菜单（不含权限测试按钮）
--    - DATA_ANALYST：分析/数据/表格等偏数据页面
--    - 业务/职能类角色：通用页面（不含系统管理/权限测试/多级菜单等偏技术演示内容）
-- 3. 支持重复执行：ON CONFLICT ("roleId", "menuId") DO UPDATE
-- 4. 为了避免“改了分配规则后，旧的 role-menu 还残留”，会先把非超级管理员的旧关联软删除，再按规则回填

-- 先把非超级管理员的旧关联软删除（便于重复执行、且分配规则变更后不残留多余菜单）
UPDATE "sys_role_menu" rm
SET
  "deleted"    = true,
  "updater"    = 'system',
  "updateTime" = CURRENT_TIMESTAMP
FROM "sys_role" r
WHERE rm."roleId" = r."id"
  AND rm."tenantId" = 0
  AND r."tenantId" = 0
  AND r."deleted" = false
  AND r."status" = 1
  AND r."code" <> 'SUPER_ADMIN';

-- 1) SUPER_ADMIN：全量菜单（启用 + 未删除）
INSERT INTO "sys_role_menu"
  ("tenantId", "roleId", "menuId", "creator", "createTime", "updater", "updateTime", "deleted")
SELECT
  0                    AS "tenantId",
  r."id"               AS "roleId",
  m."id"               AS "menuId",
  'system'             AS "creator",
  CURRENT_TIMESTAMP    AS "createTime",
  'system'             AS "updater",
  CURRENT_TIMESTAMP    AS "updateTime",
  false                AS "deleted"
FROM "sys_role" r
JOIN "sys_menu" m
  ON m."deleted" = false
 AND m."status" = 1
WHERE r."deleted" = false
  AND r."status" = 1
  AND r."code" = 'SUPER_ADMIN'
ON CONFLICT ("roleId", "menuId") DO UPDATE SET
  "tenantId"   = EXCLUDED."tenantId",
  "updater"    = EXCLUDED."updater",
  "updateTime" = EXCLUDED."updateTime",
  "deleted"    = EXCLUDED."deleted";

-- 2) SYSTEM_ADMIN：系统管理 + 基础通用页面
WITH allowed(menu_id) AS (
  VALUES
    -- 基础通用
    (1),(101),                 -- 分析
    (6),(601),(602),(603),     -- 错误页
    (7),(701),(702),           -- 结果页
    (11),(1101),               -- 关于
    (14),(1401),(1402),(1403), -- 文档
    -- 系统管理
    (8),(801),(802),(803),(804),(805),(806)
)
INSERT INTO "sys_role_menu"
  ("tenantId", "roleId", "menuId", "creator", "createTime", "updater", "updateTime", "deleted")
SELECT
  0,
  r."id",
  m."id",
  'system',
  CURRENT_TIMESTAMP,
  'system',
  CURRENT_TIMESTAMP,
  false
FROM "sys_role" r
JOIN allowed a ON true
JOIN "sys_menu" m
  ON m."id" = a.menu_id
 AND m."deleted" = false
 AND m."status" = 1
WHERE r."tenantId" = 0
  AND r."deleted" = false
  AND r."status" = 1
  AND r."code" = 'SYSTEM_ADMIN'
ON CONFLICT ("roleId", "menuId") DO UPDATE SET
  "tenantId"   = EXCLUDED."tenantId",
  "updater"    = EXCLUDED."updater",
  "updateTime" = EXCLUDED."updateTime",
  "deleted"    = EXCLUDED."deleted";

-- 3) TECH_PLATFORM_LEAD：通用 + 文档/示例/多级菜单（不含权限测试按钮 type=3）
WITH allowed(menu_id) AS (
  VALUES
    -- 通用
    (1),(101),
    (2),(201),(202),(203),
    (3),(301),(302),
    (4),(401),(402),(403),(404),
    (5),(501),(502),(503),(504),
    (6),(601),(602),(603),
    (7),(701),(702),
    (11),(1101),
    (13),(1301),(1302),
    (14),(1401),(1402),(1403),
    -- 示例/多级
    (9),(901),
    (10),(1001),(100101),(10010101),(100102),(1002),(100201),(100202),
    (15),(1501),(1502),(1503),(1504),(1505)
)
INSERT INTO "sys_role_menu"
  ("tenantId", "roleId", "menuId", "creator", "createTime", "updater", "updateTime", "deleted")
SELECT
  0,
  r."id",
  m."id",
  'system',
  CURRENT_TIMESTAMP,
  'system',
  CURRENT_TIMESTAMP,
  false
FROM "sys_role" r
JOIN allowed a ON true
JOIN "sys_menu" m
  ON m."id" = a.menu_id
 AND m."deleted" = false
 AND m."status" = 1
 AND m."type" <> 3
WHERE r."tenantId" = 0
  AND r."deleted" = false
  AND r."status" = 1
  AND r."code" = 'TECH_PLATFORM_LEAD'
ON CONFLICT ("roleId", "menuId") DO UPDATE SET
  "tenantId"   = EXCLUDED."tenantId",
  "updater"    = EXCLUDED."updater",
  "updateTime" = EXCLUDED."updateTime",
  "deleted"    = EXCLUDED."deleted";

-- 4) DATA_ANALYST：分析/数据/表格为主
WITH allowed(menu_id) AS (
  VALUES
    (1),(101),
    (2),(201),(202),(203),
    (5),(501),(502),(503),(504),
    (6),(601),(602),(603),
    (7),(701),(702),
    (11),(1101),
    (14),(1401),(1402)
)
INSERT INTO "sys_role_menu"
  ("tenantId", "roleId", "menuId", "creator", "createTime", "updater", "updateTime", "deleted")
SELECT
  0,
  r."id",
  m."id",
  'system',
  CURRENT_TIMESTAMP,
  'system',
  CURRENT_TIMESTAMP,
  false
FROM "sys_role" r
JOIN allowed a ON true
JOIN "sys_menu" m
  ON m."id" = a.menu_id
 AND m."deleted" = false
 AND m."status" = 1
WHERE r."tenantId" = 0
  AND r."deleted" = false
  AND r."status" = 1
  AND r."code" = 'DATA_ANALYST'
ON CONFLICT ("roleId", "menuId") DO UPDATE SET
  "tenantId"   = EXCLUDED."tenantId",
  "updater"    = EXCLUDED."updater",
  "updateTime" = EXCLUDED."updateTime",
  "deleted"    = EXCLUDED."deleted";

-- 5) 业务/职能类角色：通用页面（排除系统管理/权限测试/多级菜单等偏演示内容）
WITH allowed(menu_id) AS (
  VALUES
    (1),(101),
    (2),(201),(202),(203),
    (3),(301),(302),
    (4),(401),(402),(403),(404),
    (5),(501),(502),(503),(504),
    (6),(601),(602),(603),
    (7),(701),(702),
    (11),(1101),
    (13),(1301),(1302),
    (14),(1401),(1402)
)
INSERT INTO "sys_role_menu"
  ("tenantId", "roleId", "menuId", "creator", "createTime", "updater", "updateTime", "deleted")
SELECT
  0,
  r."id",
  m."id",
  'system',
  CURRENT_TIMESTAMP,
  'system',
  CURRENT_TIMESTAMP,
  false
FROM "sys_role" r
JOIN allowed a ON true
JOIN "sys_menu" m
  ON m."id" = a.menu_id
 AND m."deleted" = false
 AND m."status" = 1
WHERE r."tenantId" = 0
  AND r."deleted" = false
  AND r."status" = 1
  AND r."code" IN (
    'CEO_OFFICE_LEAD',
    'HR_MANAGER',
    'FINANCE_MANAGER',
    'SUPPLY_CHAIN_MANAGER',
    'RETAIL_OPS_MANAGER',
    'ECOMMERCE_OPS_MANAGER'
  )
ON CONFLICT ("roleId", "menuId") DO UPDATE SET
  "tenantId"   = EXCLUDED."tenantId",
  "updater"    = EXCLUDED."updater",
  "updateTime" = EXCLUDED."updateTime",
  "deleted"    = EXCLUDED."deleted";

-- 可选：修正序列，避免后续自增主键冲突
SELECT setval(
  pg_get_serial_sequence('"sys_role_menu"', 'id'),
  GREATEST((SELECT COALESCE(MAX("id"), 1) FROM "sys_role_menu"), 1),
  true
);

