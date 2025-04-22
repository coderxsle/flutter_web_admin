/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

/// 用于记录系统中的数据操作日志
abstract class SysOperationLog
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  SysOperationLog._({
    this.id,
    String? tableNameStr,
    int? operationType,
    this.recordId,
    String? oldData,
    String? newData,
    int? operatorId,
    DateTime? operationTime,
  })  : tableNameStr = tableNameStr ?? '',
        operationType = operationType ?? 0,
        oldData = oldData ?? '',
        newData = newData ?? '',
        operatorId = operatorId ?? 0,
        operationTime = operationTime ?? DateTime.now();

  factory SysOperationLog({
    int? id,
    String? tableNameStr,
    int? operationType,
    int? recordId,
    String? oldData,
    String? newData,
    int? operatorId,
    DateTime? operationTime,
  }) = _SysOperationLogImpl;

  factory SysOperationLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysOperationLog(
      id: jsonSerialization['id'] as int?,
      tableNameStr: jsonSerialization['tableNameStr'] as String,
      operationType: jsonSerialization['operationType'] as int,
      recordId: jsonSerialization['recordId'] as int?,
      oldData: jsonSerialization['oldData'] as String,
      newData: jsonSerialization['newData'] as String,
      operatorId: jsonSerialization['operatorId'] as int,
      operationTime: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['operationTime']),
    );
  }

  static final t = SysOperationLogTable();

  static const db = SysOperationLogRepository._();

  @override
  int? id;

  /// 被操作的表名（默认空字符串）
  String tableNameStr;

  /// 表示操作类型（1插入、2删除、3更新）
  int operationType;

  /// 被操作的记录的唯一标识符（通常是该表的主键）
  int? recordId;

  /// 在更新或删除时，记录被修改前的旧数据，使用 JSON 格式存储
  String oldData;

  /// 在更新或插入时，记录被修改后的新数据，使用 JSON 格式存储
  String newData;

  /// 记录执行操作的用户，可以是用户名或用户的 ID
  int operatorId;

  /// 记录操作发生的时间，默认为当前时间
  DateTime operationTime;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [SysOperationLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysOperationLog copyWith({
    int? id,
    String? tableNameStr,
    int? operationType,
    int? recordId,
    String? oldData,
    String? newData,
    int? operatorId,
    DateTime? operationTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'tableNameStr': tableNameStr,
      'operationType': operationType,
      if (recordId != null) 'recordId': recordId,
      'oldData': oldData,
      'newData': newData,
      'operatorId': operatorId,
      'operationTime': operationTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'tableNameStr': tableNameStr,
      'operationType': operationType,
      if (recordId != null) 'recordId': recordId,
      'oldData': oldData,
      'newData': newData,
      'operatorId': operatorId,
      'operationTime': operationTime.toJson(),
    };
  }

  static SysOperationLogInclude include() {
    return SysOperationLogInclude._();
  }

  static SysOperationLogIncludeList includeList({
    _i1.WhereExpressionBuilder<SysOperationLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysOperationLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysOperationLogTable>? orderByList,
    SysOperationLogInclude? include,
  }) {
    return SysOperationLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysOperationLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysOperationLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysOperationLogImpl extends SysOperationLog {
  _SysOperationLogImpl({
    int? id,
    String? tableNameStr,
    int? operationType,
    int? recordId,
    String? oldData,
    String? newData,
    int? operatorId,
    DateTime? operationTime,
  }) : super._(
          id: id,
          tableNameStr: tableNameStr,
          operationType: operationType,
          recordId: recordId,
          oldData: oldData,
          newData: newData,
          operatorId: operatorId,
          operationTime: operationTime,
        );

  /// Returns a shallow copy of this [SysOperationLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysOperationLog copyWith({
    Object? id = _Undefined,
    String? tableNameStr,
    int? operationType,
    Object? recordId = _Undefined,
    String? oldData,
    String? newData,
    int? operatorId,
    DateTime? operationTime,
  }) {
    return SysOperationLog(
      id: id is int? ? id : this.id,
      tableNameStr: tableNameStr ?? this.tableNameStr,
      operationType: operationType ?? this.operationType,
      recordId: recordId is int? ? recordId : this.recordId,
      oldData: oldData ?? this.oldData,
      newData: newData ?? this.newData,
      operatorId: operatorId ?? this.operatorId,
      operationTime: operationTime ?? this.operationTime,
    );
  }
}

