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

/// 用于记录促销活动的基本信息，支持管理折扣和活动规则
abstract class Promotion implements _i1.TableRow, _i1.ProtocolSerialization {
  Promotion._({
    this.id,
    required this.name,
    required this.type,
    this.discountRate,
    DateTime? startTime,
    DateTime? endTime,
    this.description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : startTime = startTime ?? DateTime.now(),
        endTime = endTime ?? DateTime.now(),
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory Promotion({
    int? id,
    required String name,
    required int type,
    double? discountRate,
    DateTime? startTime,
    DateTime? endTime,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _PromotionImpl;

  factory Promotion.fromJson(Map<String, dynamic> jsonSerialization) {
    return Promotion(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      type: jsonSerialization['type'] as int,
      discountRate: (jsonSerialization['discountRate'] as num?)?.toDouble(),
      startTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startTime']),
      endTime: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
      description: jsonSerialization['description'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  static final t = PromotionTable();

  static const db = PromotionRepository._();

  @override
  int? id;

  /// 活动名称
  String name;

  /// 活动类型，0=单本折扣，1=组合优惠
  int type;

  /// 折扣率，范围 0.0 - 1.0，用于定义折扣力度
  double? discountRate;

  /// 活动开始时间
  DateTime startTime;

  /// 活动结束时间
  DateTime endTime;

  /// 活动描述或规则说明
  String? description;

  /// 活动创建时间
  DateTime createTime;

  /// 活动最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  @override
  _i1.Table get table => t;

  Promotion copyWith({
    int? id,
    String? name,
    int? type,
    double? discountRate,
    DateTime? startTime,
    DateTime? endTime,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'type': type,
      if (discountRate != null) 'discountRate': discountRate,
      'startTime': startTime.toJson(),
      'endTime': endTime.toJson(),
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
      'name': name,
      'type': type,
      if (discountRate != null) 'discountRate': discountRate,
      'startTime': startTime.toJson(),
      'endTime': endTime.toJson(),
      if (description != null) 'description': description,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  static PromotionInclude include() {
    return PromotionInclude._();
  }

  static PromotionIncludeList includeList({
    _i1.WhereExpressionBuilder<PromotionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PromotionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PromotionTable>? orderByList,
    PromotionInclude? include,
  }) {
    return PromotionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Promotion.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Promotion.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PromotionImpl extends Promotion {
  _PromotionImpl({
    int? id,
    required String name,
    required int type,
    double? discountRate,
    DateTime? startTime,
    DateTime? endTime,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          name: name,
          type: type,
          discountRate: discountRate,
          startTime: startTime,
          endTime: endTime,
          description: description,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  @override
  Promotion copyWith({
    Object? id = _Undefined,
    String? name,
    int? type,
    Object? discountRate = _Undefined,
    DateTime? startTime,
    DateTime? endTime,
    Object? description = _Undefined,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return Promotion(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      discountRate: discountRate is double? ? discountRate : this.discountRate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      description: description is String? ? description : this.description,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class PromotionTable extends _i1.Table {
  PromotionTable({super.tableRelation}) : super(tableName: 'promotion') {
    name = _i1.ColumnString(
      'name',
      this,
    );
    type = _i1.ColumnInt(
      'type',
      this,
    );
    discountRate = _i1.ColumnDouble(
      'discountRate',
      this,
    );
    startTime = _i1.ColumnDateTime(
      'startTime',
      this,
      hasDefault: true,
    );
    endTime = _i1.ColumnDateTime(
      'endTime',
      this,
      hasDefault: true,
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

  /// 活动名称
  late final _i1.ColumnString name;

  /// 活动类型，0=单本折扣，1=组合优惠
  late final _i1.ColumnInt type;

  /// 折扣率，范围 0.0 - 1.0，用于定义折扣力度
  late final _i1.ColumnDouble discountRate;

  /// 活动开始时间
  late final _i1.ColumnDateTime startTime;

  /// 活动结束时间
  late final _i1.ColumnDateTime endTime;

  /// 活动描述或规则说明
  late final _i1.ColumnString description;

  /// 活动创建时间
  late final _i1.ColumnDateTime createTime;

  /// 活动最后更新时间
  late final _i1.ColumnDateTime updateTime;

  /// 是否删除
  late final _i1.ColumnBool isDeleted;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        type,
        discountRate,
        startTime,
        endTime,
        description,
        createTime,
        updateTime,
        isDeleted,
      ];
}

class PromotionInclude extends _i1.IncludeObject {
  PromotionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Promotion.t;
}

class PromotionIncludeList extends _i1.IncludeList {
  PromotionIncludeList._({
    _i1.WhereExpressionBuilder<PromotionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Promotion.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Promotion.t;
}

class PromotionRepository {
  const PromotionRepository._();

  Future<List<Promotion>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PromotionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PromotionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PromotionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Promotion>(
      where: where?.call(Promotion.t),
      orderBy: orderBy?.call(Promotion.t),
      orderByList: orderByList?.call(Promotion.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Promotion?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PromotionTable>? where,
    int? offset,
    _i1.OrderByBuilder<PromotionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PromotionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Promotion>(
      where: where?.call(Promotion.t),
      orderBy: orderBy?.call(Promotion.t),
      orderByList: orderByList?.call(Promotion.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Promotion?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Promotion>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Promotion>> insert(
    _i1.Session session,
    List<Promotion> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Promotion>(
      rows,
      transaction: transaction,
    );
  }

  Future<Promotion> insertRow(
    _i1.Session session,
    Promotion row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Promotion>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Promotion>> update(
    _i1.Session session,
    List<Promotion> rows, {
    _i1.ColumnSelections<PromotionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Promotion>(
      rows,
      columns: columns?.call(Promotion.t),
      transaction: transaction,
    );
  }

  Future<Promotion> updateRow(
    _i1.Session session,
    Promotion row, {
    _i1.ColumnSelections<PromotionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Promotion>(
      row,
      columns: columns?.call(Promotion.t),
      transaction: transaction,
    );
  }

  Future<List<Promotion>> delete(
    _i1.Session session,
    List<Promotion> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Promotion>(
      rows,
      transaction: transaction,
    );
  }

  Future<Promotion> deleteRow(
    _i1.Session session,
    Promotion row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Promotion>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Promotion>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PromotionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Promotion>(
      where: where(Promotion.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PromotionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Promotion>(
      where: where?.call(Promotion.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
