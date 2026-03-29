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
abstract class SysDictCode implements _i1.SerializableModel {
  SysDictCode._({
    this.id,
    int? tenantId,
    required this.name,
    required this.code,
    required this.status,
    this.description,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
  }) : tenantId = tenantId ?? 0,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now();

  factory SysDictCode({
    int? id,
    int? tenantId,
    required String name,
    required String code,
    required int status,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) = _SysDictCodeImpl;

  factory SysDictCode.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysDictCode(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      status: jsonSerialization['status'] as int,
      description: jsonSerialization['description'] as String?,
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updateTime'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? tenantId;

  String name;

  String code;

  int status;

  String? description;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  /// Returns a shallow copy of this [SysDictCode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysDictCode copyWith({
    int? id,
    int? tenantId,
    String? name,
    String? code,
    int? status,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysDictCode',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      'name': name,
      'code': code,
      'status': status,
      if (description != null) 'description': description,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysDictCodeImpl extends SysDictCode {
  _SysDictCodeImpl({
    int? id,
    int? tenantId,
    required String name,
    required String code,
    required int status,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         name: name,
         code: code,
         status: status,
         description: description,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [SysDictCode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysDictCode copyWith({
    Object? id = _Undefined,
    Object? tenantId = _Undefined,
    String? name,
    String? code,
    int? status,
    Object? description = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return SysDictCode(
      id: id is int? ? id : this.id,
      tenantId: tenantId is int? ? tenantId : this.tenantId,
      name: name ?? this.name,
      code: code ?? this.code,
      status: status ?? this.status,
      description: description is String? ? description : this.description,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}
