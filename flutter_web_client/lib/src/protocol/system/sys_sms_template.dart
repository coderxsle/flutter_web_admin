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

/// 短信模板
abstract class SysSmsTemplate implements _i1.SerializableModel {
  SysSmsTemplate._({
    this.id,
    required this.type,
    required this.status,
    required this.code,
    required this.name,
    required this.content,
    required this.params,
    this.remark,
    required this.apiTemplateId,
    required this.channelId,
    required this.channelCode,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysSmsTemplate({
    int? id,
    required int type,
    required int status,
    required String code,
    required String name,
    required String content,
    required String params,
    String? remark,
    required String apiTemplateId,
    required int channelId,
    required String channelCode,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysSmsTemplateImpl;

  factory SysSmsTemplate.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysSmsTemplate(
      id: jsonSerialization['id'] as int?,
      type: jsonSerialization['type'] as int,
      status: jsonSerialization['status'] as int,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      content: jsonSerialization['content'] as String,
      params: jsonSerialization['params'] as String,
      remark: jsonSerialization['remark'] as String?,
      apiTemplateId: jsonSerialization['apiTemplateId'] as String,
      channelId: jsonSerialization['channelId'] as int,
      channelCode: jsonSerialization['channelCode'] as String,
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

  int type;

  int status;

  String code;

  String name;

  String content;

  String params;

  String? remark;

  String apiTemplateId;

  int channelId;

  String channelCode;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysSmsTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysSmsTemplate copyWith({
    int? id,
    int? type,
    int? status,
    String? code,
    String? name,
    String? content,
    String? params,
    String? remark,
    String? apiTemplateId,
    int? channelId,
    String? channelCode,
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
      'type': type,
      'status': status,
      'code': code,
      'name': name,
      'content': content,
      'params': params,
      if (remark != null) 'remark': remark,
      'apiTemplateId': apiTemplateId,
      'channelId': channelId,
      'channelCode': channelCode,
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

class _SysSmsTemplateImpl extends SysSmsTemplate {
  _SysSmsTemplateImpl({
    int? id,
    required int type,
    required int status,
    required String code,
    required String name,
    required String content,
    required String params,
    String? remark,
    required String apiTemplateId,
    required int channelId,
    required String channelCode,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          type: type,
          status: status,
          code: code,
          name: name,
          content: content,
          params: params,
          remark: remark,
          apiTemplateId: apiTemplateId,
          channelId: channelId,
          channelCode: channelCode,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysSmsTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysSmsTemplate copyWith({
    Object? id = _Undefined,
    int? type,
    int? status,
    String? code,
    String? name,
    String? content,
    String? params,
    Object? remark = _Undefined,
    String? apiTemplateId,
    int? channelId,
    String? channelCode,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysSmsTemplate(
      id: id is int? ? id : this.id,
      type: type ?? this.type,
      status: status ?? this.status,
      code: code ?? this.code,
      name: name ?? this.name,
      content: content ?? this.content,
      params: params ?? this.params,
      remark: remark is String? ? remark : this.remark,
      apiTemplateId: apiTemplateId ?? this.apiTemplateId,
      channelId: channelId ?? this.channelId,
      channelCode: channelCode ?? this.channelCode,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
