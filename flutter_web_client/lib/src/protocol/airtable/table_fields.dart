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
import 'package:flutter_web_client/src/protocol/protocol.dart' as _is5docn0;
import 'package:serverpod_client/serverpod_client.dart' as _isc;
import '../airtable/table_items.dart' as _isilgdtt;
import '../airtable/tables.dart' as _iiekz83j;

abstract class AirTableFields
    implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
    _iiekz83j.AirTables? tables,
    List<_isilgdtt.AirTableItems>? items,
  }) = _AirTableFieldsImpl;

  factory AirTableFields.fromJson(Map<String, dynamic> jsonSerialization) {
    return AirTableFields(
      id: jsonSerialization['id'] as int?,
      field: jsonSerialization['field'] as String,
      tablesId: jsonSerialization['tablesId'] as int,
      tables: jsonSerialization['tables'] == null
          ? null
          : _is5docn0.Protocol().deserialize<_iiekz83j.AirTables>(
              jsonSerialization['tables'],
            ),
      items: jsonSerialization['items'] == null
          ? null
          : _is5docn0.Protocol().deserialize<List<_isilgdtt.AirTableItems>>(
              jsonSerialization['items'],
            ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String field;

  int tablesId;

  _iiekz83j.AirTables? tables;

  List<_isilgdtt.AirTableItems>? items;

  /// Returns a shallow copy of this [AirTableFields]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AirTableFields copyWith({
    int? id,
    String? field,
    int? tablesId,
    _iiekz83j.AirTables? tables,
    List<_isilgdtt.AirTableItems>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AirTableFields',
      if (id != null) 'id': id,
      'field': field,
      'tablesId': tablesId,
      if (tables != null) 'tables': tables?.toJson(),
      if (items != null) 'items': items?.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AirTableFields',
      if (id != null) 'id': id,
      'field': field,
      'tablesId': tablesId,
      if (tables != null) 'tables': tables?.toJsonForProtocol(),
      if (items != null)
        'items': items?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AirTableFieldsImpl extends AirTableFields {
  _AirTableFieldsImpl({
    int? id,
    required String field,
    required int tablesId,
    _iiekz83j.AirTables? tables,
    List<_isilgdtt.AirTableItems>? items,
  }) : super._(
         id: id,
         field: field,
         tablesId: tablesId,
         tables: tables,
         items: items,
       );

  /// Returns a shallow copy of this [AirTableFields]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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
      tables: tables is _iiekz83j.AirTables? ? tables : this.tables?.copyWith(),
      items: items is List<_isilgdtt.AirTableItems>?
          ? items
          : this.items?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
