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

/// 用户列表查询请求参数
abstract class UserListRequest implements _i1.SerializableModel {
  UserListRequest._({
    int? tenantId,
    this.deptId,
    this.username,
    this.nickname,
    this.phone,
    this.email,
    String? status,
  }) : tenantId = tenantId ?? 0,
       status = status ?? '1';

  factory UserListRequest({
    int? tenantId,
    int? deptId,
    String? username,
    String? nickname,
    String? phone,
    String? email,
    String? status,
  }) = _UserListRequestImpl;

  factory UserListRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserListRequest(
      tenantId: jsonSerialization['tenantId'] as int?,
      deptId: jsonSerialization['deptId'] as int?,
      username: jsonSerialization['username'] as String?,
      nickname: jsonSerialization['nickname'] as String?,
      phone: jsonSerialization['phone'] as String?,
      email: jsonSerialization['email'] as String?,
      status: jsonSerialization['status'] as String?,
    );
  }

  int? tenantId;

  int? deptId;

  String? username;

  String? nickname;

  String? phone;

  String? email;

  String status;

  /// Returns a shallow copy of this [UserListRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserListRequest copyWith({
    int? tenantId,
    int? deptId,
    String? username,
    String? nickname,
    String? phone,
    String? email,
    String? status,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserListRequest',
      if (tenantId != null) 'tenantId': tenantId,
      if (deptId != null) 'deptId': deptId,
      if (username != null) 'username': username,
      if (nickname != null) 'nickname': nickname,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      'status': status,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserListRequestImpl extends UserListRequest {
  _UserListRequestImpl({
    int? tenantId,
    int? deptId,
    String? username,
    String? nickname,
    String? phone,
    String? email,
    String? status,
  }) : super._(
         tenantId: tenantId,
         deptId: deptId,
         username: username,
         nickname: nickname,
         phone: phone,
         email: email,
         status: status,
       );

  /// Returns a shallow copy of this [UserListRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserListRequest copyWith({
    Object? tenantId = _Undefined,
    Object? deptId = _Undefined,
    Object? username = _Undefined,
    Object? nickname = _Undefined,
    Object? phone = _Undefined,
    Object? email = _Undefined,
    String? status,
  }) {
    return UserListRequest(
      tenantId: tenantId is int? ? tenantId : this.tenantId,
      deptId: deptId is int? ? deptId : this.deptId,
      username: username is String? ? username : this.username,
      nickname: nickname is String? ? nickname : this.nickname,
      phone: phone is String? ? phone : this.phone,
      email: email is String? ? email : this.email,
      status: status ?? this.status,
    );
  }
}
