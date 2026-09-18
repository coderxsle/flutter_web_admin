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

/// 租户表
abstract class SysTenant
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysTenant._({
    this.id,
    required this.name,
    this.contactUserId,
    required this.contactName,
    this.contactMobile,
    required this.status,
    this.websites,
    required this.packageId,
    required this.expireTime,
    required this.accountCount,
    required this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysTenant({
    int? id,
    required String name,
    int? contactUserId,
    required String contactName,
    String? contactMobile,
    required int status,
    String? websites,
    required int packageId,
    required DateTime expireTime,
    required int accountCount,
    required String creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysTenantImpl;

  factory SysTenant.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysTenant(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      contactUserId: jsonSerialization['contactUserId'] as int?,
      contactName: jsonSerialization['contactName'] as String,
      contactMobile: jsonSerialization['contactMobile'] as String?,
      status: jsonSerialization['status'] as int,
      websites: jsonSerialization['websites'] as String?,
      packageId: jsonSerialization['packageId'] as int,
      expireTime: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['expireTime'],
      ),
      accountCount: jsonSerialization['accountCount'] as int,
      creator: jsonSerialization['creator'] as String,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updateTime'],
      ),
      deleted: _is.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
    );
  }

  static final t = SysTenantTable();

  static const db = SysTenantRepository._();

  @override
  int? id;

  String name;

  int? contactUserId;

  String contactName;

  String? contactMobile;

  int status;

  String? websites;

  int packageId;

  DateTime expireTime;

  int accountCount;

  String creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysTenant]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysTenant copyWith({
    int? id,
    String? name,
    int? contactUserId,
    String? contactName,
    String? contactMobile,
    int? status,
    String? websites,
    int? packageId,
    DateTime? expireTime,
    int? accountCount,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysTenant',
      if (id != null) 'id': id,
      'name': name,
      if (contactUserId != null) 'contactUserId': contactUserId,
      'contactName': contactName,
      if (contactMobile != null) 'contactMobile': contactMobile,
      'status': status,
      if (websites != null) 'websites': websites,
      'packageId': packageId,
      'expireTime': expireTime.toJson(),
      'accountCount': accountCount,
      'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SysTenant',
      if (id != null) 'id': id,
      'name': name,
      if (contactUserId != null) 'contactUserId': contactUserId,
      'contactName': contactName,
      if (contactMobile != null) 'contactMobile': contactMobile,
      'status': status,
      if (websites != null) 'websites': websites,
      'packageId': packageId,
      'expireTime': expireTime.toJson(),
      'accountCount': accountCount,
      'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysTenantInclude include() {
    return SysTenantInclude._();
  }

  static SysTenantIncludeList includeList({
    _is.WhereExpressionBuilder<SysTenantTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysTenantTable>? orderBy,
    _is.OrderByListBuilder<SysTenantTable>? orderByList,
    SysTenantInclude? include,
  }) {
    return SysTenantIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysTenant.t),
      orderByList: orderByList?.call(SysTenant.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysTenantImpl extends SysTenant {
  _SysTenantImpl({
    int? id,
    required String name,
    int? contactUserId,
    required String contactName,
    String? contactMobile,
    required int status,
    String? websites,
    required int packageId,
    required DateTime expireTime,
    required int accountCount,
    required String creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         name: name,
         contactUserId: contactUserId,
         contactName: contactName,
         contactMobile: contactMobile,
         status: status,
         websites: websites,
         packageId: packageId,
         expireTime: expireTime,
         accountCount: accountCount,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [SysTenant]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysTenant copyWith({
    Object? id = _Undefined,
    String? name,
    Object? contactUserId = _Undefined,
    String? contactName,
    Object? contactMobile = _Undefined,
    int? status,
    Object? websites = _Undefined,
    int? packageId,
    DateTime? expireTime,
    int? accountCount,
    String? creator,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysTenant(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      contactUserId: contactUserId is int? ? contactUserId : this.contactUserId,
      contactName: contactName ?? this.contactName,
      contactMobile: contactMobile is String?
          ? contactMobile
          : this.contactMobile,
      status: status ?? this.status,
      websites: websites is String? ? websites : this.websites,
      packageId: packageId ?? this.packageId,
      expireTime: expireTime ?? this.expireTime,
      accountCount: accountCount ?? this.accountCount,
      creator: creator ?? this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysTenantUpdateTable extends _is.UpdateTable<SysTenantTable> {
  SysTenantUpdateTable(super.table);

  _is.ColumnValue<String, String> name(String value) =>
      _is.ColumnValue(table.name, value);

  _is.ColumnValue<int, int> contactUserId(int? value) =>
      _is.ColumnValue(table.contactUserId, value);

  _is.ColumnValue<String, String> contactName(String value) =>
      _is.ColumnValue(table.contactName, value);

  _is.ColumnValue<String, String> contactMobile(String? value) =>
      _is.ColumnValue(table.contactMobile, value);

  _is.ColumnValue<int, int> status(int value) =>
      _is.ColumnValue(table.status, value);

  _is.ColumnValue<String, String> websites(String? value) =>
      _is.ColumnValue(table.websites, value);

  _is.ColumnValue<int, int> packageId(int value) =>
      _is.ColumnValue(table.packageId, value);

  _is.ColumnValue<DateTime, DateTime> expireTime(DateTime value) =>
      _is.ColumnValue(table.expireTime, value);

  _is.ColumnValue<int, int> accountCount(int value) =>
      _is.ColumnValue(table.accountCount, value);

  _is.ColumnValue<String, String> creator(String value) =>
      _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) =>
      _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _is.ColumnValue(table.updateTime, value);

  _is.ColumnValue<bool, bool> deleted(bool value) =>
      _is.ColumnValue(table.deleted, value);
}

class SysTenantTable extends _is.Table<int?> {
  SysTenantTable({super.tableRelation}) : super(tableName: 'sys_tenant') {
    updateTable = SysTenantUpdateTable(this);
    name = _is.ColumnString('name', this);
    contactUserId = _is.ColumnInt('contactUserId', this);
    contactName = _is.ColumnString('contactName', this);
    contactMobile = _is.ColumnString('contactMobile', this);
    status = _is.ColumnInt('status', this);
    websites = _is.ColumnString('websites', this);
    packageId = _is.ColumnInt('packageId', this);
    expireTime = _is.ColumnDateTime('expireTime', this);
    accountCount = _is.ColumnInt('accountCount', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final SysTenantUpdateTable updateTable;

  late final _is.ColumnString name;

  late final _is.ColumnInt contactUserId;

  late final _is.ColumnString contactName;

  late final _is.ColumnString contactMobile;

  late final _is.ColumnInt status;

  late final _is.ColumnString websites;

  late final _is.ColumnInt packageId;

  late final _is.ColumnDateTime expireTime;

  late final _is.ColumnInt accountCount;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    name,
    contactUserId,
    contactName,
    contactMobile,
    status,
    websites,
    packageId,
    expireTime,
    accountCount,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class SysTenantInclude extends _is.IncludeObject {
  SysTenantInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysTenant.t;
}

class SysTenantIncludeList extends _is.IncludeList {
  SysTenantIncludeList._({
    _is.WhereExpressionBuilder<SysTenantTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysTenant.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysTenant.t;
}

class SysTenantRepository {
  const SysTenantRepository._();

  /// Returns a list of [SysTenant]s matching the given query parameters.
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
  Future<List<SysTenant>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysTenantTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysTenantTable>? orderBy,
    _is.OrderByListBuilder<SysTenantTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysTenant>(
      where: where?.call(SysTenant.t),
      orderBy: orderBy?.call(SysTenant.t),
      orderByList: orderByList?.call(SysTenant.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysTenant] matching the given query parameters.
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
  Future<SysTenant?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysTenantTable>? where,
    int? offset,
    _is.OrderByBuilder<SysTenantTable>? orderBy,
    _is.OrderByListBuilder<SysTenantTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysTenant>(
      where: where?.call(SysTenant.t),
      orderBy: orderBy?.call(SysTenant.t),
      orderByList: orderByList?.call(SysTenant.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysTenant] by its [id] or null if no such row exists.
  Future<SysTenant?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysTenant>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysTenant]s in the list and returns the inserted rows.
  ///
  /// The returned [SysTenant]s will have their `id` fields set.
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
  Future<List<SysTenant>> insert(
    _is.DatabaseSession session,
    List<SysTenant> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysTenant>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysTenant] and returns the inserted row.
  ///
  /// The returned [SysTenant] will have its `id` field set.
  Future<SysTenant> insertRow(
    _is.DatabaseSession session,
    SysTenant row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysTenant>(row, transaction: transaction);
  }

  /// Upserts all [SysTenant]s in the list and returns the resulting rows.
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
  /// The returned [SysTenant]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysTenant>> upsert(
    _is.DatabaseSession session,
    List<SysTenant> rows, {
    required _is.ColumnSelections<SysTenantTable> conflictColumns,
    _is.ColumnSelections<SysTenantTable>? updateColumns,
    _is.WhereExpressionBuilder<SysTenantTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysTenant>(
      rows,
      conflictColumns: conflictColumns(SysTenant.t),
      updateColumns: updateColumns?.call(SysTenant.t),
      updateWhere: updateWhere?.call(SysTenant.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysTenant] and returns the resulting row.
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
  /// The returned [SysTenant] will have its `id` field set.
  Future<SysTenant?> upsertRow(
    _is.DatabaseSession session,
    SysTenant row, {
    required _is.ColumnSelections<SysTenantTable> conflictColumns,
    _is.ColumnSelections<SysTenantTable>? updateColumns,
    _is.WhereExpressionBuilder<SysTenantTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysTenant>(
      row,
      conflictColumns: conflictColumns(SysTenant.t),
      updateColumns: updateColumns?.call(SysTenant.t),
      updateWhere: updateWhere?.call(SysTenant.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysTenant]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysTenant>> update(
    _is.DatabaseSession session,
    List<SysTenant> rows, {
    _is.ColumnSelections<SysTenantTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysTenant>(
      rows,
      columns: columns?.call(SysTenant.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysTenant]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysTenant> updateRow(
    _is.DatabaseSession session,
    SysTenant row, {
    _is.ColumnSelections<SysTenantTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysTenant>(
      row,
      columns: columns?.call(SysTenant.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysTenant] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysTenant?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysTenantUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysTenant>(
      id,
      columnValues: columnValues(SysTenant.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysTenant]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysTenant>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysTenantUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysTenantTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysTenantTable>? orderBy,
    _is.OrderByListBuilder<SysTenantTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysTenant>(
      columnValues: columnValues(SysTenant.t.updateTable),
      where: where(SysTenant.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysTenant.t),
      orderByList: orderByList?.call(SysTenant.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysTenant]s in the list and returns the deleted rows.
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
  Future<List<SysTenant>> delete(
    _is.DatabaseSession session,
    List<SysTenant> rows, {
    _is.OrderByBuilder<SysTenantTable>? orderBy,
    _is.OrderByListBuilder<SysTenantTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysTenant>(
      rows,
      orderBy: orderBy?.call(SysTenant.t),
      orderByList: orderByList?.call(SysTenant.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysTenant].
  Future<SysTenant> deleteRow(
    _is.DatabaseSession session,
    SysTenant row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysTenant>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysTenant>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysTenantTable> where,
    _is.OrderByBuilder<SysTenantTable>? orderBy,
    _is.OrderByListBuilder<SysTenantTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysTenant>(
      where: where(SysTenant.t),
      orderBy: orderBy?.call(SysTenant.t),
      orderByList: orderByList?.call(SysTenant.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysTenantTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysTenant>(
      where: where?.call(SysTenant.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysTenant] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysTenantTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysTenant>(
      where: where(SysTenant.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
