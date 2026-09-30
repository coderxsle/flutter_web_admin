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

/// 文件表
abstract class InfraFile implements _isc.SerializableModel, _isc.ProtocolSerialization {
  InfraFile._({
    this.id,
    int? tenantId,
    this.configId,
    this.parentId,
    required this.name,
    bool? isDir,
    required this.path,
    this.storageKey,
    this.url,
    this.type,
    this.extendName,
    this.mimeType,
    int? size,
    this.sha256,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : tenantId = tenantId ?? 0,
       isDir = isDir ?? false,
       size = size ?? 0,
       createTime = createTime ?? DateTime.now();

  factory InfraFile({
    int? id,
    int? tenantId,
    int? configId,
    int? parentId,
    required String name,
    bool? isDir,
    required String path,
    String? storageKey,
    String? url,
    String? type,
    String? extendName,
    String? mimeType,
    int? size,
    String? sha256,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraFileImpl;

  factory InfraFile.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraFile(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      configId: jsonSerialization['configId'] as int?,
      parentId: jsonSerialization['parentId'] as int?,
      name: jsonSerialization['name'] as String,
      isDir: jsonSerialization['isDir'] == null ? null : _isc.BoolJsonExtension.fromJson(jsonSerialization['isDir']),
      path: jsonSerialization['path'] as String,
      storageKey: jsonSerialization['storageKey'] as String?,
      url: jsonSerialization['url'] as String?,
      type: jsonSerialization['type'] as String?,
      extendName: jsonSerialization['extendName'] as String?,
      mimeType: jsonSerialization['mimeType'] as String?,
      size: jsonSerialization['size'] as int?,
      sha256: jsonSerialization['sha256'] as String?,
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: _isc.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int tenantId;

  int? configId;

  int? parentId;

  String name;

  bool isDir;

  String path;

  String? storageKey;

  String? url;

  String? type;

  String? extendName;

  String? mimeType;

  int size;

  String? sha256;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [InfraFile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  InfraFile copyWith({
    int? id,
    int? tenantId,
    int? configId,
    int? parentId,
    String? name,
    bool? isDir,
    String? path,
    String? storageKey,
    String? url,
    String? type,
    String? extendName,
    String? mimeType,
    int? size,
    String? sha256,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InfraFile',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (configId != null) 'configId': configId,
      if (parentId != null) 'parentId': parentId,
      'name': name,
      'isDir': isDir,
      'path': path,
      if (storageKey != null) 'storageKey': storageKey,
      if (url != null) 'url': url,
      if (type != null) 'type': type,
      if (extendName != null) 'extendName': extendName,
      if (mimeType != null) 'mimeType': mimeType,
      'size': size,
      if (sha256 != null) 'sha256': sha256,
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
      '__className__': 'InfraFile',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (configId != null) 'configId': configId,
      if (parentId != null) 'parentId': parentId,
      'name': name,
      'isDir': isDir,
      'path': path,
      if (storageKey != null) 'storageKey': storageKey,
      if (url != null) 'url': url,
      if (type != null) 'type': type,
      if (extendName != null) 'extendName': extendName,
      if (mimeType != null) 'mimeType': mimeType,
      'size': size,
      if (sha256 != null) 'sha256': sha256,
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

class _InfraFileImpl extends InfraFile {
  _InfraFileImpl({
    int? id,
    int? tenantId,
    int? configId,
    int? parentId,
    required String name,
    bool? isDir,
    required String path,
    String? storageKey,
    String? url,
    String? type,
    String? extendName,
    String? mimeType,
    int? size,
    String? sha256,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         configId: configId,
         parentId: parentId,
         name: name,
         isDir: isDir,
         path: path,
         storageKey: storageKey,
         url: url,
         type: type,
         extendName: extendName,
         mimeType: mimeType,
         size: size,
         sha256: sha256,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [InfraFile]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  InfraFile copyWith({
    Object? id = _Undefined,
    int? tenantId,
    Object? configId = _Undefined,
    Object? parentId = _Undefined,
    String? name,
    bool? isDir,
    String? path,
    Object? storageKey = _Undefined,
    Object? url = _Undefined,
    Object? type = _Undefined,
    Object? extendName = _Undefined,
    Object? mimeType = _Undefined,
    int? size,
    Object? sha256 = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraFile(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      configId: configId is int? ? configId : this.configId,
      parentId: parentId is int? ? parentId : this.parentId,
      name: name ?? this.name,
      isDir: isDir ?? this.isDir,
      path: path ?? this.path,
      storageKey: storageKey is String? ? storageKey : this.storageKey,
      url: url is String? ? url : this.url,
      type: type is String? ? type : this.type,
      extendName: extendName is String? ? extendName : this.extendName,
      mimeType: mimeType is String? ? mimeType : this.mimeType,
      size: size ?? this.size,
      sha256: sha256 is String? ? sha256 : this.sha256,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
