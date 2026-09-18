/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: dead_code, unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_web_server/src/generated/protocol.dart' as _ii4hkddg;
import 'package:serverpod/serverpod.dart' as _is;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _iacs;

/// 用户信息表
abstract class SysUser
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysUser._({
    this.id,
    int? tenantId,
    this.deptId,
    this.postIds,
    required this.username,
    this.password,
    this.authUserId,
    this.authUser,
    required this.nickname,
    this.phone,
    int? gender,
    this.email,
    this.avatar,
    this.description,
    int? status,
    int? type,
    bool? isSuperuser,
    bool? deleted,
    this.loginIp,
    this.loginTime,
    this.updater,
    this.updateTime,
    this.creator,
    DateTime? createTime,
  }) : tenantId = tenantId ?? 0,
       gender = gender ?? 3,
       status = status ?? 1,
       type = type ?? 2,
       isSuperuser = isSuperuser ?? false,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now();

  factory SysUser({
    int? id,
    int? tenantId,
    int? deptId,
    List<int>? postIds,
    required String username,
    String? password,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    required String nickname,
    String? phone,
    int? gender,
    String? email,
    String? avatar,
    String? description,
    int? status,
    int? type,
    bool? isSuperuser,
    bool? deleted,
    String? loginIp,
    DateTime? loginTime,
    String? updater,
    DateTime? updateTime,
    String? creator,
    DateTime? createTime,
  }) = _SysUserImpl;

  factory SysUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysUser(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      deptId: jsonSerialization['deptId'] as int?,
      postIds: jsonSerialization['postIds'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<List<int>>(
              jsonSerialization['postIds'],
            ),
      username: jsonSerialization['username'] as String,
      password: jsonSerialization['password'] as String?,
      authUserId: jsonSerialization['authUserId'] == null
          ? null
          : _is.UuidValueJsonExtension.fromJson(
              jsonSerialization['authUserId'],
            ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<_iacs.AuthUser>(
              jsonSerialization['authUser'],
            ),
      nickname: jsonSerialization['nickname'] as String,
      phone: jsonSerialization['phone'] as String?,
      gender: jsonSerialization['gender'] as int?,
      email: jsonSerialization['email'] as String?,
      avatar: jsonSerialization['avatar'] as String?,
      description: jsonSerialization['description'] as String?,
      status: jsonSerialization['status'] as int?,
      type: jsonSerialization['type'] as int?,
      isSuperuser: jsonSerialization['isSuperuser'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isSuperuser']),
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      loginIp: jsonSerialization['loginIp'] as String?,
      loginTime: jsonSerialization['loginTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['loginTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
    );
  }

  static final t = SysUserTable();

  static const db = SysUserRepository._();

  @override
  int? id;

  int tenantId;

  int? deptId;

  List<int>? postIds;

  String username;

  String? password;

  _is.UuidValue? authUserId;

  _iacs.AuthUser? authUser;

  String nickname;

  String? phone;

  int? gender;

  String? email;

  String? avatar;

  String? description;

  int? status;

  int type;

  bool isSuperuser;

  bool deleted;

  String? loginIp;

  DateTime? loginTime;

  String? updater;

  DateTime? updateTime;

  String? creator;

  DateTime createTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysUser copyWith({
    int? id,
    int? tenantId,
    int? deptId,
    List<int>? postIds,
    String? username,
    String? password,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    String? nickname,
    String? phone,
    int? gender,
    String? email,
    String? avatar,
    String? description,
    int? status,
    int? type,
    bool? isSuperuser,
    bool? deleted,
    String? loginIp,
    DateTime? loginTime,
    String? updater,
    DateTime? updateTime,
    String? creator,
    DateTime? createTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysUser',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (deptId != null) 'deptId': deptId,
      if (postIds != null) 'postIds': postIds?.toJson(),
      'username': username,
      if (password != null) 'password': password,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'nickname': nickname,
      if (phone != null) 'phone': phone,
      if (gender != null) 'gender': gender,
      if (email != null) 'email': email,
      if (avatar != null) 'avatar': avatar,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      'type': type,
      'isSuperuser': isSuperuser,
      'deleted': deleted,
      if (loginIp != null) 'loginIp': loginIp,
      if (loginTime != null) 'loginTime': loginTime?.toJson(),
      if (updater != null) 'updater': updater,
      if (updateTime != null) 'updateTime': updateTime?.toJson(),
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'SysUser',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (deptId != null) 'deptId': deptId,
      if (postIds != null) 'postIds': postIds?.toJson(),
      'username': username,
      if (authUserId != null) 'authUserId': authUserId?.toJson(),
      if (authUser != null) 'authUser': authUser?.toJson(),
      'nickname': nickname,
      if (phone != null) 'phone': phone,
      if (gender != null) 'gender': gender,
      if (email != null) 'email': email,
      if (avatar != null) 'avatar': avatar,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      'type': type,
      'isSuperuser': isSuperuser,
      'deleted': deleted,
      if (loginIp != null) 'loginIp': loginIp,
      if (loginTime != null) 'loginTime': loginTime?.toJson(),
      if (updater != null) 'updater': updater,
      if (updateTime != null) 'updateTime': updateTime?.toJson(),
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
    };
  }

  static SysUserInclude include({_iacs.AuthUserInclude? authUser}) {
    return SysUserInclude._(authUser: authUser);
  }

  static SysUserIncludeList includeList({
    _is.WhereExpressionBuilder<SysUserTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysUserTable>? orderBy,
    _is.OrderByListBuilder<SysUserTable>? orderByList,
    SysUserInclude? include,
  }) {
    return SysUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysUser.t),
      orderByList: orderByList?.call(SysUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysUserImpl extends SysUser {
  _SysUserImpl({
    int? id,
    int? tenantId,
    int? deptId,
    List<int>? postIds,
    required String username,
    String? password,
    _is.UuidValue? authUserId,
    _iacs.AuthUser? authUser,
    required String nickname,
    String? phone,
    int? gender,
    String? email,
    String? avatar,
    String? description,
    int? status,
    int? type,
    bool? isSuperuser,
    bool? deleted,
    String? loginIp,
    DateTime? loginTime,
    String? updater,
    DateTime? updateTime,
    String? creator,
    DateTime? createTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         deptId: deptId,
         postIds: postIds,
         username: username,
         password: password,
         authUserId: authUserId,
         authUser: authUser,
         nickname: nickname,
         phone: phone,
         gender: gender,
         email: email,
         avatar: avatar,
         description: description,
         status: status,
         type: type,
         isSuperuser: isSuperuser,
         deleted: deleted,
         loginIp: loginIp,
         loginTime: loginTime,
         updater: updater,
         updateTime: updateTime,
         creator: creator,
         createTime: createTime,
       );

  /// Returns a shallow copy of this [SysUser]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysUser copyWith({
    Object? id = _Undefined,
    int? tenantId,
    Object? deptId = _Undefined,
    Object? postIds = _Undefined,
    String? username,
    Object? password = _Undefined,
    Object? authUserId = _Undefined,
    Object? authUser = _Undefined,
    String? nickname,
    Object? phone = _Undefined,
    Object? gender = _Undefined,
    Object? email = _Undefined,
    Object? avatar = _Undefined,
    Object? description = _Undefined,
    Object? status = _Undefined,
    int? type,
    bool? isSuperuser,
    bool? deleted,
    Object? loginIp = _Undefined,
    Object? loginTime = _Undefined,
    Object? updater = _Undefined,
    Object? updateTime = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
  }) {
    return SysUser(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      deptId: deptId is int? ? deptId : this.deptId,
      postIds: postIds is List<int>?
          ? postIds
          : this.postIds?.map((e0) => e0).toList(),
      username: username ?? this.username,
      password: password is String? ? password : this.password,
      authUserId: authUserId is _is.UuidValue? ? authUserId : this.authUserId,
      authUser: authUser is _iacs.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      nickname: nickname ?? this.nickname,
      phone: phone is String? ? phone : this.phone,
      gender: gender is int? ? gender : this.gender,
      email: email is String? ? email : this.email,
      avatar: avatar is String? ? avatar : this.avatar,
      description: description is String? ? description : this.description,
      status: status is int? ? status : this.status,
      type: type ?? this.type,
      isSuperuser: isSuperuser ?? this.isSuperuser,
      deleted: deleted ?? this.deleted,
      loginIp: loginIp is String? ? loginIp : this.loginIp,
      loginTime: loginTime is DateTime? ? loginTime : this.loginTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime is DateTime? ? updateTime : this.updateTime,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
    );
  }
}

class SysUserUpdateTable extends _is.UpdateTable<SysUserTable> {
  SysUserUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) =>
      _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> deptId(int? value) =>
      _is.ColumnValue(table.deptId, value);

  _is.ColumnValue<List<int>, List<int>> postIds(List<int>? value) =>
      _is.ColumnValue(table.postIds, value);

  _is.ColumnValue<String, String> username(String value) =>
      _is.ColumnValue(table.username, value);

  _is.ColumnValue<String, String> password(String? value) =>
      _is.ColumnValue(table.password, value);

  _is.ColumnValue<_is.UuidValue, _is.UuidValue> authUserId(
    _is.UuidValue? value,
  ) => _is.ColumnValue(table.authUserId, value);

  _is.ColumnValue<String, String> nickname(String value) =>
      _is.ColumnValue(table.nickname, value);

  _is.ColumnValue<String, String> phone(String? value) =>
      _is.ColumnValue(table.phone, value);

  _is.ColumnValue<int, int> gender(int? value) =>
      _is.ColumnValue(table.gender, value);

  _is.ColumnValue<String, String> email(String? value) =>
      _is.ColumnValue(table.email, value);

  _is.ColumnValue<String, String> avatar(String? value) =>
      _is.ColumnValue(table.avatar, value);

  _is.ColumnValue<String, String> description(String? value) =>
      _is.ColumnValue(table.description, value);

  _is.ColumnValue<int, int> status(int? value) =>
      _is.ColumnValue(table.status, value);

  _is.ColumnValue<bool, bool> isSuperuser(bool value) =>
      _is.ColumnValue(table.isSuperuser, value);

  _is.ColumnValue<bool, bool> deleted(bool value) =>
      _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> loginIp(String? value) =>
      _is.ColumnValue(table.loginIp, value);

  _is.ColumnValue<DateTime, DateTime> loginTime(DateTime? value) =>
      _is.ColumnValue(table.loginTime, value);

  _is.ColumnValue<String, String> updater(String? value) =>
      _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime? value) =>
      _is.ColumnValue(table.updateTime, value);

  _is.ColumnValue<String, String> creator(String? value) =>
      _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);
}

