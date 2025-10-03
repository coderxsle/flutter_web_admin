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

/// 用户和角色关联表
abstract class SysUserRole implements _i1.SerializableModel {
  SysUserRole._({
    this.id,
    int? tenantId,
    required this.userId,
    required this.roleId,
    this.creator,
    DateTime? createTime,
    this.updater,
    this.updateTime,
    required this.deleted,
  })  : tenantId = tenantId ?? 0,
        createTime = createTime ?? DateTime.now();

  factory SysUserRole({
    int? id,
    int? tenantId,
    required int userId,
    required int roleId,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    required bool deleted,
  }) = _SysUserRoleImpl;

  factory SysUserRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysUserRole(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      userId: jsonSerialization['userId'] as int,
      roleId: jsonSerialization['roleId'] as int,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int tenantId;

  int userId;

  int roleId;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime? updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysUserRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysUserRole copyWith({
    int? id,
    int? tenantId,
    int? userId,
    int? roleId,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'userId': userId,
      'roleId': roleId,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      if (updateTime != null) 'updateTime': updateTime?.toJson(),
      'deleted': deleted,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysUserRoleImpl extends SysUserRole {
  _SysUserRoleImpl({
    int? id,
    int? tenantId,
    required int userId,
    required int roleId,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          userId: userId,
          roleId: roleId,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysUserRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysUserRole copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? userId,
    int? roleId,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    Object? updateTime = _Undefined,
    bool? deleted,
  }) {
    return SysUserRole(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      userId: userId ?? this.userId,
      roleId: roleId ?? this.roleId,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime is DateTime? ? updateTime : this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
