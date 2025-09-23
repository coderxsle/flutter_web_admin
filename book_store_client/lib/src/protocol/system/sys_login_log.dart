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

/// 系统访问记录
abstract class SysLoginLog implements _i1.SerializableModel {
  SysLoginLog._({
    this.id,
    required this.tenantId,
    required this.logType,
    required this.traceId,
    required this.userId,
    required this.userType,
    required this.username,
    required this.result,
    required this.userIp,
    required this.userAgent,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysLoginLog({
    int? id,
    required int tenantId,
    required int logType,
    required String traceId,
    required int userId,
    required int userType,
    required String username,
    required int result,
    required String userIp,
    required String userAgent,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysLoginLogImpl;

  factory SysLoginLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysLoginLog(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      logType: jsonSerialization['logType'] as int,
      traceId: jsonSerialization['traceId'] as String,
      userId: jsonSerialization['userId'] as int,
      userType: jsonSerialization['userType'] as int,
      username: jsonSerialization['username'] as String,
      result: jsonSerialization['result'] as int,
      userIp: jsonSerialization['userIp'] as String,
      userAgent: jsonSerialization['userAgent'] as String,
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

  int logType;

  String traceId;

  int userId;

  int userType;

  String username;

  int result;

  String userIp;

  String userAgent;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysLoginLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysLoginLog copyWith({
    int? id,
    int? tenantId,
    int? logType,
    String? traceId,
    int? userId,
    int? userType,
    String? username,
    int? result,
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
      'logType': logType,
      'traceId': traceId,
      'userId': userId,
      'userType': userType,
      'username': username,
      'result': result,
      'userIp': userIp,
      'userAgent': userAgent,
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

class _SysLoginLogImpl extends SysLoginLog {
  _SysLoginLogImpl({
    int? id,
    required int tenantId,
    required int logType,
    required String traceId,
    required int userId,
    required int userType,
    required String username,
    required int result,
    required String userIp,
    required String userAgent,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          logType: logType,
          traceId: traceId,
          userId: userId,
          userType: userType,
          username: username,
          result: result,
          userIp: userIp,
          userAgent: userAgent,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysLoginLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysLoginLog copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? logType,
    String? traceId,
    int? userId,
    int? userType,
    String? username,
    int? result,
    String? userIp,
    String? userAgent,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysLoginLog(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      logType: logType ?? this.logType,
      traceId: traceId ?? this.traceId,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      username: username ?? this.username,
      result: result ?? this.result,
      userIp: userIp ?? this.userIp,
      userAgent: userAgent ?? this.userAgent,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
