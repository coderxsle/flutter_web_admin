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
abstract class DictDataRequest implements _i1.SerializableModel {
  DictDataRequest._({
    int? tenantId,
    required this.code,
    required this.name,
    required this.value,
    this.color,
    required this.sort,
    int? status,
    this.description,
  }) : tenantId = tenantId ?? 0,
       status = status ?? 1;

  factory DictDataRequest({
    int? tenantId,
    required String code,
    required String name,
    required String value,
    String? color,
    required int sort,
    int? status,
    String? description,
  }) = _DictDataRequestImpl;

  factory DictDataRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return DictDataRequest(
      tenantId: jsonSerialization['tenantId'] as int?,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      value: jsonSerialization['value'] as String,
      color: jsonSerialization['color'] as String?,
      sort: jsonSerialization['sort'] as int,
      status: jsonSerialization['status'] as int?,
      description: jsonSerialization['description'] as String?,
    );
  }

  int tenantId;

  String code;

  String name;

  String value;

  String? color;

  int sort;

  int status;

  String? description;

  /// Returns a shallow copy of this [DictDataRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictDataRequest copyWith({
    int? tenantId,
    String? code,
    String? name,
    String? value,
    String? color,
    int? sort,
    int? status,
    String? description,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DictDataRequest',
      'tenantId': tenantId,
      'code': code,
      'name': name,
      'value': value,
      if (color != null) 'color': color,
      'sort': sort,
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

class _DictDataRequestImpl extends DictDataRequest {
  _DictDataRequestImpl({
    int? tenantId,
    required String code,
    required String name,
    required String value,
    String? color,
    required int sort,
    int? status,
    String? description,
  }) : super._(
         tenantId: tenantId,
         code: code,
         name: name,
         value: value,
         color: color,
         sort: sort,
         status: status,
         description: description,
       );

  /// Returns a shallow copy of this [DictDataRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictDataRequest copyWith({
    int? tenantId,
    String? code,
    String? name,
    String? value,
    Object? color = _Undefined,
    int? sort,
    int? status,
    Object? description = _Undefined,
  }) {
    return DictDataRequest(
      tenantId: tenantId ?? this.tenantId,
      code: code ?? this.code,
      name: name ?? this.name,
      value: value ?? this.value,
      color: color is String? ? color : this.color,
      sort: sort ?? this.sort,
      status: status ?? this.status,
      description: description is String? ? description : this.description,
    );
  }
}
