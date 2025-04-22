/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Qimen implements _i1.TableRow<int>, _i1.ProtocolSerialization {
  Qimen._({
    this.id,
    required this.userId,
    required this.panTime,
    required this.method,
    required this.dunType,
    required this.juShu,
    required this.question,
    required this.analysis,
    DateTime? createTime,
    DateTime? updateTime,
  })  : createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now();

  factory Qimen({
    int? id,
    required int userId,
    required DateTime panTime,
    required String method,
    required String dunType,
    required int juShu,
    required String question,
    required String analysis,
    DateTime? createTime,
    DateTime? updateTime,
  }) = _QimenImpl;

  factory Qimen.fromJson(Map<String, dynamic> jsonSerialization) {
    return Qimen(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      panTime: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['panTime']),
      method: jsonSerialization['method'] as String,
      dunType: jsonSerialization['dunType'] as String,
      juShu: jsonSerialization['juShu'] as int,
      question: jsonSerialization['question'] as String,
      analysis: jsonSerialization['analysis'] as String,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  static final t = QimenTable();

  static const db = QimenRepository._();

  @override
  int? id;

  int userId;

  /// 排盘时间
  DateTime panTime;

  /// 排盘方式（如奇门遁甲、四柱八字等）
  String method;

  /// 遁法（阳遁、阴遁）
  String dunType;

  /// # 局数（1~9）
  int juShu;

  /// 占事（用户所问之事）
  String question;

  /// 断言（断语或推演结果）
  String analysis;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  @override
  _i1.Table<int> get table => t;

  /// Returns a shallow copy of this [Qimen]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Qimen copyWith({
    int? id,
    int? userId,
    DateTime? panTime,
    String? method,
    String? dunType,
    int? juShu,
    String? question,
    String? analysis,
    DateTime? createTime,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'panTime': panTime.toJson(),
      'method': method,
      'dunType': dunType,
      'juShu': juShu,
      'question': question,
      'analysis': analysis,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'panTime': panTime.toJson(),
      'method': method,
      'dunType': dunType,
      'juShu': juShu,
      'question': question,
      'analysis': analysis,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
    };
  }

  static QimenInclude include() {
    return QimenInclude._();
  }

  static QimenIncludeList includeList({
    _i1.WhereExpressionBuilder<QimenTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QimenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QimenTable>? orderByList,
    QimenInclude? include,
  }) {
    return QimenIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Qimen.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Qimen.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QimenImpl extends Qimen {
  _QimenImpl({
    int? id,
    required int userId,
    required DateTime panTime,
    required String method,
    required String dunType,
    required int juShu,
    required String question,
    required String analysis,
    DateTime? createTime,
    DateTime? updateTime,
  }) : super._(
          id: id,
          userId: userId,
          panTime: panTime,
          method: method,
          dunType: dunType,
          juShu: juShu,
          question: question,
          analysis: analysis,
          createTime: createTime,
          updateTime: updateTime,
        );

  /// Returns a shallow copy of this [Qimen]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Qimen copyWith({
    Object? id = _Undefined,
    int? userId,
    DateTime? panTime,
    String? method,
    String? dunType,
    int? juShu,
    String? question,
    String? analysis,
    DateTime? createTime,
    DateTime? updateTime,
  }) {
    return Qimen(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      panTime: panTime ?? this.panTime,
      method: method ?? this.method,
      dunType: dunType ?? this.dunType,
      juShu: juShu ?? this.juShu,
      question: question ?? this.question,
      analysis: analysis ?? this.analysis,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class QimenTable extends _i1.Table<int> {
  QimenTable({super.tableRelation}) : super(tableName: 'qimen_history') {
    userId = _i1.ColumnInt(
      'userId',
      this,
    );
    panTime = _i1.ColumnDateTime(
      'panTime',
      this,
    );
    method = _i1.ColumnString(
      'method',
      this,
    );
    dunType = _i1.ColumnString(
      'dunType',
      this,
    );
    juShu = _i1.ColumnInt(
      'juShu',
      this,
    );
    question = _i1.ColumnString(
      'question',
      this,
    );
    analysis = _i1.ColumnString(
      'analysis',
      this,
    );
    createTime = _i1.ColumnDateTime(
      'createTime',
      this,
      hasDefault: true,
    );
    updateTime = _i1.ColumnDateTime(
      'updateTime',
      this,
      hasDefault: true,
    );
  }

  late final _i1.ColumnInt userId;

  /// 排盘时间
  late final _i1.ColumnDateTime panTime;

  /// 排盘方式（如奇门遁甲、四柱八字等）
  late final _i1.ColumnString method;

  /// 遁法（阳遁、阴遁）
  late final _i1.ColumnString dunType;

  /// # 局数（1~9）
  late final _i1.ColumnInt juShu;

  /// 占事（用户所问之事）
  late final _i1.ColumnString question;

  /// 断言（断语或推演结果）
  late final _i1.ColumnString analysis;

  /// 记录创建时间
  late final _i1.ColumnDateTime createTime;

  /// 记录最后更新时间
  late final _i1.ColumnDateTime updateTime;

  @override
  List<_i1.Column> get columns => [
        id,
        userId,
        panTime,
        method,
        dunType,
        juShu,
        question,
        analysis,
        createTime,
        updateTime,
      ];
}

class QimenInclude extends _i1.IncludeObject {
  QimenInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int> get table => Qimen.t;
}

class QimenIncludeList extends _i1.IncludeList {
  QimenIncludeList._({
    _i1.WhereExpressionBuilder<QimenTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Qimen.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int> get table => Qimen.t;
}

class QimenRepository {
  const QimenRepository._();

  /// Returns a list of [Qimen]s matching the given query parameters.
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
  Future<List<Qimen>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QimenTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<QimenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QimenTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Qimen>(
      where: where?.call(Qimen.t),
      orderBy: orderBy?.call(Qimen.t),
      orderByList: orderByList?.call(Qimen.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Returns the first matching [Qimen] matching the given query parameters.
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
  Future<Qimen?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QimenTable>? where,
    int? offset,
    _i1.OrderByBuilder<QimenTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<QimenTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Qimen>(
      where: where?.call(Qimen.t),
      orderBy: orderBy?.call(Qimen.t),
      orderByList: orderByList?.call(Qimen.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  /// Finds a single [Qimen] by its [id] or null if no such row exists.
  Future<Qimen?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Qimen>(
      id,
      transaction: transaction,
    );
  }

  /// Inserts all [Qimen]s in the list and returns the inserted rows.
  ///
  /// The returned [Qimen]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  Future<List<Qimen>> insert(
    _i1.Session session,
    List<Qimen> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Qimen>(
      rows,
      transaction: transaction,
    );
  }

  /// Inserts a single [Qimen] and returns the inserted row.
  ///
  /// The returned [Qimen] will have its `id` field set.
  Future<Qimen> insertRow(
    _i1.Session session,
    Qimen row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Qimen>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Qimen]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Qimen>> update(
    _i1.Session session,
    List<Qimen> rows, {
    _i1.ColumnSelections<QimenTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Qimen>(
      rows,
      columns: columns?.call(Qimen.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Qimen]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Qimen> updateRow(
    _i1.Session session,
    Qimen row, {
    _i1.ColumnSelections<QimenTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Qimen>(
      row,
      columns: columns?.call(Qimen.t),
      transaction: transaction,
    );
  }

  /// Deletes all [Qimen]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Qimen>> delete(
    _i1.Session session,
    List<Qimen> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Qimen>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Qimen].
  Future<Qimen> deleteRow(
    _i1.Session session,
    Qimen row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Qimen>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Qimen>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<QimenTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Qimen>(
      where: where(Qimen.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<QimenTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Qimen>(
      where: where?.call(Qimen.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
