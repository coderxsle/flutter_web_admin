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

/// 岗位信息表
abstract class SysPost
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysPost._({
    this.id,
    required this.tenantId,
    required this.code,
    required this.name,
    required this.sort,
    required this.status,
    this.remark,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysPost({
    int? id,
    required int tenantId,
    required String code,
    required String name,
    required int sort,
    required int status,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysPostImpl;

  factory SysPost.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysPost(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      code: jsonSerialization['code'] as String,
      name: jsonSerialization['name'] as String,
      sort: jsonSerialization['sort'] as int,
      status: jsonSerialization['status'] as int,
      remark: jsonSerialization['remark'] as String?,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = SysPostTable();

  static const db = SysPostRepository._();

  @override
  int? id;

  int tenantId;

  String code;

  String name;

  int sort;

  int status;

  String? remark;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysPost copyWith({
    int? id,
    int? tenantId,
    String? code,
    String? name,
    int? sort,
    int? status,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'code': code,
      'name': name,
      'sort': sort,
      'status': status,
      if (remark != null) 'remark': remark,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'code': code,
      'name': name,
      'sort': sort,
      'status': status,
      if (remark != null) 'remark': remark,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysPostInclude include() {
    return SysPostInclude._();
  }

  static SysPostIncludeList includeList({
    _i1.WhereExpressionBuilder<SysPostTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysPostTable>? orderByList,
    SysPostInclude? include,
  }) {
    return SysPostIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysPost.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysPost.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysPostImpl extends SysPost {
  _SysPostImpl({
    int? id,
    required int tenantId,
    required String code,
    required String name,
    required int sort,
    required int status,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          code: code,
          name: name,
          sort: sort,
          status: status,
          remark: remark,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysPost copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? code,
    String? name,
    int? sort,
    int? status,
    Object? remark = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysPost(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      code: code ?? this.code,
      name: name ?? this.name,
      sort: sort ?? this.sort,
      status: status ?? this.status,
      remark: remark is String? ? remark : this.remark,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysPostTable extends _i1.Table<int?> {
  SysPostTable({super.tableRelation}) : super(tableName: 'sys_post') {
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
    );
    code = _i1.ColumnString(
      'code',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    sort = _i1.ColumnInt(
      'sort',
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
  }

  late final _i1.ColumnInt tenantId;

  late final _i1.ColumnString code;

  late final _i1.ColumnString name;

  late final _i1.ColumnInt sort;

  late final _i1.ColumnInt status;

  late final _i1.ColumnString remark;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        tenantId,
        code,
        name,
        sort,
        status,
        remark,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysPostInclude extends _i1.IncludeObject {
  SysPostInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysPost.t;
}

class SysPostIncludeList extends _i1.IncludeList {
  SysPostIncludeList._({
    _i1.WhereExpressionBuilder<SysPostTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysPost.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysPost.t;
}

class SysPostRepository {
  const SysPostRepository._();

  /// Returns a list of [SysPost]s matching the given query parameters.
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
  Future<List<SysPost>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysPostTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysPostTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysPost>(
      where: where?.call(SysPost.t),
      orderBy: orderBy?.call(SysPost.t),
      orderByList: orderByList?.call(SysPost.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysPost] matching the given query parameters.
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
  Future<SysPost?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysPostTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysPostTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysPost>(
      where: where?.call(SysPost.t),
      orderBy: orderBy?.call(SysPost.t),
      orderByList: orderByList?.call(SysPost.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysPost] by its [id] or null if no such row exists.
  Future<SysPost?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysPost>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysPost]s in the list and returns the inserted rows.
  ///
  /// The returned [SysPost]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysPost>> insert(
    _i1.Session session,
    List<SysPost> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysPost>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysPost] and returns the inserted row.
  ///
  /// The returned [SysPost] will have its `id` field set.
  Future<SysPost> insertRow(
    _i1.Session session,
    SysPost row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysPost>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysPost]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysPost>> update(
    _i1.Session session,
    List<SysPost> rows, {
    _i1.ColumnSelections<SysPostTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysPost>(
      rows,
      columns: columns?.call(SysPost.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysPost]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysPost> updateRow(
    _i1.Session session,
    SysPost row, {
    _i1.ColumnSelections<SysPostTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysPost>(
      row,
      columns: columns?.call(SysPost.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysPost]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysPost>> delete(
    _i1.Session session,
    List<SysPost> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysPost>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysPost].
  Future<SysPost> deleteRow(
    _i1.Session session,
    SysPost row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysPost>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysPost>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysPostTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysPost>(
      where: where(SysPost.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysPostTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysPost>(
      where: where?.call(SysPost.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
