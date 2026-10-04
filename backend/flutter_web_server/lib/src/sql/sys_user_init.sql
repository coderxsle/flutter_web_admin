-- sys_user 初始化数据（真实业务风格，覆盖总部/职能中心/区域门店）
-- 说明：
-- 1. 创建用户时需要同时写入三张表：
--    serverpod_auth_core_user -> serverpod_auth_core_profile -> sys_user
-- 2. 使用固定 UUID，保证脚本可重复执行且幂等
-- 3. 采用 ON CONFLICT DO NOTHING，避免重复执行时报错
-- 4. 用户部门与 sys_dept_init.sql 中的部门 ID 对齐

-- 1) 初始化认证用户（serverpod_auth_core_user）
INSERT INTO "serverpod_auth_core_user"
  ("id", "createdAt", "scopeNames", "blocked")
VALUES
  ('019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, now(), '[]'::json, false), -- admin
  ('019d1000-0001-7000-8000-000000000001'::uuid, now(), '[]'::json, false), -- chen.yu
  ('019d1000-0002-7000-8000-000000000002'::uuid, now(), '[]'::json, false), -- zhao.min
  ('019d1000-0003-7000-8000-000000000003'::uuid, now(), '[]'::json, false), -- liu.jie
  ('019d1000-0004-7000-8000-000000000004'::uuid, now(), '[]'::json, false), -- wang.kai
  ('019d1000-0005-7000-8000-000000000005'::uuid, now(), '[]'::json, false), -- xu.qiang
  ('019d1000-0006-7000-8000-000000000006'::uuid, now(), '[]'::json, false), -- he.ting
  ('019d1000-0007-7000-8000-000000000007'::uuid, now(), '[]'::json, false), -- sun.yao
  ('019d1000-0008-7000-8000-000000000008'::uuid, now(), '[]'::json, false), -- guo.nan
  ('019d1000-0009-7000-8000-000000000009'::uuid, now(), '[]'::json, false), -- peng.wei
  ('019d1000-0010-7000-8000-000000000010'::uuid, now(), '[]'::json, false), -- zhou.lin
  ('019d1000-0011-7000-8000-000000000011'::uuid, now(), '[]'::json, false), -- tang.xin
  ('019d1000-0012-7000-8000-000000000012'::uuid, now(), '[]'::json, false), -- ma.chen
  ('019d1000-0013-7000-8000-000000000013'::uuid, now(), '[]'::json, false), -- qin.mo
  ('019d1000-0014-7000-8000-000000000014'::uuid, now(), '[]'::json, false), -- yang.fei
  ('019d1000-0015-7000-8000-000000000015'::uuid, now(), '[]'::json, false)  -- luo.yi
ON CONFLICT ("id") DO NOTHING;


-- 2) 初始化用户资料（serverpod_auth_core_profile）
INSERT INTO "serverpod_auth_core_profile"
  ("id", "authUserId", "userName", "fullName", "email", "createdAt", "imageId")
