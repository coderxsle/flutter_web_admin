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
import '../system/sys_user.dart' as _i2;
import '../system/sys_menu.dart' as _i3;
import 'package:flutter_web_client/src/protocol/protocol.dart' as _i4;

abstract class LoginResponse implements _i1.SerializableModel {
  LoginResponse._({
    required this.user,
    this.posts,
    this.roles,
    this.permissions,
    this.menus,
  });

  factory LoginResponse({
    required _i2.SysUser user,
    List<String>? posts,
    List<String>? roles,
    List<String>? permissions,
    List<_i3.SysMenu>? menus,
  }) = _LoginResponseImpl;

  factory LoginResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return LoginResponse(
      user: _i4.Protocol().deserialize<_i2.SysUser>(jsonSerialization['user']),
      posts: jsonSerialization['posts'] == null
          ? null
          : _i4.Protocol().deserialize<List<String>>(
              jsonSerialization['posts'],
            ),
      roles: jsonSerialization['roles'] == null
          ? null
          : _i4.Protocol().deserialize<List<String>>(
              jsonSerialization['roles'],
            ),
      permissions: jsonSerialization['permissions'] == null
          ? null
          : _i4.Protocol().deserialize<List<String>>(
              jsonSerialization['permissions'],
            ),
      menus: jsonSerialization['menus'] == null
          ? null
          : _i4.Protocol().deserialize<List<_i3.SysMenu>>(
              jsonSerialization['menus'],
            ),
    );
  }

  _i2.SysUser user;

  List<String>? posts;

  List<String>? roles;

  List<String>? permissions;

  List<_i3.SysMenu>? menus;

  /// Returns a shallow copy of this [LoginResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  LoginResponse copyWith({
    _i2.SysUser? user,
    List<String>? posts,
    List<String>? roles,
    List<String>? permissions,
    List<_i3.SysMenu>? menus,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'LoginResponse',
      'user': user.toJson(),
      if (posts != null) 'posts': posts?.toJson(),
      if (roles != null) 'roles': roles?.toJson(),
      if (permissions != null) 'permissions': permissions?.toJson(),
      if (menus != null) 'menus': menus?.toJson(valueToJson: (v) => v.toJson()),
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
    required _i2.SysUser user,
    List<String>? posts,
    List<String>? roles,
    List<String>? permissions,
    List<_i3.SysMenu>? menus,
  }) : super._(
         user: user,
         posts: posts,
         roles: roles,
         permissions: permissions,
         menus: menus,
       );

  /// Returns a shallow copy of this [LoginResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  LoginResponse copyWith({
    _i2.SysUser? user,
    Object? posts = _Undefined,
    Object? roles = _Undefined,
    Object? permissions = _Undefined,
    Object? menus = _Undefined,
  }) {
    return LoginResponse(
      user: user ?? this.user.copyWith(),
      posts: posts is List<String>?
          ? posts
          : this.posts?.map((e0) => e0).toList(),
      roles: roles is List<String>?
          ? roles
          : this.roles?.map((e0) => e0).toList(),
      permissions: permissions is List<String>?
          ? permissions
          : this.permissions?.map((e0) => e0).toList(),
      menus: menus is List<_i3.SysMenu>?
          ? menus
          : this.menus?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
