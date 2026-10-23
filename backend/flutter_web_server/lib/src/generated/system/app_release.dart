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

/// App 版本发布表（按租户隔离，tenantId=0 为平台级默认版本）
abstract class AppRelease implements _is.TableRow<int?>, _is.ProtocolSerialization {
  AppRelease._({
    this.id,
    int? tenantId,
    required this.platform,
    String? channel,
    required this.versionName,
    required this.versionCode,
    String? releaseNotes,
    this.minOsVersion,
    String? status,
    int? rolloutPercent,
    bool? forceUpdate,
    this.storageKey,
    this.fileName,
    int? fileSize,
    this.sha256,
    this.storeUrl,
    this.publishedAt,
    int? downloadCount,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    bool? deleted,
  }) : tenantId = tenantId ?? 0,
       channel = channel ?? 'official',
       releaseNotes = releaseNotes ?? '',
       status = status ?? 'draft',
       rolloutPercent = rolloutPercent ?? 0,
       forceUpdate = forceUpdate ?? false,
       fileSize = fileSize ?? 0,
       downloadCount = downloadCount ?? 0,
       createTime = createTime ?? DateTime.now(),
       deleted = deleted ?? false;

  factory AppRelease({
    int? id,
    int? tenantId,
    required String platform,
    String? channel,
    required String versionName,
    required int versionCode,
    String? releaseNotes,
    String? minOsVersion,
    String? status,
    int? rolloutPercent,
    bool? forceUpdate,
    String? storageKey,
    String? fileName,
    int? fileSize,
    String? sha256,
    String? storeUrl,
    DateTime? publishedAt,
    int? downloadCount,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    bool? deleted,
  }) = _AppReleaseImpl;

