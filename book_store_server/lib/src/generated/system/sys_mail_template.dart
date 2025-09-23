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

/// 邮件模版表
abstract class SysMailTemplate
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysMailTemplate._({
    this.id,
    required this.name,
    required this.code,
    required this.accountId,
    this.nickname,
    required this.title,
    required this.content,
    required this.params,
    required this.status,
    this.remark,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysMailTemplate({
    int? id,
    required String name,
    required String code,
    required int accountId,
    String? nickname,
    required String title,
    required String content,
    required String params,
    required int status,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysMailTemplateImpl;

  factory SysMailTemplate.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysMailTemplate(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      accountId: jsonSerialization['accountId'] as int,
      nickname: jsonSerialization['nickname'] as String?,
      title: jsonSerialization['title'] as String,
      content: jsonSerialization['content'] as String,
      params: jsonSerialization['params'] as String,
      status: jsonSerialization['status'] as int,
      remark: jsonSerialization['remark'] as String?,
      creator: jsonSerialization['creator'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      deleted: jsonSerialization['deleted'] as bool,
    );
  }

  static final t = SysMailTemplateTable();

  static const db = SysMailTemplateRepository._();

  @override
  int? id;

  String name;

  String code;

  int accountId;

  String? nickname;

  String title;

  String content;

  String params;

  int status;

  String? remark;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysMailTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysMailTemplate copyWith({
    int? id,
    String? name,
    String? code,
    int? accountId,
    String? nickname,
    String? title,
    String? content,
    String? params,
    int? status,
    String? remark,
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
      'code': code,
      'accountId': accountId,
      if (nickname != null) 'nickname': nickname,
      'title': title,
      'content': content,
      'params': params,
      'status': status,
      if (remark != null) 'remark': remark,
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
      'name': name,
      'code': code,
      'accountId': accountId,
      if (nickname != null) 'nickname': nickname,
      'title': title,
      'content': content,
      'params': params,
      'status': status,
      if (remark != null) 'remark': remark,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysMailTemplateInclude include() {
    return SysMailTemplateInclude._();
  }

  static SysMailTemplateIncludeList includeList({
    _i1.WhereExpressionBuilder<SysMailTemplateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysMailTemplateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysMailTemplateTable>? orderByList,
    SysMailTemplateInclude? include,
  }) {
    return SysMailTemplateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysMailTemplate.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysMailTemplate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysMailTemplateImpl extends SysMailTemplate {
  _SysMailTemplateImpl({
    int? id,
    required String name,
    required String code,
    required int accountId,
    String? nickname,
    required String title,
    required String content,
    required String params,
    required int status,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) : super._(
          id: id,
          name: name,
          code: code,
          accountId: accountId,
          nickname: nickname,
          title: title,
          content: content,
          params: params,
          status: status,
          remark: remark,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysMailTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysMailTemplate copyWith({
    Object? id = _Undefined,
    String? name,
    String? code,
    int? accountId,
    Object? nickname = _Undefined,
    String? title,
    String? content,
    String? params,
    int? status,
    Object? remark = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysMailTemplate(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      accountId: accountId ?? this.accountId,
      nickname: nickname is String? ? nickname : this.nickname,
      title: title ?? this.title,
      content: content ?? this.content,
      params: params ?? this.params,
      status: status ?? this.status,
      remark: remark is String? ? remark : this.remark,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
      deleted: deleted ?? this.deleted,
    );
  }
}

class SysMailTemplateTable extends _i1.Table<int?> {
  SysMailTemplateTable({super.tableRelation})
      : super(tableName: 'sys_mail_template') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    code = _i1.ColumnString(
      'code',
      this,
    );
    accountId = _i1.ColumnInt(
      'accountId',
      this,
    );
    nickname = _i1.ColumnString(
      'nickname',
      this,
    );
    title = _i1.ColumnString(
      'title',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    params = _i1.ColumnString(
      'params',
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

  late final _i1.ColumnString code;

  late final _i1.ColumnInt accountId;

  late final _i1.ColumnString nickname;

  late final _i1.ColumnString title;

  late final _i1.ColumnString content;

  late final _i1.ColumnString params;

  late final _i1.ColumnInt status;

  late final _i1.ColumnString remark;

  late final _i1.ColumnString creator;

  late final _i1.ColumnDateTime createTime;

  late final _i1.ColumnString updater;

  late final _i1.ColumnDateTime updateTime;

  late final _i1.ColumnBool deleted;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        code,
        accountId,
        nickname,
        title,
        content,
        params,
        status,
        remark,
        creator,
        createTime,
        updater,
        updateTime,
        deleted,
      ];
}

class SysMailTemplateInclude extends _i1.IncludeObject {
  SysMailTemplateInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysMailTemplate.t;
}

class SysMailTemplateIncludeList extends _i1.IncludeList {
  SysMailTemplateIncludeList._({
    _i1.WhereExpressionBuilder<SysMailTemplateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysMailTemplate.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysMailTemplate.t;
}

class SysMailTemplateRepository {
  const SysMailTemplateRepository._();

  /// Returns a list of [SysMailTemplate]s matching the given query parameters.
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
  Future<List<SysMailTemplate>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysMailTemplateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysMailTemplateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysMailTemplateTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysMailTemplate>(
      where: where?.call(SysMailTemplate.t),
      orderBy: orderBy?.call(SysMailTemplate.t),
      orderByList: orderByList?.call(SysMailTemplate.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysMailTemplate] matching the given query parameters.
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
  Future<SysMailTemplate?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysMailTemplateTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysMailTemplateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysMailTemplateTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysMailTemplate>(
      where: where?.call(SysMailTemplate.t),
      orderBy: orderBy?.call(SysMailTemplate.t),
      orderByList: orderByList?.call(SysMailTemplate.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysMailTemplate] by its [id] or null if no such row exists.
  Future<SysMailTemplate?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysMailTemplate>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysMailTemplate]s in the list and returns the inserted rows.
  ///
  /// The returned [SysMailTemplate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysMailTemplate>> insert(
    _i1.Session session,
    List<SysMailTemplate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysMailTemplate>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysMailTemplate] and returns the inserted row.
  ///
  /// The returned [SysMailTemplate] will have its `id` field set.
  Future<SysMailTemplate> insertRow(
    _i1.Session session,
    SysMailTemplate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysMailTemplate>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysMailTemplate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysMailTemplate>> update(
    _i1.Session session,
    List<SysMailTemplate> rows, {
    _i1.ColumnSelections<SysMailTemplateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysMailTemplate>(
      rows,
      columns: columns?.call(SysMailTemplate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysMailTemplate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysMailTemplate> updateRow(
    _i1.Session session,
    SysMailTemplate row, {
    _i1.ColumnSelections<SysMailTemplateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysMailTemplate>(
      row,
      columns: columns?.call(SysMailTemplate.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysMailTemplate]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysMailTemplate>> delete(
    _i1.Session session,
    List<SysMailTemplate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysMailTemplate>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysMailTemplate].
  Future<SysMailTemplate> deleteRow(
    _i1.Session session,
    SysMailTemplate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysMailTemplate>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysMailTemplate>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysMailTemplateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysMailTemplate>(
      where: where(SysMailTemplate.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysMailTemplateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysMailTemplate>(
      where: where?.call(SysMailTemplate.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
