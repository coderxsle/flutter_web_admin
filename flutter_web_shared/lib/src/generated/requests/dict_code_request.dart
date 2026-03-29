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
import 'package:serverpod_serialization/serverpod_serialization.dart' as _i1;

/// 新增、修改字典类型请求参数
abstract class DictCodeRequest implements _i1.SerializableModel {
  DictCodeRequest._({
    int? tenantId,
    required this.name,
    required this.code,
    int? status,
    this.description,
  }) : tenantId = tenantId ?? 0,
       status = status ?? 1;

  factory DictCodeRequest({
    int? tenantId,
    required String name,
    required String code,
    int? status,
    String? description,
  }) = _DictCodeRequestImpl;

  factory DictCodeRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return DictCodeRequest(
      tenantId: jsonSerialization['tenantId'] as int?,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      status: jsonSerialization['status'] as int?,
      description: jsonSerialization['description'] as String?,
    );
  }

  int tenantId;

  String name;

  String code;

  int status;

  String? description;

  /// Returns a shallow copy of this [DictCodeRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictCodeRequest copyWith({
    int? tenantId,
    String? name,
    String? code,
    int? status,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictCodeRequest',
      'tenantId': tenantId,
      'name': name,
      'code': code,
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

class _DictCodeRequestImpl extends DictCodeRequest {
  _DictCodeRequestImpl({
    int? tenantId,
    required String name,
    required String code,
    int? status,
    String? description,
  }) : super._(
         tenantId: tenantId,
         name: name,
         code: code,
         status: status,
         description: description,
       );

  /// Returns a shallow copy of this [DictCodeRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictCodeRequest copyWith({
    int? tenantId,
    String? name,
    String? code,
    int? status,
    Object? description = _Undefined,
  }) {
    return DictCodeRequest(
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      code: code ?? this.code,
      status: status ?? this.status,
      description: description is String? ? description : this.description,
    );
  }
}
