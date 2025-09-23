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

/// 文件表
abstract class InfraFile
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  InfraFile._({
    this.id,
    this.configId,
    this.name,
    required this.path,
    required this.url,
    this.type,
    required this.size,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory InfraFile({
    int? id,
    int? configId,
    String? name,
    required String path,
    required String url,
    String? type,
    required int size,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraFileImpl;

  factory InfraFile.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraFile(
      id: jsonSerialization['id'] as int?,
      configId: jsonSerialization['configId'] as int?,
      name: jsonSerialization['name'] as String?,
      path: jsonSerialization['path'] as String,
      url: jsonSerialization['url'] as String,
      type: jsonSerialization['type'] as String?,
      size: jsonSerialization['size'] as int,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = InfraFileTable();

  static const db = InfraFileRepository._();

  @override
  int? id;

  int? configId;

  String? name;

  String path;

  String url;

  String? type;

  int size;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [InfraFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InfraFile copyWith({
    int? id,
    int? configId,
    String? name,
    String? path,
    String? url,
    String? type,
    int? size,
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
      if (configId != null) 'configId': configId,
      if (name != null) 'name': name,
      'path': path,
      'url': url,
      if (type != null) 'type': type,
      'size': size,
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
      if (configId != null) 'configId': configId,
      if (name != null) 'name': name,
      'path': path,
      'url': url,
      if (type != null) 'type': type,
      'size': size,
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
    _i1.WhereExpressionBuilder<InfraFileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InfraFileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraFileTable>? orderByList,
    InfraFileInclude? include,
  }) {
    return InfraFileIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraFile.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(InfraFile.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InfraFileImpl extends InfraFile {
  _InfraFileImpl({
    int? id,
    int? configId,
    String? name,
    required String path,
    required String url,
    String? type,
    required int size,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          configId: configId,
          name: name,
          path: path,
          url: url,
          type: type,
          size: size,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [InfraFile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InfraFile copyWith({
    Object? id = _Undefined,
    Object? configId = _Undefined,
    Object? name = _Undefined,
    String? path,
    String? url,
    Object? type = _Undefined,
    int? size,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraFile(
      id: id is int? ? id : this.id,
      configId: configId is int? ? configId : this.configId,
      name: name is String? ? name : this.name,
      path: path ?? this.path,
      url: url ?? this.url,
      type: type is String? ? type : this.type,
      size: size ?? this.size,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class InfraFileTable extends _i1.Table<int?> {
  InfraFileTable({super.tableRelation}) : super(tableName: 'infra_file') {
    configId = _i1.ColumnInt(
      'configId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    path = _i1.ColumnString(
      'path',
      this,
    );
    url = _i1.ColumnString(
      'url',
      this,
    );
    type = _i1.ColumnString(
      'type',
      this,
    );
    size = _i1.ColumnInt(
      'size',
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

  late final _i1.ColumnString name;

  late final _i1.ColumnString path;

  late final _i1.ColumnString url;

  late final _i1.ColumnString type;

  late final _i1.ColumnInt size;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        configId,
        name,
        path,
        url,
        type,
        size,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class InfraFileInclude extends _i1.IncludeObject {
  InfraFileInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => InfraFile.t;
}

class InfraFileIncludeList extends _i1.IncludeList {
  InfraFileIncludeList._({
    _i1.WhereExpressionBuilder<InfraFileTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InfraFile.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => InfraFile.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraFileTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InfraFileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraFileTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<InfraFile>(
      where: where?.call(InfraFile.t),
      orderBy: orderBy?.call(InfraFile.t),
      orderByList: orderByList?.call(InfraFile.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraFileTable>? where,
    int? offset,
    _i1.OrderByBuilder<InfraFileTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraFileTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<InfraFile>(
      where: where?.call(InfraFile.t),
      orderBy: orderBy?.call(InfraFile.t),
      orderByList: orderByList?.call(InfraFile.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [InfraFile] by its [id] or null if no such row exists.
  Future<InfraFile?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<InfraFile>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [InfraFile]s in the list and returns the inserted rows.
  ///
  /// The returned [InfraFile]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<InfraFile>> insert(
    _i1.Session session,
    List<InfraFile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<InfraFile>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [InfraFile] and returns the inserted row.
  ///
  /// The returned [InfraFile] will have its `id` field set.
  Future<InfraFile> insertRow(
    _i1.Session session,
    InfraFile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<InfraFile>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [InfraFile]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<InfraFile>> update(
    _i1.Session session,
    List<InfraFile> rows, {
    _i1.ColumnSelections<InfraFileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<InfraFile>(
      rows,
      columns: columns?.call(InfraFile.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InfraFile]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InfraFile> updateRow(
    _i1.Session session,
    InfraFile row, {
    _i1.ColumnSelections<InfraFileTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<InfraFile>(
      row,
      columns: columns?.call(InfraFile.t),
      transaction: transaction,
    );
  }

  /// Deletes all [InfraFile]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<InfraFile>> delete(
    _i1.Session session,
    List<InfraFile> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<InfraFile>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [InfraFile].
  Future<InfraFile> deleteRow(
    _i1.Session session,
    InfraFile row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InfraFile>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<InfraFile>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<InfraFileTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<InfraFile>(
      where: where(InfraFile.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraFileTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<InfraFile>(
      where: where?.call(InfraFile.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
