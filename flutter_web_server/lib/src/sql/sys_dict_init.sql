-- sys_dict_type / sys_dict_data 初始化数据
-- 说明：提供常见脚手架系统的字典类型与字典数据，确保类型与数据可关联

INSERT INTO "sys_dict_code" (
  "id", "tenantId", "name", "code", "status", "description",
  "creator", "createTime", "updater", "updateTime", "deleted"
) VALUES
  (1, 0, '性别', 'gender', 1, '用户性别字典', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (2, 0, '通用状态', 'common_status', 1, '启用/停用状态', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (3, 0, '是否', 'yes_no', 1, '通用是/否', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (4, 0, '菜单类型', 'menu_type', 1, '菜单类型字典', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (5, 0, '数据范围', 'data_scope', 1, '角色数据权限范围', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (6, 0, '账号状态', 'account_status', 1, '账号启用/禁用', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (7, 0, '字典状态', 'dict_status', 1, '字典项状态', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (8, 0, '用户状态', 'user_status', 1, '用户启用/禁用状态', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (9, 0, '用户类型', 'user_type', 1, '系统内置/自定义', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false)
ON CONFLICT ("id") DO UPDATE SET
  "tenantId" = EXCLUDED."tenantId",
  "name" = EXCLUDED."name",
  "code" = EXCLUDED."code",
  "status" = EXCLUDED."status",
  "description" = EXCLUDED."description",
  "updater" = EXCLUDED."updater",
  "updateTime" = EXCLUDED."updateTime",
  "deleted" = EXCLUDED."deleted";

INSERT INTO "sys_dict_data" (
  "id", "tenantId", "name", "value", "code", "color",
  "description", "status", "sort", "creator", "createTime", "updater",
  "updateTime", "deleted"
) VALUES
  -- gender
  (1001, 0, '男', '1', 'gender', 'blue', '性别-男', 1, 1, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (1002, 0, '女', '2', 'gender', 'pink', '性别-女', 1, 2, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (1003, 0, '保密', '3', 'gender', 'gray', '性别-保密', 1, 3, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),

  -- common_status
  (2001, 0, '正常', '1', 'common_status', 'green', '启用状态', 1, 1, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (2002, 0, '禁用', '0', 'common_status', 'red', '停用状态', 1, 2, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),

  -- yes_no
  (3001, 0, '是', '1', 'yes_no', 'green', '是', 1, 1, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (3002, 0, '否', '0', 'yes_no', 'red', '否', 1, 2, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),

  -- menu_type
  (4001, 0, '目录', '1', 'menu_type', 'blue', '菜单目录', 1, 1, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (4002, 0, '菜单', '2', 'menu_type', 'green', '菜单项', 1, 2, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (4003, 0, '按钮', '3', 'menu_type', 'orange', '按钮权限', 1, 3, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),

  -- data_scope
  (5001, 0, '全部数据', '1', 'data_scope', 'blue', '全部数据权限', 1, 1, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (5002, 0, '本部门及以下', '2', 'data_scope', 'green', '本部门及以下数据权限', 1, 2, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (5003, 0, '本部门', '3', 'data_scope', 'orange', '本部门数据权限', 1, 3, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (5004, 0, '本人', '4', 'data_scope', 'gray', '仅本人数据权限', 1, 4, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (5005, 0, '自定', '5', 'data_scope', 'purple', '自定数据权限', 1, 5, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),

  -- account_status
  (6002, 0, '禁用', '0', 'account_status', 'red', '账号禁用', 1, 2, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (6001, 0, '正常', '1', 'account_status', 'green', '账号正常', 1, 1, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (6003, 0, '锁定', '2', 'account_status', 'orange', '账号锁定', 1, 3, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),

  -- dict_status
  (7002, 0, '停用', '0', 'dict_status', 'red', '字典停用', 1, 2, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (7001, 0, '正常', '1', 'dict_status', 'green', '字典正常', 1, 1, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),

  -- user_status
  (8001, 0, '禁用', '0', 'user_status', 'red', '用户禁用', 1, 1, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (8002, 0, '正常', '1', 'user_status', 'green', '用户正常', 1, 2, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),

  -- user_type
  (9001, 0, '系统内置', '1', 'user_type', 'blue', '系统内置用户', 1, 1, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false),
  (9002, 0, '自定义', '2', 'user_type', 'orange', '自定义用户', 1, 2, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, false)
ON CONFLICT ("id") DO UPDATE SET
  "tenantId" = EXCLUDED."tenantId",
  "name" = EXCLUDED."name",
  "value" = EXCLUDED."value",
  "code" = EXCLUDED."code",
  "color" = EXCLUDED."color",
  "description" = EXCLUDED."description",
  "status" = EXCLUDED."status",
  "sort" = EXCLUDED."sort",
  "updater" = EXCLUDED."updater",
  "updateTime" = EXCLUDED."updateTime",
  "deleted" = EXCLUDED."deleted";

-- 修正序列，避免后续自增主键冲突
SELECT setval(
  pg_get_serial_sequence('"sys_dict_code"', 'id'),
  GREATEST((SELECT COALESCE(MAX("id"), 1) FROM "sys_dict_code"), 1),
  true
);

SELECT setval(
  pg_get_serial_sequence('"sys_dict_data"', 'id'),
  GREATEST((SELECT COALESCE(MAX("id"), 1) FROM "sys_dict_data"), 1),
  true
);
