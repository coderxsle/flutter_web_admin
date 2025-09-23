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

/// 字典数据表
abstract class SysDictData
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysDictData._({
    this.id,
    required this.sort,
    required this.label,
    required this.value,
    required this.dictType,
    required this.status,
    this.colorType,
    this.remark,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysDictData({
    int? id,
    required int sort,
    required String label,
    required String value,
    required String dictType,
    required int status,
    String? colorType,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysDictDataImpl;

  factory SysDictData.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysDictData(
      id: jsonSerialization['id'] as int?,
      sort: jsonSerialization['sort'] as int,
      label: jsonSerialization['label'] as String,
      value: jsonSerialization['value'] as String,
      dictType: jsonSerialization['dictType'] as String,
      status: jsonSerialization['status'] as int,
      colorType: jsonSerialization['colorType'] as String?,
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

  static final t = SysDictDataTable();

  static const db = SysDictDataRepository._();

  @override
  int? id;

  int sort;

  String label;

  String value;

  String dictType;

  int status;

  String? colorType;

  String? remark;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysDictData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysDictData copyWith({
    int? id,
    int? sort,
    String? label,
    String? value,
    String? dictType,
    int? status,
    String? colorType,
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
      'sort': sort,
      'label': label,
      'value': value,
      'dictType': dictType,
      'status': status,
      if (colorType != null) 'colorType': colorType,
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
      'sort': sort,
      'label': label,
      'value': value,
      'dictType': dictType,
      'status': status,
      if (colorType != null) 'colorType': colorType,
      if (remark != null) 'remark': remark,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysDictDataInclude include() {
    return SysDictDataInclude._();
  }

  static SysDictDataIncludeList includeList({
    _i1.WhereExpressionBuilder<SysDictDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysDictDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysDictDataTable>? orderByList,
    SysDictDataInclude? include,
  }) {
    return SysDictDataIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysDictData.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysDictData.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysDictDataImpl extends SysDictData {
  _SysDictDataImpl({
    int? id,
    required int sort,
    required String label,
    required String value,
    required String dictType,
    required int status,
    String? colorType,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          sort: sort,
          label: label,
          value: value,
          dictType: dictType,
          status: status,
          colorType: colorType,
          remark: remark,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysDictData]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysDictData copyWith({
    Object? id = _Undefined,
    int? sort,
    String? label,
    String? value,
    String? dictType,
    int? status,
    Object? colorType = _Undefined,
    Object? remark = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysDictData(
      id: id is int? ? id : this.id,
      sort: sort ?? this.sort,
      label: label ?? this.label,
      value: value ?? this.value,
      dictType: dictType ?? this.dictType,
      status: status ?? this.status,
      colorType: colorType is String? ? colorType : this.colorType,
      remark: remark is String? ? remark : this.remark,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysDictDataTable extends _i1.Table<int?> {
  SysDictDataTable({super.tableRelation}) : super(tableName: 'sys_dict_data') {
    sort = _i1.ColumnInt(
      'sort',
      this,
    );
    label = _i1.ColumnString(
      'label',
      this,
    );
    value = _i1.ColumnString(
      'value',
      this,
    );
    dictType = _i1.ColumnString(
      'dictType',
      this,
    );
    status = _i1.ColumnInt(
      'status',
      this,
    );
    colorType = _i1.ColumnString(
      'colorType',
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

  late final _i1.ColumnInt sort;

  late final _i1.ColumnString label;

  late final _i1.ColumnString value;

  late final _i1.ColumnString dictType;

  late final _i1.ColumnInt status;

  late final _i1.ColumnString colorType;

  late final _i1.ColumnString remark;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        sort,
        label,
        value,
        dictType,
        status,
        colorType,
        remark,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysDictDataInclude extends _i1.IncludeObject {
  SysDictDataInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysDictData.t;
}

class SysDictDataIncludeList extends _i1.IncludeList {
  SysDictDataIncludeList._({
    _i1.WhereExpressionBuilder<SysDictDataTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysDictData.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysDictData.t;
}

class SysDictDataRepository {
  const SysDictDataRepository._();

  /// Returns a list of [SysDictData]s matching the given query parameters.
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
  Future<List<SysDictData>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysDictDataTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysDictDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysDictDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysDictData>(
      where: where?.call(SysDictData.t),
      orderBy: orderBy?.call(SysDictData.t),
      orderByList: orderByList?.call(SysDictData.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysDictData] matching the given query parameters.
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
  Future<SysDictData?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysDictDataTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysDictDataTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysDictDataTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysDictData>(
      where: where?.call(SysDictData.t),
      orderBy: orderBy?.call(SysDictData.t),
      orderByList: orderByList?.call(SysDictData.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysDictData] by its [id] or null if no such row exists.
  Future<SysDictData?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysDictData>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysDictData]s in the list and returns the inserted rows.
  ///
  /// The returned [SysDictData]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysDictData>> insert(
    _i1.Session session,
    List<SysDictData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysDictData>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysDictData] and returns the inserted row.
  ///
  /// The returned [SysDictData] will have its `id` field set.
  Future<SysDictData> insertRow(
    _i1.Session session,
    SysDictData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysDictData>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysDictData]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysDictData>> update(
    _i1.Session session,
    List<SysDictData> rows, {
    _i1.ColumnSelections<SysDictDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysDictData>(
      rows,
      columns: columns?.call(SysDictData.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysDictData]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysDictData> updateRow(
    _i1.Session session,
    SysDictData row, {
    _i1.ColumnSelections<SysDictDataTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysDictData>(
      row,
      columns: columns?.call(SysDictData.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysDictData]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysDictData>> delete(
    _i1.Session session,
    List<SysDictData> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysDictData>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysDictData].
  Future<SysDictData> deleteRow(
    _i1.Session session,
    SysDictData row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysDictData>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysDictData>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysDictDataTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysDictData>(
      where: where(SysDictData.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysDictDataTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysDictData>(
      where: where?.call(SysDictData.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
