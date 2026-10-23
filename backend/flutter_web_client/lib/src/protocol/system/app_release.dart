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

/// App 版本发布表（按租户隔离，tenantId=0 为平台级默认版本）
abstract class AppRelease implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AppRelease._({
    this.id,
    int? tenantId,
    required this.platform,
    String? channel,
    required this.versionName,
    required this.versionCode,
    String? releaseNotes,
    this.minOsVersion,
    String? status,
    int? rolloutPercent,
    bool? forceUpdate,
    this.storageKey,
    this.fileName,
    int? fileSize,
    this.sha256,
    this.storeUrl,
    this.publishedAt,
    int? downloadCount,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    bool? deleted,
  }) : tenantId = tenantId ?? 0,
       channel = channel ?? 'official',
       releaseNotes = releaseNotes ?? '',
       status = status ?? 'draft',
       rolloutPercent = rolloutPercent ?? 0,
       forceUpdate = forceUpdate ?? false,
       fileSize = fileSize ?? 0,
       downloadCount = downloadCount ?? 0,
       createTime = createTime ?? DateTime.now(),
       deleted = deleted ?? false;

  factory AppRelease({
    int? id,
    int? tenantId,
    required String platform,
    String? channel,
    required String versionName,
    required int versionCode,
    String? releaseNotes,
    String? minOsVersion,
    String? status,
    int? rolloutPercent,
    bool? forceUpdate,
    String? storageKey,
    String? fileName,
    int? fileSize,
    String? sha256,
    String? storeUrl,
    DateTime? publishedAt,
    int? downloadCount,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    bool? deleted,
  }) = _AppReleaseImpl;

  factory AppRelease.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppRelease(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      platform: jsonSerialization['platform'] as String,
      channel: jsonSerialization['channel'] as String?,
      versionName: jsonSerialization['versionName'] as String,
      versionCode: jsonSerialization['versionCode'] as int,
      releaseNotes: jsonSerialization['releaseNotes'] as String?,
      minOsVersion: jsonSerialization['minOsVersion'] as String?,
      status: jsonSerialization['status'] as String?,
      rolloutPercent: jsonSerialization['rolloutPercent'] as int?,
      forceUpdate: jsonSerialization['forceUpdate'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['forceUpdate']),
      storageKey: jsonSerialization['storageKey'] as String?,
      fileName: jsonSerialization['fileName'] as String?,
      fileSize: jsonSerialization['fileSize'] as int?,
      sha256: jsonSerialization['sha256'] as String?,
      storeUrl: jsonSerialization['storeUrl'] as String?,
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['publishedAt']),
      downloadCount: jsonSerialization['downloadCount'] as int?,
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

  String versionName;

  int versionCode;

  String releaseNotes;

  String? minOsVersion;

  String status;

  int rolloutPercent;

  bool forceUpdate;

  String? storageKey;

  String? fileName;

  int fileSize;

  String? sha256;

  String? storeUrl;

  DateTime? publishedAt;

  int downloadCount;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [AppRelease]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AppRelease copyWith({
    int? id,
    int? tenantId,
    String? platform,
    String? channel,
    String? versionName,
    int? versionCode,
    String? releaseNotes,
    String? minOsVersion,
    String? status,
    int? rolloutPercent,
    bool? forceUpdate,
    String? storageKey,
    String? fileName,
    int? fileSize,
    String? sha256,
    String? storeUrl,
    DateTime? publishedAt,
    int? downloadCount,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppRelease',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'platform': platform,
      'channel': channel,
      'versionName': versionName,
      'versionCode': versionCode,
      'releaseNotes': releaseNotes,
      if (minOsVersion != null) 'minOsVersion': minOsVersion,
      'status': status,
      'rolloutPercent': rolloutPercent,
      'forceUpdate': forceUpdate,
      if (storageKey != null) 'storageKey': storageKey,
      if (fileName != null) 'fileName': fileName,
      'fileSize': fileSize,
      if (sha256 != null) 'sha256': sha256,
      if (storeUrl != null) 'storeUrl': storeUrl,
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      'downloadCount': downloadCount,
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
      '__className__': 'AppRelease',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'platform': platform,
      'channel': channel,
      'versionName': versionName,
      'versionCode': versionCode,
      'releaseNotes': releaseNotes,
      if (minOsVersion != null) 'minOsVersion': minOsVersion,
      'status': status,
      'rolloutPercent': rolloutPercent,
      'forceUpdate': forceUpdate,
      if (storageKey != null) 'storageKey': storageKey,
      if (fileName != null) 'fileName': fileName,
      'fileSize': fileSize,
      if (sha256 != null) 'sha256': sha256,
      if (storeUrl != null) 'storeUrl': storeUrl,
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      'downloadCount': downloadCount,
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

class _AppReleaseImpl extends AppRelease {
  _AppReleaseImpl({
    int? id,
    int? tenantId,
    required String platform,
    String? channel,
    required String versionName,
    required int versionCode,
    String? releaseNotes,
    String? minOsVersion,
    String? status,
    int? rolloutPercent,
    bool? forceUpdate,
    String? storageKey,
    String? fileName,
    int? fileSize,
    String? sha256,
    String? storeUrl,
    DateTime? publishedAt,
    int? downloadCount,
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
         versionName: versionName,
         versionCode: versionCode,
         releaseNotes: releaseNotes,
         minOsVersion: minOsVersion,
         status: status,
         rolloutPercent: rolloutPercent,
         forceUpdate: forceUpdate,
         storageKey: storageKey,
         fileName: fileName,
         fileSize: fileSize,
         sha256: sha256,
         storeUrl: storeUrl,
         publishedAt: publishedAt,
         downloadCount: downloadCount,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [AppRelease]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AppRelease copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? platform,
    String? channel,
    String? versionName,
    int? versionCode,
    String? releaseNotes,
    Object? minOsVersion = _Undefined,
    String? status,
    int? rolloutPercent,
    bool? forceUpdate,
    Object? storageKey = _Undefined,
    Object? fileName = _Undefined,
    int? fileSize,
    Object? sha256 = _Undefined,
    Object? storeUrl = _Undefined,
    Object? publishedAt = _Undefined,
    int? downloadCount,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return AppRelease(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      platform: platform ?? this.platform,
      channel: channel ?? this.channel,
      versionName: versionName ?? this.versionName,
      versionCode: versionCode ?? this.versionCode,
      releaseNotes: releaseNotes ?? this.releaseNotes,
      minOsVersion: minOsVersion is String? ? minOsVersion : this.minOsVersion,
      status: status ?? this.status,
      rolloutPercent: rolloutPercent ?? this.rolloutPercent,
      forceUpdate: forceUpdate ?? this.forceUpdate,
      storageKey: storageKey is String? ? storageKey : this.storageKey,
      fileName: fileName is String? ? fileName : this.fileName,
      fileSize: fileSize ?? this.fileSize,
      sha256: sha256 is String? ? sha256 : this.sha256,
      storeUrl: storeUrl is String? ? storeUrl : this.storeUrl,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
      downloadCount: downloadCount ?? this.downloadCount,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
