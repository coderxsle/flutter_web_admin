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

/// 短信日志
abstract class SysSmsLog
    implements _is.TableRow<int?>, _is.ProtocolSerialization {
  SysSmsLog._({
    this.id,
    required this.channelId,
    required this.channelCode,
    required this.templateId,
    required this.templateCode,
    required this.templateType,
    required this.templateContent,
    required this.templateParams,
    required this.apiTemplateId,
    required this.mobile,
    this.userId,
    this.userType,
    required this.sendStatus,
    this.sendTime,
    this.apiSendCode,
    this.apiSendMsg,
    this.apiRequestId,
    this.apiSerialNo,
    required this.receiveStatus,
    this.receiveTime,
    this.apiReceiveCode,
    this.apiReceiveMsg,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysSmsLog({
    int? id,
    required int channelId,
    required String channelCode,
    required int templateId,
    required String templateCode,
    required int templateType,
    required String templateContent,
    required String templateParams,
    required String apiTemplateId,
    required String mobile,
    int? userId,
    int? userType,
    required int sendStatus,
    DateTime? sendTime,
    String? apiSendCode,
    String? apiSendMsg,
    String? apiRequestId,
    String? apiSerialNo,
    required int receiveStatus,
    DateTime? receiveTime,
    String? apiReceiveCode,
    String? apiReceiveMsg,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysSmsLogImpl;

  factory SysSmsLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysSmsLog(
      id: jsonSerialization['id'] as int?,
      channelId: jsonSerialization['channelId'] as int,
      channelCode: jsonSerialization['channelCode'] as String,
      templateId: jsonSerialization['templateId'] as int,
      templateCode: jsonSerialization['templateCode'] as String,
      templateType: jsonSerialization['templateType'] as int,
      templateContent: jsonSerialization['templateContent'] as String,
      templateParams: jsonSerialization['templateParams'] as String,
      apiTemplateId: jsonSerialization['apiTemplateId'] as String,
      mobile: jsonSerialization['mobile'] as String,
      userId: jsonSerialization['userId'] as int?,
      userType: jsonSerialization['userType'] as int?,
      sendStatus: jsonSerialization['sendStatus'] as int,
      sendTime: jsonSerialization['sendTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['sendTime']),
      apiSendCode: jsonSerialization['apiSendCode'] as String?,
      apiSendMsg: jsonSerialization['apiSendMsg'] as String?,
      apiRequestId: jsonSerialization['apiRequestId'] as String?,
      apiSerialNo: jsonSerialization['apiSerialNo'] as String?,
      receiveStatus: jsonSerialization['receiveStatus'] as int,
      receiveTime: jsonSerialization['receiveTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(
              jsonSerialization['receiveTime'],
            ),
      apiReceiveCode: jsonSerialization['apiReceiveCode'] as String?,
      apiReceiveMsg: jsonSerialization['apiReceiveMsg'] as String?,
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: _is.DateTimeJsonExtension.fromJson(
        jsonSerialization['updateTime'],
      ),
      deleted: _is.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
    );
  }

  static final t = SysSmsLogTable();

  static const db = SysSmsLogRepository._();

  @override
  int? id;

  int channelId;

  String channelCode;

  int templateId;

  String templateCode;

  int templateType;

  String templateContent;

  String templateParams;

  String apiTemplateId;

  String mobile;

  int? userId;

  int? userType;

  int sendStatus;

  DateTime? sendTime;

  String? apiSendCode;

  String? apiSendMsg;

  String? apiRequestId;

  String? apiSerialNo;

  int receiveStatus;

  DateTime? receiveTime;

  String? apiReceiveCode;

  String? apiReceiveMsg;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysSmsLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  SysSmsLog copyWith({
    int? id,
    int? channelId,
    String? channelCode,
    int? templateId,
    String? templateCode,
    int? templateType,
    String? templateContent,
    String? templateParams,
    String? apiTemplateId,
    String? mobile,
    int? userId,
    int? userType,
    int? sendStatus,
    DateTime? sendTime,
    String? apiSendCode,
    String? apiSendMsg,
    String? apiRequestId,
    String? apiSerialNo,
    int? receiveStatus,
    DateTime? receiveTime,
    String? apiReceiveCode,
    String? apiReceiveMsg,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
    bool? deleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SysSmsLog',
      if (id != null) 'id': id,
      'channelId': channelId,
      'channelCode': channelCode,
      'templateId': templateId,
      'templateCode': templateCode,
      'templateType': templateType,
      'templateContent': templateContent,
      'templateParams': templateParams,
      'apiTemplateId': apiTemplateId,
      'mobile': mobile,
      if (userId != null) 'userId': userId,
      if (userType != null) 'userType': userType,
      'sendStatus': sendStatus,
      if (sendTime != null) 'sendTime': sendTime?.toJson(),
      if (apiSendCode != null) 'apiSendCode': apiSendCode,
      if (apiSendMsg != null) 'apiSendMsg': apiSendMsg,
      if (apiRequestId != null) 'apiRequestId': apiRequestId,
      if (apiSerialNo != null) 'apiSerialNo': apiSerialNo,
      'receiveStatus': receiveStatus,
      if (receiveTime != null) 'receiveTime': receiveTime?.toJson(),
      if (apiReceiveCode != null) 'apiReceiveCode': apiReceiveCode,
      if (apiReceiveMsg != null) 'apiReceiveMsg': apiReceiveMsg,
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
      '__className__': 'SysSmsLog',
      if (id != null) 'id': id,
      'channelId': channelId,
      'channelCode': channelCode,
      'templateId': templateId,
      'templateCode': templateCode,
      'templateType': templateType,
      'templateContent': templateContent,
      'templateParams': templateParams,
      'apiTemplateId': apiTemplateId,
      'mobile': mobile,
      if (userId != null) 'userId': userId,
      if (userType != null) 'userType': userType,
      'sendStatus': sendStatus,
      if (sendTime != null) 'sendTime': sendTime?.toJson(),
      if (apiSendCode != null) 'apiSendCode': apiSendCode,
      if (apiSendMsg != null) 'apiSendMsg': apiSendMsg,
      if (apiRequestId != null) 'apiRequestId': apiRequestId,
      if (apiSerialNo != null) 'apiSerialNo': apiSerialNo,
      'receiveStatus': receiveStatus,
      if (receiveTime != null) 'receiveTime': receiveTime?.toJson(),
      if (apiReceiveCode != null) 'apiReceiveCode': apiReceiveCode,
      if (apiReceiveMsg != null) 'apiReceiveMsg': apiReceiveMsg,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysSmsLogInclude include() {
    return SysSmsLogInclude._();
  }

  static SysSmsLogIncludeList includeList({
    _is.WhereExpressionBuilder<SysSmsLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSmsLogTable>? orderBy,
    _is.OrderByListBuilder<SysSmsLogTable>? orderByList,
    SysSmsLogInclude? include,
  }) {
    return SysSmsLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSmsLog.t),
      orderByList: orderByList?.call(SysSmsLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysSmsLogImpl extends SysSmsLog {
  _SysSmsLogImpl({
    int? id,
    required int channelId,
    required String channelCode,
    required int templateId,
    required String templateCode,
    required int templateType,
    required String templateContent,
    required String templateParams,
    required String apiTemplateId,
    required String mobile,
    int? userId,
    int? userType,
    required int sendStatus,
    DateTime? sendTime,
    String? apiSendCode,
    String? apiSendMsg,
    String? apiRequestId,
    String? apiSerialNo,
    required int receiveStatus,
    DateTime? receiveTime,
    String? apiReceiveCode,
    String? apiReceiveMsg,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
         id: id,
         channelId: channelId,
         channelCode: channelCode,
         templateId: templateId,
         templateCode: templateCode,
         templateType: templateType,
         templateContent: templateContent,
         templateParams: templateParams,
         apiTemplateId: apiTemplateId,
         mobile: mobile,
         userId: userId,
         userType: userType,
         sendStatus: sendStatus,
         sendTime: sendTime,
         apiSendCode: apiSendCode,
         apiSendMsg: apiSendMsg,
         apiRequestId: apiRequestId,
         apiSerialNo: apiSerialNo,
         receiveStatus: receiveStatus,
         receiveTime: receiveTime,
         apiReceiveCode: apiReceiveCode,
         apiReceiveMsg: apiReceiveMsg,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
         deleted: deleted,
       );

  /// Returns a shallow copy of this [SysSmsLog]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  SysSmsLog copyWith({
    Object? id = _Undefined,
    int? channelId,
    String? channelCode,
    int? templateId,
    String? templateCode,
    int? templateType,
    String? templateContent,
    String? templateParams,
    String? apiTemplateId,
    String? mobile,
    Object? userId = _Undefined,
    Object? userType = _Undefined,
    int? sendStatus,
    Object? sendTime = _Undefined,
    Object? apiSendCode = _Undefined,
    Object? apiSendMsg = _Undefined,
    Object? apiRequestId = _Undefined,
    Object? apiSerialNo = _Undefined,
    int? receiveStatus,
    Object? receiveTime = _Undefined,
    Object? apiReceiveCode = _Undefined,
    Object? apiReceiveMsg = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysSmsLog(
      id: id is int? ? id : this.id,
      channelId: channelId ?? this.channelId,
      channelCode: channelCode ?? this.channelCode,
      templateId: templateId ?? this.templateId,
      templateCode: templateCode ?? this.templateCode,
      templateType: templateType ?? this.templateType,
      templateContent: templateContent ?? this.templateContent,
      templateParams: templateParams ?? this.templateParams,
      apiTemplateId: apiTemplateId ?? this.apiTemplateId,
      mobile: mobile ?? this.mobile,
      userId: userId is int? ? userId : this.userId,
      userType: userType is int? ? userType : this.userType,
      sendStatus: sendStatus ?? this.sendStatus,
      sendTime: sendTime is DateTime? ? sendTime : this.sendTime,
      apiSendCode: apiSendCode is String? ? apiSendCode : this.apiSendCode,
      apiSendMsg: apiSendMsg is String? ? apiSendMsg : this.apiSendMsg,
      apiRequestId: apiRequestId is String? ? apiRequestId : this.apiRequestId,
      apiSerialNo: apiSerialNo is String? ? apiSerialNo : this.apiSerialNo,
      receiveStatus: receiveStatus ?? this.receiveStatus,
      receiveTime: receiveTime is DateTime? ? receiveTime : this.receiveTime,
      apiReceiveCode: apiReceiveCode is String?
          ? apiReceiveCode
          : this.apiReceiveCode,
      apiReceiveMsg: apiReceiveMsg is String?
          ? apiReceiveMsg
          : this.apiReceiveMsg,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysSmsLogUpdateTable extends _is.UpdateTable<SysSmsLogTable> {
  SysSmsLogUpdateTable(super.table);

  _is.ColumnValue<int, int> channelId(int value) =>
      _is.ColumnValue(table.channelId, value);

  _is.ColumnValue<String, String> channelCode(String value) =>
      _is.ColumnValue(table.channelCode, value);

  _is.ColumnValue<int, int> templateId(int value) =>
      _is.ColumnValue(table.templateId, value);

  _is.ColumnValue<String, String> templateCode(String value) =>
      _is.ColumnValue(table.templateCode, value);

  _is.ColumnValue<int, int> templateType(int value) =>
      _is.ColumnValue(table.templateType, value);

  _is.ColumnValue<String, String> templateContent(String value) =>
      _is.ColumnValue(table.templateContent, value);

  _is.ColumnValue<String, String> templateParams(String value) =>
      _is.ColumnValue(table.templateParams, value);

  _is.ColumnValue<String, String> apiTemplateId(String value) =>
      _is.ColumnValue(table.apiTemplateId, value);

  _is.ColumnValue<String, String> mobile(String value) =>
      _is.ColumnValue(table.mobile, value);

  _is.ColumnValue<int, int> userId(int? value) =>
      _is.ColumnValue(table.userId, value);

  _is.ColumnValue<int, int> userType(int? value) =>
      _is.ColumnValue(table.userType, value);

  _is.ColumnValue<int, int> sendStatus(int value) =>
      _is.ColumnValue(table.sendStatus, value);

  _is.ColumnValue<DateTime, DateTime> sendTime(DateTime? value) =>
      _is.ColumnValue(table.sendTime, value);

  _is.ColumnValue<String, String> apiSendCode(String? value) =>
      _is.ColumnValue(table.apiSendCode, value);

  _is.ColumnValue<String, String> apiSendMsg(String? value) =>
      _is.ColumnValue(table.apiSendMsg, value);

  _is.ColumnValue<String, String> apiRequestId(String? value) =>
      _is.ColumnValue(table.apiRequestId, value);

  _is.ColumnValue<String, String> apiSerialNo(String? value) =>
      _is.ColumnValue(table.apiSerialNo, value);

  _is.ColumnValue<int, int> receiveStatus(int value) =>
      _is.ColumnValue(table.receiveStatus, value);

  _is.ColumnValue<DateTime, DateTime> receiveTime(DateTime? value) =>
      _is.ColumnValue(table.receiveTime, value);

  _is.ColumnValue<String, String> apiReceiveCode(String? value) =>
      _is.ColumnValue(table.apiReceiveCode, value);

  _is.ColumnValue<String, String> apiReceiveMsg(String? value) =>
      _is.ColumnValue(table.apiReceiveMsg, value);

  _is.ColumnValue<String, String> creator(String? value) =>
      _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) =>
      _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) =>
      _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) =>
      _is.ColumnValue(table.updateTime, value);

  _is.ColumnValue<bool, bool> deleted(bool value) =>
      _is.ColumnValue(table.deleted, value);
}

class SysSmsLogTable extends _is.Table<int?> {
  SysSmsLogTable({super.tableRelation}) : super(tableName: 'sys_sms_log') {
    updateTable = SysSmsLogUpdateTable(this);
    channelId = _is.ColumnInt('channelId', this);
    channelCode = _is.ColumnString('channelCode', this);
    templateId = _is.ColumnInt('templateId', this);
    templateCode = _is.ColumnString('templateCode', this);
    templateType = _is.ColumnInt('templateType', this);
    templateContent = _is.ColumnString('templateContent', this);
    templateParams = _is.ColumnString('templateParams', this);
    apiTemplateId = _is.ColumnString('apiTemplateId', this);
    mobile = _is.ColumnString('mobile', this);
    userId = _is.ColumnInt('userId', this);
    userType = _is.ColumnInt('userType', this);
    sendStatus = _is.ColumnInt('sendStatus', this);
    sendTime = _is.ColumnDateTime('sendTime', this);
    apiSendCode = _is.ColumnString('apiSendCode', this);
    apiSendMsg = _is.ColumnString('apiSendMsg', this);
    apiRequestId = _is.ColumnString('apiRequestId', this);
    apiSerialNo = _is.ColumnString('apiSerialNo', this);
    receiveStatus = _is.ColumnInt('receiveStatus', this);
    receiveTime = _is.ColumnDateTime('receiveTime', this);
    apiReceiveCode = _is.ColumnString('apiReceiveCode', this);
    apiReceiveMsg = _is.ColumnString('apiReceiveMsg', this);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this);
    deleted = _is.ColumnBool('deleted', this);
  }

  late final SysSmsLogUpdateTable updateTable;

  late final _is.ColumnInt channelId;

  late final _is.ColumnString channelCode;

  late final _is.ColumnInt templateId;

  late final _is.ColumnString templateCode;

  late final _is.ColumnInt templateType;

  late final _is.ColumnString templateContent;

  late final _is.ColumnString templateParams;

  late final _is.ColumnString apiTemplateId;

  late final _is.ColumnString mobile;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt userType;

  late final _is.ColumnInt sendStatus;

  late final _is.ColumnDateTime sendTime;

  late final _is.ColumnString apiSendCode;

  late final _is.ColumnString apiSendMsg;

  late final _is.ColumnString apiRequestId;

  late final _is.ColumnString apiSerialNo;

  late final _is.ColumnInt receiveStatus;

  late final _is.ColumnDateTime receiveTime;

  late final _is.ColumnString apiReceiveCode;

  late final _is.ColumnString apiReceiveMsg;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  late final _is.ColumnBool deleted;

  @override
  List<_is.Column> get columns => [
    id,
    channelId,
    channelCode,
    templateId,
    templateCode,
    templateType,
    templateContent,
    templateParams,
    apiTemplateId,
    mobile,
    userId,
    userType,
    sendStatus,
    sendTime,
    apiSendCode,
    apiSendMsg,
    apiRequestId,
    apiSerialNo,
    receiveStatus,
    receiveTime,
    apiReceiveCode,
    apiReceiveMsg,
    creator,
    createTime,
    updater,
    updateTime,
    deleted,
  ];
}

class SysSmsLogInclude extends _is.IncludeObject {
  SysSmsLogInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => SysSmsLog.t;
}

class SysSmsLogIncludeList extends _is.IncludeList {
  SysSmsLogIncludeList._({
    _is.WhereExpressionBuilder<SysSmsLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysSmsLog.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => SysSmsLog.t;
}

class SysSmsLogRepository {
  const SysSmsLogRepository._();

  /// Returns a list of [SysSmsLog]s matching the given query parameters.
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
  Future<List<SysSmsLog>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSmsLogTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSmsLogTable>? orderBy,
    _is.OrderByListBuilder<SysSmsLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<SysSmsLog>(
      where: where?.call(SysSmsLog.t),
      orderBy: orderBy?.call(SysSmsLog.t),
      orderByList: orderByList?.call(SysSmsLog.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [SysSmsLog] matching the given query parameters.
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
  Future<SysSmsLog?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSmsLogTable>? where,
    int? offset,
    _is.OrderByBuilder<SysSmsLogTable>? orderBy,
    _is.OrderByListBuilder<SysSmsLogTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<SysSmsLog>(
      where: where?.call(SysSmsLog.t),
      orderBy: orderBy?.call(SysSmsLog.t),
      orderByList: orderByList?.call(SysSmsLog.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [SysSmsLog] by its [id] or null if no such row exists.
  Future<SysSmsLog?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<SysSmsLog>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [SysSmsLog]s in the list and returns the inserted rows.
  ///
  /// The returned [SysSmsLog]s will have their `id` fields set.
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
  Future<List<SysSmsLog>> insert(
    _is.DatabaseSession session,
    List<SysSmsLog> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<SysSmsLog>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [SysSmsLog] and returns the inserted row.
  ///
  /// The returned [SysSmsLog] will have its `id` field set.
  Future<SysSmsLog> insertRow(
    _is.DatabaseSession session,
    SysSmsLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysSmsLog>(row, transaction: transaction);
  }

  /// Upserts all [SysSmsLog]s in the list and returns the resulting rows.
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
  /// The returned [SysSmsLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsLog>> upsert(
    _is.DatabaseSession session,
    List<SysSmsLog> rows, {
    required _is.ColumnSelections<SysSmsLogTable> conflictColumns,
    _is.ColumnSelections<SysSmsLogTable>? updateColumns,
    _is.WhereExpressionBuilder<SysSmsLogTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<SysSmsLog>(
      rows,
      conflictColumns: conflictColumns(SysSmsLog.t),
      updateColumns: updateColumns?.call(SysSmsLog.t),
      updateWhere: updateWhere?.call(SysSmsLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [SysSmsLog] and returns the resulting row.
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
  /// The returned [SysSmsLog] will have its `id` field set.
  Future<SysSmsLog?> upsertRow(
    _is.DatabaseSession session,
    SysSmsLog row, {
    required _is.ColumnSelections<SysSmsLogTable> conflictColumns,
    _is.ColumnSelections<SysSmsLogTable>? updateColumns,
    _is.WhereExpressionBuilder<SysSmsLogTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<SysSmsLog>(
      row,
      conflictColumns: conflictColumns(SysSmsLog.t),
      updateColumns: updateColumns?.call(SysSmsLog.t),
      updateWhere: updateWhere?.call(SysSmsLog.t),
      transaction: transaction,
    );
  }

  /// Updates all [SysSmsLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsLog>> update(
    _is.DatabaseSession session,
    List<SysSmsLog> rows, {
    _is.ColumnSelections<SysSmsLogTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<SysSmsLog>(
      rows,
      columns: columns?.call(SysSmsLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [SysSmsLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysSmsLog> updateRow(
    _is.DatabaseSession session,
    SysSmsLog row, {
    _is.ColumnSelections<SysSmsLogTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysSmsLog>(
      row,
      columns: columns?.call(SysSmsLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysSmsLog] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<SysSmsLog?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<SysSmsLogUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<SysSmsLog>(
      id,
      columnValues: columnValues(SysSmsLog.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [SysSmsLog]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsLog>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<SysSmsLogUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<SysSmsLogTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<SysSmsLogTable>? orderBy,
    _is.OrderByListBuilder<SysSmsLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<SysSmsLog>(
      columnValues: columnValues(SysSmsLog.t.updateTable),
      where: where(SysSmsLog.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSmsLog.t),
      orderByList: orderByList?.call(SysSmsLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [SysSmsLog]s in the list and returns the deleted rows.
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
  Future<List<SysSmsLog>> delete(
    _is.DatabaseSession session,
    List<SysSmsLog> rows, {
    _is.OrderByBuilder<SysSmsLogTable>? orderBy,
    _is.OrderByListBuilder<SysSmsLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<SysSmsLog>(
      rows,
      orderBy: orderBy?.call(SysSmsLog.t),
      orderByList: orderByList?.call(SysSmsLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [SysSmsLog].
  Future<SysSmsLog> deleteRow(
    _is.DatabaseSession session,
    SysSmsLog row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysSmsLog>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<SysSmsLog>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysSmsLogTable> where,
    _is.OrderByBuilder<SysSmsLogTable>? orderBy,
    _is.OrderByListBuilder<SysSmsLogTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<SysSmsLog>(
      where: where(SysSmsLog.t),
      orderBy: orderBy?.call(SysSmsLog.t),
      orderByList: orderByList?.call(SysSmsLog.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<SysSmsLogTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<SysSmsLog>(
      where: where?.call(SysSmsLog.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [SysSmsLog] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<SysSmsLogTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<SysSmsLog>(
      where: where(SysSmsLog.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
