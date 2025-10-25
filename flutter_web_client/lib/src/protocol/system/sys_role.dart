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

/// 角色信息表
abstract class SysRole implements _i1.SerializableModel {
  SysRole._({
    this.id,
    int? tenantId,
    required this.name,
    required this.code,
    required this.sort,
    required this.dataScope,
    this.dataScopeDeptIds,
    required this.status,
    required this.type,
    this.remark,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  })  : tenantId = tenantId ?? 0,
        createTime = createTime ?? DateTime.now();

  factory SysRole({
    int? id,
    int? tenantId,
    required String name,
    required String code,
    required int sort,
    required int dataScope,
    String? dataScopeDeptIds,
    required int status,
    required int type,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysRoleImpl;

  factory SysRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysRole(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      sort: jsonSerialization['sort'] as int,
      dataScope: jsonSerialization['dataScope'] as int,
      dataScopeDeptIds: jsonSerialization['dataScopeDeptIds'] as String?,
      status: jsonSerialization['status'] as int,
      type: jsonSerialization['type'] as int,
      remark: jsonSerialization['remark'] as String?,
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

  String code;

  int sort;

  int dataScope;

  String? dataScopeDeptIds;

  int status;

  int type;

  String? remark;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysRole copyWith({
    int? id,
    int? tenantId,
    String? name,
    String? code,
    int? sort,
    int? dataScope,
    String? dataScopeDeptIds,
    int? status,
    int? type,
    String? remark,
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
      'code': code,
      'sort': sort,
      'dataScope': dataScope,
      if (dataScopeDeptIds != null) 'dataScopeDeptIds': dataScopeDeptIds,
      'status': status,
      'type': type,
      if (remark != null) 'remark': remark,
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

class _SysRoleImpl extends SysRole {
  _SysRoleImpl({
    int? id,
    int? tenantId,
    required String name,
    required String code,
    required int sort,
    required int dataScope,
    String? dataScopeDeptIds,
    required int status,
    required int type,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          name: name,
          code: code,
          sort: sort,
          dataScope: dataScope,
          dataScopeDeptIds: dataScopeDeptIds,
          status: status,
          type: type,
          remark: remark,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysRole copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? name,
    String? code,
    int? sort,
    int? dataScope,
    Object? dataScopeDeptIds = _Undefined,
    int? status,
    int? type,
    Object? remark = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysRole(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      code: code ?? this.code,
      sort: sort ?? this.sort,
      dataScope: dataScope ?? this.dataScope,
      dataScopeDeptIds: dataScopeDeptIds is String?
          ? dataScopeDeptIds
          : this.dataScopeDeptIds,
      status: status ?? this.status,
      type: type ?? this.type,
      remark: remark is String? ? remark : this.remark,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
