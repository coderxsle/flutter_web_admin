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

/// 站内信消息表
abstract class SysNotifyMessage implements _i1.SerializableModel {
  SysNotifyMessage._({
    this.id,
    int? tenantId,
    required this.userId,
    required this.userType,
    required this.templateId,
    required this.templateCode,
    required this.templateNickname,
    required this.templateContent,
    required this.templateType,
    required this.templateParams,
    required this.readStatus,
    this.readTime,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  })  : tenantId = tenantId ?? 0,
        createTime = createTime ?? DateTime.now();

  factory SysNotifyMessage({
    int? id,
    int? tenantId,
    required int userId,
    required int userType,
    required int templateId,
    required String templateCode,
    required String templateNickname,
    required String templateContent,
    required int templateType,
    required String templateParams,
    required bool readStatus,
    DateTime? readTime,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysNotifyMessageImpl;

  factory SysNotifyMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysNotifyMessage(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      userId: jsonSerialization['userId'] as int,
      userType: jsonSerialization['userType'] as int,
      templateId: jsonSerialization['templateId'] as int,
      templateCode: jsonSerialization['templateCode'] as String,
      templateNickname: jsonSerialization['templateNickname'] as String,
      templateContent: jsonSerialization['templateContent'] as String,
      templateType: jsonSerialization['templateType'] as int,
      templateParams: jsonSerialization['templateParams'] as String,
      readStatus: jsonSerialization['readStatus'] as bool,
      readTime: jsonSerialization['readTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['readTime']),
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

  int userId;

  int userType;

  int templateId;

  String templateCode;

  String templateNickname;

  String templateContent;

  int templateType;

  String templateParams;

  bool readStatus;

  DateTime? readTime;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysNotifyMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysNotifyMessage copyWith({
    int? id,
    int? tenantId,
    int? userId,
    int? userType,
    int? templateId,
    String? templateCode,
    String? templateNickname,
    String? templateContent,
    int? templateType,
    String? templateParams,
    bool? readStatus,
    DateTime? readTime,
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
      'userId': userId,
      'userType': userType,
      'templateId': templateId,
      'templateCode': templateCode,
      'templateNickname': templateNickname,
      'templateContent': templateContent,
      'templateType': templateType,
      'templateParams': templateParams,
      'readStatus': readStatus,
      if (readTime != null) 'readTime': readTime?.toJson(),
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

class _SysNotifyMessageImpl extends SysNotifyMessage {
  _SysNotifyMessageImpl({
    int? id,
    int? tenantId,
    required int userId,
    required int userType,
    required int templateId,
    required String templateCode,
    required String templateNickname,
    required String templateContent,
    required int templateType,
    required String templateParams,
    required bool readStatus,
    DateTime? readTime,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          userId: userId,
          userType: userType,
          templateId: templateId,
          templateCode: templateCode,
          templateNickname: templateNickname,
          templateContent: templateContent,
          templateType: templateType,
          templateParams: templateParams,
          readStatus: readStatus,
          readTime: readTime,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysNotifyMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysNotifyMessage copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? userId,
    int? userType,
    int? templateId,
    String? templateCode,
    String? templateNickname,
    String? templateContent,
    int? templateType,
    String? templateParams,
    bool? readStatus,
    Object? readTime = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysNotifyMessage(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      templateId: templateId ?? this.templateId,
      templateCode: templateCode ?? this.templateCode,
      templateNickname: templateNickname ?? this.templateNickname,
      templateContent: templateContent ?? this.templateContent,
      templateType: templateType ?? this.templateType,
      templateParams: templateParams ?? this.templateParams,
      readStatus: readStatus ?? this.readStatus,
      readTime: readTime is DateTime? ? readTime : this.readTime,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
