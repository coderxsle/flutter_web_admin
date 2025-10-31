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
import 'package:serverpod/serverpod.dart' as _i1;
import '../airtable/table_fields_summary.dart' as _i2;

abstract class AirTableDetail
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  AirTableDetail._({
    required this.id,
    required this.name,
    this.fields,
    required this.fieldsCount,
    required this.rowsCount,
  });

  factory AirTableDetail({
    required int id,
    required String name,
    List<_i2.AirTableFieldsSummary>? fields,
    required int fieldsCount,
    required int rowsCount,
  }) = _AirTableDetailImpl;

  factory AirTableDetail.fromJson(Map<String, dynamic> jsonSerialization) {
    return AirTableDetail(
      id: jsonSerialization['id'] as int,
      name: jsonSerialization['name'] as String,
      fields: (jsonSerialization['fields'] as List?)
          ?.map((e) =>
              _i2.AirTableFieldsSummary.fromJson((e as Map<String, dynamic>)))
          .toList(),
      fieldsCount: jsonSerialization['fieldsCount'] as int,
      rowsCount: jsonSerialization['rowsCount'] as int,
    );
  }

  int id;

  String name;

  List<_i2.AirTableFieldsSummary>? fields;

  int fieldsCount;

  int rowsCount;

  /// Returns a shallow copy of this [AirTableDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AirTableDetail copyWith({
    int? id,
    String? name,
    List<_i2.AirTableFieldsSummary>? fields,
    int? fieldsCount,
    int? rowsCount,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      if (fields != null)
        'fields': fields?.toJson(valueToJson: (v) => v.toJson()),
      'fieldsCount': fieldsCount,
      'rowsCount': rowsCount,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      'id': id,
      'name': name,
      if (fields != null)
        'fields': fields?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'fieldsCount': fieldsCount,
      'rowsCount': rowsCount,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AirTableDetailImpl extends AirTableDetail {
  _AirTableDetailImpl({
    required int id,
    required String name,
    List<_i2.AirTableFieldsSummary>? fields,
    required int fieldsCount,
    required int rowsCount,
  }) : super._(
          id: id,
          name: name,
          fields: fields,
          fieldsCount: fieldsCount,
          rowsCount: rowsCount,
        );

  /// Returns a shallow copy of this [AirTableDetail]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AirTableDetail copyWith({
    int? id,
    String? name,
    Object? fields = _Undefined,
    int? fieldsCount,
    int? rowsCount,
  }) {
    return AirTableDetail(
      id: id ?? this.id,
      name: name ?? this.name,
      fields: fields is List<_i2.AirTableFieldsSummary>?
          ? fields
          : this.fields?.map((e0) => e0.copyWith()).toList(),
      fieldsCount: fieldsCount ?? this.fieldsCount,
      rowsCount: rowsCount ?? this.rowsCount,
    );
  }
}
