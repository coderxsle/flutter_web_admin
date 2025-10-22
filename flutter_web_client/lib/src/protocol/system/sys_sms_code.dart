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

/// 手机验证码
abstract class SysSmsCode implements _i1.SerializableModel {
  SysSmsCode._({
    this.id,
    int? tenantId,
    required this.mobile,
    required this.code,
    required this.createIp,
    required this.scene,
    required this.todayIndex,
    required this.used,
    this.usedTime,
    this.usedIp,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  })  : tenantId = tenantId ?? 0,
        createTime = createTime ?? DateTime.now();

  factory SysSmsCode({
    int? id,
    int? tenantId,
    required String mobile,
    required String code,
    required String createIp,
    required int scene,
    required int todayIndex,
    required int used,
    DateTime? usedTime,
    String? usedIp,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysSmsCodeImpl;

  factory SysSmsCode.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysSmsCode(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      mobile: jsonSerialization['mobile'] as String,
      code: jsonSerialization['code'] as String,
      createIp: jsonSerialization['createIp'] as String,
      scene: jsonSerialization['scene'] as int,
      todayIndex: jsonSerialization['todayIndex'] as int,
      used: jsonSerialization['used'] as int,
      usedTime: jsonSerialization['usedTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['usedTime']),
      usedIp: jsonSerialization['usedIp'] as String?,
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

  String mobile;

  String code;

  String createIp;

  int scene;

  int todayIndex;

  int used;

  DateTime? usedTime;

  String? usedIp;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysSmsCode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysSmsCode copyWith({
    int? id,
    int? tenantId,
    String? mobile,
    String? code,
    String? createIp,
    int? scene,
    int? todayIndex,
    int? used,
    DateTime? usedTime,
    String? usedIp,
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
      'mobile': mobile,
      'code': code,
      'createIp': createIp,
      'scene': scene,
      'todayIndex': todayIndex,
      'used': used,
      if (usedTime != null) 'usedTime': usedTime?.toJson(),
      if (usedIp != null) 'usedIp': usedIp,
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

class _SysSmsCodeImpl extends SysSmsCode {
  _SysSmsCodeImpl({
    int? id,
    int? tenantId,
    required String mobile,
    required String code,
    required String createIp,
    required int scene,
    required int todayIndex,
    required int used,
    DateTime? usedTime,
    String? usedIp,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          mobile: mobile,
          code: code,
          createIp: createIp,
          scene: scene,
          todayIndex: todayIndex,
          used: used,
          usedTime: usedTime,
          usedIp: usedIp,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysSmsCode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysSmsCode copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? mobile,
    String? code,
    String? createIp,
    int? scene,
    int? todayIndex,
    int? used,
    Object? usedTime = _Undefined,
    Object? usedIp = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysSmsCode(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      mobile: mobile ?? this.mobile,
      code: code ?? this.code,
      createIp: createIp ?? this.createIp,
      scene: scene ?? this.scene,
      todayIndex: todayIndex ?? this.todayIndex,
      used: used ?? this.used,
      usedTime: usedTime is DateTime? ? usedTime : this.usedTime,
      usedIp: usedIp is String? ? usedIp : this.usedIp,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
