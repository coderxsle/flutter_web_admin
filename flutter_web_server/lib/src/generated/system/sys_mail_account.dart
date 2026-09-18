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

/// 邮箱账号表
abstract class SysMailAccount
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysMailAccount._({
    this.id,
    required this.mail,
    required this.username,
    required this.password,
    required this.host,
    required this.port,
    required this.sslEnable,
    required this.starttlsEnable,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysMailAccount({
    int? id,
    required String mail,
    required String username,
    required String password,
    required String host,
    required int port,
    required bool sslEnable,
    required bool starttlsEnable,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysMailAccountImpl;

  factory SysMailAccount.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysMailAccount(
      id: jsonSerialization['id'] as int?,
      mail: jsonSerialization['mail'] as String,
      username: jsonSerialization['username'] as String,
      password: jsonSerialization['password'] as String,
      host: jsonSerialization['host'] as String,
      port: jsonSerialization['port'] as int,
      sslEnable: _is.BoolJsonExtension.fromJson(jsonSerialization['sslEnable']),
      starttlsEnable: _is.BoolJsonExtension.fromJson(
        jsonSerialization['starttlsEnable'],
      ),
      creator: jsonSerialization['creator'] as String?,
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

  static final t = SysMailAccountTable();

  static const db = SysMailAccountRepository._();

  @override
  int? id;

  String mail;

  String username;

  String password;

  String host;

  int port;

  bool sslEnable;

  bool starttlsEnable;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysMailAccount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysMailAccount copyWith({
    int? id,
    String? mail,
    String? username,
    String? password,
    String? host,
    int? port,
    bool? sslEnable,
    bool? starttlsEnable,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysMailAccount',
      if (id != null) 'id': id,
      'mail': mail,
      'username': username,
      'password': password,
      'host': host,
      'port': port,
      'sslEnable': sslEnable,
      'starttlsEnable': starttlsEnable,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SysMailAccount',
      if (id != null) 'id': id,
      'mail': mail,
      'username': username,
      'password': password,
      'host': host,
      'port': port,
      'sslEnable': sslEnable,
      'starttlsEnable': starttlsEnable,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysMailAccountInclude include() {
    return SysMailAccountInclude._();
  }

  static SysMailAccountIncludeList includeList({
    _is.WhereExpressionBuilder<SysMailAccountTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysMailAccountTable>? orderBy,
    _is.OrderByListBuilder<SysMailAccountTable>? orderByList,
    SysMailAccountInclude? include,
  }) {
    return SysMailAccountIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysMailAccount.t),
      orderByList: orderByList?.call(SysMailAccount.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysMailAccountImpl extends SysMailAccount {
  _SysMailAccountImpl({
    int? id,
    required String mail,
    required String username,
    required String password,
    required String host,
    required int port,
    required bool sslEnable,
    required bool starttlsEnable,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         mail: mail,
         username: username,
         password: password,
         host: host,
         port: port,
         sslEnable: sslEnable,
         starttlsEnable: starttlsEnable,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [SysMailAccount]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysMailAccount copyWith({
    Object? id = _Undefined,
    String? mail,
    String? username,
    String? password,
    String? host,
    int? port,
    bool? sslEnable,
    bool? starttlsEnable,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysMailAccount(
      id: id is int? ? id : this.id,
      mail: mail ?? this.mail,
      username: username ?? this.username,
      password: password ?? this.password,
      host: host ?? this.host,
      port: port ?? this.port,
      sslEnable: sslEnable ?? this.sslEnable,
      starttlsEnable: starttlsEnable ?? this.starttlsEnable,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysMailAccountUpdateTable extends _is.UpdateTable<SysMailAccountTable> {
  SysMailAccountUpdateTable(super.table);

  _is.ColumnValue<String, String> mail(String value) =>
      _is.ColumnValue(table.mail, value);

  _is.ColumnValue<String, String> username(String value) =>
      _is.ColumnValue(table.username, value);

  _is.ColumnValue<String, String> password(String value) =>
      _is.ColumnValue(table.password, value);

  _is.ColumnValue<String, String> host(String value) =>
      _is.ColumnValue(table.host, value);

  _is.ColumnValue<int, int> port(int value) =>
      _is.ColumnValue(table.port, value);

  _is.ColumnValue<bool, bool> sslEnable(bool value) =>
      _is.ColumnValue(table.sslEnable, value);

  _is.ColumnValue<bool, bool> starttlsEnable(bool value) =>
      _is.ColumnValue(table.starttlsEnable, value);

  _is.ColumnValue<String, String> creator(String? value) =>
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

class SysMailAccountTable extends _is.Table<int?> {
  SysMailAccountTable({super.tableRelation})
    : super(tableName: 'sys_mail_account') {
    updateTable = SysMailAccountUpdateTable(this);
    mail = _is.ColumnString('mail', this);
    username = _is.ColumnString('username', this);
    password = _is.ColumnString('password', this);
    host = _is.ColumnString('host', this);
    port = _is.ColumnInt('port', this);
    sslEnable = _is.ColumnBool('sslEnable', this);
    starttlsEnable = _is.ColumnBool('starttlsEnable', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final SysMailAccountUpdateTable updateTable;

  late final _is.ColumnString mail;

  late final _is.ColumnString username;

  late final _is.ColumnString password;

  late final _is.ColumnString host;

  late final _is.ColumnInt port;

  late final _is.ColumnBool sslEnable;

  late final _is.ColumnBool starttlsEnable;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    mail,
    username,
    password,
    host,
    port,
    sslEnable,
    starttlsEnable,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class SysMailAccountInclude extends _is.IncludeObject {
  SysMailAccountInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysMailAccount.t;
}

class SysMailAccountIncludeList extends _is.IncludeList {
  SysMailAccountIncludeList._({
    _is.WhereExpressionBuilder<SysMailAccountTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysMailAccount.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysMailAccount.t;
}

class SysMailAccountRepository {
  const SysMailAccountRepository._();

  /// Returns a list of [SysMailAccount]s matching the given query parameters.
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
  Future<List<SysMailAccount>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysMailAccountTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysMailAccountTable>? orderBy,
    _is.OrderByListBuilder<SysMailAccountTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysMailAccount>(
      where: where?.call(SysMailAccount.t),
      orderBy: orderBy?.call(SysMailAccount.t),
      orderByList: orderByList?.call(SysMailAccount.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysMailAccount] matching the given query parameters.
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
  Future<SysMailAccount?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysMailAccountTable>? where,
    int? offset,
    _is.OrderByBuilder<SysMailAccountTable>? orderBy,
    _is.OrderByListBuilder<SysMailAccountTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysMailAccount>(
      where: where?.call(SysMailAccount.t),
      orderBy: orderBy?.call(SysMailAccount.t),
      orderByList: orderByList?.call(SysMailAccount.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysMailAccount] by its [id] or null if no such row exists.
  Future<SysMailAccount?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysMailAccount>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysMailAccount]s in the list and returns the inserted rows.
  ///
  /// The returned [SysMailAccount]s will have their `id` fields set.
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
  Future<List<SysMailAccount>> insert(
    _is.DatabaseSession session,
    List<SysMailAccount> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysMailAccount>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysMailAccount] and returns the inserted row.
  ///
  /// The returned [SysMailAccount] will have its `id` field set.
  Future<SysMailAccount> insertRow(
    _is.DatabaseSession session,
    SysMailAccount row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysMailAccount>(row, transaction: transaction);
  }

  /// Upserts all [SysMailAccount]s in the list and returns the resulting rows.
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
  /// The returned [SysMailAccount]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysMailAccount>> upsert(
    _is.DatabaseSession session,
    List<SysMailAccount> rows, {
    required _is.ColumnSelections<SysMailAccountTable> conflictColumns,
    _is.ColumnSelections<SysMailAccountTable>? updateColumns,
    _is.WhereExpressionBuilder<SysMailAccountTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysMailAccount>(
      rows,
      conflictColumns: conflictColumns(SysMailAccount.t),
      updateColumns: updateColumns?.call(SysMailAccount.t),
      updateWhere: updateWhere?.call(SysMailAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysMailAccount] and returns the resulting row.
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
  /// The returned [SysMailAccount] will have its `id` field set.
  Future<SysMailAccount?> upsertRow(
    _is.DatabaseSession session,
    SysMailAccount row, {
    required _is.ColumnSelections<SysMailAccountTable> conflictColumns,
    _is.ColumnSelections<SysMailAccountTable>? updateColumns,
    _is.WhereExpressionBuilder<SysMailAccountTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysMailAccount>(
      row,
      conflictColumns: conflictColumns(SysMailAccount.t),
      updateColumns: updateColumns?.call(SysMailAccount.t),
      updateWhere: updateWhere?.call(SysMailAccount.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysMailAccount]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysMailAccount>> update(
    _is.DatabaseSession session,
    List<SysMailAccount> rows, {
    _is.ColumnSelections<SysMailAccountTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysMailAccount>(
      rows,
      columns: columns?.call(SysMailAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysMailAccount]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysMailAccount> updateRow(
    _is.DatabaseSession session,
    SysMailAccount row, {
    _is.ColumnSelections<SysMailAccountTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysMailAccount>(
      row,
      columns: columns?.call(SysMailAccount.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysMailAccount] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysMailAccount?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysMailAccountUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysMailAccount>(
      id,
      columnValues: columnValues(SysMailAccount.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysMailAccount]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysMailAccount>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysMailAccountUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysMailAccountTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysMailAccountTable>? orderBy,
    _is.OrderByListBuilder<SysMailAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysMailAccount>(
      columnValues: columnValues(SysMailAccount.t.updateTable),
      where: where(SysMailAccount.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysMailAccount.t),
      orderByList: orderByList?.call(SysMailAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysMailAccount]s in the list and returns the deleted rows.
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
  Future<List<SysMailAccount>> delete(
    _is.DatabaseSession session,
    List<SysMailAccount> rows, {
    _is.OrderByBuilder<SysMailAccountTable>? orderBy,
    _is.OrderByListBuilder<SysMailAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysMailAccount>(
      rows,
      orderBy: orderBy?.call(SysMailAccount.t),
      orderByList: orderByList?.call(SysMailAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysMailAccount].
  Future<SysMailAccount> deleteRow(
    _is.DatabaseSession session,
    SysMailAccount row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysMailAccount>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysMailAccount>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysMailAccountTable> where,
    _is.OrderByBuilder<SysMailAccountTable>? orderBy,
    _is.OrderByListBuilder<SysMailAccountTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysMailAccount>(
      where: where(SysMailAccount.t),
      orderBy: orderBy?.call(SysMailAccount.t),
      orderByList: orderByList?.call(SysMailAccount.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysMailAccountTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysMailAccount>(
      where: where?.call(SysMailAccount.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysMailAccount] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysMailAccountTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysMailAccount>(
      where: where(SysMailAccount.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
