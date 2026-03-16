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

/// 新增、修改部门请求参数
abstract class DeptRequest implements _i1.SerializableModel {
  DeptRequest._({
    this.id,
    int? tenantId,
    int? parentId,
    required this.name,
    this.sort,
    int? status,
    this.description,
  }) : tenantId = tenantId ?? 0,
       parentId = parentId ?? 0,
       status = status ?? 1;

  factory DeptRequest({
    int? id,
    int? tenantId,
    int? parentId,
    required String name,
    int? sort,
    int? status,
    String? description,
  }) = _DeptRequestImpl;

  factory DeptRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return DeptRequest(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      parentId: jsonSerialization['parentId'] as int?,
      name: jsonSerialization['name'] as String,
      sort: jsonSerialization['sort'] as int?,
      status: jsonSerialization['status'] as int?,
      description: jsonSerialization['description'] as String?,
    );
  }

  int? id;

  int tenantId;

  int parentId;

  String name;

  int? sort;

  int status;

  String? description;

  /// Returns a shallow copy of this [DeptRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DeptRequest copyWith({
    int? id,
    int? tenantId,
    int? parentId,
    String? name,
    int? sort,
    int? status,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DeptRequest',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'parentId': parentId,
      'name': name,
      if (sort != null) 'sort': sort,
      'status': status,
      if (description != null) 'description': description,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DeptRequestImpl extends DeptRequest {
  _DeptRequestImpl({
    int? id,
    int? tenantId,
    int? parentId,
    required String name,
    int? sort,
    int? status,
    String? description,
  }) : super._(
         id: id,
         tenantId: tenantId,
         parentId: parentId,
         name: name,
         sort: sort,
         status: status,
         description: description,
       );

  /// Returns a shallow copy of this [DeptRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DeptRequest copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? parentId,
    String? name,
    Object? sort = _Undefined,
    int? status,
    Object? description = _Undefined,
  }) {
    return DeptRequest(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      parentId: parentId ?? this.parentId,
      name: name ?? this.name,
      sort: sort is int? ? sort : this.sort,
      status: status ?? this.status,
      description: description is String? ? description : this.description,
    );
  }
}
