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
import '../airtable/table_rows.dart' as _i2;
import '../airtable/table_fields.dart' as _i3;
import '../airtable/table_items.dart' as _i4;
import '../airtable/tables.dart' as _i5;

abstract class AirTableItems implements _i1.SerializableModel {
  AirTableItems._({
    this.id,
    required this.value,
    required this.rowId,
    this.row,
    required this.fieldId,
    this.field,
    this.itemId,
    this.item,
    this.tablesId,
    this.tables,
  });

  factory AirTableItems({
    int? id,
    required String value,
    required int rowId,
    _i2.AirTableRows? row,
    required int fieldId,
    _i3.AirTableFields? field,
    int? itemId,
    _i4.AirTableItems? item,
    int? tablesId,
    _i5.AirTables? tables,
  }) = _AirTableItemsImpl;

  factory AirTableItems.fromJson(Map<String, dynamic> jsonSerialization) {
    return AirTableItems(
      id: jsonSerialization['id'] as int?,
      value: jsonSerialization['value'] as String,
      rowId: jsonSerialization['rowId'] as int,
      row: jsonSerialization['row'] == null
          ? null
          : _i2.AirTableRows.fromJson(
              (jsonSerialization['row'] as Map<String, dynamic>)),
      fieldId: jsonSerialization['fieldId'] as int,
      field: jsonSerialization['field'] == null
          ? null
          : _i3.AirTableFields.fromJson(
              (jsonSerialization['field'] as Map<String, dynamic>)),
      itemId: jsonSerialization['itemId'] as int?,
      item: jsonSerialization['item'] == null
          ? null
          : _i4.AirTableItems.fromJson(
              (jsonSerialization['item'] as Map<String, dynamic>)),
      tablesId: jsonSerialization['tablesId'] as int?,
      tables: jsonSerialization['tables'] == null
          ? null
          : _i5.AirTables.fromJson(
              (jsonSerialization['tables'] as Map<String, dynamic>)),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String value;

  int rowId;

  _i2.AirTableRows? row;

  int fieldId;

  _i3.AirTableFields? field;

  int? itemId;

  _i4.AirTableItems? item;

  int? tablesId;

  _i5.AirTables? tables;

  /// Returns a shallow copy of this [AirTableItems]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AirTableItems copyWith({
    int? id,
    String? value,
    int? rowId,
    _i2.AirTableRows? row,
    int? fieldId,
    _i3.AirTableFields? field,
    int? itemId,
    _i4.AirTableItems? item,
    int? tablesId,
    _i5.AirTables? tables,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'value': value,
      'rowId': rowId,
      if (row != null) 'row': row?.toJson(),
      'fieldId': fieldId,
      if (field != null) 'field': field?.toJson(),
      if (itemId != null) 'itemId': itemId,
      if (item != null) 'item': item?.toJson(),
      if (tablesId != null) 'tablesId': tablesId,
      if (tables != null) 'tables': tables?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AirTableItemsImpl extends AirTableItems {
  _AirTableItemsImpl({
    int? id,
    required String value,
    required int rowId,
    _i2.AirTableRows? row,
    required int fieldId,
    _i3.AirTableFields? field,
    int? itemId,
    _i4.AirTableItems? item,
    int? tablesId,
    _i5.AirTables? tables,
  }) : super._(
          id: id,
          value: value,
          rowId: rowId,
          row: row,
          fieldId: fieldId,
          field: field,
          itemId: itemId,
          item: item,
          tablesId: tablesId,
          tables: tables,
        );

  /// Returns a shallow copy of this [AirTableItems]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AirTableItems copyWith({
    Object? id = _Undefined,
    String? value,
    int? rowId,
    Object? row = _Undefined,
    int? fieldId,
    Object? field = _Undefined,
    Object? itemId = _Undefined,
    Object? item = _Undefined,
    Object? tablesId = _Undefined,
    Object? tables = _Undefined,
  }) {
    return AirTableItems(
      id: id is int? ? id : this.id,
      value: value ?? this.value,
      rowId: rowId ?? this.rowId,
      row: row is _i2.AirTableRows? ? row : this.row?.copyWith(),
      fieldId: fieldId ?? this.fieldId,
      field: field is _i3.AirTableFields? ? field : this.field?.copyWith(),
      itemId: itemId is int? ? itemId : this.itemId,
      item: item is _i4.AirTableItems? ? item : this.item?.copyWith(),
      tablesId: tablesId is int? ? tablesId : this.tablesId,
      tables: tables is _i5.AirTables? ? tables : this.tables?.copyWith(),
    );
  }
}
