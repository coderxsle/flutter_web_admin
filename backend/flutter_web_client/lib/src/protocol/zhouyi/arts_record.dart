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
import 'package:flutter_web_client/src/protocol/protocol.dart' as _is5docn0;
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// 术数排盘记录表
abstract class ArtsRecord implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ArtsRecord._({
    this.id,
    int? tenantId,
    required this.userId,
    required this.artsType,
    required this.clientKey,
    String? title,
    String? question,
    required this.chartTime,
    String? queryParams,
    String? chartSnapshot,
    String? interpretation,
    String? feedback,
    this.tags,
    int? status,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : tenantId = tenantId ?? 0,
       title = title ?? '',
       question = question ?? '',
       queryParams = queryParams ?? '',
       chartSnapshot = chartSnapshot ?? '',
       interpretation = interpretation ?? '',
       feedback = feedback ?? '',
       status = status ?? 1,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ArtsRecord({
    int? id,
    int? tenantId,
    required int userId,
    required String artsType,
    required String clientKey,
    String? title,
    String? question,
    required DateTime chartTime,
    String? queryParams,
    String? chartSnapshot,
    String? interpretation,
    String? feedback,
    List<String>? tags,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ArtsRecordImpl;

  factory ArtsRecord.fromJson(Map<String, dynamic> jsonSerialization) {
    return ArtsRecord(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      userId: jsonSerialization['userId'] as int,
      artsType: jsonSerialization['artsType'] as String,
      clientKey: jsonSerialization['clientKey'] as String,
      title: jsonSerialization['title'] as String?,
      question: jsonSerialization['question'] as String?,
      chartTime: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['chartTime']),
      queryParams: jsonSerialization['queryParams'] as String?,
      chartSnapshot: jsonSerialization['chartSnapshot'] as String?,
      interpretation: jsonSerialization['interpretation'] as String?,
      feedback: jsonSerialization['feedback'] as String?,
      tags: jsonSerialization['tags'] == null
          ? null
          : _is5docn0.Protocol().deserialize<List<String>>(jsonSerialization['tags']),
      status: jsonSerialization['status'] as int?,
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

  /// 租户ID（0 表示系统租户）
  int tenantId;

  /// 用户ID（sys_user.id）
  int userId;

  /// 术数类型：qimen（奇门）/ bazi（八字）
  String artsType;

  /// 客户端记录键：同一条排盘重复上报时据此幂等（本地记录 id）
  String clientKey;

  /// 标题：奇门取占事，八字取命主姓名
  String title;

  /// 占事
  String question;

  /// 排盘时间（八字为真太阳时校正后的时刻）
  DateTime chartTime;

  /// 起盘参数（JSON 文本）
  String queryParams;

  /// 排盘快照（JSON 文本）
  String chartSnapshot;

  /// 卦解/断语
  String interpretation;

  /// 反馈/应验
  String feedback;

  /// 标签
  List<String>? tags;

  /// 状态（1=正常，0=禁用）
  int status;

  /// 是否删除
  bool deleted;

  /// 创建者
  String? creator;

  /// 创建时间
  DateTime createTime;

  /// 更新者
  String? updater;

  /// 更新时间
  DateTime updateTime;

  /// Returns a shallow copy of this [ArtsRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ArtsRecord copyWith({
    int? id,
    int? tenantId,
    int? userId,
    String? artsType,
    String? clientKey,
    String? title,
    String? question,
    DateTime? chartTime,
    String? queryParams,
    String? chartSnapshot,
    String? interpretation,
    String? feedback,
    List<String>? tags,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ArtsRecord',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'userId': userId,
      'artsType': artsType,
      'clientKey': clientKey,
      'title': title,
      'question': question,
      'chartTime': chartTime.toJson(),
      'queryParams': queryParams,
      'chartSnapshot': chartSnapshot,
      'interpretation': interpretation,
      'feedback': feedback,
      if (tags != null) 'tags': tags?.toJson(),
      'status': status,
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
      '__className__': 'ArtsRecord',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'userId': userId,
      'artsType': artsType,
      'clientKey': clientKey,
      'title': title,
      'question': question,
      'chartTime': chartTime.toJson(),
      'queryParams': queryParams,
      'chartSnapshot': chartSnapshot,
      'interpretation': interpretation,
      'feedback': feedback,
      if (tags != null) 'tags': tags?.toJson(),
      'status': status,
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

class _ArtsRecordImpl extends ArtsRecord {
  _ArtsRecordImpl({
    int? id,
    int? tenantId,
    required int userId,
    required String artsType,
    required String clientKey,
    String? title,
    String? question,
    required DateTime chartTime,
    String? queryParams,
    String? chartSnapshot,
    String? interpretation,
    String? feedback,
    List<String>? tags,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         userId: userId,
         artsType: artsType,
         clientKey: clientKey,
         title: title,
         question: question,
         chartTime: chartTime,
         queryParams: queryParams,
         chartSnapshot: chartSnapshot,
         interpretation: interpretation,
         feedback: feedback,
         tags: tags,
         status: status,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ArtsRecord]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ArtsRecord copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? userId,
    String? artsType,
    String? clientKey,
    String? title,
    String? question,
    DateTime? chartTime,
    String? queryParams,
    String? chartSnapshot,
    String? interpretation,
    String? feedback,
    Object? tags = _Undefined,
    int? status,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ArtsRecord(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      userId: userId ?? this.userId,
      artsType: artsType ?? this.artsType,
      clientKey: clientKey ?? this.clientKey,
      title: title ?? this.title,
      question: question ?? this.question,
      chartTime: chartTime ?? this.chartTime,
      queryParams: queryParams ?? this.queryParams,
      chartSnapshot: chartSnapshot ?? this.chartSnapshot,
      interpretation: interpretation ?? this.interpretation,
      feedback: feedback ?? this.feedback,
      tags: tags is List<String>? ? tags : this.tags?.map((e0) => e0).toList(),
      status: status ?? this.status,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}
