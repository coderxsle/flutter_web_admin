-- sys_menu 初始化数据
-- 数据来源: docs/sys_menu.md
-- 注意: 当前表存在 permission 唯一索引，因此对原始空权限补齐为 menu:auto:<id>




INSERT INTO "sys_menu" (
  "id", "parentId", "type", "title", "icon", "permission", "path", "redirect", "component",
  "componentName", "activeMenu", "sort", "status", "breadcrumb", "visible", "keepAlive", "alwaysShow",
  "showInTabs", "affix", "deleted", "creator", "createTime", "updater", "updateTime"
) VALUES
  (1, 0, 1, '仪表盘', NULL, 'menu:dashboard', '/dashboard', '/dashboard/index', 'Layout', NULL, NULL, 2, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (101, 1, 2, '分析页', 'menu-analyse', 'menu:dashboard:analyse', '/analyse/index', NULL, 'analyse/index', NULL, NULL, 1, 1, 'false', true, false, false, true, true, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  -- 分析页按钮
  (10101, 101, 3, '查看数据', NULL, 'dashboard:analyse:view', '', NULL, NULL, NULL, NULL, 1, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (10102, 101, 3, '刷新', NULL, 'dashboard:analyse:refresh', '', NULL, NULL, NULL, NULL, 2, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (10103, 101, 3, '导出报表', NULL, 'dashboard:analyse:export', '', NULL, NULL, NULL, NULL, 3, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),


  (2, 0, 1, '增删查改', 'menu-crud', 'menu:auto:2', '/crud', '/crud/index', 'Layout', NULL, NULL, 3, 1, true, true, true, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (201, 2, 2, '增删查改', NULL, 'menu:crud:index', '/crud/index', NULL, 'crud/main/index', NULL, NULL, 0, 1, 'false', true, true, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (20101, 201, 3, '列表', NULL, 'crud:index:list', '', NULL, NULL, NULL, NULL, 1, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (20102, 201, 3, '详情', NULL, 'crud:index:detail', '', NULL, NULL, NULL, NULL, 2, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (20103, 201, 3, '新增', NULL, 'crud:index:add', '', NULL, NULL, NULL, NULL, 3, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (20104, 201, 3, '修改', NULL, 'crud:index:update', '', NULL, NULL, NULL, NULL, 4, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (20105, 201, 3, '删除', NULL, 'crud:index:delete', '', NULL, NULL, NULL, NULL, 5, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (20106, 201, 3, '导入', NULL, 'crud:index:import', '', NULL, NULL, NULL, NULL, 6, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (20107, 201, 3, '导出', NULL, 'crud:index:export', '', NULL, NULL, NULL, NULL, 7, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),


  (3, 0, 1, '文件管理', 'menu-file', 'menu:file', '/file', '/file/index', 'Layout', NULL, NULL, 4, 1, true, true, true, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (301, 3, 2, '文件列表', NULL, 'menu:file:index', '/file/index', NULL, 'file/main/index', NULL, NULL, 0, 1, 'false', true, true, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (30101, 301, 3, '列表', NULL, 'file:index:list', '', NULL, NULL, NULL, NULL, 1, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (30102, 301, 3, '详情', NULL, 'file:index:detail', '', NULL, NULL, NULL, NULL, 2, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (30103, 301, 3, '上传', NULL, 'file:index:upload', '', NULL, NULL, NULL, NULL, 3, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (30104, 301, 3, '下载', NULL, 'file:index:download', '', NULL, NULL, NULL, NULL, 4, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (30105, 301, 3, '删除', NULL, 'file:index:delete', '', NULL, NULL, NULL, NULL, 5, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (30106, 301, 3, '批量删除', NULL, 'file:index:batchDelete', '', NULL, NULL, NULL, NULL, 6, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),

  
  (4, 0, 1, '表单管理', 'menu-form', 'menu:form', '/form', '/form/base', 'Layout', NULL, NULL, 5, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (401, 4, 2, '基础表单', 'icon-park-outline:notes', 'menu:form:base', '/form/base', NULL, 'form/base/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (40101, 401, 3, '查看', NULL, 'form:base:view', '', NULL, NULL, NULL, NULL, 1, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (40102, 401, 3, '提交', NULL, 'form:base:submit', '', NULL, NULL, NULL, NULL, 2, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (40103, 401, 3, '重置', NULL, 'form:base:reset', '', NULL, NULL, NULL, NULL, 3, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),

  (402, 4, 2, '分步表单', 'icon-park-outline:notes', 'menu:form:step', '/form/step', NULL, 'form/step/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (403, 4, 2, '配置表单', 'icon-park-outline:notes', 'menu:form:custom', '/form/custom', NULL, 'form/custom/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (404, 4, 2, '编辑表格', 'icon-park-outline:notes', 'menu:form:table', '/form/table', NULL, 'form/table/index', NULL, NULL, 0, 1, true, true, true, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  

  (5, 0, 1, '表格管理', 'menu-table', 'menu:table', '/table', '/table/base', 'Layout', NULL, NULL, 6, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (501, 5, 2, '基础表格', 'icon-park-outline:table-file', 'menu:table:base', '/table/base', NULL, 'table/base/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (50101, 501, 3, '列表', NULL, 'table:base:list', '', NULL, NULL, NULL, NULL, 1, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (50102, 501, 3, '详情', NULL, 'table:base:detail', '', NULL, NULL, NULL, NULL, 2, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (50103, 501, 3, '新增', NULL, 'table:base:add', '', NULL, NULL, NULL, NULL, 3, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (50104, 501, 3, '修改', NULL, 'table:base:update', '', NULL, NULL, NULL, NULL, 4, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (50105, 501, 3, '删除', NULL, 'table:base:delete', '', NULL, NULL, NULL, NULL, 5, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (50106, 501, 3, '导入', NULL, 'table:base:import', '', NULL, NULL, NULL, NULL, 6, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (50107, 501, 3, '导出', NULL, 'table:base:export', '', NULL, NULL, NULL, NULL, 7, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),

  (502, 5, 2, '自定义表格', 'icon-park-outline:table-file', 'menu:table:custom', '/table/custom', NULL, 'table/custom/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (503, 5, 2, '配置化表格', 'icon-park-outline:table-file', 'menu:table:custom2', '/table/custom2', NULL, 'table/custom2/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (504, 5, 2, '弹窗表格', 'icon-park-outline:table-file', 'menu:table:dialog', '/table/dialog', NULL, 'table/dialog/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  

  (6, 0, 1, '错误页', 'menu-error', 'menu:error', '/error', '/error/403', 'Layout', NULL, NULL, 7, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (601, 6, 2, '403页', 'icon-park-outline:bug', 'menu::error:403', '/error/403', NULL, 'error/403', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (602, 6, 2, '404页', 'icon-park-outline:bug', 'menu::error:404', '/error/404', NULL, 'error/404', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (603, 6, 2, '500页', 'icon-park-outline:bug', 'menu:error:500', '/error/500', NULL, 'error/500', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  

  (7, 0, 1, '结果页', 'menu-result', 'menu:result', '/result', '/result/success', 'Layout', NULL, NULL, 8, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (701, 7, 2, '成功页', 'icon-park-outline:report', 'menu:result:success', '/result/success', NULL, 'result/success/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (702, 7, 2, '失败页', 'icon-park-outline:report', 'menu:result:fail', '/result/fail', NULL, 'result/fail/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),


  (8, 0, 1, '系统管理', 'menu-system', 'menu:system', '/system', '/system/user', 'Layout', NULL, NULL, 9, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (801, 8, 2, '用户管理', 'icon-park-outline:setting-config', 'menu:system:user', '/system/user', NULL, 'system/user/index', NULL, NULL, 1, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80101, 801, 3, '列表', NULL, 'system:user:list', '', NULL, NULL, NULL, NULL, 1, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80102, 801, 3, '详情', NULL, 'system:user:detail', '', NULL, NULL, NULL, NULL, 2, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80103, 801, 3, '新增', NULL, 'system:user:add', '', NULL, NULL, NULL, NULL, 3, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80104, 801, 3, '修改', NULL, 'system:user:update', '', NULL, NULL, NULL, NULL, 4, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80105, 801, 3, '删除', NULL, 'system:user:delete', '', NULL, NULL, NULL, NULL, 5, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80106, 801, 3, '导入', NULL, 'system:user:import', '', NULL, NULL, NULL, NULL, 6, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80107, 801, 3, '导出', NULL, 'system:user:export', '', NULL, NULL, NULL, NULL, 7, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80108, 801, 3, '重置密码', NULL, 'system:user:resetPwd', '', NULL, NULL, NULL, NULL, 8, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80109, 801, 3, '启用', NULL, 'system:user:enable', '', NULL, NULL, NULL, NULL, 9, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80110, 801, 3, '禁用', NULL, 'system:user:disable', '', NULL, NULL, NULL, NULL, 10, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),

  (802, 8, 2, '角色管理', 'icon-park-outline:setting-config', 'menu:system:role', '/system/role', NULL, 'system/role/index', NULL, NULL, 2, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80201, 802, 3, '列表', NULL, 'system:role:list', '', NULL, NULL, NULL, NULL, 1, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80202, 802, 3, '详情', NULL, 'system:role:detail', '', NULL, NULL, NULL, NULL, 2, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80203, 802, 3, '新增', NULL, 'system:role:add', '', NULL, NULL, NULL, NULL, 3, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80204, 802, 3, '修改', NULL, 'system:role:update', '', NULL, NULL, NULL, NULL, 4, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80205, 802, 3, '删除', NULL, 'system:role:delete', '', NULL, NULL, NULL, NULL, 5, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80206, 802, 3, '导出', NULL, 'system:role:export', '', NULL, NULL, NULL, NULL, 6, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),

  (803, 8, 2, '部门管理', 'icon-park-outline:setting-config', 'menu:system:dept', '/system/dept', NULL, 'system/dept/index', NULL, NULL, 3, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80301, 803, 3, '列表', NULL, 'system:dept:list', '', NULL, NULL, NULL, NULL, 1, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80302, 803, 3, '详情', NULL, 'system:dept:detail', '', NULL, NULL, NULL, NULL, 2, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80303, 803, 3, '新增', NULL, 'system:dept:add', '', NULL, NULL, NULL, NULL, 3, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80304, 803, 3, '修改', NULL, 'system:dept:update', '', NULL, NULL, NULL, NULL, 4, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80305, 803, 3, '删除', NULL, 'system:dept:delete', '', NULL, NULL, NULL, NULL, 5, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),

  (804, 8, 2, '菜单管理', 'icon-park-outline:setting-config', 'menu:system:menu', '/system/menu', NULL, 'system/menu/index', NULL, NULL, 4, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80401, 804, 3, '列表', NULL, 'system:menu:list', '', NULL, NULL, NULL, NULL, 1, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80402, 804, 3, '新增', NULL, 'system:menu:add', '', NULL, NULL, NULL, NULL, 2, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80403, 804, 3, '修改', NULL, 'system:menu:update', '', NULL, NULL, NULL, NULL, 3, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80404, 804, 3, '删除', NULL, 'system:menu:delete', '', NULL, NULL, NULL, NULL, 4, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  
  (805, 8, 2, '字典管理', 'icon-park-outline:setting-config', 'menu:system:dict', '/system/dict', NULL, 'system/dict/index', NULL, NULL, 5, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80501, 805, 3, '列表', NULL, 'system:dict:list', '', NULL, NULL, NULL, NULL, 1, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80502, 805, 3, '新增', NULL, 'system:dict:add', '', NULL, NULL, NULL, NULL, 2, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80503, 805, 3, '修改', NULL, 'system:dict:update', '', NULL, NULL, NULL, NULL, 3, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80504, 805, 3, '删除', NULL, 'system:dict:delete', '', NULL, NULL, NULL, NULL, 4, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80505, 805, 3, '导出', NULL, 'system:dict:export', '', NULL, NULL, NULL, NULL, 5, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),

  (806, 8, 2, '用户账户', 'icon-park-outline:setting-config', 'menu:system:account', '/system/account', NULL, 'system/account/index', NULL, NULL, 6, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (80601, 806, 3, '详情', NULL, 'system:account:detail', '', NULL, NULL, NULL, NULL, 2, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),


  (9, 0, 1, '权限测试', 'menu-test', 'menu:test', '/test', 'noRedirect', 'Layout', NULL, NULL, 9, 1, true, true, false, true, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (9101, 9, 2, '测试页面1', 'icon-park-outline:protect', 'menu:test:page1', '/test/page1', NULL, 'test/page1/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (9102, 9, 2, '测试页面2', 'icon-park-outline:protect', 'menu:test:page2', '/test/page2', NULL, 'test/page2/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (910201, 9101, 3, '按钮新增', NULL, 'user:test:page1:add', '', NULL, NULL, NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (910202, 9101, 3, '按钮编辑', NULL, 'user:test:page1:edit', '', NULL, NULL, NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (910203, 9101, 3, '按钮删除', NULL, 'user:test:page1:delete', '', NULL, NULL, NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (910204, 9102, 3, '按钮新增(测试)', NULL, 'test:test:page2:add', '', NULL, NULL, NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (910205, 9102, 3, '按钮编辑(测试)', NULL, 'test:test:page2:edit', '', NULL, NULL, NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (910206, 9102, 3, '按钮删除(测试)', NULL, 'test:test:page2:delete', '', NULL, NULL, NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),

  (10, 0, 1, '示例页', NULL, 'menu:demo', '/demo', '/demo/index', 'Layout', NULL, NULL, 15, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (1001, 10, 2, '示例页', 'menu-example', 'menu:demo:index', '/demo/index', NULL, 'demo/index', NULL, NULL, 0, 1, 'false', true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  

  (11, 0, 1, '多级缓存', 'menu-multi', 'menu:multi', '/multi', '/multi/menu1/menu1-1/menu1-1-1', 'Layout', NULL, NULL, 11, 1, true, true, true, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (1101, 11, 2, 'menu1', 'icon-park-outline:connection-point', 'menu:multi:menu1', '/multi/menu1', NULL, NULL, NULL, NULL, 0, 1, true, true, true, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (110101, 1101, 2, 'menu1-1', 'icon-park-outline:connection-point', 'menu:multi:menu1-1', '/multi/menu1/menu1-1', NULL, NULL, NULL, NULL, 0, 1, true, true, false, true, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (11010101, 110101, 2, 'menu1-1-1', 'icon-park-outline:connection-point', 'menu:multi:menu1-1-1', '/multi/menu1/menu1-1/menu1-1-1', NULL, 'multi/menu1/menu1-1/menu1-1-1/index', NULL, NULL, 0, 1, true, true, true, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (110102, 1101, 2, 'menu1-2', 'icon-park-outline:connection-point', 'menu:multi:menu1-2', '/multi/menu1/menu1-2', NULL, 'multi/menu1/menu1-2/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (1102, 11, 2, 'menu2', 'icon-park-outline:connection-point', 'menu:multi:menu2', '/multi/menu2', NULL, NULL, NULL, NULL, 0, 1, true, true, true, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (110201, 1102, 2, 'menu2-1', 'icon-park-outline:connection-point', 'menu:multi:menu2-1', '/multi/menu2/menu2-1', NULL, 'multi/menu2/menu2-1/index', NULL, NULL, 0, 1, true, true, true, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (110202, 1102, 2, 'menu2-2', 'icon-park-outline:connection-point', 'menu:multi:menu2-2', '/multi/menu2/menu2-2', NULL, 'multi/menu2/menu2-2/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  

  (12, 0, 1, '关于我们', NULL, 'menu:about', '/about', '/about/index', 'Layout', NULL, NULL, 20, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (1201, 12, 2, '关于项目', 'menu-about', 'menu:about:index', '/about/index', NULL, 'about/index', NULL, NULL, 0, 1, 'false', true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  
  
  (13, 0, 1, '详情页', 'menu-detail', 'menu:detail', '/detail', '/detail/base', 'Layout', NULL, NULL, 6, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (1301, 13, 2, '基本详情', 'icon-park-outline:newspaper-folding', 'menu:detail:base', '/detail/base', NULL, 'detail/base/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (1302, 13, 2, '普通详情', 'icon-park-outline:newspaper-folding', 'menu:detail:senior', '/detail/senior', NULL, 'detail/senior/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  
  
  (14, 0, 1, '文档', 'menu-document', 'menu:document', '/document', NULL, 'Layout', NULL, NULL, 14, 1, true, true, true, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (1401, 14, 2, 'ArcoDesign文档', 'arco', 'menu:arco:document', '/document/arco-design-vue', NULL, 'document/arco-design-vue/index', NULL, NULL, 0, 1, 'false', true, true, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (1402, 14, 2, 'Vite文档', 'vite', 'menu:vite:document', '/document/vite', NULL, 'document/vite/index', NULL, NULL, 1, 1, 'false', true, true, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (1403, 14, 2, '项目地址(外链)', 'menu-gitee', 'menu:gitee:document', 'https://gitee.com/lin0716/gi-demo', NULL, 'https://gitee.com/lin0716/gi-demo', NULL, NULL, 2, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),

  
  (15, 0, 1, '布局页', 'menu-layout', 'menu:layout', '/layout', '/layout/demo1', 'Layout', NULL, NULL, 6, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (1501, 15, 2, '布局1', 'icon-park-outline:layout-three', 'menu:layout:demo1', '/layout/demo1', NULL, 'layout/demo1/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (1502, 15, 2, '布局2', 'icon-park-outline:layout-three', 'menu:layout:demo2', '/layout/demo2', NULL, 'layout/demo2/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (1503, 15, 2, '布局3', 'icon-park-outline:layout-three', 'menu:layout:demo3', '/layout/demo3', NULL, 'layout/demo3/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (1504, 15, 2, '布局4', 'icon-park-outline:layout-three', 'menu:layout:demo4', '/layout/demo4', NULL, 'layout/demo4/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
  (1505, 15, 2, '布局5', 'icon-park-outline:layout-three', 'menu:layout:demo5', '/layout/demo5', NULL, 'layout/demo5/index', NULL, NULL, 0, 1, true, true, false, false, true, false, false, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP)

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

-- 修正序列，避免后续自增主键冲突
SELECT setval(
  pg_get_serial_sequence('"sys_menu"', 'id'),
  GREATEST((SELECT COALESCE(MAX("id"), 1) FROM "sys_menu"), 1),
  true
);