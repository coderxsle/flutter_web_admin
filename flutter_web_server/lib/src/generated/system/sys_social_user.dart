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

/// 社交用户表
abstract class SysSocialUser
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysSocialUser._({
    this.id,
    int? tenantId,
    required this.type,
    required this.openid,
    this.token,
    required this.rawTokenInfo,
    required this.nickname,
    this.avatar,
    required this.rawUserInfo,
    required this.code,
    this.state,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : tenantId = tenantId ?? 0,
       createTime = createTime ?? DateTime.now();

  factory SysSocialUser({
    int? id,
    int? tenantId,
    required int type,
    required String openid,
    String? token,
    required String rawTokenInfo,
    required String nickname,
    String? avatar,
    required String rawUserInfo,
    required String code,
    String? state,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysSocialUserImpl;

  factory SysSocialUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysSocialUser(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      type: jsonSerialization['type'] as int,
      openid: jsonSerialization['openid'] as String,
      token: jsonSerialization['token'] as String?,
      rawTokenInfo: jsonSerialization['rawTokenInfo'] as String,
      nickname: jsonSerialization['nickname'] as String,
      avatar: jsonSerialization['avatar'] as String?,
      rawUserInfo: jsonSerialization['rawUserInfo'] as String,
      code: jsonSerialization['code'] as String,
      state: jsonSerialization['state'] as String?,
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

  static final t = SysSocialUserTable();

  static const db = SysSocialUserRepository._();

  @override
  int? id;

  int tenantId;

  int type;

  String openid;

  String? token;

  String rawTokenInfo;

  String nickname;

  String? avatar;

  String rawUserInfo;

  String code;

  String? state;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysSocialUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysSocialUser copyWith({
    int? id,
    int? tenantId,
    int? type,
    String? openid,
    String? token,
    String? rawTokenInfo,
    String? nickname,
    String? avatar,
    String? rawUserInfo,
    String? code,
    String? state,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysSocialUser',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'type': type,
      'openid': openid,
      if (token != null) 'token': token,
      'rawTokenInfo': rawTokenInfo,
      'nickname': nickname,
      if (avatar != null) 'avatar': avatar,
      'rawUserInfo': rawUserInfo,
      'code': code,
      if (state != null) 'state': state,
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
      '__className__': 'SysSocialUser',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'type': type,
      'openid': openid,
      if (token != null) 'token': token,
      'rawTokenInfo': rawTokenInfo,
      'nickname': nickname,
      if (avatar != null) 'avatar': avatar,
      'rawUserInfo': rawUserInfo,
      'code': code,
      if (state != null) 'state': state,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysSocialUserInclude include() {
    return SysSocialUserInclude._();
  }

  static SysSocialUserIncludeList includeList({
    _is.WhereExpressionBuilder<SysSocialUserTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSocialUserTable>? orderBy,
    _is.OrderByListBuilder<SysSocialUserTable>? orderByList,
    SysSocialUserInclude? include,
  }) {
    return SysSocialUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSocialUser.t),
      orderByList: orderByList?.call(SysSocialUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysSocialUserImpl extends SysSocialUser {
  _SysSocialUserImpl({
    int? id,
    int? tenantId,
    required int type,
    required String openid,
    String? token,
    required String rawTokenInfo,
    required String nickname,
    String? avatar,
    required String rawUserInfo,
    required String code,
    String? state,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         type: type,
         openid: openid,
         token: token,
         rawTokenInfo: rawTokenInfo,
         nickname: nickname,
         avatar: avatar,
         rawUserInfo: rawUserInfo,
         code: code,
         state: state,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [SysSocialUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysSocialUser copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? type,
    String? openid,
    Object? token = _Undefined,
    String? rawTokenInfo,
    String? nickname,
    Object? avatar = _Undefined,
    String? rawUserInfo,
    String? code,
    Object? state = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysSocialUser(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      type: type ?? this.type,
      openid: openid ?? this.openid,
      token: token is String? ? token : this.token,
      rawTokenInfo: rawTokenInfo ?? this.rawTokenInfo,
      nickname: nickname ?? this.nickname,
      avatar: avatar is String? ? avatar : this.avatar,
      rawUserInfo: rawUserInfo ?? this.rawUserInfo,
      code: code ?? this.code,
      state: state is String? ? state : this.state,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysSocialUserUpdateTable extends _is.UpdateTable<SysSocialUserTable> {
  SysSocialUserUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> type(int value) =>
      _is.ColumnValue(table.type, value);

  _is.ColumnValue<String, String> openid(String value) =>
      _is.ColumnValue(table.openid, value);

  _is.ColumnValue<String, String> token(String? value) =>
      _is.ColumnValue(table.token, value);

  _is.ColumnValue<String, String> rawTokenInfo(String value) =>
      _is.ColumnValue(table.rawTokenInfo, value);

  _is.ColumnValue<String, String> nickname(String value) =>
      _is.ColumnValue(table.nickname, value);

  _is.ColumnValue<String, String> avatar(String? value) =>
      _is.ColumnValue(table.avatar, value);

  _is.ColumnValue<String, String> rawUserInfo(String value) =>
      _is.ColumnValue(table.rawUserInfo, value);

  _is.ColumnValue<String, String> code(String value) =>
      _is.ColumnValue(table.code, value);

  _is.ColumnValue<String, String> state(String? value) =>
      _is.ColumnValue(table.state, value);

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

class SysSocialUserTable extends _is.Table<int?> {
  SysSocialUserTable({super.tableRelation})
    : super(tableName: 'sys_social_user') {
    updateTable = SysSocialUserUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    type = _is.ColumnInt('type', this);
    openid = _is.ColumnString('openid', this);
    token = _is.ColumnString('token', this);
    rawTokenInfo = _is.ColumnString('rawTokenInfo', this);
    nickname = _is.ColumnString('nickname', this);
    avatar = _is.ColumnString('avatar', this);
    rawUserInfo = _is.ColumnString('rawUserInfo', this);
    code = _is.ColumnString('code', this);
    state = _is.ColumnString('state', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final SysSocialUserUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnInt type;

  late final _is.ColumnString openid;

  late final _is.ColumnString token;

  late final _is.ColumnString rawTokenInfo;

  late final _is.ColumnString nickname;

  late final _is.ColumnString avatar;

  late final _is.ColumnString rawUserInfo;

  late final _is.ColumnString code;

  late final _is.ColumnString state;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    type,
    openid,
    token,
    rawTokenInfo,
    nickname,
    avatar,
    rawUserInfo,
    code,
    state,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class SysSocialUserInclude extends _is.IncludeObject {
  SysSocialUserInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysSocialUser.t;
}

class SysSocialUserIncludeList extends _is.IncludeList {
  SysSocialUserIncludeList._({
    _is.WhereExpressionBuilder<SysSocialUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysSocialUser.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysSocialUser.t;
}

class SysSocialUserRepository {
  const SysSocialUserRepository._();

  /// Returns a list of [SysSocialUser]s matching the given query parameters.
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
  Future<List<SysSocialUser>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSocialUserTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSocialUserTable>? orderBy,
    _is.OrderByListBuilder<SysSocialUserTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysSocialUser>(
      where: where?.call(SysSocialUser.t),
      orderBy: orderBy?.call(SysSocialUser.t),
      orderByList: orderByList?.call(SysSocialUser.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysSocialUser] matching the given query parameters.
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
  Future<SysSocialUser?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSocialUserTable>? where,
    int? offset,
    _is.OrderByBuilder<SysSocialUserTable>? orderBy,
    _is.OrderByListBuilder<SysSocialUserTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysSocialUser>(
      where: where?.call(SysSocialUser.t),
      orderBy: orderBy?.call(SysSocialUser.t),
      orderByList: orderByList?.call(SysSocialUser.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysSocialUser] by its [id] or null if no such row exists.
  Future<SysSocialUser?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysSocialUser>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysSocialUser]s in the list and returns the inserted rows.
  ///
  /// The returned [SysSocialUser]s will have their `id` fields set.
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
  Future<List<SysSocialUser>> insert(
    _is.DatabaseSession session,
    List<SysSocialUser> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysSocialUser>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysSocialUser] and returns the inserted row.
  ///
  /// The returned [SysSocialUser] will have its `id` field set.
  Future<SysSocialUser> insertRow(
    _is.DatabaseSession session,
    SysSocialUser row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysSocialUser>(row, transaction: transaction);
  }

  /// Upserts all [SysSocialUser]s in the list and returns the resulting rows.
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
  /// The returned [SysSocialUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSocialUser>> upsert(
    _is.DatabaseSession session,
    List<SysSocialUser> rows, {
    required _is.ColumnSelections<SysSocialUserTable> conflictColumns,
    _is.ColumnSelections<SysSocialUserTable>? updateColumns,
    _is.WhereExpressionBuilder<SysSocialUserTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysSocialUser>(
      rows,
      conflictColumns: conflictColumns(SysSocialUser.t),
      updateColumns: updateColumns?.call(SysSocialUser.t),
      updateWhere: updateWhere?.call(SysSocialUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysSocialUser] and returns the resulting row.
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
  /// The returned [SysSocialUser] will have its `id` field set.
  Future<SysSocialUser?> upsertRow(
    _is.DatabaseSession session,
    SysSocialUser row, {
    required _is.ColumnSelections<SysSocialUserTable> conflictColumns,
    _is.ColumnSelections<SysSocialUserTable>? updateColumns,
    _is.WhereExpressionBuilder<SysSocialUserTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysSocialUser>(
      row,
      conflictColumns: conflictColumns(SysSocialUser.t),
      updateColumns: updateColumns?.call(SysSocialUser.t),
      updateWhere: updateWhere?.call(SysSocialUser.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysSocialUser]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSocialUser>> update(
    _is.DatabaseSession session,
    List<SysSocialUser> rows, {
    _is.ColumnSelections<SysSocialUserTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysSocialUser>(
      rows,
      columns: columns?.call(SysSocialUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysSocialUser]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysSocialUser> updateRow(
    _is.DatabaseSession session,
    SysSocialUser row, {
    _is.ColumnSelections<SysSocialUserTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysSocialUser>(
      row,
      columns: columns?.call(SysSocialUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysSocialUser] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysSocialUser?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysSocialUserUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysSocialUser>(
      id,
      columnValues: columnValues(SysSocialUser.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysSocialUser]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSocialUser>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysSocialUserUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysSocialUserTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSocialUserTable>? orderBy,
    _is.OrderByListBuilder<SysSocialUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysSocialUser>(
      columnValues: columnValues(SysSocialUser.t.updateTable),
      where: where(SysSocialUser.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSocialUser.t),
      orderByList: orderByList?.call(SysSocialUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysSocialUser]s in the list and returns the deleted rows.
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
  Future<List<SysSocialUser>> delete(
    _is.DatabaseSession session,
    List<SysSocialUser> rows, {
    _is.OrderByBuilder<SysSocialUserTable>? orderBy,
    _is.OrderByListBuilder<SysSocialUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysSocialUser>(
      rows,
      orderBy: orderBy?.call(SysSocialUser.t),
      orderByList: orderByList?.call(SysSocialUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysSocialUser].
  Future<SysSocialUser> deleteRow(
    _is.DatabaseSession session,
    SysSocialUser row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysSocialUser>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSocialUser>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysSocialUserTable> where,
    _is.OrderByBuilder<SysSocialUserTable>? orderBy,
    _is.OrderByListBuilder<SysSocialUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysSocialUser>(
      where: where(SysSocialUser.t),
      orderBy: orderBy?.call(SysSocialUser.t),
      orderByList: orderByList?.call(SysSocialUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSocialUserTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysSocialUser>(
      where: where?.call(SysSocialUser.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysSocialUser] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysSocialUserTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysSocialUser>(
      where: where(SysSocialUser.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
