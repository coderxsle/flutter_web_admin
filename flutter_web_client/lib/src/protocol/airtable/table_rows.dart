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

abstract class AirTableRows implements _isc.SerializableModel, _isc.ProtocolSerialization {
  AirTableRows._({
    this.id,
    int? tenantId,
    required this.index,
    required this.tablesId,
    this.tables,
    this.items,
    bool? deleted,
  }) : tenantId = tenantId ?? 0,
       deleted = deleted ?? false;

  factory AirTableRows({
    int? id,
    int? tenantId,
    required int index,
    required int tablesId,
    _iiekz83j.AirTables? tables,
    List<_isilgdtt.AirTableItems>? items,
    bool? deleted,
  }) = _AirTableRowsImpl;

  factory AirTableRows.fromJson(Map<String, dynamic> jsonSerialization) {
    return AirTableRows(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      index: jsonSerialization['index'] as int,
      tablesId: jsonSerialization['tablesId'] as int,
      tables: jsonSerialization['tables'] == null
          ? null
          : _is5docn0.Protocol().deserialize<_iiekz83j.AirTables>(jsonSerialization['tables']),
      items: jsonSerialization['items'] == null
          ? null
          : _is5docn0.Protocol().deserialize<List<_isilgdtt.AirTableItems>>(jsonSerialization['items']),
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int tenantId;

  int index;

  int tablesId;

  _iiekz83j.AirTables? tables;

  List<_isilgdtt.AirTableItems>? items;

  bool deleted;

  /// Returns a shallow copy of this [AirTableRows]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  AirTableRows copyWith({
    int? id,
    int? tenantId,
    int? index,
    int? tablesId,
    _iiekz83j.AirTables? tables,
    List<_isilgdtt.AirTableItems>? items,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AirTableRows',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'index': index,
      'tablesId': tablesId,
      if (tables != null) 'tables': tables?.toJson(),
      if (items != null) 'items': items?.toJson(valueToJson: (v) => v.toJson()),
      'deleted': deleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'AirTableRows',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'index': index,
      'tablesId': tablesId,
      if (tables != null) 'tables': tables?.toJsonForProtocol(),
      if (items != null) 'items': items?.toJson(valueToJson: (v) => v.toJsonForProtocol()),
      'deleted': deleted,
    };
  }

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AirTableRowsImpl extends AirTableRows {
  _AirTableRowsImpl({
    int? id,
    int? tenantId,
    required int index,
    required int tablesId,
    _iiekz83j.AirTables? tables,
    List<_isilgdtt.AirTableItems>? items,
    bool? deleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         index: index,
         tablesId: tablesId,
         tables: tables,
         items: items,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [AirTableRows]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
  @override
  AirTableRows copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? index,
    int? tablesId,
    Object? tables = _Undefined,
    Object? items = _Undefined,
    bool? deleted,
  }) {
    return AirTableRows(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      index: index ?? this.index,
      tablesId: tablesId ?? this.tablesId,
      tables: tables is _iiekz83j.AirTables? ? tables : this.tables?.copyWith(),
      items: items is List<_isilgdtt.AirTableItems>? ? items : this.items?.map((e0) => e0.copyWith()).toList(),
      deleted: deleted ?? this.deleted,
    );
  }
}
