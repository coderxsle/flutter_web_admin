-- liquibase formatted sql

-- comment 初始化表数据

-- 初始化赞助商数据
INSERT INTO "sys_sponsor"
("id", "name", "img", "url", "type", "description", "sort", "status", "create_user", "create_time")
VALUES
    (1, '石家庄智合未来家文化有限公司', '/img/sponsor/ad/jssy-20250218.jpg', 'https://www.baidu.com.com/', 'PLATINUM', 'ContiNew 赞助商', 1, 1, 1, NOW()),
    (2, '精医链', '/img/sponsor/cn/cn-20250317.png', 'http://www.jingyilian.cn', 'PLATINUM', 'ContiNew 赞助商', 1, 1, 1, NOW());