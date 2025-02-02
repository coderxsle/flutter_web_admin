/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// 用于存储可以登录后台系统的用户信息
/// sys_user: 面向后台的管理员账户系统
abstract class SysUser implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
