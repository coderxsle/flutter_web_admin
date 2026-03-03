-- sys_role 初始化数据（真实业务风格，覆盖总部/职能中心/区域门店）
-- 说明：
-- 1. 采用显式 id，便于与其他初始化脚本联动（如后续 sys_user_role 关系初始化）
-- 2. 支持重复执行：ON CONFLICT ("id") DO UPDATE
-- 3. 角色编码在租户内唯一（sys_role_code_tenant_unique）

INSERT INTO "sys_role"
  ("id", "tenantId", "name", "code", "sort", "dataScope", "dataScopeDeptIds", "status", "type", "remark", "creator", "createTime", "updater", "updateTime", "deleted")
VALUES
  -- 系统内置角色
  (1, 0, '超级管理员', 'SUPER_ADMIN', 1, 1, NULL, 1, 1, '系统内置超级管理员，默认拥有全部数据权限', 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (2, 0, '系统管理员', 'SYSTEM_ADMIN', 2, 1, NULL, 1, 1, '系统运维与配置管理角色', 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  -- 总部管理
  (10, 0, '总裁办负责人', 'CEO_OFFICE_LEAD', 10, 4, '[2]', 1, 2, '总部战略协同与跨部门审批角色', 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (11, 0, '人力资源经理', 'HR_MANAGER', 11, 4, '[3,31,32]', 1, 2, '人力中心管理角色，覆盖招聘与组织发展', 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (12, 0, '财务经理', 'FINANCE_MANAGER', 12, 4, '[4,41,42]', 1, 2, '财务中心管理角色，覆盖核算与经营分析', 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (13, 0, '供应链经理', 'SUPPLY_CHAIN_MANAGER', 13, 4, '[6]', 1, 2, '图书供应链中心管理角色', 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  -- IT 与数据
  (20, 0, '技术平台主管', 'TECH_PLATFORM_LEAD', 20, 4, '[7,71,72,73]', 1, 2, '信息技术中心负责人角色', 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (21, 0, '数据分析师', 'DATA_ANALYST', 21, 3, '[72]', 1, 2, '数据与 BI 分析角色（本部门数据权限）', 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  -- 业务线角色
  (30, 0, '线下零售运营经理', 'RETAIL_OPS_MANAGER', 30, 4, '[8,81,82,83,811,812,821,831]', 1, 2, '线下零售事业部区域运营管理角色', 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (31, 0, '电商运营经理', 'ECOMMERCE_OPS_MANAGER', 31, 4, '[9,91,92,93]', 1, 2, '电商事业部运营管理角色', 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  -- 联调与测试场景
  (90, 0, '禁用测试角色', 'DISABLED_TEST_ROLE', 90, 5, NULL, 0, 2, '用于状态筛选与权限联调（禁用）', 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (91, 0, '软删除测试角色', 'DELETED_TEST_ROLE', 91, 5, NULL, 1, 2, '用于软删除数据联调', 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, true)
ON CONFLICT ("id") DO UPDATE SET
  "tenantId" = EXCLUDED."tenantId",
  "name" = EXCLUDED."name",
  "code" = EXCLUDED."code",
  "sort" = EXCLUDED."sort",
  "dataScope" = EXCLUDED."dataScope",
  "dataScopeDeptIds" = EXCLUDED."dataScopeDeptIds",
  "status" = EXCLUDED."status",
  "type" = EXCLUDED."type",
  "remark" = EXCLUDED."remark",
  "updater" = EXCLUDED."updater",
  "updateTime" = EXCLUDED."updateTime",
  "deleted" = EXCLUDED."deleted";

-- 修正序列，避免后续自增主键冲突
SELECT setval(
  pg_get_serial_sequence('"sys_role"', 'id'),
  GREATEST((SELECT COALESCE(MAX("id"), 1) FROM "sys_role"), 1),
  true
);
