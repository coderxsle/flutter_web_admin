-- sys_operate_log 操作日志菜单初始化数据
-- 说明：
-- 1. 挂在「系统管理」(id=8) 下，type=2 为菜单、type=3 为按钮权限点
-- 2. 支持重复执行：ON CONFLICT ("id") DO UPDATE
-- 3. 菜单只读：不提供新增/修改/删除，按钮只保留「列表」「详情」
-- 4. 权限标识使用 system:operateLog:*，与前端 /system/operate-log 对应

INSERT INTO "sys_menu" (
  "id", "parentId", "type", "title", "icon", "permission", "path", "redirect", "component",
  "componentName", "activeMenu", "sort", "status", "breadcrumb", "visible", "keepAlive", "alwaysShow",
  "showInTabs", "affix", "deleted", "creator", "createTime", "updater", "updateTime"
) VALUES
  (807, 8, 2, '操作日志', 'icon-park-outline:log', 'menu:system:operateLog', '/system/operate-log', NULL, 'system/operate-log/index',
   NULL, NULL, 7, 1, true, true, false, false, true, false, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (80701, 807, 3, '列表', NULL, 'system:operateLog:list', '', NULL, NULL,
   NULL, NULL, 1, 1, true, true, false, false, true, false, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (80702, 807, 3, '详情', NULL, 'system:operateLog:detail', '', NULL, NULL,
   NULL, NULL, 2, 1, true, true, false, false, true, false, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP)
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

-- 授权：超级管理员与系统管理员才需要看操作日志
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
  AND m."id" IN (807, 80701, 80702)
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
