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

/// 邮件日志表
abstract class SysMailLog implements _i1.SerializableModel {
  SysMailLog._({
    this.id,
    this.userId,
    this.userType,
    required this.toMail,
    required this.accountId,
    required this.fromMail,
    required this.templateId,
    required this.templateCode,
    this.templateNickname,
    required this.templateTitle,
    required this.templateContent,
    required this.templateParams,
    required this.sendStatus,
    this.sendTime,
    this.sendMessageId,
    this.sendException,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysMailLog({
    int? id,
    int? userId,
    int? userType,
    required String toMail,
    required int accountId,
    required String fromMail,
    required int templateId,
    required String templateCode,
    String? templateNickname,
    required String templateTitle,
    required String templateContent,
    required String templateParams,
    required int sendStatus,
    DateTime? sendTime,
    String? sendMessageId,
    String? sendException,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysMailLogImpl;

  factory SysMailLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysMailLog(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int?,
      userType: jsonSerialization['userType'] as int?,
      toMail: jsonSerialization['toMail'] as String,
      accountId: jsonSerialization['accountId'] as int,
      fromMail: jsonSerialization['fromMail'] as String,
      templateId: jsonSerialization['templateId'] as int,
      templateCode: jsonSerialization['templateCode'] as String,
      templateNickname: jsonSerialization['templateNickname'] as String?,
      templateTitle: jsonSerialization['templateTitle'] as String,
      templateContent: jsonSerialization['templateContent'] as String,
      templateParams: jsonSerialization['templateParams'] as String,
      sendStatus: jsonSerialization['sendStatus'] as int,
      sendTime: jsonSerialization['sendTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sendTime']),
      sendMessageId: jsonSerialization['sendMessageId'] as String?,
      sendException: jsonSerialization['sendException'] as String?,
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

  int? userId;

  int? userType;

  String toMail;

  int accountId;

  String fromMail;

  int templateId;

  String templateCode;

  String? templateNickname;

  String templateTitle;

  String templateContent;

  String templateParams;

  int sendStatus;

  DateTime? sendTime;

  String? sendMessageId;

  String? sendException;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysMailLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysMailLog copyWith({
    int? id,
    int? userId,
    int? userType,
    String? toMail,
    int? accountId,
    String? fromMail,
    int? templateId,
    String? templateCode,
    String? templateNickname,
    String? templateTitle,
    String? templateContent,
    String? templateParams,
    int? sendStatus,
    DateTime? sendTime,
    String? sendMessageId,
    String? sendException,
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
      if (userId != null) 'userId': userId,
      if (userType != null) 'userType': userType,
      'toMail': toMail,
      'accountId': accountId,
      'fromMail': fromMail,
      'templateId': templateId,
      'templateCode': templateCode,
      if (templateNickname != null) 'templateNickname': templateNickname,
      'templateTitle': templateTitle,
      'templateContent': templateContent,
      'templateParams': templateParams,
      'sendStatus': sendStatus,
      if (sendTime != null) 'sendTime': sendTime?.toJson(),
      if (sendMessageId != null) 'sendMessageId': sendMessageId,
      if (sendException != null) 'sendException': sendException,
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

class _SysMailLogImpl extends SysMailLog {
  _SysMailLogImpl({
    int? id,
    int? userId,
    int? userType,
    required String toMail,
    required int accountId,
    required String fromMail,
    required int templateId,
    required String templateCode,
    String? templateNickname,
    required String templateTitle,
    required String templateContent,
    required String templateParams,
    required int sendStatus,
    DateTime? sendTime,
    String? sendMessageId,
    String? sendException,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          userId: userId,
          userType: userType,
          toMail: toMail,
          accountId: accountId,
          fromMail: fromMail,
          templateId: templateId,
          templateCode: templateCode,
          templateNickname: templateNickname,
          templateTitle: templateTitle,
          templateContent: templateContent,
          templateParams: templateParams,
          sendStatus: sendStatus,
          sendTime: sendTime,
          sendMessageId: sendMessageId,
          sendException: sendException,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysMailLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysMailLog copyWith({
    Object? id = _Undefined,
    Object? userId = _Undefined,
    Object? userType = _Undefined,
    String? toMail,
    int? accountId,
    String? fromMail,
    int? templateId,
    String? templateCode,
    Object? templateNickname = _Undefined,
    String? templateTitle,
    String? templateContent,
    String? templateParams,
    int? sendStatus,
    Object? sendTime = _Undefined,
    Object? sendMessageId = _Undefined,
    Object? sendException = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysMailLog(
      id: id is int? ? id : this.id,
      userId: userId is int? ? userId : this.userId,
      userType: userType is int? ? userType : this.userType,
      toMail: toMail ?? this.toMail,
      accountId: accountId ?? this.accountId,
      fromMail: fromMail ?? this.fromMail,
      templateId: templateId ?? this.templateId,
      templateCode: templateCode ?? this.templateCode,
      templateNickname: templateNickname is String?
          ? templateNickname
          : this.templateNickname,
      templateTitle: templateTitle ?? this.templateTitle,
      templateContent: templateContent ?? this.templateContent,
      templateParams: templateParams ?? this.templateParams,
      sendStatus: sendStatus ?? this.sendStatus,
      sendTime: sendTime is DateTime? ? sendTime : this.sendTime,
      sendMessageId:
          sendMessageId is String? ? sendMessageId : this.sendMessageId,
      sendException:
          sendException is String? ? sendException : this.sendException,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
