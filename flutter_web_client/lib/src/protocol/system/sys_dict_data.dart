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

/// 字典数据表
abstract class SysDictData implements _i1.SerializableModel {
  SysDictData._({
    this.id,
    this.tenantId,
    required this.code,
    required this.name,
    required this.value,
    this.color,
    required this.sort,
    required this.status,
    this.remark,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
  }) : deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now();

  factory SysDictData({
    int? id,
    int? tenantId,
    required String code,
    required String name,
    required String value,
    String? color,
    required int sort,
    required int status,
    String? remark,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) = _SysDictDataImpl;

  factory SysDictData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysDictData(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      value: jsonSerialization['value'] as String,
      color: jsonSerialization['color'] as String?,
      sort: jsonSerialization['sort'] as int,
      status: jsonSerialization['status'] as int,
      remark: jsonSerialization['remark'] as String?,
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

  String code;

  String name;

  String value;

  String? color;

  int sort;

  int status;

  String? remark;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  /// Returns a shallow copy of this [SysDictData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysDictData copyWith({
    int? id,
    int? tenantId,
    String? code,
    String? name,
    String? value,
    String? color,
    int? sort,
    int? status,
    String? remark,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysDictData',
      if (id != null) 'id': id,
      if (tenantId != null) 'tenantId': tenantId,
      'code': code,
      'name': name,
      'value': value,
      if (color != null) 'color': color,
      'sort': sort,
      'status': status,
      if (remark != null) 'remark': remark,
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

class _SysDictDataImpl extends SysDictData {
  _SysDictDataImpl({
    int? id,
    int? tenantId,
    required String code,
    required String name,
    required String value,
    String? color,
    required int sort,
    required int status,
    String? remark,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         code: code,
         name: name,
         value: value,
         color: color,
         sort: sort,
         status: status,
         remark: remark,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [SysDictData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysDictData copyWith({
    Object? id = _Undefined,
    Object? tenantId = _Undefined,
    String? code,
    String? name,
    String? value,
    Object? color = _Undefined,
    int? sort,
    int? status,
    Object? remark = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return SysDictData(
      id: id is int? ? id : this.id,
      tenantId: tenantId is int? ? tenantId : this.tenantId,
      code: code ?? this.code,
      name: name ?? this.name,
      value: value ?? this.value,
      color: color is String? ? color : this.color,
      sort: sort ?? this.sort,
      status: status ?? this.status,
      remark: remark is String? ? remark : this.remark,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}
