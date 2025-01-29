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

/// 用于存储活动场地的基本信息
abstract class Party implements _i1.TableRow, _i1.ProtocolSerialization {
  Party._({
    this.id,
    String? name,
    this.latitude,
    this.longitude,
    this.address,
    this.capacity,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : name = name ?? '',
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory Party({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
    String? address,
    int? capacity,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _PartyImpl;

  factory Party.fromJson(Map<String, dynamic> jsonSerialization) {
    return Party(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      latitude: (jsonSerialization['latitude'] as num?)?.toDouble(),
      longitude: (jsonSerialization['longitude'] as num?)?.toDouble(),
      address: jsonSerialization['address'] as String?,
      capacity: jsonSerialization['capacity'] as int?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  static final t = PartyTable();

  static const db = PartyRepository._();

  @override
  int? id;

  /// 场地名称（默认空字符串）
  String name;

  /// 纬度
  double? latitude;

  /// 经度
  double? longitude;

  /// 详细地址
  String? address;

  /// 场地容量
  int? capacity;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  @override
  _i1.Table get table => t;

  Party copyWith({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
    String? address,
    int? capacity,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (address != null) 'address': address,
      if (capacity != null) 'capacity': capacity,
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
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (address != null) 'address': address,
      if (capacity != null) 'capacity': capacity,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  static PartyInclude include() {
    return PartyInclude._();
  }

  static PartyIncludeList includeList({
    _i1.WhereExpressionBuilder<PartyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PartyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PartyTable>? orderByList,
    PartyInclude? include,
  }) {
    return PartyIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Party.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Party.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PartyImpl extends Party {
  _PartyImpl({
    int? id,
    String? name,
    double? latitude,
    double? longitude,
    String? address,
    int? capacity,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          name: name,
          latitude: latitude,
          longitude: longitude,
          address: address,
          capacity: capacity,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  @override
  Party copyWith({
    Object? id = _Undefined,
    String? name,
    Object? latitude = _Undefined,
    Object? longitude = _Undefined,
    Object? address = _Undefined,
    Object? capacity = _Undefined,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return Party(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      latitude: latitude is double? ? latitude : this.latitude,
      longitude: longitude is double? ? longitude : this.longitude,
      address: address is String? ? address : this.address,
      capacity: capacity is int? ? capacity : this.capacity,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class PartyTable extends _i1.Table {
  PartyTable({super.tableRelation}) : super(tableName: 'party') {
    name = _i1.ColumnString(
      'name',
      this,
      hasDefault: true,
    );
    latitude = _i1.ColumnDouble(
      'latitude',
      this,
    );
    longitude = _i1.ColumnDouble(
      'longitude',
      this,
    );
    address = _i1.ColumnString(
      'address',
      this,
    );
    capacity = _i1.ColumnInt(
      'capacity',
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

  /// 场地名称（默认空字符串）
  late final _i1.ColumnString name;

  /// 纬度
  late final _i1.ColumnDouble latitude;

  /// 经度
  late final _i1.ColumnDouble longitude;

  /// 详细地址
  late final _i1.ColumnString address;

  /// 场地容量
  late final _i1.ColumnInt capacity;

  /// 记录创建时间
  late final _i1.ColumnDateTime createTime;

  /// 记录最后更新时间
  late final _i1.ColumnDateTime updateTime;

  /// 是否删除
  late final _i1.ColumnBool isDeleted;

  @override
  List<_i1.Column> get columns => [
        id,
        name,
        latitude,
        longitude,
        address,
        capacity,
        createTime,
        updateTime,
        isDeleted,
      ];
}

class PartyInclude extends _i1.IncludeObject {
  PartyInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => Party.t;
}

class PartyIncludeList extends _i1.IncludeList {
  PartyIncludeList._({
    _i1.WhereExpressionBuilder<PartyTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Party.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => Party.t;
}

class PartyRepository {
  const PartyRepository._();

  Future<List<Party>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PartyTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<PartyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PartyTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<Party>(
      where: where?.call(Party.t),
      orderBy: orderBy?.call(Party.t),
      orderByList: orderByList?.call(Party.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Party?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PartyTable>? where,
    int? offset,
    _i1.OrderByBuilder<PartyTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<PartyTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<Party>(
      where: where?.call(Party.t),
      orderBy: orderBy?.call(Party.t),
      orderByList: orderByList?.call(Party.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<Party?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<Party>(
      id,
      transaction: transaction,
    );
  }

  Future<List<Party>> insert(
    _i1.Session session,
    List<Party> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<Party>(
      rows,
      transaction: transaction,
    );
  }

  Future<Party> insertRow(
    _i1.Session session,
    Party row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Party>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Party>> update(
    _i1.Session session,
    List<Party> rows, {
    _i1.ColumnSelections<PartyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Party>(
      rows,
      columns: columns?.call(Party.t),
      transaction: transaction,
    );
  }

  Future<Party> updateRow(
    _i1.Session session,
    Party row, {
    _i1.ColumnSelections<PartyTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Party>(
      row,
      columns: columns?.call(Party.t),
      transaction: transaction,
    );
  }

  Future<List<Party>> delete(
    _i1.Session session,
    List<Party> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Party>(
      rows,
      transaction: transaction,
    );
  }

  Future<Party> deleteRow(
    _i1.Session session,
    Party row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Party>(
      row,
      transaction: transaction,
    );
  }

  Future<List<Party>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<PartyTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Party>(
      where: where(Party.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<PartyTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Party>(
      where: where?.call(Party.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
