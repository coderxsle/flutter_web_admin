-- sys_menu 初始化数据
-- 数据来源: docs/sys_menu.md
-- 注意: 当前表存在 permission 唯一索引，因此对原始空权限补齐为 menu:auto:<id>

INSERT INTO "sys_menu" (
  "id", "name", "permission", "type", "sort", "parentId", "breadcrumb", "path", "icon",
  "component", "componentName", "redirect", "status", "visible", "keepAlive", "alwaysShow",
  "activeMenu", "showInTabs", "affix", "creator", "createTime", "updater", "updateTime", "deleted"
) VALUES
  (1, '分析页', 'menu:auto:1', 1, 2, 0, 'true', '/analyse', NULL, 'Layout', NULL, '/analyse/index', 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (101, '分析页', 'menu:auto:101', 2, 1, 1, 'false', '/analyse/index', 'menu-analyse', 'analyse/index', NULL, NULL, 1, true, false, false, NULL, true, true, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  (2, '数据管理', 'menu:auto:2', 1, 3, 0, 'true', '/data', 'menu-data', 'Layout', NULL, '/data/index', 1, true, true, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (201, '数据管理', 'menu:auto:201', 2, 0, 2, 'false', '/data/index', NULL, 'data/main/index', NULL, NULL, 1, true, true, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (202, '详情', 'menu:auto:202', 2, 0, 2, 'true', '/data/detail/:id', NULL, 'data/detail/index', NULL, NULL, 1, false, false, false, '/data/index', true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (203, '新增', 'menu:auto:203', 2, 0, 2, 'true', '/data/form', NULL, 'data/form/index', NULL, NULL, 1, false, false, false, '/data/index', true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  (3, '文件管理', 'menu:auto:3', 1, 4, 0, 'true', '/file', 'menu-file', 'Layout', NULL, '/file/index', 1, true, true, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (301, '文件管理', 'menu:auto:301', 2, 0, 3, 'false', '/file/index', NULL, 'file/main/index', NULL, NULL, 1, true, true, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (302, '详情', 'menu:auto:302', 2, 0, 3, 'true', '/file/detail', NULL, 'file/detail/index', NULL, NULL, 1, false, false, false, '/file/index', false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  (4, '表单管理', 'menu:auto:4', 1, 5, 0, 'true', '/form', 'menu-form', 'Layout', NULL, '/form/base', 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (401, '基础表单', 'menu:auto:401', 2, 0, 4, 'true', '/form/base', 'icon-park-outline:notes', 'form/base/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (402, '分步表单', 'menu:auto:402', 2, 0, 4, 'true', '/form/step', 'icon-park-outline:notes', 'form/step/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (403, '配置表单', 'menu:auto:403', 2, 0, 4, 'true', '/form/custom', 'icon-park-outline:notes', 'form/custom/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (404, '编辑表格', 'menu:auto:404', 2, 0, 4, 'true', '/form/table', 'icon-park-outline:notes', 'form/table/index', NULL, NULL, 1, true, true, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  (5, '表格管理', 'menu:auto:5', 1, 6, 0, 'true', '/table', 'menu-table', 'Layout', NULL, '/table/base', 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (501, '基础表格', 'menu:auto:501', 2, 0, 5, 'true', '/table/base', 'icon-park-outline:table-file', 'table/base/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (502, '自定义表格', 'menu:auto:502', 2, 0, 5, 'true', '/table/custom', 'icon-park-outline:table-file', 'table/custom/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (503, '配置化表格', 'menu:auto:503', 2, 0, 5, 'true', '/table/custom2', 'icon-park-outline:table-file', 'table/custom2/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (504, '弹窗表格', 'menu:auto:504', 2, 0, 5, 'true', '/table/dialog', 'icon-park-outline:table-file', 'table/dialog/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  (15, '布局页', 'menu:auto:15', 1, 6, 0, 'true', '/layout', 'menu-layout', 'Layout', NULL, '/layout/demo1', 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (1501, '布局1', 'menu:auto:1501', 2, 0, 15, 'true', '/layout/demo1', 'icon-park-outline:layout-three', 'layout/demo1/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (1502, '布局2', 'menu:auto:1502', 2, 0, 15, 'true', '/layout/demo2', 'icon-park-outline:layout-three', 'layout/demo2/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (1503, '布局3', 'menu:auto:1503', 2, 0, 15, 'true', '/layout/demo3', 'icon-park-outline:layout-three', 'layout/demo3/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (1504, '布局4', 'menu:auto:1504', 2, 0, 15, 'true', '/layout/demo4', 'icon-park-outline:layout-three', 'layout/demo4/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (1505, '布局5', 'menu:auto:1505', 2, 0, 15, 'true', '/layout/demo5', 'icon-park-outline:layout-three', 'layout/demo5/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  (6, '错误页', 'menu:auto:6', 1, 7, 0, 'true', '/error', 'menu-error', 'Layout', NULL, '/error/403', 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (601, '403页', 'menu:auto:601', 2, 0, 6, 'true', '/error/403', 'icon-park-outline:bug', 'error/403', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (602, '404页', 'menu:auto:602', 2, 0, 6, 'true', '/error/404', 'icon-park-outline:bug', 'error/404', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (603, '500页', 'menu:auto:603', 2, 0, 6, 'true', '/error/500', 'icon-park-outline:bug', 'error/500', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  (7, '结果页', 'menu:auto:7', 1, 8, 0, 'true', '/result', 'menu-result', 'Layout', NULL, '/result/success', 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (701, '成功页', 'menu:auto:701', 2, 0, 7, 'true', '/result/success', 'icon-park-outline:report', 'result/success/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (702, '失败页', 'menu:auto:702', 2, 0, 7, 'true', '/result/fail', 'icon-park-outline:report', 'result/fail/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  (8, '系统管理', 'menu:auto:8', 1, 9, 0, 'true', '/system', 'menu-system', 'Layout', NULL, '/system/user', 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (801, '用户管理', 'menu:auto:801', 2, 1, 8, 'true', '/system/user', 'icon-park-outline:setting-config', 'system/user/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (802, '角色管理', 'menu:auto:802', 2, 2, 8, 'true', '/system/role', 'icon-park-outline:setting-config', 'system/role/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (803, '部门管理', 'menu:auto:803', 2, 3, 8, 'true', '/system/dept', 'icon-park-outline:setting-config', 'system/dept/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (804, '菜单管理', 'menu:auto:804', 2, 4, 8, 'true', '/system/menu', 'icon-park-outline:setting-config', 'system/menu/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (805, '字典管理', 'menu:auto:805', 2, 5, 8, 'true', '/system/dict', 'icon-park-outline:setting-config', 'system/dict/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (806, '用户账户', 'menu:auto:806', 2, 6, 8, 'true', '/system/account', 'icon-park-outline:setting-config', 'system/account/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  (81, '权限测试', 'menu:auto:81', 1, 9, 0, 'true', '/test', 'menu-test', 'Layout', NULL, 'noRedirect', 1, true, false, true, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (8101, '测试页面1', 'menu:auto:8101', 2, 0, 81, 'true', '/test/page1', 'icon-park-outline:protect', 'test/page1/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (8102, '测试页面2', 'menu:auto:8102', 2, 0, 81, 'true', '/test/page2', 'icon-park-outline:protect', 'test/page2/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (810201, '按钮新增', 'user:btn:add', 3, 0, 8102, 'true', '', NULL, NULL, NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (810202, '按钮编辑', 'user:btn:edit', 3, 0, 8102, 'true', '', NULL, NULL, NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (810203, '按钮删除', 'user:btn:delete', 3, 0, 8102, 'true', '', NULL, NULL, NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (810204, '按钮新增(测试)', 'test:btn:add', 3, 0, 8102, 'true', '', NULL, NULL, NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (810205, '按钮编辑(测试)', 'test:btn:edit', 3, 0, 8102, 'true', '', NULL, NULL, NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (810206, '按钮删除(测试)', 'test:btn:delete', 3, 0, 8102, 'true', '', NULL, NULL, NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  (9, '示例页', 'menu:auto:9', 1, 15, 0, 'true', '/demo', NULL, 'Layout', NULL, '/demo/index', 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (901, '示例页', 'menu:auto:901', 2, 0, 9, 'false', '/demo/index', 'menu-example', 'demo/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  (10, '多级缓存', 'menu:auto:10', 1, 11, 0, 'true', '/multi', 'menu-multi', 'Layout', NULL, '/multi/menu1/menu1-1/menu1-1-1', 1, true, true, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (1001, 'menu1', 'menu:auto:1001', 2, 0, 10, 'true', '/multi/menu1', 'icon-park-outline:connection-point', NULL, NULL, NULL, 1, true, true, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (100101, 'menu1-1', 'menu:auto:100101', 2, 0, 1001, 'true', '/multi/menu1/menu1-1', 'icon-park-outline:connection-point', NULL, NULL, NULL, 1, true, false, true, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (10010101, 'menu1-1-1', 'menu:auto:10010101', 2, 0, 100101, 'true', '/multi/menu1/menu1-1/menu1-1-1', 'icon-park-outline:connection-point', 'multi/menu1/menu1-1/menu1-1-1/index', NULL, NULL, 1, true, true, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (100102, 'menu1-2', 'menu:auto:100102', 2, 0, 1001, 'true', '/multi/menu1/menu1-2', 'icon-park-outline:connection-point', 'multi/menu1/menu1-2/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (1002, 'menu2', 'menu:auto:1002', 2, 0, 10, 'true', '/multi/menu2', 'icon-park-outline:connection-point', NULL, NULL, NULL, 1, true, true, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (100201, 'menu2-1', 'menu:auto:100201', 2, 0, 1002, 'true', '/multi/menu2/menu2-1', 'icon-park-outline:connection-point', 'multi/menu2/menu2-1/index', NULL, NULL, 1, true, true, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (100202, 'menu2-2', 'menu:auto:100202', 2, 0, 1002, 'true', '/multi/menu2/menu2-2', 'icon-park-outline:connection-point', 'multi/menu2/menu2-2/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  (11, '关于我们', 'menu:auto:11', 1, 20, 0, 'true', '/about', NULL, 'Layout', NULL, '/about/index', 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (1101, '关于项目', 'menu:auto:1101', 2, 0, 11, 'false', '/about/index', 'menu-about', 'about/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  (14, '文档', 'menu:auto:14', 1, 14, 0, 'true', '/document', 'menu-document', 'Layout', NULL, NULL, 1, true, true, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (1401, 'ArcoDesign文档', 'menu:auto:1401', 2, 0, 14, 'false', '/document/arco-design-vue', 'arco', 'document/arco-design-vue/index', NULL, NULL, 1, true, true, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (1402, 'Vite文档', 'menu:auto:1402', 2, 1, 14, 'false', '/document/vite', 'vite', 'document/vite/index', NULL, NULL, 1, true, true, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (1403, '项目地址(外链)', 'menu:auto:1403', 2, 2, 14, 'true', 'https://gitee.com/lin0716/gi-demo', 'menu-gitee', 'https://gitee.com/lin0716/gi-demo', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  (13, '详情页', 'menu:auto:13', 1, 6, 0, 'true', '/detail', 'menu-detail', 'Layout', NULL, '/detail/base', 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (1301, '基本详情', 'menu:auto:1301', 2, 0, 13, 'true', '/detail/base', 'icon-park-outline:newspaper-folding', 'detail/base/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (1302, '普通详情', 'menu:auto:1302', 2, 0, 13, 'true', '/detail/senior', 'icon-park-outline:newspaper-folding', 'detail/senior/index', NULL, NULL, 1, true, false, false, NULL, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false)
ON CONFLICT ("id") DO UPDATE SET
  "name" = EXCLUDED."name",
  "permission" = EXCLUDED."permission",
  "type" = EXCLUDED."type",
  "sort" = EXCLUDED."sort",
  "parentId" = EXCLUDED."parentId",
  "breadcrumb" = EXCLUDED."breadcrumb",
  "path" = EXCLUDED."path",
  "icon" = EXCLUDED."icon",
  "component" = EXCLUDED."component",
  "componentName" = EXCLUDED."componentName",
  "redirect" = EXCLUDED."redirect",
  "status" = EXCLUDED."status",
  "visible" = EXCLUDED."visible",
  "keepAlive" = EXCLUDED."keepAlive",
  "alwaysShow" = EXCLUDED."alwaysShow",
  "activeMenu" = EXCLUDED."activeMenu",
  "showInTabs" = EXCLUDED."showInTabs",
  "affix" = EXCLUDED."affix",
  "updater" = EXCLUDED."updater",
  "updateTime" = EXCLUDED."updateTime",
  "deleted" = EXCLUDED."deleted";

-- 修正序列，避免后续自增主键冲突
SELECT setval(
  pg_get_serial_sequence('"sys_menu"', 'id'),
  GREATEST((SELECT COALESCE(MAX("id"), 1) FROM "sys_menu"), 1),
  true
);