class SysUserTable extends _is.Table<int?> {
  SysUserTable({super.tableRelation}) : super(tableName: 'sys_user') {
    updateTable = SysUserUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    deptId = _is.ColumnInt('deptId', this);
    postIds = _is.ColumnSerializable<List<int>>('postIds', this);
    username = _is.ColumnString('username', this);
    password = _is.ColumnString('password', this);
    authUserId = _is.ColumnUuid('authUserId', this);
    nickname = _is.ColumnString('nickname', this);
    phone = _is.ColumnString('phone', this);
    gender = _is.ColumnInt('gender', this, hasDefault: true);
    email = _is.ColumnString('email', this);
    avatar = _is.ColumnString('avatar', this);
    description = _is.ColumnString('description', this);
    status = _is.ColumnInt('status', this, hasDefault: true);
    isSuperuser = _is.ColumnBool('isSuperuser', this, hasDefault: true);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    loginIp = _is.ColumnString('loginIp', this);
    loginTime = _is.ColumnDateTime('loginTime', this);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
  }

  late final SysUserUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnInt deptId;

  late final _is.ColumnSerializable<List<int>> postIds;

  late final _is.ColumnString username;

  late final _is.ColumnString password;

  late final _is.ColumnUuid authUserId;

  _iacs.AuthUserTable? _authUser;

