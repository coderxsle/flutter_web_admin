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

/// API 访问日志表
abstract class InfraApiAccessLog implements _i1.SerializableModel {
  InfraApiAccessLog._({
    this.id,
    required this.tenantId,
    required this.traceId,
    required this.userId,
    required this.userType,
    required this.applicationName,
    required this.requestMethod,
    required this.requestUrl,
    this.requestParams,
    this.responseBody,
    required this.userIp,
    required this.userAgent,
    this.operateModule,
    this.operateName,
    required this.operateType,
    required this.beginTime,
    required this.endTime,
    required this.duration,
    required this.resultCode,
    this.resultMsg,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory InfraApiAccessLog({
    int? id,
    required int tenantId,
    required String traceId,
    required int userId,
    required int userType,
    required String applicationName,
    required String requestMethod,
    required String requestUrl,
    String? requestParams,
    String? responseBody,
    required String userIp,
    required String userAgent,
    String? operateModule,
    String? operateName,
    required int operateType,
    required DateTime beginTime,
    required DateTime endTime,
    required int duration,
    required int resultCode,
    String? resultMsg,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraApiAccessLogImpl;

  factory InfraApiAccessLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraApiAccessLog(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      traceId: jsonSerialization['traceId'] as String,
      userId: jsonSerialization['userId'] as int,
      userType: jsonSerialization['userType'] as int,
      applicationName: jsonSerialization['applicationName'] as String,
      requestMethod: jsonSerialization['requestMethod'] as String,
      requestUrl: jsonSerialization['requestUrl'] as String,
      requestParams: jsonSerialization['requestParams'] as String?,
      responseBody: jsonSerialization['responseBody'] as String?,
      userIp: jsonSerialization['userIp'] as String,
      userAgent: jsonSerialization['userAgent'] as String,
      operateModule: jsonSerialization['operateModule'] as String?,
      operateName: jsonSerialization['operateName'] as String?,
      operateType: jsonSerialization['operateType'] as int,
      beginTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['beginTime']),
      endTime: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
      duration: jsonSerialization['duration'] as int,
      resultCode: jsonSerialization['resultCode'] as int,
      resultMsg: jsonSerialization['resultMsg'] as String?,
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

  String? requestParams;

  String? responseBody;

  String userIp;

  String userAgent;

  String? operateModule;

  String? operateName;

  int operateType;

  DateTime beginTime;

  DateTime endTime;

  int duration;

  int resultCode;

  String? resultMsg;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [InfraApiAccessLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InfraApiAccessLog copyWith({
    int? id,
    int? tenantId,
    String? traceId,
    int? userId,
    int? userType,
    String? applicationName,
    String? requestMethod,
    String? requestUrl,
    String? requestParams,
    String? responseBody,
    String? userIp,
    String? userAgent,
    String? operateModule,
    String? operateName,
    int? operateType,
    DateTime? beginTime,
    DateTime? endTime,
    int? duration,
    int? resultCode,
    String? resultMsg,
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
      if (requestParams != null) 'requestParams': requestParams,
      if (responseBody != null) 'responseBody': responseBody,
      'userIp': userIp,
      'userAgent': userAgent,
      if (operateModule != null) 'operateModule': operateModule,
      if (operateName != null) 'operateName': operateName,
      'operateType': operateType,
      'beginTime': beginTime.toJson(),
      'endTime': endTime.toJson(),
      'duration': duration,
      'resultCode': resultCode,
      if (resultMsg != null) 'resultMsg': resultMsg,
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

class _InfraApiAccessLogImpl extends InfraApiAccessLog {
  _InfraApiAccessLogImpl({
    int? id,
    required int tenantId,
    required String traceId,
    required int userId,
    required int userType,
    required String applicationName,
    required String requestMethod,
    required String requestUrl,
    String? requestParams,
    String? responseBody,
    required String userIp,
    required String userAgent,
    String? operateModule,
    String? operateName,
    required int operateType,
    required DateTime beginTime,
    required DateTime endTime,
    required int duration,
    required int resultCode,
    String? resultMsg,
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
          responseBody: responseBody,
          userIp: userIp,
          userAgent: userAgent,
          operateModule: operateModule,
          operateName: operateName,
          operateType: operateType,
          beginTime: beginTime,
          endTime: endTime,
          duration: duration,
          resultCode: resultCode,
          resultMsg: resultMsg,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [InfraApiAccessLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InfraApiAccessLog copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? traceId,
    int? userId,
    int? userType,
    String? applicationName,
    String? requestMethod,
    String? requestUrl,
    Object? requestParams = _Undefined,
    Object? responseBody = _Undefined,
    String? userIp,
    String? userAgent,
    Object? operateModule = _Undefined,
    Object? operateName = _Undefined,
    int? operateType,
    DateTime? beginTime,
    DateTime? endTime,
    int? duration,
    int? resultCode,
    Object? resultMsg = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraApiAccessLog(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      traceId: traceId ?? this.traceId,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      applicationName: applicationName ?? this.applicationName,
      requestMethod: requestMethod ?? this.requestMethod,
      requestUrl: requestUrl ?? this.requestUrl,
      requestParams:
          requestParams is String? ? requestParams : this.requestParams,
      responseBody: responseBody is String? ? responseBody : this.responseBody,
      userIp: userIp ?? this.userIp,
      userAgent: userAgent ?? this.userAgent,
      operateModule:
          operateModule is String? ? operateModule : this.operateModule,
      operateName: operateName is String? ? operateName : this.operateName,
      operateType: operateType ?? this.operateType,
      beginTime: beginTime ?? this.beginTime,
      endTime: endTime ?? this.endTime,
      duration: duration ?? this.duration,
      resultCode: resultCode ?? this.resultCode,
      resultMsg: resultMsg is String? ? resultMsg : this.resultMsg,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
