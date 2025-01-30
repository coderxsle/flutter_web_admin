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

/// 用于存储书籍组合套餐的基本信息。
abstract class BookPackage implements _i1.TableRow, _i1.ProtocolSerialization {
  BookPackage._({
    this.id,
    String? name,
    required this.bundlePrice,
    required this.originalPrice,
    double? discountRate,
    String? contentDescription,
    int? status,
    this.startTime,
    this.endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : name = name ?? '',
        discountRate = discountRate ?? 1.0,
        contentDescription = contentDescription ?? '',
        status = status ?? 0,
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory BookPackage({
    int? id,
    String? name,
    required double bundlePrice,
    required double originalPrice,
    double? discountRate,
    String? contentDescription,
    int? status,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _BookPackageImpl;

  factory BookPackage.fromJson(Map<String, dynamic> jsonSerialization) {
    return BookPackage(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      bundlePrice: (jsonSerialization['bundlePrice'] as num).toDouble(),
      originalPrice: (jsonSerialization['originalPrice'] as num).toDouble(),
      discountRate: (jsonSerialization['discountRate'] as num).toDouble(),
      contentDescription: jsonSerialization['contentDescription'] as String,
      status: jsonSerialization['status'] as int,
      startTime: jsonSerialization['startTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['startTime']),
      endTime: jsonSerialization['endTime'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endTime']),
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  static final t = BookPackageTable();

  static const db = BookPackageRepository._();

  @override
  int? id;

  /// 套餐名称（必填）
  String name;

  /// 套餐的组合价格（实际售价）
  double bundlePrice;

  /// 套餐的原价（各书原价总和）
  double originalPrice;

  /// 折扣率（例：0.8 表示八折）
  double discountRate;

  /// 套餐的描述内容
  String contentDescription;

  /// 套餐状态：0-下架，1-上架，2-预售
  int status;

  /// 生效时间
  DateTime? startTime;

  /// 失效时间
  DateTime? endTime;

  /// 套餐记录创建时间
  DateTime createTime;

  /// 套餐记录最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  @override
  _i1.Table get table => t;

  BookPackage copyWith({
    int? id,
    String? name,
    double? bundlePrice,
    double? originalPrice,
    double? discountRate,
    String? contentDescription,
    int? status,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'bundlePrice': bundlePrice,
      'originalPrice': originalPrice,
      'discountRate': discountRate,
      'contentDescription': contentDescription,
      'status': status,
      if (startTime != null) 'startTime': startTime?.toJson(),
      if (endTime != null) 'endTime': endTime?.toJson(),
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
      'bundlePrice': bundlePrice,
      'originalPrice': originalPrice,
      'discountRate': discountRate,
      'contentDescription': contentDescription,
      'status': status,
      if (startTime != null) 'startTime': startTime?.toJson(),
      if (endTime != null) 'endTime': endTime?.toJson(),
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  static BookPackageInclude include() {
    return BookPackageInclude._();
  }

  static BookPackageIncludeList includeList({
    _i1.WhereExpressionBuilder<BookPackageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookPackageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookPackageTable>? orderByList,
    BookPackageInclude? include,
  }) {
    return BookPackageIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(BookPackage.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(BookPackage.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _BookPackageImpl extends BookPackage {
  _BookPackageImpl({
    int? id,
    String? name,
    required double bundlePrice,
    required double originalPrice,
    double? discountRate,
    String? contentDescription,
    int? status,
    DateTime? startTime,
    DateTime? endTime,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          name: name,
          bundlePrice: bundlePrice,
          originalPrice: originalPrice,
          discountRate: discountRate,
          contentDescription: contentDescription,
          status: status,
          startTime: startTime,
          endTime: endTime,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  @override
  BookPackage copyWith({
    Object? id = _Undefined,
    String? name,
    double? bundlePrice,
    double? originalPrice,
    double? discountRate,
    String? contentDescription,
    int? status,
    Object? startTime = _Undefined,
    Object? endTime = _Undefined,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return BookPackage(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      bundlePrice: bundlePrice ?? this.bundlePrice,
      originalPrice: originalPrice ?? this.originalPrice,
      discountRate: discountRate ?? this.discountRate,
      contentDescription: contentDescription ?? this.contentDescription,
      status: status ?? this.status,
      startTime: startTime is DateTime? ? startTime : this.startTime,
      endTime: endTime is DateTime? ? endTime : this.endTime,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class BookPackageTable extends _i1.Table {
  BookPackageTable({super.tableRelation}) : super(tableName: 'book_package') {
    name = _i1.ColumnString(
      'name',
      this,
      hasDefault: true,
    );
    bundlePrice = _i1.ColumnDouble(
      'bundlePrice',
      this,
    );
    originalPrice = _i1.ColumnDouble(
      'originalPrice',
      this,
    );
    discountRate = _i1.ColumnDouble(
      'discountRate',
      this,
      hasDefault: true,
    );
    contentDescription = _i1.ColumnString(
      'contentDescription',
      this,
      hasDefault: true,
    );
    status = _i1.ColumnInt(
      'status',
      this,
      hasDefault: true,
    );
    startTime = _i1.ColumnDateTime(
      'startTime',
      this,
    );
    endTime = _i1.ColumnDateTime(
      'endTime',
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

  /// 套餐名称（必填）
  late final _i1.ColumnString name;

  /// 套餐的组合价格（实际售价）
  late final _i1.ColumnDouble bundlePrice;

  /// 套餐的原价（各书原价总和）
  late final _i1.ColumnDouble originalPrice;

  /// 折扣率（例：0.8 表示八折）
  late final _i1.ColumnDouble discountRate;

  /// 套餐的描述内容
  late final _i1.ColumnString contentDescription;

  /// 套餐状态：0-下架，1-上架，2-预售
  late final _i1.ColumnInt status;

  /// 生效时间
  late final _i1.ColumnDateTime startTime;

  /// 失效时间
  late final _i1.ColumnDateTime endTime;

  /// 套餐记录创建时间
  late final _i1.ColumnDateTime createTime;

  /// 套餐记录最后更新时间
  late final _i1.ColumnDateTime updateTime;

  /// 是否删除
  late final _i1.ColumnBool isDeleted;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        bundlePrice,
        originalPrice,
        discountRate,
        contentDescription,
        status,
        startTime,
        endTime,
        createTime,
        updateTime,
        isDeleted,
      ];
}

class BookPackageInclude extends _i1.IncludeObject {
  BookPackageInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => BookPackage.t;
}

class BookPackageIncludeList extends _i1.IncludeList {
  BookPackageIncludeList._({
    _i1.WhereExpressionBuilder<BookPackageTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(BookPackage.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => BookPackage.t;
}

class BookPackageRepository {
  const BookPackageRepository._();

  Future<List<BookPackage>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookPackageTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<BookPackageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookPackageTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<BookPackage>(
      where: where?.call(BookPackage.t),
      orderBy: orderBy?.call(BookPackage.t),
      orderByList: orderByList?.call(BookPackage.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<BookPackage?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookPackageTable>? where,
    int? offset,
    _i1.OrderByBuilder<BookPackageTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<BookPackageTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<BookPackage>(
      where: where?.call(BookPackage.t),
      orderBy: orderBy?.call(BookPackage.t),
      orderByList: orderByList?.call(BookPackage.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<BookPackage?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<BookPackage>(
      id,
      transaction: transaction,
    );
  }

  Future<List<BookPackage>> insert(
    _i1.Session session,
    List<BookPackage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<BookPackage>(
      rows,
      transaction: transaction,
    );
  }

  Future<BookPackage> insertRow(
    _i1.Session session,
    BookPackage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<BookPackage>(
      row,
      transaction: transaction,
    );
  }

  Future<List<BookPackage>> update(
    _i1.Session session,
    List<BookPackage> rows, {
    _i1.ColumnSelections<BookPackageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<BookPackage>(
      rows,
      columns: columns?.call(BookPackage.t),
      transaction: transaction,
    );
  }

  Future<BookPackage> updateRow(
    _i1.Session session,
    BookPackage row, {
    _i1.ColumnSelections<BookPackageTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<BookPackage>(
      row,
      columns: columns?.call(BookPackage.t),
      transaction: transaction,
    );
  }

  Future<List<BookPackage>> delete(
    _i1.Session session,
    List<BookPackage> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<BookPackage>(
      rows,
      transaction: transaction,
    );
  }

  Future<BookPackage> deleteRow(
    _i1.Session session,
    BookPackage row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<BookPackage>(
      row,
      transaction: transaction,
    );
  }

  Future<List<BookPackage>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<BookPackageTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<BookPackage>(
      where: where(BookPackage.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<BookPackageTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<BookPackage>(
      where: where?.call(BookPackage.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
