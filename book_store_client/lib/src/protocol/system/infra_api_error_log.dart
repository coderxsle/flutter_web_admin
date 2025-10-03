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

/// 系统异常日志
abstract class InfraApiErrorLog implements _i1.SerializableModel {
  InfraApiErrorLog._({
    this.id,
    int? tenantId,
    required this.traceId,
    required this.userId,
    required this.userType,
    required this.applicationName,
    required this.requestMethod,
    required this.requestUrl,
    required this.requestParams,
    required this.userIp,
    required this.userAgent,
    required this.exceptionTime,
    required this.exceptionName,
    required this.exceptionMessage,
    required this.exceptionRootCauseMessage,
    required this.exceptionStackTrace,
    required this.exceptionClassName,
    required this.exceptionFileName,
    required this.exceptionMethodName,
    required this.exceptionLineNumber,
    required this.processStatus,
    this.processTime,
    this.processUserId,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  })  : tenantId = tenantId ?? 0,
        createTime = createTime ?? DateTime.now();

  factory InfraApiErrorLog({
    int? id,
    int? tenantId,
    required String traceId,
    required int userId,
    required int userType,
    required String applicationName,
    required String requestMethod,
    required String requestUrl,
    required String requestParams,
    required String userIp,
    required String userAgent,
    required DateTime exceptionTime,
    required String exceptionName,
    required String exceptionMessage,
    required String exceptionRootCauseMessage,
    required String exceptionStackTrace,
    required String exceptionClassName,
    required String exceptionFileName,
    required String exceptionMethodName,
    required int exceptionLineNumber,
    required int processStatus,
    DateTime? processTime,
    int? processUserId,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraApiErrorLogImpl;

  factory InfraApiErrorLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraApiErrorLog(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      traceId: jsonSerialization['traceId'] as String,
      userId: jsonSerialization['userId'] as int,
      userType: jsonSerialization['userType'] as int,
      applicationName: jsonSerialization['applicationName'] as String,
      requestMethod: jsonSerialization['requestMethod'] as String,
      requestUrl: jsonSerialization['requestUrl'] as String,
      requestParams: jsonSerialization['requestParams'] as String,
      userIp: jsonSerialization['userIp'] as String,
      userAgent: jsonSerialization['userAgent'] as String,
      exceptionTime: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['exceptionTime']),
      exceptionName: jsonSerialization['exceptionName'] as String,
      exceptionMessage: jsonSerialization['exceptionMessage'] as String,
      exceptionRootCauseMessage:
          jsonSerialization['exceptionRootCauseMessage'] as String,
      exceptionStackTrace: jsonSerialization['exceptionStackTrace'] as String,
      exceptionClassName: jsonSerialization['exceptionClassName'] as String,
      exceptionFileName: jsonSerialization['exceptionFileName'] as String,
      exceptionMethodName: jsonSerialization['exceptionMethodName'] as String,
      exceptionLineNumber: jsonSerialization['exceptionLineNumber'] as int,
      processStatus: jsonSerialization['processStatus'] as int,
      processTime: jsonSerialization['processTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['processTime']),
      processUserId: jsonSerialization['processUserId'] as int?,
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

  int tenantId;

  String traceId;

  int userId;

  int userType;

  String applicationName;

  String requestMethod;

  String requestUrl;

  String requestParams;

  String userIp;

  String userAgent;

  DateTime exceptionTime;

  String exceptionName;

  String exceptionMessage;

  String exceptionRootCauseMessage;

  String exceptionStackTrace;

  String exceptionClassName;

  String exceptionFileName;

  String exceptionMethodName;

  int exceptionLineNumber;

  int processStatus;

  DateTime? processTime;

  int? processUserId;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [InfraApiErrorLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InfraApiErrorLog copyWith({
    int? id,
    int? tenantId,
    String? traceId,
    int? userId,
    int? userType,
    String? applicationName,
    String? requestMethod,
    String? requestUrl,
    String? requestParams,
    String? userIp,
    String? userAgent,
    DateTime? exceptionTime,
    String? exceptionName,
    String? exceptionMessage,
    String? exceptionRootCauseMessage,
    String? exceptionStackTrace,
    String? exceptionClassName,
    String? exceptionFileName,
    String? exceptionMethodName,
    int? exceptionLineNumber,
    int? processStatus,
    DateTime? processTime,
    int? processUserId,
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
      'tenantId': tenantId,
      'traceId': traceId,
      'userId': userId,
      'userType': userType,
      'applicationName': applicationName,
      'requestMethod': requestMethod,
      'requestUrl': requestUrl,
      'requestParams': requestParams,
      'userIp': userIp,
      'userAgent': userAgent,
      'exceptionTime': exceptionTime.toJson(),
      'exceptionName': exceptionName,
      'exceptionMessage': exceptionMessage,
      'exceptionRootCauseMessage': exceptionRootCauseMessage,
      'exceptionStackTrace': exceptionStackTrace,
      'exceptionClassName': exceptionClassName,
      'exceptionFileName': exceptionFileName,
      'exceptionMethodName': exceptionMethodName,
      'exceptionLineNumber': exceptionLineNumber,
      'processStatus': processStatus,
      if (processTime != null) 'processTime': processTime?.toJson(),
      if (processUserId != null) 'processUserId': processUserId,
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

class _InfraApiErrorLogImpl extends InfraApiErrorLog {
  _InfraApiErrorLogImpl({
    int? id,
    int? tenantId,
    required String traceId,
    required int userId,
    required int userType,
    required String applicationName,
    required String requestMethod,
    required String requestUrl,
    required String requestParams,
    required String userIp,
    required String userAgent,
    required DateTime exceptionTime,
    required String exceptionName,
    required String exceptionMessage,
    required String exceptionRootCauseMessage,
    required String exceptionStackTrace,
    required String exceptionClassName,
    required String exceptionFileName,
    required String exceptionMethodName,
    required int exceptionLineNumber,
    required int processStatus,
    DateTime? processTime,
    int? processUserId,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          traceId: traceId,
          userId: userId,
          userType: userType,
          applicationName: applicationName,
          requestMethod: requestMethod,
          requestUrl: requestUrl,
          requestParams: requestParams,
          userIp: userIp,
          userAgent: userAgent,
          exceptionTime: exceptionTime,
          exceptionName: exceptionName,
          exceptionMessage: exceptionMessage,
          exceptionRootCauseMessage: exceptionRootCauseMessage,
          exceptionStackTrace: exceptionStackTrace,
          exceptionClassName: exceptionClassName,
          exceptionFileName: exceptionFileName,
          exceptionMethodName: exceptionMethodName,
          exceptionLineNumber: exceptionLineNumber,
          processStatus: processStatus,
          processTime: processTime,
          processUserId: processUserId,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [InfraApiErrorLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InfraApiErrorLog copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? traceId,
    int? userId,
    int? userType,
    String? applicationName,
    String? requestMethod,
    String? requestUrl,
    String? requestParams,
    String? userIp,
    String? userAgent,
    DateTime? exceptionTime,
    String? exceptionName,
    String? exceptionMessage,
    String? exceptionRootCauseMessage,
    String? exceptionStackTrace,
    String? exceptionClassName,
    String? exceptionFileName,
    String? exceptionMethodName,
    int? exceptionLineNumber,
    int? processStatus,
    Object? processTime = _Undefined,
    Object? processUserId = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraApiErrorLog(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      traceId: traceId ?? this.traceId,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      applicationName: applicationName ?? this.applicationName,
      requestMethod: requestMethod ?? this.requestMethod,
      requestUrl: requestUrl ?? this.requestUrl,
      requestParams: requestParams ?? this.requestParams,
      userIp: userIp ?? this.userIp,
      userAgent: userAgent ?? this.userAgent,
      exceptionTime: exceptionTime ?? this.exceptionTime,
      exceptionName: exceptionName ?? this.exceptionName,
      exceptionMessage: exceptionMessage ?? this.exceptionMessage,
      exceptionRootCauseMessage:
          exceptionRootCauseMessage ?? this.exceptionRootCauseMessage,
      exceptionStackTrace: exceptionStackTrace ?? this.exceptionStackTrace,
      exceptionClassName: exceptionClassName ?? this.exceptionClassName,
      exceptionFileName: exceptionFileName ?? this.exceptionFileName,
      exceptionMethodName: exceptionMethodName ?? this.exceptionMethodName,
      exceptionLineNumber: exceptionLineNumber ?? this.exceptionLineNumber,
      processStatus: processStatus ?? this.processStatus,
      processTime: processTime is DateTime? ? processTime : this.processTime,
      processUserId: processUserId is int? ? processUserId : this.processUserId,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
