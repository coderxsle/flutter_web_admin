/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

/// 用于存储系统角色信息
abstract class SysRole implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  SysRole._({
    this.id,
    String? name,
  }) : name = name ?? '';

  factory SysRole({
    int? id,
    String? name,
  }) = _SysRoleImpl;

  factory SysRole.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysRole(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
    );
  }

  static final t = SysRoleTable();

  static const db = SysRoleRepository._();

  @override
  int? id;

  /// 角色名称
  String name;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [SysRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysRole copyWith({
    int? id,
    String? name,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
    };
  }

  static SysRoleInclude include() {
    return SysRoleInclude._();
  }

  static SysRoleIncludeList includeList({
    _i1.WhereExpressionBuilder<SysRoleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysRoleTable>? orderByList,
    SysRoleInclude? include,
  }) {
    return SysRoleIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysRole.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysRole.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysRoleImpl extends SysRole {
  _SysRoleImpl({
    int? id,
    String? name,
  }) : super._(
          id: id,
          name: name,
        );

  /// Returns a shallow copy of this [SysRole]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysRole copyWith({
    Object? id = _Undefined,
    String? name,
  }) {
    return SysRole(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
    );
  }
}

class SysRoleTable extends _i1.Table<int> {
  SysRoleTable({super.tableRelation}) : super(tableName: 'sys_role') {
    name = _i1.ColumnString(
      'name',
      this,
      hasDefault: true,
    );
  }

  /// 角色名称
  late final _i1.ColumnString name;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
      ];
}

class SysRoleInclude extends _i1.IncludeObject {
  SysRoleInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => SysRole.t;
}

class SysRoleIncludeList extends _i1.IncludeList {
  SysRoleIncludeList._({
    _i1.WhereExpressionBuilder<SysRoleTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysRole.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => SysRole.t;
}

class SysRoleRepository {
  const SysRoleRepository._();

  /// Returns a list of [SysRole]s matching the given query parameters.
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
  Future<List<SysRole>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysRoleTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysRoleTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysRole>(
      where: where?.call(SysRole.t),
      orderBy: orderBy?.call(SysRole.t),
      orderByList: orderByList?.call(SysRole.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysRole] matching the given query parameters.
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
  Future<SysRole?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysRoleTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysRoleTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysRoleTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysRole>(
      where: where?.call(SysRole.t),
      orderBy: orderBy?.call(SysRole.t),
      orderByList: orderByList?.call(SysRole.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysRole] by its [id] or null if no such row exists.
  Future<SysRole?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysRole>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysRole]s in the list and returns the inserted rows.
  ///
  /// The returned [SysRole]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysRole>> insert(
    _i1.Session session,
    List<SysRole> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysRole>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysRole] and returns the inserted row.
  ///
  /// The returned [SysRole] will have its `id` field set.
  Future<SysRole> insertRow(
    _i1.Session session,
    SysRole row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysRole>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysRole]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysRole>> update(
    _i1.Session session,
    List<SysRole> rows, {
    _i1.ColumnSelections<SysRoleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysRole>(
      rows,
      columns: columns?.call(SysRole.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysRole]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysRole> updateRow(
    _i1.Session session,
    SysRole row, {
    _i1.ColumnSelections<SysRoleTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysRole>(
      row,
      columns: columns?.call(SysRole.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysRole]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysRole>> delete(
    _i1.Session session,
    List<SysRole> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysRole>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysRole].
  Future<SysRole> deleteRow(
    _i1.Session session,
    SysRole row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysRole>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysRole>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysRoleTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysRole>(
      where: where(SysRole.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysRoleTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysRole>(
      where: where?.call(SysRole.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
