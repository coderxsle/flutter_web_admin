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

/// 中医门诊科室
abstract class ZhongyiDepartment implements _isc.SerializableModel, _isc.ProtocolSerialization {
  ZhongyiDepartment._({
    this.id,
    int? tenantId,
    required this.name,
    required this.code,
    int? parentId,
    int? sortOrder,
    bool? isActive,
    this.phone,
    this.description,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : tenantId = tenantId ?? 0,
       parentId = parentId ?? 0,
       sortOrder = sortOrder ?? 0,
       isActive = isActive ?? true,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ZhongyiDepartment({
    int? id,
    int? tenantId,
    required String name,
    required String code,
    int? parentId,
    int? sortOrder,
    bool? isActive,
    String? phone,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiDepartmentImpl;

  factory ZhongyiDepartment.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiDepartment(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      parentId: jsonSerialization['parentId'] as int?,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
      phone: jsonSerialization['phone'] as String?,
      description: jsonSerialization['description'] as String?,
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// 租户ID
  int tenantId;

  /// 科室名称
  String name;

  /// 科室编码
  String code;

  /// 上级科室ID
  int? parentId;

  /// 排序
  int sortOrder;

  /// 是否启用
  bool isActive;

  String? phone;

  String? description;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  /// Returns a shallow copy of this [ZhongyiDepartment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  ZhongyiDepartment copyWith({
    int? id,
    int? tenantId,
    String? name,
    String? code,
    int? parentId,
    int? sortOrder,
    bool? isActive,
    String? phone,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ZhongyiDepartment',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'code': code,
      if (parentId != null) 'parentId': parentId,
      'sortOrder': sortOrder,
      'isActive': isActive,
      if (phone != null) 'phone': phone,
      if (description != null) 'description': description,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ZhongyiDepartment',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'code': code,
      if (parentId != null) 'parentId': parentId,
      'sortOrder': sortOrder,
      'isActive': isActive,
      if (phone != null) 'phone': phone,
      if (description != null) 'description': description,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ZhongyiDepartmentImpl extends ZhongyiDepartment {
  _ZhongyiDepartmentImpl({
    int? id,
    int? tenantId,
    required String name,
    required String code,
    int? parentId,
    int? sortOrder,
    bool? isActive,
    String? phone,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         name: name,
         code: code,
         parentId: parentId,
         sortOrder: sortOrder,
         isActive: isActive,
         phone: phone,
         description: description,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiDepartment]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  ZhongyiDepartment copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? name,
    String? code,
    Object? parentId = _Undefined,
    int? sortOrder,
    bool? isActive,
    Object? phone = _Undefined,
    Object? description = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiDepartment(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      code: code ?? this.code,
      parentId: parentId is int? ? parentId : this.parentId,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      phone: phone is String? ? phone : this.phone,
      description: description is String? ? description : this.description,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}
