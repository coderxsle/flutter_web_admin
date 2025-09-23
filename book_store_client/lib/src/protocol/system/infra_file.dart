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

/// 文件表
abstract class InfraFile implements _i1.SerializableModel {
  InfraFile._({
    this.id,
    this.configId,
    this.name,
    required this.path,
    required this.url,
    this.type,
    required this.size,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory InfraFile({
    int? id,
    int? configId,
    String? name,
    required String path,
    required String url,
    String? type,
    required int size,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraFileImpl;

  factory InfraFile.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraFile(
      id: jsonSerialization['id'] as int?,
      configId: jsonSerialization['configId'] as int?,
      name: jsonSerialization['name'] as String?,
      path: jsonSerialization['path'] as String,
      url: jsonSerialization['url'] as String,
      type: jsonSerialization['type'] as String?,
      size: jsonSerialization['size'] as int,
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

  int? configId;

  String? name;

  String path;

  String url;

  String? type;

  int size;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [InfraFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InfraFile copyWith({
    int? id,
    int? configId,
    String? name,
    String? path,
    String? url,
    String? type,
    int? size,
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
      if (configId != null) 'configId': configId,
      if (name != null) 'name': name,
      'path': path,
      'url': url,
      if (type != null) 'type': type,
      'size': size,
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

class _InfraFileImpl extends InfraFile {
  _InfraFileImpl({
    int? id,
    int? configId,
    String? name,
    required String path,
    required String url,
    String? type,
    required int size,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          configId: configId,
          name: name,
          path: path,
          url: url,
          type: type,
          size: size,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [InfraFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InfraFile copyWith({
    Object? id = _Undefined,
    Object? configId = _Undefined,
    Object? name = _Undefined,
    String? path,
    String? url,
    Object? type = _Undefined,
    int? size,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraFile(
      id: id is int? ? id : this.id,
      configId: configId is int? ? configId : this.configId,
      name: name is String? ? name : this.name,
      path: path ?? this.path,
      url: url ?? this.url,
      type: type is String? ? type : this.type,
      size: size ?? this.size,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