  late final _is.ColumnString nickname;

  late final _is.ColumnString phone;

  late final _is.ColumnInt gender;

  late final _is.ColumnString email;

  late final _is.ColumnString avatar;

  late final _is.ColumnString description;

  late final _is.ColumnInt status;

  late final _is.ColumnBool isSuperuser;

  late final _is.ColumnBool deleted;

  late final _is.ColumnString loginIp;

  late final _is.ColumnDateTime loginTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  _iacs.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _is.createRelationTable(
      relationFieldName: 'authUser',
      field: SysUser.t.authUserId,
      foreignField: _iacs.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _iacs.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    deptId,
    postIds,
    username,
    password,
    authUserId,
    nickname,
    phone,
    gender,
    email,
    avatar,
    description,
    status,
    isSuperuser,
    deleted,
    loginIp,
    loginTime,
    updater,
    updateTime,
    creator,
    createTime,
  ];

  @override
  _is.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class SysUserInclude extends _is.IncludeObject {
  SysUserInclude._({_iacs.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _iacs.AuthUserInclude? _authUser;

  @override
  Map<String, _is.Include?> get includes => {'authUser': _authUser};

  @override
  _is.Table<int?> get table => SysUser.t;
}

class SysUserIncludeList extends _is.IncludeList {
  SysUserIncludeList._({
    _is.WhereExpressionBuilder<SysUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysUser.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysUser.t;
}

class SysUserRepository {
  const SysUserRepository._();

  final attachRow = const SysUserAttachRowRepository._();

  final detachRow = const SysUserDetachRowRepository._();

  /// Returns a list of [SysUser]s matching the given query parameters.
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
  Future<List<SysUser>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysUserTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysUserTable>? orderBy,
    _is.OrderByListBuilder<SysUserTable>? orderByList,
    _is.Transaction? transaction,
    SysUserInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysUser>(
      where: where?.call(SysUser.t),
      orderBy: orderBy?.call(SysUser.t),
      orderByList: orderByList?.call(SysUser.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysUser] matching the given query parameters.
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
  Future<SysUser?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysUserTable>? where,
    int? offset,
    _is.OrderByBuilder<SysUserTable>? orderBy,
    _is.OrderByListBuilder<SysUserTable>? orderByList,
    _is.Transaction? transaction,
    SysUserInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysUser>(
      where: where?.call(SysUser.t),
      orderBy: orderBy?.call(SysUser.t),
      orderByList: orderByList?.call(SysUser.t),
      offset: offset,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysUser] by its [id] or null if no such row exists.
  Future<SysUser?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    SysUserInclude? include,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysUser>(
      id,
      transaction: transaction,
      include: include,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysUser]s in the list and returns the inserted rows.
  ///
  /// The returned [SysUser]s will have their `id` fields set.
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
  Future<List<SysUser>> insert(
    _is.DatabaseSession session,
    List<SysUser> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysUser>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysUser] and returns the inserted row.
  ///
  /// The returned [SysUser] will have its `id` field set.
  Future<SysUser> insertRow(
    _is.DatabaseSession session,
    SysUser row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysUser>(row, transaction: transaction);
  }

  /// Upserts all [SysUser]s in the list and returns the resulting rows.
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
  /// The returned [SysUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysUser>> upsert(
    _is.DatabaseSession session,
    List<SysUser> rows, {
    required _is.ColumnSelections<SysUserTable> conflictColumns,
    _is.ColumnSelections<SysUserTable>? updateColumns,
    _is.WhereExpressionBuilder<SysUserTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysUser>(
      rows,
      conflictColumns: conflictColumns(SysUser.t),
      updateColumns: updateColumns?.call(SysUser.t),
      updateWhere: updateWhere?.call(SysUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysUser] and returns the resulting row.
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
  /// The returned [SysUser] will have its `id` field set.
  Future<SysUser?> upsertRow(
    _is.DatabaseSession session,
    SysUser row, {
    required _is.ColumnSelections<SysUserTable> conflictColumns,
    _is.ColumnSelections<SysUserTable>? updateColumns,
    _is.WhereExpressionBuilder<SysUserTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysUser>(
      row,
      conflictColumns: conflictColumns(SysUser.t),
      updateColumns: updateColumns?.call(SysUser.t),
      updateWhere: updateWhere?.call(SysUser.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysUser]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysUser>> update(
    _is.DatabaseSession session,
    List<SysUser> rows, {
    _is.ColumnSelections<SysUserTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysUser>(
      rows,
      columns: columns?.call(SysUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysUser]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysUser> updateRow(
    _is.DatabaseSession session,
    SysUser row, {
    _is.ColumnSelections<SysUserTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysUser>(
      row,
      columns: columns?.call(SysUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysUser] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysUser?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysUserUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysUser>(
      id,
      columnValues: columnValues(SysUser.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysUser]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysUser>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysUserUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysUserTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysUserTable>? orderBy,
    _is.OrderByListBuilder<SysUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysUser>(
      columnValues: columnValues(SysUser.t.updateTable),
      where: where(SysUser.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysUser.t),
      orderByList: orderByList?.call(SysUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysUser]s in the list and returns the deleted rows.
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
  Future<List<SysUser>> delete(
    _is.DatabaseSession session,
    List<SysUser> rows, {
    _is.OrderByBuilder<SysUserTable>? orderBy,
    _is.OrderByListBuilder<SysUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysUser>(
      rows,
      orderBy: orderBy?.call(SysUser.t),
      orderByList: orderByList?.call(SysUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysUser].
  Future<SysUser> deleteRow(
    _is.DatabaseSession session,
    SysUser row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysUser>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysUser>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysUserTable> where,
    _is.OrderByBuilder<SysUserTable>? orderBy,
    _is.OrderByListBuilder<SysUserTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysUser>(
      where: where(SysUser.t),
      orderBy: orderBy?.call(SysUser.t),
      orderByList: orderByList?.call(SysUser.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysUserTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysUser>(
      where: where?.call(SysUser.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysUser] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysUserTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysUser>(
      where: where(SysUser.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}

class SysUserAttachRowRepository {
  const SysUserAttachRowRepository._();

  /// Creates a relation between the given [SysUser] and [AuthUser]
  /// by setting the [SysUser]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _is.DatabaseSession session,
    SysUser sysUser,
    _iacs.AuthUser authUser, {
    _is.Transaction? transaction,
  }) async {
    if (sysUser.id == null) {
      throw ArgumentError.notNull('sysUser.id');
    }
    if (authUser.id == null) {
      throw ArgumentError.notNull('authUser.id');
    }

    var $sysUser = sysUser.copyWith(authUserId: authUser.id);
    await session.db.updateRow<SysUser>(
      $sysUser,
      columns: [SysUser.t.authUserId],
      transaction: transaction,
    );
  }
}

class SysUserDetachRowRepository {
  const SysUserDetachRowRepository._();

  /// Detaches the relation between this [SysUser] and the [AuthUser] set in `authUser`
  /// by setting the [SysUser]'s foreign key `authUserId` to `null`.
  ///
  /// This removes the association between the two models without deleting
  /// the related record.
  Future<void> authUser(
    _is.DatabaseSession session,
    SysUser sysUser, {
    _is.Transaction? transaction,
  }) async {
    if (sysUser.id == null) {
      throw ArgumentError.notNull('sysUser.id');
    }

    var $sysUser = sysUser.copyWith(authUserId: null);
    await session.db.updateRow<SysUser>(
      $sysUser,
      columns: [SysUser.t.authUserId],
      transaction: transaction,
    );
  }
}
