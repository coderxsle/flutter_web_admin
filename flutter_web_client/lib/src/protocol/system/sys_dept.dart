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

/// 系统部门表 - 支持多租户、树形结构
abstract class SysDept implements _i1.SerializableModel {
  SysDept._({
    this.id,
    int? tenantId,
    this.parentId,
    this.leaderId,
    this.name,
    this.phone,
    this.email,
    this.sort,
    this.status,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
    bool? deleted,
  }) : tenantId = tenantId ?? 0,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now(),
       deleted = deleted ?? false;

  factory SysDept({
    int? id,
    int? tenantId,
    int? parentId,
    int? leaderId,
    String? name,
    String? phone,
    String? email,
    int? sort,
    int? status,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  }) = _SysDeptImpl;

  factory SysDept.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysDept(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      parentId: jsonSerialization['parentId'] as int?,
      leaderId: jsonSerialization['leaderId'] as int?,
      name: jsonSerialization['name'] as String?,
      phone: jsonSerialization['phone'] as String?,
      email: jsonSerialization['email'] as String?,
      sort: jsonSerialization['sort'] as int?,
      status: jsonSerialization['status'] as int?,
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int tenantId;

  int? parentId;

  int? leaderId;

  String? name;

  String? phone;

  String? email;

  int? sort;

  int? status;

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
    int? parentId,
    int? leaderId,
    String? name,
    String? phone,
    String? email,
    int? sort,
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
      '__className__': 'SysDept',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (parentId != null) 'parentId': parentId,
      if (leaderId != null) 'leaderId': leaderId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (sort != null) 'sort': sort,
      if (status != null) 'status': status,
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
    int? parentId,
    int? leaderId,
    String? name,
    String? phone,
    String? email,
    int? sort,
    int? status,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         parentId: parentId,
         leaderId: leaderId,
         name: name,
         phone: phone,
         email: email,
         sort: sort,
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
    Object? parentId = _Undefined,
    Object? leaderId = _Undefined,
    Object? name = _Undefined,
    Object? phone = _Undefined,
    Object? email = _Undefined,
    Object? sort = _Undefined,
    Object? status = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysDept(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      parentId: parentId is int? ? parentId : this.parentId,
      leaderId: leaderId is int? ? leaderId : this.leaderId,
      name: name is String? ? name : this.name,
      phone: phone is String? ? phone : this.phone,
      email: email is String? ? email : this.email,
      sort: sort is int? ? sort : this.sort,
      status: status is int? ? status : this.status,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
