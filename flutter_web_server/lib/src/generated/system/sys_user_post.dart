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

/// 用户岗位表
abstract class SysUserPost
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysUserPost._({
    this.id,
    int? tenantId,
    required this.userId,
    required this.postId,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  })  : tenantId = tenantId ?? 0,
        createTime = createTime ?? DateTime.now();

  factory SysUserPost({
    int? id,
    int? tenantId,
    required int userId,
    required int postId,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysUserPostImpl;

  factory SysUserPost.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysUserPost(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      userId: jsonSerialization['userId'] as int,
      postId: jsonSerialization['postId'] as int,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = SysUserPostTable();

  static const db = SysUserPostRepository._();

  @override
  int? id;

  int tenantId;

  int userId;

  int postId;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysUserPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysUserPost copyWith({
    int? id,
    int? tenantId,
    int? userId,
    int? postId,
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
      'userId': userId,
      'postId': postId,
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
      'userId': userId,
      'postId': postId,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysUserPostInclude include() {
    return SysUserPostInclude._();
  }

  static SysUserPostIncludeList includeList({
    _i1.WhereExpressionBuilder<SysUserPostTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysUserPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysUserPostTable>? orderByList,
    SysUserPostInclude? include,
  }) {
    return SysUserPostIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysUserPost.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysUserPost.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysUserPostImpl extends SysUserPost {
  _SysUserPostImpl({
    int? id,
    int? tenantId,
    required int userId,
    required int postId,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          userId: userId,
          postId: postId,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysUserPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysUserPost copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? userId,
    int? postId,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysUserPost(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      userId: userId ?? this.userId,
      postId: postId ?? this.postId,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysUserPostTable extends _i1.Table<int?> {
  SysUserPostTable({super.tableRelation}) : super(tableName: 'sys_user_post') {
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
      hasDefault: true,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    postId = _i1.ColumnInt(
      'postId',
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

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt postId;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        tenantId,
        userId,
        postId,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysUserPostInclude extends _i1.IncludeObject {
  SysUserPostInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysUserPost.t;
}

class SysUserPostIncludeList extends _i1.IncludeList {
  SysUserPostIncludeList._({
    _i1.WhereExpressionBuilder<SysUserPostTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysUserPost.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysUserPost.t;
}

class SysUserPostRepository {
  const SysUserPostRepository._();

  /// Returns a list of [SysUserPost]s matching the given query parameters.
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
  Future<List<SysUserPost>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysUserPostTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysUserPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysUserPostTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysUserPost>(
      where: where?.call(SysUserPost.t),
      orderBy: orderBy?.call(SysUserPost.t),
      orderByList: orderByList?.call(SysUserPost.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysUserPost] matching the given query parameters.
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
  Future<SysUserPost?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysUserPostTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysUserPostTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysUserPostTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysUserPost>(
      where: where?.call(SysUserPost.t),
      orderBy: orderBy?.call(SysUserPost.t),
      orderByList: orderByList?.call(SysUserPost.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysUserPost] by its [id] or null if no such row exists.
  Future<SysUserPost?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysUserPost>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysUserPost]s in the list and returns the inserted rows.
  ///
  /// The returned [SysUserPost]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysUserPost>> insert(
    _i1.Session session,
    List<SysUserPost> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysUserPost>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysUserPost] and returns the inserted row.
  ///
  /// The returned [SysUserPost] will have its `id` field set.
  Future<SysUserPost> insertRow(
    _i1.Session session,
    SysUserPost row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysUserPost>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysUserPost]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysUserPost>> update(
    _i1.Session session,
    List<SysUserPost> rows, {
    _i1.ColumnSelections<SysUserPostTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysUserPost>(
      rows,
      columns: columns?.call(SysUserPost.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysUserPost]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysUserPost> updateRow(
    _i1.Session session,
    SysUserPost row, {
    _i1.ColumnSelections<SysUserPostTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysUserPost>(
      row,
      columns: columns?.call(SysUserPost.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysUserPost]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysUserPost>> delete(
    _i1.Session session,
    List<SysUserPost> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysUserPost>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysUserPost].
  Future<SysUserPost> deleteRow(
    _i1.Session session,
    SysUserPost row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysUserPost>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysUserPost>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysUserPostTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysUserPost>(
      where: where(SysUserPost.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysUserPostTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysUserPost>(
      where: where?.call(SysUserPost.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
