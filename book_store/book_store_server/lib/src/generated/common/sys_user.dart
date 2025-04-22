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

/// 用于存储可以登录后台系统的用户信息
/// sys_user: 面向后台的管理员账户系统
abstract class SysUser implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  SysUser._({
    this.id,
    String? truename,
    String? nickname,
    String? username,
    String? password,
    String? phone,
    String? email,
    this.avatar,
    this.roles,
    this.permissions,
    int? creatorId,
    DateTime? createTime,
    DateTime? loginTime,
    int? status,
    bool? isDeleted,
  })  : truename = truename ?? '',
        nickname = nickname ?? '',
        username = username ?? '',
        password = password ?? '',
        phone = phone ?? '',
        email = email ?? '',
        creatorId = creatorId ?? 0,
        createTime = createTime ?? DateTime.now(),
        loginTime = loginTime ?? DateTime.now(),
        status = status ?? 0,
        isDeleted = isDeleted ?? false;

  factory SysUser({
    int? id,
    String? truename,
    String? nickname,
    String? username,
    String? password,
    String? phone,
    String? email,
    String? avatar,
    String? roles,
    String? permissions,
    int? creatorId,
    DateTime? createTime,
    DateTime? loginTime,
    int? status,
    bool? isDeleted,
  }) = _SysUserImpl;

  factory SysUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysUser(
      id: jsonSerialization['id'] as int?,
      truename: jsonSerialization['truename'] as String,
      nickname: jsonSerialization['nickname'] as String,
      username: jsonSerialization['username'] as String,
      password: jsonSerialization['password'] as String,
      phone: jsonSerialization['phone'] as String,
      email: jsonSerialization['email'] as String,
      avatar: jsonSerialization['avatar'] as String?,
      roles: jsonSerialization['roles'] as String?,
      permissions: jsonSerialization['permissions'] as String?,
      creatorId: jsonSerialization['creatorId'] as int,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      loginTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['loginTime']),
      status: jsonSerialization['status'] as int,
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  static final t = SysUserTable();

  static const db = SysUserRepository._();

  @override
  int? id;

  /// 真实姓名
  String truename;

  /// 昵称
  String nickname;

  /// 登录用户名
  String username;

  /// 登录密码
  String password;

  /// 手机号
  String phone;

  /// 邮箱
  String email;

  /// 头像
  String? avatar;

  /// 角色列表（逗号分隔的角色编码）
  String? roles;

  /// 权限列表（逗号分隔的权限编码）
  String? permissions;

  /// 创建人
  int creatorId;

  /// 创建时间
  DateTime createTime;

  /// 最后一次登录时间
  DateTime loginTime;

  /// 账号的状态，0为正常，1为锁定
  int status;

  /// 是否删除
  bool isDeleted;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [SysUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysUser copyWith({
    int? id,
    String? truename,
    String? nickname,
    String? username,
    String? password,
    String? phone,
    String? email,
    String? avatar,
    String? roles,
    String? permissions,
    int? creatorId,
    DateTime? createTime,
    DateTime? loginTime,
    int? status,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'truename': truename,
      'nickname': nickname,
      'username': username,
      'password': password,
      'phone': phone,
      'email': email,
      if (avatar != null) 'avatar': avatar,
      if (roles != null) 'roles': roles,
      if (permissions != null) 'permissions': permissions,
      'creatorId': creatorId,
      'createTime': createTime.toJson(),
      'loginTime': loginTime.toJson(),
      'status': status,
      'isDeleted': isDeleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'truename': truename,
      'nickname': nickname,
      'username': username,
      'password': password,
      'phone': phone,
      'email': email,
      if (avatar != null) 'avatar': avatar,
      if (roles != null) 'roles': roles,
      if (permissions != null) 'permissions': permissions,
      'creatorId': creatorId,
      'createTime': createTime.toJson(),
      'loginTime': loginTime.toJson(),
      'status': status,
      'isDeleted': isDeleted,
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
    String? truename,
    String? nickname,
    String? username,
    String? password,
    String? phone,
    String? email,
    String? avatar,
    String? roles,
    String? permissions,
    int? creatorId,
    DateTime? createTime,
    DateTime? loginTime,
    int? status,
    bool? isDeleted,
  }) : super._(
          id: id,
          truename: truename,
          nickname: nickname,
          username: username,
          password: password,
          phone: phone,
          email: email,
          avatar: avatar,
          roles: roles,
          permissions: permissions,
          creatorId: creatorId,
          createTime: createTime,
          loginTime: loginTime,
          status: status,
          isDeleted: isDeleted,
        );

  /// Returns a shallow copy of this [SysUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysUser copyWith({
    Object? id = _Undefined,
    String? truename,
    String? nickname,
    String? username,
    String? password,
    String? phone,
    String? email,
    Object? avatar = _Undefined,
    Object? roles = _Undefined,
    Object? permissions = _Undefined,
    int? creatorId,
    DateTime? createTime,
    DateTime? loginTime,
    int? status,
    bool? isDeleted,
  }) {
    return SysUser(
      id: id is int? ? id : this.id,
      truename: truename ?? this.truename,
      nickname: nickname ?? this.nickname,
      username: username ?? this.username,
      password: password ?? this.password,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      avatar: avatar is String? ? avatar : this.avatar,
      roles: roles is String? ? roles : this.roles,
      permissions: permissions is String? ? permissions : this.permissions,
      creatorId: creatorId ?? this.creatorId,
      createTime: createTime ?? this.createTime,
      loginTime: loginTime ?? this.loginTime,
      status: status ?? this.status,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class SysUserTable extends _i1.Table<int> {
  SysUserTable({super.tableRelation}) : super(tableName: 'sys_user') {
    truename = _i1.ColumnString(
      'truename',
      this,
      hasDefault: true,
    );
    nickname = _i1.ColumnString(
      'nickname',
      this,
      hasDefault: true,
    );
    username = _i1.ColumnString(
      'username',
      this,
      hasDefault: true,
    );
    password = _i1.ColumnString(
      'password',
      this,
      hasDefault: true,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
      hasDefault: true,
    );
    email = _i1.ColumnString(
      'email',
      this,
      hasDefault: true,
    );
    avatar = _i1.ColumnString(
      'avatar',
      this,
    );
    roles = _i1.ColumnString(
      'roles',
      this,
    );
    permissions = _i1.ColumnString(
      'permissions',
      this,
    );
    creatorId = _i1.ColumnInt(
      'creatorId',
      this,
      hasDefault: true,
    );
    createTime = _i1.ColumnDateTime(
      'createTime',
      this,
      hasDefault: true,
    );
    loginTime = _i1.ColumnDateTime(
      'loginTime',
      this,
      hasDefault: true,
    );
    status = _i1.ColumnInt(
      'status',
      this,
      hasDefault: true,
    );
    isDeleted = _i1.ColumnBool(
      'isDeleted',
      this,
      hasDefault: true,
    );
  }

  /// 真实姓名
  late final _i1.ColumnString truename;

  /// 昵称
  late final _i1.ColumnString nickname;

  /// 登录用户名
  late final _i1.ColumnString username;

  /// 登录密码
  late final _i1.ColumnString password;

  /// 手机号
  late final _i1.ColumnString phone;

  /// 邮箱
  late final _i1.ColumnString email;

  /// 头像
  late final _i1.ColumnString avatar;

  /// 角色列表（逗号分隔的角色编码）
  late final _i1.ColumnString roles;

  /// 权限列表（逗号分隔的权限编码）
  late final _i1.ColumnString permissions;

  /// 创建人
  late final _i1.ColumnInt creatorId;

  /// 创建时间
  late final _i1.ColumnDateTime createTime;

  /// 最后一次登录时间
  late final _i1.ColumnDateTime loginTime;

  /// 账号的状态，0为正常，1为锁定
  late final _i1.ColumnInt status;

  /// 是否删除
  late final _i1.ColumnBool isDeleted;

  @override
  List<_i1.Column> get columns => [
        id,
        truename,
        nickname,
        username,
        password,
        phone,
        email,
        avatar,
        roles,
        permissions,
        creatorId,
        createTime,
        loginTime,
        status,
        isDeleted,
      ];
}

class SysUserInclude extends _i1.IncludeObject {
  SysUserInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => SysUser.t;
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
  _i1.Table<int> get table => SysUser.t;
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
