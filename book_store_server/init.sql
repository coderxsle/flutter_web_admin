-- 插入 sys_user 数据
INSERT INTO "sys_user"
    ("tenantId", "deptId", "username", "phone", "password", "nickname", "gender", "email", "avatar", "remark", "status", "postIds", "deleted", "loginIp", "loginTime", "updater", "updateTime", "creator", "createTime") 
VALUES
    (1, 0, 'coderxslee', '18511971935', 'asdfasdf', 'lxs', 0, 'coderxslee@qq.com', 'avatar1.jpg', '系统管理员', 0, '1,2', false, '127.0.0.1', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
    (1, 0, 'john_doe', '1234567890', 'password123', 'John', 0, 'john@example.com', 'avatar1.jpg', '管理员用户', 0, '1', false, '127.0.0.1', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
    (1, 0, 'jane_smith', '0987654321', 'password456', 'Jane', 1, 'jane@example.com', 'avatar2.jpg', '编辑用户', 0, '2', false, '127.0.0.1', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP),
    (1, 0, 'alice_wang', '1122334455', 'password789', 'Alice', 1, 'alice@example.com', 'avatar3.jpg', '查看用户', 1, '3', false, '127.0.0.1', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP);

-- 插入 sys_role 数据
INSERT INTO "sys_role" 
    ("tenantId", "name", "code", "sort", "dataScope", "dataScopeDeptIds", "status", "type", "remark", "creator", "createTime", "updater", "updateTime", "deleted") 
VALUES
    (0, '系统管理员', 'super_admin', 1, 1, NULL, 0, 1, '系统管理员角色', 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '内容编辑员', 'editor', 2, 2, NULL, 0, 1, '内容编辑员角色', 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '数据查看员', 'viewer', 3, 3, NULL, 0, 1, '数据查看员角色', 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false);

-- 插入 sys_user_role 数据
INSERT INTO "sys_user_role" 
    ("tenantId", "userId", "roleId", "creator", "createTime", "updater", "updateTime", "deleted") 
VALUES
    (0, 1, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, 2, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, 3, 2, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, 4, 3, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false);

-- 插入 sys_menu 数据
INSERT INTO "sys_menu" 
    ("tenantId", "name", "uri", "permission", "type", "icon", "sn", "parentId", "creator", "createTime", "updater", "updateTime", "deleted") 
VALUES
    (0, '系统管理', '/system', 'manage_system', 1, 'book', 1, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '用户管理', '/users', 'manage_users', 1, 'user', 2, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '角色管理', '/roles', 'manage_roles', 1, 'role', 3, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '菜单管理', '/menus', 'manage_menus', 1, 'menu', 4, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '部门管理', '/depts', 'manage_depts', 1, 'dept', 5, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '通知公告', '/notices', 'manage_notices', 1, 'notice', 6, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '文件管理', '/files', 'manage_files', 1, 'file', 7, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '字典管理', '/dicts', 'manage_dicts', 1, 'dict', 8, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '岗位管理', '/posts', 'manage_posts', 1, 'post', 10, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '系统配置', '/configs', 'manage_configs', 1, 'config', 12, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),

    (0, '系统监控', '/monitor', 'manage_monitor', 1, 'monitor', 13, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '在线用户', '/online', 'manage_online', 1, 'online', 14, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '系统日志', '/logs', 'manage_logs', 1, 'log', 15, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '短信管理', '/sms', 'manage_sms', 1, 'sms', 16, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '邮箱管理', '/mail', 'manage_mail', 1, 'mail', 17, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '站内信管理', '/notify', 'manage_notify', 1, 'notify', 18, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '模板管理', '/notify-template', 'manage_notify_template', 1, 'notify_template', 19, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '消息管理', '/message', 'manage_message', 1, 'message', 20, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '消息模板管理', '/message-template', 'manage_message_template', 1, 'message_template', 21, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, '消息记录管理', '/message-log', 'manage_message_log', 1, 'message_log', 22, 0, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    


-- 插入 sys_role_menu 数据
INSERT INTO "sys_role_menu" 
    ("tenantId", "roleId", "menuId", "creator", "createTime", "updater", "updateTime", "deleted") 
VALUES
    (0, 1, 1, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, 1, 2, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false),
    (0, 1, 3, 'system', CURRENT_TIMESTAMP, 'system', CURRENT_TIMESTAMP, false);








INSERT INTO "customer" 
    ("userName", "password", "nickname", "phone", "email", "status", "memberLevel", "createTime", "updateTime") 
VALUES
    ('lixuesong', 'asdfasdf', 'coderxslee', '18511971935', 'coderxslee@qq.com', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('john_doe', 'password123', 'John', '1234567890', 'john@example.com', 1, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('jane_smith', 'password456', 'Jane', '0987654321', 'jane@example.com', 1, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    ('alice_wang', 'password789', 'Alice', '1122334455', 'alice@example.com', 0, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);




-- 先插入 dict_type 数据
INSERT INTO "dict_type" 
    ("name", "value", "intro", "createTime", "updateTime", "isDeleted") 
VALUES
    ('Book Status', 'book_status', '书籍状态字典', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('Sale Type', 'sale_type', '销售类型字典', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false);

-- 再插入 dict_item 数据
INSERT INTO "dict_item" 
    ("name", "value", "sn", "disabled", "typeId", "createTime", "updateTime", "isDeleted") 
VALUES
    ('Available', '1', 1, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('Out of Stock', '2', 2, 0, 1, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('Online Sale', '1', 1, 0, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('Offline Sale', '2', 2, 0, 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false);




INSERT INTO "book_inventory_log" 
    ("bookId", "quantity", "changeType", "changeTime", "description", "createTime", "updateTime", "isDeleted") 
VALUES
    (55, 10, 1, '2024-07-10 10:00:00', 'Initial stock', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    (57, 5, 1, '2024-07-11 14:30:00', 'Restocked', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    (58, -2, 2, '2024-07-12 09:15:00', 'Sold 2 copies', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    (60, 8, 1, '2024-07-13 16:45:00', 'Initial stock', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false);


-- party 和 promotion 表在当前数据库架构中不存在，已移除相关插入语句

INSERT INTO "region" 
    ("name", "pinyin", "parentId") 
VALUES
    ('Beijing', 'beijing', 0),
    ('Shanghai', 'shanghai', 0),
    ('Guangdong', 'guangdong', 0),
    ('Shenzhen', 'shenzhen', 3),
    ('Guangzhou', 'guangzhou', 3);




-- 再插入 role_permission 数据
INSERT INTO "role_permission" 
    ("roleId", "permissionKey", "createTime", "updateTime") 
VALUES
    (1, 'manage_books', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (2, 'edit_books', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP),
    (3, 'view_books', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);


INSERT INTO "sys_operation_log" 
    ("tableNameStr", "operationType", "recordId", "oldData", "newData", "operatorId", "operationTime") 
VALUES
    ('book', 1, 55, '', '{"name": "爱与和解"}', 1, CURRENT_TIMESTAMP),
    ('book', 2, 57, '{"inventory": 98}', '{"inventory": 96}', 2, CURRENT_TIMESTAMP),
    ('book_package', 1, 1, '', '{"name": "经典文学套装"}', 3, CURRENT_TIMESTAMP);


INSERT INTO "sys_resource" 
    ("name", "uri", "permission", "type", "icon", "sn", "parentId") 
VALUES
    ('Book Management', '/books', 'manage_books', 1, 'book', 1, 0),
    ('User Management', '/users', 'manage_users', 1, 'user', 2, 0),
    ('Order Management', '/orders', 'manage_orders', 1, 'order', 3, 0);


INSERT INTO "sys_role_resource" 
    ("roleId", "resourceId") 
VALUES
    (1, 1),
    (1, 2),
    (1, 3),
    (2, 1),
    (3, 1);



INSERT INTO "book" 
    ("id", "isbn", "name", "image", "author", "publisher", "originalPrice", "createTime", "updateTime", "categoryId", "isDeleted") 
VALUES
    (55, '9787100093651', '爱与和解', 'http://static.tanshuapi.com/isbn/202314/16810167840447b1.jpg', '周鼎文, 著', '商务印书馆', 30.00, '2024-07-07 12:08:57', '2024-07-08 11:28:46', 1, false),
    (57, '9787205095369', '中国家书家训', 'http://static.tanshuapi.com/isbn/202225/1656171705905a25.jpg', '宸冰, 著', '辽宁人民出版社', 62.00, '2024-07-07 12:13:05', '2024-07-08 11:28:46', 1, false),
    (58, '9787549127146', '悟解', 'http://static.tanshuapi.com/isbn/202428/1720407883baf517.jpg', '林青贤', '广东南方日报出版社', 68.00, '2024-07-08 11:05:10', '2024-07-08 11:28:46', 1, false),
    (60, '9787549113675', '幸福，从接纳开始', 'http://static.tanshuapi.com/isbn/202231/1659603546ac7dd5.jpg', '林青贤, 主编', '南方日报出版社', 28.00, '2024-07-08 11:11:13', '2024-07-08 11:28:46', 1, false);


INSERT INTO "book_category" 
    ("name", "description", "createTime", "updateTime", "isDeleted") 
VALUES
    ('文学', '涵盖小说、散文、诗歌等文学作品', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('心理学', '心理成长、情绪管理、社交心理等相关书籍', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('儿童读物', '适合不同年龄段儿童的故事书、科普书籍', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('编程技术', '计算机编程、软件开发、人工智能相关书籍', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('历史文化', '历史事件、文化发展、人物传记相关书籍', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('科普', '自然科学、天文学、生物学等领域的科普书籍', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('商业管理', '商业战略、管理学、经济学相关书籍', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false);



INSERT INTO "book_sale" 
    ("bookId", "quantity", "salePrice", "saleTime", "isDeleted") 
VALUES
    (55, 10, 25.00, '2024-07-10 10:00:00', false),
    (57, 5, 50.00, '2024-07-11 14:30:00', false),
    (58, 8, 60.00, '2024-07-12 09:15:00', false),
    (60, 12, 20.00, '2024-07-13 16:45:00', false);



INSERT INTO "book_package" 
    ("name", "salePrice", "originalPrice", "discountRate", "contentDescription", "status", "startTime", "endTime", "createTime", "updateTime", "isDeleted") 
VALUES
    ('经典文学套装', 120.00, 150.00, 0.8, '包含《红楼梦》《西游记》《三国演义》《水浒传》', 1, '2025-03-01 00:00:00', '2025-03-31 23:59:59', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('心理成长必读', 90.00, 120.00, 0.75, '精选心理学书籍，包括《被讨厌的勇气》《终身成长》《幸福的方法》', 1, '2025-04-01 00:00:00', '2025-04-30 23:59:59', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('儿童科普启蒙', 80.00, 100.00, 0.8, '适合6-12岁孩子的科学启蒙书籍，包括《十万个为什么》《少儿百科全书》《恐龙探秘》', 1, '2025-05-01 00:00:00', '2025-05-31 23:59:59', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('编程入门精选', 200.00, 250.00, 0.8, '包含《Python编程》《深入理解计算机系统》《数据结构与算法》', 1, '2025-06-01 00:00:00', '2025-06-30 23:59:59', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    ('历史文化精选', 150.00, 180.00, 0.83, '精选历史文化书籍，包括《中国通史》《全球通史》《明朝那些事儿》', 1, '2025-07-01 00:00:00', '2025-07-31 23:59:59', CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false);
    

INSERT INTO "book_package_item" 
    ("bookId", "packageId", "quantity", "packagePrice", "originalPrice", "discountRate", "createTime", "updateTime", "isDeleted") 
VALUES
    (55, 1, 1, 30.00, 38.00, 0.79, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    (57, 1, 1, 32.00, 40.00, 0.80, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    (58, 2, 1, 45.00, 60.00, 0.75, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    (60, 2, 1, 28.00, 35.00, 0.80, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    (55, 3, 2, 58.00, 76.00, 0.76, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false),
    (58, 3, 1, 40.00, 50.00, 0.80, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, false);








