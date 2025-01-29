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

/// 用于存储区域信息，如省市区等
abstract class Region implements _i1.TableRow, _i1.ProtocolSerialization {
  Region._({
    this.id,
    String? name,
    String? pinyin,
    int? parentId,
  })  : name = name ?? '',
        pinyin = pinyin ?? '',
        parentId = parentId ?? 0;

  factory Region({
    int? id,
    String? name,
    String? pinyin,
    int? parentId,
  }) = _RegionImpl;

  factory Region.fromJson(Map<String, dynamic> jsonSerialization) {
    return Region(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      pinyin: jsonSerialization['pinyin'] as String,
      parentId: jsonSerialization['parentId'] as int,
    );
  }

  static final t = RegionTable();

  static const db = RegionRepository._();

  @override
  int? id;

  /// 名称（默认空字符串）
  String name;

  /// 拼音（默认空字符串）
  String pinyin;

  /// 父级主键，无父级为 0
  int parentId;

  @override
  _i1.Table get table => t;

  Region copyWith({
    int? id,
    String? name,
    String? pinyin,
    int? parentId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'pinyin': pinyin,
      'parentId': parentId,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'pinyin': pinyin,
      'parentId': parentId,
    };
  }

  static RegionInclude include() {
    return RegionInclude._();
  }

  static RegionIncludeList includeList({
    _i1.WhereExpressionBuilder<RegionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RegionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RegionTable>? orderByList,
    RegionInclude? include,
  }) {
    return RegionIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Region.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Region.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RegionImpl extends Region {
  _RegionImpl({
    int? id,
    String? name,
    String? pinyin,
    int? parentId,
  }) : super._(
          id: id,
          name: name,
          pinyin: pinyin,
          parentId: parentId,
        );

  @override
  Region copyWith({
    Object? id = _Undefined,
    String? name,
    String? pinyin,
    int? parentId,
  }) {
    return Region(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      pinyin: pinyin ?? this.pinyin,
      parentId: parentId ?? this.parentId,
    );
  }
}

class RegionTable extends _i1.Table {
  RegionTable({super.tableRelation}) : super(tableName: 'region') {
    name = _i1.ColumnString(
      'name',
      this,
      hasDefault: true,
    );
    pinyin = _i1.ColumnString(
      'pinyin',
      this,
      hasDefault: true,
    );
    parentId = _i1.ColumnInt(
      'parentId',
      this,
      hasDefault: true,
    );
  }

  /// 名称（默认空字符串）
  late final _i1.ColumnString name;

  /// 拼音（默认空字符串）
  late final _i1.ColumnString pinyin;

  /// 父级主键，无父级为 0
  late final _i1.ColumnInt parentId;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        pinyin,
        parentId,
      ];
}

class RegionInclude extends _i1.IncludeObject {
  RegionInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Region.t;
}

class RegionIncludeList extends _i1.IncludeList {
  RegionIncludeList._({
    _i1.WhereExpressionBuilder<RegionTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Region.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Region.t;
}

class RegionRepository {
  const RegionRepository._();

  Future<List<Region>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RegionTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RegionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RegionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Region>(
      where: where?.call(Region.t),
      orderBy: orderBy?.call(Region.t),
      orderByList: orderByList?.call(Region.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Region?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RegionTable>? where,
    int? offset,
    _i1.OrderByBuilder<RegionTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RegionTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Region>(
      where: where?.call(Region.t),
      orderBy: orderBy?.call(Region.t),
      orderByList: orderByList?.call(Region.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Region?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Region>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Region>> insert(
    _i1.Session session,
    List<Region> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Region>(
      rows,
      transaction: transaction,
    );
  }

  Future<Region> insertRow(
    _i1.Session session,
    Region row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Region>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Region>> update(
    _i1.Session session,
    List<Region> rows, {
    _i1.ColumnSelections<RegionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Region>(
      rows,
      columns: columns?.call(Region.t),
      transaction: transaction,
    );
  }

  Future<Region> updateRow(
    _i1.Session session,
    Region row, {
    _i1.ColumnSelections<RegionTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Region>(
      row,
      columns: columns?.call(Region.t),
      transaction: transaction,
    );
  }

  Future<List<Region>> delete(
    _i1.Session session,
    List<Region> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Region>(
      rows,
      transaction: transaction,
    );
  }

  Future<Region> deleteRow(
    _i1.Session session,
    Region row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Region>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Region>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<RegionTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Region>(
      where: where(Region.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<RegionTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Region>(
      where: where?.call(Region.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
