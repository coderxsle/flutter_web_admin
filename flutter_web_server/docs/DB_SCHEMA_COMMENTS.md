# 数据库表/字段注释（PostgreSQL COMMENT ON）

## 背景

Serverpod 会根据 `.spy.yaml` / 模型生成数据库表结构与迁移文件，但 **不会自动把模型里的注释同步成 PostgreSQL 的表/字段注释**。

本项目采用的约定是：把注释写在 `.spy.yaml` 里（`###` 或字段行尾 `#`），再通过脚本生成 `COMMENT ON ...` SQL，在每次迁移后自动应用。

## 注释来源与优先级

脚本：`tool/generate_schema_comments.dart`

- 字段注释（优先级从高到低）
  - 字段定义行尾的 `# 注释`
  - 字段上方紧邻的 `### 文档注释`（支持多行，自动用换行拼接）
- 表注释
  - `fields:` 之前出现的 `### 文档注释`（支持多行）

## 本地开发：推荐用菜单一键同步

在 `flutter_web_server` 目录执行：

```bash
./start.sh
```

然后选择：

- **7. 📝 仅同步数据库表/字段注释**

脚本会自动：

1. 启动开发环境的 Postgres 容器（如果还没启动）
2. 生成 SQL：`tool/generated/schema_comments.sql`
3. 通过 `docker exec ... psql` 写入数据库注释

## 生产/CI：手动或接入部署脚本

你可以在部署流程里加入：

```bash
cd flutter_web_server
dart run tool/generate_schema_comments.dart --out tool/generated/schema_comments.sql
cat tool/generated/schema_comments.sql | docker exec -i <postgres-container> psql -U <user> -d <db> -v ON_ERROR_STOP=1
```

`COMMENT ON` 语句是幂等的，重复执行会覆盖为最新注释。


