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

/// 租户表
abstract class SysTenant implements _i1.SerializableModel {
  SysTenant._({
    this.id,
    required this.name,
    this.contactUserId,
    required this.contactName,
    this.contactMobile,
    required this.status,
    this.websites,
    required this.packageId,
    required this.expireTime,
    required this.accountCount,
    required this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysTenant({
    int? id,
    required String name,
    int? contactUserId,
    required String contactName,
    String? contactMobile,
    required int status,
    String? websites,
    required int packageId,
    required DateTime expireTime,
    required int accountCount,
    required String creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysTenantImpl;

  factory SysTenant.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysTenant(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      contactUserId: jsonSerialization['contactUserId'] as int?,
      contactName: jsonSerialization['contactName'] as String,
      contactMobile: jsonSerialization['contactMobile'] as String?,
      status: jsonSerialization['status'] as int,
      websites: jsonSerialization['websites'] as String?,
      packageId: jsonSerialization['packageId'] as int,
      expireTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expireTime']),
      accountCount: jsonSerialization['accountCount'] as int,
      creator: jsonSerialization['creator'] as String,
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

  int? contactUserId;

  String contactName;

  String? contactMobile;

  int status;

  String? websites;

  int packageId;

  DateTime expireTime;

  int accountCount;

  String creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  /// Returns a shallow copy of this [SysTenant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysTenant copyWith({
    int? id,
    String? name,
    int? contactUserId,
    String? contactName,
    String? contactMobile,
    int? status,
    String? websites,
    int? packageId,
    DateTime? expireTime,
    int? accountCount,
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
      if (contactUserId != null) 'contactUserId': contactUserId,
      'contactName': contactName,
      if (contactMobile != null) 'contactMobile': contactMobile,
      'status': status,
      if (websites != null) 'websites': websites,
      'packageId': packageId,
      'expireTime': expireTime.toJson(),
      'accountCount': accountCount,
      'creator': creator,
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

class _SysTenantImpl extends SysTenant {
  _SysTenantImpl({
    int? id,
    required String name,
    int? contactUserId,
    required String contactName,
    String? contactMobile,
    required int status,
    String? websites,
    required int packageId,
    required DateTime expireTime,
    required int accountCount,
    required String creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          name: name,
          contactUserId: contactUserId,
          contactName: contactName,
          contactMobile: contactMobile,
          status: status,
          websites: websites,
          packageId: packageId,
          expireTime: expireTime,
          accountCount: accountCount,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysTenant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysTenant copyWith({
    Object? id = _Undefined,
    String? name,
    Object? contactUserId = _Undefined,
    String? contactName,
    Object? contactMobile = _Undefined,
    int? status,
    Object? websites = _Undefined,
    int? packageId,
    DateTime? expireTime,
    int? accountCount,
    String? creator,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysTenant(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      contactUserId: contactUserId is int? ? contactUserId : this.contactUserId,
      contactName: contactName ?? this.contactName,
      contactMobile:
          contactMobile is String? ? contactMobile : this.contactMobile,
      status: status ?? this.status,
      websites: websites is String? ? websites : this.websites,
      packageId: packageId ?? this.packageId,
      expireTime: expireTime ?? this.expireTime,
      accountCount: accountCount ?? this.accountCount,
      creator: creator ?? this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}
