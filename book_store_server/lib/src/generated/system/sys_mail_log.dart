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

/// 邮件日志表
abstract class SysMailLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysMailLog._({
    this.id,
    this.userId,
    this.userType,
    required this.toMail,
    required this.accountId,
    required this.fromMail,
    required this.templateId,
    required this.templateCode,
    this.templateNickname,
    required this.templateTitle,
    required this.templateContent,
    required this.templateParams,
    required this.sendStatus,
    this.sendTime,
    this.sendMessageId,
    this.sendException,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysMailLog({
    int? id,
    int? userId,
    int? userType,
    required String toMail,
    required int accountId,
    required String fromMail,
    required int templateId,
    required String templateCode,
    String? templateNickname,
    required String templateTitle,
    required String templateContent,
    required String templateParams,
    required int sendStatus,
    DateTime? sendTime,
    String? sendMessageId,
    String? sendException,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysMailLogImpl;

  factory SysMailLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysMailLog(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int?,
      userType: jsonSerialization['userType'] as int?,
      toMail: jsonSerialization['toMail'] as String,
      accountId: jsonSerialization['accountId'] as int,
      fromMail: jsonSerialization['fromMail'] as String,
      templateId: jsonSerialization['templateId'] as int,
      templateCode: jsonSerialization['templateCode'] as String,
      templateNickname: jsonSerialization['templateNickname'] as String?,
      templateTitle: jsonSerialization['templateTitle'] as String,
      templateContent: jsonSerialization['templateContent'] as String,
      templateParams: jsonSerialization['templateParams'] as String,
      sendStatus: jsonSerialization['sendStatus'] as int,
      sendTime: jsonSerialization['sendTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sendTime']),
      sendMessageId: jsonSerialization['sendMessageId'] as String?,
      sendException: jsonSerialization['sendException'] as String?,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = SysMailLogTable();

  static const db = SysMailLogRepository._();

  @override
  int? id;

  int? userId;

  int? userType;

  String toMail;

  int accountId;

  String fromMail;

  int templateId;

  String templateCode;

  String? templateNickname;

  String templateTitle;

  String templateContent;

  String templateParams;

  int sendStatus;

  DateTime? sendTime;

  String? sendMessageId;

  String? sendException;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysMailLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysMailLog copyWith({
    int? id,
    int? userId,
    int? userType,
    String? toMail,
    int? accountId,
    String? fromMail,
    int? templateId,
    String? templateCode,
    String? templateNickname,
    String? templateTitle,
    String? templateContent,
    String? templateParams,
    int? sendStatus,
    DateTime? sendTime,
    String? sendMessageId,
    String? sendException,
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
      if (userId != null) 'userId': userId,
      if (userType != null) 'userType': userType,
      'toMail': toMail,
      'accountId': accountId,
      'fromMail': fromMail,
      'templateId': templateId,
      'templateCode': templateCode,
      if (templateNickname != null) 'templateNickname': templateNickname,
      'templateTitle': templateTitle,
      'templateContent': templateContent,
      'templateParams': templateParams,
      'sendStatus': sendStatus,
      if (sendTime != null) 'sendTime': sendTime?.toJson(),
      if (sendMessageId != null) 'sendMessageId': sendMessageId,
      if (sendException != null) 'sendException': sendException,
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
      if (userId != null) 'userId': userId,
      if (userType != null) 'userType': userType,
      'toMail': toMail,
      'accountId': accountId,
      'fromMail': fromMail,
      'templateId': templateId,
      'templateCode': templateCode,
      if (templateNickname != null) 'templateNickname': templateNickname,
      'templateTitle': templateTitle,
      'templateContent': templateContent,
      'templateParams': templateParams,
      'sendStatus': sendStatus,
      if (sendTime != null) 'sendTime': sendTime?.toJson(),
      if (sendMessageId != null) 'sendMessageId': sendMessageId,
      if (sendException != null) 'sendException': sendException,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysMailLogInclude include() {
    return SysMailLogInclude._();
  }

  static SysMailLogIncludeList includeList({
    _i1.WhereExpressionBuilder<SysMailLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysMailLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysMailLogTable>? orderByList,
    SysMailLogInclude? include,
  }) {
    return SysMailLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysMailLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysMailLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysMailLogImpl extends SysMailLog {
  _SysMailLogImpl({
    int? id,
    int? userId,
    int? userType,
    required String toMail,
    required int accountId,
    required String fromMail,
    required int templateId,
    required String templateCode,
    String? templateNickname,
    required String templateTitle,
    required String templateContent,
    required String templateParams,
    required int sendStatus,
    DateTime? sendTime,
    String? sendMessageId,
    String? sendException,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          userId: userId,
          userType: userType,
          toMail: toMail,
          accountId: accountId,
          fromMail: fromMail,
          templateId: templateId,
          templateCode: templateCode,
          templateNickname: templateNickname,
          templateTitle: templateTitle,
          templateContent: templateContent,
          templateParams: templateParams,
          sendStatus: sendStatus,
          sendTime: sendTime,
          sendMessageId: sendMessageId,
          sendException: sendException,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysMailLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysMailLog copyWith({
    Object? id = _Undefined,
    Object? userId = _Undefined,
    Object? userType = _Undefined,
    String? toMail,
    int? accountId,
    String? fromMail,
    int? templateId,
    String? templateCode,
    Object? templateNickname = _Undefined,
    String? templateTitle,
    String? templateContent,
    String? templateParams,
    int? sendStatus,
    Object? sendTime = _Undefined,
    Object? sendMessageId = _Undefined,
    Object? sendException = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysMailLog(
      id: id is int? ? id : this.id,
      userId: userId is int? ? userId : this.userId,
      userType: userType is int? ? userType : this.userType,
      toMail: toMail ?? this.toMail,
      accountId: accountId ?? this.accountId,
      fromMail: fromMail ?? this.fromMail,
      templateId: templateId ?? this.templateId,
      templateCode: templateCode ?? this.templateCode,
      templateNickname: templateNickname is String?
          ? templateNickname
          : this.templateNickname,
      templateTitle: templateTitle ?? this.templateTitle,
      templateContent: templateContent ?? this.templateContent,
      templateParams: templateParams ?? this.templateParams,
      sendStatus: sendStatus ?? this.sendStatus,
      sendTime: sendTime is DateTime? ? sendTime : this.sendTime,
      sendMessageId:
          sendMessageId is String? ? sendMessageId : this.sendMessageId,
      sendException:
          sendException is String? ? sendException : this.sendException,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysMailLogTable extends _i1.Table<int?> {
  SysMailLogTable({super.tableRelation}) : super(tableName: 'sys_mail_log') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    userType = _i1.ColumnInt(
      'userType',
      this,
    );
    toMail = _i1.ColumnString(
      'toMail',
      this,
    );
    accountId = _i1.ColumnInt(
      'accountId',
      this,
    );
    fromMail = _i1.ColumnString(
      'fromMail',
      this,
    );
    templateId = _i1.ColumnInt(
      'templateId',
      this,
    );
    templateCode = _i1.ColumnString(
      'templateCode',
      this,
    );
    templateNickname = _i1.ColumnString(
      'templateNickname',
      this,
    );
    templateTitle = _i1.ColumnString(
      'templateTitle',
      this,
    );
    templateContent = _i1.ColumnString(
      'templateContent',
      this,
    );
    templateParams = _i1.ColumnString(
      'templateParams',
      this,
    );
    sendStatus = _i1.ColumnInt(
      'sendStatus',
      this,
    );
    sendTime = _i1.ColumnDateTime(
      'sendTime',
      this,
    );
    sendMessageId = _i1.ColumnString(
      'sendMessageId',
      this,
    );
    sendException = _i1.ColumnString(
      'sendException',
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

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt userType;

  late final _i1.ColumnString toMail;

  late final _i1.ColumnInt accountId;

  late final _i1.ColumnString fromMail;

  late final _i1.ColumnInt templateId;

  late final _i1.ColumnString templateCode;

  late final _i1.ColumnString templateNickname;

  late final _i1.ColumnString templateTitle;

  late final _i1.ColumnString templateContent;

  late final _i1.ColumnString templateParams;

  late final _i1.ColumnInt sendStatus;

  late final _i1.ColumnDateTime sendTime;

  late final _i1.ColumnString sendMessageId;

  late final _i1.ColumnString sendException;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        userType,
        toMail,
        accountId,
        fromMail,
        templateId,
        templateCode,
        templateNickname,
        templateTitle,
        templateContent,
        templateParams,
        sendStatus,
        sendTime,
        sendMessageId,
        sendException,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysMailLogInclude extends _i1.IncludeObject {
  SysMailLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysMailLog.t;
}

class SysMailLogIncludeList extends _i1.IncludeList {
  SysMailLogIncludeList._({
    _i1.WhereExpressionBuilder<SysMailLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysMailLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysMailLog.t;
}

class SysMailLogRepository {
  const SysMailLogRepository._();

  /// Returns a list of [SysMailLog]s matching the given query parameters.
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
  Future<List<SysMailLog>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysMailLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysMailLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysMailLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysMailLog>(
      where: where?.call(SysMailLog.t),
      orderBy: orderBy?.call(SysMailLog.t),
      orderByList: orderByList?.call(SysMailLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysMailLog] matching the given query parameters.
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
  Future<SysMailLog?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysMailLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysMailLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysMailLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysMailLog>(
      where: where?.call(SysMailLog.t),
      orderBy: orderBy?.call(SysMailLog.t),
      orderByList: orderByList?.call(SysMailLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysMailLog] by its [id] or null if no such row exists.
  Future<SysMailLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysMailLog>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysMailLog]s in the list and returns the inserted rows.
  ///
  /// The returned [SysMailLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysMailLog>> insert(
    _i1.Session session,
    List<SysMailLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysMailLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysMailLog] and returns the inserted row.
  ///
  /// The returned [SysMailLog] will have its `id` field set.
  Future<SysMailLog> insertRow(
    _i1.Session session,
    SysMailLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysMailLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysMailLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysMailLog>> update(
    _i1.Session session,
    List<SysMailLog> rows, {
    _i1.ColumnSelections<SysMailLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysMailLog>(
      rows,
      columns: columns?.call(SysMailLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysMailLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysMailLog> updateRow(
    _i1.Session session,
    SysMailLog row, {
    _i1.ColumnSelections<SysMailLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysMailLog>(
      row,
      columns: columns?.call(SysMailLog.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysMailLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysMailLog>> delete(
    _i1.Session session,
    List<SysMailLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysMailLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysMailLog].
  Future<SysMailLog> deleteRow(
    _i1.Session session,
    SysMailLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysMailLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysMailLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysMailLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysMailLog>(
      where: where(SysMailLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysMailLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysMailLog>(
      where: where?.call(SysMailLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
