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

/// 用于存储数据字典的条目信息
abstract class DictItem
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  DictItem._({
    this.id,
    String? name,
    String? value,
    int? sn,
    int? disabled,
    int? typeId,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : name = name ?? '',
        value = value ?? '',
        sn = sn ?? 0,
        disabled = disabled ?? 0,
        typeId = typeId ?? 0,
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory DictItem({
    int? id,
    String? name,
    String? value,
    int? sn,
    int? disabled,
    int? typeId,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _DictItemImpl;

  factory DictItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return DictItem(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      value: jsonSerialization['value'] as String,
      sn: jsonSerialization['sn'] as int,
      disabled: jsonSerialization['disabled'] as int,
      typeId: jsonSerialization['typeId'] as int,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  static final t = DictItemTable();

  static const db = DictItemRepository._();

  @override
  int? id;

  /// 名称（默认空字符串）
  String name;

  /// 值（默认空字符串）
  String value;

  /// 排列顺序，默认0。值越大，就排在越前面
  int sn;

  /// 是否禁用。0代表不禁用（启用），1代表禁用
  int disabled;

  /// 所属的类型
  int typeId;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [DictItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DictItem copyWith({
    int? id,
    String? name,
    String? value,
    int? sn,
    int? disabled,
    int? typeId,
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
      'sn': sn,
      'disabled': disabled,
      'typeId': typeId,
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
      'sn': sn,
      'disabled': disabled,
      'typeId': typeId,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  static DictItemInclude include() {
    return DictItemInclude._();
  }

  static DictItemIncludeList includeList({
    _i1.WhereExpressionBuilder<DictItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictItemTable>? orderByList,
    DictItemInclude? include,
  }) {
    return DictItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictItem.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DictItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DictItemImpl extends DictItem {
  _DictItemImpl({
    int? id,
    String? name,
    String? value,
    int? sn,
    int? disabled,
    int? typeId,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          name: name,
          value: value,
          sn: sn,
          disabled: disabled,
          typeId: typeId,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  /// Returns a shallow copy of this [DictItem]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DictItem copyWith({
    Object? id = _Undefined,
    String? name,
    String? value,
    int? sn,
    int? disabled,
    int? typeId,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return DictItem(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      sn: sn ?? this.sn,
      disabled: disabled ?? this.disabled,
      typeId: typeId ?? this.typeId,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class DictItemTable extends _i1.Table<int> {
  DictItemTable({super.tableRelation}) : super(tableName: 'dict_item') {
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
    sn = _i1.ColumnInt(
      'sn',
      this,
      hasDefault: true,
    );
    disabled = _i1.ColumnInt(
      'disabled',
      this,
      hasDefault: true,
    );
    typeId = _i1.ColumnInt(
      'typeId',
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

  /// 名称（默认空字符串）
  late final _i1.ColumnString name;

  /// 值（默认空字符串）
  late final _i1.ColumnString value;

  /// 排列顺序，默认0。值越大，就排在越前面
  late final _i1.ColumnInt sn;

  /// 是否禁用。0代表不禁用（启用），1代表禁用
  late final _i1.ColumnInt disabled;

  /// 所属的类型
  late final _i1.ColumnInt typeId;

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
        sn,
        disabled,
        typeId,
        createTime,
        updateTime,
        isDeleted,
      ];
}

class DictItemInclude extends _i1.IncludeObject {
  DictItemInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => DictItem.t;
}

class DictItemIncludeList extends _i1.IncludeList {
  DictItemIncludeList._({
    _i1.WhereExpressionBuilder<DictItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DictItem.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => DictItem.t;
}

class DictItemRepository {
  const DictItemRepository._();

  /// Returns a list of [DictItem]s matching the given query parameters.
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
  Future<List<DictItem>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DictItemTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<DictItem>(
      where: where?.call(DictItem.t),
      orderBy: orderBy?.call(DictItem.t),
      orderByList: orderByList?.call(DictItem.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [DictItem] matching the given query parameters.
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
  Future<DictItem?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DictItemTable>? where,
    int? offset,
    _i1.OrderByBuilder<DictItemTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictItemTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<DictItem>(
      where: where?.call(DictItem.t),
      orderBy: orderBy?.call(DictItem.t),
      orderByList: orderByList?.call(DictItem.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [DictItem] by its [id] or null if no such row exists.
  Future<DictItem?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<DictItem>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [DictItem]s in the list and returns the inserted rows.
  ///
  /// The returned [DictItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<DictItem>> insert(
    _i1.Session session,
    List<DictItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<DictItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [DictItem] and returns the inserted row.
  ///
  /// The returned [DictItem] will have its `id` field set.
  Future<DictItem> insertRow(
    _i1.Session session,
    DictItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DictItem>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [DictItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<DictItem>> update(
    _i1.Session session,
    List<DictItem> rows, {
    _i1.ColumnSelections<DictItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DictItem>(
      rows,
      columns: columns?.call(DictItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [DictItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<DictItem> updateRow(
    _i1.Session session,
    DictItem row, {
    _i1.ColumnSelections<DictItemTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DictItem>(
      row,
      columns: columns?.call(DictItem.t),
      transaction: transaction,
    );
  }

  /// Deletes all [DictItem]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<DictItem>> delete(
    _i1.Session session,
    List<DictItem> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DictItem>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [DictItem].
  Future<DictItem> deleteRow(
    _i1.Session session,
    DictItem row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DictItem>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<DictItem>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DictItemTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DictItem>(
      where: where(DictItem.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DictItemTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DictItem>(
      where: where?.call(DictItem.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
