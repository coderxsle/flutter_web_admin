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

/// 用于记录每本书库存变动的详细信息，便于审计和管理
abstract class InventoryLog implements _i1.TableRow, _i1.ProtocolSerialization {
  InventoryLog._({
    this.id,
    required this.bookId,
    required this.quantity,
    required this.changeType,
    required this.changeTime,
    this.description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory InventoryLog({
    int? id,
    required int bookId,
    required int quantity,
    required int changeType,
    required DateTime changeTime,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _InventoryLogImpl;

  factory InventoryLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return InventoryLog(
      id: jsonSerialization['id'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      quantity: jsonSerialization['quantity'] as int,
      changeType: jsonSerialization['changeType'] as int,
      changeTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['changeTime']),
      description: jsonSerialization['description'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  static final t = InventoryLogTable();

  static const db = InventoryLogRepository._();

  @override
  int? id;

  /// 图书ID，用于标识是哪本书
  int bookId;

  /// 变动数量，可以为正（增加库存）或负（减少库存）
  int quantity;

  /// 变动类型，0=进货，1=售出，2=退货，3=损耗，4=库存调整
  int changeType;

  /// 变动发生的时间
  DateTime changeTime;

  /// 变动的原因或描述，提供额外的说明
  String? description;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  @override
  _i1.Table get table => t;

  InventoryLog copyWith({
    int? id,
    int? bookId,
    int? quantity,
    int? changeType,
    DateTime? changeTime,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'bookId': bookId,
      'quantity': quantity,
      'changeType': changeType,
      'changeTime': changeTime.toJson(),
      if (description != null) 'description': description,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'bookId': bookId,
      'quantity': quantity,
      'changeType': changeType,
      'changeTime': changeTime.toJson(),
      if (description != null) 'description': description,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  static InventoryLogInclude include() {
    return InventoryLogInclude._();
  }

  static InventoryLogIncludeList includeList({
    _i1.WhereExpressionBuilder<InventoryLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InventoryLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InventoryLogTable>? orderByList,
    InventoryLogInclude? include,
  }) {
    return InventoryLogIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(InventoryLog.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(InventoryLog.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InventoryLogImpl extends InventoryLog {
  _InventoryLogImpl({
    int? id,
    required int bookId,
    required int quantity,
    required int changeType,
    required DateTime changeTime,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          bookId: bookId,
          quantity: quantity,
          changeType: changeType,
          changeTime: changeTime,
          description: description,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  @override
  InventoryLog copyWith({
    Object? id = _Undefined,
    int? bookId,
    int? quantity,
    int? changeType,
    DateTime? changeTime,
    Object? description = _Undefined,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return InventoryLog(
      id: id is int? ? id : this.id,
      bookId: bookId ?? this.bookId,
      quantity: quantity ?? this.quantity,
      changeType: changeType ?? this.changeType,
      changeTime: changeTime ?? this.changeTime,
      description: description is String? ? description : this.description,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class InventoryLogTable extends _i1.Table {
  InventoryLogTable({super.tableRelation}) : super(tableName: 'inventory_log') {
    bookId = _i1.ColumnInt(
      'bookId',
      this,
    );
    quantity = _i1.ColumnInt(
      'quantity',
      this,
    );
    changeType = _i1.ColumnInt(
      'changeType',
      this,
    );
    changeTime = _i1.ColumnDateTime(
      'changeTime',
      this,
    );
    description = _i1.ColumnString(
      'description',
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
    isDeleted = _i1.ColumnBool(
      'isDeleted',
      this,
      hasDefault: true,
    );
  }

  /// 图书ID，用于标识是哪本书
  late final _i1.ColumnInt bookId;

  /// 变动数量，可以为正（增加库存）或负（减少库存）
  late final _i1.ColumnInt quantity;

  /// 变动类型，0=进货，1=售出，2=退货，3=损耗，4=库存调整
  late final _i1.ColumnInt changeType;

  /// 变动发生的时间
  late final _i1.ColumnDateTime changeTime;

  /// 变动的原因或描述，提供额外的说明
  late final _i1.ColumnString description;

  /// 记录创建时间
  late final _i1.ColumnDateTime createTime;

  /// 记录最后更新时间
  late final _i1.ColumnDateTime updateTime;

  /// 是否删除
  late final _i1.ColumnBool isDeleted;

  @override
  List<_i1.Column> get columns => [
        id,
        bookId,
        quantity,
        changeType,
        changeTime,
        description,
        createTime,
        updateTime,
        isDeleted,
      ];
}

class InventoryLogInclude extends _i1.IncludeObject {
  InventoryLogInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => InventoryLog.t;
}

class InventoryLogIncludeList extends _i1.IncludeList {
  InventoryLogIncludeList._({
    _i1.WhereExpressionBuilder<InventoryLogTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(InventoryLog.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => InventoryLog.t;
}

class InventoryLogRepository {
  const InventoryLogRepository._();

  Future<List<InventoryLog>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InventoryLogTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<InventoryLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InventoryLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<InventoryLog>(
      where: where?.call(InventoryLog.t),
      orderBy: orderBy?.call(InventoryLog.t),
      orderByList: orderByList?.call(InventoryLog.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<InventoryLog?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InventoryLogTable>? where,
    int? offset,
    _i1.OrderByBuilder<InventoryLogTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<InventoryLogTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<InventoryLog>(
      where: where?.call(InventoryLog.t),
      orderBy: orderBy?.call(InventoryLog.t),
      orderByList: orderByList?.call(InventoryLog.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<InventoryLog?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<InventoryLog>(
      id,
      transaction: transaction,
    );
  }

  Future<List<InventoryLog>> insert(
    _i1.Session session,
    List<InventoryLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<InventoryLog>(
      rows,
      transaction: transaction,
    );
  }

  Future<InventoryLog> insertRow(
    _i1.Session session,
    InventoryLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<InventoryLog>(
      row,
      transaction: transaction,
    );
  }

  Future<List<InventoryLog>> update(
    _i1.Session session,
    List<InventoryLog> rows, {
    _i1.ColumnSelections<InventoryLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<InventoryLog>(
      rows,
      columns: columns?.call(InventoryLog.t),
      transaction: transaction,
    );
  }

  Future<InventoryLog> updateRow(
    _i1.Session session,
    InventoryLog row, {
    _i1.ColumnSelections<InventoryLogTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<InventoryLog>(
      row,
      columns: columns?.call(InventoryLog.t),
      transaction: transaction,
    );
  }

  Future<List<InventoryLog>> delete(
    _i1.Session session,
    List<InventoryLog> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<InventoryLog>(
      rows,
      transaction: transaction,
    );
  }

  Future<InventoryLog> deleteRow(
    _i1.Session session,
    InventoryLog row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<InventoryLog>(
      row,
      transaction: transaction,
    );
  }

  Future<List<InventoryLog>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<InventoryLogTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<InventoryLog>(
      where: where(InventoryLog.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<InventoryLogTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<InventoryLog>(
      where: where?.call(InventoryLog.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
