# Flutter Web Server 小改造草图（借鉴 MyBatis-Plus 风格）

> 目标：在不大改现有业务接口的前提下，继续减少 `Service` 重复代码，统一动态查询、租户与逻辑删除处理。

## 1. 改造目标

当前我们已经有：

- `BaseService<T, TTable>`：通用 CRUD + 分页查询入口
- `ServerpodCrudAdapter<T, TTable>`：封装 `db/table` 与基础操作
- `columnMap` / `keywordColumns`：动态字段映射与关键词搜索

下一步想解决的问题：

1. `columnMap` 在各个 service 中重复定义，格式不完全统一。
2. `ProductService` 仍然承担了一些“配置拼装”工作，类可继续瘦身。
3. 多租户、逻辑删除、排序字段校验等“全局规则”希望更集中。

---

## 2. 设计原则

1. **保留现有 API**：`create/update/delete/get/list/query` 对外尽量不变。
2. **配置前置**：把实体差异抽成 `Descriptor`（描述符），service 只组合。
3. **白名单优先**：所有可排序/过滤字段必须显式声明。

---

## 3. 核心抽象（建议）

## 3.1 EntityDescriptor（实体描述符）

把“实体相关、但与业务流程无关”的信息集中管理。

```dart
class EntityDescriptor<T extends TableRow, TTable extends Table> {
  final ServerpodCrudAdapter<T, TTable> adapter;
  final Map<String, Column Function(TTable)> fields; // 原 columnMap
  final List<ColumnString Function(TTable)> keywordFields;
  final Map<String, String> fieldAliases; // 可选：前端别名 -> 规范字段

  const EntityDescriptor({
    required this.adapter,
    required this.fields,
    this.keywordFields = const [],
    this.fieldAliases = const {},
  });
}
```

作用：

- 统一字段白名单定义；
- 把 `columnMap`、`keywordColumns`、别名映射放在一起；
- 避免每个 service 构造函数里重复写大段配置。

---

## 3.2 BaseEntityService（实体基类）

在 `BaseService` 之上增加一个“描述符驱动”的薄层。

```dart
abstract class BaseEntityService<T extends TableRow, TTable extends Table>
    extends BaseService<T, TTable> {
  BaseEntityService(EntityDescriptor<T, TTable> descriptor)
      : super.fromAdapter(
          adapter: descriptor.adapter,
          columnMap: descriptor.fields,
          keywordColumns: descriptor.keywordFields.isEmpty
              ? null
              : (t) => descriptor.keywordFields.map((f) => f(t)).toList(),
        );
}
```

作用：

- 让业务 service 只需要提供一个 `descriptor`；
- 进一步减少构造函数样板代码。

---

## 3.3 QueryCriteria（可选）

在 `QueryDTO` 外围增加一层语义对象（不一定替换，先适配）。

```dart
class QueryCriteria {
  final List<FilterItem> filters;
  final List<SortItem> sorts;
  final String? keyword;
  final int page;
  final int size;
}
```

作用：

- 减少到处操作裸 Map/裸字符串；
- 后续便于增加数据权限规则；
- 便于写单元测试（构建 criteria 更清晰）。

---

## 4. ProductService 迁移后的理想形态

```dart
class ProductService extends BaseEntityService<Book, BookTable> {
  ProductService() : super(ProductDescriptor.instance);
}
```

其中 `ProductDescriptor` 示例：

```dart
class ProductDescriptor {
  static final instance = EntityDescriptor<Book, BookTable>(
    adapter: ServerpodCrudAdapter<Book, BookTable>.fromDb(
      db: Book.db,
      table: Book.t,
      idColumn: (t) => t.id as ColumnInt,
      tenantIdColumn: (t) => t.tenantId,
      deletedColumn: (t) => t.isDeleted,
      getId: (m) => m.id,
      setTenantId: (m, tenantId) => m.tenantId = tenantId,
      setDeleted: (m, deleted) => m.isDeleted = deleted,
    ),
    fields: {
      'id': (t) => t.id,
      'tenantId': (t) => t.tenantId,
      'name': (t) => t.name,
      'isbn': (t) => t.isbn,
      'author': (t) => t.author,
      'keyword': (t) => t.keyword,
      'publisher': (t) => t.publisher,
      'originalPrice': (t) => t.originalPrice,
      'categoryId': (t) => t.categoryId,
      'createTime': (t) => t.createTime,
      'updateTime': (t) => t.updateTime,
    },
    keywordFields: [(t) => t.name, (t) => t.author, (t) => t.publisher, (t) => t.keyword],
    fieldAliases: {
      'createdAt': 'createTime',
      'updatedAt': 'updateTime',
    },
  );
}
```

---

## 5. 分阶段落地计划

## 阶段 A（低风险，建议先做）

- [x] 增加 `EntityDescriptor`。
- [x] 增加 `BaseEntityService`。
- [x] `ProductService` 切到 descriptor 模式。
- [x] 行为保持与当前一致。

## 阶段 B（增强查询一致性）

- [x] `QueryEngine` 支持 `fieldAliases`。
- [x] 统一非法字段报错文案（排序、过滤、关键词）。
- [x] 补充字段白名单相关单元测试。

## 阶段 C（可选，偏中长期）

- [x] 增加 `QueryCriteria` 适配层。
- [x] 汇总租户/逻辑删除/数据权限拦截点。
- [x] 抽象“通用审计字段”（create/update 时间）自动填充策略。

---

## 6. 与 MyBatis-Plus 概念对照

| 本项目拟抽象 | MyBatis-Plus 对应概念 | 说明 |
|---|---|---|
| `ServerpodCrudAdapter` | `BaseMapper<T>` | 封装实体基础数据库操作 |
| `BaseService` / `BaseEntityService` | `IService<T>` + `ServiceImpl<M,T>` | 通用业务层 CRUD |
| `columnMap` / `fields` | `Wrapper` 中可访问字段 + Lambda 引用 | 控制动态查询字段 |
| `deletedColumn` | `@TableLogic` | 逻辑删除 |
| `tenantIdColumn + resolveTenantId` | 多租户插件 | 租户隔离 |

---

## 7. 风险与注意事项

1. `fromDb` 目前使用 `dynamic db`，需保证传入的 `db` 具备标准方法签名。
2. `fieldAliases` 引入后，要明确冲突规则（别名与原字段同名时优先级）。
3. 排序字段建议限制到可索引列，避免大表慢查询。
4. 如存在历史接口，建议先灰度一个模块（如 Product）再全量迁移。

---

## 8. 建议的下一步

如果你同意，我可以下一步直接实现 **阶段 A**：

1. 新增 `EntityDescriptor` 与 `BaseEntityService`；
2. 把 `ProductService` 改成 `ProductDescriptor + ProductService` 两段式；
3. 保持现有接口与行为不变，改动尽量小。
