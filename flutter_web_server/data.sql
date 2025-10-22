-- 插入 sys_user 数据
INSERT INTO "sys_user"
    ("id", "tenantId", "deptId", "username", "phone", "password", "nickname", "gender", "email", "avatar", "remark", "status", "deleted", "loginIp", "loginTime", "updater", "updateTime", "creator", "createTime") 
VALUES
    (0, 0, 1, 'coderxslee', '18511971935', 'asdfasdf', 'lxs', 0, 'coderxslee@qq.com', 'avatar1.jpg', '系统管理员', 0, false, '127.0.0.1', now(), 'system', now(), 'system', now()),
    (1, 0, 1, 'john_doe', '1234567890', 'password123', 'John', 0, 'john@example.com', 'avatar1.jpg', '管理员用户', 0, false, '127.0.0.1', now(), 'system', now(), 'system', now()),
    (2, 0, 1, 'jane_smith', '0987654321', 'password456', 'Jane', 1, 'jane@example.com', 'avatar2.jpg', '编辑用户', 0, false, '127.0.0.1', now(), 'system', now(), 'system', now()),
    (3, 0, 1, 'alice_wang', '1122334455', 'password789', 'Alice', 1, 'alice@example.com', 'avatar3.jpg', '查看用户', 1, false, '127.0.0.1', now(), 'system', now(), 'system', now());
DROP SEQUENCE IF EXISTS sys_user_seq;
CREATE SEQUENCE sys_user_seq
    START 4;



-- 插入 sys_role 数据
INSERT INTO "sys_role"
    ("id", "tenantId", "name", "code", "sort", "dataScope", "dataScopeDeptIds", "status", "type", "remark", "creator", "createTime", "updater", "updateTime", "deleted") 
VALUES
    (0, 0, '系统管理员', 'super_admin', 1, 1, NULL, 0, 1, '系统管理员角色', 'system', now(), 'system', now(), false),
    (1, 0, '内容编辑员', 'editor', 2, 2, NULL, 0, 1, '内容编辑员角色', 'system', now(), 'system', now(), false),
    (2, 0, '数据查看员', 'viewer', 3, 3, NULL, 0, 1, '数据查看员角色', 'system', now(), 'system', now(), false);
DROP SEQUENCE IF EXISTS sys_role_seq;
CREATE SEQUENCE sys_role_seq
    START 3;



-- 插入 sys_user_role 数据
INSERT INTO "sys_user_role"
    ("id", "tenantId", "userId", "roleId", "creator", "createTime", "updater", "updateTime", "deleted") 
VALUES
    (0, 0, 0, 1, 'system', now(), 'system', now(), false),
    (1, 0, 1, 1, 'system', now(), 'system', now(), false),
    (2, 0, 2, 2, 'system', now(), 'system', now(), false),
    (3, 0, 3, 3, 'system', now(), 'system', now(), false);
DROP SEQUENCE IF EXISTS sys_user_role_seq;
CREATE SEQUENCE sys_user_role_seq
    START 4;