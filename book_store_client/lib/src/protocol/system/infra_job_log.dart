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

/// 定时任务日志表
abstract class InfraJobLog implements _i1.SerializableModel {
  InfraJobLog._({
    this.id,
    required this.jobId,
    required this.handlerName,
    this.handlerParam,
    required this.executeIndex,
    required this.beginTime,
    this.endTime,
    this.duration,
    required this.status,
    this.result,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory InfraJobLog({
    int? id,
    required int jobId,
    required String handlerName,
    String? handlerParam,
    required int executeIndex,
    required DateTime beginTime,
    DateTime? endTime,
    int? duration,
    required int status,
    String? result,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraJobLogImpl;

  factory InfraJobLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraJobLog(
      id: jsonSerialization['id'] as int?,
      jobId: jsonSerialization['jobId'] as int,
      handlerName: jsonSerialization['handlerName'] as String,
      handlerParam: jsonSerialization['handlerParam'] as String?,
      executeIndex: jsonSerialization['executeIndex'] as int,
      beginTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['beginTime']),
      endTime: jsonSerialization['endTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
      duration: jsonSerialization['duration'] as int?,
      status: jsonSerialization['status'] as int,
      result: jsonSerialization['result'] as String?,
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

  int jobId;

  String handlerName;

  String? handlerParam;

  int executeIndex;

  DateTime beginTime;

  DateTime? endTime;

  int? duration;

  int status;

  String? result;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [InfraJobLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InfraJobLog copyWith({
    int? id,
    int? jobId,
    String? handlerName,
    String? handlerParam,
    int? executeIndex,
    DateTime? beginTime,
    DateTime? endTime,
    int? duration,
    int? status,
    String? result,
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
      'jobId': jobId,
      'handlerName': handlerName,
      if (handlerParam != null) 'handlerParam': handlerParam,
      'executeIndex': executeIndex,
      'beginTime': beginTime.toJson(),
      if (endTime != null) 'endTime': endTime?.toJson(),
      if (duration != null) 'duration': duration,
      'status': status,
      if (result != null) 'result': result,
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

class _InfraJobLogImpl extends InfraJobLog {
  _InfraJobLogImpl({
    int? id,
    required int jobId,
    required String handlerName,
    String? handlerParam,
    required int executeIndex,
    required DateTime beginTime,
    DateTime? endTime,
    int? duration,
    required int status,
    String? result,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          jobId: jobId,
          handlerName: handlerName,
          handlerParam: handlerParam,
          executeIndex: executeIndex,
          beginTime: beginTime,
          endTime: endTime,
          duration: duration,
          status: status,
          result: result,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [InfraJobLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InfraJobLog copyWith({
    Object? id = _Undefined,
    int? jobId,
    String? handlerName,
    Object? handlerParam = _Undefined,
    int? executeIndex,
    DateTime? beginTime,
    Object? endTime = _Undefined,
    Object? duration = _Undefined,
    int? status,
    Object? result = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraJobLog(
      id: id is int? ? id : this.id,
      jobId: jobId ?? this.jobId,
      handlerName: handlerName ?? this.handlerName,
      handlerParam: handlerParam is String? ? handlerParam : this.handlerParam,
      executeIndex: executeIndex ?? this.executeIndex,
      beginTime: beginTime ?? this.beginTime,
      endTime: endTime is DateTime? ? endTime : this.endTime,
      duration: duration is int? ? duration : this.duration,
      status: status ?? this.status,
      result: result is String? ? result : this.result,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
