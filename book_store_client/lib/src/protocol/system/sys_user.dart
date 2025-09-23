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
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// 用户信息表
abstract class SysUser implements _i1.SerializableModel {
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

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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
