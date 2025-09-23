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

/// 文件配置表
abstract class InfraFileConfig implements _i1.SerializableModel {
  InfraFileConfig._({
    this.id,
    required this.name,
    required this.storage,
    this.remark,
    required this.master,
    required this.config,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory InfraFileConfig({
    int? id,
    required String name,
    required int storage,
    String? remark,
    required bool master,
    required String config,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraFileConfigImpl;

  factory InfraFileConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraFileConfig(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      storage: jsonSerialization['storage'] as int,
      remark: jsonSerialization['remark'] as String?,
      master: jsonSerialization['master'] as bool,
      config: jsonSerialization['config'] as String,
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

  String name;

  int storage;

  String? remark;

  bool master;

  String config;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [InfraFileConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InfraFileConfig copyWith({
    int? id,
    String? name,
    int? storage,
    String? remark,
    bool? master,
    String? config,
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
      'storage': storage,
      if (remark != null) 'remark': remark,
      'master': master,
      'config': config,
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

class _InfraFileConfigImpl extends InfraFileConfig {
  _InfraFileConfigImpl({
    int? id,
    required String name,
    required int storage,
    String? remark,
    required bool master,
    required String config,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          name: name,
          storage: storage,
          remark: remark,
          master: master,
          config: config,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [InfraFileConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InfraFileConfig copyWith({
    Object? id = _Undefined,
    String? name,
    int? storage,
    Object? remark = _Undefined,
    bool? master,
    String? config,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraFileConfig(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      storage: storage ?? this.storage,
      remark: remark is String? ? remark : this.remark,
      master: master ?? this.master,
      config: config ?? this.config,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