VALUES
  ('019ca2b5-2fcc-719a-8fb6-4e8baed3ada1'::uuid, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, 'admin', '系统管理员', 'admin@xinghebooks.com', now(), NULL),
  ('019d2000-0001-7000-8000-000000000001'::uuid, '019d1000-0001-7000-8000-000000000001'::uuid, 'chen.yu', '陈宇', 'chen.yu@xinghebooks.com', now(), NULL),
  ('019d2000-0002-7000-8000-000000000002'::uuid, '019d1000-0002-7000-8000-000000000002'::uuid, 'zhao.min', '赵敏', 'zhao.min@xinghebooks.com', now(), NULL),
  ('019d2000-0003-7000-8000-000000000003'::uuid, '019d1000-0003-7000-8000-000000000003'::uuid, 'liu.jie', '刘杰', 'liu.jie@xinghebooks.com', now(), NULL),
  ('019d2000-0004-7000-8000-000000000004'::uuid, '019d1000-0004-7000-8000-000000000004'::uuid, 'wang.kai', '王凯', 'wang.kai@xinghebooks.com', now(), NULL),
  ('019d2000-0005-7000-8000-000000000005'::uuid, '019d1000-0005-7000-8000-000000000005'::uuid, 'xu.qiang', '徐强', 'xu.qiang@xinghebooks.com', now(), NULL),
  ('019d2000-0006-7000-8000-000000000006'::uuid, '019d1000-0006-7000-8000-000000000006'::uuid, 'he.ting', '何婷', 'he.ting@xinghebooks.com', now(), NULL),
  ('019d2000-0007-7000-8000-000000000007'::uuid, '019d1000-0007-7000-8000-000000000007'::uuid, 'sun.yao', '孙尧', 'sun.yao@xinghebooks.com', now(), NULL),
  ('019d2000-0008-7000-8000-000000000008'::uuid, '019d1000-0008-7000-8000-000000000008'::uuid, 'guo.nan', '郭楠', 'guo.nan@xinghebooks.com', now(), NULL),
  ('019d2000-0009-7000-8000-000000000009'::uuid, '019d1000-0009-7000-8000-000000000009'::uuid, 'peng.wei', '彭伟', 'peng.wei@xinghebooks.com', now(), NULL),
  ('019d2000-0010-7000-8000-000000000010'::uuid, '019d1000-0010-7000-8000-000000000010'::uuid, 'zhou.lin', '周琳', 'zhou.lin@xinghebooks.com', now(), NULL),
  ('019d2000-0011-7000-8000-000000000011'::uuid, '019d1000-0011-7000-8000-000000000011'::uuid, 'tang.xin', '唐鑫', 'tang.xin@xinghebooks.com', now(), NULL),
  ('019d2000-0012-7000-8000-000000000012'::uuid, '019d1000-0012-7000-8000-000000000012'::uuid, 'ma.chen', '马晨', 'ma.chen@xinghebooks.com', now(), NULL),
  ('019d2000-0013-7000-8000-000000000013'::uuid, '019d1000-0013-7000-8000-000000000013'::uuid, 'qin.mo', '秦墨', 'qin.mo@xinghebooks.com', now(), NULL),
  ('019d2000-0014-7000-8000-000000000014'::uuid, '019d1000-0014-7000-8000-000000000014'::uuid, 'yang.fei', '杨菲', 'yang.fei@xinghebooks.com', now(), NULL),
  ('019d2000-0015-7000-8000-000000000015'::uuid, '019d1000-0015-7000-8000-000000000015'::uuid, 'luo.yi', '罗毅', 'luo.yi@xinghebooks.com', now(), NULL)
ON CONFLICT ("authUserId") DO NOTHING;


-- 3) 初始化业务用户（sys_user）
INSERT INTO "sys_user"
  ("tenantId", "authUserId", "deptId", "postIds", "username", "password", "nickname", "phone", "gender", "email", "avatar", "description", "status", "isSuperuser", "deleted", "loginIp", "loginTime", "updater", "updateTime", "creator", "createTime")
