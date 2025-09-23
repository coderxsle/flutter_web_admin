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

/// 邮箱账号表
abstract class SysMailAccount
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysMailAccount._({
    this.id,
    required this.mail,
    required this.username,
    required this.password,
    required this.host,
    required this.port,
    required this.sslEnable,
    required this.starttlsEnable,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysMailAccount({
    int? id,
    required String mail,
    required String username,
    required String password,
    required String host,
    required int port,
    required bool sslEnable,
    required bool starttlsEnable,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysMailAccountImpl;

  factory SysMailAccount.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysMailAccount(
      id: jsonSerialization['id'] as int?,
      mail: jsonSerialization['mail'] as String,
      username: jsonSerialization['username'] as String,
      password: jsonSerialization['password'] as String,
      host: jsonSerialization['host'] as String,
      port: jsonSerialization['port'] as int,
      sslEnable: jsonSerialization['sslEnable'] as bool,
      starttlsEnable: jsonSerialization['starttlsEnable'] as bool,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = SysMailAccountTable();

  static const db = SysMailAccountRepository._();

  @override
  int? id;

  String mail;

  String username;

  String password;

  String host;

  int port;

  bool sslEnable;

  bool starttlsEnable;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysMailAccount]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysMailAccount copyWith({
    int? id,
    String? mail,
    String? username,
    String? password,
    String? host,
    int? port,
    bool? sslEnable,
    bool? starttlsEnable,
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
      'mail': mail,
      'username': username,
      'password': password,
      'host': host,
      'port': port,
      'sslEnable': sslEnable,
      'starttlsEnable': starttlsEnable,
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
      'mail': mail,
      'username': username,
      'password': password,
      'host': host,
      'port': port,
      'sslEnable': sslEnable,
      'starttlsEnable': starttlsEnable,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysMailAccountInclude include() {
    return SysMailAccountInclude._();
  }

  static SysMailAccountIncludeList includeList({
    _i1.WhereExpressionBuilder<SysMailAccountTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysMailAccountTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysMailAccountTable>? orderByList,
    SysMailAccountInclude? include,
  }) {
    return SysMailAccountIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysMailAccount.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysMailAccount.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysMailAccountImpl extends SysMailAccount {
  _SysMailAccountImpl({
    int? id,
    required String mail,
    required String username,
    required String password,
    required String host,
    required int port,
    required bool sslEnable,
    required bool starttlsEnable,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          mail: mail,
          username: username,
          password: password,
          host: host,
          port: port,
          sslEnable: sslEnable,
          starttlsEnable: starttlsEnable,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysMailAccount]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysMailAccount copyWith({
    Object? id = _Undefined,
    String? mail,
    String? username,
    String? password,
    String? host,
    int? port,
    bool? sslEnable,
    bool? starttlsEnable,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysMailAccount(
      id: id is int? ? id : this.id,
      mail: mail ?? this.mail,
      username: username ?? this.username,
      password: password ?? this.password,
      host: host ?? this.host,
      port: port ?? this.port,
      sslEnable: sslEnable ?? this.sslEnable,
      starttlsEnable: starttlsEnable ?? this.starttlsEnable,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysMailAccountTable extends _i1.Table<int?> {
  SysMailAccountTable({super.tableRelation})
      : super(tableName: 'sys_mail_account') {
    mail = _i1.ColumnString(
      'mail',
      this,
    );
    username = _i1.ColumnString(
      'username',
      this,
    );
    password = _i1.ColumnString(
      'password',
      this,
    );
    host = _i1.ColumnString(
      'host',
      this,
    );
    port = _i1.ColumnInt(
      'port',
      this,
    );
    sslEnable = _i1.ColumnBool(
      'sslEnable',
      this,
    );
    starttlsEnable = _i1.ColumnBool(
      'starttlsEnable',
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

  late final _i1.ColumnString mail;

  late final _i1.ColumnString username;

  late final _i1.ColumnString password;

  late final _i1.ColumnString host;

  late final _i1.ColumnInt port;

  late final _i1.ColumnBool sslEnable;

  late final _i1.ColumnBool starttlsEnable;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        mail,
        username,
        password,
        host,
        port,
        sslEnable,
        starttlsEnable,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysMailAccountInclude extends _i1.IncludeObject {
  SysMailAccountInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysMailAccount.t;
}

class SysMailAccountIncludeList extends _i1.IncludeList {
  SysMailAccountIncludeList._({
    _i1.WhereExpressionBuilder<SysMailAccountTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysMailAccount.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysMailAccount.t;
}

class SysMailAccountRepository {
  const SysMailAccountRepository._();

  /// Returns a list of [SysMailAccount]s matching the given query parameters.
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
  Future<List<SysMailAccount>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysMailAccountTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysMailAccountTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysMailAccountTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysMailAccount>(
      where: where?.call(SysMailAccount.t),
      orderBy: orderBy?.call(SysMailAccount.t),
      orderByList: orderByList?.call(SysMailAccount.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysMailAccount] matching the given query parameters.
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
  Future<SysMailAccount?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysMailAccountTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysMailAccountTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysMailAccountTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysMailAccount>(
      where: where?.call(SysMailAccount.t),
      orderBy: orderBy?.call(SysMailAccount.t),
      orderByList: orderByList?.call(SysMailAccount.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysMailAccount] by its [id] or null if no such row exists.
  Future<SysMailAccount?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysMailAccount>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysMailAccount]s in the list and returns the inserted rows.
  ///
  /// The returned [SysMailAccount]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysMailAccount>> insert(
    _i1.Session session,
    List<SysMailAccount> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysMailAccount>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysMailAccount] and returns the inserted row.
  ///
  /// The returned [SysMailAccount] will have its `id` field set.
  Future<SysMailAccount> insertRow(
    _i1.Session session,
    SysMailAccount row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysMailAccount>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysMailAccount]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysMailAccount>> update(
    _i1.Session session,
    List<SysMailAccount> rows, {
    _i1.ColumnSelections<SysMailAccountTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysMailAccount>(
      rows,
      columns: columns?.call(SysMailAccount.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysMailAccount]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysMailAccount> updateRow(
    _i1.Session session,
    SysMailAccount row, {
    _i1.ColumnSelections<SysMailAccountTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysMailAccount>(
      row,
      columns: columns?.call(SysMailAccount.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysMailAccount]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysMailAccount>> delete(
    _i1.Session session,
    List<SysMailAccount> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysMailAccount>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysMailAccount].
  Future<SysMailAccount> deleteRow(
    _i1.Session session,
    SysMailAccount row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysMailAccount>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysMailAccount>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysMailAccountTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysMailAccount>(
      where: where(SysMailAccount.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysMailAccountTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysMailAccount>(
      where: where?.call(SysMailAccount.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
