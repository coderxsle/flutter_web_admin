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

/// 文件配置表
abstract class InfraFileConfig
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  InfraFileConfig._({
    this.id,
    required this.name,
    required this.storage,
    this.remark,
    required this.master,
    required this.config,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory InfraFileConfig({
    int? id,
    required String name,
    required int storage,
    String? remark,
    required bool master,
    required String config,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _InfraFileConfigImpl;

  factory InfraFileConfig.fromJson(Map<String, dynamic> jsonSerialization) {
    return InfraFileConfig(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      storage: jsonSerialization['storage'] as int,
      remark: jsonSerialization['remark'] as String?,
      master: jsonSerialization['master'] as bool,
      config: jsonSerialization['config'] as String,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = InfraFileConfigTable();

  static const db = InfraFileConfigRepository._();

  @override
  int? id;

  String name;

  int storage;

  String? remark;

  bool master;

  String config;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [InfraFileConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InfraFileConfig copyWith({
    int? id,
    String? name,
    int? storage,
    String? remark,
    bool? master,
    String? config,
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
      'name': name,
      'storage': storage,
      if (remark != null) 'remark': remark,
      'master': master,
      'config': config,
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
      'name': name,
      'storage': storage,
      if (remark != null) 'remark': remark,
      'master': master,
      'config': config,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static InfraFileConfigInclude include() {
    return InfraFileConfigInclude._();
  }

  static InfraFileConfigIncludeList includeList({
    _i1.WhereExpressionBuilder<InfraFileConfigTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InfraFileConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraFileConfigTable>? orderByList,
    InfraFileConfigInclude? include,
  }) {
    return InfraFileConfigIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InfraFileConfig.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(InfraFileConfig.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InfraFileConfigImpl extends InfraFileConfig {
  _InfraFileConfigImpl({
    int? id,
    required String name,
    required int storage,
    String? remark,
    required bool master,
    required String config,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          name: name,
          storage: storage,
          remark: remark,
          master: master,
          config: config,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [InfraFileConfig]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InfraFileConfig copyWith({
    Object? id = _Undefined,
    String? name,
    int? storage,
    Object? remark = _Undefined,
    bool? master,
    String? config,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return InfraFileConfig(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      storage: storage ?? this.storage,
      remark: remark is String? ? remark : this.remark,
      master: master ?? this.master,
      config: config ?? this.config,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class InfraFileConfigTable extends _i1.Table<int?> {
  InfraFileConfigTable({super.tableRelation})
      : super(tableName: 'infra_file_config') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    storage = _i1.ColumnInt(
      'storage',
      this,
    );
    remark = _i1.ColumnString(
      'remark',
      this,
    );
    master = _i1.ColumnBool(
      'master',
      this,
    );
    config = _i1.ColumnString(
      'config',
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

  late final _i1.ColumnString name;

  late final _i1.ColumnInt storage;

  late final _i1.ColumnString remark;

  late final _i1.ColumnBool master;

  late final _i1.ColumnString config;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        storage,
        remark,
        master,
        config,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class InfraFileConfigInclude extends _i1.IncludeObject {
  InfraFileConfigInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => InfraFileConfig.t;
}

class InfraFileConfigIncludeList extends _i1.IncludeList {
  InfraFileConfigIncludeList._({
    _i1.WhereExpressionBuilder<InfraFileConfigTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InfraFileConfig.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => InfraFileConfig.t;
}

class InfraFileConfigRepository {
  const InfraFileConfigRepository._();

  /// Returns a list of [InfraFileConfig]s matching the given query parameters.
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
  Future<List<InfraFileConfig>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraFileConfigTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InfraFileConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraFileConfigTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<InfraFileConfig>(
      where: where?.call(InfraFileConfig.t),
      orderBy: orderBy?.call(InfraFileConfig.t),
      orderByList: orderByList?.call(InfraFileConfig.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [InfraFileConfig] matching the given query parameters.
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
  Future<InfraFileConfig?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraFileConfigTable>? where,
    int? offset,
    _i1.OrderByBuilder<InfraFileConfigTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InfraFileConfigTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<InfraFileConfig>(
      where: where?.call(InfraFileConfig.t),
      orderBy: orderBy?.call(InfraFileConfig.t),
      orderByList: orderByList?.call(InfraFileConfig.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [InfraFileConfig] by its [id] or null if no such row exists.
  Future<InfraFileConfig?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<InfraFileConfig>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [InfraFileConfig]s in the list and returns the inserted rows.
  ///
  /// The returned [InfraFileConfig]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<InfraFileConfig>> insert(
    _i1.Session session,
    List<InfraFileConfig> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<InfraFileConfig>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [InfraFileConfig] and returns the inserted row.
  ///
  /// The returned [InfraFileConfig] will have its `id` field set.
  Future<InfraFileConfig> insertRow(
    _i1.Session session,
    InfraFileConfig row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<InfraFileConfig>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [InfraFileConfig]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<InfraFileConfig>> update(
    _i1.Session session,
    List<InfraFileConfig> rows, {
    _i1.ColumnSelections<InfraFileConfigTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<InfraFileConfig>(
      rows,
      columns: columns?.call(InfraFileConfig.t),
      transaction: transaction,
    );
  }

  /// Updates a single [InfraFileConfig]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<InfraFileConfig> updateRow(
    _i1.Session session,
    InfraFileConfig row, {
    _i1.ColumnSelections<InfraFileConfigTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<InfraFileConfig>(
      row,
      columns: columns?.call(InfraFileConfig.t),
      transaction: transaction,
    );
  }

  /// Deletes all [InfraFileConfig]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<InfraFileConfig>> delete(
    _i1.Session session,
    List<InfraFileConfig> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<InfraFileConfig>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [InfraFileConfig].
  Future<InfraFileConfig> deleteRow(
    _i1.Session session,
    InfraFileConfig row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InfraFileConfig>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<InfraFileConfig>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<InfraFileConfigTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<InfraFileConfig>(
      where: where(InfraFileConfig.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InfraFileConfigTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<InfraFileConfig>(
      where: where?.call(InfraFileConfig.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
