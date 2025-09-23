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

/// 短信日志
abstract class SysSmsLog implements _i1.SerializableModel {
  SysSmsLog._({
    this.id,
    required this.channelId,
    required this.channelCode,
    required this.templateId,
    required this.templateCode,
    required this.templateType,
    required this.templateContent,
    required this.templateParams,
    required this.apiTemplateId,
    required this.mobile,
    this.userId,
    this.userType,
    required this.sendStatus,
    this.sendTime,
    this.apiSendCode,
    this.apiSendMsg,
    this.apiRequestId,
    this.apiSerialNo,
    required this.receiveStatus,
    this.receiveTime,
    this.apiReceiveCode,
    this.apiReceiveMsg,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysSmsLog({
    int? id,
    required int channelId,
    required String channelCode,
    required int templateId,
    required String templateCode,
    required int templateType,
    required String templateContent,
    required String templateParams,
    required String apiTemplateId,
    required String mobile,
    int? userId,
    int? userType,
    required int sendStatus,
    DateTime? sendTime,
    String? apiSendCode,
    String? apiSendMsg,
    String? apiRequestId,
    String? apiSerialNo,
    required int receiveStatus,
    DateTime? receiveTime,
    String? apiReceiveCode,
    String? apiReceiveMsg,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysSmsLogImpl;

  factory SysSmsLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysSmsLog(
      id: jsonSerialization['id'] as int?,
      channelId: jsonSerialization['channelId'] as int,
      channelCode: jsonSerialization['channelCode'] as String,
      templateId: jsonSerialization['templateId'] as int,
      templateCode: jsonSerialization['templateCode'] as String,
      templateType: jsonSerialization['templateType'] as int,
      templateContent: jsonSerialization['templateContent'] as String,
      templateParams: jsonSerialization['templateParams'] as String,
      apiTemplateId: jsonSerialization['apiTemplateId'] as String,
      mobile: jsonSerialization['mobile'] as String,
      userId: jsonSerialization['userId'] as int?,
      userType: jsonSerialization['userType'] as int?,
      sendStatus: jsonSerialization['sendStatus'] as int,
      sendTime: jsonSerialization['sendTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sendTime']),
      apiSendCode: jsonSerialization['apiSendCode'] as String?,
      apiSendMsg: jsonSerialization['apiSendMsg'] as String?,
      apiRequestId: jsonSerialization['apiRequestId'] as String?,
      apiSerialNo: jsonSerialization['apiSerialNo'] as String?,
      receiveStatus: jsonSerialization['receiveStatus'] as int,
      receiveTime: jsonSerialization['receiveTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['receiveTime']),
      apiReceiveCode: jsonSerialization['apiReceiveCode'] as String?,
      apiReceiveMsg: jsonSerialization['apiReceiveMsg'] as String?,
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

  int channelId;

  String channelCode;

  int templateId;

  String templateCode;

  int templateType;

  String templateContent;

  String templateParams;

  String apiTemplateId;

  String mobile;

  int? userId;

  int? userType;

  int sendStatus;

  DateTime? sendTime;

  String? apiSendCode;

  String? apiSendMsg;

  String? apiRequestId;

  String? apiSerialNo;

  int receiveStatus;

  DateTime? receiveTime;

  String? apiReceiveCode;

  String? apiReceiveMsg;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysSmsLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysSmsLog copyWith({
    int? id,
    int? channelId,
    String? channelCode,
    int? templateId,
    String? templateCode,
    int? templateType,
    String? templateContent,
    String? templateParams,
    String? apiTemplateId,
    String? mobile,
    int? userId,
    int? userType,
    int? sendStatus,
    DateTime? sendTime,
    String? apiSendCode,
    String? apiSendMsg,
    String? apiRequestId,
    String? apiSerialNo,
    int? receiveStatus,
    DateTime? receiveTime,
    String? apiReceiveCode,
    String? apiReceiveMsg,
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
      'channelId': channelId,
      'channelCode': channelCode,
      'templateId': templateId,
      'templateCode': templateCode,
      'templateType': templateType,
      'templateContent': templateContent,
      'templateParams': templateParams,
      'apiTemplateId': apiTemplateId,
      'mobile': mobile,
      if (userId != null) 'userId': userId,
      if (userType != null) 'userType': userType,
      'sendStatus': sendStatus,
      if (sendTime != null) 'sendTime': sendTime?.toJson(),
      if (apiSendCode != null) 'apiSendCode': apiSendCode,
      if (apiSendMsg != null) 'apiSendMsg': apiSendMsg,
      if (apiRequestId != null) 'apiRequestId': apiRequestId,
      if (apiSerialNo != null) 'apiSerialNo': apiSerialNo,
      'receiveStatus': receiveStatus,
      if (receiveTime != null) 'receiveTime': receiveTime?.toJson(),
      if (apiReceiveCode != null) 'apiReceiveCode': apiReceiveCode,
      if (apiReceiveMsg != null) 'apiReceiveMsg': apiReceiveMsg,
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

class _SysSmsLogImpl extends SysSmsLog {
  _SysSmsLogImpl({
    int? id,
    required int channelId,
    required String channelCode,
    required int templateId,
    required String templateCode,
    required int templateType,
    required String templateContent,
    required String templateParams,
    required String apiTemplateId,
    required String mobile,
    int? userId,
    int? userType,
    required int sendStatus,
    DateTime? sendTime,
    String? apiSendCode,
    String? apiSendMsg,
    String? apiRequestId,
    String? apiSerialNo,
    required int receiveStatus,
    DateTime? receiveTime,
    String? apiReceiveCode,
    String? apiReceiveMsg,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          channelId: channelId,
          channelCode: channelCode,
          templateId: templateId,
          templateCode: templateCode,
          templateType: templateType,
          templateContent: templateContent,
          templateParams: templateParams,
          apiTemplateId: apiTemplateId,
          mobile: mobile,
          userId: userId,
          userType: userType,
          sendStatus: sendStatus,
          sendTime: sendTime,
          apiSendCode: apiSendCode,
          apiSendMsg: apiSendMsg,
          apiRequestId: apiRequestId,
          apiSerialNo: apiSerialNo,
          receiveStatus: receiveStatus,
          receiveTime: receiveTime,
          apiReceiveCode: apiReceiveCode,
          apiReceiveMsg: apiReceiveMsg,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysSmsLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysSmsLog copyWith({
    Object? id = _Undefined,
    int? channelId,
    String? channelCode,
    int? templateId,
    String? templateCode,
    int? templateType,
    String? templateContent,
    String? templateParams,
    String? apiTemplateId,
    String? mobile,
    Object? userId = _Undefined,
    Object? userType = _Undefined,
    int? sendStatus,
    Object? sendTime = _Undefined,
    Object? apiSendCode = _Undefined,
    Object? apiSendMsg = _Undefined,
    Object? apiRequestId = _Undefined,
    Object? apiSerialNo = _Undefined,
    int? receiveStatus,
    Object? receiveTime = _Undefined,
    Object? apiReceiveCode = _Undefined,
    Object? apiReceiveMsg = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysSmsLog(
      id: id is int? ? id : this.id,
      channelId: channelId ?? this.channelId,
      channelCode: channelCode ?? this.channelCode,
      templateId: templateId ?? this.templateId,
      templateCode: templateCode ?? this.templateCode,
      templateType: templateType ?? this.templateType,
      templateContent: templateContent ?? this.templateContent,
      templateParams: templateParams ?? this.templateParams,
      apiTemplateId: apiTemplateId ?? this.apiTemplateId,
      mobile: mobile ?? this.mobile,
      userId: userId is int? ? userId : this.userId,
      userType: userType is int? ? userType : this.userType,
      sendStatus: sendStatus ?? this.sendStatus,
      sendTime: sendTime is DateTime? ? sendTime : this.sendTime,
      apiSendCode: apiSendCode is String? ? apiSendCode : this.apiSendCode,
      apiSendMsg: apiSendMsg is String? ? apiSendMsg : this.apiSendMsg,
      apiRequestId: apiRequestId is String? ? apiRequestId : this.apiRequestId,
      apiSerialNo: apiSerialNo is String? ? apiSerialNo : this.apiSerialNo,
      receiveStatus: receiveStatus ?? this.receiveStatus,
      receiveTime: receiveTime is DateTime? ? receiveTime : this.receiveTime,
      apiReceiveCode:
          apiReceiveCode is String? ? apiReceiveCode : this.apiReceiveCode,
      apiReceiveMsg:
          apiReceiveMsg is String? ? apiReceiveMsg : this.apiReceiveMsg,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
