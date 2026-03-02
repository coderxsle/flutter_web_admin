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

abstract class LoginResponse implements _i1.SerializableModel {
  LoginResponse._({
    this.userId,
    this.username,
    this.expiresIn,
    this.tokenType,
    this.accessToken,
    this.refreshToken,
  });

  factory LoginResponse({
    int? userId,
    String? username,
    int? expiresIn,
    String? tokenType,
    String? accessToken,
    String? refreshToken,
  }) = _LoginResponseImpl;

  factory LoginResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return LoginResponse(
      userId: jsonSerialization['userId'] as int?,
      username: jsonSerialization['username'] as String?,
      expiresIn: jsonSerialization['expiresIn'] as int?,
      tokenType: jsonSerialization['tokenType'] as String?,
      accessToken: jsonSerialization['accessToken'] as String?,
      refreshToken: jsonSerialization['refreshToken'] as String?,
    );
  }

  int? userId;

  String? username;

  int? expiresIn;

  String? tokenType;

  String? accessToken;

  String? refreshToken;

  /// Returns a shallow copy of this [LoginResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LoginResponse copyWith({
    int? userId,
    String? username,
    int? expiresIn,
    String? tokenType,
    String? accessToken,
    String? refreshToken,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LoginResponse',
      if (userId != null) 'userId': userId,
      if (username != null) 'username': username,
      if (expiresIn != null) 'expiresIn': expiresIn,
      if (tokenType != null) 'tokenType': tokenType,
      if (accessToken != null) 'accessToken': accessToken,
      if (refreshToken != null) 'refreshToken': refreshToken,
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
    int? userId,
    String? username,
    int? expiresIn,
    String? tokenType,
    String? accessToken,
    String? refreshToken,
  }) : super._(
         userId: userId,
         username: username,
         expiresIn: expiresIn,
         tokenType: tokenType,
         accessToken: accessToken,
         refreshToken: refreshToken,
       );

  /// Returns a shallow copy of this [LoginResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LoginResponse copyWith({
    Object? userId = _Undefined,
    Object? username = _Undefined,
    Object? expiresIn = _Undefined,
    Object? tokenType = _Undefined,
    Object? accessToken = _Undefined,
    Object? refreshToken = _Undefined,
  }) {
    return LoginResponse(
      userId: userId is int? ? userId : this.userId,
      username: username is String? ? username : this.username,
      expiresIn: expiresIn is int? ? expiresIn : this.expiresIn,
      tokenType: tokenType is String? ? tokenType : this.tokenType,
      accessToken: accessToken is String? ? accessToken : this.accessToken,
      refreshToken: refreshToken is String? ? refreshToken : this.refreshToken,
    );
  }
}
