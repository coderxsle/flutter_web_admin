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
abstract class SysUser implements _i1.TableRow, _i1.ProtocolSerialization {
  SysUser._({
    this.id,
    String? truename,
    String? nickname,
    String? username,
    String? password,
    String? phone,
    String? email,
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
  _i1.Table get table => t;

  SysUser copyWith({
    int? id,
    String? truename,
    String? nickname,
    String? username,
    String? password,
    String? phone,
    String? email,
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
          creatorId: creatorId,
          createTime: createTime,
          loginTime: loginTime,
          status: status,
          isDeleted: isDeleted,
        );

  @override
  SysUser copyWith({
    Object? id = _Undefined,
    String? truename,
    String? nickname,
    String? username,
    String? password,
    String? phone,
    String? email,
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
      creatorId: creatorId ?? this.creatorId,
      createTime: createTime ?? this.createTime,
      loginTime: loginTime ?? this.loginTime,
      status: status ?? this.status,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class SysUserTable extends _i1.Table {
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
  _i1.Table get table => SysUser.t;
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
  _i1.Table get table => SysUser.t;
}

class SysUserRepository {
  const SysUserRepository._();

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
