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

/// 站内信模板表
abstract class SysNotifyTemplate
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  SysNotifyTemplate._({
    this.id,
    required this.name,
    required this.code,
    required this.nickname,
    required this.content,
    required this.type,
    this.params,
    required this.status,
    this.remark,
    this.creator,
    DateTime? createTime,
    this.updater,
    required this.updateTime,
    required this.deleted,
  }) : createTime = createTime ?? DateTime.now();

  factory SysNotifyTemplate({
    int? id,
    required String name,
    required String code,
    required String nickname,
    required String content,
    required int type,
    String? params,
    required int status,
    String? remark,
    String? creator,
    DateTime? createTime,
    String? updater,
    required DateTime updateTime,
    required bool deleted,
  }) = _SysNotifyTemplateImpl;

  factory SysNotifyTemplate.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysNotifyTemplate(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      code: jsonSerialization['code'] as String,
      nickname: jsonSerialization['nickname'] as String,
      content: jsonSerialization['content'] as String,
      type: jsonSerialization['type'] as int,
      params: jsonSerialization['params'] as String?,
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

  static final t = SysNotifyTemplateTable();

  static const db = SysNotifyTemplateRepository._();

  @override
  int? id;

  String name;

  String code;

  String nickname;

  String content;

  int type;

  String? params;

  int status;

  String? remark;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  bool deleted;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [SysNotifyTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysNotifyTemplate copyWith({
    int? id,
    String? name,
    String? code,
    String? nickname,
    String? content,
    int? type,
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
      'nickname': nickname,
      'content': content,
      'type': type,
      if (params != null) 'params': params,
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
      'nickname': nickname,
      'content': content,
      'type': type,
      if (params != null) 'params': params,
      'status': status,
      if (remark != null) 'remark': remark,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
      'deleted': deleted,
    };
  }

  static SysNotifyTemplateInclude include() {
    return SysNotifyTemplateInclude._();
  }

  static SysNotifyTemplateIncludeList includeList({
    _i1.WhereExpressionBuilder<SysNotifyTemplateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysNotifyTemplateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysNotifyTemplateTable>? orderByList,
    SysNotifyTemplateInclude? include,
  }) {
    return SysNotifyTemplateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(SysNotifyTemplate.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(SysNotifyTemplate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysNotifyTemplateImpl extends SysNotifyTemplate {
  _SysNotifyTemplateImpl({
    int? id,
    required String name,
    required String code,
    required String nickname,
    required String content,
    required int type,
    String? params,
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
          nickname: nickname,
          content: content,
          type: type,
          params: params,
          status: status,
          remark: remark,
          creator: creator,
          createTime: createTime,
          updater: updater,
          updateTime: updateTime,
          deleted: deleted,
        );

  /// Returns a shallow copy of this [SysNotifyTemplate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysNotifyTemplate copyWith({
    Object? id = _Undefined,
    String? name,
    String? code,
    String? nickname,
    String? content,
    int? type,
    Object? params = _Undefined,
    int? status,
    Object? remark = _Undefined,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
    bool? deleted,
  }) {
    return SysNotifyTemplate(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      nickname: nickname ?? this.nickname,
      content: content ?? this.content,
      type: type ?? this.type,
      params: params is String? ? params : this.params,
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

class SysNotifyTemplateTable extends _i1.Table<int?> {
  SysNotifyTemplateTable({super.tableRelation})
      : super(tableName: 'sys_notify_template') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    code = _i1.ColumnString(
      'code',
      this,
    );
    nickname = _i1.ColumnString(
      'nickname',
      this,
    );
    content = _i1.ColumnString(
      'content',
      this,
    );
    type = _i1.ColumnInt(
      'type',
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

  late final _i1.ColumnString nickname;

  late final _i1.ColumnString content;

  late final _i1.ColumnInt type;

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
        nickname,
        content,
        type,
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

class SysNotifyTemplateInclude extends _i1.IncludeObject {
  SysNotifyTemplateInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => SysNotifyTemplate.t;
}

class SysNotifyTemplateIncludeList extends _i1.IncludeList {
  SysNotifyTemplateIncludeList._({
    _i1.WhereExpressionBuilder<SysNotifyTemplateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(SysNotifyTemplate.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => SysNotifyTemplate.t;
}

class SysNotifyTemplateRepository {
  const SysNotifyTemplateRepository._();

  /// Returns a list of [SysNotifyTemplate]s matching the given query parameters.
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
  Future<List<SysNotifyTemplate>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysNotifyTemplateTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SysNotifyTemplateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysNotifyTemplateTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<SysNotifyTemplate>(
      where: where?.call(SysNotifyTemplate.t),
      orderBy: orderBy?.call(SysNotifyTemplate.t),
      orderByList: orderByList?.call(SysNotifyTemplate.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [SysNotifyTemplate] matching the given query parameters.
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
  Future<SysNotifyTemplate?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysNotifyTemplateTable>? where,
    int? offset,
    _i1.OrderByBuilder<SysNotifyTemplateTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SysNotifyTemplateTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<SysNotifyTemplate>(
      where: where?.call(SysNotifyTemplate.t),
      orderBy: orderBy?.call(SysNotifyTemplate.t),
      orderByList: orderByList?.call(SysNotifyTemplate.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [SysNotifyTemplate] by its [id] or null if no such row exists.
  Future<SysNotifyTemplate?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<SysNotifyTemplate>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [SysNotifyTemplate]s in the list and returns the inserted rows.
  ///
  /// The returned [SysNotifyTemplate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<SysNotifyTemplate>> insert(
    _i1.Session session,
    List<SysNotifyTemplate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<SysNotifyTemplate>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [SysNotifyTemplate] and returns the inserted row.
  ///
  /// The returned [SysNotifyTemplate] will have its `id` field set.
  Future<SysNotifyTemplate> insertRow(
    _i1.Session session,
    SysNotifyTemplate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<SysNotifyTemplate>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [SysNotifyTemplate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<SysNotifyTemplate>> update(
    _i1.Session session,
    List<SysNotifyTemplate> rows, {
    _i1.ColumnSelections<SysNotifyTemplateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<SysNotifyTemplate>(
      rows,
      columns: columns?.call(SysNotifyTemplate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [SysNotifyTemplate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<SysNotifyTemplate> updateRow(
    _i1.Session session,
    SysNotifyTemplate row, {
    _i1.ColumnSelections<SysNotifyTemplateTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<SysNotifyTemplate>(
      row,
      columns: columns?.call(SysNotifyTemplate.t),
      transaction: transaction,
    );
  }

  /// Deletes all [SysNotifyTemplate]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<SysNotifyTemplate>> delete(
    _i1.Session session,
    List<SysNotifyTemplate> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<SysNotifyTemplate>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [SysNotifyTemplate].
  Future<SysNotifyTemplate> deleteRow(
    _i1.Session session,
    SysNotifyTemplate row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<SysNotifyTemplate>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<SysNotifyTemplate>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<SysNotifyTemplateTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<SysNotifyTemplate>(
      where: where(SysNotifyTemplate.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<SysNotifyTemplateTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<SysNotifyTemplate>(
      where: where?.call(SysNotifyTemplate.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
