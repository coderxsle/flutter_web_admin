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

/// 站内信模板表
abstract class SysNotifyTemplate implements _i1.SerializableModel {
  SysNotifyTemplate._({
    this.id,
    required this.name,
    required this.code,
    required this.nickname,
    required this.content,
    required this.type,
    this.params,
    required this.status,
    this.remark,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysNotifyTemplate({
    int? id,
    required String name,
    required String code,
    required String nickname,
    required String content,
    required int type,
    String? params,
    required int status,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysNotifyTemplateImpl;

  factory SysNotifyTemplate.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysNotifyTemplate(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      nickname: jsonSerialization['nickname'] as String,
      content: jsonSerialization['content'] as String,
      type: jsonSerialization['type'] as int,
      params: jsonSerialization['params'] as String?,
      status: jsonSerialization['status'] as int,
      remark: jsonSerialization['remark'] as String?,
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

  String name;

  String code;

  String nickname;

  String content;

  int type;

  String? params;

  int status;

  String? remark;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysNotifyTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysNotifyTemplate copyWith({
    int? id,
    String? name,
    String? code,
    String? nickname,
    String? content,
    int? type,
    String? params,
    int? status,
    String? remark,
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
      'name': name,
      'code': code,
      'nickname': nickname,
      'content': content,
      'type': type,
      if (params != null) 'params': params,
      'status': status,
      if (remark != null) 'remark': remark,
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

class _SysNotifyTemplateImpl extends SysNotifyTemplate {
  _SysNotifyTemplateImpl({
    int? id,
    required String name,
    required String code,
    required String nickname,
    required String content,
    required int type,
    String? params,
    required int status,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          name: name,
          code: code,
          nickname: nickname,
          content: content,
          type: type,
          params: params,
          status: status,
          remark: remark,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysNotifyTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysNotifyTemplate copyWith({
    Object? id = _Undefined,
    String? name,
    String? code,
    String? nickname,
    String? content,
    int? type,
    Object? params = _Undefined,
    int? status,
    Object? remark = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysNotifyTemplate(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      nickname: nickname ?? this.nickname,
      content: content ?? this.content,
      type: type ?? this.type,
      params: params is String? ? params : this.params,
      status: status ?? this.status,
      remark: remark is String? ? remark : this.remark,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
