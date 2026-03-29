-- book 表初始化数据
-- 说明：
-- 1) tenantId = 0 表示系统租户
-- 2) 利用 book_unique(isbn, name) 唯一索引避免重复插入

INSERT INTO book (
  "tenantId",
  "name",
  "isbn",
  "author",
  "keyword",
  "publisher",
  "image",
  "originalPrice",
  "createTime",
  "updateTime",
  "isDeleted",
  "categoryId"
)
VALUES
  (0, 'Flutter 从入门到实战', '9787115545387', '张三', 'flutter,dart,移动开发', '人民邮电出版社', '', 79.00, NOW(), NOW(), FALSE, NULL),
  (0, 'Dart 语言精讲', '9787121398757', '李四', 'dart,编程语言', '电子工业出版社', '', 68.00, NOW(), NOW(), FALSE, NULL),
  (0, 'Serverpod 后端开发指南', '9787302611225', '王五', 'serverpod,dart,后端', '清华大学出版社', '', 88.00, NOW(), NOW(), FALSE, NULL),
  (0, 'PostgreSQL 实战手册', '9787111615527', '赵六', 'postgresql,数据库', '机械工业出版社', '', 99.00, NOW(), NOW(), FALSE, NULL),
  (0, '软件架构设计模式', '9787115531243', '钱七', '架构,设计模式', '人民邮电出版社', '', 89.00, NOW(), NOW(), FALSE, NULL)
ON CONFLICT ("isbn", "name") DO NOTHING;
