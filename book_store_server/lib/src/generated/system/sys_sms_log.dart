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

/// 短信日志
abstract class SysSmsLog
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
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
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sendTime']),
      apiSendCode: jsonSerialization['apiSendCode'] as String?,
      apiSendMsg: jsonSerialization['apiSendMsg'] as String?,
      apiRequestId: jsonSerialization['apiRequestId'] as String?,
      apiSerialNo: jsonSerialization['apiSerialNo'] as String?,
      receiveStatus: jsonSerialization['receiveStatus'] as int,
      receiveTime: jsonSerialization['receiveTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['receiveTime']),
      apiReceiveCode: jsonSerialization['apiReceiveCode'] as String?,
      apiReceiveMsg: jsonSerialization['apiReceiveMsg'] as String?,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
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
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysSmsLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
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
    _i1.WhereExpressionBuilder<SysSmsLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysSmsLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSmsLogTable>? orderByList,
    SysSmsLogInclude? include,
  }) {
    return SysSmsLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSmsLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysSmsLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
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
  @_i1.useResult
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
      apiReceiveCode:
          apiReceiveCode is String? ? apiReceiveCode : this.apiReceiveCode,
      apiReceiveMsg:
          apiReceiveMsg is String? ? apiReceiveMsg : this.apiReceiveMsg,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysSmsLogTable extends _i1.Table<int?> {
  SysSmsLogTable({super.tableRelation}) : super(tableName: 'sys_sms_log') {
    channelId = _i1.ColumnInt(
      'channelId',
      this,
    );
    channelCode = _i1.ColumnString(
      'channelCode',
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
    templateType = _i1.ColumnInt(
      'templateType',
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
    apiTemplateId = _i1.ColumnString(
      'apiTemplateId',
      this,
    );
    mobile = _i1.ColumnString(
      'mobile',
      this,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    userType = _i1.ColumnInt(
      'userType',
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
    apiSendCode = _i1.ColumnString(
      'apiSendCode',
      this,
    );
    apiSendMsg = _i1.ColumnString(
      'apiSendMsg',
      this,
    );
    apiRequestId = _i1.ColumnString(
      'apiRequestId',
      this,
    );
    apiSerialNo = _i1.ColumnString(
      'apiSerialNo',
      this,
    );
    receiveStatus = _i1.ColumnInt(
      'receiveStatus',
      this,
    );
    receiveTime = _i1.ColumnDateTime(
      'receiveTime',
      this,
    );
    apiReceiveCode = _i1.ColumnString(
      'apiReceiveCode',
      this,
    );
    apiReceiveMsg = _i1.ColumnString(
      'apiReceiveMsg',
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

  late final _i1.ColumnInt channelId;

  late final _i1.ColumnString channelCode;

  late final _i1.ColumnInt templateId;

  late final _i1.ColumnString templateCode;

  late final _i1.ColumnInt templateType;

  late final _i1.ColumnString templateContent;

  late final _i1.ColumnString templateParams;

  late final _i1.ColumnString apiTemplateId;

  late final _i1.ColumnString mobile;

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt userType;

  late final _i1.ColumnInt sendStatus;

  late final _i1.ColumnDateTime sendTime;

  late final _i1.ColumnString apiSendCode;

  late final _i1.ColumnString apiSendMsg;

  late final _i1.ColumnString apiRequestId;

  late final _i1.ColumnString apiSerialNo;

  late final _i1.ColumnInt receiveStatus;

  late final _i1.ColumnDateTime receiveTime;

  late final _i1.ColumnString apiReceiveCode;

  late final _i1.ColumnString apiReceiveMsg;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
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

class SysSmsLogInclude extends _i1.IncludeObject {
  SysSmsLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysSmsLog.t;
}

class SysSmsLogIncludeList extends _i1.IncludeList {
  SysSmsLogIncludeList._({
    _i1.WhereExpressionBuilder<SysSmsLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysSmsLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysSmsLog.t;
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSmsLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysSmsLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSmsLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysSmsLog>(
      where: where?.call(SysSmsLog.t),
      orderBy: orderBy?.call(SysSmsLog.t),
      orderByList: orderByList?.call(SysSmsLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
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
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSmsLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysSmsLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSmsLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysSmsLog>(
      where: where?.call(SysSmsLog.t),
      orderBy: orderBy?.call(SysSmsLog.t),
      orderByList: orderByList?.call(SysSmsLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysSmsLog] by its [id] or null if no such row exists.
  Future<SysSmsLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysSmsLog>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysSmsLog]s in the list and returns the inserted rows.
  ///
  /// The returned [SysSmsLog]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysSmsLog>> insert(
    _i1.Session session,
    List<SysSmsLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysSmsLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysSmsLog] and returns the inserted row.
  ///
  /// The returned [SysSmsLog] will have its `id` field set.
  Future<SysSmsLog> insertRow(
    _i1.Session session,
    SysSmsLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysSmsLog>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysSmsLog]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysSmsLog>> update(
    _i1.Session session,
    List<SysSmsLog> rows, {
    _i1.ColumnSelections<SysSmsLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysSmsLog>(
      rows,
      columns: columns?.call(SysSmsLog.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysSmsLog]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysSmsLog> updateRow(
    _i1.Session session,
    SysSmsLog row, {
    _i1.ColumnSelections<SysSmsLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysSmsLog>(
      row,
      columns: columns?.call(SysSmsLog.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysSmsLog]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysSmsLog>> delete(
    _i1.Session session,
    List<SysSmsLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysSmsLog>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysSmsLog].
  Future<SysSmsLog> deleteRow(
    _i1.Session session,
    SysSmsLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysSmsLog>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysSmsLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysSmsLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysSmsLog>(
      where: where(SysSmsLog.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSmsLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysSmsLog>(
      where: where?.call(SysSmsLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
