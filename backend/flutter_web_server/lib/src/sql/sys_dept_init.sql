-- sys_dept 初始化数据（物业集团总部组织结构）

INSERT INTO "sys_dept"
  ("id", "tenantId", "parentId", "name", "sort", "status", "description", "deleted", "creator", "createTime", "updater", "updateTime")
VALUES
  -- 一级部门（总部）
  (1, 0, NULL, '物业集团总部', 1, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),

  -- 二级部门（总部直属）
  (2, 0, 1, '总裁办 / 综合管理中心', 1, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (3, 0, 1, '人力资源中心', 2, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (4, 0, 1, '财务管理中心', 3, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (5, 0, 1, '品牌与市场中心', 4, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (6, 0, 1, '信息技术中心', 5, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (7, 0, 1, '物业运营中心', 6, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (8, 0, 1, '工程与设施管理中心', 7, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (9, 0, 1, '安全与秩序管理中心', 8, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (10, 0, 1, '客户服务中心', 9, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (11, 0, 1, '区域物业事业部', 10, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),

  -- 三级部门（人力资源中心）
  (31, 0, 3, '招聘与培训部', 1, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (32, 0, 3, '绩效与员工关系部', 2, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),

  -- 三级部门（财务管理中心）
  (41, 0, 4, '收费与结算部', 1, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (42, 0, 4, '预算与经营分析部', 2, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),

  -- 三级部门（品牌与市场中心）
  (51, 0, 5, '品牌宣传部', 1, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (52, 0, 5, '社区活动与业主运营部', 2, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),

  -- 三级部门（信息技术中心）
  (61, 0, 6, '系统研发部', 1, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (62, 0, 6, '数据与BI部', 2, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (63, 0, 6, '智慧物业平台部', 3, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),

  -- 三级部门（物业运营中心）
  (71, 0, 7, '住宅物业管理部', 1, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (72, 0, 7, '商业物业管理部', 2, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (73, 0, 7, '产业园区物业部', 3, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),

  -- 三级部门（工程与设施管理中心）
  (81, 0, 8, '工程运维部', 1, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (82, 0, 8, '设备管理部', 2, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (83, 0, 8, '能源管理部', 3, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),

  -- 三级部门（安全与秩序管理中心）
  (91, 0, 9, '安保管理部', 1, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (92, 0, 9, '消防管理部', 2, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),

  -- 三级部门（客户服务中心）
  (101, 0, 10, '客服管理部', 1, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (102, 0, 10, '投诉与品质管理部', 2, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),

  -- 三级部门（区域物业事业部）
  (111, 0, 11, '华东区域', 1, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (112, 0, 11, '华南区域', 2, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (113, 0, 11, '华北区域', 3, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),

  -- 四级部门
  (1111, 0, 111, '上海项目管理处', 1, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (1112, 0, 111, '杭州项目管理处', 2, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (1121, 0, 112, '广州项目管理处', 1, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (1131, 0, 113, '石家庄项目管理处', 1, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),

  -- 五级部门
  (11311, 0, 1131, '盛邦花园一区物业服务中心', 1, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (11312, 0, 1131, '盛邦花园二区物业服务中心', 2, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (11313, 0, 1131, '盛邦花园三区物业服务中心', 3, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (11314, 0, 1131, '盛邦花园五区物业服务中心', 4, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (11315, 0, 1131, '盛邦花园六区物业服务中心', 5, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (11316, 0, 1131, '盛邦花园八区物业服务中心', 6, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (11317, 0, 1131, '盛邦九号院物业服务中心', 7, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP),
  (11318, 0, 1131, '盛邦启元物业服务中心', 8, 1, NULL, false, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, CURRENT_TIMESTAMP)

ON CONFLICT ("id") DO UPDATE SET
  "tenantId" = EXCLUDED."tenantId",
  "parentId" = EXCLUDED."parentId",
  "name" = EXCLUDED."name",
  "sort" = EXCLUDED."sort",
  "status" = EXCLUDED."status",
  "description" = EXCLUDED."description",
  "deleted" = EXCLUDED."deleted",
  "updater" = EXCLUDED."updater",
  "updateTime" = EXCLUDED."updateTime";

-- 重置自增序列到当前最大 id
SELECT setval(pg_get_serial_sequence('"sys_dept"', 'id'), COALESCE(MAX("id"), 0))
FROM "sys_dept";