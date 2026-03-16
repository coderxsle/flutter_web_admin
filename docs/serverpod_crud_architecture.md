# Serverpod 企业级自动 CRUD 架构设计（SaaS 多租户优化版）

## 1. 设计目标

本架构旨在为 Serverpod 项目提供一套成熟、严谨、可扩展的自动 CRUD
开发体系，使开发者只需定义数据模型和业务逻辑，即可获得完整的 CRUD
API、分页查询能力、权限控制、审计日志和后台管理能力。

在 SaaS 多租户场景下的核心目标：

-   减少重复 CRUD 代码
-   保持 Serverpod 强类型优势
-   支持企业级系统开发
-   内置多租户隔离与权限边界
-   可扩展为低代码平台基础

------------------------------------------------------------------------

# 2. 整体架构

    Flutter Admin / App
            │
            │ typed client
            ▼
    Serverpod Endpoint Layer
            │
            │ Generic CRUD + Tenant Guard
            ▼
    Service Layer（业务逻辑）
            │
            ▼
    Repository / ORM
            │
            ▼
    PostgreSQL

架构分为四层：

  层           职责
  ------------ -------------------
  Endpoint     提供 API 接口、会话鉴权、租户上下文注入
  Service      业务逻辑、权限校验、租户边界控制
  Repository   ORM 数据访问、统一过滤器与审计钩子
  Database     PostgreSQL 数据库

优势：

-   解耦 API 与业务逻辑
-   CRUD 可复用
-   方便测试
-   易于扩展
-   多租户隔离有统一规范

------------------------------------------------------------------------

# 3. 多租户核心设计

## 3.1 租户模型与会话上下文

建议标准化租户模型：

    tenant
    tenant_user
    tenant_role
    tenant_permission

会话上下文必须包含：

    tenantId
    userId
    roles
    permissions

建议在 Serverpod Session 中通过扩展统一读取租户上下文：

``` dart
extension SessionTenant on Session {
  int get tenantId => authenticatedUser!.scope['tenantId'] as int;
}
```

## 3.2 租户隔离策略（推荐行级隔离）

所有业务表必须包含：

    tenantId

所有查询必须自动拼接：

    WHERE tenantId = :tenantId

所有写操作必须强制注入 tenantId，禁止客户端提交 tenantId。

------------------------------------------------------------------------

# 4. Generic CRUD Endpoint 设计

设计一个通用 CRUD Endpoint 基类：

``` dart
abstract class CrudEndpoint<T> extends Endpoint {
  Future<T> create(Session session, T data);
  Future<T> update(Session session, T data);
  Future<void> delete(Session session, int id);
  Future<T?> get(Session session, int id);
  Future<List<T>> list(Session session);
}
```

实体 Endpoint 只需继承：

``` dart
class UserEndpoint extends CrudEndpoint<User> {}
```

多租户要求：

-   Endpoint 层统一校验 session 是否存在 tenantId
-   Endpoint 层禁止客户端传入 tenantId

------------------------------------------------------------------------

# 5. DTO 设计

为了解决查询模型与响应模型问题，设计标准 DTO：

    CreateDTO
    UpdateDTO
    QueryDTO
    ResponseDTO

示例：

    UserCreate
    UserUpdate
    UserQuery
    UserResponse

分页查询 DTO（推荐结构化条件，而非动态 Map）：

``` dart
class QueryDTO {
  int page = 1;
  int pageSize = 20;
  List<QueryCondition>? filters;
  List<QuerySort>? sort;
  String? keyword;
}

class QueryCondition {
  String field;
  String operator; // eq, like, between, in
  dynamic value;
}

class QuerySort {
  String field;
  String order; // asc, desc
}
```

统一分页返回结构：

``` dart
class PageResponse<T> {
  int total;
  List<T> data;
}
```

------------------------------------------------------------------------

# 6. 通用分页查询引擎

设计通用查询方法：

``` dart
Future<PageResponse<T>> pageQuery<T>({
  required Session session,
  required QueryDTO query,
})
```

支持：

-   分页
-   排序
-   条件过滤
-   关键字搜索
-   租户隔离（强制）

示例过滤：

    name like
    status =
    createTime between

注意：查询引擎必须默认附加 `tenantId` 条件，不允许绕过。

------------------------------------------------------------------------

# 7. 自动 CRUD 代码生成

在 Serverpod YAML 中增加扩展配置：

``` yaml
class: User
table: user
crud: true
multiTenant: true

fields:
  name: String
  age: int
```

Generator 自动生成：

    user_endpoint.dart
    user_service.dart
    user_repository.dart
    user_dto.dart

多租户规则自动生成：

-   insert 自动注入 tenantId
-   update/delete/get/list 自动过滤 tenantId
-   默认禁止客户端提交 tenantId

------------------------------------------------------------------------

# 8. Service 层设计

Endpoint 不直接操作 ORM，而通过 Service。

示例：

