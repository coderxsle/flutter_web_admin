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

/// 社交用户表
abstract class SysSocialUser implements _i1.SerializableModel {
  SysSocialUser._({
    this.id,
    int? tenantId,
    required this.type,
    required this.openid,
    this.token,
    required this.rawTokenInfo,
    required this.nickname,
    this.avatar,
    required this.rawUserInfo,
    required this.code,
    this.state,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  })  : tenantId = tenantId ?? 0,
        createTime = createTime ?? DateTime.now();

  factory SysSocialUser({
    int? id,
    int? tenantId,
    required int type,
    required String openid,
    String? token,
    required String rawTokenInfo,
    required String nickname,
    String? avatar,
    required String rawUserInfo,
    required String code,
    String? state,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysSocialUserImpl;

  factory SysSocialUser.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysSocialUser(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      type: jsonSerialization['type'] as int,
      openid: jsonSerialization['openid'] as String,
      token: jsonSerialization['token'] as String?,
      rawTokenInfo: jsonSerialization['rawTokenInfo'] as String,
      nickname: jsonSerialization['nickname'] as String,
      avatar: jsonSerialization['avatar'] as String?,
      rawUserInfo: jsonSerialization['rawUserInfo'] as String,
      code: jsonSerialization['code'] as String,
      state: jsonSerialization['state'] as String?,
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

  int type;

  String openid;

  String? token;

  String rawTokenInfo;

  String nickname;

  String? avatar;

  String rawUserInfo;

  String code;

  String? state;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysSocialUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysSocialUser copyWith({
    int? id,
    int? tenantId,
    int? type,
    String? openid,
    String? token,
    String? rawTokenInfo,
    String? nickname,
    String? avatar,
    String? rawUserInfo,
    String? code,
    String? state,
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
      'type': type,
      'openid': openid,
      if (token != null) 'token': token,
      'rawTokenInfo': rawTokenInfo,
      'nickname': nickname,
      if (avatar != null) 'avatar': avatar,
      'rawUserInfo': rawUserInfo,
      'code': code,
      if (state != null) 'state': state,
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

class _SysSocialUserImpl extends SysSocialUser {
  _SysSocialUserImpl({
    int? id,
    int? tenantId,
    required int type,
    required String openid,
    String? token,
    required String rawTokenInfo,
    required String nickname,
    String? avatar,
    required String rawUserInfo,
    required String code,
    String? state,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          type: type,
          openid: openid,
          token: token,
          rawTokenInfo: rawTokenInfo,
          nickname: nickname,
          avatar: avatar,
          rawUserInfo: rawUserInfo,
          code: code,
          state: state,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysSocialUser]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysSocialUser copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? type,
    String? openid,
    Object? token = _Undefined,
    String? rawTokenInfo,
    String? nickname,
    Object? avatar = _Undefined,
    String? rawUserInfo,
    String? code,
    Object? state = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysSocialUser(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      type: type ?? this.type,
      openid: openid ?? this.openid,
      token: token is String? ? token : this.token,
      rawTokenInfo: rawTokenInfo ?? this.rawTokenInfo,
      nickname: nickname ?? this.nickname,
      avatar: avatar is String? ? avatar : this.avatar,
      rawUserInfo: rawUserInfo ?? this.rawUserInfo,
      code: code ?? this.code,
      state: state is String? ? state : this.state,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
