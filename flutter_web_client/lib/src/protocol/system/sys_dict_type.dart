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

/// 字典类型表
abstract class SysDictType implements _i1.SerializableModel {
  SysDictType._({
    this.id,
    required this.name,
    required this.type,
    required this.status,
    this.remark,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
    this.deletedTime,
  }) : createTime = createTime ?? DateTime.now();

  factory SysDictType({
    int? id,
    required String name,
    required String type,
    required int status,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
    DateTime? deletedTime,
  }) = _SysDictTypeImpl;

  factory SysDictType.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysDictType(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as String,
      status: jsonSerialization['status'] as int,
      remark: jsonSerialization['remark'] as String?,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
      deletedTime: jsonSerialization['deletedTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['deletedTime']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String type;

  int status;

  String? remark;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  DateTime? deletedTime;

  /// Returns a shallow copy of this [SysDictType]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysDictType copyWith({
    int? id,
    String? name,
    String? type,
    int? status,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
    DateTime? deletedTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'type': type,
      'status': status,
      if (remark != null) 'remark': remark,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
      if (deletedTime != null) 'deletedTime': deletedTime?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysDictTypeImpl extends SysDictType {
  _SysDictTypeImpl({
    int? id,
    required String name,
    required String type,
    required int status,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
    DateTime? deletedTime,
  }) : super._(
          id: id,
          name: name,
          type: type,
          status: status,
          remark: remark,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
          deletedTime: deletedTime,
        );

  /// Returns a shallow copy of this [SysDictType]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysDictType copyWith({
    Object? id = _Undefined,
    String? name,
    String? type,
    int? status,
    Object? remark = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
    Object? deletedTime = _Undefined,
  }) {
    return SysDictType(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      status: status ?? this.status,
      remark: remark is String? ? remark : this.remark,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
      deletedTime: deletedTime is DateTime? ? deletedTime : this.deletedTime,
    );
  }
}
