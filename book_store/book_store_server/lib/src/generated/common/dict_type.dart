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

/// 用于存储数据字典的类型信息
abstract class DictType
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  DictType._({
    this.id,
    String? name,
    String? value,
    String? intro,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : name = name ?? '',
        value = value ?? '',
        intro = intro ?? '',
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory DictType({
    int? id,
    String? name,
    String? value,
    String? intro,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _DictTypeImpl;

  factory DictType.fromJson(Map<String, dynamic> jsonSerialization) {
    return DictType(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      value: jsonSerialization['value'] as String,
      intro: jsonSerialization['intro'] as String,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  static final t = DictTypeTable();

  static const db = DictTypeRepository._();

  @override
  int? id;

  /// 名称（默认空字符串，唯一约束）
  String name;

  /// 值（默认空字符串，唯一约束）
  String value;

  /// 简介（默认空字符串）
  String intro;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [DictType]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictType copyWith({
    int? id,
    String? name,
    String? value,
    String? intro,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'value': value,
      'intro': intro,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'value': value,
      'intro': intro,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  static DictTypeInclude include() {
    return DictTypeInclude._();
  }

  static DictTypeIncludeList includeList({
    _i1.WhereExpressionBuilder<DictTypeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictTypeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictTypeTable>? orderByList,
    DictTypeInclude? include,
  }) {
    return DictTypeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictType.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DictType.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DictTypeImpl extends DictType {
  _DictTypeImpl({
    int? id,
    String? name,
    String? value,
    String? intro,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          name: name,
          value: value,
          intro: intro,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  /// Returns a shallow copy of this [DictType]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictType copyWith({
    Object? id = _Undefined,
    String? name,
    String? value,
    String? intro,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return DictType(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      intro: intro ?? this.intro,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class DictTypeTable extends _i1.Table<int> {
  DictTypeTable({super.tableRelation}) : super(tableName: 'dict_type') {
    name = _i1.ColumnString(
      'name',
      this,
      hasDefault: true,
    );
    value = _i1.ColumnString(
      'value',
      this,
      hasDefault: true,
    );
    intro = _i1.ColumnString(
      'intro',
      this,
      hasDefault: true,
    );
    createTime = _i1.ColumnDateTime(
      'createTime',
      this,
      hasDefault: true,
    );
    updateTime = _i1.ColumnDateTime(
      'updateTime',
      this,
      hasDefault: true,
    );
    isDeleted = _i1.ColumnBool(
      'isDeleted',
      this,
      hasDefault: true,
    );
  }

  /// 名称（默认空字符串，唯一约束）
  late final _i1.ColumnString name;

  /// 值（默认空字符串，唯一约束）
  late final _i1.ColumnString value;

  /// 简介（默认空字符串）
  late final _i1.ColumnString intro;

  /// 记录创建时间
  late final _i1.ColumnDateTime createTime;

  /// 记录最后更新时间
  late final _i1.ColumnDateTime updateTime;

  /// 是否删除
  late final _i1.ColumnBool isDeleted;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        value,
        intro,
        createTime,
        updateTime,
        isDeleted,
      ];
}

class DictTypeInclude extends _i1.IncludeObject {
  DictTypeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => DictType.t;
}

class DictTypeIncludeList extends _i1.IncludeList {
  DictTypeIncludeList._({
    _i1.WhereExpressionBuilder<DictTypeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DictType.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => DictType.t;
}

class DictTypeRepository {
  const DictTypeRepository._();

  /// Returns a list of [DictType]s matching the given query parameters.
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
  Future<List<DictType>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DictTypeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictTypeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictTypeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<DictType>(
      where: where?.call(DictType.t),
      orderBy: orderBy?.call(DictType.t),
      orderByList: orderByList?.call(DictType.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [DictType] matching the given query parameters.
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
  Future<DictType?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DictTypeTable>? where,
    int? offset,
    _i1.OrderByBuilder<DictTypeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictTypeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<DictType>(
      where: where?.call(DictType.t),
      orderBy: orderBy?.call(DictType.t),
      orderByList: orderByList?.call(DictType.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [DictType] by its [id] or null if no such row exists.
  Future<DictType?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<DictType>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [DictType]s in the list and returns the inserted rows.
  ///
  /// The returned [DictType]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<DictType>> insert(
    _i1.Session session,
    List<DictType> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<DictType>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [DictType] and returns the inserted row.
  ///
  /// The returned [DictType] will have its `id` field set.
  Future<DictType> insertRow(
    _i1.Session session,
    DictType row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DictType>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DictType]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DictType>> update(
    _i1.Session session,
    List<DictType> rows, {
    _i1.ColumnSelections<DictTypeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DictType>(
      rows,
      columns: columns?.call(DictType.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictType]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DictType> updateRow(
    _i1.Session session,
    DictType row, {
    _i1.ColumnSelections<DictTypeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DictType>(
      row,
      columns: columns?.call(DictType.t),
      transaction: transaction,
    );
  }

  /// Deletes all [DictType]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DictType>> delete(
    _i1.Session session,
    List<DictType> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DictType>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DictType].
  Future<DictType> deleteRow(
    _i1.Session session,
    DictType row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DictType>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DictType>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DictTypeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DictType>(
      where: where(DictType.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DictTypeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DictType>(
      where: where?.call(DictType.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
