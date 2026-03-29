import 'package:serverpod/serverpod.dart';
import 'package:serverpod_crud/serverpod_crud.dart';

enum _CompareOperator { gt, gte, lt, lte }

/// 查询参数校验异常。
class QueryValidationException implements Exception {
  QueryValidationException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// 查询引擎：统一处理分页、过滤、排序、关键词、租户隔离、软删除与插件扩展。
class QueryEngine {
  static String resolveFieldName(
    String rawField,
    Map<String, String> fieldAliases, {
    CrudRuntime? runtime,
  }) {
    return (runtime ?? CrudRuntime()).plugins.fieldAlias.resolveField(rawField, fieldAliases);
  }

  static bool isAllowedField(
    String rawField,
    Map<String, String> fieldAliases,
    bool Function(String field) isKnownField, {
    CrudRuntime? runtime,
  }) {
    return isKnownField(resolveFieldName(rawField, fieldAliases, runtime: runtime));
  }

  static Future<CrudPage<T>> pageQuery<T extends TableRow, TTable extends Table>({
    required Session session,
    required QueryDTO query,
    required TTable table,
    required TenantColumn<TTable> tenantIdColumn,
    required ResolveTenantId resolveTenantId,
    required ColumnResolver<TTable> resolveColumn,
    Map<String, String> fieldAliases = const {},
    required FindRows<T, TTable> find,
    required CountRows<T, TTable> count,
    DeletedColumn<TTable>? deletedColumn,
    KeywordColumns<TTable>? keywordColumns,
    CrudRuntime? runtime,
  }) async {
    final rt = runtime ?? CrudRuntime();
    rt.validate(query);
    final tenantId = resolveTenantId(session);
    final safePage = query.page < 1 ? 1 : query.page;
    final safePageSize = query.pageSize < 1 ? 20 : (query.pageSize > 200 ? 200 : query.pageSize);

    Expression buildWhere(TTable t) {
      var filter = tenantIdColumn(t).equals(tenantId);
      if (deletedColumn != null) {
        final deleted = deletedColumn(t);
        if (deleted != null) filter = filter & deleted.equals(false);
      }

      final conditions = query.filters ?? <QueryCondition>[];
      for (final condition in conditions) {
        final normalizedField = resolveFieldName(condition.field, fieldAliases, runtime: rt);
        final normalizedCondition = condition.copyWith(field: normalizedField);
        final expr = _buildCondition(t, normalizedCondition, resolveColumn, runtime: rt);
        if (expr == null) {
          throw QueryValidationException(
            '非法过滤字段或操作: field=${condition.field}, operator=${condition.comparator}',
          );
        }
        filter = filter & expr;
      }

      final keyword = query.keyword?.trim();
      if (keyword != null && keyword.isNotEmpty) {
        if (keywordColumns == null) throw QueryValidationException('当前实体不支持关键词查询。');
        final columns = keywordColumns(t);
        if (columns.isEmpty) throw QueryValidationException('当前实体未配置关键词字段，无法进行关键词查询。');
        Expression keywordExpr = columns.first.like('%$keyword%');
        for (final column in columns.skip(1)) {
          keywordExpr = keywordExpr | column.like('%$keyword%');
        }
        filter = filter & keywordExpr;
      }

      for (final plugin in rt.plugins.dataPermissions) {
        final expression = (plugin as dynamic).buildFilter(session, t) as Expression?;
        if (expression != null) filter = filter & expression;
      }

      return filter;
    }

    final total = await count(session, where: (t) => buildWhere(t));
    if (total == 0) {
      return CrudPage.from(data: <T>[], pageNum: safePage, pageSize: safePageSize, total: 0);
    }

    // 排序规则说明：
    // 1. 前端可通过 query.sort 传递一组排序字段，每个包含 field（字段名）和 order（asc/desc）。
    // 2. 后端依次取出排序数组，从上到下构建多字段排序，顺序完全遵循前端传入的字段顺序。
    // 3. 每个排序项：
    //    - 先用 resolveFieldName 规范化字段名（支持字段别名/内部mapping）；
    //    - 然后调用 resolveColumn 获取实际数据库列对象，校验字段合法性；
    //    - 最后实例化 Order，orderDescending=true 表示降序，否则升序排序。
    // 4. 若有任何非法字段，抛出 QueryValidationException。
    OrderByListBuilder<TTable>? orderByList;
    final sorts = query.sort ?? <QuerySort>[];
    if (sorts.isNotEmpty) {
      orderByList = (t) {
        final orders = <Order>[];
        for (final sort in sorts) {
          final normalizedField = resolveFieldName(sort.field, fieldAliases, runtime: rt);
          final column = resolveColumn(t, normalizedField);
          if (column == null) throw QueryValidationException('非法排序字段: ${sort.field}');
          orders.add(Order(column: column, orderDescending: sort.order.toLowerCase() == 'desc'));
        }
        return orders;
      };
    }

    final data = await find(
      session,
      where: (t) => buildWhere(t),
      limit: safePageSize,
      offset: (safePage - 1) * safePageSize,
      orderByList: orderByList,
      orderDescending: false,
    );

    await rt.audit(session, query);
    return CrudPage.from(data: data, pageNum: safePage, pageSize: safePageSize, total: total);
  }

