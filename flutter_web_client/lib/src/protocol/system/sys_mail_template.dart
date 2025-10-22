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

/// 邮件模版表
abstract class SysMailTemplate implements _i1.SerializableModel {
  SysMailTemplate._({
    this.id,
    required this.name,
    required this.code,
    required this.accountId,
    this.nickname,
    required this.title,
    required this.content,
    required this.params,
    required this.status,
    this.remark,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysMailTemplate({
    int? id,
    required String name,
    required String code,
    required int accountId,
    String? nickname,
    required String title,
    required String content,
    required String params,
    required int status,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysMailTemplateImpl;

  factory SysMailTemplate.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysMailTemplate(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      accountId: jsonSerialization['accountId'] as int,
      nickname: jsonSerialization['nickname'] as String?,
      title: jsonSerialization['title'] as String,
      content: jsonSerialization['content'] as String,
      params: jsonSerialization['params'] as String,
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

  int accountId;

  String? nickname;

  String title;

  String content;

  String params;

  int status;

  String? remark;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysMailTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysMailTemplate copyWith({
    int? id,
    String? name,
    String? code,
    int? accountId,
    String? nickname,
    String? title,
    String? content,
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
      'accountId': accountId,
      if (nickname != null) 'nickname': nickname,
      'title': title,
      'content': content,
      'params': params,
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

class _SysMailTemplateImpl extends SysMailTemplate {
  _SysMailTemplateImpl({
    int? id,
    required String name,
    required String code,
    required int accountId,
    String? nickname,
    required String title,
    required String content,
    required String params,
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
          accountId: accountId,
          nickname: nickname,
          title: title,
          content: content,
          params: params,
          status: status,
          remark: remark,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysMailTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysMailTemplate copyWith({
    Object? id = _Undefined,
    String? name,
    String? code,
    int? accountId,
    Object? nickname = _Undefined,
    String? title,
    String? content,
    String? params,
    int? status,
    Object? remark = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysMailTemplate(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      accountId: accountId ?? this.accountId,
      nickname: nickname is String? ? nickname : this.nickname,
      title: title ?? this.title,
      content: content ?? this.content,
      params: params ?? this.params,
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
