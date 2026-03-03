/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: unnecessary_null_comparison

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import 'package:serverpod_auth_core_server/serverpod_auth_core_server.dart'
    as _i2;
import 'package:flutter_web_server/src/generated/protocol.dart' as _i3;

/// 用户信息表
abstract class SysUser
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
    this.remark,
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
    _i1.UuidValue? authUserId,
    _i2.AuthUser? authUser,
    required String nickname,
    String? phone,
    int? gender,
    String? email,
    String? avatar,
    String? remark,
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
          : _i3.Protocol().deserialize<List<int>>(jsonSerialization['postIds']),
      username: jsonSerialization['username'] as String,
      password: jsonSerialization['password'] as String?,
      authUserId: jsonSerialization['authUserId'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(
              jsonSerialization['authUserId'],
            ),
      authUser: jsonSerialization['authUser'] == null
          ? null
          : _i3.Protocol().deserialize<_i2.AuthUser>(
              jsonSerialization['authUser'],
            ),
      nickname: jsonSerialization['nickname'] as String,
      phone: jsonSerialization['phone'] as String?,
      gender: jsonSerialization['gender'] as int?,
      email: jsonSerialization['email'] as String?,
      avatar: jsonSerialization['avatar'] as String?,
      remark: jsonSerialization['remark'] as String?,
      status: jsonSerialization['status'] as int?,
      type: jsonSerialization['type'] as int?,
      isSuperuser: jsonSerialization['isSuperuser'] as bool?,
      deleted: jsonSerialization['deleted'] as bool?,
      loginIp: jsonSerialization['loginIp'] as String?,
      loginTime: jsonSerialization['loginTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['loginTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
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

  _i1.UuidValue? authUserId;

  _i2.AuthUser? authUser;

  String nickname;

  String? phone;

  int? gender;

  String? email;

  String? avatar;

  String? remark;

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
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysUser copyWith({
    int? id,
    int? tenantId,
    int? deptId,
    List<int>? postIds,
    String? username,
    String? password,
    _i1.UuidValue? authUserId,
    _i2.AuthUser? authUser,
    String? nickname,
    String? phone,
    int? gender,
    String? email,
    String? avatar,
    String? remark,
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
      if (remark != null) 'remark': remark,
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
      if (authUser != null) 'authUser': authUser?.toJsonForProtocol(),
      'nickname': nickname,
      if (phone != null) 'phone': phone,
      if (gender != null) 'gender': gender,
      if (email != null) 'email': email,
      if (avatar != null) 'avatar': avatar,
      if (remark != null) 'remark': remark,
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

  static SysUserInclude include({_i2.AuthUserInclude? authUser}) {
    return SysUserInclude._(authUser: authUser);
  }

  static SysUserIncludeList includeList({
    _i1.WhereExpressionBuilder<SysUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysUserTable>? orderByList,
    SysUserInclude? include,
  }) {
    return SysUserIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysUser.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysUser.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
    _i1.UuidValue? authUserId,
    _i2.AuthUser? authUser,
    required String nickname,
    String? phone,
    int? gender,
    String? email,
    String? avatar,
    String? remark,
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
         remark: remark,
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
  @_i1.useResult
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
    Object? remark = _Undefined,
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
      authUserId: authUserId is _i1.UuidValue? ? authUserId : this.authUserId,
      authUser: authUser is _i2.AuthUser?
          ? authUser
          : this.authUser?.copyWith(),
      nickname: nickname ?? this.nickname,
      phone: phone is String? ? phone : this.phone,
      gender: gender is int? ? gender : this.gender,
      email: email is String? ? email : this.email,
      avatar: avatar is String? ? avatar : this.avatar,
      remark: remark is String? ? remark : this.remark,
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

class SysUserUpdateTable extends _i1.UpdateTable<SysUserTable> {
  SysUserUpdateTable(super.table);

  _i1.ColumnValue<int, int> tenantId(int value) => _i1.ColumnValue(
    table.tenantId,
    value,
  );

  _i1.ColumnValue<int, int> deptId(int? value) => _i1.ColumnValue(
    table.deptId,
    value,
  );

  _i1.ColumnValue<List<int>, List<int>> postIds(List<int>? value) =>
      _i1.ColumnValue(
        table.postIds,
        value,
      );

  _i1.ColumnValue<String, String> username(String value) => _i1.ColumnValue(
    table.username,
    value,
  );

  _i1.ColumnValue<String, String> password(String? value) => _i1.ColumnValue(
    table.password,
    value,
  );

  _i1.ColumnValue<_i1.UuidValue, _i1.UuidValue> authUserId(
    _i1.UuidValue? value,
  ) => _i1.ColumnValue(
    table.authUserId,
    value,
  );

  _i1.ColumnValue<String, String> nickname(String value) => _i1.ColumnValue(
    table.nickname,
    value,
  );

  _i1.ColumnValue<String, String> phone(String? value) => _i1.ColumnValue(
    table.phone,
    value,
  );

  _i1.ColumnValue<int, int> gender(int? value) => _i1.ColumnValue(
    table.gender,
    value,
  );

  _i1.ColumnValue<String, String> email(String? value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<String, String> avatar(String? value) => _i1.ColumnValue(
    table.avatar,
    value,
  );

  _i1.ColumnValue<String, String> remark(String? value) => _i1.ColumnValue(
    table.remark,
    value,
  );

  _i1.ColumnValue<int, int> status(int? value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<bool, bool> isSuperuser(bool value) => _i1.ColumnValue(
    table.isSuperuser,
    value,
  );

  _i1.ColumnValue<bool, bool> deleted(bool value) => _i1.ColumnValue(
    table.deleted,
    value,
  );

  _i1.ColumnValue<String, String> loginIp(String? value) => _i1.ColumnValue(
    table.loginIp,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> loginTime(DateTime? value) =>
      _i1.ColumnValue(
        table.loginTime,
        value,
      );

  _i1.ColumnValue<String, String> updater(String? value) => _i1.ColumnValue(
    table.updater,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updateTime(DateTime? value) =>
      _i1.ColumnValue(
        table.updateTime,
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
}

class SysUserTable extends _i1.Table<int?> {
  SysUserTable({super.tableRelation}) : super(tableName: 'sys_user') {
    updateTable = SysUserUpdateTable(this);
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
      hasDefault: true,
    );
    deptId = _i1.ColumnInt(
      'deptId',
      this,
    );
    postIds = _i1.ColumnSerializable<List<int>>(
      'postIds',
      this,
    );
    username = _i1.ColumnString(
      'username',
      this,
    );
    password = _i1.ColumnString(
      'password',
      this,
    );
    authUserId = _i1.ColumnUuid(
      'authUserId',
      this,
    );
    nickname = _i1.ColumnString(
      'nickname',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    gender = _i1.ColumnInt(
      'gender',
      this,
      hasDefault: true,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    avatar = _i1.ColumnString(
      'avatar',
      this,
    );
    remark = _i1.ColumnString(
      'remark',
      this,
    );
    status = _i1.ColumnInt(
      'status',
      this,
      hasDefault: true,
    );
    isSuperuser = _i1.ColumnBool(
      'isSuperuser',
      this,
      hasDefault: true,
    );
    deleted = _i1.ColumnBool(
      'deleted',
      this,
      hasDefault: true,
    );
    loginIp = _i1.ColumnString(
      'loginIp',
      this,
    );
    loginTime = _i1.ColumnDateTime(
      'loginTime',
      this,
    );
    updater = _i1.ColumnString(
      'updater',
      this,
    );
    updateTime = _i1.ColumnDateTime(
      'updateTime',
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
  }

  late final SysUserUpdateTable updateTable;

  late final _i1.ColumnInt tenantId;

  late final _i1.ColumnInt deptId;

  late final _i1.ColumnSerializable<List<int>> postIds;

  late final _i1.ColumnString username;

  late final _i1.ColumnString password;

  late final _i1.ColumnUuid authUserId;

  _i2.AuthUserTable? _authUser;

  late final _i1.ColumnString nickname;

  late final _i1.ColumnString phone;

  late final _i1.ColumnInt gender;

  late final _i1.ColumnString email;

  late final _i1.ColumnString avatar;

  late final _i1.ColumnString remark;

  late final _i1.ColumnInt status;

  late final _i1.ColumnBool isSuperuser;

  late final _i1.ColumnBool deleted;

  late final _i1.ColumnString loginIp;

  late final _i1.ColumnDateTime loginTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  _i2.AuthUserTable get authUser {
    if (_authUser != null) return _authUser!;
    _authUser = _i1.createRelationTable(
      relationFieldName: 'authUser',
      field: SysUser.t.authUserId,
      foreignField: _i2.AuthUser.t.id,
      tableRelation: tableRelation,
      createTable: (foreignTableRelation) =>
          _i2.AuthUserTable(tableRelation: foreignTableRelation),
    );
    return _authUser!;
  }

  @override
  List<_i1.Column> get columns => [
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
    remark,
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
  _i1.Table? getRelationTable(String relationField) {
    if (relationField == 'authUser') {
      return authUser;
    }
    return null;
  }
}

class SysUserInclude extends _i1.IncludeObject {
  SysUserInclude._({_i2.AuthUserInclude? authUser}) {
    _authUser = authUser;
  }

  _i2.AuthUserInclude? _authUser;

  @override
  Map<String, _i1.Include?> get includes => {'authUser': _authUser};

  @override
  _i1.Table<int?> get table => SysUser.t;
}

class SysUserIncludeList extends _i1.IncludeList {
  SysUserIncludeList._({
    _i1.WhereExpressionBuilder<SysUserTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysUser.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysUser.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysUserTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysUserTable>? orderByList,
    _i1.Transaction? transaction,
    SysUserInclude? include,
  }) async {
    return session.db.find<SysUser>(
      where: where?.call(SysUser.t),
      orderBy: orderBy?.call(SysUser.t),
      orderByList: orderByList?.call(SysUser.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      include: include,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysUserTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysUserTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysUserTable>? orderByList,
    _i1.Transaction? transaction,
    SysUserInclude? include,
  }) async {
    return session.db.findFirstRow<SysUser>(
      where: where?.call(SysUser.t),
      orderBy: orderBy?.call(SysUser.t),
      orderByList: orderByList?.call(SysUser.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      include: include,
    );
  }

  /// Finds a single [SysUser] by its [id] or null if no such row exists.
  Future<SysUser?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
    SysUserInclude? include,
  }) async {
    return session.db.findById<SysUser>(
      id,
      transaction: transaction,
      include: include,
    );
  }

  /// Inserts all [SysUser]s in the list and returns the inserted rows.
  ///
  /// The returned [SysUser]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysUser>> insert(
    _i1.Session session,
    List<SysUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysUser] and returns the inserted row.
  ///
  /// The returned [SysUser] will have its `id` field set.
  Future<SysUser> insertRow(
    _i1.Session session,
    SysUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysUser>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysUser]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysUser>> update(
    _i1.Session session,
    List<SysUser> rows, {
    _i1.ColumnSelections<SysUserTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysUser>(
      rows,
      columns: columns?.call(SysUser.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysUser]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysUser> updateRow(
    _i1.Session session,
    SysUser row, {
    _i1.ColumnSelections<SysUserTable>? columns,
    _i1.Transaction? transaction,
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
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<SysUserUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SysUser>(
      id,
      columnValues: columnValues(SysUser.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysUser]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SysUser>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SysUserUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SysUserTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysUserTable>? orderBy,
    _i1.OrderByListBuilder<SysUserTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SysUser>(
      columnValues: columnValues(SysUser.t.updateTable),
      where: where(SysUser.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysUser.t),
      orderByList: orderByList?.call(SysUser.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SysUser]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysUser>> delete(
    _i1.Session session,
    List<SysUser> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysUser>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysUser].
  Future<SysUser> deleteRow(
    _i1.Session session,
    SysUser row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysUser>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysUser>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysUserTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysUser>(
      where: where(SysUser.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysUserTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysUser>(
      where: where?.call(SysUser.t),
      limit: limit,
      transaction: transaction,
    );
  }
}

class SysUserAttachRowRepository {
  const SysUserAttachRowRepository._();

  /// Creates a relation between the given [SysUser] and [AuthUser]
  /// by setting the [SysUser]'s foreign key `authUserId` to refer to the [AuthUser].
  Future<void> authUser(
    _i1.Session session,
    SysUser sysUser,
    _i2.AuthUser authUser, {
    _i1.Transaction? transaction,
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
    _i1.Session session,
    SysUser sysUser, {
    _i1.Transaction? transaction,
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
