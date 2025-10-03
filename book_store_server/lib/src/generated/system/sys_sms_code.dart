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

/// 手机验证码
abstract class SysSmsCode
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysSmsCode._({
    this.id,
    int? tenantId,
    required this.mobile,
    required this.code,
    required this.createIp,
    required this.scene,
    required this.todayIndex,
    required this.used,
    this.usedTime,
    this.usedIp,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  })  : tenantId = tenantId ?? 0,
        createTime = createTime ?? DateTime.now();

  factory SysSmsCode({
    int? id,
    int? tenantId,
    required String mobile,
    required String code,
    required String createIp,
    required int scene,
    required int todayIndex,
    required int used,
    DateTime? usedTime,
    String? usedIp,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysSmsCodeImpl;

  factory SysSmsCode.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysSmsCode(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      mobile: jsonSerialization['mobile'] as String,
      code: jsonSerialization['code'] as String,
      createIp: jsonSerialization['createIp'] as String,
      scene: jsonSerialization['scene'] as int,
      todayIndex: jsonSerialization['todayIndex'] as int,
      used: jsonSerialization['used'] as int,
      usedTime: jsonSerialization['usedTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['usedTime']),
      usedIp: jsonSerialization['usedIp'] as String?,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = SysSmsCodeTable();

  static const db = SysSmsCodeRepository._();

  @override
  int? id;

  int tenantId;

  String mobile;

  String code;

  String createIp;

  int scene;

  int todayIndex;

  int used;

  DateTime? usedTime;

  String? usedIp;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysSmsCode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysSmsCode copyWith({
    int? id,
    int? tenantId,
    String? mobile,
    String? code,
    String? createIp,
    int? scene,
    int? todayIndex,
    int? used,
    DateTime? usedTime,
    String? usedIp,
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
      'mobile': mobile,
      'code': code,
      'createIp': createIp,
      'scene': scene,
      'todayIndex': todayIndex,
      'used': used,
      if (usedTime != null) 'usedTime': usedTime?.toJson(),
      if (usedIp != null) 'usedIp': usedIp,
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
      'mobile': mobile,
      'code': code,
      'createIp': createIp,
      'scene': scene,
      'todayIndex': todayIndex,
      'used': used,
      if (usedTime != null) 'usedTime': usedTime?.toJson(),
      if (usedIp != null) 'usedIp': usedIp,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysSmsCodeInclude include() {
    return SysSmsCodeInclude._();
  }

  static SysSmsCodeIncludeList includeList({
    _i1.WhereExpressionBuilder<SysSmsCodeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysSmsCodeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSmsCodeTable>? orderByList,
    SysSmsCodeInclude? include,
  }) {
    return SysSmsCodeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSmsCode.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysSmsCode.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysSmsCodeImpl extends SysSmsCode {
  _SysSmsCodeImpl({
    int? id,
    int? tenantId,
    required String mobile,
    required String code,
    required String createIp,
    required int scene,
    required int todayIndex,
    required int used,
    DateTime? usedTime,
    String? usedIp,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          mobile: mobile,
          code: code,
          createIp: createIp,
          scene: scene,
          todayIndex: todayIndex,
          used: used,
          usedTime: usedTime,
          usedIp: usedIp,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysSmsCode]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysSmsCode copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? mobile,
    String? code,
    String? createIp,
    int? scene,
    int? todayIndex,
    int? used,
    Object? usedTime = _Undefined,
    Object? usedIp = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysSmsCode(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      mobile: mobile ?? this.mobile,
      code: code ?? this.code,
      createIp: createIp ?? this.createIp,
      scene: scene ?? this.scene,
      todayIndex: todayIndex ?? this.todayIndex,
      used: used ?? this.used,
      usedTime: usedTime is DateTime? ? usedTime : this.usedTime,
      usedIp: usedIp is String? ? usedIp : this.usedIp,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysSmsCodeTable extends _i1.Table<int?> {
  SysSmsCodeTable({super.tableRelation}) : super(tableName: 'sys_sms_code') {
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
      hasDefault: true,
    );
    mobile = _i1.ColumnString(
      'mobile',
      this,
    );
    code = _i1.ColumnString(
      'code',
      this,
    );
    createIp = _i1.ColumnString(
      'createIp',
      this,
    );
    scene = _i1.ColumnInt(
      'scene',
      this,
    );
    todayIndex = _i1.ColumnInt(
      'todayIndex',
      this,
    );
    used = _i1.ColumnInt(
      'used',
      this,
    );
    usedTime = _i1.ColumnDateTime(
      'usedTime',
      this,
    );
    usedIp = _i1.ColumnString(
      'usedIp',
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

  late final _i1.ColumnString mobile;

  late final _i1.ColumnString code;

  late final _i1.ColumnString createIp;

  late final _i1.ColumnInt scene;

  late final _i1.ColumnInt todayIndex;

  late final _i1.ColumnInt used;

  late final _i1.ColumnDateTime usedTime;

  late final _i1.ColumnString usedIp;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        tenantId,
        mobile,
        code,
        createIp,
        scene,
        todayIndex,
        used,
        usedTime,
        usedIp,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysSmsCodeInclude extends _i1.IncludeObject {
  SysSmsCodeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysSmsCode.t;
}

class SysSmsCodeIncludeList extends _i1.IncludeList {
  SysSmsCodeIncludeList._({
    _i1.WhereExpressionBuilder<SysSmsCodeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysSmsCode.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysSmsCode.t;
}

class SysSmsCodeRepository {
  const SysSmsCodeRepository._();

  /// Returns a list of [SysSmsCode]s matching the given query parameters.
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
  Future<List<SysSmsCode>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSmsCodeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysSmsCodeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSmsCodeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysSmsCode>(
      where: where?.call(SysSmsCode.t),
      orderBy: orderBy?.call(SysSmsCode.t),
      orderByList: orderByList?.call(SysSmsCode.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysSmsCode] matching the given query parameters.
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
  Future<SysSmsCode?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSmsCodeTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysSmsCodeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSmsCodeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysSmsCode>(
      where: where?.call(SysSmsCode.t),
      orderBy: orderBy?.call(SysSmsCode.t),
      orderByList: orderByList?.call(SysSmsCode.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysSmsCode] by its [id] or null if no such row exists.
  Future<SysSmsCode?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysSmsCode>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysSmsCode]s in the list and returns the inserted rows.
  ///
  /// The returned [SysSmsCode]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysSmsCode>> insert(
    _i1.Session session,
    List<SysSmsCode> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysSmsCode>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysSmsCode] and returns the inserted row.
  ///
  /// The returned [SysSmsCode] will have its `id` field set.
  Future<SysSmsCode> insertRow(
    _i1.Session session,
    SysSmsCode row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysSmsCode>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysSmsCode]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysSmsCode>> update(
    _i1.Session session,
    List<SysSmsCode> rows, {
    _i1.ColumnSelections<SysSmsCodeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysSmsCode>(
      rows,
      columns: columns?.call(SysSmsCode.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysSmsCode]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysSmsCode> updateRow(
    _i1.Session session,
    SysSmsCode row, {
    _i1.ColumnSelections<SysSmsCodeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysSmsCode>(
      row,
      columns: columns?.call(SysSmsCode.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysSmsCode]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysSmsCode>> delete(
    _i1.Session session,
    List<SysSmsCode> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysSmsCode>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysSmsCode].
  Future<SysSmsCode> deleteRow(
    _i1.Session session,
    SysSmsCode row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysSmsCode>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysSmsCode>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysSmsCodeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysSmsCode>(
      where: where(SysSmsCode.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSmsCodeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysSmsCode>(
      where: where?.call(SysSmsCode.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
