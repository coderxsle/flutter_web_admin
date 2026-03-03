-- sys_user_role 初始化数据（用户-角色关联）
-- 说明：
-- 1. 通过 username + role code 关联，避免依赖自增 id 的具体值
-- 2. 支持重复执行：ON CONFLICT ("roleId", "userId") DO UPDATE
-- 3. 与 sys_user_init.sql、sys_role_init.sql 配套使用

WITH role_user_map(username, role_code, tenant_id, creator_name) AS (
  VALUES
    -- 系统管理员
    ('admin',    'SUPER_ADMIN',          0, 'system'),

    -- 总部 / 职能中心
    ('chen.yu',  'CEO_OFFICE_LEAD',      0, 'system'),
    ('zhao.min', 'HR_MANAGER',           0, 'system'),
    ('liu.jie',  'FINANCE_MANAGER',      0, 'system'),
    ('wang.kai', 'SUPPLY_CHAIN_MANAGER', 0, 'system'),

    -- IT 与数据
    ('xu.qiang', 'TECH_PLATFORM_LEAD',   0, 'system'),
    ('he.ting',  'DATA_ANALYST',         0, 'system'),
    ('sun.yao',  'TECH_PLATFORM_LEAD',   0, 'system'),

    -- 业务线
    ('guo.nan',  'RETAIL_OPS_MANAGER',   0, 'system'),
    ('peng.wei', 'RETAIL_OPS_MANAGER',   0, 'system'),
    ('zhou.lin', 'RETAIL_OPS_MANAGER',   0, 'system'),
    ('tang.xin', 'ECOMMERCE_OPS_MANAGER',0, 'system'),
    ('ma.chen',  'ECOMMERCE_OPS_MANAGER',0, 'system'),
    ('qin.mo',   'ECOMMERCE_OPS_MANAGER',0, 'system'),

    -- 联调场景
    ('yang.fei', 'DISABLED_TEST_ROLE',   0, 'system'),
    ('luo.yi',   'DELETED_TEST_ROLE',    0, 'system')
)
INSERT INTO "sys_user_role"
  ("tenantId", "userId", "roleId", "creator", "createTime", "updater", "updateTime", "deleted")
SELECT
  m.tenant_id,
  u."id" AS "userId",
  r."id" AS "roleId",
  m.creator_name,
  CURRENT_TIMESTAMP,
  m.creator_name,
  CURRENT_TIMESTAMP,
  false
FROM role_user_map m
JOIN "sys_user" u
  ON u."username" = m.username
 AND u."tenantId" = m.tenant_id
JOIN "sys_role" r
  ON r."code" = m.role_code
 AND r."tenantId" = m.tenant_id
ON CONFLICT ("roleId", "userId") DO UPDATE SET
  "tenantId" = EXCLUDED."tenantId",
  "updater" = EXCLUDED."updater",
  "updateTime" = EXCLUDED."updateTime",
  "deleted" = EXCLUDED."deleted";

-- 可选：修正序列，避免后续自增主键冲突
SELECT setval(
  pg_get_serial_sequence('"sys_user_role"', 'id'),
  GREATEST((SELECT COALESCE(MAX("id"), 1) FROM "sys_user_role"), 1),
  true
);