  factory AppRelease.fromJson(Map<String, dynamic> jsonSerialization) {
    return AppRelease(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      platform: jsonSerialization['platform'] as String,
      channel: jsonSerialization['channel'] as String?,
      versionName: jsonSerialization['versionName'] as String,
      versionCode: jsonSerialization['versionCode'] as int,
      releaseNotes: jsonSerialization['releaseNotes'] as String?,
      minOsVersion: jsonSerialization['minOsVersion'] as String?,
      status: jsonSerialization['status'] as String?,
      rolloutPercent: jsonSerialization['rolloutPercent'] as int?,
      forceUpdate: jsonSerialization['forceUpdate'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['forceUpdate']),
      storageKey: jsonSerialization['storageKey'] as String?,
      fileName: jsonSerialization['fileName'] as String?,
      fileSize: jsonSerialization['fileSize'] as int?,
      sha256: jsonSerialization['sha256'] as String?,
      storeUrl: jsonSerialization['storeUrl'] as String?,
      publishedAt: jsonSerialization['publishedAt'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['publishedAt']),
      downloadCount: jsonSerialization['downloadCount'] as int?,
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

  static final t = AppReleaseTable();

  static const db = AppReleaseRepository._();

  @override
  int? id;

  int tenantId;

  String platform;

  String channel;

  String versionName;

  int versionCode;

  String releaseNotes;

  String? minOsVersion;

  String status;

  int rolloutPercent;

  bool forceUpdate;

  String? storageKey;

  String? fileName;

  int fileSize;

  String? sha256;

  String? storeUrl;

  DateTime? publishedAt;

  int downloadCount;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [AppRelease]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  AppRelease copyWith({
    int? id,
    int? tenantId,
    String? platform,
    String? channel,
    String? versionName,
    int? versionCode,
    String? releaseNotes,
    String? minOsVersion,
    String? status,
    int? rolloutPercent,
    bool? forceUpdate,
    String? storageKey,
    String? fileName,
    int? fileSize,
    String? sha256,
    String? storeUrl,
    DateTime? publishedAt,
    int? downloadCount,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AppRelease',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'platform': platform,
      'channel': channel,
      'versionName': versionName,
      'versionCode': versionCode,
      'releaseNotes': releaseNotes,
      if (minOsVersion != null) 'minOsVersion': minOsVersion,
      'status': status,
      'rolloutPercent': rolloutPercent,
      'forceUpdate': forceUpdate,
      if (storageKey != null) 'storageKey': storageKey,
      if (fileName != null) 'fileName': fileName,
      'fileSize': fileSize,
      if (sha256 != null) 'sha256': sha256,
      if (storeUrl != null) 'storeUrl': storeUrl,
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      'downloadCount': downloadCount,
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
      '__className__': 'AppRelease',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'platform': platform,
      'channel': channel,
      'versionName': versionName,
      'versionCode': versionCode,
      'releaseNotes': releaseNotes,
      if (minOsVersion != null) 'minOsVersion': minOsVersion,
      'status': status,
      'rolloutPercent': rolloutPercent,
      'forceUpdate': forceUpdate,
      if (storageKey != null) 'storageKey': storageKey,
      if (fileName != null) 'fileName': fileName,
      'fileSize': fileSize,
      if (sha256 != null) 'sha256': sha256,
      if (storeUrl != null) 'storeUrl': storeUrl,
      if (publishedAt != null) 'publishedAt': publishedAt?.toJson(),
      'downloadCount': downloadCount,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static AppReleaseInclude include() {
    return AppReleaseInclude._();
  }

  static AppReleaseIncludeList includeList({
    _is.WhereExpressionBuilder<AppReleaseTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AppReleaseTable>? orderBy,
    _is.OrderByListBuilder<AppReleaseTable>? orderByList,
    AppReleaseInclude? include,
  }) {
    return AppReleaseIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppRelease.t),
      orderByList: orderByList?.call(AppRelease.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AppReleaseImpl extends AppRelease {
  _AppReleaseImpl({
    int? id,
    int? tenantId,
    required String platform,
    String? channel,
    required String versionName,
    required int versionCode,
    String? releaseNotes,
    String? minOsVersion,
    String? status,
    int? rolloutPercent,
    bool? forceUpdate,
    String? storageKey,
    String? fileName,
    int? fileSize,
    String? sha256,
    String? storeUrl,
    DateTime? publishedAt,
    int? downloadCount,
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
         versionName: versionName,
         versionCode: versionCode,
         releaseNotes: releaseNotes,
         minOsVersion: minOsVersion,
         status: status,
         rolloutPercent: rolloutPercent,
         forceUpdate: forceUpdate,
         storageKey: storageKey,
         fileName: fileName,
         fileSize: fileSize,
         sha256: sha256,
         storeUrl: storeUrl,
         publishedAt: publishedAt,
         downloadCount: downloadCount,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [AppRelease]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  AppRelease copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? platform,
    String? channel,
    String? versionName,
    int? versionCode,
    String? releaseNotes,
    Object? minOsVersion = _Undefined,
    String? status,
    int? rolloutPercent,
    bool? forceUpdate,
    Object? storageKey = _Undefined,
    Object? fileName = _Undefined,
    int? fileSize,
    Object? sha256 = _Undefined,
    Object? storeUrl = _Undefined,
    Object? publishedAt = _Undefined,
    int? downloadCount,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return AppRelease(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      platform: platform ?? this.platform,
      channel: channel ?? this.channel,
      versionName: versionName ?? this.versionName,
      versionCode: versionCode ?? this.versionCode,
      releaseNotes: releaseNotes ?? this.releaseNotes,
      minOsVersion: minOsVersion is String? ? minOsVersion : this.minOsVersion,
      status: status ?? this.status,
      rolloutPercent: rolloutPercent ?? this.rolloutPercent,
      forceUpdate: forceUpdate ?? this.forceUpdate,
      storageKey: storageKey is String? ? storageKey : this.storageKey,
      fileName: fileName is String? ? fileName : this.fileName,
      fileSize: fileSize ?? this.fileSize,
      sha256: sha256 is String? ? sha256 : this.sha256,
      storeUrl: storeUrl is String? ? storeUrl : this.storeUrl,
      publishedAt: publishedAt is DateTime? ? publishedAt : this.publishedAt,
      downloadCount: downloadCount ?? this.downloadCount,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class AppReleaseUpdateTable extends _is.UpdateTable<AppReleaseTable> {
  AppReleaseUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) => _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<String, String> platform(String value) => _is.ColumnValue(table.platform, value);

  _is.ColumnValue<String, String> channel(String value) => _is.ColumnValue(table.channel, value);

  _is.ColumnValue<String, String> versionName(String value) => _is.ColumnValue(table.versionName, value);

  _is.ColumnValue<int, int> versionCode(int value) => _is.ColumnValue(table.versionCode, value);

  _is.ColumnValue<String, String> releaseNotes(String value) => _is.ColumnValue(table.releaseNotes, value);

  _is.ColumnValue<String, String> minOsVersion(String? value) => _is.ColumnValue(table.minOsVersion, value);

  _is.ColumnValue<String, String> status(String value) => _is.ColumnValue(table.status, value);

  _is.ColumnValue<int, int> rolloutPercent(int value) => _is.ColumnValue(table.rolloutPercent, value);

  _is.ColumnValue<bool, bool> forceUpdate(bool value) => _is.ColumnValue(table.forceUpdate, value);

  _is.ColumnValue<String, String> storageKey(String? value) => _is.ColumnValue(table.storageKey, value);

  _is.ColumnValue<String, String> fileName(String? value) => _is.ColumnValue(table.fileName, value);

  _is.ColumnValue<int, int> fileSize(int value) => _is.ColumnValue(table.fileSize, value);

  _is.ColumnValue<String, String> sha256(String? value) => _is.ColumnValue(table.sha256, value);

  _is.ColumnValue<String, String> storeUrl(String? value) => _is.ColumnValue(table.storeUrl, value);

  _is.ColumnValue<DateTime, DateTime> publishedAt(DateTime? value) => _is.ColumnValue(table.publishedAt, value);

  _is.ColumnValue<int, int> downloadCount(int value) => _is.ColumnValue(table.downloadCount, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);
}

class AppReleaseTable extends _is.Table<int?> {
  AppReleaseTable({super.tableRelation}) : super(tableName: 'app_release') {
    updateTable = AppReleaseUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    platform = _is.ColumnString('platform', this);
    channel = _is.ColumnString('channel', this, hasDefault: true);
    versionName = _is.ColumnString('versionName', this);
    versionCode = _is.ColumnInt('versionCode', this);
    releaseNotes = _is.ColumnString('releaseNotes', this, hasDefault: true);
    minOsVersion = _is.ColumnString('minOsVersion', this);
    status = _is.ColumnString('status', this, hasDefault: true);
    rolloutPercent = _is.ColumnInt('rolloutPercent', this, hasDefault: true);
    forceUpdate = _is.ColumnBool('forceUpdate', this, hasDefault: true);
    storageKey = _is.ColumnString('storageKey', this);
    fileName = _is.ColumnString('fileName', this);
    fileSize = _is.ColumnInt('fileSize', this, hasDefault: true);
    sha256 = _is.ColumnString('sha256', this);
    storeUrl = _is.ColumnString('storeUrl', this);
    publishedAt = _is.ColumnDateTime('publishedAt', this);
    downloadCount = _is.ColumnInt('downloadCount', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
  }

  late final AppReleaseUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnString platform;

  late final _is.ColumnString channel;

  late final _is.ColumnString versionName;

  late final _is.ColumnInt versionCode;

  late final _is.ColumnString releaseNotes;

  late final _is.ColumnString minOsVersion;

  late final _is.ColumnString status;

  late final _is.ColumnInt rolloutPercent;

  late final _is.ColumnBool forceUpdate;

  late final _is.ColumnString storageKey;

  late final _is.ColumnString fileName;

  late final _is.ColumnInt fileSize;

  late final _is.ColumnString sha256;

  late final _is.ColumnString storeUrl;

  late final _is.ColumnDateTime publishedAt;

  late final _is.ColumnInt downloadCount;

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
    versionName,
    versionCode,
    releaseNotes,
    minOsVersion,
    status,
    rolloutPercent,
    forceUpdate,
    storageKey,
    fileName,
    fileSize,
    sha256,
    storeUrl,
    publishedAt,
    downloadCount,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class AppReleaseInclude extends _is.IncludeObject {
  AppReleaseInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => AppRelease.t;
}

class AppReleaseIncludeList extends _is.IncludeList {
  AppReleaseIncludeList._({
    _is.WhereExpressionBuilder<AppReleaseTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(AppRelease.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => AppRelease.t;
}

class AppReleaseRepository {
  const AppReleaseRepository._();

  /// Returns a list of [AppRelease]s matching the given query parameters.
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
  Future<List<AppRelease>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AppReleaseTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AppReleaseTable>? orderBy,
    _is.OrderByListBuilder<AppReleaseTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<AppRelease>(
      where: where?.call(AppRelease.t),
      orderBy: orderBy?.call(AppRelease.t),
      orderByList: orderByList?.call(AppRelease.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [AppRelease] matching the given query parameters.
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
  Future<AppRelease?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AppReleaseTable>? where,
    int? offset,
    _is.OrderByBuilder<AppReleaseTable>? orderBy,
    _is.OrderByListBuilder<AppReleaseTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<AppRelease>(
      where: where?.call(AppRelease.t),
      orderBy: orderBy?.call(AppRelease.t),
      orderByList: orderByList?.call(AppRelease.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [AppRelease] by its [id] or null if no such row exists.
  Future<AppRelease?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<AppRelease>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [AppRelease]s in the list and returns the inserted rows.
  ///
  /// The returned [AppRelease]s will have their `id` fields set.
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
  Future<List<AppRelease>> insert(
    _is.DatabaseSession session,
    List<AppRelease> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<AppRelease>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [AppRelease] and returns the inserted row.
  ///
  /// The returned [AppRelease] will have its `id` field set.
  Future<AppRelease> insertRow(_is.DatabaseSession session, AppRelease row, {_is.Transaction? transaction}) async {
    return session.db.insertRow<AppRelease>(row, transaction: transaction);
  }

  /// Upserts all [AppRelease]s in the list and returns the resulting rows.
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
  /// The returned [AppRelease]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AppRelease>> upsert(
    _is.DatabaseSession session,
    List<AppRelease> rows, {
    required _is.ColumnSelections<AppReleaseTable> conflictColumns,
    _is.ColumnSelections<AppReleaseTable>? updateColumns,
    _is.WhereExpressionBuilder<AppReleaseTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<AppRelease>(
      rows,
      conflictColumns: conflictColumns(AppRelease.t),
      updateColumns: updateColumns?.call(AppRelease.t),
      updateWhere: updateWhere?.call(AppRelease.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [AppRelease] and returns the resulting row.
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
  /// The returned [AppRelease] will have its `id` field set.
  Future<AppRelease?> upsertRow(
    _is.DatabaseSession session,
    AppRelease row, {
    required _is.ColumnSelections<AppReleaseTable> conflictColumns,
    _is.ColumnSelections<AppReleaseTable>? updateColumns,
    _is.WhereExpressionBuilder<AppReleaseTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<AppRelease>(
      row,
      conflictColumns: conflictColumns(AppRelease.t),
      updateColumns: updateColumns?.call(AppRelease.t),
      updateWhere: updateWhere?.call(AppRelease.t),
      transaction: transaction,
    );
  }

  /// Updates all [AppRelease]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AppRelease>> update(
    _is.DatabaseSession session,
    List<AppRelease> rows, {
    _is.ColumnSelections<AppReleaseTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<AppRelease>(
      rows,
      columns: columns?.call(AppRelease.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [AppRelease]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<AppRelease> updateRow(
    _is.DatabaseSession session,
    AppRelease row, {
    _is.ColumnSelections<AppReleaseTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<AppRelease>(row, columns: columns?.call(AppRelease.t), transaction: transaction);
  }

  /// Updates a single [AppRelease] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<AppRelease?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<AppReleaseUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<AppRelease>(
      id,
      columnValues: columnValues(AppRelease.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [AppRelease]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AppRelease>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<AppReleaseUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<AppReleaseTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<AppReleaseTable>? orderBy,
    _is.OrderByListBuilder<AppReleaseTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<AppRelease>(
      columnValues: columnValues(AppRelease.t.updateTable),
      where: where(AppRelease.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(AppRelease.t),
      orderByList: orderByList?.call(AppRelease.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [AppRelease]s in the list and returns the deleted rows.
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
  Future<List<AppRelease>> delete(
    _is.DatabaseSession session,
    List<AppRelease> rows, {
    _is.OrderByBuilder<AppReleaseTable>? orderBy,
    _is.OrderByListBuilder<AppReleaseTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<AppRelease>(
      rows,
      orderBy: orderBy?.call(AppRelease.t),
      orderByList: orderByList?.call(AppRelease.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [AppRelease].
  Future<AppRelease> deleteRow(_is.DatabaseSession session, AppRelease row, {_is.Transaction? transaction}) async {
    return session.db.deleteRow<AppRelease>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<AppRelease>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AppReleaseTable> where,
    _is.OrderByBuilder<AppReleaseTable>? orderBy,
    _is.OrderByListBuilder<AppReleaseTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<AppRelease>(
      where: where(AppRelease.t),
      orderBy: orderBy?.call(AppRelease.t),
      orderByList: orderByList?.call(AppRelease.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<AppReleaseTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<AppRelease>(where: where?.call(AppRelease.t), limit: limit, transaction: transaction);
  }

  /// Acquires row-level locks on [AppRelease] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<AppReleaseTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<AppRelease>(
      where: where(AppRelease.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
