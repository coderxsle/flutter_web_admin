/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _is;

abstract class Qimen implements _is.TableRow<int?>, _is.ProtocolSerialization {
  Qimen._({
    this.id,
    required this.userId,
    required this.panTime,
    required this.method,
    required this.dunType,
    required this.juShu,
    required this.question,
    required this.analysis,
    DateTime? createTime,
    DateTime? updateTime,
  }) : createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory Qimen({
    int? id,
    required int userId,
    required DateTime panTime,
    required String method,
    required String dunType,
    required int juShu,
    required String question,
    required String analysis,
    DateTime? createTime,
    DateTime? updateTime,
  }) = _QimenImpl;

  factory Qimen.fromJson(Map<String, dynamic> jsonSerialization) {
    return Qimen(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      panTime: _is.DateTimeJsonExtension.fromJson(jsonSerialization['panTime']),
      method: jsonSerialization['method'] as String,
      dunType: jsonSerialization['dunType'] as String,
      juShu: jsonSerialization['juShu'] as int,
      question: jsonSerialization['question'] as String,
      analysis: jsonSerialization['analysis'] as String,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  static final t = QimenTable();

  static const db = QimenRepository._();

  @override
  int? id;

  int userId;

  /// 排盘时间
  DateTime panTime;

  /// 排盘方式（如奇门遁甲、四柱八字等）
  String method;

  /// 遁法（阳遁、阴遁）
  String dunType;

  /// # 局数（1~9）
  int juShu;

  /// 占事（用户所问之事）
  String question;

  /// 断言（断语或推演结果）
  String analysis;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [Qimen]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  Qimen copyWith({
    int? id,
    int? userId,
    DateTime? panTime,
    String? method,
    String? dunType,
    int? juShu,
    String? question,
    String? analysis,
    DateTime? createTime,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Qimen',
      if (id != null) 'id': id,
      'userId': userId,
      'panTime': panTime.toJson(),
      'method': method,
      'dunType': dunType,
      'juShu': juShu,
      'question': question,
      'analysis': analysis,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Qimen',
      if (id != null) 'id': id,
      'userId': userId,
      'panTime': panTime.toJson(),
      'method': method,
      'dunType': dunType,
      'juShu': juShu,
      'question': question,
      'analysis': analysis,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
    };
  }

  static QimenInclude include() {
    return QimenInclude._();
  }

  static QimenIncludeList includeList({
    _is.WhereExpressionBuilder<QimenTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QimenTable>? orderBy,
    _is.OrderByListBuilder<QimenTable>? orderByList,
    QimenInclude? include,
  }) {
    return QimenIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Qimen.t),
      orderByList: orderByList?.call(Qimen.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QimenImpl extends Qimen {
  _QimenImpl({
    int? id,
    required int userId,
    required DateTime panTime,
    required String method,
    required String dunType,
    required int juShu,
    required String question,
    required String analysis,
    DateTime? createTime,
    DateTime? updateTime,
  }) : super._(
         id: id,
         userId: userId,
         panTime: panTime,
         method: method,
         dunType: dunType,
         juShu: juShu,
         question: question,
         analysis: analysis,
         createTime: createTime,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [Qimen]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  Qimen copyWith({
    Object? id = _Undefined,
    int? userId,
    DateTime? panTime,
    String? method,
    String? dunType,
    int? juShu,
    String? question,
    String? analysis,
    DateTime? createTime,
    DateTime? updateTime,
  }) {
    return Qimen(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      panTime: panTime ?? this.panTime,
      method: method ?? this.method,
      dunType: dunType ?? this.dunType,
      juShu: juShu ?? this.juShu,
      question: question ?? this.question,
      analysis: analysis ?? this.analysis,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class QimenUpdateTable extends _is.UpdateTable<QimenTable> {
  QimenUpdateTable(super.table);

  _is.ColumnValue<int, int> userId(int value) =>
      _is.ColumnValue(table.userId, value);

  _is.ColumnValue<DateTime, DateTime> panTime(DateTime value) =>
      _is.ColumnValue(table.panTime, value);

  _is.ColumnValue<String, String> method(String value) =>
      _is.ColumnValue(table.method, value);

  _is.ColumnValue<String, String> dunType(String value) =>
      _is.ColumnValue(table.dunType, value);

  _is.ColumnValue<int, int> juShu(int value) =>
      _is.ColumnValue(table.juShu, value);

  _is.ColumnValue<String, String> question(String value) =>
      _is.ColumnValue(table.question, value);

  _is.ColumnValue<String, String> analysis(String value) =>
      _is.ColumnValue(table.analysis, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _is.ColumnValue(table.updateTime, value);
}

class QimenTable extends _is.Table<int?> {
  QimenTable({super.tableRelation}) : super(tableName: 'qimen_history') {
    updateTable = QimenUpdateTable(this);
    userId = _is.ColumnInt('userId', this);
    panTime = _is.ColumnDateTime('panTime', this);
    method = _is.ColumnString('method', this);
    dunType = _is.ColumnString('dunType', this);
    juShu = _is.ColumnInt('juShu', this);
    question = _is.ColumnString('question', this);
    analysis = _is.ColumnString('analysis', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final QimenUpdateTable updateTable;

  late final _is.ColumnInt userId;

  /// 排盘时间
  late final _is.ColumnDateTime panTime;

  /// 排盘方式（如奇门遁甲、四柱八字等）
  late final _is.ColumnString method;

  /// 遁法（阳遁、阴遁）
  late final _is.ColumnString dunType;

  /// # 局数（1~9）
  late final _is.ColumnInt juShu;

  /// 占事（用户所问之事）
  late final _is.ColumnString question;

  /// 断言（断语或推演结果）
  late final _is.ColumnString analysis;

  /// 记录创建时间
  late final _is.ColumnDateTime createTime;

  /// 记录最后更新时间
  late final _is.ColumnDateTime updateTime;

  @override
  List<_is.Column> get columns => [
    id,
    userId,
    panTime,
    method,
    dunType,
    juShu,
    question,
    analysis,
    createTime,
    updateTime,
  ];
}

class QimenInclude extends _is.IncludeObject {
  QimenInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => Qimen.t;
}

class QimenIncludeList extends _is.IncludeList {
  QimenIncludeList._({
    _is.WhereExpressionBuilder<QimenTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Qimen.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => Qimen.t;
}

class QimenRepository {
  const QimenRepository._();

  /// Returns a list of [Qimen]s matching the given query parameters.
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
  Future<List<Qimen>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QimenTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QimenTable>? orderBy,
    _is.OrderByListBuilder<QimenTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Qimen>(
      where: where?.call(Qimen.t),
      orderBy: orderBy?.call(Qimen.t),
      orderByList: orderByList?.call(Qimen.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Qimen] matching the given query parameters.
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
  Future<Qimen?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QimenTable>? where,
    int? offset,
    _is.OrderByBuilder<QimenTable>? orderBy,
    _is.OrderByListBuilder<QimenTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Qimen>(
      where: where?.call(Qimen.t),
      orderBy: orderBy?.call(Qimen.t),
      orderByList: orderByList?.call(Qimen.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Qimen] by its [id] or null if no such row exists.
  Future<Qimen?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Qimen>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Qimen]s in the list and returns the inserted rows.
  ///
  /// The returned [Qimen]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Qimen>> insert(
    _is.DatabaseSession session,
    List<Qimen> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<Qimen>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [Qimen] and returns the inserted row.
  ///
  /// The returned [Qimen] will have its `id` field set.
  Future<Qimen> insertRow(
    _is.DatabaseSession session,
    Qimen row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<Qimen>(row, transaction: transaction);
  }

  /// Upserts all [Qimen]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [Qimen]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Qimen>> upsert(
    _is.DatabaseSession session,
    List<Qimen> rows, {
    required _is.ColumnSelections<QimenTable> conflictColumns,
    _is.ColumnSelections<QimenTable>? updateColumns,
    _is.WhereExpressionBuilder<QimenTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<Qimen>(
      rows,
      conflictColumns: conflictColumns(Qimen.t),
      updateColumns: updateColumns?.call(Qimen.t),
      updateWhere: updateWhere?.call(Qimen.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [Qimen] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [Qimen] will have its `id` field set.
  Future<Qimen?> upsertRow(
    _is.DatabaseSession session,
    Qimen row, {
    required _is.ColumnSelections<QimenTable> conflictColumns,
    _is.ColumnSelections<QimenTable>? updateColumns,
    _is.WhereExpressionBuilder<QimenTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<Qimen>(
      row,
      conflictColumns: conflictColumns(Qimen.t),
      updateColumns: updateColumns?.call(Qimen.t),
      updateWhere: updateWhere?.call(Qimen.t),
      transaction: transaction,
    );
  }

  /// Updates all [Qimen]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Qimen>> update(
    _is.DatabaseSession session,
    List<Qimen> rows, {
    _is.ColumnSelections<QimenTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<Qimen>(
      rows,
      columns: columns?.call(Qimen.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [Qimen]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Qimen> updateRow(
    _is.DatabaseSession session,
    Qimen row, {
    _is.ColumnSelections<QimenTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<Qimen>(
      row,
      columns: columns?.call(Qimen.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Qimen] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Qimen?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<QimenUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<Qimen>(
      id,
      columnValues: columnValues(Qimen.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Qimen]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Qimen>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<QimenUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<QimenTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<QimenTable>? orderBy,
    _is.OrderByListBuilder<QimenTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<Qimen>(
      columnValues: columnValues(Qimen.t.updateTable),
      where: where(Qimen.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Qimen.t),
      orderByList: orderByList?.call(Qimen.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [Qimen]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Qimen>> delete(
    _is.DatabaseSession session,
    List<Qimen> rows, {
    _is.OrderByBuilder<QimenTable>? orderBy,
    _is.OrderByListBuilder<QimenTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<Qimen>(
      rows,
      orderBy: orderBy?.call(Qimen.t),
      orderByList: orderByList?.call(Qimen.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [Qimen].
  Future<Qimen> deleteRow(
    _is.DatabaseSession session,
    Qimen row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Qimen>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<Qimen>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QimenTable> where,
    _is.OrderByBuilder<QimenTable>? orderBy,
    _is.OrderByListBuilder<QimenTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<Qimen>(
      where: where(Qimen.t),
      orderBy: orderBy?.call(Qimen.t),
      orderByList: orderByList?.call(Qimen.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<QimenTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<Qimen>(
      where: where?.call(Qimen.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Qimen] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<QimenTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Qimen>(
      where: where(Qimen.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
