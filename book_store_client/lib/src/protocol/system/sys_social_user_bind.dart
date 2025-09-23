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

/// 社交绑定表
abstract class SysSocialUserBind implements _i1.SerializableModel {
  SysSocialUserBind._({
    this.id,
    required this.tenantId,
    required this.userId,
    required this.userType,
    required this.socialType,
    required this.socialUserId,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysSocialUserBind({
    int? id,
    required int tenantId,
    required int userId,
    required int userType,
    required int socialType,
    required int socialUserId,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysSocialUserBindImpl;

  factory SysSocialUserBind.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysSocialUserBind(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      userId: jsonSerialization['userId'] as int,
      userType: jsonSerialization['userType'] as int,
      socialType: jsonSerialization['socialType'] as int,
      socialUserId: jsonSerialization['socialUserId'] as int,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int tenantId;

  int userId;

  int userType;

  int socialType;

  int socialUserId;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysSocialUserBind]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysSocialUserBind copyWith({
    int? id,
    int? tenantId,
    int? userId,
    int? userType,
    int? socialType,
    int? socialUserId,
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
      'userType': userType,
      'socialType': socialType,
      'socialUserId': socialUserId,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysSocialUserBindImpl extends SysSocialUserBind {
  _SysSocialUserBindImpl({
    int? id,
    required int tenantId,
    required int userId,
    required int userType,
    required int socialType,
    required int socialUserId,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          userId: userId,
          userType: userType,
          socialType: socialType,
          socialUserId: socialUserId,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysSocialUserBind]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysSocialUserBind copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? userId,
    int? userType,
    int? socialType,
    int? socialUserId,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysSocialUserBind(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      socialType: socialType ?? this.socialType,
      socialUserId: socialUserId ?? this.socialUserId,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
