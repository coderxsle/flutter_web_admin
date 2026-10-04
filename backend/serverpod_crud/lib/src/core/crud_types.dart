import 'package:serverpod/serverpod.dart';

/// CRUD 层常用函数签名（typedef）集合。
///
/// 作用：把 Serverpod DB API 抽象为可注入函数，
/// 便于通用 CRUD Service 复用与测试。


/// 插入一条新记录并返回插入后的对象
/// [T] 为数据实体类型
typedef InsertRow<T> = Future<T> Function(DatabaseSession session, T row);

/// 更新一条记录并返回更新后的对象
/// [T] 为数据实体类型
typedef UpdateRow<T> = Future<T> Function(DatabaseSession session, T row);

/// 查询符合条件的首条记录，找不到时返回 null
/// [T] 为数据实体类型，[TTable] 为表类型
/// [where] 指定过滤条件
typedef FindFirstRow<T, TTable extends Table> = Future<T?> Function(
  DatabaseSession session, {
    WhereExpressionBuilder<TTable>? where,
  });

/// 查询列表，按照条件过滤、分页、排序
/// [T] 为数据实体类型，[TTable] 为表类型
/// [where] 过滤条件，[limit] 限制条数，[offset] 偏移，[orderBy] 单字段排序
/// [orderDescending] 排序方向，[orderByList] 多字段排序
typedef FindRows<T, TTable extends Table> = Future<List<T>> Function(
  DatabaseSession session, {
    WhereExpressionBuilder<TTable>? where,
    int? limit,
    int? offset,
    OrderByBuilder<TTable>? orderBy,
    bool orderDescending,
    OrderByListBuilder<TTable>? orderByList,
  });

/// 删除所有符合 where 条件的数据，并返回被删除的对象列表
/// [T] 为数据实体类型，[TTable] 为表类型
typedef DeleteWhere<T, TTable extends Table> = Future<List<T>> Function(
  DatabaseSession session, {
    required WhereExpressionBuilder<TTable> where,
  });

/// 统计符合 where 条件的数据总数
/// [T] 为数据实体类型，[TTable] 为表类型
typedef CountRows<T, TTable extends Table> = Future<int> Function(
  DatabaseSession session, {
    WhereExpressionBuilder<TTable>? where,
  });

/// 通过字段名获取 [Table] 表中的对应列对象，用于动态访问字段
typedef ColumnResolver<TTable extends Table> = Column? Function(TTable table, String field);

/// 获取“关键词检索”用的字符串字段列集合（如 name、title 等），可用于全表搜索
typedef KeywordColumns<TTable extends Table> = List<ColumnString> Function(TTable table);

/// 通过 [Session] 解析/获取租户 ID（多租户场景必用）
typedef ResolveTenantId = int Function(Session session);

/// 获取“租户 ID”字段对象（如 table.tenantId），用于多租户隔离
typedef TenantColumn<TTable extends Table> = ColumnInt Function(TTable table);

/// 获取“已删除”标记字段列对象（如 table.deleted），用于软删除场景
typedef DeletedColumn<TTable extends Table> = ColumnBool? Function(TTable table);
