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

/// 操作日志记录 V2 版本
abstract class SysOperateLog implements _i1.SerializableModel {
  SysOperateLog._({
    this.id,
    int? tenantId,
    required this.traceId,
    required this.userId,
    required this.userType,
    required this.type,
    required this.subType,
    required this.bizId,
    required this.action,
    required this.success,
    required this.extra,
    this.requestMethod,
    this.requestUrl,
    this.userIp,
    this.userAgent,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  })  : tenantId = tenantId ?? 0,
        createTime = createTime ?? DateTime.now();

  factory SysOperateLog({
    int? id,
    int? tenantId,
    required String traceId,
    required int userId,
    required int userType,
    required String type,
    required String subType,
    required int bizId,
    required String action,
    required bool success,
    required String extra,
    String? requestMethod,
    String? requestUrl,
    String? userIp,
    String? userAgent,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysOperateLogImpl;

  factory SysOperateLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysOperateLog(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      traceId: jsonSerialization['traceId'] as String,
      userId: jsonSerialization['userId'] as int,
      userType: jsonSerialization['userType'] as int,
      type: jsonSerialization['type'] as String,
      subType: jsonSerialization['subType'] as String,
      bizId: jsonSerialization['bizId'] as int,
      action: jsonSerialization['action'] as String,
      success: jsonSerialization['success'] as bool,
      extra: jsonSerialization['extra'] as String,
      requestMethod: jsonSerialization['requestMethod'] as String?,
      requestUrl: jsonSerialization['requestUrl'] as String?,
      userIp: jsonSerialization['userIp'] as String?,
      userAgent: jsonSerialization['userAgent'] as String?,
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

  String type;

  String subType;

  int bizId;

  String action;

  bool success;

  String extra;

  String? requestMethod;

  String? requestUrl;

  String? userIp;

  String? userAgent;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysOperateLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysOperateLog copyWith({
    int? id,
    int? tenantId,
    String? traceId,
    int? userId,
    int? userType,
    String? type,
    String? subType,
    int? bizId,
    String? action,
    bool? success,
    String? extra,
    String? requestMethod,
    String? requestUrl,
    String? userIp,
    String? userAgent,
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
      'type': type,
      'subType': subType,
      'bizId': bizId,
      'action': action,
      'success': success,
      'extra': extra,
      if (requestMethod != null) 'requestMethod': requestMethod,
      if (requestUrl != null) 'requestUrl': requestUrl,
      if (userIp != null) 'userIp': userIp,
      if (userAgent != null) 'userAgent': userAgent,
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

class _SysOperateLogImpl extends SysOperateLog {
  _SysOperateLogImpl({
    int? id,
    int? tenantId,
    required String traceId,
    required int userId,
    required int userType,
    required String type,
    required String subType,
    required int bizId,
    required String action,
    required bool success,
    required String extra,
    String? requestMethod,
    String? requestUrl,
    String? userIp,
    String? userAgent,
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
          type: type,
          subType: subType,
          bizId: bizId,
          action: action,
          success: success,
          extra: extra,
          requestMethod: requestMethod,
          requestUrl: requestUrl,
          userIp: userIp,
          userAgent: userAgent,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysOperateLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysOperateLog copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? traceId,
    int? userId,
    int? userType,
    String? type,
    String? subType,
    int? bizId,
    String? action,
    bool? success,
    String? extra,
    Object? requestMethod = _Undefined,
    Object? requestUrl = _Undefined,
    Object? userIp = _Undefined,
    Object? userAgent = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysOperateLog(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      traceId: traceId ?? this.traceId,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      type: type ?? this.type,
      subType: subType ?? this.subType,
      bizId: bizId ?? this.bizId,
      action: action ?? this.action,
      success: success ?? this.success,
      extra: extra ?? this.extra,
      requestMethod:
          requestMethod is String? ? requestMethod : this.requestMethod,
      requestUrl: requestUrl is String? ? requestUrl : this.requestUrl,
      userIp: userIp is String? ? userIp : this.userIp,
      userAgent: userAgent is String? ? userAgent : this.userAgent,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
