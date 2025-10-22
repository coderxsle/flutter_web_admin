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

/// 短信渠道
abstract class SysSmsChannel
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysSmsChannel._({
    this.id,
    required this.signature,
    required this.code,
    required this.status,
    this.remark,
    required this.apiKey,
    this.apiSecret,
    this.callbackUrl,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysSmsChannel({
    int? id,
    required String signature,
    required String code,
    required int status,
    String? remark,
    required String apiKey,
    String? apiSecret,
    String? callbackUrl,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysSmsChannelImpl;

  factory SysSmsChannel.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysSmsChannel(
      id: jsonSerialization['id'] as int?,
      signature: jsonSerialization['signature'] as String,
      code: jsonSerialization['code'] as String,
      status: jsonSerialization['status'] as int,
      remark: jsonSerialization['remark'] as String?,
      apiKey: jsonSerialization['apiKey'] as String,
      apiSecret: jsonSerialization['apiSecret'] as String?,
      callbackUrl: jsonSerialization['callbackUrl'] as String?,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = SysSmsChannelTable();

  static const db = SysSmsChannelRepository._();

  @override
  int? id;

  String signature;

  String code;

  int status;

  String? remark;

  String apiKey;

  String? apiSecret;

  String? callbackUrl;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysSmsChannel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysSmsChannel copyWith({
    int? id,
    String? signature,
    String? code,
    int? status,
    String? remark,
    String? apiKey,
    String? apiSecret,
    String? callbackUrl,
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
      'signature': signature,
      'code': code,
      'status': status,
      if (remark != null) 'remark': remark,
      'apiKey': apiKey,
      if (apiSecret != null) 'apiSecret': apiSecret,
      if (callbackUrl != null) 'callbackUrl': callbackUrl,
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
      'signature': signature,
      'code': code,
      'status': status,
      if (remark != null) 'remark': remark,
      'apiKey': apiKey,
      if (apiSecret != null) 'apiSecret': apiSecret,
      if (callbackUrl != null) 'callbackUrl': callbackUrl,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysSmsChannelInclude include() {
    return SysSmsChannelInclude._();
  }

  static SysSmsChannelIncludeList includeList({
    _i1.WhereExpressionBuilder<SysSmsChannelTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysSmsChannelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSmsChannelTable>? orderByList,
    SysSmsChannelInclude? include,
  }) {
    return SysSmsChannelIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSmsChannel.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysSmsChannel.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysSmsChannelImpl extends SysSmsChannel {
  _SysSmsChannelImpl({
    int? id,
    required String signature,
    required String code,
    required int status,
    String? remark,
    required String apiKey,
    String? apiSecret,
    String? callbackUrl,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          signature: signature,
          code: code,
          status: status,
          remark: remark,
          apiKey: apiKey,
          apiSecret: apiSecret,
          callbackUrl: callbackUrl,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysSmsChannel]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysSmsChannel copyWith({
    Object? id = _Undefined,
    String? signature,
    String? code,
    int? status,
    Object? remark = _Undefined,
    String? apiKey,
    Object? apiSecret = _Undefined,
    Object? callbackUrl = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysSmsChannel(
      id: id is int? ? id : this.id,
      signature: signature ?? this.signature,
      code: code ?? this.code,
      status: status ?? this.status,
      remark: remark is String? ? remark : this.remark,
      apiKey: apiKey ?? this.apiKey,
      apiSecret: apiSecret is String? ? apiSecret : this.apiSecret,
      callbackUrl: callbackUrl is String? ? callbackUrl : this.callbackUrl,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysSmsChannelTable extends _i1.Table<int?> {
  SysSmsChannelTable({super.tableRelation})
      : super(tableName: 'sys_sms_channel') {
    signature = _i1.ColumnString(
      'signature',
      this,
    );
    code = _i1.ColumnString(
      'code',
      this,
    );
    status = _i1.ColumnInt(
      'status',
      this,
    );
    remark = _i1.ColumnString(
      'remark',
      this,
    );
    apiKey = _i1.ColumnString(
      'apiKey',
      this,
    );
    apiSecret = _i1.ColumnString(
      'apiSecret',
      this,
    );
    callbackUrl = _i1.ColumnString(
      'callbackUrl',
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

  late final _i1.ColumnString signature;

  late final _i1.ColumnString code;

  late final _i1.ColumnInt status;

  late final _i1.ColumnString remark;

  late final _i1.ColumnString apiKey;

  late final _i1.ColumnString apiSecret;

  late final _i1.ColumnString callbackUrl;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        signature,
        code,
        status,
        remark,
        apiKey,
        apiSecret,
        callbackUrl,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysSmsChannelInclude extends _i1.IncludeObject {
  SysSmsChannelInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysSmsChannel.t;
}

class SysSmsChannelIncludeList extends _i1.IncludeList {
  SysSmsChannelIncludeList._({
    _i1.WhereExpressionBuilder<SysSmsChannelTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysSmsChannel.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysSmsChannel.t;
}

class SysSmsChannelRepository {
  const SysSmsChannelRepository._();

  /// Returns a list of [SysSmsChannel]s matching the given query parameters.
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
  Future<List<SysSmsChannel>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSmsChannelTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysSmsChannelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSmsChannelTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysSmsChannel>(
      where: where?.call(SysSmsChannel.t),
      orderBy: orderBy?.call(SysSmsChannel.t),
      orderByList: orderByList?.call(SysSmsChannel.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysSmsChannel] matching the given query parameters.
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
  Future<SysSmsChannel?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSmsChannelTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysSmsChannelTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSmsChannelTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysSmsChannel>(
      where: where?.call(SysSmsChannel.t),
      orderBy: orderBy?.call(SysSmsChannel.t),
      orderByList: orderByList?.call(SysSmsChannel.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysSmsChannel] by its [id] or null if no such row exists.
  Future<SysSmsChannel?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysSmsChannel>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysSmsChannel]s in the list and returns the inserted rows.
  ///
  /// The returned [SysSmsChannel]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysSmsChannel>> insert(
    _i1.Session session,
    List<SysSmsChannel> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysSmsChannel>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysSmsChannel] and returns the inserted row.
  ///
  /// The returned [SysSmsChannel] will have its `id` field set.
  Future<SysSmsChannel> insertRow(
    _i1.Session session,
    SysSmsChannel row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysSmsChannel>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysSmsChannel]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysSmsChannel>> update(
    _i1.Session session,
    List<SysSmsChannel> rows, {
    _i1.ColumnSelections<SysSmsChannelTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysSmsChannel>(
      rows,
      columns: columns?.call(SysSmsChannel.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysSmsChannel]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysSmsChannel> updateRow(
    _i1.Session session,
    SysSmsChannel row, {
    _i1.ColumnSelections<SysSmsChannelTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysSmsChannel>(
      row,
      columns: columns?.call(SysSmsChannel.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysSmsChannel]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysSmsChannel>> delete(
    _i1.Session session,
    List<SysSmsChannel> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysSmsChannel>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysSmsChannel].
  Future<SysSmsChannel> deleteRow(
    _i1.Session session,
    SysSmsChannel row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysSmsChannel>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysSmsChannel>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysSmsChannelTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysSmsChannel>(
      where: where(SysSmsChannel.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSmsChannelTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysSmsChannel>(
      where: where?.call(SysSmsChannel.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
