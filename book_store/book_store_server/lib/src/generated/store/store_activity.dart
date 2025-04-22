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

abstract class StoreActivity
    implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  StoreActivity._({
    this.id,
    required this.storeId,
    required this.name,
    required this.address,
    required this.description,
    required this.startTime,
    required this.endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory StoreActivity({
    int? id,
    required int storeId,
    required String name,
    required String address,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _StoreActivityImpl;

  factory StoreActivity.fromJson(Map<String, dynamic> jsonSerialization) {
    return StoreActivity(
      id: jsonSerialization['id'] as int?,
      storeId: jsonSerialization['storeId'] as int,
      name: jsonSerialization['name'] as String,
      address: jsonSerialization['address'] as String,
      description: jsonSerialization['description'] as String,
      startTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startTime']),
      endTime: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  static final t = StoreActivityTable();

  static const db = StoreActivityRepository._();

  @override
  int? id;

  /// 店铺ID
  int storeId;

  /// 活动名称
  String name;

  /// 活动地点
  String address;

  /// 活动描述
  String description;

  /// 开始时间
  DateTime startTime;

  /// 结束时间
  DateTime endTime;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否已删除（默认值：false）
  bool isDeleted;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [StoreActivity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StoreActivity copyWith({
    int? id,
    int? storeId,
    String? name,
    String? address,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'storeId': storeId,
      'name': name,
      'address': address,
      'description': description,
      'startTime': startTime.toJson(),
      'endTime': endTime.toJson(),
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'storeId': storeId,
      'name': name,
      'address': address,
      'description': description,
      'startTime': startTime.toJson(),
      'endTime': endTime.toJson(),
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  static StoreActivityInclude include() {
    return StoreActivityInclude._();
  }

  static StoreActivityIncludeList includeList({
    _i1.WhereExpressionBuilder<StoreActivityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreActivityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreActivityTable>? orderByList,
    StoreActivityInclude? include,
  }) {
    return StoreActivityIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(StoreActivity.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(StoreActivity.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreActivityImpl extends StoreActivity {
  _StoreActivityImpl({
    int? id,
    required int storeId,
    required String name,
    required String address,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          storeId: storeId,
          name: name,
          address: address,
          description: description,
          startTime: startTime,
          endTime: endTime,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  /// Returns a shallow copy of this [StoreActivity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StoreActivity copyWith({
    Object? id = _Undefined,
    int? storeId,
    String? name,
    String? address,
    String? description,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return StoreActivity(
      id: id is int? ? id : this.id,
      storeId: storeId ?? this.storeId,
      name: name ?? this.name,
      address: address ?? this.address,
      description: description ?? this.description,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class StoreActivityTable extends _i1.Table<int> {
  StoreActivityTable({super.tableRelation})
      : super(tableName: 'store_activity') {
    storeId = _i1.ColumnInt(
      'storeId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    address = _i1.ColumnString(
      'address',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    startTime = _i1.ColumnDateTime(
      'startTime',
      this,
    );
    endTime = _i1.ColumnDateTime(
      'endTime',
      this,
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

  /// 店铺ID
  late final _i1.ColumnInt storeId;

  /// 活动名称
  late final _i1.ColumnString name;

  /// 活动地点
  late final _i1.ColumnString address;

  /// 活动描述
  late final _i1.ColumnString description;

  /// 开始时间
  late final _i1.ColumnDateTime startTime;

  /// 结束时间
  late final _i1.ColumnDateTime endTime;

  /// 记录创建时间
  late final _i1.ColumnDateTime createTime;

  /// 记录最后更新时间
  late final _i1.ColumnDateTime updateTime;

  /// 是否已删除（默认值：false）
  late final _i1.ColumnBool isDeleted;

  @override
  List<_i1.Column> get columns => [
        id,
        storeId,
        name,
        address,
        description,
        startTime,
        endTime,
        createTime,
        updateTime,
        isDeleted,
      ];
}

class StoreActivityInclude extends _i1.IncludeObject {
  StoreActivityInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => StoreActivity.t;
}

class StoreActivityIncludeList extends _i1.IncludeList {
  StoreActivityIncludeList._({
    _i1.WhereExpressionBuilder<StoreActivityTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(StoreActivity.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => StoreActivity.t;
}

class StoreActivityRepository {
  const StoreActivityRepository._();

  /// Returns a list of [StoreActivity]s matching the given query parameters.
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
  Future<List<StoreActivity>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreActivityTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<StoreActivityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreActivityTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<StoreActivity>(
      where: where?.call(StoreActivity.t),
      orderBy: orderBy?.call(StoreActivity.t),
      orderByList: orderByList?.call(StoreActivity.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [StoreActivity] matching the given query parameters.
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
  Future<StoreActivity?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreActivityTable>? where,
    int? offset,
    _i1.OrderByBuilder<StoreActivityTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<StoreActivityTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<StoreActivity>(
      where: where?.call(StoreActivity.t),
      orderBy: orderBy?.call(StoreActivity.t),
      orderByList: orderByList?.call(StoreActivity.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [StoreActivity] by its [id] or null if no such row exists.
  Future<StoreActivity?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<StoreActivity>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [StoreActivity]s in the list and returns the inserted rows.
  ///
  /// The returned [StoreActivity]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<StoreActivity>> insert(
    _i1.Session session,
    List<StoreActivity> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<StoreActivity>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [StoreActivity] and returns the inserted row.
  ///
  /// The returned [StoreActivity] will have its `id` field set.
  Future<StoreActivity> insertRow(
    _i1.Session session,
    StoreActivity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<StoreActivity>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [StoreActivity]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<StoreActivity>> update(
    _i1.Session session,
    List<StoreActivity> rows, {
    _i1.ColumnSelections<StoreActivityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<StoreActivity>(
      rows,
      columns: columns?.call(StoreActivity.t),
      transaction: transaction,
    );
  }

  /// Updates a single [StoreActivity]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<StoreActivity> updateRow(
    _i1.Session session,
    StoreActivity row, {
    _i1.ColumnSelections<StoreActivityTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<StoreActivity>(
      row,
      columns: columns?.call(StoreActivity.t),
      transaction: transaction,
    );
  }

  /// Deletes all [StoreActivity]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<StoreActivity>> delete(
    _i1.Session session,
    List<StoreActivity> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<StoreActivity>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [StoreActivity].
  Future<StoreActivity> deleteRow(
    _i1.Session session,
    StoreActivity row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<StoreActivity>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<StoreActivity>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<StoreActivityTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<StoreActivity>(
      where: where(StoreActivity.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<StoreActivityTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<StoreActivity>(
      where: where?.call(StoreActivity.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
