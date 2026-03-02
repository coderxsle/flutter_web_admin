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

/// 系统部门表 - 支持多租户、树形结构
abstract class SysDept
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysDept._({
    this.id,
    int? tenantId,
    this.parentId,
    this.leaderId,
    this.name,
    this.phone,
    this.email,
    this.sort,
    this.status,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
    bool? deleted,
  }) : tenantId = tenantId ?? 0,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now(),
       deleted = deleted ?? false;

  factory SysDept({
    int? id,
    int? tenantId,
    int? parentId,
    int? leaderId,
    String? name,
    String? phone,
    String? email,
    int? sort,
    int? status,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  }) = _SysDeptImpl;

  factory SysDept.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysDept(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      parentId: jsonSerialization['parentId'] as int?,
      leaderId: jsonSerialization['leaderId'] as int?,
      name: jsonSerialization['name'] as String?,
      phone: jsonSerialization['phone'] as String?,
      email: jsonSerialization['email'] as String?,
      sort: jsonSerialization['sort'] as int?,
      status: jsonSerialization['status'] as int?,
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool?,
    );
  }

  static final t = SysDeptTable();

  static const db = SysDeptRepository._();

  @override
  int? id;

  int tenantId;

  int? parentId;

  int? leaderId;

  String? name;

  String? phone;

  String? email;

  int? sort;

  int? status;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysDept]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysDept copyWith({
    int? id,
    int? tenantId,
    int? parentId,
    int? leaderId,
    String? name,
    String? phone,
    String? email,
    int? sort,
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
      '__className__': 'SysDept',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (parentId != null) 'parentId': parentId,
      if (leaderId != null) 'leaderId': leaderId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (sort != null) 'sort': sort,
      if (status != null) 'status': status,
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
      '__className__': 'SysDept',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      if (parentId != null) 'parentId': parentId,
      if (leaderId != null) 'leaderId': leaderId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (email != null) 'email': email,
      if (sort != null) 'sort': sort,
      if (status != null) 'status': status,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysDeptInclude include() {
    return SysDeptInclude._();
  }

  static SysDeptIncludeList includeList({
    _i1.WhereExpressionBuilder<SysDeptTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysDeptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysDeptTable>? orderByList,
    SysDeptInclude? include,
  }) {
    return SysDeptIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysDept.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysDept.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysDeptImpl extends SysDept {
  _SysDeptImpl({
    int? id,
    int? tenantId,
    int? parentId,
    int? leaderId,
    String? name,
    String? phone,
    String? email,
    int? sort,
    int? status,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         parentId: parentId,
         leaderId: leaderId,
         name: name,
         phone: phone,
         email: email,
         sort: sort,
         status: status,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [SysDept]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysDept copyWith({
    Object? id = _Undefined,
    int? tenantId,
    Object? parentId = _Undefined,
    Object? leaderId = _Undefined,
    Object? name = _Undefined,
    Object? phone = _Undefined,
    Object? email = _Undefined,
    Object? sort = _Undefined,
    Object? status = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysDept(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      parentId: parentId is int? ? parentId : this.parentId,
      leaderId: leaderId is int? ? leaderId : this.leaderId,
      name: name is String? ? name : this.name,
      phone: phone is String? ? phone : this.phone,
      email: email is String? ? email : this.email,
      sort: sort is int? ? sort : this.sort,
      status: status is int? ? status : this.status,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysDeptUpdateTable extends _i1.UpdateTable<SysDeptTable> {
  SysDeptUpdateTable(super.table);

  _i1.ColumnValue<int, int> tenantId(int value) => _i1.ColumnValue(
    table.tenantId,
    value,
  );

  _i1.ColumnValue<int, int> parentId(int? value) => _i1.ColumnValue(
    table.parentId,
    value,
  );

  _i1.ColumnValue<int, int> leaderId(int? value) => _i1.ColumnValue(
    table.leaderId,
    value,
  );

  _i1.ColumnValue<String, String> name(String? value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<String, String> phone(String? value) => _i1.ColumnValue(
    table.phone,
    value,
  );

  _i1.ColumnValue<String, String> email(String? value) => _i1.ColumnValue(
    table.email,
    value,
  );

  _i1.ColumnValue<int, int> sort(int? value) => _i1.ColumnValue(
    table.sort,
    value,
  );

  _i1.ColumnValue<int, int> status(int? value) => _i1.ColumnValue(
    table.status,
    value,
  );

  _i1.ColumnValue<String, String> creator(String? value) => _i1.ColumnValue(
    table.creator,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _i1.ColumnValue(
        table.createTime,
        value,
      );

  _i1.ColumnValue<String, String> updater(String? value) => _i1.ColumnValue(
    table.updater,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _i1.ColumnValue(
        table.updateTime,
        value,
      );

  _i1.ColumnValue<bool, bool> deleted(bool value) => _i1.ColumnValue(
    table.deleted,
    value,
  );
}

class SysDeptTable extends _i1.Table<int?> {
  SysDeptTable({super.tableRelation}) : super(tableName: 'sys_dept') {
    updateTable = SysDeptUpdateTable(this);
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
      hasDefault: true,
    );
    parentId = _i1.ColumnInt(
      'parentId',
      this,
    );
    leaderId = _i1.ColumnInt(
      'leaderId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    phone = _i1.ColumnString(
      'phone',
      this,
    );
    email = _i1.ColumnString(
      'email',
      this,
    );
    sort = _i1.ColumnInt(
      'sort',
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
      hasDefault: true,
    );
    deleted = _i1.ColumnBool(
      'deleted',
      this,
      hasDefault: true,
    );
  }

  late final SysDeptUpdateTable updateTable;

  late final _i1.ColumnInt tenantId;

  late final _i1.ColumnInt parentId;

  late final _i1.ColumnInt leaderId;

  late final _i1.ColumnString name;

  late final _i1.ColumnString phone;

  late final _i1.ColumnString email;

  late final _i1.ColumnInt sort;

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
    parentId,
    leaderId,
    name,
    phone,
    email,
    sort,
    status,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class SysDeptInclude extends _i1.IncludeObject {
  SysDeptInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysDept.t;
}

class SysDeptIncludeList extends _i1.IncludeList {
  SysDeptIncludeList._({
    _i1.WhereExpressionBuilder<SysDeptTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysDept.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysDept.t;
}

class SysDeptRepository {
  const SysDeptRepository._();

  /// Returns a list of [SysDept]s matching the given query parameters.
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
  Future<List<SysDept>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysDeptTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysDeptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysDeptTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysDept>(
      where: where?.call(SysDept.t),
      orderBy: orderBy?.call(SysDept.t),
      orderByList: orderByList?.call(SysDept.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysDept] matching the given query parameters.
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
  Future<SysDept?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysDeptTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysDeptTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysDeptTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysDept>(
      where: where?.call(SysDept.t),
      orderBy: orderBy?.call(SysDept.t),
      orderByList: orderByList?.call(SysDept.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysDept] by its [id] or null if no such row exists.
  Future<SysDept?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysDept>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysDept]s in the list and returns the inserted rows.
  ///
  /// The returned [SysDept]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysDept>> insert(
    _i1.Session session,
    List<SysDept> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysDept>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysDept] and returns the inserted row.
  ///
  /// The returned [SysDept] will have its `id` field set.
  Future<SysDept> insertRow(
    _i1.Session session,
    SysDept row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysDept>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysDept]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysDept>> update(
    _i1.Session session,
    List<SysDept> rows, {
    _i1.ColumnSelections<SysDeptTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysDept>(
      rows,
      columns: columns?.call(SysDept.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysDept]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysDept> updateRow(
    _i1.Session session,
    SysDept row, {
    _i1.ColumnSelections<SysDeptTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysDept>(
      row,
      columns: columns?.call(SysDept.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysDept] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysDept?> updateById(
    _i1.Session session,
    int id, {
    required _i1.ColumnValueListBuilder<SysDeptUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<SysDept>(
      id,
      columnValues: columnValues(SysDept.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysDept]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<SysDept>> updateWhere(
    _i1.Session session, {
    required _i1.ColumnValueListBuilder<SysDeptUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SysDeptTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysDeptTable>? orderBy,
    _i1.OrderByListBuilder<SysDeptTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<SysDept>(
      columnValues: columnValues(SysDept.t.updateTable),
      where: where(SysDept.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysDept.t),
      orderByList: orderByList?.call(SysDept.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [SysDept]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysDept>> delete(
    _i1.Session session,
    List<SysDept> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysDept>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysDept].
  Future<SysDept> deleteRow(
    _i1.Session session,
    SysDept row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysDept>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysDept>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysDeptTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysDept>(
      where: where(SysDept.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysDeptTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysDept>(
      where: where?.call(SysDept.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
