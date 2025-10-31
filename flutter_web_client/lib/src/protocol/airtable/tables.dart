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
import '../airtable/table_fields.dart' as _i2;
import '../airtable/table_rows.dart' as _i3;

abstract class AirTables implements _i1.SerializableModel {
  AirTables._({
    this.id,
    required this.name,
    this.fields,
    this.rows,
  });

  factory AirTables({
    int? id,
    required String name,
    List<_i2.AirTableFields>? fields,
    List<_i3.AirTableRows>? rows,
  }) = _AirTablesImpl;

  factory AirTables.fromJson(Map<String, dynamic> jsonSerialization) {
    return AirTables(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      fields: (jsonSerialization['fields'] as List?)
          ?.map((e) => _i2.AirTableFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
      rows: (jsonSerialization['rows'] as List?)
          ?.map((e) => _i3.AirTableRows.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  List<_i2.AirTableFields>? fields;

  List<_i3.AirTableRows>? rows;

  /// Returns a shallow copy of this [AirTables]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AirTables copyWith({
    int? id,
    String? name,
    List<_i2.AirTableFields>? fields,
    List<_i3.AirTableRows>? rows,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (fields != null)
        'fields': fields?.toJson(valueToJson: (v) => v.toJson()),
      if (rows != null) 'rows': rows?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AirTablesImpl extends AirTables {
  _AirTablesImpl({
    int? id,
    required String name,
    List<_i2.AirTableFields>? fields,
    List<_i3.AirTableRows>? rows,
  }) : super._(
          id: id,
          name: name,
          fields: fields,
          rows: rows,
        );

  /// Returns a shallow copy of this [AirTables]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AirTables copyWith({
    Object? id = _Undefined,
    String? name,
    Object? fields = _Undefined,
    Object? rows = _Undefined,
  }) {
    return AirTables(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      fields: fields is List<_i2.AirTableFields>?
          ? fields
          : this.fields?.map((e0) => e0.copyWith()).toList(),
      rows: rows is List<_i3.AirTableRows>?
          ? rows
          : this.rows?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
