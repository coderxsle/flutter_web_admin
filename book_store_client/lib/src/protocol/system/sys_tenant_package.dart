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

/// 租户套餐表
abstract class SysTenantPackage implements _i1.SerializableModel {
  SysTenantPackage._({
    this.id,
    required this.name,
    required this.status,
    this.remark,
    required this.menuIds,
    required this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysTenantPackage({
    int? id,
    required String name,
    required int status,
    String? remark,
    required String menuIds,
    required String creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysTenantPackageImpl;

  factory SysTenantPackage.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysTenantPackage(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      status: jsonSerialization['status'] as int,
      remark: jsonSerialization['remark'] as String?,
      menuIds: jsonSerialization['menuIds'] as String,
      creator: jsonSerialization['creator'] as String,
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

  String name;

  int status;

  String? remark;

  String menuIds;

  String creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysTenantPackage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysTenantPackage copyWith({
    int? id,
    String? name,
    int? status,
    String? remark,
    String? menuIds,
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
      'name': name,
      'status': status,
      if (remark != null) 'remark': remark,
      'menuIds': menuIds,
      'creator': creator,
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

class _SysTenantPackageImpl extends SysTenantPackage {
  _SysTenantPackageImpl({
    int? id,
    required String name,
    required int status,
    String? remark,
    required String menuIds,
    required String creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          name: name,
          status: status,
          remark: remark,
          menuIds: menuIds,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysTenantPackage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysTenantPackage copyWith({
    Object? id = _Undefined,
    String? name,
    int? status,
    Object? remark = _Undefined,
    String? menuIds,
    String? creator,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysTenantPackage(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      remark: remark is String? ? remark : this.remark,
      menuIds: menuIds ?? this.menuIds,
      creator: creator ?? this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
