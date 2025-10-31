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
import '../airtable/tables.dart' as _i2;
import '../airtable/table_items.dart' as _i3;

abstract class AirTableFields implements _i1.SerializableModel {
  AirTableFields._({
    this.id,
    required this.field,
    required this.tablesId,
    this.tables,
    this.items,
  });

  factory AirTableFields({
    int? id,
    required String field,
    required int tablesId,
    _i2.AirTables? tables,
    List<_i3.AirTableItems>? items,
  }) = _AirTableFieldsImpl;

  factory AirTableFields.fromJson(Map<String, dynamic> jsonSerialization) {
    return AirTableFields(
      id: jsonSerialization['id'] as int?,
      field: jsonSerialization['field'] as String,
      tablesId: jsonSerialization['tablesId'] as int,
      tables: jsonSerialization['tables'] == null
          ? null
          : _i2.AirTables.fromJson(
              (jsonSerialization['tables'] as Map<String, dynamic>)),
      items: (jsonSerialization['items'] as List?)
          ?.map((e) => _i3.AirTableItems.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String field;

  int tablesId;

  _i2.AirTables? tables;

  List<_i3.AirTableItems>? items;

  /// Returns a shallow copy of this [AirTableFields]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AirTableFields copyWith({
    int? id,
    String? field,
    int? tablesId,
    _i2.AirTables? tables,
    List<_i3.AirTableItems>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'field': field,
      'tablesId': tablesId,
      if (tables != null) 'tables': tables?.toJson(),
      if (items != null) 'items': items?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AirTableFieldsImpl extends AirTableFields {
  _AirTableFieldsImpl({
    int? id,
    required String field,
    required int tablesId,
    _i2.AirTables? tables,
    List<_i3.AirTableItems>? items,
  }) : super._(
          id: id,
          field: field,
          tablesId: tablesId,
          tables: tables,
          items: items,
        );

  /// Returns a shallow copy of this [AirTableFields]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AirTableFields copyWith({
    Object? id = _Undefined,
    String? field,
    int? tablesId,
    Object? tables = _Undefined,
    Object? items = _Undefined,
  }) {
    return AirTableFields(
      id: id is int? ? id : this.id,
      field: field ?? this.field,
      tablesId: tablesId ?? this.tablesId,
      tables: tables is _i2.AirTables? ? tables : this.tables?.copyWith(),
      items: items is List<_i3.AirTableItems>?
          ? items
          : this.items?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
