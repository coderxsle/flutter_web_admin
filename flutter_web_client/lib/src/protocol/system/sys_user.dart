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
class SysUser implements _i1.SerializableModel {
  SysUser({
    this.id,
    int? tenantId,
    this.deptId,
    required this.username,
    this.phone,
    this.token,
    required this.nickname,
    required this.gender,
    this.email,
    this.avatar,
    this.remark,
    required this.status,
    bool? deleted,
    this.loginIp,
    this.loginTime,
    this.updater,
    this.updateTime,
    this.creator,
    DateTime? createTime,
  })  : tenantId = tenantId ?? 0,
        deleted = deleted ?? false,
        createTime = createTime ?? DateTime.now();

  factory SysUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysUser(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      deptId: jsonSerialization['deptId'] as int?,
      username: jsonSerialization['username'] as String,
      phone: jsonSerialization['phone'] as String?,
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
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['loginTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int tenantId;

  int? deptId;

  String username;

  String? phone;

  String? token;

  String nickname;

  int gender;

  String? email;

  String? avatar;

  String? remark;

  int status;

  bool deleted;

  String? loginIp;

  DateTime? loginTime;

  String? updater;

  DateTime? updateTime;

  String? creator;

  DateTime createTime;

  /// Returns a shallow copy of this [SysUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysUser copyWith({
    Object? id = _Undefined,
    int? tenantId,
    Object? deptId = _Undefined,
    String? username,
    Object? phone = _Undefined,
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
  }) {
    return SysUser(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      deptId: deptId is int? ? deptId : this.deptId,
      username: username ?? this.username,
      phone: phone is String? ? phone : this.phone,
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
    );
  }

  @override
  Map<String, dynamic> toJson() {
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
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}
