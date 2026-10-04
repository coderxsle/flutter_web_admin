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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// 患者档案访问审计日志；不得在日志中保存患者身份证号或病史内容。
abstract class ZhongyiPatientAccessLog implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ZhongyiPatientAccessLog._({
    this.id,
    int? tenantId,
    this.patientId,
    required this.action,
    this.actorId,
    DateTime? accessTime,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : tenantId = tenantId ?? 0,
       accessTime = accessTime ?? DateTime.now(),
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ZhongyiPatientAccessLog({
    int? id,
    int? tenantId,
    int? patientId,
    required String action,
    int? actorId,
    DateTime? accessTime,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiPatientAccessLogImpl;

  factory ZhongyiPatientAccessLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiPatientAccessLog(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      patientId: jsonSerialization['patientId'] as int?,
      action: jsonSerialization['action'] as String,
      actorId: jsonSerialization['actorId'] as int?,
      accessTime: jsonSerialization['accessTime'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['accessTime']),
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int tenantId;

  int? patientId;

  String action;

  int? actorId;

  DateTime accessTime;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  /// Returns a shallow copy of this [ZhongyiPatientAccessLog]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ZhongyiPatientAccessLog copyWith({
    int? id,
    int? tenantId,
    int? patientId,
    String? action,
    int? actorId,
    DateTime? accessTime,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ZhongyiPatientAccessLog',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (patientId != null) 'patientId': patientId,
      'action': action,
      if (actorId != null) 'actorId': actorId,
      'accessTime': accessTime.toJson(),
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ZhongyiPatientAccessLog',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (patientId != null) 'patientId': patientId,
      'action': action,
      if (actorId != null) 'actorId': actorId,
      'accessTime': accessTime.toJson(),
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ZhongyiPatientAccessLogImpl extends ZhongyiPatientAccessLog {
  _ZhongyiPatientAccessLogImpl({
    int? id,
    int? tenantId,
    int? patientId,
    required String action,
    int? actorId,
    DateTime? accessTime,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         patientId: patientId,
         action: action,
         actorId: actorId,
         accessTime: accessTime,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiPatientAccessLog]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ZhongyiPatientAccessLog copyWith({
    Object? id = _Undefined,
    int? tenantId,
    Object? patientId = _Undefined,
    String? action,
    Object? actorId = _Undefined,
    DateTime? accessTime,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiPatientAccessLog(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      patientId: patientId is int? ? patientId : this.patientId,
      action: action ?? this.action,
      actorId: actorId is int? ? actorId : this.actorId,
      accessTime: accessTime ?? this.accessTime,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}
