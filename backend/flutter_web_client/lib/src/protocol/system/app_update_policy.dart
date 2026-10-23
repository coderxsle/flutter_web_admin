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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// App 更新策略表（按租户 + 平台 + 渠道一条）
abstract class AppUpdatePolicy implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AppUpdatePolicy._({
    this.id,
    int? tenantId,
    required this.platform,
    String? channel,
    int? minSupportedVersionCode,
    int? promptCooldownHours,
    int? downloadUrlTtlMinutes,
    bool? enabled,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    bool? deleted,
  }) : tenantId = tenantId ?? 0,
       channel = channel ?? 'official',
       minSupportedVersionCode = minSupportedVersionCode ?? 0,
       promptCooldownHours = promptCooldownHours ?? 24,
       downloadUrlTtlMinutes = downloadUrlTtlMinutes ?? 120,
       enabled = enabled ?? true,
       createTime = createTime ?? DateTime.now(),
       deleted = deleted ?? false;

  factory AppUpdatePolicy({
    int? id,
    int? tenantId,
    required String platform,
    String? channel,
    int? minSupportedVersionCode,
    int? promptCooldownHours,
    int? downloadUrlTtlMinutes,
    bool? enabled,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    bool? deleted,
  }) = _AppUpdatePolicyImpl;

  factory AppUpdatePolicy.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppUpdatePolicy(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      platform: jsonSerialization['platform'] as String,
      channel: jsonSerialization['channel'] as String?,
      minSupportedVersionCode: jsonSerialization['minSupportedVersionCode'] as int?,
      promptCooldownHours: jsonSerialization['promptCooldownHours'] as int?,
      downloadUrlTtlMinutes: jsonSerialization['downloadUrlTtlMinutes'] as int?,
      enabled: jsonSerialization['enabled'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int tenantId;

  String platform;

  String channel;

  int minSupportedVersionCode;

  int promptCooldownHours;

  int downloadUrlTtlMinutes;

  bool enabled;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [AppUpdatePolicy]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AppUpdatePolicy copyWith({
    int? id,
    int? tenantId,
    String? platform,
    String? channel,
    int? minSupportedVersionCode,
    int? promptCooldownHours,
    int? downloadUrlTtlMinutes,
    bool? enabled,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppUpdatePolicy',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'platform': platform,
      'channel': channel,
      'minSupportedVersionCode': minSupportedVersionCode,
      'promptCooldownHours': promptCooldownHours,
      'downloadUrlTtlMinutes': downloadUrlTtlMinutes,
      'enabled': enabled,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AppUpdatePolicy',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'platform': platform,
      'channel': channel,
      'minSupportedVersionCode': minSupportedVersionCode,
      'promptCooldownHours': promptCooldownHours,
      'downloadUrlTtlMinutes': downloadUrlTtlMinutes,
      'enabled': enabled,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppUpdatePolicyImpl extends AppUpdatePolicy {
  _AppUpdatePolicyImpl({
    int? id,
    int? tenantId,
    required String platform,
    String? channel,
    int? minSupportedVersionCode,
    int? promptCooldownHours,
    int? downloadUrlTtlMinutes,
    bool? enabled,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    bool? deleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         platform: platform,
         channel: channel,
         minSupportedVersionCode: minSupportedVersionCode,
         promptCooldownHours: promptCooldownHours,
         downloadUrlTtlMinutes: downloadUrlTtlMinutes,
         enabled: enabled,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [AppUpdatePolicy]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AppUpdatePolicy copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? platform,
    String? channel,
    int? minSupportedVersionCode,
    int? promptCooldownHours,
    int? downloadUrlTtlMinutes,
    bool? enabled,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return AppUpdatePolicy(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      platform: platform ?? this.platform,
      channel: channel ?? this.channel,
      minSupportedVersionCode: minSupportedVersionCode ?? this.minSupportedVersionCode,
      promptCooldownHours: promptCooldownHours ?? this.promptCooldownHours,
      downloadUrlTtlMinutes: downloadUrlTtlMinutes ?? this.downloadUrlTtlMinutes,
      enabled: enabled ?? this.enabled,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