class SysOperationLogTable extends _i1.Table<int> {
  SysOperationLogTable({super.tableRelation})
      : super(tableName: 'sys_operation_log') {
    tableNameStr = _i1.ColumnString(
      'tableNameStr',
      this,
      hasDefault: true,
    );
    operationType = _i1.ColumnInt(
      'operationType',
      this,
      hasDefault: true,
    );
    recordId = _i1.ColumnInt(
      'recordId',
      this,
    );
    oldData = _i1.ColumnString(
      'oldData',
      this,
      hasDefault: true,
    );
    newData = _i1.ColumnString(
      'newData',
      this,
      hasDefault: true,
    );
    operatorId = _i1.ColumnInt(
      'operatorId',
      this,
      hasDefault: true,
    );
    operationTime = _i1.ColumnDateTime(
      'operationTime',
      this,
      hasDefault: true,
    );
  }

  /// 被操作的表名（默认空字符串）
  late final _i1.ColumnString tableNameStr;

  /// 表示操作类型（1插入、2删除、3更新）
  late final _i1.ColumnInt operationType;

  /// 被操作的记录的唯一标识符（通常是该表的主键）
  late final _i1.ColumnInt recordId;

  /// 在更新或删除时，记录被修改前的旧数据，使用 JSON 格式存储
  late final _i1.ColumnString oldData;

  /// 在更新或插入时，记录被修改后的新数据，使用 JSON 格式存储
  late final _i1.ColumnString newData;

  /// 记录执行操作的用户，可以是用户名或用户的 ID
  late final _i1.ColumnInt operatorId;

  /// 记录操作发生的时间，默认为当前时间
  late final _i1.ColumnDateTime operationTime;

  @override
  List<_i1.Column> get columns => [
        id,
        tableNameStr,
        operationType,
        recordId,
        oldData,
        newData,
        operatorId,
        operationTime,
      ];
}

class SysOperationLogInclude extends _i1.IncludeObject {
  SysOperationLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => SysOperationLog.t;
}

class SysOperationLogIncludeList extends _i1.IncludeList {
  SysOperationLogIncludeList._({
    _i1.WhereExpressionBuilder<SysOperationLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysOperationLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => SysOperationLog.t;
}

class SysOperationLogRepository {
  const SysOperationLogRepository._();

  /// Returns a list of [SysOperationLog]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<SysOperationLog>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysOperationLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysOperationLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysOperationLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysOperationLog>(
      where: where?.call(SysOperationLog.t),
      orderBy: orderBy?.call(SysOperationLog.t),
      orderByList: orderByList?.call(SysOperationLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysOperationLog] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<SysOperationLog?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysOperationLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysOperationLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysOperationLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysOperationLog>(
      where: where?.call(SysOperationLog.t),
      orderBy: orderBy?.call(SysOperationLog.t),
      orderByList: orderByList?.call(SysOperationLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysOperationLog] by its [id] or null if no such row exists.
  Future<SysOperationLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysOperationLog>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysOperationLog]s in the list and returns the inserted rows.
  ///
  /// The returned [SysOperationLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysOperationLog>> insert(
    _i1.Session session,
    List<SysOperationLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysOperationLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysOperationLog] and returns the inserted row.
  ///
  /// The returned [SysOperationLog] will have its `id` field set.
  Future<SysOperationLog> insertRow(
    _i1.Session session,
    SysOperationLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysOperationLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysOperationLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysOperationLog>> update(
    _i1.Session session,
    List<SysOperationLog> rows, {
    _i1.ColumnSelections<SysOperationLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysOperationLog>(
      rows,
      columns: columns?.call(SysOperationLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysOperationLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysOperationLog> updateRow(
    _i1.Session session,
    SysOperationLog row, {
    _i1.ColumnSelections<SysOperationLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysOperationLog>(
      row,
      columns: columns?.call(SysOperationLog.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysOperationLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysOperationLog>> delete(
    _i1.Session session,
    List<SysOperationLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysOperationLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysOperationLog].
  Future<SysOperationLog> deleteRow(
    _i1.Session session,
    SysOperationLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysOperationLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysOperationLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysOperationLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysOperationLog>(
      where: where(SysOperationLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysOperationLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysOperationLog>(
      where: where?.call(SysOperationLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
