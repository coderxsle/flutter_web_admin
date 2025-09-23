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

/// 通知公告表
abstract class SysNotice
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysNotice._({
    this.id,
    required this.tenantId,
    required this.title,
    required this.content,
    required this.type,
    required this.status,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysNotice({
    int? id,
    required int tenantId,
    required String title,
    required String content,
    required int type,
    required int status,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysNoticeImpl;

  factory SysNotice.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysNotice(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      title: jsonSerialization['title'] as String,
      content: jsonSerialization['content'] as String,
      type: jsonSerialization['type'] as int,
      status: jsonSerialization['status'] as int,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = SysNoticeTable();

  static const db = SysNoticeRepository._();

  @override
  int? id;

  int tenantId;

  String title;

  String content;

  int type;

  int status;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysNotice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysNotice copyWith({
    int? id,
    int? tenantId,
    String? title,
    String? content,
    int? type,
    int? status,
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
      'title': title,
      'content': content,
      'type': type,
      'status': status,
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
      'title': title,
      'content': content,
      'type': type,
      'status': status,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysNoticeInclude include() {
    return SysNoticeInclude._();
  }

  static SysNoticeIncludeList includeList({
    _i1.WhereExpressionBuilder<SysNoticeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysNoticeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysNoticeTable>? orderByList,
    SysNoticeInclude? include,
  }) {
    return SysNoticeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysNotice.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysNotice.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysNoticeImpl extends SysNotice {
  _SysNoticeImpl({
    int? id,
    required int tenantId,
    required String title,
    required String content,
    required int type,
    required int status,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          title: title,
          content: content,
          type: type,
          status: status,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysNotice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysNotice copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? title,
    String? content,
    int? type,
    int? status,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysNotice(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      title: title ?? this.title,
      content: content ?? this.content,
      type: type ?? this.type,
      status: status ?? this.status,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysNoticeTable extends _i1.Table<int?> {
  SysNoticeTable({super.tableRelation}) : super(tableName: 'sys_notice') {
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    type = _i1.ColumnInt(
      'type',
      this,
    );
    status = _i1.ColumnInt(
      'status',
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

  late final _i1.ColumnString title;

  late final _i1.ColumnString content;

  late final _i1.ColumnInt type;

  late final _i1.ColumnInt status;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        tenantId,
        title,
        content,
        type,
        status,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysNoticeInclude extends _i1.IncludeObject {
  SysNoticeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysNotice.t;
}

class SysNoticeIncludeList extends _i1.IncludeList {
  SysNoticeIncludeList._({
    _i1.WhereExpressionBuilder<SysNoticeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysNotice.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysNotice.t;
}

class SysNoticeRepository {
  const SysNoticeRepository._();

  /// Returns a list of [SysNotice]s matching the given query parameters.
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
  Future<List<SysNotice>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysNoticeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysNoticeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysNoticeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysNotice>(
      where: where?.call(SysNotice.t),
      orderBy: orderBy?.call(SysNotice.t),
      orderByList: orderByList?.call(SysNotice.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysNotice] matching the given query parameters.
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
  Future<SysNotice?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysNoticeTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysNoticeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysNoticeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysNotice>(
      where: where?.call(SysNotice.t),
      orderBy: orderBy?.call(SysNotice.t),
      orderByList: orderByList?.call(SysNotice.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysNotice] by its [id] or null if no such row exists.
  Future<SysNotice?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysNotice>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysNotice]s in the list and returns the inserted rows.
  ///
  /// The returned [SysNotice]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysNotice>> insert(
    _i1.Session session,
    List<SysNotice> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysNotice>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysNotice] and returns the inserted row.
  ///
  /// The returned [SysNotice] will have its `id` field set.
  Future<SysNotice> insertRow(
    _i1.Session session,
    SysNotice row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysNotice>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysNotice]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysNotice>> update(
    _i1.Session session,
    List<SysNotice> rows, {
    _i1.ColumnSelections<SysNoticeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysNotice>(
      rows,
      columns: columns?.call(SysNotice.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysNotice]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysNotice> updateRow(
    _i1.Session session,
    SysNotice row, {
    _i1.ColumnSelections<SysNoticeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysNotice>(
      row,
      columns: columns?.call(SysNotice.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysNotice]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysNotice>> delete(
    _i1.Session session,
    List<SysNotice> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysNotice>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysNotice].
  Future<SysNotice> deleteRow(
    _i1.Session session,
    SysNotice row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysNotice>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysNotice>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysNoticeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysNotice>(
      where: where(SysNotice.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysNoticeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysNotice>(
      where: where?.call(SysNotice.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
