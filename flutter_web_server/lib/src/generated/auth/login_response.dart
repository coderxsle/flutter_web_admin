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
import '../protocol.dart' as _i1;
import 'package:serverpod/serverpod.dart' as _i2;
import '../system/sys_menu.dart' as _i3;

abstract class LoginResponse extends _i1.SysUser
    implements _i2.SerializableModel, _i2.ProtocolSerialization {
  LoginResponse._({
    super.id,
    super.tenantId,
    super.deptId,
    required super.username,
    super.phone,
    super.password,
    super.token,
    required super.nickname,
    required super.gender,
    super.email,
    super.avatar,
    super.remark,
    required super.status,
    super.deleted,
    super.loginIp,
    super.loginTime,
    super.updater,
    super.updateTime,
    super.creator,
    super.createTime,
    this.posts,
    this.roles,
    this.permissions,
    this.menus,
  });

  factory LoginResponse({
    int? id,
    int? tenantId,
    int? deptId,
    required String username,
    String? phone,
    String? password,
    String? token,
    required String nickname,
    required int gender,
    String? email,
    String? avatar,
    String? remark,
    required int status,
    bool? deleted,
    String? loginIp,
    DateTime? loginTime,
    String? updater,
    DateTime? updateTime,
    String? creator,
    DateTime? createTime,
    List<String>? posts,
    List<String>? roles,
    List<String>? permissions,
    List<_i3.SysMenu>? menus,
  }) = _LoginResponseImpl;

  factory LoginResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return LoginResponse(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      deptId: jsonSerialization['deptId'] as int?,
      username: jsonSerialization['username'] as String,
      phone: jsonSerialization['phone'] as String?,
      password: jsonSerialization['password'] as String?,
      token: jsonSerialization['token'] as String?,
      nickname: jsonSerialization['nickname'] as String,
      gender: jsonSerialization['gender'] as int,
      email: jsonSerialization['email'] as String?,
      avatar: jsonSerialization['avatar'] as String?,
      remark: jsonSerialization['remark'] as String?,
      status: jsonSerialization['status'] as int,
      deleted: jsonSerialization['deleted'] as bool,
      loginIp: jsonSerialization['loginIp'] as String?,
      loginTime: jsonSerialization['loginTime'] == null
          ? null
          : _i2.DateTimeJsonExtension.fromJson(jsonSerialization['loginTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _i2.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i2.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      posts: (jsonSerialization['posts'] as List?)
          ?.map((e) => e as String)
          .toList(),
      roles: (jsonSerialization['roles'] as List?)
          ?.map((e) => e as String)
          .toList(),
      permissions: (jsonSerialization['permissions'] as List?)
          ?.map((e) => e as String)
          .toList(),
      menus: (jsonSerialization['menus'] as List?)
          ?.map((e) => _i3.SysMenu.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  List<String>? posts;

  List<String>? roles;

  List<String>? permissions;

  List<_i3.SysMenu>? menus;

  /// Returns a shallow copy of this [LoginResponse]
  /// with some or all fields replaced by the given arguments.
  @override
  @_i2.useResult
  LoginResponse copyWith({
    Object? id,
    int? tenantId,
    Object? deptId,
    String? username,
    Object? phone,
    Object? password,
    Object? token,
    String? nickname,
    int? gender,
    Object? email,
    Object? avatar,
    Object? remark,
    int? status,
    bool? deleted,
    Object? loginIp,
    Object? loginTime,
    Object? updater,
    Object? updateTime,
    Object? creator,
    DateTime? createTime,
    List<String>? posts,
    List<String>? roles,
    List<String>? permissions,
    List<_i3.SysMenu>? menus,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (deptId != null) 'deptId': deptId,
      'username': username,
      if (phone != null) 'phone': phone,
      if (password != null) 'password': password,
      if (token != null) 'token': token,
      'nickname': nickname,
      'gender': gender,
      if (email != null) 'email': email,
      if (avatar != null) 'avatar': avatar,
      if (remark != null) 'remark': remark,
      'status': status,
      'deleted': deleted,
      if (loginIp != null) 'loginIp': loginIp,
      if (loginTime != null) 'loginTime': loginTime?.toJson(),
      if (updater != null) 'updater': updater,
      if (updateTime != null) 'updateTime': updateTime?.toJson(),
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (posts != null) 'posts': posts?.toJson(),
      if (roles != null) 'roles': roles?.toJson(),
      if (permissions != null) 'permissions': permissions?.toJson(),
      if (menus != null) 'menus': menus?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (deptId != null) 'deptId': deptId,
      'username': username,
      if (phone != null) 'phone': phone,
      if (token != null) 'token': token,
      'nickname': nickname,
      'gender': gender,
      if (email != null) 'email': email,
      if (avatar != null) 'avatar': avatar,
      if (remark != null) 'remark': remark,
      'status': status,
      'deleted': deleted,
      if (loginIp != null) 'loginIp': loginIp,
      if (loginTime != null) 'loginTime': loginTime?.toJson(),
      if (updater != null) 'updater': updater,
      if (updateTime != null) 'updateTime': updateTime?.toJson(),
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (posts != null) 'posts': posts?.toJson(),
      if (roles != null) 'roles': roles?.toJson(),
      if (permissions != null) 'permissions': permissions?.toJson(),
      if (menus != null)
        'menus': menus?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _i2.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LoginResponseImpl extends LoginResponse {
  _LoginResponseImpl({
    int? id,
    int? tenantId,
    int? deptId,
    required String username,
    String? phone,
    String? password,
    String? token,
    required String nickname,
    required int gender,
    String? email,
    String? avatar,
    String? remark,
    required int status,
    bool? deleted,
    String? loginIp,
    DateTime? loginTime,
    String? updater,
    DateTime? updateTime,
    String? creator,
    DateTime? createTime,
    List<String>? posts,
    List<String>? roles,
    List<String>? permissions,
    List<_i3.SysMenu>? menus,
  }) : super._(
          id: id,
          tenantId: tenantId,
          deptId: deptId,
          username: username,
          phone: phone,
          password: password,
          token: token,
          nickname: nickname,
          gender: gender,
          email: email,
          avatar: avatar,
          remark: remark,
          status: status,
          deleted: deleted,
          loginIp: loginIp,
          loginTime: loginTime,
          updater: updater,
          updateTime: updateTime,
          creator: creator,
          createTime: createTime,
          posts: posts,
          roles: roles,
          permissions: permissions,
          menus: menus,
        );

  /// Returns a shallow copy of this [LoginResponse]
  /// with some or all fields replaced by the given arguments.
  @_i2.useResult
  @override
  LoginResponse copyWith({
    Object? id = _Undefined,
    int? tenantId,
    Object? deptId = _Undefined,
    String? username,
    Object? phone = _Undefined,
    Object? password = _Undefined,
    Object? token = _Undefined,
    String? nickname,
    int? gender,
    Object? email = _Undefined,
    Object? avatar = _Undefined,
    Object? remark = _Undefined,
    int? status,
    bool? deleted,
    Object? loginIp = _Undefined,
    Object? loginTime = _Undefined,
    Object? updater = _Undefined,
    Object? updateTime = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? posts = _Undefined,
    Object? roles = _Undefined,
    Object? permissions = _Undefined,
    Object? menus = _Undefined,
  }) {
    return LoginResponse(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      deptId: deptId is int? ? deptId : this.deptId,
      username: username ?? this.username,
      phone: phone is String? ? phone : this.phone,
      password: password is String? ? password : this.password,
      token: token is String? ? token : this.token,
      nickname: nickname ?? this.nickname,
      gender: gender ?? this.gender,
      email: email is String? ? email : this.email,
      avatar: avatar is String? ? avatar : this.avatar,
      remark: remark is String? ? remark : this.remark,
      status: status ?? this.status,
      deleted: deleted ?? this.deleted,
      loginIp: loginIp is String? ? loginIp : this.loginIp,
      loginTime: loginTime is DateTime? ? loginTime : this.loginTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime is DateTime? ? updateTime : this.updateTime,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      posts:
          posts is List<String>? ? posts : this.posts?.map((e0) => e0).toList(),
      roles:
          roles is List<String>? ? roles : this.roles?.map((e0) => e0).toList(),
      permissions: permissions is List<String>?
          ? permissions
          : this.permissions?.map((e0) => e0).toList(),
      menus: menus is List<_i3.SysMenu>?
          ? menus
          : this.menus?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
