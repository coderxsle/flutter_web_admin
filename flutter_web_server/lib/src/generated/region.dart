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

/// 用于存储区域信息，如省市区等
abstract class Region implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Region._({
    this.id,
    String? name,
    String? pinyin,
    int? parentId,
  })  : name = name ?? '',
        pinyin = pinyin ?? '',
        parentId = parentId ?? 0;

  factory Region({
    int? id,
    String? name,
    String? pinyin,
    int? parentId,
  }) = _RegionImpl;

  factory Region.fromJson(Map<String, dynamic> jsonSerialization) {
    return Region(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      pinyin: jsonSerialization['pinyin'] as String,
      parentId: jsonSerialization['parentId'] as int,
    );
  }

  static final t = RegionTable();

  static const db = RegionRepository._();

  @override
  int? id;

  /// 名称（默认空字符串）
  String name;

  /// 拼音（默认空字符串）
  String pinyin;

  /// 父级主键，无父级为 0
  int parentId;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Region]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Region copyWith({
    int? id,
    String? name,
    String? pinyin,
    int? parentId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'pinyin': pinyin,
      'parentId': parentId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'pinyin': pinyin,
      'parentId': parentId,
    };
  }

  static RegionInclude include() {
    return RegionInclude._();
  }

  static RegionIncludeList includeList({
    _i1.WhereExpressionBuilder<RegionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RegionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RegionTable>? orderByList,
    RegionInclude? include,
  }) {
    return RegionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Region.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Region.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RegionImpl extends Region {
  _RegionImpl({
    int? id,
    String? name,
    String? pinyin,
    int? parentId,
  }) : super._(
          id: id,
          name: name,
          pinyin: pinyin,
          parentId: parentId,
        );

  /// Returns a shallow copy of this [Region]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Region copyWith({
    Object? id = _Undefined,
    String? name,
    String? pinyin,
    int? parentId,
  }) {
    return Region(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      pinyin: pinyin ?? this.pinyin,
      parentId: parentId ?? this.parentId,
    );
  }
}

class RegionTable extends _i1.Table<int?> {
  RegionTable({super.tableRelation}) : super(tableName: 'region') {
    name = _i1.ColumnString(
      'name',
      this,
      hasDefault: true,
    );
    pinyin = _i1.ColumnString(
      'pinyin',
      this,
      hasDefault: true,
    );
    parentId = _i1.ColumnInt(
      'parentId',
      this,
      hasDefault: true,
    );
  }

  /// 名称（默认空字符串）
  late final _i1.ColumnString name;

  /// 拼音（默认空字符串）
  late final _i1.ColumnString pinyin;

  /// 父级主键，无父级为 0
  late final _i1.ColumnInt parentId;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        pinyin,
        parentId,
      ];
}

class RegionInclude extends _i1.IncludeObject {
  RegionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Region.t;
}

class RegionIncludeList extends _i1.IncludeList {
  RegionIncludeList._({
    _i1.WhereExpressionBuilder<RegionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Region.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Region.t;
}

class RegionRepository {
  const RegionRepository._();

  /// Returns a list of [Region]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Region>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RegionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RegionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RegionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Region>(
      where: where?.call(Region.t),
      orderBy: orderBy?.call(Region.t),
      orderByList: orderByList?.call(Region.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Region] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Region?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RegionTable>? where,
    int? offset,
    _i1.OrderByBuilder<RegionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RegionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Region>(
      where: where?.call(Region.t),
      orderBy: orderBy?.call(Region.t),
      orderByList: orderByList?.call(Region.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Region] by its [id] or null if no such row exists.
  Future<Region?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Region>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Region]s in the list and returns the inserted rows.
  ///
  /// The returned [Region]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Region>> insert(
    _i1.Session session,
    List<Region> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Region>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Region] and returns the inserted row.
  ///
  /// The returned [Region] will have its `id` field set.
  Future<Region> insertRow(
    _i1.Session session,
    Region row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Region>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Region]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Region>> update(
    _i1.Session session,
    List<Region> rows, {
    _i1.ColumnSelections<RegionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Region>(
      rows,
      columns: columns?.call(Region.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Region]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Region> updateRow(
    _i1.Session session,
    Region row, {
    _i1.ColumnSelections<RegionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Region>(
      row,
      columns: columns?.call(Region.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Region]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Region>> delete(
    _i1.Session session,
    List<Region> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Region>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Region].
  Future<Region> deleteRow(
    _i1.Session session,
    Region row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Region>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Region>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RegionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Region>(
      where: where(Region.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RegionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Region>(
      where: where?.call(Region.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
