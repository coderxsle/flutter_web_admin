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

abstract class AirTableFieldsSummary implements _i1.SerializableModel {
  AirTableFieldsSummary._({
    required this.id,
    required this.field,
  });

  factory AirTableFieldsSummary({
    required int id,
    required String field,
  }) = _AirTableFieldsSummaryImpl;

  factory AirTableFieldsSummary.fromJson(
      Map<String, dynamic> jsonSerialization) {
    return AirTableFieldsSummary(
      id: jsonSerialization['id'] as int,
      field: jsonSerialization['field'] as String,
    );
  }

  int id;

  String field;

  /// Returns a shallow copy of this [AirTableFieldsSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AirTableFieldsSummary copyWith({
    int? id,
    String? field,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'field': field,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _AirTableFieldsSummaryImpl extends AirTableFieldsSummary {
  _AirTableFieldsSummaryImpl({
    required int id,
    required String field,
  }) : super._(
          id: id,
          field: field,
        );

  /// Returns a shallow copy of this [AirTableFieldsSummary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AirTableFieldsSummary copyWith({
    int? id,
    String? field,
  }) {
    return AirTableFieldsSummary(
      id: id ?? this.id,
      field: field ?? this.field,
    );
  }
}
