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

/// App 更新策略表（按租户 + 平台 + 渠道一条）
abstract class AppUpdatePolicy implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AppUpdatePolicy._({
    this.id,
    int? tenantId,
    required this.platform,
    String? channel,
    int? minSupportedVersionCode,
    int? promptCooldownHours,
    int? downloadUrlTtlMinutes,
    bool? enabled,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    bool? deleted,
  }) : tenantId = tenantId ?? 0,
       channel = channel ?? 'official',
       minSupportedVersionCode = minSupportedVersionCode ?? 0,
       promptCooldownHours = promptCooldownHours ?? 24,
       downloadUrlTtlMinutes = downloadUrlTtlMinutes ?? 120,
       enabled = enabled ?? true,
       createTime = createTime ?? DateTime.now(),
       deleted = deleted ?? false;

  factory AppUpdatePolicy({
    int? id,
    int? tenantId,
    required String platform,
    String? channel,
    int? minSupportedVersionCode,
    int? promptCooldownHours,
    int? downloadUrlTtlMinutes,
    bool? enabled,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    bool? deleted,
  }) = _AppUpdatePolicyImpl;

  factory AppUpdatePolicy.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppUpdatePolicy(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      platform: jsonSerialization['platform'] as String,
      channel: jsonSerialization['channel'] as String?,
      minSupportedVersionCode: jsonSerialization['minSupportedVersionCode'] as int?,
      promptCooldownHours: jsonSerialization['promptCooldownHours'] as int?,
      downloadUrlTtlMinutes: jsonSerialization['downloadUrlTtlMinutes'] as int?,
      enabled: jsonSerialization['enabled'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['enabled']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _is.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
    );
  }

  static final t = AppUpdatePolicyTable();

  static const db = AppUpdatePolicyRepository._();

  @override
  int? id;

  int tenantId;

  String platform;

  String channel;

  int minSupportedVersionCode;

  int promptCooldownHours;

  int downloadUrlTtlMinutes;

  bool enabled;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AppUpdatePolicy]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AppUpdatePolicy copyWith({
    int? id,
    int? tenantId,
    String? platform,
    String? channel,
    int? minSupportedVersionCode,
    int? promptCooldownHours,
    int? downloadUrlTtlMinutes,
    bool? enabled,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppUpdatePolicy',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'platform': platform,
      'channel': channel,
      'minSupportedVersionCode': minSupportedVersionCode,
      'promptCooldownHours': promptCooldownHours,
      'downloadUrlTtlMinutes': downloadUrlTtlMinutes,
      'enabled': enabled,
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
      '__className__': 'AppUpdatePolicy',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'platform': platform,
      'channel': channel,
      'minSupportedVersionCode': minSupportedVersionCode,
      'promptCooldownHours': promptCooldownHours,
      'downloadUrlTtlMinutes': downloadUrlTtlMinutes,
      'enabled': enabled,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static AppUpdatePolicyInclude include() {
    return AppUpdatePolicyInclude._();
  }

  static AppUpdatePolicyIncludeList includeList({
    _is.WhereExpressionBuilder<AppUpdatePolicyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AppUpdatePolicyTable>? orderBy,
    _is.OrderByListBuilder<AppUpdatePolicyTable>? orderByList,
    AppUpdatePolicyInclude? include,
  }) {
    return AppUpdatePolicyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppUpdatePolicy.t),
      orderByList: orderByList?.call(AppUpdatePolicy.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppUpdatePolicyImpl extends AppUpdatePolicy {
  _AppUpdatePolicyImpl({
    int? id,
    int? tenantId,
    required String platform,
    String? channel,
    int? minSupportedVersionCode,
    int? promptCooldownHours,
    int? downloadUrlTtlMinutes,
    bool? enabled,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    bool? deleted,
  }) : super._(
         id: id,
         tenantId: tenantId,
         platform: platform,
         channel: channel,
         minSupportedVersionCode: minSupportedVersionCode,
         promptCooldownHours: promptCooldownHours,
         downloadUrlTtlMinutes: downloadUrlTtlMinutes,
         enabled: enabled,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [AppUpdatePolicy]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AppUpdatePolicy copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? platform,
    String? channel,
    int? minSupportedVersionCode,
    int? promptCooldownHours,
    int? downloadUrlTtlMinutes,
    bool? enabled,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return AppUpdatePolicy(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      platform: platform ?? this.platform,
      channel: channel ?? this.channel,
      minSupportedVersionCode: minSupportedVersionCode ?? this.minSupportedVersionCode,
      promptCooldownHours: promptCooldownHours ?? this.promptCooldownHours,
      downloadUrlTtlMinutes: downloadUrlTtlMinutes ?? this.downloadUrlTtlMinutes,
      enabled: enabled ?? this.enabled,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class AppUpdatePolicyUpdateTable extends _is.UpdateTable<AppUpdatePolicyTable> {
  AppUpdatePolicyUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) => _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<String, String> platform(String value) => _is.ColumnValue(table.platform, value);

  _is.ColumnValue<String, String> channel(String value) => _is.ColumnValue(table.channel, value);

  _is.ColumnValue<int, int> minSupportedVersionCode(int value) => _is.ColumnValue(table.minSupportedVersionCode, value);

  _is.ColumnValue<int, int> promptCooldownHours(int value) => _is.ColumnValue(table.promptCooldownHours, value);

  _is.ColumnValue<int, int> downloadUrlTtlMinutes(int value) => _is.ColumnValue(table.downloadUrlTtlMinutes, value);

  _is.ColumnValue<bool, bool> enabled(bool value) => _is.ColumnValue(table.enabled, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);
}

class AppUpdatePolicyTable extends _is.Table<int?> {
  AppUpdatePolicyTable({super.tableRelation}) : super(tableName: 'app_update_policy') {
    updateTable = AppUpdatePolicyUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    platform = _is.ColumnString('platform', this);
    channel = _is.ColumnString('channel', this, hasDefault: true);
    minSupportedVersionCode = _is.ColumnInt('minSupportedVersionCode', this, hasDefault: true);
    promptCooldownHours = _is.ColumnInt('promptCooldownHours', this, hasDefault: true);
    downloadUrlTtlMinutes = _is.ColumnInt('downloadUrlTtlMinutes', this, hasDefault: true);
    enabled = _is.ColumnBool('enabled', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
  }

  late final AppUpdatePolicyUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnString platform;

  late final _is.ColumnString channel;

  late final _is.ColumnInt minSupportedVersionCode;

  late final _is.ColumnInt promptCooldownHours;

  late final _is.ColumnInt downloadUrlTtlMinutes;

  late final _is.ColumnBool enabled;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    platform,
    channel,
    minSupportedVersionCode,
    promptCooldownHours,
    downloadUrlTtlMinutes,
    enabled,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class AppUpdatePolicyInclude extends _is.IncludeObject {
  AppUpdatePolicyInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => AppUpdatePolicy.t;
}

class AppUpdatePolicyIncludeList extends _is.IncludeList {
  AppUpdatePolicyIncludeList._({
    _is.WhereExpressionBuilder<AppUpdatePolicyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AppUpdatePolicy.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AppUpdatePolicy.t;
}

class AppUpdatePolicyRepository {
  const AppUpdatePolicyRepository._();

  /// Returns a list of [AppUpdatePolicy]s matching the given query parameters.
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
  Future<List<AppUpdatePolicy>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AppUpdatePolicyTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AppUpdatePolicyTable>? orderBy,
    _is.OrderByListBuilder<AppUpdatePolicyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AppUpdatePolicy>(
      where: where?.call(AppUpdatePolicy.t),
      orderBy: orderBy?.call(AppUpdatePolicy.t),
      orderByList: orderByList?.call(AppUpdatePolicy.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AppUpdatePolicy] matching the given query parameters.
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
  Future<AppUpdatePolicy?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AppUpdatePolicyTable>? where,
    int? offset,
    _is.OrderByBuilder<AppUpdatePolicyTable>? orderBy,
    _is.OrderByListBuilder<AppUpdatePolicyTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AppUpdatePolicy>(
      where: where?.call(AppUpdatePolicy.t),
      orderBy: orderBy?.call(AppUpdatePolicy.t),
      orderByList: orderByList?.call(AppUpdatePolicy.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AppUpdatePolicy] by its [id] or null if no such row exists.
  Future<AppUpdatePolicy?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AppUpdatePolicy>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AppUpdatePolicy]s in the list and returns the inserted rows.
  ///
  /// The returned [AppUpdatePolicy]s will have their `id` fields set.
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
  Future<List<AppUpdatePolicy>> insert(
    _is.DatabaseSession session,
    List<AppUpdatePolicy> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AppUpdatePolicy>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AppUpdatePolicy] and returns the inserted row.
  ///
  /// The returned [AppUpdatePolicy] will have its `id` field set.
  Future<AppUpdatePolicy> insertRow(
    _is.DatabaseSession session,
    AppUpdatePolicy row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<AppUpdatePolicy>(row, transaction: transaction);
  }

  /// Upserts all [AppUpdatePolicy]s in the list and returns the resulting rows.
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
  /// The returned [AppUpdatePolicy]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AppUpdatePolicy>> upsert(
    _is.DatabaseSession session,
    List<AppUpdatePolicy> rows, {
    required _is.ColumnSelections<AppUpdatePolicyTable> conflictColumns,
    _is.ColumnSelections<AppUpdatePolicyTable>? updateColumns,
    _is.WhereExpressionBuilder<AppUpdatePolicyTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AppUpdatePolicy>(
      rows,
      conflictColumns: conflictColumns(AppUpdatePolicy.t),
      updateColumns: updateColumns?.call(AppUpdatePolicy.t),
      updateWhere: updateWhere?.call(AppUpdatePolicy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AppUpdatePolicy] and returns the resulting row.
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
  /// The returned [AppUpdatePolicy] will have its `id` field set.
  Future<AppUpdatePolicy?> upsertRow(
    _is.DatabaseSession session,
    AppUpdatePolicy row, {
    required _is.ColumnSelections<AppUpdatePolicyTable> conflictColumns,
    _is.ColumnSelections<AppUpdatePolicyTable>? updateColumns,
    _is.WhereExpressionBuilder<AppUpdatePolicyTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AppUpdatePolicy>(
      row,
      conflictColumns: conflictColumns(AppUpdatePolicy.t),
      updateColumns: updateColumns?.call(AppUpdatePolicy.t),
      updateWhere: updateWhere?.call(AppUpdatePolicy.t),
      transaction: transaction,
    );
  }

  /// Updates all [AppUpdatePolicy]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AppUpdatePolicy>> update(
    _is.DatabaseSession session,
    List<AppUpdatePolicy> rows, {
    _is.ColumnSelections<AppUpdatePolicyTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AppUpdatePolicy>(
      rows,
      columns: columns?.call(AppUpdatePolicy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AppUpdatePolicy]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AppUpdatePolicy> updateRow(
    _is.DatabaseSession session,
    AppUpdatePolicy row, {
    _is.ColumnSelections<AppUpdatePolicyTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AppUpdatePolicy>(
      row,
      columns: columns?.call(AppUpdatePolicy.t),
      transaction: transaction,
    );
  }

  /// Updates a single [AppUpdatePolicy] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AppUpdatePolicy?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AppUpdatePolicyUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AppUpdatePolicy>(
      id,
      columnValues: columnValues(AppUpdatePolicy.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AppUpdatePolicy]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AppUpdatePolicy>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AppUpdatePolicyUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AppUpdatePolicyTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AppUpdatePolicyTable>? orderBy,
    _is.OrderByListBuilder<AppUpdatePolicyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AppUpdatePolicy>(
      columnValues: columnValues(AppUpdatePolicy.t.updateTable),
      where: where(AppUpdatePolicy.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppUpdatePolicy.t),
      orderByList: orderByList?.call(AppUpdatePolicy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AppUpdatePolicy]s in the list and returns the deleted rows.
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
  Future<List<AppUpdatePolicy>> delete(
    _is.DatabaseSession session,
    List<AppUpdatePolicy> rows, {
    _is.OrderByBuilder<AppUpdatePolicyTable>? orderBy,
    _is.OrderByListBuilder<AppUpdatePolicyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AppUpdatePolicy>(
      rows,
      orderBy: orderBy?.call(AppUpdatePolicy.t),
      orderByList: orderByList?.call(AppUpdatePolicy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AppUpdatePolicy].
  Future<AppUpdatePolicy> deleteRow(
    _is.DatabaseSession session,
    AppUpdatePolicy row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<AppUpdatePolicy>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AppUpdatePolicy>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AppUpdatePolicyTable> where,
    _is.OrderByBuilder<AppUpdatePolicyTable>? orderBy,
    _is.OrderByListBuilder<AppUpdatePolicyTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AppUpdatePolicy>(
      where: where(AppUpdatePolicy.t),
      orderBy: orderBy?.call(AppUpdatePolicy.t),
      orderByList: orderByList?.call(AppUpdatePolicy.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AppUpdatePolicyTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AppUpdatePolicy>(
      where: where?.call(AppUpdatePolicy.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [AppUpdatePolicy] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AppUpdatePolicyTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AppUpdatePolicy>(
      where: where(AppUpdatePolicy.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
