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

abstract class AirTableRows implements _i1.SerializableModel {
  AirTableRows._({
    this.id,
    required this.index,
    required this.tablesId,
    this.tables,
    this.items,
  });

  factory AirTableRows({
    int? id,
    required int index,
    required int tablesId,
    _i2.AirTables? tables,
    List<_i3.AirTableItems>? items,
  }) = _AirTableRowsImpl;

  factory AirTableRows.fromJson(Map<String, dynamic> jsonSerialization) {
    return AirTableRows(
      id: jsonSerialization['id'] as int?,
      index: jsonSerialization['index'] as int,
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

  int index;

  int tablesId;

  _i2.AirTables? tables;

  List<_i3.AirTableItems>? items;

  /// Returns a shallow copy of this [AirTableRows]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AirTableRows copyWith({
    int? id,
    int? index,
    int? tablesId,
    _i2.AirTables? tables,
    List<_i3.AirTableItems>? items,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'index': index,
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

class _AirTableRowsImpl extends AirTableRows {
  _AirTableRowsImpl({
    int? id,
    required int index,
    required int tablesId,
    _i2.AirTables? tables,
    List<_i3.AirTableItems>? items,
  }) : super._(
          id: id,
          index: index,
          tablesId: tablesId,
          tables: tables,
          items: items,
        );

  /// Returns a shallow copy of this [AirTableRows]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AirTableRows copyWith({
    Object? id = _Undefined,
    int? index,
    int? tablesId,
    Object? tables = _Undefined,
    Object? items = _Undefined,
  }) {
    return AirTableRows(
      id: id is int? ? id : this.id,
      index: index ?? this.index,
      tablesId: tablesId ?? this.tablesId,
      tables: tables is _i2.AirTables? ? tables : this.tables?.copyWith(),
      items: items is List<_i3.AirTableItems>?
          ? items
          : this.items?.map((e0) => e0.copyWith()).toList(),
    );
  }
}
