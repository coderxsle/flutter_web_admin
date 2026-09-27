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
import 'package:flutter_web_server/src/generated/protocol.dart' as _ii4hkddg;
import 'package:serverpod/serverpod.dart' as _is;
import '../responses/menu.dart' as _i4cmevm9;
import '../responses/user_info.dart' as _inynmhro;

abstract class UserInfoResponse implements _is.SerializableModel, _is.ProtocolSerialization {
  UserInfoResponse._({required this.user, this.posts, this.roles, this.permissions, this.menus});

  factory UserInfoResponse({
    required _inynmhro.UserInfo user,
    List<String>? posts,
    List<String>? roles,
    List<String>? permissions,
    List<_i4cmevm9.Menu>? menus,
  }) = _UserInfoResponseImpl;

  factory UserInfoResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserInfoResponse(
      user: _ii4hkddg.Protocol().deserialize<_inynmhro.UserInfo>(jsonSerialization['user']),
      posts: jsonSerialization['posts'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<List<String>>(jsonSerialization['posts']),
      roles: jsonSerialization['roles'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<List<String>>(jsonSerialization['roles']),
      permissions: jsonSerialization['permissions'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<List<String>>(jsonSerialization['permissions']),
      menus: jsonSerialization['menus'] == null
          ? null
          : _ii4hkddg.Protocol().deserialize<List<_i4cmevm9.Menu>>(jsonSerialization['menus']),
    );
  }

  _inynmhro.UserInfo user;

  List<String>? posts;

  List<String>? roles;

  List<String>? permissions;

  List<_i4cmevm9.Menu>? menus;

  /// Returns a shallow copy of this [UserInfoResponse]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  UserInfoResponse copyWith({
    _inynmhro.UserInfo? user,
    List<String>? posts,
    List<String>? roles,
    List<String>? permissions,
    List<_i4cmevm9.Menu>? menus,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserInfoResponse',
      'user': user.toJson(),
      if (posts != null) 'posts': posts?.toJson(),
      if (roles != null) 'roles': roles?.toJson(),
      if (permissions != null) 'permissions': permissions?.toJson(),
      if (menus != null) 'menus': menus?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserInfoResponse',
      'user': user.toJsonForProtocol(),
      if (posts != null) 'posts': posts?.toJson(),
      if (roles != null) 'roles': roles?.toJson(),
      if (permissions != null) 'permissions': permissions?.toJson(),
      if (menus != null) 'menus': menus?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserInfoResponseImpl extends UserInfoResponse {
  _UserInfoResponseImpl({
    required _inynmhro.UserInfo user,
    List<String>? posts,
    List<String>? roles,
    List<String>? permissions,
    List<_i4cmevm9.Menu>? menus,
  }) : super._(user: user, posts: posts, roles: roles, permissions: permissions, menus: menus);

  /// Returns a shallow copy of this [UserInfoResponse]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  UserInfoResponse copyWith({
    _inynmhro.UserInfo? user,
    Object? posts = _Undefined,
    Object? roles = _Undefined,
    Object? permissions = _Undefined,
    Object? menus = _Undefined,
  }) {
    return UserInfoResponse(
      user: user ?? this.user.copyWith(),
      posts: posts is List<String>? ? posts : this.posts?.map((e0) => e0).toList(),
      roles: roles is List<String>? ? roles : this.roles?.map((e0) => e0).toList(),
      permissions: permissions is List<String>? ? permissions : this.permissions?.map((e0) => e0).toList(),
      menus: menus is List<_i4cmevm9.Menu>? ? menus : this.menus?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
