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
import 'package:serverpod_serialization/serverpod_serialization.dart' as _i1;

/// 新增、修改字典类型请求参数
abstract class DictCodeResponse implements _i1.SerializableModel {
  DictCodeResponse._({
    this.id,
    required this.tenantId,
    required this.name,
    required this.code,
    required this.status,
    this.description,
    required this.deleted,
    this.creator,
    required this.createTime,
    this.updater,
    required this.updateTime,
  });

  factory DictCodeResponse({
    int? id,
    required int tenantId,
    required String name,
    required String code,
    required int status,
    String? description,
    required bool deleted,
    String? creator,
    required DateTime createTime,
    String? updater,
    required DateTime updateTime,
  }) = _DictCodeResponseImpl;

  factory DictCodeResponse.fromJson(Map<String, dynamic> jsonSerialization) {
    return DictCodeResponse(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      status: jsonSerialization['status'] as int,
      description: jsonSerialization['description'] as String?,
      deleted: _i1.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      creator: jsonSerialization['creator'] as String?,
      createTime: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createTime'],
      ),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updateTime'],
      ),
    );
  }

  int? id;

  int tenantId;

  String name;

  String code;

  int status;

  String? description;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  /// Returns a shallow copy of this [DictCodeResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictCodeResponse copyWith({
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
      '__className__': 'DictCodeResponse',
      if (id != null) 'id': id,
      'tenantId': tenantId,
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

class _DictCodeResponseImpl extends DictCodeResponse {
  _DictCodeResponseImpl({
    int? id,
    required int tenantId,
    required String name,
    required String code,
    required int status,
    String? description,
    required bool deleted,
    String? creator,
    required DateTime createTime,
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

  /// Returns a shallow copy of this [DictCodeResponse]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictCodeResponse copyWith({
    Object? id = _Undefined,
    int? tenantId,
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
    return DictCodeResponse(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
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
