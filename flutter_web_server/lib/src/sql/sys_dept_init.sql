-- sys_dept 初始化数据（真实风格的部门树）
-- 说明：
-- 1. 采用显式 id，便于与 sys_user.deptId / 其他初始化脚本联动
-- 2. 支持重复执行：ON CONFLICT ("id") DO UPDATE
-- 3. 组织结构覆盖总部 + 多业务条线 + 区域分部，层级 3~4 级

INSERT INTO "sys_dept"
  ("id", "tenantId", "parentId", "leaderId", "name", "phone", "email", "sort", "status", "creator", "createTime", "updater", "updateTime", "deleted")
VALUES
  -- 一级部门（总部）
  (1, 0, NULL, 1, '集团总部', '021-80100001', 'hq@xinghebooks.com', 1, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  -- 二级部门（总部直属）
  (2, 0, 1, 1, '总裁办', '021-80100011', 'ceo.office@xinghebooks.com', 1, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (3, 0, 1, 1, '人力资源中心', '021-80100012', 'hr@xinghebooks.com', 2, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (4, 0, 1, 1, '财务管理中心', '021-80100013', 'finance@xinghebooks.com', 3, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (5, 0, 1, 2, '品牌与市场中心', '021-80100014', 'marketing@xinghebooks.com', 4, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (6, 0, 1, 2, '图书供应链中心', '021-80100015', 'supplychain@xinghebooks.com', 5, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (7, 0, 1, 3, '信息技术中心', '021-80100016', 'it@xinghebooks.com', 6, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (8, 0, 1, 2, '线下零售事业部', '021-80100017', 'retail@xinghebooks.com', 7, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (9, 0, 1, 3, '电商事业部', '021-80100018', 'ecommerce@xinghebooks.com', 8, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  -- 三级部门（人力）
  (31, 0, 3, 1, '招聘与雇主品牌部', '021-80100121', 'hr.recruit@xinghebooks.com', 1, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (32, 0, 3, 1, '组织发展与培训部', '021-80100122', 'hr.od@xinghebooks.com', 2, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  -- 三级部门（财务）
  (41, 0, 4, 1, '核算与结算部', '021-80100131', 'finance.apar@xinghebooks.com', 1, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (42, 0, 4, 1, '预算与经营分析部', '021-80100132', 'finance.fpna@xinghebooks.com', 2, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  -- 三级部门（IT）
  (71, 0, 7, 3, '研发平台部', '021-80100161', 'it.rnd@xinghebooks.com', 1, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (72, 0, 7, 3, '数据与BI部', '021-80100162', 'it.bi@xinghebooks.com', 2, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (73, 0, 7, 3, '基础设施与安全部', '021-80100163', 'it.ops@xinghebooks.com', 3, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  -- 三级部门（线下零售）
  (81, 0, 8, 2, '华东大区', '025-61200001', 'retail.east@xinghebooks.com', 1, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (82, 0, 8, 2, '华南大区', '020-62300001', 'retail.south@xinghebooks.com', 2, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (83, 0, 8, 2, '华北大区', '010-63500001', 'retail.north@xinghebooks.com', 3, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  -- 四级部门（区域门店管理）
  (811, 0, 81, 2, '上海城市群门店管理部', '021-61200011', 'retail.sh@xinghebooks.com', 1, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (812, 0, 81, 2, '杭州城市群门店管理部', '0571-61200012', 'retail.hz@xinghebooks.com', 2, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (821, 0, 82, 2, '广州城市群门店管理部', '020-62300011', 'retail.gz@xinghebooks.com', 1, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (831, 0, 83, 2, '北京城市群门店管理部', '010-63500011', 'retail.bj@xinghebooks.com', 1, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

  -- 三级部门（电商）
  (91, 0, 9, 3, '平台运营部', '021-80100181', 'ecom.ops@xinghebooks.com', 1, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (92, 0, 9, 3, '用户增长部', '021-80100182', 'ecom.growth@xinghebooks.com', 2, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
  (93, 0, 9, 3, '客户服务部', '021-80100183', 'ecom.cs@xinghebooks.com', 3, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false)
ON CONFLICT ("id") DO UPDATE SET
  "tenantId" = EXCLUDED."tenantId",
  "parentId" = EXCLUDED."parentId",
  "leaderId" = EXCLUDED."leaderId",
  "name" = EXCLUDED."name",
  "phone" = EXCLUDED."phone",
  "email" = EXCLUDED."email",
  "sort" = EXCLUDED."sort",
  "status" = EXCLUDED."status",
  "updater" = EXCLUDED."updater",
  "updateTime" = EXCLUDED."updateTime",
  "deleted" = EXCLUDED."deleted";

-- 修正序列，避免后续自增主键冲突
SELECT setval(
  pg_get_serial_sequence('"sys_dept"', 'id'),
  GREATEST((SELECT COALESCE(MAX("id"), 1) FROM "sys_dept"), 1),
  true
);