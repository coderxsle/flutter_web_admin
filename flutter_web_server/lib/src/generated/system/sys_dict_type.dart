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

/// 字典类型表
abstract class SysDictType
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysDictType._({
    this.id,
    required this.name,
    required this.type,
    required this.status,
    this.remark,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
    this.deletedTime,
  }) : createTime = createTime ?? DateTime.now();

  factory SysDictType({
    int? id,
    required String name,
    required String type,
    required int status,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
    DateTime? deletedTime,
  }) = _SysDictTypeImpl;

  factory SysDictType.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysDictType(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as String,
      status: jsonSerialization['status'] as int,
      remark: jsonSerialization['remark'] as String?,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
      deletedTime: jsonSerialization['deletedTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['deletedTime']),
    );
  }

  static final t = SysDictTypeTable();

  static const db = SysDictTypeRepository._();

  @override
  int? id;

  String name;

  String type;

  int status;

  String? remark;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  DateTime? deletedTime;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysDictType]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysDictType copyWith({
    int? id,
    String? name,
    String? type,
    int? status,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
    DateTime? deletedTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'type': type,
      'status': status,
      if (remark != null) 'remark': remark,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
      if (deletedTime != null) 'deletedTime': deletedTime?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'type': type,
      'status': status,
      if (remark != null) 'remark': remark,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
      if (deletedTime != null) 'deletedTime': deletedTime?.toJson(),
    };
  }

  static SysDictTypeInclude include() {
    return SysDictTypeInclude._();
  }

  static SysDictTypeIncludeList includeList({
    _i1.WhereExpressionBuilder<SysDictTypeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysDictTypeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysDictTypeTable>? orderByList,
    SysDictTypeInclude? include,
  }) {
    return SysDictTypeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysDictType.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysDictType.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysDictTypeImpl extends SysDictType {
  _SysDictTypeImpl({
    int? id,
    required String name,
    required String type,
    required int status,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
    DateTime? deletedTime,
  }) : super._(
          id: id,
          name: name,
          type: type,
          status: status,
          remark: remark,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
          deletedTime: deletedTime,
        );

  /// Returns a shallow copy of this [SysDictType]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysDictType copyWith({
    Object? id = _Undefined,
    String? name,
    String? type,
    int? status,
    Object? remark = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
    Object? deletedTime = _Undefined,
  }) {
    return SysDictType(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      status: status ?? this.status,
      remark: remark is String? ? remark : this.remark,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
      deletedTime: deletedTime is DateTime? ? deletedTime : this.deletedTime,
    );
  }
}

class SysDictTypeTable extends _i1.Table<int?> {
  SysDictTypeTable({super.tableRelation}) : super(tableName: 'sys_dict_type') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    type = _i1.ColumnString(
      'type',
      this,
    );
    status = _i1.ColumnInt(
      'status',
      this,
    );
    remark = _i1.ColumnString(
      'remark',
      this,
    );
    creator = _i1.ColumnString(
      'creator',
      this,
    );
    createTime = _i1.ColumnDateTime(
      'createTime',
      this,
      hasDefault: true,
    );
    updater = _i1.ColumnString(
      'updater',
      this,
    );
    updateTime = _i1.ColumnDateTime(
      'updateTime',
      this,
    );
    deleted = _i1.ColumnBool(
      'deleted',
      this,
    );
    deletedTime = _i1.ColumnDateTime(
      'deletedTime',
      this,
    );
  }

  late final _i1.ColumnString name;

  late final _i1.ColumnString type;

  late final _i1.ColumnInt status;

  late final _i1.ColumnString remark;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  late final _i1.ColumnDateTime deletedTime;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        type,
        status,
        remark,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
        deletedTime,
      ];
}

class SysDictTypeInclude extends _i1.IncludeObject {
  SysDictTypeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysDictType.t;
}

class SysDictTypeIncludeList extends _i1.IncludeList {
  SysDictTypeIncludeList._({
    _i1.WhereExpressionBuilder<SysDictTypeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysDictType.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysDictType.t;
}

class SysDictTypeRepository {
  const SysDictTypeRepository._();

  /// Returns a list of [SysDictType]s matching the given query parameters.
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
  Future<List<SysDictType>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysDictTypeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysDictTypeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysDictTypeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysDictType>(
      where: where?.call(SysDictType.t),
      orderBy: orderBy?.call(SysDictType.t),
      orderByList: orderByList?.call(SysDictType.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysDictType] matching the given query parameters.
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
  Future<SysDictType?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysDictTypeTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysDictTypeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysDictTypeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysDictType>(
      where: where?.call(SysDictType.t),
      orderBy: orderBy?.call(SysDictType.t),
      orderByList: orderByList?.call(SysDictType.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysDictType] by its [id] or null if no such row exists.
  Future<SysDictType?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysDictType>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysDictType]s in the list and returns the inserted rows.
  ///
  /// The returned [SysDictType]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysDictType>> insert(
    _i1.Session session,
    List<SysDictType> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysDictType>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysDictType] and returns the inserted row.
  ///
  /// The returned [SysDictType] will have its `id` field set.
  Future<SysDictType> insertRow(
    _i1.Session session,
    SysDictType row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysDictType>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysDictType]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysDictType>> update(
    _i1.Session session,
    List<SysDictType> rows, {
    _i1.ColumnSelections<SysDictTypeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysDictType>(
      rows,
      columns: columns?.call(SysDictType.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysDictType]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysDictType> updateRow(
    _i1.Session session,
    SysDictType row, {
    _i1.ColumnSelections<SysDictTypeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysDictType>(
      row,
      columns: columns?.call(SysDictType.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysDictType]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysDictType>> delete(
    _i1.Session session,
    List<SysDictType> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysDictType>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysDictType].
  Future<SysDictType> deleteRow(
    _i1.Session session,
    SysDictType row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysDictType>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysDictType>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysDictTypeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysDictType>(
      where: where(SysDictType.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysDictTypeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysDictType>(
      where: where?.call(SysDictType.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
