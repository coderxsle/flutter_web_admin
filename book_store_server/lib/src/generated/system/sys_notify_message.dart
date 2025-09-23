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

/// 站内信消息表
abstract class SysNotifyMessage
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysNotifyMessage._({
    this.id,
    required this.tenantId,
    required this.userId,
    required this.userType,
    required this.templateId,
    required this.templateCode,
    required this.templateNickname,
    required this.templateContent,
    required this.templateType,
    required this.templateParams,
    required this.readStatus,
    this.readTime,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysNotifyMessage({
    int? id,
    required int tenantId,
    required int userId,
    required int userType,
    required int templateId,
    required String templateCode,
    required String templateNickname,
    required String templateContent,
    required int templateType,
    required String templateParams,
    required bool readStatus,
    DateTime? readTime,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysNotifyMessageImpl;

  factory SysNotifyMessage.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysNotifyMessage(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      userId: jsonSerialization['userId'] as int,
      userType: jsonSerialization['userType'] as int,
      templateId: jsonSerialization['templateId'] as int,
      templateCode: jsonSerialization['templateCode'] as String,
      templateNickname: jsonSerialization['templateNickname'] as String,
      templateContent: jsonSerialization['templateContent'] as String,
      templateType: jsonSerialization['templateType'] as int,
      templateParams: jsonSerialization['templateParams'] as String,
      readStatus: jsonSerialization['readStatus'] as bool,
      readTime: jsonSerialization['readTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['readTime']),
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = SysNotifyMessageTable();

  static const db = SysNotifyMessageRepository._();

  @override
  int? id;

  int tenantId;

  int userId;

  int userType;

  int templateId;

  String templateCode;

  String templateNickname;

  String templateContent;

  int templateType;

  String templateParams;

  bool readStatus;

  DateTime? readTime;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysNotifyMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysNotifyMessage copyWith({
    int? id,
    int? tenantId,
    int? userId,
    int? userType,
    int? templateId,
    String? templateCode,
    String? templateNickname,
    String? templateContent,
    int? templateType,
    String? templateParams,
    bool? readStatus,
    DateTime? readTime,
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
      'userId': userId,
      'userType': userType,
      'templateId': templateId,
      'templateCode': templateCode,
      'templateNickname': templateNickname,
      'templateContent': templateContent,
      'templateType': templateType,
      'templateParams': templateParams,
      'readStatus': readStatus,
      if (readTime != null) 'readTime': readTime?.toJson(),
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
      'userId': userId,
      'userType': userType,
      'templateId': templateId,
      'templateCode': templateCode,
      'templateNickname': templateNickname,
      'templateContent': templateContent,
      'templateType': templateType,
      'templateParams': templateParams,
      'readStatus': readStatus,
      if (readTime != null) 'readTime': readTime?.toJson(),
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysNotifyMessageInclude include() {
    return SysNotifyMessageInclude._();
  }

  static SysNotifyMessageIncludeList includeList({
    _i1.WhereExpressionBuilder<SysNotifyMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysNotifyMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysNotifyMessageTable>? orderByList,
    SysNotifyMessageInclude? include,
  }) {
    return SysNotifyMessageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysNotifyMessage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysNotifyMessage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysNotifyMessageImpl extends SysNotifyMessage {
  _SysNotifyMessageImpl({
    int? id,
    required int tenantId,
    required int userId,
    required int userType,
    required int templateId,
    required String templateCode,
    required String templateNickname,
    required String templateContent,
    required int templateType,
    required String templateParams,
    required bool readStatus,
    DateTime? readTime,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          userId: userId,
          userType: userType,
          templateId: templateId,
          templateCode: templateCode,
          templateNickname: templateNickname,
          templateContent: templateContent,
          templateType: templateType,
          templateParams: templateParams,
          readStatus: readStatus,
          readTime: readTime,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysNotifyMessage]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysNotifyMessage copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? userId,
    int? userType,
    int? templateId,
    String? templateCode,
    String? templateNickname,
    String? templateContent,
    int? templateType,
    String? templateParams,
    bool? readStatus,
    Object? readTime = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysNotifyMessage(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      templateId: templateId ?? this.templateId,
      templateCode: templateCode ?? this.templateCode,
      templateNickname: templateNickname ?? this.templateNickname,
      templateContent: templateContent ?? this.templateContent,
      templateType: templateType ?? this.templateType,
      templateParams: templateParams ?? this.templateParams,
      readStatus: readStatus ?? this.readStatus,
      readTime: readTime is DateTime? ? readTime : this.readTime,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysNotifyMessageTable extends _i1.Table<int?> {
  SysNotifyMessageTable({super.tableRelation})
      : super(tableName: 'sys_notify_message') {
    tenantId = _i1.ColumnInt(
      'tenantId',
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
    templateContent = _i1.ColumnString(
      'templateContent',
      this,
    );
    templateType = _i1.ColumnInt(
      'templateType',
      this,
    );
    templateParams = _i1.ColumnString(
      'templateParams',
      this,
    );
    readStatus = _i1.ColumnBool(
      'readStatus',
      this,
    );
    readTime = _i1.ColumnDateTime(
      'readTime',
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

  late final _i1.ColumnInt userId;

  late final _i1.ColumnInt userType;

  late final _i1.ColumnInt templateId;

  late final _i1.ColumnString templateCode;

  late final _i1.ColumnString templateNickname;

  late final _i1.ColumnString templateContent;

  late final _i1.ColumnInt templateType;

  late final _i1.ColumnString templateParams;

  late final _i1.ColumnBool readStatus;

  late final _i1.ColumnDateTime readTime;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        tenantId,
        userId,
        userType,
        templateId,
        templateCode,
        templateNickname,
        templateContent,
        templateType,
        templateParams,
        readStatus,
        readTime,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysNotifyMessageInclude extends _i1.IncludeObject {
  SysNotifyMessageInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysNotifyMessage.t;
}

class SysNotifyMessageIncludeList extends _i1.IncludeList {
  SysNotifyMessageIncludeList._({
    _i1.WhereExpressionBuilder<SysNotifyMessageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysNotifyMessage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysNotifyMessage.t;
}

class SysNotifyMessageRepository {
  const SysNotifyMessageRepository._();

  /// Returns a list of [SysNotifyMessage]s matching the given query parameters.
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
  Future<List<SysNotifyMessage>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysNotifyMessageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysNotifyMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysNotifyMessageTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysNotifyMessage>(
      where: where?.call(SysNotifyMessage.t),
      orderBy: orderBy?.call(SysNotifyMessage.t),
      orderByList: orderByList?.call(SysNotifyMessage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysNotifyMessage] matching the given query parameters.
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
  Future<SysNotifyMessage?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysNotifyMessageTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysNotifyMessageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysNotifyMessageTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysNotifyMessage>(
      where: where?.call(SysNotifyMessage.t),
      orderBy: orderBy?.call(SysNotifyMessage.t),
      orderByList: orderByList?.call(SysNotifyMessage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysNotifyMessage] by its [id] or null if no such row exists.
  Future<SysNotifyMessage?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysNotifyMessage>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysNotifyMessage]s in the list and returns the inserted rows.
  ///
  /// The returned [SysNotifyMessage]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysNotifyMessage>> insert(
    _i1.Session session,
    List<SysNotifyMessage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysNotifyMessage>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysNotifyMessage] and returns the inserted row.
  ///
  /// The returned [SysNotifyMessage] will have its `id` field set.
  Future<SysNotifyMessage> insertRow(
    _i1.Session session,
    SysNotifyMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysNotifyMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysNotifyMessage]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysNotifyMessage>> update(
    _i1.Session session,
    List<SysNotifyMessage> rows, {
    _i1.ColumnSelections<SysNotifyMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysNotifyMessage>(
      rows,
      columns: columns?.call(SysNotifyMessage.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysNotifyMessage]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysNotifyMessage> updateRow(
    _i1.Session session,
    SysNotifyMessage row, {
    _i1.ColumnSelections<SysNotifyMessageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysNotifyMessage>(
      row,
      columns: columns?.call(SysNotifyMessage.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysNotifyMessage]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysNotifyMessage>> delete(
    _i1.Session session,
    List<SysNotifyMessage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysNotifyMessage>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysNotifyMessage].
  Future<SysNotifyMessage> deleteRow(
    _i1.Session session,
    SysNotifyMessage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysNotifyMessage>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysNotifyMessage>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysNotifyMessageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysNotifyMessage>(
      where: where(SysNotifyMessage.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysNotifyMessageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysNotifyMessage>(
      where: where?.call(SysNotifyMessage.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
