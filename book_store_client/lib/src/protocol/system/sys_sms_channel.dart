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

/// 短信渠道
abstract class SysSmsChannel implements _i1.SerializableModel {
  SysSmsChannel._({
    this.id,
    required this.signature,
    required this.code,
    required this.status,
    this.remark,
    required this.apiKey,
    this.apiSecret,
    this.callbackUrl,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysSmsChannel({
    int? id,
    required String signature,
    required String code,
    required int status,
    String? remark,
    required String apiKey,
    String? apiSecret,
    String? callbackUrl,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysSmsChannelImpl;

  factory SysSmsChannel.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysSmsChannel(
      id: jsonSerialization['id'] as int?,
      signature: jsonSerialization['signature'] as String,
      code: jsonSerialization['code'] as String,
      status: jsonSerialization['status'] as int,
      remark: jsonSerialization['remark'] as String?,
      apiKey: jsonSerialization['apiKey'] as String,
      apiSecret: jsonSerialization['apiSecret'] as String?,
      callbackUrl: jsonSerialization['callbackUrl'] as String?,
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

  String signature;

  String code;

  int status;

  String? remark;

  String apiKey;

  String? apiSecret;

  String? callbackUrl;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysSmsChannel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysSmsChannel copyWith({
    int? id,
    String? signature,
    String? code,
    int? status,
    String? remark,
    String? apiKey,
    String? apiSecret,
    String? callbackUrl,
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
      'signature': signature,
      'code': code,
      'status': status,
      if (remark != null) 'remark': remark,
      'apiKey': apiKey,
      if (apiSecret != null) 'apiSecret': apiSecret,
      if (callbackUrl != null) 'callbackUrl': callbackUrl,
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

class _SysSmsChannelImpl extends SysSmsChannel {
  _SysSmsChannelImpl({
    int? id,
    required String signature,
    required String code,
    required int status,
    String? remark,
    required String apiKey,
    String? apiSecret,
    String? callbackUrl,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          signature: signature,
          code: code,
          status: status,
          remark: remark,
          apiKey: apiKey,
          apiSecret: apiSecret,
          callbackUrl: callbackUrl,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysSmsChannel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysSmsChannel copyWith({
    Object? id = _Undefined,
    String? signature,
    String? code,
    int? status,
    Object? remark = _Undefined,
    String? apiKey,
    Object? apiSecret = _Undefined,
    Object? callbackUrl = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysSmsChannel(
      id: id is int? ? id : this.id,
      signature: signature ?? this.signature,
      code: code ?? this.code,
      status: status ?? this.status,
      remark: remark is String? ? remark : this.remark,
      apiKey: apiKey ?? this.apiKey,
      apiSecret: apiSecret is String? ? apiSecret : this.apiSecret,
      callbackUrl: callbackUrl is String? ? callbackUrl : this.callbackUrl,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