VALUES
  -- 总部 / 管理层
  (0, '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, 1,   '[1]',      'admin',    'pbkdf2_sha256$100000$lOaV2jHTxGKnYTh920XWyQ==$Zxvp027jrR3LcFHBSkeLDUemN1Ys0g0XHxNmQ0HKmSc=',    '系统管理员', '13800000001', 1, 'admin@xinghebooks.com', NULL, '系统内置管理员账号', 1, true,  false, '127.0.0.1',    '2026-02-28 09:20:00', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, '2026-02-28 09:20:00', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, '2026-01-01 08:00:00'),
  (0, '019d1000-0001-7000-8000-000000000001'::uuid, 2,   '[1,2]',    'chen.yu',  'pbkdf2_sha256$100000$lOaV2jHTxGKnYTh920XWyQ==$Zxvp027jrR3LcFHBSkeLDUemN1Ys0g0XHxNmQ0HKmSc=',     '陈宇',       '13917001201', 1, 'chen.yu@xinghebooks.com', NULL, '总裁办主任，负责战略协同', 1, false, false, '10.20.1.11',  '2026-03-01 08:36:12', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,  '2026-03-01 08:36:12', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, '2026-01-03 09:10:00'),
  (0, '019d1000-0002-7000-8000-000000000002'::uuid, 3,   '[2,3]',    'zhao.min', 'pbkdf2_sha256$100000$lOaV2jHTxGKnYTh920XWyQ==$Zxvp027jrR3LcFHBSkeLDUemN1Ys0g0XHxNmQ0HKmSc=',     '赵敏',       '13681802345', 2, 'zhao.min@xinghebooks.com', NULL, '人力资源BP负责人', 1, false, false, '10.20.1.12',  '2026-03-01 09:05:18', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,'2026-03-01 09:05:18', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,  '2026-01-05 10:00:00'),

  -- 财务 / 供应链
  (0, '019d1000-0003-7000-8000-000000000003'::uuid, 41,  '[4]',      'liu.jie',  'pbkdf2_sha256$100000$lOaV2jHTxGKnYTh920XWyQ==$Zxvp027jrR3LcFHBSkeLDUemN1Ys0g0XHxNmQ0HKmSc=',      '刘杰',       '13761234567', 1, 'liu.jie@xinghebooks.com', NULL, '核算经理，负责总账与结算', 1, false, false, '10.20.2.21',  '2026-03-01 09:22:30', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,'2026-03-01 09:22:30', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,  '2026-01-08 11:20:00'),
  (0, '019d1000-0004-7000-8000-000000000004'::uuid, 6,   '[5,6]',    'wang.kai', 'pbkdf2_sha256$100000$lOaV2jHTxGKnYTh920XWyQ==$Zxvp027jrR3LcFHBSkeLDUemN1Ys0g0XHxNmQ0HKmSc=',       '王凯',       '13817770086', 1, 'wang.kai@xinghebooks.com', NULL, '供应链计划经理', 1, false, false, '10.20.2.22',  '2026-03-01 10:12:41', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,'2026-03-01 10:12:41', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,  '2026-01-09 14:00:00'),

  -- IT 中心
  (0, '019d1000-0005-7000-8000-000000000005'::uuid, 71,  '[7,8]',    'xu.qiang', 'pbkdf2_sha256$100000$lOaV2jHTxGKnYTh920XWyQ==$Zxvp027jrR3LcFHBSkeLDUemN1Ys0g0XHxNmQ0HKmSc=',     '徐强',       '13918881234', 1, 'xu.qiang@xinghebooks.com', NULL, '后端技术负责人（Serverpod）', 1, false, false, '10.20.3.31',  '2026-03-01 10:45:05', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,  '2026-03-01 10:45:05', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,  '2026-01-11 09:30:00'),
  (0, '019d1000-0006-7000-8000-000000000006'::uuid, 72,  '[8,9]',    'he.ting',  'pbkdf2_sha256$100000$lOaV2jHTxGKnYTh920XWyQ==$Zxvp027jrR3LcFHBSkeLDUemN1Ys0g0XHxNmQ0HKmSc=',      '何婷',       '13524561238', 2, 'he.ting@xinghebooks.com', NULL, '数据分析负责人，维护 BI 看板', 1, false, false, '10.20.3.32',  '2026-03-01 11:01:44', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,'2026-03-01 11:01:44', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,  '2026-01-12 13:40:00'),
  (0, '019d1000-0007-7000-8000-000000000007'::uuid, 73,  '[9]',      'sun.yao',  'pbkdf2_sha256$100000$lOaV2jHTxGKnYTh920XWyQ==$Zxvp027jrR3LcFHBSkeLDUemN1Ys0g0XHxNmQ0HKmSc=',      '孙尧',       '13701775566', 1, 'sun.yao@xinghebooks.com', NULL, '基础设施工程师，负责容器与监控', 1, false, false, '10.20.3.33',  '2026-03-01 11:20:09', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,'2026-03-01 11:20:09', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,  '2026-01-13 10:10:00'),

  -- 线下零售（大区/城市群）
  (0, '019d1000-0008-7000-8000-000000000008'::uuid, 81,  '[10]',     'guo.nan',  '$2a$10$exampleHashForGuoNan123456789012',      '郭楠',       '13916110088', 2, 'guo.nan@xinghebooks.com', NULL, '华东大区运营负责人', 1, false, false, '10.20.4.41',  '2026-03-01 12:03:27', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,'2026-03-01 12:03:27', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,  '2026-01-14 09:50:00'),
  (0, '019d1000-0009-7000-8000-000000000009'::uuid, 811, '[10,11]',  'peng.wei', '$2a$10$exampleHashForPengWei12345678901',     '彭伟',       '13611889977', 1, 'peng.wei@xinghebooks.com', NULL, '上海城市群门店督导', 1, false, false, '10.20.4.42',  '2026-03-01 12:21:56', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, '2026-03-01 12:21:56', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,  '2026-01-15 14:30:00'),
  (0, '019d1000-0010-7000-8000-000000000010'::uuid, 812, '[11]',     'zhou.lin', '$2a$10$exampleHashForZhouLin12345678901',     '周琳',       '13764223344', 2, 'zhou.lin@xinghebooks.com', NULL, '杭州城市群门店经理', 1, false, false, '10.20.4.43',  '2026-03-01 12:48:10', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, '2026-03-01 12:48:10', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,  '2026-01-16 10:05:00'),

  -- 电商事业部
  (0, '019d1000-0011-7000-8000-000000000011'::uuid, 91,  '[12,13]',  'tang.xin', '$2a$10$exampleHashForTangXin12345678901',     '唐鑫',       '13816665521', 1, 'tang.xin@xinghebooks.com', NULL, '平台运营经理（天猫/京东）', 1, false, false, '10.20.5.51',  '2026-03-01 13:10:34', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, '2026-03-01 13:10:34', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,  '2026-01-17 09:20:00'),
  (0, '019d1000-0012-7000-8000-000000000012'::uuid, 92,  '[13]',     'ma.chen',  '$2a$10$exampleHashForMaChen123456789012',      '马晨',       '13917773390', 1, 'ma.chen@xinghebooks.com', NULL, '增长运营，负责活动转化', 1, false, false, '10.20.5.52',  '2026-03-01 13:36:49', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,'2026-03-01 13:36:49', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,  '2026-01-18 11:15:00'),
  (0, '019d1000-0013-7000-8000-000000000013'::uuid, 93,  '[14]',     'qin.mo',   '$2a$10$exampleHashForQinMo1234567890123',      '秦墨',       '13524771109', 2, 'qin.mo@xinghebooks.com', NULL, '在线客服组长', 1, false, false, '10.20.5.53',  '2026-03-01 13:58:06', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,'2026-03-01 13:58:06', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,  '2026-01-19 09:45:00'),

  -- 测试禁用账号（用于状态筛选联调）
  (0, '019d1000-0014-7000-8000-000000000014'::uuid, 31,  '[2]',      'yang.fei', '$2a$10$exampleHashForYangFei12345678901',     '杨菲',       '13601998876', 2, 'yang.fei@xinghebooks.com', NULL, '招聘专员（禁用测试账号）', 0, false, false, '10.20.1.18',  '2026-02-25 16:30:40', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,'2026-02-25 16:30:40', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,  '2026-01-20 08:40:00'),

  -- 预留离职软删除测试
  (0, '019d1000-0015-7000-8000-000000000015'::uuid, 42,  '[4]',      'luo.yi',   '$2a$10$exampleHashForLuoYi1234567890123',      '罗毅',       '13761002219', 1, 'luo.yi@xinghebooks.com', NULL, '经营分析师（软删除测试）', 1, false, true,  '10.20.2.29',  '2026-02-10 10:18:22', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid, '2026-02-10 10:18:22', '019ca2b5-2fcc-719a-8fb6-4e8baed3ad9b'::uuid,  '2026-01-21 10:30:00')
ON CONFLICT ("username") DO NOTHING;