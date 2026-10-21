-- arts_record 术数排盘记录菜单初始化数据
-- 说明：
-- 1. 新增顶级「术数管理」(id=18) 与菜单「排盘记录」(id=1801)，type=2 为菜单、type=3 为按钮权限点
-- 2. 支持重复执行：ON CONFLICT ("id") DO UPDATE
-- 3. 页面放在 frontend/web/src/views/zhouyi/arts-record/index.vue，权限标识使用 zhouyi:artsRecord:*
-- 4. 按钮序号沿用「父菜单ID * 100 + 序号」，与 10101 / 20101 等既有编号规则一致

INSERT INTO "sys_menu" (
  "id", "parentId", "type", "title", "icon", "permission", "path", "redirect", "component",
  "componentName", "activeMenu", "sort", "status", "breadcrumb", "visible", "keepAlive", "alwaysShow",
  "showInTabs", "affix", "deleted", "creator", "createTime", "updater", "updateTime"
) VALUES
  (18, 0, 1, '术数管理', 'icon-park-outline:chart-graph', 'menu:zhouyi', '/zhouyi', NULL, 'Layout',
   NULL, NULL, 23, 1, true, true, false, false, true, false, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (1801, 18, 2, '排盘记录', 'icon-park-outline:notes', 'menu:zhouyi:artsRecord', '/zhouyi/arts-record', NULL, 'zhouyi/arts-record/index',
   NULL, NULL, 1, 1, true, true, false, false, true, false, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (180101, 1801, 3, '列表', NULL, 'zhouyi:artsRecord:list', '', NULL, NULL,
   NULL, NULL, 1, 1, true, true, false, false, true, false, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (180102, 1801, 3, '详情', NULL, 'zhouyi:artsRecord:detail', '', NULL, NULL,
   NULL, NULL, 2, 1, true, true, false, false, true, false, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (180103, 1801, 3, '新增', NULL, 'zhouyi:artsRecord:add', '', NULL, NULL,
   NULL, NULL, 3, 1, true, true, false, false, true, false, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (180104, 1801, 3, '修改', NULL, 'zhouyi:artsRecord:update', '', NULL, NULL,
   NULL, NULL, 4, 1, true, true, false, false, true, false, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (180105, 1801, 3, '删除', NULL, 'zhouyi:artsRecord:delete', '', NULL, NULL,
   NULL, NULL, 5, 1, true, true, false, false, true, false, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (180106, 1801, 3, '启用停用', NULL, 'zhouyi:artsRecord:status', '', NULL, NULL,
   NULL, NULL, 6, 1, true, true, false, false, true, false, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP)
ON CONFLICT ("id") DO UPDATE SET
  "parentId" = EXCLUDED."parentId",
  "type" = EXCLUDED."type",
  "title" = EXCLUDED."title",
  "icon" = EXCLUDED."icon",
  "permission" = EXCLUDED."permission",
  "path" = EXCLUDED."path",
  "redirect" = EXCLUDED."redirect",
  "component" = EXCLUDED."component",
  "componentName" = EXCLUDED."componentName",
  "activeMenu" = EXCLUDED."activeMenu",
  "sort" = EXCLUDED."sort",
  "status" = EXCLUDED."status",
  "breadcrumb" = EXCLUDED."breadcrumb",
  "visible" = EXCLUDED."visible",
  "keepAlive" = EXCLUDED."keepAlive",
  "alwaysShow" = EXCLUDED."alwaysShow",
  "showInTabs" = EXCLUDED."showInTabs",
  "affix" = EXCLUDED."affix",
  "deleted" = EXCLUDED."deleted",
  "updater" = EXCLUDED."updater",
  "updateTime" = EXCLUDED."updateTime";

-- 授权：与「药房管理」「门诊管理」一致，先给超级管理员与系统管理员
INSERT INTO "sys_role_menu"
  ("tenantId", "roleId", "menuId", "creator", "createTime", "updater", "updateTime", "deleted")
SELECT
  0,
  r."id",
  m."id",
  '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,
  CURRENT_TIMESTAMP,
  '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,
  CURRENT_TIMESTAMP,
  false
FROM "sys_role" r
CROSS JOIN "sys_menu" m
WHERE r."tenantId" = 0
  AND r."deleted" = false
  AND r."status" = 1
  AND r."code" IN ('SUPER_ADMIN', 'SYSTEM_ADMIN')
  AND m."id" IN (18, 1801, 180101, 180102, 180103, 180104, 180105, 180106)
  AND m."deleted" = false
ON CONFLICT ("roleId", "menuId") DO UPDATE SET
  "tenantId"   = EXCLUDED."tenantId",
  "updater"    = EXCLUDED."updater",
  "updateTime" = EXCLUDED."updateTime",
  "deleted"    = EXCLUDED."deleted";

-- 修正序列，避免后续自增主键冲突
SELECT setval(
  pg_get_serial_sequence('"sys_menu"', 'id'),
  GREATEST((SELECT COALESCE(MAX("id"), 1) FROM "sys_menu"), 1),
  true
);
