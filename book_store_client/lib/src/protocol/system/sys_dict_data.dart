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
    required this.sort,
    required this.label,
    required this.value,
    required this.dictType,
    required this.status,
    this.colorType,
    this.remark,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysDictData({
    int? id,
    required int sort,
    required String label,
    required String value,
    required String dictType,
    required int status,
    String? colorType,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysDictDataImpl;

  factory SysDictData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysDictData(
      id: jsonSerialization['id'] as int?,
      sort: jsonSerialization['sort'] as int,
      label: jsonSerialization['label'] as String,
      value: jsonSerialization['value'] as String,
      dictType: jsonSerialization['dictType'] as String,
      status: jsonSerialization['status'] as int,
      colorType: jsonSerialization['colorType'] as String?,
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

  int sort;

  String label;

  String value;

  String dictType;

  int status;

  String? colorType;

  String? remark;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysDictData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysDictData copyWith({
    int? id,
    int? sort,
    String? label,
    String? value,
    String? dictType,
    int? status,
    String? colorType,
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
      'sort': sort,
      'label': label,
      'value': value,
      'dictType': dictType,
      'status': status,
      if (colorType != null) 'colorType': colorType,
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

class _SysDictDataImpl extends SysDictData {
  _SysDictDataImpl({
    int? id,
    required int sort,
    required String label,
    required String value,
    required String dictType,
    required int status,
    String? colorType,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          sort: sort,
          label: label,
          value: value,
          dictType: dictType,
          status: status,
          colorType: colorType,
          remark: remark,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysDictData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysDictData copyWith({
    Object? id = _Undefined,
    int? sort,
    String? label,
    String? value,
    String? dictType,
    int? status,
    Object? colorType = _Undefined,
    Object? remark = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysDictData(
      id: id is int? ? id : this.id,
      sort: sort ?? this.sort,
      label: label ?? this.label,
      value: value ?? this.value,
      dictType: dictType ?? this.dictType,
      status: status ?? this.status,
      colorType: colorType is String? ? colorType : this.colorType,
      remark: remark is String? ? remark : this.remark,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
