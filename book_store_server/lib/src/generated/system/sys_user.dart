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

/// 用户信息表
abstract class SysUser
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysUser._({
    this.id,
    required this.tenantId,
    this.deptId,
    required this.username,
    required this.nickname,
    required this.gender,
    this.phone,
    this.email,
    this.avatar,
    this.password,
    required this.status,
    this.postIds,
    required this.deleted,
    this.remark,
    this.loginIp,
    this.loginTime,
    this.creator,
    DateTime? createTime,
    this.updater,
    this.updateTime,
  }) : createTime = createTime ?? DateTime.now();

  factory SysUser({
    int? id,
    required int tenantId,
    int? deptId,
    required String username,
    required String nickname,
    required int gender,
    String? phone,
    String? email,
    String? avatar,
    String? password,
    required int status,
    String? postIds,
    required bool deleted,
    String? remark,
    String? loginIp,
    DateTime? loginTime,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _SysUserImpl;

  factory SysUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysUser(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      deptId: jsonSerialization['deptId'] as int?,
      username: jsonSerialization['username'] as String,
      nickname: jsonSerialization['nickname'] as String,
      gender: jsonSerialization['gender'] as int,
      phone: jsonSerialization['phone'] as String?,
      email: jsonSerialization['email'] as String?,
      avatar: jsonSerialization['avatar'] as String?,
      password: jsonSerialization['password'] as String?,
      status: jsonSerialization['status'] as int,
      postIds: jsonSerialization['postIds'] as String?,
      deleted: jsonSerialization['deleted'] as bool,
      remark: jsonSerialization['remark'] as String?,
      loginIp: jsonSerialization['loginIp'] as String?,
      loginTime: jsonSerialization['loginTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['loginTime']),
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  static final t = SysUserTable();

  static const db = SysUserRepository._();

  @override
  int? id;

  int tenantId;

  int? deptId;

  String username;

  String nickname;

  int gender;

  String? phone;

  String? email;

  String? avatar;

  String? password;

  int status;

  String? postIds;

  bool deleted;

  String? remark;

  String? loginIp;

  DateTime? loginTime;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime? updateTime;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysUser copyWith({
    int? id,
    int? tenantId,
    int? deptId,
    String? username,
    String? nickname,
    int? gender,
    String? phone,
    String? email,
    String? avatar,
    String? password,
    int? status,
    String? postIds,
    bool? deleted,
    String? remark,
    String? loginIp,
    DateTime? loginTime,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (deptId != null) 'deptId': deptId,
      'username': username,
      'nickname': nickname,
      'gender': gender,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (avatar != null) 'avatar': avatar,
      if (password != null) 'password': password,
      'status': status,
      if (postIds != null) 'postIds': postIds,
      'deleted': deleted,
      if (remark != null) 'remark': remark,
      if (loginIp != null) 'loginIp': loginIp,
      if (loginTime != null) 'loginTime': loginTime?.toJson(),
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      if (updateTime != null) 'updateTime': updateTime?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (deptId != null) 'deptId': deptId,
      'username': username,
      'nickname': nickname,
      'gender': gender,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (avatar != null) 'avatar': avatar,
      if (password != null) 'password': password,
      'status': status,
      if (postIds != null) 'postIds': postIds,
      'deleted': deleted,
      if (remark != null) 'remark': remark,
      if (loginIp != null) 'loginIp': loginIp,
      if (loginTime != null) 'loginTime': loginTime?.toJson(),
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      if (updateTime != null) 'updateTime': updateTime?.toJson(),
    };
  }

  static SysUserInclude include() {
    return SysUserInclude._();
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
    required int tenantId,
    int? deptId,
    required String username,
    required String nickname,
    required int gender,
    String? phone,
    String? email,
    String? avatar,
    String? password,
    required int status,
    String? postIds,
    required bool deleted,
    String? remark,
    String? loginIp,
    DateTime? loginTime,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
          id: id,
          tenantId: tenantId,
          deptId: deptId,
          username: username,
          nickname: nickname,
          gender: gender,
          phone: phone,
          email: email,
          avatar: avatar,
          password: password,
          status: status,
          postIds: postIds,
          deleted: deleted,
          remark: remark,
          loginIp: loginIp,
          loginTime: loginTime,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
        );

  /// Returns a shallow copy of this [SysUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysUser copyWith({
    Object? id = _Undefined,
    int? tenantId,
    Object? deptId = _Undefined,
    String? username,
    String? nickname,
    int? gender,
    Object? phone = _Undefined,
    Object? email = _Undefined,
    Object? avatar = _Undefined,
    Object? password = _Undefined,
    int? status,
    Object? postIds = _Undefined,
    bool? deleted,
    Object? remark = _Undefined,
    Object? loginIp = _Undefined,
    Object? loginTime = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    Object? updateTime = _Undefined,
  }) {
    return SysUser(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      deptId: deptId is int? ? deptId : this.deptId,
      username: username ?? this.username,
      nickname: nickname ?? this.nickname,
      gender: gender ?? this.gender,
      phone: phone is String? ? phone : this.phone,
      email: email is String? ? email : this.email,
      avatar: avatar is String? ? avatar : this.avatar,
      password: password is String? ? password : this.password,
      status: status ?? this.status,
      postIds: postIds is String? ? postIds : this.postIds,
      deleted: deleted ?? this.deleted,
      remark: remark is String? ? remark : this.remark,
      loginIp: loginIp is String? ? loginIp : this.loginIp,
      loginTime: loginTime is DateTime? ? loginTime : this.loginTime,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime is DateTime? ? updateTime : this.updateTime,
    );
  }
}

class SysUserTable extends _i1.Table<int?> {
  SysUserTable({super.tableRelation}) : super(tableName: 'sys_user') {
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
    );
    deptId = _i1.ColumnInt(
      'deptId',
      this,
    );
    username = _i1.ColumnString(
      'username',
      this,
    );
    nickname = _i1.ColumnString(
      'nickname',
      this,
    );
    gender = _i1.ColumnInt(
      'gender',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    avatar = _i1.ColumnString(
      'avatar',
      this,
    );
    password = _i1.ColumnString(
      'password',
      this,
    );
    status = _i1.ColumnInt(
      'status',
      this,
    );
    postIds = _i1.ColumnString(
      'postIds',
      this,
    );
    deleted = _i1.ColumnBool(
      'deleted',
      this,
    );
    remark = _i1.ColumnString(
      'remark',
      this,
    );
    loginIp = _i1.ColumnString(
      'loginIp',
      this,
    );
    loginTime = _i1.ColumnDateTime(
      'loginTime',
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
  }

  late final _i1.ColumnInt tenantId;

  late final _i1.ColumnInt deptId;

  late final _i1.ColumnString username;

  late final _i1.ColumnString nickname;

  late final _i1.ColumnInt gender;

  late final _i1.ColumnString phone;

  late final _i1.ColumnString email;

  late final _i1.ColumnString avatar;

  late final _i1.ColumnString password;

  late final _i1.ColumnInt status;

  late final _i1.ColumnString postIds;

  late final _i1.ColumnBool deleted;

  late final _i1.ColumnString remark;

  late final _i1.ColumnString loginIp;

  late final _i1.ColumnDateTime loginTime;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  @override
  List<_i1.Column> get columns => [
        id,
        tenantId,
        deptId,
        username,
        nickname,
        gender,
        phone,
        email,
        avatar,
        password,
        status,
        postIds,
        deleted,
        remark,
        loginIp,
        loginTime,
        creator,
        createTime,
        updater,
        updateTime,
      ];
}

class SysUserInclude extends _i1.IncludeObject {
  SysUserInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

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
  }) async {
    return session.db.find<SysUser>(
      where: where?.call(SysUser.t),
      orderBy: orderBy?.call(SysUser.t),
      orderByList: orderByList?.call(SysUser.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
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
  }) async {
    return session.db.findFirstRow<SysUser>(
      where: where?.call(SysUser.t),
      orderBy: orderBy?.call(SysUser.t),
      orderByList: orderByList?.call(SysUser.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysUser] by its [id] or null if no such row exists.
  Future<SysUser?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysUser>(
      id,
      transaction: transaction,
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
