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
import 'dart:typed_data' as _i2;

/// 文件内容表
abstract class InfraFileContent implements _i1.SerializableModel {
  InfraFileContent._({
    this.id,
    required this.configId,
    required this.path,
    required this.content,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory InfraFileContent({
    int? id,
    required int configId,
    required String path,
    required _i2.ByteData content,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraFileContentImpl;

  factory InfraFileContent.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraFileContent(
      id: jsonSerialization['id'] as int?,
      configId: jsonSerialization['configId'] as int,
      path: jsonSerialization['path'] as String,
      content: _i1.ByteDataJsonExtension.fromJson(jsonSerialization['content']),
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

  int configId;

  String path;

  _i2.ByteData content;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [InfraFileContent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InfraFileContent copyWith({
    int? id,
    int? configId,
    String? path,
    _i2.ByteData? content,
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
      'configId': configId,
      'path': path,
      'content': content.toJson(),
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

class _InfraFileContentImpl extends InfraFileContent {
  _InfraFileContentImpl({
    int? id,
    required int configId,
    required String path,
    required _i2.ByteData content,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          configId: configId,
          path: path,
          content: content,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [InfraFileContent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InfraFileContent copyWith({
    Object? id = _Undefined,
    int? configId,
    String? path,
    _i2.ByteData? content,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraFileContent(
      id: id is int? ? id : this.id,
      configId: configId ?? this.configId,
      path: path ?? this.path,
      content: content ?? this.content.clone(),
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
