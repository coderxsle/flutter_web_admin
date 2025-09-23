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
import 'dart:typed_data' as _i2;

/// 文件内容表
abstract class InfraFileContent
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  InfraFileContent._({
    this.id,
    required this.configId,
    required this.path,
    required this.content,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory InfraFileContent({
    int? id,
    required int configId,
    required String path,
    required _i2.ByteData content,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraFileContentImpl;

  factory InfraFileContent.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraFileContent(
      id: jsonSerialization['id'] as int?,
      configId: jsonSerialization['configId'] as int,
      path: jsonSerialization['path'] as String,
      content: _i1.ByteDataJsonExtension.fromJson(jsonSerialization['content']),
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = InfraFileContentTable();

  static const db = InfraFileContentRepository._();

  @override
  int? id;

  int configId;

  String path;

  _i2.ByteData content;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [InfraFileContent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InfraFileContent copyWith({
    int? id,
    int? configId,
    String? path,
    _i2.ByteData? content,
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
      'configId': configId,
      'path': path,
      'content': content.toJson(),
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
      'configId': configId,
      'path': path,
      'content': content.toJson(),
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static InfraFileContentInclude include() {
    return InfraFileContentInclude._();
  }

  static InfraFileContentIncludeList includeList({
    _i1.WhereExpressionBuilder<InfraFileContentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InfraFileContentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraFileContentTable>? orderByList,
    InfraFileContentInclude? include,
  }) {
    return InfraFileContentIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraFileContent.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(InfraFileContent.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InfraFileContentImpl extends InfraFileContent {
  _InfraFileContentImpl({
    int? id,
    required int configId,
    required String path,
    required _i2.ByteData content,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          configId: configId,
          path: path,
          content: content,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [InfraFileContent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InfraFileContent copyWith({
    Object? id = _Undefined,
    int? configId,
    String? path,
    _i2.ByteData? content,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraFileContent(
      id: id is int? ? id : this.id,
      configId: configId ?? this.configId,
      path: path ?? this.path,
      content: content ?? this.content.clone(),
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class InfraFileContentTable extends _i1.Table<int?> {
  InfraFileContentTable({super.tableRelation})
      : super(tableName: 'infra_file_content') {
    configId = _i1.ColumnInt(
      'configId',
      this,
    );
    path = _i1.ColumnString(
      'path',
      this,
    );
    content = _i1.ColumnByteData(
      'content',
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

  late final _i1.ColumnInt configId;

  late final _i1.ColumnString path;

  late final _i1.ColumnByteData content;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        configId,
        path,
        content,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class InfraFileContentInclude extends _i1.IncludeObject {
  InfraFileContentInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => InfraFileContent.t;
}

class InfraFileContentIncludeList extends _i1.IncludeList {
  InfraFileContentIncludeList._({
    _i1.WhereExpressionBuilder<InfraFileContentTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InfraFileContent.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => InfraFileContent.t;
}

class InfraFileContentRepository {
  const InfraFileContentRepository._();

  /// Returns a list of [InfraFileContent]s matching the given query parameters.
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
  Future<List<InfraFileContent>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraFileContentTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InfraFileContentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraFileContentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<InfraFileContent>(
      where: where?.call(InfraFileContent.t),
      orderBy: orderBy?.call(InfraFileContent.t),
      orderByList: orderByList?.call(InfraFileContent.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [InfraFileContent] matching the given query parameters.
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
  Future<InfraFileContent?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraFileContentTable>? where,
    int? offset,
    _i1.OrderByBuilder<InfraFileContentTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraFileContentTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<InfraFileContent>(
      where: where?.call(InfraFileContent.t),
      orderBy: orderBy?.call(InfraFileContent.t),
      orderByList: orderByList?.call(InfraFileContent.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [InfraFileContent] by its [id] or null if no such row exists.
  Future<InfraFileContent?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<InfraFileContent>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [InfraFileContent]s in the list and returns the inserted rows.
  ///
  /// The returned [InfraFileContent]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<InfraFileContent>> insert(
    _i1.Session session,
    List<InfraFileContent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<InfraFileContent>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [InfraFileContent] and returns the inserted row.
  ///
  /// The returned [InfraFileContent] will have its `id` field set.
  Future<InfraFileContent> insertRow(
    _i1.Session session,
    InfraFileContent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<InfraFileContent>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [InfraFileContent]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<InfraFileContent>> update(
    _i1.Session session,
    List<InfraFileContent> rows, {
    _i1.ColumnSelections<InfraFileContentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<InfraFileContent>(
      rows,
      columns: columns?.call(InfraFileContent.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InfraFileContent]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InfraFileContent> updateRow(
    _i1.Session session,
    InfraFileContent row, {
    _i1.ColumnSelections<InfraFileContentTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<InfraFileContent>(
      row,
      columns: columns?.call(InfraFileContent.t),
      transaction: transaction,
    );
  }

  /// Deletes all [InfraFileContent]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<InfraFileContent>> delete(
    _i1.Session session,
    List<InfraFileContent> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<InfraFileContent>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [InfraFileContent].
  Future<InfraFileContent> deleteRow(
    _i1.Session session,
    InfraFileContent row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InfraFileContent>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<InfraFileContent>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<InfraFileContentTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<InfraFileContent>(
      where: where(InfraFileContent.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraFileContentTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<InfraFileContent>(
      where: where?.call(InfraFileContent.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
