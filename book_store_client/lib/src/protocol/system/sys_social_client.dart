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

/// 社交客户端表
abstract class SysSocialClient implements _i1.SerializableModel {
  SysSocialClient._({
    this.id,
    int? tenantId,
    required this.name,
    required this.socialType,
    required this.userType,
    required this.clientId,
    required this.clientSecret,
    this.agentId,
    required this.status,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  })  : tenantId = tenantId ?? 0,
        createTime = createTime ?? DateTime.now();

  factory SysSocialClient({
    int? id,
    int? tenantId,
    required String name,
    required int socialType,
    required int userType,
    required String clientId,
    required String clientSecret,
    String? agentId,
    required int status,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysSocialClientImpl;

  factory SysSocialClient.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysSocialClient(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      name: jsonSerialization['name'] as String,
      socialType: jsonSerialization['socialType'] as int,
      userType: jsonSerialization['userType'] as int,
      clientId: jsonSerialization['clientId'] as String,
      clientSecret: jsonSerialization['clientSecret'] as String,
      agentId: jsonSerialization['agentId'] as String?,
      status: jsonSerialization['status'] as int,
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

  String name;

  int socialType;

  int userType;

  String clientId;

  String clientSecret;

  String? agentId;

  int status;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysSocialClient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysSocialClient copyWith({
    int? id,
    int? tenantId,
    String? name,
    int? socialType,
    int? userType,
    String? clientId,
    String? clientSecret,
    String? agentId,
    int? status,
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
      'name': name,
      'socialType': socialType,
      'userType': userType,
      'clientId': clientId,
      'clientSecret': clientSecret,
      if (agentId != null) 'agentId': agentId,
      'status': status,
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

class _SysSocialClientImpl extends SysSocialClient {
  _SysSocialClientImpl({
    int? id,
    int? tenantId,
    required String name,
    required int socialType,
    required int userType,
    required String clientId,
    required String clientSecret,
    String? agentId,
    required int status,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          name: name,
          socialType: socialType,
          userType: userType,
          clientId: clientId,
          clientSecret: clientSecret,
          agentId: agentId,
          status: status,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysSocialClient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysSocialClient copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? name,
    int? socialType,
    int? userType,
    String? clientId,
    String? clientSecret,
    Object? agentId = _Undefined,
    int? status,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysSocialClient(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      socialType: socialType ?? this.socialType,
      userType: userType ?? this.userType,
      clientId: clientId ?? this.clientId,
      clientSecret: clientSecret ?? this.clientSecret,
      agentId: agentId is String? ? agentId : this.agentId,
      status: status ?? this.status,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
