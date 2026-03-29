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
import 'package:flutter_web_shared/flutter_web_shared.dart' as _i2;

/// 新增、修改用户请求参数
abstract class UserRequest implements _i1.SerializableModel {
  UserRequest._({
    this.id,
    required this.username,
    required this.nickname,
    this.password,
    this.email,
    int? status,
    this.roleIds,
    this.deptId,
    this.phone,
    int? gender,
    this.description,
  }) : status = status ?? 1,
       gender = gender ?? 3;

  factory UserRequest({
    int? id,
    required String username,
    required String nickname,
    String? password,
    String? email,
    int? status,
    List<int>? roleIds,
    int? deptId,
    String? phone,
    int? gender,
    String? description,
  }) = _UserRequestImpl;

  factory UserRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserRequest(
      id: jsonSerialization['id'] as int?,
      username: jsonSerialization['username'] as String,
      nickname: jsonSerialization['nickname'] as String,
      password: jsonSerialization['password'] as String?,
      email: jsonSerialization['email'] as String?,
      status: jsonSerialization['status'] as int?,
      roleIds: jsonSerialization['roleIds'] == null
          ? null
          : _i2.Protocol().deserialize<List<int>>(jsonSerialization['roleIds']),
      deptId: jsonSerialization['deptId'] as int?,
      phone: jsonSerialization['phone'] as String?,
      gender: jsonSerialization['gender'] as int?,
      description: jsonSerialization['description'] as String?,
    );
  }

  int? id;

  String username;

  String nickname;

  String? password;

  String? email;

  int? status;

  List<int>? roleIds;

  int? deptId;

  String? phone;

  int? gender;

  String? description;

  /// Returns a shallow copy of this [UserRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserRequest copyWith({
    int? id,
    String? username,
    String? nickname,
    String? password,
    String? email,
    int? status,
    List<int>? roleIds,
    int? deptId,
    String? phone,
    int? gender,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserRequest',
      if (id != null) 'id': id,
      'username': username,
      'nickname': nickname,
      if (password != null) 'password': password,
      if (email != null) 'email': email,
      if (status != null) 'status': status,
      if (roleIds != null) 'roleIds': roleIds?.toJson(),
      if (deptId != null) 'deptId': deptId,
      if (phone != null) 'phone': phone,
      if (gender != null) 'gender': gender,
      if (description != null) 'description': description,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserRequestImpl extends UserRequest {
  _UserRequestImpl({
    int? id,
    required String username,
    required String nickname,
    String? password,
    String? email,
    int? status,
    List<int>? roleIds,
    int? deptId,
    String? phone,
    int? gender,
    String? description,
  }) : super._(
         id: id,
         username: username,
         nickname: nickname,
         password: password,
         email: email,
         status: status,
         roleIds: roleIds,
         deptId: deptId,
         phone: phone,
         gender: gender,
         description: description,
       );

  /// Returns a shallow copy of this [UserRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserRequest copyWith({
    Object? id = _Undefined,
    String? username,
    String? nickname,
    Object? password = _Undefined,
    Object? email = _Undefined,
    Object? status = _Undefined,
    Object? roleIds = _Undefined,
    Object? deptId = _Undefined,
    Object? phone = _Undefined,
    Object? gender = _Undefined,
    Object? description = _Undefined,
  }) {
    return UserRequest(
      id: id is int? ? id : this.id,
      username: username ?? this.username,
      nickname: nickname ?? this.nickname,
      password: password is String? ? password : this.password,
      email: email is String? ? email : this.email,
      status: status is int? ? status : this.status,
      roleIds: roleIds is List<int>?
          ? roleIds
          : this.roleIds?.map((e0) => e0).toList(),
      deptId: deptId is int? ? deptId : this.deptId,
      phone: phone is String? ? phone : this.phone,
      gender: gender is int? ? gender : this.gender,
      description: description is String? ? description : this.description,
    );
  }
}
