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
import 'package:flutter_web_server/src/generated/protocol.dart' as _i2;

/// 新增用户请求参数
abstract class AddUserRequest
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AddUserRequest._({
    required this.username,
    required this.nickname,
    required this.password,
    this.email,
    int? status,
    bool? isSuperuser,
    this.roleIds,
    this.deptId,
    this.phone,
    int? gender,
  }) : status = status ?? 1,
       isSuperuser = isSuperuser ?? false,
       gender = gender ?? 3;

  factory AddUserRequest({
    required String username,
    required String nickname,
    required String password,
    String? email,
    int? status,
    bool? isSuperuser,
    List<int>? roleIds,
    int? deptId,
    String? phone,
    int? gender,
  }) = _AddUserRequestImpl;

  factory AddUserRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return AddUserRequest(
      username: jsonSerialization['username'] as String,
      nickname: jsonSerialization['nickname'] as String,
      password: jsonSerialization['password'] as String,
      email: jsonSerialization['email'] as String?,
      status: jsonSerialization['status'] as int?,
      isSuperuser: jsonSerialization['isSuperuser'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isSuperuser']),
      roleIds: jsonSerialization['roleIds'] == null
          ? null
          : _i2.Protocol().deserialize<List<int>>(jsonSerialization['roleIds']),
      deptId: jsonSerialization['deptId'] as int?,
      phone: jsonSerialization['phone'] as String?,
      gender: jsonSerialization['gender'] as int?,
    );
  }

  String username;

  String nickname;

  String password;

  String? email;

  int? status;

  bool isSuperuser;

  List<int>? roleIds;

  int? deptId;

  String? phone;

  int? gender;

  /// Returns a shallow copy of this [AddUserRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AddUserRequest copyWith({
    String? username,
    String? nickname,
    String? password,
    String? email,
    int? status,
    bool? isSuperuser,
    List<int>? roleIds,
    int? deptId,
    String? phone,
    int? gender,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AddUserRequest',
      'username': username,
      'nickname': nickname,
      'password': password,
      if (email != null) 'email': email,
      if (status != null) 'status': status,
      'isSuperuser': isSuperuser,
      if (roleIds != null) 'roleIds': roleIds?.toJson(),
      if (deptId != null) 'deptId': deptId,
      if (phone != null) 'phone': phone,
      if (gender != null) 'gender': gender,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AddUserRequest',
      'username': username,
      'nickname': nickname,
      'password': password,
      if (email != null) 'email': email,
      if (status != null) 'status': status,
      'isSuperuser': isSuperuser,
      if (roleIds != null) 'roleIds': roleIds?.toJson(),
      if (deptId != null) 'deptId': deptId,
      if (phone != null) 'phone': phone,
      if (gender != null) 'gender': gender,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AddUserRequestImpl extends AddUserRequest {
  _AddUserRequestImpl({
    required String username,
    required String nickname,
    required String password,
    String? email,
    int? status,
    bool? isSuperuser,
    List<int>? roleIds,
    int? deptId,
    String? phone,
    int? gender,
  }) : super._(
         username: username,
         nickname: nickname,
         password: password,
         email: email,
         status: status,
         isSuperuser: isSuperuser,
         roleIds: roleIds,
         deptId: deptId,
         phone: phone,
         gender: gender,
       );

  /// Returns a shallow copy of this [AddUserRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AddUserRequest copyWith({
    String? username,
    String? nickname,
    String? password,
    Object? email = _Undefined,
    Object? status = _Undefined,
    bool? isSuperuser,
    Object? roleIds = _Undefined,
    Object? deptId = _Undefined,
    Object? phone = _Undefined,
    Object? gender = _Undefined,
  }) {
    return AddUserRequest(
      username: username ?? this.username,
      nickname: nickname ?? this.nickname,
      password: password ?? this.password,
      email: email is String? ? email : this.email,
      status: status is int? ? status : this.status,
      isSuperuser: isSuperuser ?? this.isSuperuser,
      roleIds: roleIds is List<int>?
          ? roleIds
          : this.roleIds?.map((e0) => e0).toList(),
      deptId: deptId is int? ? deptId : this.deptId,
      phone: phone is String? ? phone : this.phone,
      gender: gender is int? ? gender : this.gender,
    );
  }
}
