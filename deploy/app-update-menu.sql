-- 应用管理 / 版本更新 菜单（幂等，可在库恢复后重复执行）
-- 用法：psql -U postgres -d serverpod -v ON_ERROR_STOP=1 -f deploy/app-update-menu.sql

DO $$
DECLARE
  pid bigint;
BEGIN
  SELECT id INTO pid FROM sys_menu
   WHERE "tenantId" = 0 AND path = '/app' AND deleted = false
   LIMIT 1;

  IF pid IS NULL THEN
    INSERT INTO sys_menu ("tenantId", "parentId", type, title, icon, path, component, permission,
                          sort, status, visible, "alwaysShow", "showInTabs", breadcrumb,
                          "keepAlive", affix, deleted, "createTime", "updateTime")
    VALUES (0, 0, 1, '应用管理', '', '/app', 'Layout', 'menu:app',
            24, 1, true, true, true, true, true, false, false, now(), now())
    RETURNING id INTO pid;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM sys_menu WHERE "tenantId" = 0 AND path = '/app/update' AND deleted = false) THEN
    INSERT INTO sys_menu ("tenantId", "parentId", type, title, icon, path, component, permission,
                          sort, status, visible, "alwaysShow", "showInTabs", breadcrumb,
                          "keepAlive", affix, deleted, "createTime", "updateTime")
    VALUES (0, pid, 2, '版本更新', '', '/app/update', 'app/update/index', 'menu:app:update',
            0, 1, true, false, true, false, true, false, false, now(), now());
  END IF;
END $$;

-- 多租户部署：把同一套菜单复制给每个租户（已在租户内存在则不重复插入）
DO $$
DECLARE
  t record;
  parent_id bigint;
BEGIN
  FOR t IN SELECT id FROM sys_tenant WHERE deleted = false LOOP
    SELECT id INTO parent_id FROM sys_menu
     WHERE "tenantId" = t.id AND path = '/app' AND deleted = false LIMIT 1;

    IF parent_id IS NULL THEN
      INSERT INTO sys_menu ("tenantId", "parentId", type, title, icon, path, component, permission,
                            sort, status, visible, "alwaysShow", "showInTabs", breadcrumb,
                            "keepAlive", affix, deleted, "createTime", "updateTime")
      VALUES (t.id, 0, 1, '应用管理', '', '/app', 'Layout', 'menu:app',
              24, 1, true, true, true, true, true, false, false, now(), now())
      RETURNING id INTO parent_id;
    END IF;

    IF NOT EXISTS (SELECT 1 FROM sys_menu WHERE "tenantId" = t.id AND path = '/app/update' AND deleted = false) THEN
      INSERT INTO sys_menu ("tenantId", "parentId", type, title, icon, path, component, permission,
                            sort, status, visible, "alwaysShow", "showInTabs", breadcrumb,
                            "keepAlive", affix, deleted, "createTime", "updateTime")
      VALUES (t.id, parent_id, 2, '版本更新', '', '/app/update', 'app/update/index', 'menu:app:update',
              0, 1, true, false, true, false, true, false, false, now(), now());
    END IF;
  END LOOP;
END $$;
