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
import 'package:serverpod/serverpod.dart' as _is;

/// 文件表
abstract class InfraFile implements _is.TableRow<int?>, _is.ProtocolSerialization {
  InfraFile._({
    this.id,
    int? tenantId,
    this.configId,
    this.parentId,
    required this.name,
    bool? isDir,
    required this.path,
    this.storageKey,
    this.url,
    this.type,
    this.extendName,
    this.mimeType,
    int? size,
    this.sha256,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : tenantId = tenantId ?? 0,
       isDir = isDir ?? false,
       size = size ?? 0,
       createTime = createTime ?? DateTime.now();

  factory InfraFile({
    int? id,
    int? tenantId,
    int? configId,
    int? parentId,
    required String name,
    bool? isDir,
    required String path,
    String? storageKey,
    String? url,
    String? type,
    String? extendName,
    String? mimeType,
    int? size,
    String? sha256,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraFileImpl;

  factory InfraFile.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraFile(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      configId: jsonSerialization['configId'] as int?,
      parentId: jsonSerialization['parentId'] as int?,
      name: jsonSerialization['name'] as String,
      isDir: jsonSerialization['isDir'] == null ? null : _is.BoolJsonExtension.fromJson(jsonSerialization['isDir']),
      path: jsonSerialization['path'] as String,
      storageKey: jsonSerialization['storageKey'] as String?,
      url: jsonSerialization['url'] as String?,
      type: jsonSerialization['type'] as String?,
      extendName: jsonSerialization['extendName'] as String?,
      mimeType: jsonSerialization['mimeType'] as String?,
      size: jsonSerialization['size'] as int?,
      sha256: jsonSerialization['sha256'] as String?,
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _is.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: _is.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
    );
  }

  static final t = InfraFileTable();

  static const db = InfraFileRepository._();

  @override
  int? id;

  int tenantId;

  int? configId;

  int? parentId;

  String name;

  bool isDir;

  String path;

  String? storageKey;

  String? url;

  String? type;

  String? extendName;

  String? mimeType;

  int size;

  String? sha256;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [InfraFile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  InfraFile copyWith({
    int? id,
    int? tenantId,
    int? configId,
    int? parentId,
    String? name,
    bool? isDir,
    String? path,
    String? storageKey,
    String? url,
    String? type,
    String? extendName,
    String? mimeType,
    int? size,
    String? sha256,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InfraFile',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (configId != null) 'configId': configId,
      if (parentId != null) 'parentId': parentId,
      'name': name,
      'isDir': isDir,
      'path': path,
      if (storageKey != null) 'storageKey': storageKey,
      if (url != null) 'url': url,
      if (type != null) 'type': type,
      if (extendName != null) 'extendName': extendName,
      if (mimeType != null) 'mimeType': mimeType,
      'size': size,
      if (sha256 != null) 'sha256': sha256,
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
      '__className__': 'InfraFile',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (configId != null) 'configId': configId,
      if (parentId != null) 'parentId': parentId,
      'name': name,
      'isDir': isDir,
      'path': path,
      if (storageKey != null) 'storageKey': storageKey,
      if (url != null) 'url': url,
      if (type != null) 'type': type,
      if (extendName != null) 'extendName': extendName,
      if (mimeType != null) 'mimeType': mimeType,
      'size': size,
      if (sha256 != null) 'sha256': sha256,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static InfraFileInclude include() {
    return InfraFileInclude._();
  }

  static InfraFileIncludeList includeList({
    _is.WhereExpressionBuilder<InfraFileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraFileTable>? orderBy,
    _is.OrderByListBuilder<InfraFileTable>? orderByList,
    InfraFileInclude? include,
  }) {
    return InfraFileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraFile.t),
      orderByList: orderByList?.call(InfraFile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InfraFileImpl extends InfraFile {
  _InfraFileImpl({
    int? id,
    int? tenantId,
    int? configId,
    int? parentId,
    required String name,
    bool? isDir,
    required String path,
    String? storageKey,
    String? url,
    String? type,
    String? extendName,
    String? mimeType,
    int? size,
    String? sha256,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         configId: configId,
         parentId: parentId,
         name: name,
         isDir: isDir,
         path: path,
         storageKey: storageKey,
         url: url,
         type: type,
         extendName: extendName,
         mimeType: mimeType,
         size: size,
         sha256: sha256,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [InfraFile]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  InfraFile copyWith({
    Object? id = _Undefined,
    int? tenantId,
    Object? configId = _Undefined,
    Object? parentId = _Undefined,
    String? name,
    bool? isDir,
    String? path,
    Object? storageKey = _Undefined,
    Object? url = _Undefined,
    Object? type = _Undefined,
    Object? extendName = _Undefined,
    Object? mimeType = _Undefined,
    int? size,
    Object? sha256 = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraFile(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      configId: configId is int? ? configId : this.configId,
      parentId: parentId is int? ? parentId : this.parentId,
      name: name ?? this.name,
      isDir: isDir ?? this.isDir,
      path: path ?? this.path,
      storageKey: storageKey is String? ? storageKey : this.storageKey,
      url: url is String? ? url : this.url,
      type: type is String? ? type : this.type,
      extendName: extendName is String? ? extendName : this.extendName,
      mimeType: mimeType is String? ? mimeType : this.mimeType,
      size: size ?? this.size,
      sha256: sha256 is String? ? sha256 : this.sha256,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class InfraFileUpdateTable extends _is.UpdateTable<InfraFileTable> {
  InfraFileUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) => _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> configId(int? value) => _is.ColumnValue(table.configId, value);

  _is.ColumnValue<int, int> parentId(int? value) => _is.ColumnValue(table.parentId, value);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(table.name, value);

  _is.ColumnValue<bool, bool> isDir(bool value) => _is.ColumnValue(table.isDir, value);

  _is.ColumnValue<String, String> path(String value) => _is.ColumnValue(table.path, value);

  _is.ColumnValue<String, String> storageKey(String? value) => _is.ColumnValue(table.storageKey, value);

  _is.ColumnValue<String, String> url(String? value) => _is.ColumnValue(table.url, value);

  _is.ColumnValue<String, String> type(String? value) => _is.ColumnValue(table.type, value);

  _is.ColumnValue<String, String> extendName(String? value) => _is.ColumnValue(table.extendName, value);

  _is.ColumnValue<String, String> mimeType(String? value) => _is.ColumnValue(table.mimeType, value);

  _is.ColumnValue<int, int> size(int value) => _is.ColumnValue(table.size, value);

  _is.ColumnValue<String, String> sha256(String? value) => _is.ColumnValue(table.sha256, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);
}

class InfraFileTable extends _is.Table<int?> {
  InfraFileTable({super.tableRelation}) : super(tableName: 'infra_file') {
    updateTable = InfraFileUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    configId = _is.ColumnInt('configId', this);
    parentId = _is.ColumnInt('parentId', this);
    name = _is.ColumnString('name', this);
    isDir = _is.ColumnBool('isDir', this, hasDefault: true);
    path = _is.ColumnString('path', this);
    storageKey = _is.ColumnString('storageKey', this);
    url = _is.ColumnString('url', this);
    type = _is.ColumnString('type', this);
    extendName = _is.ColumnString('extendName', this);
    mimeType = _is.ColumnString('mimeType', this);
    size = _is.ColumnInt('size', this, hasDefault: true);
    sha256 = _is.ColumnString('sha256', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final InfraFileUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnInt configId;

  late final _is.ColumnInt parentId;

  late final _is.ColumnString name;

  late final _is.ColumnBool isDir;

  late final _is.ColumnString path;

  late final _is.ColumnString storageKey;

  late final _is.ColumnString url;

  late final _is.ColumnString type;

  late final _is.ColumnString extendName;

  late final _is.ColumnString mimeType;

  late final _is.ColumnInt size;

  late final _is.ColumnString sha256;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    configId,
    parentId,
    name,
    isDir,
    path,
    storageKey,
    url,
    type,
    extendName,
    mimeType,
    size,
    sha256,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class InfraFileInclude extends _is.IncludeObject {
  InfraFileInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => InfraFile.t;
}

class InfraFileIncludeList extends _is.IncludeList {
  InfraFileIncludeList._({
    _is.WhereExpressionBuilder<InfraFileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InfraFile.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => InfraFile.t;
}

class InfraFileRepository {
  const InfraFileRepository._();

  /// Returns a list of [InfraFile]s matching the given query parameters.
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
  Future<List<InfraFile>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraFileTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraFileTable>? orderBy,
    _is.OrderByListBuilder<InfraFileTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<InfraFile>(
      where: where?.call(InfraFile.t),
      orderBy: orderBy?.call(InfraFile.t),
      orderByList: orderByList?.call(InfraFile.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [InfraFile] matching the given query parameters.
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
  Future<InfraFile?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraFileTable>? where,
    int? offset,
    _is.OrderByBuilder<InfraFileTable>? orderBy,
    _is.OrderByListBuilder<InfraFileTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<InfraFile>(
      where: where?.call(InfraFile.t),
      orderBy: orderBy?.call(InfraFile.t),
      orderByList: orderByList?.call(InfraFile.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [InfraFile] by its [id] or null if no such row exists.
  Future<InfraFile?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<InfraFile>(id, transaction: transaction, lockMode: lockMode, lockBehavior: lockBehavior);
  }

  /// Inserts all [InfraFile]s in the list and returns the inserted rows.
  ///
  /// The returned [InfraFile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraFile>> insert(
    _is.DatabaseSession session,
    List<InfraFile> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<InfraFile>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [InfraFile] and returns the inserted row.
  ///
  /// The returned [InfraFile] will have its `id` field set.
  Future<InfraFile> insertRow(_is.DatabaseSession session, InfraFile row, {_is.Transaction? transaction}) async {
    return session.db.insertRow<InfraFile>(row, transaction: transaction);
  }

  /// Upserts all [InfraFile]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [InfraFile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraFile>> upsert(
    _is.DatabaseSession session,
    List<InfraFile> rows, {
    required _is.ColumnSelections<InfraFileTable> conflictColumns,
    _is.ColumnSelections<InfraFileTable>? updateColumns,
    _is.WhereExpressionBuilder<InfraFileTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<InfraFile>(
      rows,
      conflictColumns: conflictColumns(InfraFile.t),
      updateColumns: updateColumns?.call(InfraFile.t),
      updateWhere: updateWhere?.call(InfraFile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [InfraFile] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [InfraFile] will have its `id` field set.
  Future<InfraFile?> upsertRow(
    _is.DatabaseSession session,
    InfraFile row, {
    required _is.ColumnSelections<InfraFileTable> conflictColumns,
    _is.ColumnSelections<InfraFileTable>? updateColumns,
    _is.WhereExpressionBuilder<InfraFileTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<InfraFile>(
      row,
      conflictColumns: conflictColumns(InfraFile.t),
      updateColumns: updateColumns?.call(InfraFile.t),
      updateWhere: updateWhere?.call(InfraFile.t),
      transaction: transaction,
    );
  }

  /// Updates all [InfraFile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraFile>> update(
    _is.DatabaseSession session,
    List<InfraFile> rows, {
    _is.ColumnSelections<InfraFileTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<InfraFile>(
      rows,
      columns: columns?.call(InfraFile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [InfraFile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InfraFile> updateRow(
    _is.DatabaseSession session,
    InfraFile row, {
    _is.ColumnSelections<InfraFileTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<InfraFile>(row, columns: columns?.call(InfraFile.t), transaction: transaction);
  }

  /// Updates a single [InfraFile] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<InfraFile?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<InfraFileUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<InfraFile>(
      id,
      columnValues: columnValues(InfraFile.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [InfraFile]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraFile>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<InfraFileUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<InfraFileTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<InfraFileTable>? orderBy,
    _is.OrderByListBuilder<InfraFileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<InfraFile>(
      columnValues: columnValues(InfraFile.t.updateTable),
      where: where(InfraFile.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraFile.t),
      orderByList: orderByList?.call(InfraFile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [InfraFile]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraFile>> delete(
    _is.DatabaseSession session,
    List<InfraFile> rows, {
    _is.OrderByBuilder<InfraFileTable>? orderBy,
    _is.OrderByListBuilder<InfraFileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<InfraFile>(
      rows,
      orderBy: orderBy?.call(InfraFile.t),
      orderByList: orderByList?.call(InfraFile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [InfraFile].
  Future<InfraFile> deleteRow(_is.DatabaseSession session, InfraFile row, {_is.Transaction? transaction}) async {
    return session.db.deleteRow<InfraFile>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<InfraFile>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InfraFileTable> where,
    _is.OrderByBuilder<InfraFileTable>? orderBy,
    _is.OrderByListBuilder<InfraFileTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<InfraFile>(
      where: where(InfraFile.t),
      orderBy: orderBy?.call(InfraFile.t),
      orderByList: orderByList?.call(InfraFile.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<InfraFileTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<InfraFile>(where: where?.call(InfraFile.t), limit: limit, transaction: transaction);
  }

  /// Acquires row-level locks on [InfraFile] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<InfraFileTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<InfraFile>(
      where: where(InfraFile.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
