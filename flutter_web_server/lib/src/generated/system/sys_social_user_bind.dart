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

/// 社交绑定表
abstract class SysSocialUserBind
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysSocialUserBind._({
    this.id,
    int? tenantId,
    required this.userId,
    required this.userType,
    required this.socialType,
    required this.socialUserId,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  })  : tenantId = tenantId ?? 0,
        createTime = createTime ?? DateTime.now();

  factory SysSocialUserBind({
    int? id,
    int? tenantId,
    required int userId,
    required int userType,
    required int socialType,
    required int socialUserId,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysSocialUserBindImpl;

  factory SysSocialUserBind.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysSocialUserBind(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int,
      userId: jsonSerialization['userId'] as int,
      userType: jsonSerialization['userType'] as int,
      socialType: jsonSerialization['socialType'] as int,
      socialUserId: jsonSerialization['socialUserId'] as int,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = SysSocialUserBindTable();

  static const db = SysSocialUserBindRepository._();

  @override
  int? id;

  int tenantId;

  int userId;

  int userType;

  int socialType;

  int socialUserId;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysSocialUserBind]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysSocialUserBind copyWith({
    int? id,
    int? tenantId,
    int? userId,
    int? userType,
    int? socialType,
    int? socialUserId,
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
      'socialType': socialType,
      'socialUserId': socialUserId,
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
      'socialType': socialType,
      'socialUserId': socialUserId,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysSocialUserBindInclude include() {
    return SysSocialUserBindInclude._();
  }

  static SysSocialUserBindIncludeList includeList({
    _i1.WhereExpressionBuilder<SysSocialUserBindTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysSocialUserBindTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSocialUserBindTable>? orderByList,
    SysSocialUserBindInclude? include,
  }) {
    return SysSocialUserBindIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysSocialUserBind.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysSocialUserBind.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysSocialUserBindImpl extends SysSocialUserBind {
  _SysSocialUserBindImpl({
    int? id,
    int? tenantId,
    required int userId,
    required int userType,
    required int socialType,
    required int socialUserId,
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
          socialType: socialType,
          socialUserId: socialUserId,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysSocialUserBind]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysSocialUserBind copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? userId,
    int? userType,
    int? socialType,
    int? socialUserId,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysSocialUserBind(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      userId: userId ?? this.userId,
      userType: userType ?? this.userType,
      socialType: socialType ?? this.socialType,
      socialUserId: socialUserId ?? this.socialUserId,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysSocialUserBindTable extends _i1.Table<int?> {
  SysSocialUserBindTable({super.tableRelation})
      : super(tableName: 'sys_social_user_bind') {
    tenantId = _i1.ColumnInt(
      'tenantId',
      this,
      hasDefault: true,
    );
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    userType = _i1.ColumnInt(
      'userType',
      this,
    );
    socialType = _i1.ColumnInt(
      'socialType',
      this,
    );
    socialUserId = _i1.ColumnInt(
      'socialUserId',
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

  late final _i1.ColumnInt socialType;

  late final _i1.ColumnInt socialUserId;

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
        socialType,
        socialUserId,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysSocialUserBindInclude extends _i1.IncludeObject {
  SysSocialUserBindInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysSocialUserBind.t;
}

class SysSocialUserBindIncludeList extends _i1.IncludeList {
  SysSocialUserBindIncludeList._({
    _i1.WhereExpressionBuilder<SysSocialUserBindTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysSocialUserBind.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysSocialUserBind.t;
}

class SysSocialUserBindRepository {
  const SysSocialUserBindRepository._();

  /// Returns a list of [SysSocialUserBind]s matching the given query parameters.
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
  Future<List<SysSocialUserBind>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSocialUserBindTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysSocialUserBindTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSocialUserBindTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysSocialUserBind>(
      where: where?.call(SysSocialUserBind.t),
      orderBy: orderBy?.call(SysSocialUserBind.t),
      orderByList: orderByList?.call(SysSocialUserBind.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysSocialUserBind] matching the given query parameters.
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
  Future<SysSocialUserBind?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSocialUserBindTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysSocialUserBindTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysSocialUserBindTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysSocialUserBind>(
      where: where?.call(SysSocialUserBind.t),
      orderBy: orderBy?.call(SysSocialUserBind.t),
      orderByList: orderByList?.call(SysSocialUserBind.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysSocialUserBind] by its [id] or null if no such row exists.
  Future<SysSocialUserBind?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysSocialUserBind>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysSocialUserBind]s in the list and returns the inserted rows.
  ///
  /// The returned [SysSocialUserBind]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysSocialUserBind>> insert(
    _i1.Session session,
    List<SysSocialUserBind> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysSocialUserBind>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysSocialUserBind] and returns the inserted row.
  ///
  /// The returned [SysSocialUserBind] will have its `id` field set.
  Future<SysSocialUserBind> insertRow(
    _i1.Session session,
    SysSocialUserBind row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysSocialUserBind>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysSocialUserBind]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysSocialUserBind>> update(
    _i1.Session session,
    List<SysSocialUserBind> rows, {
    _i1.ColumnSelections<SysSocialUserBindTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysSocialUserBind>(
      rows,
      columns: columns?.call(SysSocialUserBind.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysSocialUserBind]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysSocialUserBind> updateRow(
    _i1.Session session,
    SysSocialUserBind row, {
    _i1.ColumnSelections<SysSocialUserBindTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysSocialUserBind>(
      row,
      columns: columns?.call(SysSocialUserBind.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysSocialUserBind]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysSocialUserBind>> delete(
    _i1.Session session,
    List<SysSocialUserBind> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysSocialUserBind>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysSocialUserBind].
  Future<SysSocialUserBind> deleteRow(
    _i1.Session session,
    SysSocialUserBind row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysSocialUserBind>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysSocialUserBind>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysSocialUserBindTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysSocialUserBind>(
      where: where(SysSocialUserBind.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysSocialUserBindTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysSocialUserBind>(
      where: where?.call(SysSocialUserBind.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
