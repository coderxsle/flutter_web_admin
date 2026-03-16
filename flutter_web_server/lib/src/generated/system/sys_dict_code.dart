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
import 'package:serverpod/serverpod.dart' as _i1;

/// 字典类型表
abstract class SysDictCode
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysDictCode._({
    this.id,
    this.tenantId,
    required this.name,
    required this.code,
    required this.status,
    this.remark,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
  }) : deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now();

  factory SysDictCode({
    int? id,
    int? tenantId,
    required String name,
    required String code,
    required int status,
    String? remark,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) = _SysDictCodeImpl;

  factory SysDictCode.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysDictCode(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      status: jsonSerialization['status'] as int,
      remark: jsonSerialization['remark'] as String?,
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updateTime'],
      ),
    );
  }

  static final t = SysDictCodeTable();

  static const db = SysDictCodeRepository._();

  @override
  int? id;

  int? tenantId;

  String name;

  String code;

  int status;

  String? remark;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysDictCode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysDictCode copyWith({
    int? id,
    int? tenantId,
    String? name,
    String? code,
    int? status,
    String? remark,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysDictCode',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      'name': name,
      'code': code,
      'status': status,
      if (remark != null) 'remark': remark,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SysDictCode',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      'name': name,
      'code': code,
      'status': status,
      if (remark != null) 'remark': remark,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static SysDictCodeInclude include() {
    return SysDictCodeInclude._();
  }

  static SysDictCodeIncludeList includeList({
    _i1.WhereExpressionBuilder<SysDictCodeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysDictCodeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysDictCodeTable>? orderByList,
    SysDictCodeInclude? include,
  }) {
    return SysDictCodeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysDictCode.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysDictCode.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysDictCodeImpl extends SysDictCode {
  _SysDictCodeImpl({
    int? id,
    int? tenantId,
    required String name,
    required String code,
    required int status,
    String? remark,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         name: name,
         code: code,
         status: status,
         remark: remark,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [SysDictCode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysDictCode copyWith({
    Object? id = _Undefined,
    Object? tenantId = _Undefined,
    String? name,
    String? code,
    int? status,
    Object? remark = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return SysDictCode(
      id: id is int? ? id : this.id,
      tenantId: tenantId is int? ? tenantId : this.tenantId,
      name: name ?? this.name,
      code: code ?? this.code,
      status: status ?? this.status,
      remark: remark is String? ? remark : this.remark,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class SysDictCodeUpdateTable extends _i1.UpdateTable<SysDictCodeTable> {
  SysDictCodeUpdateTable(super.table);

  _i1.ColumnValue<int, int> tenantId(int? value) => _i1.ColumnValue(
    table.tenantId,
    value,
  );

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> code(String value) => _i1.ColumnValue(
    table.code,
    value,
  );

  _i1.ColumnValue<int, int> status(int value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> remark(String? value) => _i1.ColumnValue(
    table.remark,
    value,
  );

  _i1.ColumnValue<bool, bool> deleted(bool value) => _i1.ColumnValue(
    table.deleted,
    value,
  );

  _i1.ColumnValue<String, String> creator(String? value) => _i1.ColumnValue(
    table.creator,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _i1.ColumnValue(
        table.createTime,
        value,
      );

  _i1.ColumnValue<String, String> updater(String? value) => _i1.ColumnValue(
    table.updater,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _i1.ColumnValue(
        table.updateTime,
        value,
      );
}

class SysDictCodeTable extends _i1.Table<int?> {
  SysDictCodeTable({super.tableRelation}) : super(tableName: 'sys_dict_code') {
    updateTable = SysDictCodeUpdateTable(this);
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    code = _i1.ColumnString(
      'code',
      this,
    );
    status = _i1.ColumnInt(
      'status',
      this,
    );
    remark = _i1.ColumnString(
      'remark',
      this,
    );
    deleted = _i1.ColumnBool(
      'deleted',
      this,
      hasDefault: true,
    );
    creator = _i1.ColumnString(
      'creator',
      this,
    );
    createTime = _i1.ColumnDateTime(
      'createTime',
      this,
      hasDefault: true,
    );
    updater = _i1.ColumnString(
      'updater',
      this,
    );
    updateTime = _i1.ColumnDateTime(
      'updateTime',
      this,
    );
  }

  late final SysDictCodeUpdateTable updateTable;

  late final _i1.ColumnInt tenantId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString code;

  late final _i1.ColumnInt status;

  late final _i1.ColumnString remark;

  late final _i1.ColumnBool deleted;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  @override
  List<_i1.Column> get columns => [
    id,
    tenantId,
    name,
    code,
    status,
    remark,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class SysDictCodeInclude extends _i1.IncludeObject {
  SysDictCodeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysDictCode.t;
}

class SysDictCodeIncludeList extends _i1.IncludeList {
  SysDictCodeIncludeList._({
    _i1.WhereExpressionBuilder<SysDictCodeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysDictCode.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysDictCode.t;
}

class SysDictCodeRepository {
  const SysDictCodeRepository._();

  /// Returns a list of [SysDictCode]s matching the given query parameters.
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
  Future<List<SysDictCode>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SysDictCodeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysDictCodeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysDictCodeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysDictCode>(
      where: where?.call(SysDictCode.t),
      orderBy: orderBy?.call(SysDictCode.t),
      orderByList: orderByList?.call(SysDictCode.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysDictCode] matching the given query parameters.
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
  Future<SysDictCode?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SysDictCodeTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysDictCodeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysDictCodeTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysDictCode>(
      where: where?.call(SysDictCode.t),
      orderBy: orderBy?.call(SysDictCode.t),
      orderByList: orderByList?.call(SysDictCode.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysDictCode] by its [id] or null if no such row exists.
  Future<SysDictCode?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysDictCode>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysDictCode]s in the list and returns the inserted rows.
  ///
  /// The returned [SysDictCode]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<SysDictCode>> insert(
    _i1.DatabaseSession session,
    List<SysDictCode> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<SysDictCode>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [SysDictCode] and returns the inserted row.
  ///
  /// The returned [SysDictCode] will have its `id` field set.
  Future<SysDictCode> insertRow(
    _i1.DatabaseSession session,
    SysDictCode row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysDictCode>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysDictCode]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysDictCode>> update(
    _i1.DatabaseSession session,
    List<SysDictCode> rows, {
    _i1.ColumnSelections<SysDictCodeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysDictCode>(
      rows,
      columns: columns?.call(SysDictCode.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysDictCode]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysDictCode> updateRow(
    _i1.DatabaseSession session,
    SysDictCode row, {
    _i1.ColumnSelections<SysDictCodeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysDictCode>(
      row,
      columns: columns?.call(SysDictCode.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysDictCode] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysDictCode?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SysDictCodeUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SysDictCode>(
      id,
      columnValues: columnValues(SysDictCode.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysDictCode]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SysDictCode>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SysDictCodeUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SysDictCodeTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysDictCodeTable>? orderBy,
    _i1.OrderByListBuilder<SysDictCodeTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SysDictCode>(
      columnValues: columnValues(SysDictCode.t.updateTable),
      where: where(SysDictCode.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysDictCode.t),
      orderByList: orderByList?.call(SysDictCode.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SysDictCode]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysDictCode>> delete(
    _i1.DatabaseSession session,
    List<SysDictCode> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysDictCode>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysDictCode].
  Future<SysDictCode> deleteRow(
    _i1.DatabaseSession session,
    SysDictCode row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysDictCode>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysDictCode>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SysDictCodeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysDictCode>(
      where: where(SysDictCode.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SysDictCodeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysDictCode>(
      where: where?.call(SysDictCode.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysDictCode] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SysDictCodeTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysDictCode>(
      where: where(SysDictCode.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
