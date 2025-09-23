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

/// 租户表
abstract class SysTenant
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysTenant._({
    this.id,
    required this.name,
    this.contactUserId,
    required this.contactName,
    this.contactMobile,
    required this.status,
    this.websites,
    required this.packageId,
    required this.expireTime,
    required this.accountCount,
    required this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysTenant({
    int? id,
    required String name,
    int? contactUserId,
    required String contactName,
    String? contactMobile,
    required int status,
    String? websites,
    required int packageId,
    required DateTime expireTime,
    required int accountCount,
    required String creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysTenantImpl;

  factory SysTenant.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysTenant(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      contactUserId: jsonSerialization['contactUserId'] as int?,
      contactName: jsonSerialization['contactName'] as String,
      contactMobile: jsonSerialization['contactMobile'] as String?,
      status: jsonSerialization['status'] as int,
      websites: jsonSerialization['websites'] as String?,
      packageId: jsonSerialization['packageId'] as int,
      expireTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expireTime']),
      accountCount: jsonSerialization['accountCount'] as int,
      creator: jsonSerialization['creator'] as String,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = SysTenantTable();

  static const db = SysTenantRepository._();

  @override
  int? id;

  String name;

  int? contactUserId;

  String contactName;

  String? contactMobile;

  int status;

  String? websites;

  int packageId;

  DateTime expireTime;

  int accountCount;

  String creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysTenant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysTenant copyWith({
    int? id,
    String? name,
    int? contactUserId,
    String? contactName,
    String? contactMobile,
    int? status,
    String? websites,
    int? packageId,
    DateTime? expireTime,
    int? accountCount,
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
      'name': name,
      if (contactUserId != null) 'contactUserId': contactUserId,
      'contactName': contactName,
      if (contactMobile != null) 'contactMobile': contactMobile,
      'status': status,
      if (websites != null) 'websites': websites,
      'packageId': packageId,
      'expireTime': expireTime.toJson(),
      'accountCount': accountCount,
      'creator': creator,
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
      'name': name,
      if (contactUserId != null) 'contactUserId': contactUserId,
      'contactName': contactName,
      if (contactMobile != null) 'contactMobile': contactMobile,
      'status': status,
      if (websites != null) 'websites': websites,
      'packageId': packageId,
      'expireTime': expireTime.toJson(),
      'accountCount': accountCount,
      'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysTenantInclude include() {
    return SysTenantInclude._();
  }

  static SysTenantIncludeList includeList({
    _i1.WhereExpressionBuilder<SysTenantTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysTenantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysTenantTable>? orderByList,
    SysTenantInclude? include,
  }) {
    return SysTenantIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysTenant.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysTenant.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysTenantImpl extends SysTenant {
  _SysTenantImpl({
    int? id,
    required String name,
    int? contactUserId,
    required String contactName,
    String? contactMobile,
    required int status,
    String? websites,
    required int packageId,
    required DateTime expireTime,
    required int accountCount,
    required String creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          name: name,
          contactUserId: contactUserId,
          contactName: contactName,
          contactMobile: contactMobile,
          status: status,
          websites: websites,
          packageId: packageId,
          expireTime: expireTime,
          accountCount: accountCount,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysTenant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysTenant copyWith({
    Object? id = _Undefined,
    String? name,
    Object? contactUserId = _Undefined,
    String? contactName,
    Object? contactMobile = _Undefined,
    int? status,
    Object? websites = _Undefined,
    int? packageId,
    DateTime? expireTime,
    int? accountCount,
    String? creator,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysTenant(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      contactUserId: contactUserId is int? ? contactUserId : this.contactUserId,
      contactName: contactName ?? this.contactName,
      contactMobile:
          contactMobile is String? ? contactMobile : this.contactMobile,
      status: status ?? this.status,
      websites: websites is String? ? websites : this.websites,
      packageId: packageId ?? this.packageId,
      expireTime: expireTime ?? this.expireTime,
      accountCount: accountCount ?? this.accountCount,
      creator: creator ?? this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysTenantTable extends _i1.Table<int?> {
  SysTenantTable({super.tableRelation}) : super(tableName: 'sys_tenant') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    contactUserId = _i1.ColumnInt(
      'contactUserId',
      this,
    );
    contactName = _i1.ColumnString(
      'contactName',
      this,
    );
    contactMobile = _i1.ColumnString(
      'contactMobile',
      this,
    );
    status = _i1.ColumnInt(
      'status',
      this,
    );
    websites = _i1.ColumnString(
      'websites',
      this,
    );
    packageId = _i1.ColumnInt(
      'packageId',
      this,
    );
    expireTime = _i1.ColumnDateTime(
      'expireTime',
      this,
    );
    accountCount = _i1.ColumnInt(
      'accountCount',
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

  late final _i1.ColumnString name;

  late final _i1.ColumnInt contactUserId;

  late final _i1.ColumnString contactName;

  late final _i1.ColumnString contactMobile;

  late final _i1.ColumnInt status;

  late final _i1.ColumnString websites;

  late final _i1.ColumnInt packageId;

  late final _i1.ColumnDateTime expireTime;

  late final _i1.ColumnInt accountCount;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        contactUserId,
        contactName,
        contactMobile,
        status,
        websites,
        packageId,
        expireTime,
        accountCount,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysTenantInclude extends _i1.IncludeObject {
  SysTenantInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysTenant.t;
}

class SysTenantIncludeList extends _i1.IncludeList {
  SysTenantIncludeList._({
    _i1.WhereExpressionBuilder<SysTenantTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysTenant.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysTenant.t;
}

class SysTenantRepository {
  const SysTenantRepository._();

  /// Returns a list of [SysTenant]s matching the given query parameters.
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
  Future<List<SysTenant>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysTenantTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysTenantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysTenantTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysTenant>(
      where: where?.call(SysTenant.t),
      orderBy: orderBy?.call(SysTenant.t),
      orderByList: orderByList?.call(SysTenant.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysTenant] matching the given query parameters.
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
  Future<SysTenant?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysTenantTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysTenantTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysTenantTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysTenant>(
      where: where?.call(SysTenant.t),
      orderBy: orderBy?.call(SysTenant.t),
      orderByList: orderByList?.call(SysTenant.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysTenant] by its [id] or null if no such row exists.
  Future<SysTenant?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysTenant>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysTenant]s in the list and returns the inserted rows.
  ///
  /// The returned [SysTenant]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysTenant>> insert(
    _i1.Session session,
    List<SysTenant> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysTenant>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysTenant] and returns the inserted row.
  ///
  /// The returned [SysTenant] will have its `id` field set.
  Future<SysTenant> insertRow(
    _i1.Session session,
    SysTenant row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysTenant>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysTenant]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysTenant>> update(
    _i1.Session session,
    List<SysTenant> rows, {
    _i1.ColumnSelections<SysTenantTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysTenant>(
      rows,
      columns: columns?.call(SysTenant.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysTenant]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysTenant> updateRow(
    _i1.Session session,
    SysTenant row, {
    _i1.ColumnSelections<SysTenantTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysTenant>(
      row,
      columns: columns?.call(SysTenant.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysTenant]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysTenant>> delete(
    _i1.Session session,
    List<SysTenant> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysTenant>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysTenant].
  Future<SysTenant> deleteRow(
    _i1.Session session,
    SysTenant row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysTenant>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysTenant>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysTenantTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysTenant>(
      where: where(SysTenant.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysTenantTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysTenant>(
      where: where?.call(SysTenant.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
