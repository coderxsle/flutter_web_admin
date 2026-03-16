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

/// 系统API表
abstract class SysApi implements _i1.SerializableModel {
  SysApi._({
    this.id,
    int? tenantId,
    required this.name,
    required this.path,
    required this.method,
    this.remark,
    int? status,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    this.updateTime,
  }) : tenantId = tenantId ?? 0,
       status = status ?? 1,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now();

  factory SysApi({
    int? id,
    int? tenantId,
    required String name,
    required String path,
    required String method,
    String? remark,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _SysApiImpl;

  factory SysApi.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysApi(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      name: jsonSerialization['name'] as String,
      path: jsonSerialization['path'] as String,
      method: jsonSerialization['method'] as String,
      remark: jsonSerialization['remark'] as String?,
      status: jsonSerialization['status'] as int?,
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int tenantId;

  String name;

  String path;

  String method;

  String? remark;

  int? status;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime? updateTime;

  /// Returns a shallow copy of this [SysApi]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysApi copyWith({
    int? id,
    int? tenantId,
    String? name,
    String? path,
    String? method,
    String? remark,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysApi',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'path': path,
      'method': method,
      if (remark != null) 'remark': remark,
      if (status != null) 'status': status,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      if (updateTime != null) 'updateTime': updateTime?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysApiImpl extends SysApi {
  _SysApiImpl({
    int? id,
    int? tenantId,
    required String name,
    required String path,
    required String method,
    String? remark,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         name: name,
         path: path,
         method: method,
         remark: remark,
         status: status,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [SysApi]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysApi copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? name,
    String? path,
    String? method,
    Object? remark = _Undefined,
    Object? status = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    Object? updateTime = _Undefined,
  }) {
    return SysApi(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      path: path ?? this.path,
      method: method ?? this.method,
      remark: remark is String? ? remark : this.remark,
      status: status is int? ? status : this.status,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime is DateTime? ? updateTime : this.updateTime,
    );
  }
}
