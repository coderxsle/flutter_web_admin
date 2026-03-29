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
import 'package:serverpod_serialization/serverpod_serialization.dart' as _i1;

abstract class UserInfo implements _i1.SerializableModel {
  UserInfo._({
    this.id,
    required this.tenantId,
    this.deptId,
    required this.username,
    required this.nickname,
    this.phone,
    this.gender,
    this.email,
    this.avatar,
    this.description,
    this.status,
    required this.type,
    required this.isSuperuser,
    this.loginIp,
    this.loginTime,
    required this.createTime,
  });

  factory UserInfo({
    int? id,
    required int tenantId,
    int? deptId,
    required String username,
    required String nickname,
    String? phone,
    int? gender,
    String? email,
    String? avatar,
    String? description,
    int? status,
    required int type,
    required bool isSuperuser,
    String? loginIp,
    DateTime? loginTime,
    required DateTime createTime,
  }) = _UserInfoImpl;

  factory UserInfo.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserInfo(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      deptId: jsonSerialization['deptId'] as int?,
      username: jsonSerialization['username'] as String,
      nickname: jsonSerialization['nickname'] as String,
      phone: jsonSerialization['phone'] as String?,
      gender: jsonSerialization['gender'] as int?,
      email: jsonSerialization['email'] as String?,
      avatar: jsonSerialization['avatar'] as String?,
      description: jsonSerialization['description'] as String?,
      status: jsonSerialization['status'] as int?,
      type: jsonSerialization['type'] as int,
      isSuperuser: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['isSuperuser'],
      ),
      loginIp: jsonSerialization['loginIp'] as String?,
      loginTime: jsonSerialization['loginTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['loginTime']),
      createTime: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createTime'],
      ),
    );
  }

  int? id;

  int tenantId;

  int? deptId;

  String username;

  String nickname;

  String? phone;

  int? gender;

  String? email;

  String? avatar;

  String? description;

  int? status;

  int type;

  bool isSuperuser;

  String? loginIp;

  DateTime? loginTime;

  DateTime createTime;

  /// Returns a shallow copy of this [UserInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserInfo copyWith({
    int? id,
    int? tenantId,
    int? deptId,
    String? username,
    String? nickname,
    String? phone,
    int? gender,
    String? email,
    String? avatar,
    String? description,
    int? status,
    int? type,
    bool? isSuperuser,
    String? loginIp,
    DateTime? loginTime,
    DateTime? createTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserInfo',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (deptId != null) 'deptId': deptId,
      'username': username,
      'nickname': nickname,
      if (phone != null) 'phone': phone,
      if (gender != null) 'gender': gender,
      if (email != null) 'email': email,
      if (avatar != null) 'avatar': avatar,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      'type': type,
      'isSuperuser': isSuperuser,
      if (loginIp != null) 'loginIp': loginIp,
      if (loginTime != null) 'loginTime': loginTime?.toJson(),
      'createTime': createTime.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserInfoImpl extends UserInfo {
  _UserInfoImpl({
    int? id,
    required int tenantId,
    int? deptId,
    required String username,
    required String nickname,
    String? phone,
    int? gender,
    String? email,
    String? avatar,
    String? description,
    int? status,
    required int type,
    required bool isSuperuser,
    String? loginIp,
    DateTime? loginTime,
    required DateTime createTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         deptId: deptId,
         username: username,
         nickname: nickname,
         phone: phone,
         gender: gender,
         email: email,
         avatar: avatar,
         description: description,
         status: status,
         type: type,
         isSuperuser: isSuperuser,
         loginIp: loginIp,
         loginTime: loginTime,
         createTime: createTime,
       );

  /// Returns a shallow copy of this [UserInfo]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserInfo copyWith({
    Object? id = _Undefined,
    int? tenantId,
    Object? deptId = _Undefined,
    String? username,
    String? nickname,
    Object? phone = _Undefined,
    Object? gender = _Undefined,
    Object? email = _Undefined,
    Object? avatar = _Undefined,
    Object? description = _Undefined,
    Object? status = _Undefined,
    int? type,
    bool? isSuperuser,
    Object? loginIp = _Undefined,
    Object? loginTime = _Undefined,
    DateTime? createTime,
  }) {
    return UserInfo(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      deptId: deptId is int? ? deptId : this.deptId,
      username: username ?? this.username,
      nickname: nickname ?? this.nickname,
      phone: phone is String? ? phone : this.phone,
      gender: gender is int? ? gender : this.gender,
      email: email is String? ? email : this.email,
      avatar: avatar is String? ? avatar : this.avatar,
      description: description is String? ? description : this.description,
      status: status is int? ? status : this.status,
      type: type ?? this.type,
      isSuperuser: isSuperuser ?? this.isSuperuser,
      loginIp: loginIp is String? ? loginIp : this.loginIp,
      loginTime: loginTime is DateTime? ? loginTime : this.loginTime,
      createTime: createTime ?? this.createTime,
    );
  }
}
