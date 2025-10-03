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

/// 部门表
abstract class SysDept implements _i1.SerializableModel {
  SysDept._({
    this.id,
    int? tenantId,
    required this.name,
    required this.parentId,
    required this.sort,
    this.leaderUserId,
    this.phone,
    this.email,
    required this.status,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  })  : tenantId = tenantId ?? 0,
        createTime = createTime ?? DateTime.now();

  factory SysDept({
    int? id,
    int? tenantId,
    required String name,
    required int parentId,
    required int sort,
    int? leaderUserId,
    String? phone,
    String? email,
    required int status,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysDeptImpl;

  factory SysDept.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysDept(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      name: jsonSerialization['name'] as String,
      parentId: jsonSerialization['parentId'] as int,
      sort: jsonSerialization['sort'] as int,
      leaderUserId: jsonSerialization['leaderUserId'] as int?,
      phone: jsonSerialization['phone'] as String?,
      email: jsonSerialization['email'] as String?,
      status: jsonSerialization['status'] as int,
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

  String name;

  int parentId;

  int sort;

  int? leaderUserId;

  String? phone;

  String? email;

  int status;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysDept]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysDept copyWith({
    int? id,
    int? tenantId,
    String? name,
    int? parentId,
    int? sort,
    int? leaderUserId,
    String? phone,
    String? email,
    int? status,
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
      'name': name,
      'parentId': parentId,
      'sort': sort,
      if (leaderUserId != null) 'leaderUserId': leaderUserId,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      'status': status,
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

class _SysDeptImpl extends SysDept {
  _SysDeptImpl({
    int? id,
    int? tenantId,
    required String name,
    required int parentId,
    required int sort,
    int? leaderUserId,
    String? phone,
    String? email,
    required int status,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          name: name,
          parentId: parentId,
          sort: sort,
          leaderUserId: leaderUserId,
          phone: phone,
          email: email,
          status: status,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysDept]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysDept copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? name,
    int? parentId,
    int? sort,
    Object? leaderUserId = _Undefined,
    Object? phone = _Undefined,
    Object? email = _Undefined,
    int? status,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysDept(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      sort: sort ?? this.sort,
      leaderUserId: leaderUserId is int? ? leaderUserId : this.leaderUserId,
      phone: phone is String? ? phone : this.phone,
      email: email is String? ? email : this.email,
      status: status ?? this.status,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