  static Expression? _buildCondition<TTable extends Table>(
    TTable table,
    QueryCondition condition,
    ColumnResolver<TTable> resolveColumn, {
    CrudRuntime? runtime,
  }) {
    final column = resolveColumn(table, condition.field);
    if (column == null) return null;

    final op = condition.comparator.toLowerCase();
    final value = condition.value;

    switch (op) {
      case 'eq': return _equalsExpression(column, value);
      case 'ne': return _notEqualsExpression(column, value);
      case 'like':
        if (column is ColumnString && value is String) return column.like('%$value%');
        return null;
      case 'ilike':
        if (column is ColumnString && value is String) return column.ilike('%$value%');
        return null;
      case 'in':
        final iterable = value as Iterable?;
        if (iterable != null) return _inSetExpression(column, iterable.toSet());
        return null;
      case 'between':
        final range = value as List?;
        if (range != null && range.length == 2) return _betweenExpression(column, range[0], range[1]);
        return null;
      case 'gt': return _compareExpression(column, value, _CompareOperator.gt);
      case 'gte': return _compareExpression(column, value, _CompareOperator.gte);
      case 'lt': return _compareExpression(column, value, _CompareOperator.lt);
      case 'lte': return _compareExpression(column, value, _CompareOperator.lte);
      default:
        final rt = runtime ?? CrudRuntime();
        for (final plugin in rt.plugins.operators) {
          if (plugin.name == op) {
            return plugin.build(column, value);
          }
        }
        return null;
    }
  }

  static Expression? _equalsExpression(Column column, dynamic value) {
    if (column is ColumnComparable || column is ColumnBool || column is ColumnEnum || column is ColumnBigInt) {
      return (column as dynamic).equals(value);
    }
    return null;
  }

  static Expression? _notEqualsExpression(Column column, dynamic value) {
    if (column is ColumnComparable || column is ColumnBool || column is ColumnEnum || column is ColumnBigInt) {
      return (column as dynamic).notEquals(value);
    }
    return null;
  }

  static Expression? _inSetExpression(Column column, Set<dynamic> values) {
    if (column is ColumnComparable || column is ColumnBool || column is ColumnEnum || column is ColumnBigInt) {
      return (column as dynamic).inSet(values);
    }
    return null;
  }

  static Expression? _compareExpression(
    Column column,
    dynamic value,
    _CompareOperator operator,
  ) {
    if (column is ColumnComparable) {
      switch (operator) {
        case _CompareOperator.gt: return (column as dynamic) > value;
        case _CompareOperator.gte: return (column as dynamic) >= value;
        case _CompareOperator.lt: return (column as dynamic) < value;
        case _CompareOperator.lte: return (column as dynamic) <= value;
      }
    }
    return null;
  }

  static Expression? _betweenExpression(Column column, dynamic start, dynamic end) {
    if (column is ColumnInt && start is int && end is int) return column.between(start, end);
    if (column is ColumnDouble && start is double && end is double) return column.between(start, end);
    if (column is ColumnDateTime && start is DateTime && end is DateTime) return column.between(start, end);
    if (column is ColumnDuration && start is Duration && end is Duration) return column.between(start, end);
    return null;
  }
  
} 