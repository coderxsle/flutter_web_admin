# Serverpod 4.0 数据库升级

为从 Serverpod 3.4.4 升级到 4.0.0 的项目补充数据库迁移：新增云存储下载、定时任务领取表，扩展云存储和任务字段，更新日志索引，并将认证限流表的 `nonce` 列改名为 `key`。

## 应用

先备份数据库，再从 `flutter_web_server` 目录运行：

```bash
dart run bin/main.dart --apply-migrations
```

已有数据库由 Serverpod 执行 `migration.sql`；空数据库使用 `definition.sql` 初始化。

## 保留限流记录

Serverpod 生成器将 `nonce` → `key` 识别为删除后新增，默认会重建整张限流表。本迁移的 `migration.sql` 已改为 `RENAME COLUMN`，保留记录、主键和索引；PostgreSQL 会自动更新索引引用。

`migration.json` 保留生成器计算的结构差异，不能替代定制后的 SQL 执行。以后重新生成本迁移时，应保留 SQL 中的重命名操作。`definition.json` 和 `definition.sql` 描述的最终结构不受影响。

## 验证

已在开发数据库备份恢复出的独立测试库验证：迁移前插入限流记录，迁移后原主键、`nonce` 对应的 `key` 值及 `extraData` 均保留，复合索引引用正确。Serverpod 4.0 启动时的数据库结构校验通过。

开发库应用迁移后，普通启动成功；`GET /readyz`、`POST /system/health`、`POST /system/version` 和 Web 根页面均返回 HTTP 200，`dart analyze` 无问题。

## 回退

Serverpod 使用向前迁移，没有自动降级脚本。应用前使用 `pg_dump -Fc` 保留完整备份；需要退回 3.4.4 时，将备份恢复到独立数据库，并同时切回匹配的旧版代码。不要仅修改迁移版本记录。
