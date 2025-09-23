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

/// 定时任务表
abstract class InfraJob implements _i1.SerializableModel {
  InfraJob._({
    this.id,
    required this.name,
    required this.status,
    required this.handlerName,
    this.handlerParam,
    required this.cronExpression,
    required this.retryCount,
    required this.retryInterval,
    required this.monitorTimeout,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory InfraJob({
    int? id,
    required String name,
    required int status,
    required String handlerName,
    String? handlerParam,
    required String cronExpression,
    required int retryCount,
    required int retryInterval,
    required int monitorTimeout,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraJobImpl;

  factory InfraJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraJob(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      status: jsonSerialization['status'] as int,
      handlerName: jsonSerialization['handlerName'] as String,
      handlerParam: jsonSerialization['handlerParam'] as String?,
      cronExpression: jsonSerialization['cronExpression'] as String,
      retryCount: jsonSerialization['retryCount'] as int,
      retryInterval: jsonSerialization['retryInterval'] as int,
      monitorTimeout: jsonSerialization['monitorTimeout'] as int,
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

  int status;

  String handlerName;

  String? handlerParam;

  String cronExpression;

  int retryCount;

  int retryInterval;

  int monitorTimeout;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [InfraJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InfraJob copyWith({
    int? id,
    String? name,
    int? status,
    String? handlerName,
    String? handlerParam,
    String? cronExpression,
    int? retryCount,
    int? retryInterval,
    int? monitorTimeout,
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
      'handlerName': handlerName,
      if (handlerParam != null) 'handlerParam': handlerParam,
      'cronExpression': cronExpression,
      'retryCount': retryCount,
      'retryInterval': retryInterval,
      'monitorTimeout': monitorTimeout,
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

class _InfraJobImpl extends InfraJob {
  _InfraJobImpl({
    int? id,
    required String name,
    required int status,
    required String handlerName,
    String? handlerParam,
    required String cronExpression,
    required int retryCount,
    required int retryInterval,
    required int monitorTimeout,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          name: name,
          status: status,
          handlerName: handlerName,
          handlerParam: handlerParam,
          cronExpression: cronExpression,
          retryCount: retryCount,
          retryInterval: retryInterval,
          monitorTimeout: monitorTimeout,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [InfraJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InfraJob copyWith({
    Object? id = _Undefined,
    String? name,
    int? status,
    String? handlerName,
    Object? handlerParam = _Undefined,
    String? cronExpression,
    int? retryCount,
    int? retryInterval,
    int? monitorTimeout,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraJob(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      status: status ?? this.status,
      handlerName: handlerName ?? this.handlerName,
      handlerParam: handlerParam is String? ? handlerParam : this.handlerParam,
      cronExpression: cronExpression ?? this.cronExpression,
      retryCount: retryCount ?? this.retryCount,
      retryInterval: retryInterval ?? this.retryInterval,
      monitorTimeout: monitorTimeout ?? this.monitorTimeout,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