``` dart
class UserService {
  Future<User> create(Session session, UserCreate dto) async {
    var user = User(
      name: dto.name,
      age: dto.age,
      tenantId: session.tenantId,
    );

    return await User.db.insertRow(session, user);
  }
}
```

Endpoint：

``` dart
class UserEndpoint extends Endpoint {
  final service = UserService();

  Future<User> create(Session session, UserCreate dto) {
    return service.create(session, dto);
  }
}
```

优势：

-   业务逻辑集中
-   可复用
-   方便单元测试
-   租户注入统一

------------------------------------------------------------------------

# 9. 权限系统设计（多租户）

每个 CRUD 操作必须支持权限校验，权限应以租户为作用域。

示例：

    user.create
    user.update
    user.delete
    user.read

代码示例：

``` dart
Future<User> create(Session session, UserCreate dto) async {
  await AuthService.check(session, "user.create");
  return service.create(session, dto);
}
```

多租户补充：

-   权限判断必须基于 tenantId 的角色/用户关系
-   支持行级权限（例如数据归属 ownerId）

------------------------------------------------------------------------

# 10. 软删除机制

企业系统推荐使用软删除。

字段设计：

    deleted
    deletedAt
    deletedBy

删除操作：

    UPDATE user SET deleted=true

默认查询条件：

    WHERE deleted=false AND tenantId=:tenantId

------------------------------------------------------------------------

# 11. 审计日志系统（多租户）

所有 CRUD 自动记录日志。

日志表设计：

    audit_log

字段：

    tenant_id
    table_name
    record_id
    operation
    old_data
    new_data
    user_id
    time

记录内容：

-   操作人
-   操作时间
-   操作类型
-   修改字段
-   原始数据
-   新数据
-   租户信息

建议在 Repository 或 Service 层统一处理审计逻辑。

------------------------------------------------------------------------

# 12. Flutter Admin 自动生成

Flutter Admin 可以通过元数据自动生成管理界面。

页面自动生成：

    列表页
    创建页
    编辑页
    详情页

依赖元数据：

    字段
    类型
    枚举
    是否必填
    是否可搜索

多租户补充：

-   管理端必须具备租户切换或租户限定能力
-   UI 默认使用租户上下文过滤

------------------------------------------------------------------------

# 13. 元数据系统

为了支持低代码，需要元数据表。

    entity_metadata
    field_metadata

示例：

    entity: user
    label: 用户

字段配置：

    name
    label
    type
    required
    searchable
    sortable

建议为元数据表加入 tenantId，以支持租户级定制。

------------------------------------------------------------------------

# 14. 推荐目录结构

    server/
     ├─ endpoints
     │   ├─ user_endpoint.dart
     │
     ├─ services
     │   ├─ user_service.dart
     │
     ├─ crud
     │   ├─ crud_endpoint.dart
     │   ├─ crud_service.dart
     │   ├─ query_engine.dart
     │
     ├─ dto
     │   ├─ query_dto.dart
     │   ├─ page_response.dart
     │
     ├─ auth
     │   ├─ permission.dart
     │
     ├─ audit
     │   ├─ audit_service.dart
     │
     ├─ tenant
     │   ├─ tenant_guard.dart
     │   ├─ tenant_context.dart

说明：

-   `endpoints/` 目录下必须放“对外暴露的具体 Endpoint 类”（例如 `UserEndpoint`），以保证 `serverpod generate` 能正常扫描与生成客户端调用。
-   `crud/` 目录下仅放通用基类与工具（例如 `CrudEndpoint`、`QueryEngine`），这些不需要被生成器直接扫描。

------------------------------------------------------------------------

# 15. 最终开发流程

开发一个新实体只需：

    1 定义 YAML Model
    2 编写 Service 业务逻辑

系统自动提供：

    CRUD Endpoint
    分页查询
    权限控制
    审计日志
    后台管理接口
    租户隔离能力

------------------------------------------------------------------------

# 16. 架构成熟度

  能力         成熟度
  ------------ -------------
  CRUD         ⭐⭐⭐⭐⭐
  权限系统     ⭐⭐⭐⭐⭐
  分页查询     ⭐⭐⭐⭐⭐
  审计日志     ⭐⭐⭐⭐
  Admin UI     ⭐⭐⭐⭐
  低代码能力   ⭐⭐⭐⭐
  多租户能力   ⭐⭐⭐⭐⭐

该架构可接近成熟低代码平台能力，并适合企业级 SaaS 系统开发。

------------------------------------------------------------------------

# 17. 插件化建议

后期等功能全部完善，测试通过后，兵器额成熟的运行到一定的程度后，建议将该架构封装为 Serverpod 插件：

    serverpod_crud

插件提供：

-   自动 CRUD Endpoint
-   分页查询引擎
-   权限系统
-   审计日志
-   Admin 元数据
-   多租户隔离能力

这将成为 Serverpod 生态的重要基础组件。
