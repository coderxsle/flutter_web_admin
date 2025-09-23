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

/// 社交用户表
abstract class SysSocialUser
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysSocialUser._({
    this.id,
    required this.tenantId,
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
  }) : createTime = createTime ?? DateTime.now();

  factory SysSocialUser({
    int? id,
    required int tenantId,
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
      tenantId: jsonSerialization['tenantId'] as int,
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
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
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
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysSocialUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
    _i1.WhereExpressionBuilder<SysSocialUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysSocialUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSocialUserTable>? orderByList,
    SysSocialUserInclude? include,
  }) {
    return SysSocialUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSocialUser.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysSocialUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysSocialUserImpl extends SysSocialUser {
  _SysSocialUserImpl({
    int? id,
    required int tenantId,
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
  @_i1.useResult
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

class SysSocialUserTable extends _i1.Table<int?> {
  SysSocialUserTable({super.tableRelation})
      : super(tableName: 'sys_social_user') {
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
    );
    type = _i1.ColumnInt(
      'type',
      this,
    );
    openid = _i1.ColumnString(
      'openid',
      this,
    );
    token = _i1.ColumnString(
      'token',
      this,
    );
    rawTokenInfo = _i1.ColumnString(
      'rawTokenInfo',
      this,
    );
    nickname = _i1.ColumnString(
      'nickname',
      this,
    );
    avatar = _i1.ColumnString(
      'avatar',
      this,
    );
    rawUserInfo = _i1.ColumnString(
      'rawUserInfo',
      this,
    );
    code = _i1.ColumnString(
      'code',
      this,
    );
    state = _i1.ColumnString(
      'state',
      this,
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
    deleted = _i1.ColumnBool(
      'deleted',
      this,
    );
  }

  late final _i1.ColumnInt tenantId;

  late final _i1.ColumnInt type;

  late final _i1.ColumnString openid;

  late final _i1.ColumnString token;

  late final _i1.ColumnString rawTokenInfo;

  late final _i1.ColumnString nickname;

  late final _i1.ColumnString avatar;

  late final _i1.ColumnString rawUserInfo;

  late final _i1.ColumnString code;

  late final _i1.ColumnString state;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
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

class SysSocialUserInclude extends _i1.IncludeObject {
  SysSocialUserInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysSocialUser.t;
}

class SysSocialUserIncludeList extends _i1.IncludeList {
  SysSocialUserIncludeList._({
    _i1.WhereExpressionBuilder<SysSocialUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysSocialUser.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysSocialUser.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSocialUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysSocialUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSocialUserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysSocialUser>(
      where: where?.call(SysSocialUser.t),
      orderBy: orderBy?.call(SysSocialUser.t),
      orderByList: orderByList?.call(SysSocialUser.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSocialUserTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysSocialUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSocialUserTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysSocialUser>(
      where: where?.call(SysSocialUser.t),
      orderBy: orderBy?.call(SysSocialUser.t),
      orderByList: orderByList?.call(SysSocialUser.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysSocialUser] by its [id] or null if no such row exists.
  Future<SysSocialUser?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysSocialUser>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysSocialUser]s in the list and returns the inserted rows.
  ///
  /// The returned [SysSocialUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysSocialUser>> insert(
    _i1.Session session,
    List<SysSocialUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysSocialUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysSocialUser] and returns the inserted row.
  ///
  /// The returned [SysSocialUser] will have its `id` field set.
  Future<SysSocialUser> insertRow(
    _i1.Session session,
    SysSocialUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysSocialUser>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysSocialUser]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysSocialUser>> update(
    _i1.Session session,
    List<SysSocialUser> rows, {
    _i1.ColumnSelections<SysSocialUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysSocialUser>(
      rows,
      columns: columns?.call(SysSocialUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysSocialUser]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysSocialUser> updateRow(
    _i1.Session session,
    SysSocialUser row, {
    _i1.ColumnSelections<SysSocialUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysSocialUser>(
      row,
      columns: columns?.call(SysSocialUser.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysSocialUser]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysSocialUser>> delete(
    _i1.Session session,
    List<SysSocialUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysSocialUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysSocialUser].
  Future<SysSocialUser> deleteRow(
    _i1.Session session,
    SysSocialUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysSocialUser>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysSocialUser>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysSocialUserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysSocialUser>(
      where: where(SysSocialUser.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSocialUserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysSocialUser>(
      where: where?.call(SysSocialUser.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
