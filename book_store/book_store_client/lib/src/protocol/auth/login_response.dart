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

abstract class LoginResponse implements _i1.SerializableModel {
  LoginResponse._({
    required this.token,
    required this.userId,
    required this.username,
    this.avatar,
    this.roles,
    this.permissions,
  });

  factory LoginResponse({
    required String token,
    required String userId,
    required String username,
    String? avatar,
    List<String>? roles,
    List<String>? permissions,
  }) = _LoginResponseImpl;

  factory LoginResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return LoginResponse(
      token: jsonSerialization['token'] as String,
      userId: jsonSerialization['userId'] as String,
      username: jsonSerialization['username'] as String,
      avatar: jsonSerialization['avatar'] as String?,
      roles: (jsonSerialization['roles'] as List?)
          ?.map((e) => e as String)
          .toList(),
      permissions: (jsonSerialization['permissions'] as List?)
          ?.map((e) => e as String)
          .toList(),
    );
  }

  String token;

  String userId;

  String username;

  String? avatar;

  List<String>? roles;

  List<String>? permissions;

  LoginResponse copyWith({
    String? token,
    String? userId,
    String? username,
    String? avatar,
    List<String>? roles,
    List<String>? permissions,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'userId': userId,
      'username': username,
      if (avatar != null) 'avatar': avatar,
      if (roles != null) 'roles': roles?.toJson(),
      if (permissions != null) 'permissions': permissions?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _LoginResponseImpl extends LoginResponse {
  _LoginResponseImpl({
    required String token,
    required String userId,
    required String username,
    String? avatar,
    List<String>? roles,
    List<String>? permissions,
  }) : super._(
          token: token,
          userId: userId,
          username: username,
          avatar: avatar,
          roles: roles,
          permissions: permissions,
        );

  @override
  LoginResponse copyWith({
    String? token,
    String? userId,
    String? username,
    Object? avatar = _Undefined,
    Object? roles = _Undefined,
    Object? permissions = _Undefined,
  }) {
    return LoginResponse(
      token: token ?? this.token,
      userId: userId ?? this.userId,
      username: username ?? this.username,
      avatar: avatar is String? ? avatar : this.avatar,
      roles:
          roles is List<String>? ? roles : this.roles?.map((e0) => e0).toList(),
      permissions: permissions is List<String>?
          ? permissions
          : this.permissions?.map((e0) => e0).toList(),
    );
  }
}
