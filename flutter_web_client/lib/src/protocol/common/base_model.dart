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

abstract class BaseClass implements _i1.SerializableModel {
  BaseClass._({
    this.id,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    bool? deleted,
  }) : createTime = createTime ?? DateTime.now(),
       deleted = deleted ?? false;

  factory BaseClass({
    _i1.UuidValue? id,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    bool? deleted,
  }) = _BaseClassImpl;

  factory BaseClass.fromJson(Map<String, dynamic> jsonSerialization) {
    return BaseClass(
      id: jsonSerialization['id'] == null
          ? null
          : _i1.UuidValueJsonExtension.fromJson(jsonSerialization['id']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updateTime'],
      ),
      deleted: jsonSerialization['deleted'] as bool?,
    );
  }

  _i1.UuidValue? id;

  /// 审计字段
  String? creator;

  /// 审计字段
  DateTime createTime;

  /// 审计字段
  String? updater;

  /// 审计字段
  DateTime updateTime;

  /// 审计字段
  bool deleted;

  /// Returns a shallow copy of this [BaseClass]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BaseClass copyWith({
    _i1.UuidValue? id,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BaseClass',
      if (id != null) 'id': id?.toJson(),
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

class _BaseClassImpl extends BaseClass {
  _BaseClassImpl({
    _i1.UuidValue? id,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    bool? deleted,
  }) : super._(
         id: id,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [BaseClass]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BaseClass copyWith({
    Object? id = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return BaseClass(
      id: id is _i1.UuidValue? ? id : this.id,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
