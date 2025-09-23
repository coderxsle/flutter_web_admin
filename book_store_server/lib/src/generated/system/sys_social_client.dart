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

/// 社交客户端表
abstract class SysSocialClient
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysSocialClient._({
    this.id,
    required this.tenantId,
    required this.name,
    required this.socialType,
    required this.userType,
    required this.clientId,
    required this.clientSecret,
    this.agentId,
    required this.status,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysSocialClient({
    int? id,
    required int tenantId,
    required String name,
    required int socialType,
    required int userType,
    required String clientId,
    required String clientSecret,
    String? agentId,
    required int status,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysSocialClientImpl;

  factory SysSocialClient.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysSocialClient(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      name: jsonSerialization['name'] as String,
      socialType: jsonSerialization['socialType'] as int,
      userType: jsonSerialization['userType'] as int,
      clientId: jsonSerialization['clientId'] as String,
      clientSecret: jsonSerialization['clientSecret'] as String,
      agentId: jsonSerialization['agentId'] as String?,
      status: jsonSerialization['status'] as int,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = SysSocialClientTable();

  static const db = SysSocialClientRepository._();

  @override
  int? id;

  int tenantId;

  String name;

  int socialType;

  int userType;

  String clientId;

  String clientSecret;

  String? agentId;

  int status;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysSocialClient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysSocialClient copyWith({
    int? id,
    int? tenantId,
    String? name,
    int? socialType,
    int? userType,
    String? clientId,
    String? clientSecret,
    String? agentId,
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
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'socialType': socialType,
      'userType': userType,
      'clientId': clientId,
      'clientSecret': clientSecret,
      if (agentId != null) 'agentId': agentId,
      'status': status,
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
      'name': name,
      'socialType': socialType,
      'userType': userType,
      'clientId': clientId,
      'clientSecret': clientSecret,
      if (agentId != null) 'agentId': agentId,
      'status': status,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysSocialClientInclude include() {
    return SysSocialClientInclude._();
  }

  static SysSocialClientIncludeList includeList({
    _i1.WhereExpressionBuilder<SysSocialClientTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysSocialClientTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSocialClientTable>? orderByList,
    SysSocialClientInclude? include,
  }) {
    return SysSocialClientIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSocialClient.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysSocialClient.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysSocialClientImpl extends SysSocialClient {
  _SysSocialClientImpl({
    int? id,
    required int tenantId,
    required String name,
    required int socialType,
    required int userType,
    required String clientId,
    required String clientSecret,
    String? agentId,
    required int status,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          tenantId: tenantId,
          name: name,
          socialType: socialType,
          userType: userType,
          clientId: clientId,
          clientSecret: clientSecret,
          agentId: agentId,
          status: status,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysSocialClient]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysSocialClient copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? name,
    int? socialType,
    int? userType,
    String? clientId,
    String? clientSecret,
    Object? agentId = _Undefined,
    int? status,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysSocialClient(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      socialType: socialType ?? this.socialType,
      userType: userType ?? this.userType,
      clientId: clientId ?? this.clientId,
      clientSecret: clientSecret ?? this.clientSecret,
      agentId: agentId is String? ? agentId : this.agentId,
      status: status ?? this.status,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysSocialClientTable extends _i1.Table<int?> {
  SysSocialClientTable({super.tableRelation})
      : super(tableName: 'sys_social_client') {
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
    );
    name = _i1.ColumnString(
      'name',
      this,
    );
    socialType = _i1.ColumnInt(
      'socialType',
      this,
    );
    userType = _i1.ColumnInt(
      'userType',
      this,
    );
    clientId = _i1.ColumnString(
      'clientId',
      this,
    );
    clientSecret = _i1.ColumnString(
      'clientSecret',
      this,
    );
    agentId = _i1.ColumnString(
      'agentId',
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
    );
    deleted = _i1.ColumnBool(
      'deleted',
      this,
    );
  }

  late final _i1.ColumnInt tenantId;

  late final _i1.ColumnString name;

  late final _i1.ColumnInt socialType;

  late final _i1.ColumnInt userType;

  late final _i1.ColumnString clientId;

  late final _i1.ColumnString clientSecret;

  late final _i1.ColumnString agentId;

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
        name,
        socialType,
        userType,
        clientId,
        clientSecret,
        agentId,
        status,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysSocialClientInclude extends _i1.IncludeObject {
  SysSocialClientInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysSocialClient.t;
}

class SysSocialClientIncludeList extends _i1.IncludeList {
  SysSocialClientIncludeList._({
    _i1.WhereExpressionBuilder<SysSocialClientTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysSocialClient.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysSocialClient.t;
}

class SysSocialClientRepository {
  const SysSocialClientRepository._();

  /// Returns a list of [SysSocialClient]s matching the given query parameters.
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
  Future<List<SysSocialClient>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSocialClientTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysSocialClientTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSocialClientTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysSocialClient>(
      where: where?.call(SysSocialClient.t),
      orderBy: orderBy?.call(SysSocialClient.t),
      orderByList: orderByList?.call(SysSocialClient.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysSocialClient] matching the given query parameters.
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
  Future<SysSocialClient?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSocialClientTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysSocialClientTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSocialClientTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysSocialClient>(
      where: where?.call(SysSocialClient.t),
      orderBy: orderBy?.call(SysSocialClient.t),
      orderByList: orderByList?.call(SysSocialClient.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysSocialClient] by its [id] or null if no such row exists.
  Future<SysSocialClient?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysSocialClient>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysSocialClient]s in the list and returns the inserted rows.
  ///
  /// The returned [SysSocialClient]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysSocialClient>> insert(
    _i1.Session session,
    List<SysSocialClient> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysSocialClient>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysSocialClient] and returns the inserted row.
  ///
  /// The returned [SysSocialClient] will have its `id` field set.
  Future<SysSocialClient> insertRow(
    _i1.Session session,
    SysSocialClient row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysSocialClient>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysSocialClient]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysSocialClient>> update(
    _i1.Session session,
    List<SysSocialClient> rows, {
    _i1.ColumnSelections<SysSocialClientTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysSocialClient>(
      rows,
      columns: columns?.call(SysSocialClient.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysSocialClient]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysSocialClient> updateRow(
    _i1.Session session,
    SysSocialClient row, {
    _i1.ColumnSelections<SysSocialClientTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysSocialClient>(
      row,
      columns: columns?.call(SysSocialClient.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysSocialClient]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysSocialClient>> delete(
    _i1.Session session,
    List<SysSocialClient> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysSocialClient>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysSocialClient].
  Future<SysSocialClient> deleteRow(
    _i1.Session session,
    SysSocialClient row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysSocialClient>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysSocialClient>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysSocialClientTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysSocialClient>(
      where: where(SysSocialClient.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSocialClientTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysSocialClient>(
      where: where?.call(SysSocialClient.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
