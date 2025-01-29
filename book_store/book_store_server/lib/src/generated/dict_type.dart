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

/// 用于存储数据字典的类型信息
abstract class DictType implements _i1.TableRow, _i1.ProtocolSerialization {
  DictType._({
    this.id,
    String? name,
    String? value,
    String? intro,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : name = name ?? '',
        value = value ?? '',
        intro = intro ?? '',
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory DictType({
    int? id,
    String? name,
    String? value,
    String? intro,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _DictTypeImpl;

  factory DictType.fromJson(Map<String, dynamic> jsonSerialization) {
    return DictType(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      value: jsonSerialization['value'] as String,
      intro: jsonSerialization['intro'] as String,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  static final t = DictTypeTable();

  static const db = DictTypeRepository._();

  @override
  int? id;

  /// 名称（默认空字符串，唯一约束）
  String name;

  /// 值（默认空字符串，唯一约束）
  String value;

  /// 简介（默认空字符串）
  String intro;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  @override
  _i1.Table get table => t;

  DictType copyWith({
    int? id,
    String? name,
    String? value,
    String? intro,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'value': value,
      'intro': intro,
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
      'value': value,
      'intro': intro,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  static DictTypeInclude include() {
    return DictTypeInclude._();
  }

  static DictTypeIncludeList includeList({
    _i1.WhereExpressionBuilder<DictTypeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictTypeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictTypeTable>? orderByList,
    DictTypeInclude? include,
  }) {
    return DictTypeIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(DictType.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(DictType.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _DictTypeImpl extends DictType {
  _DictTypeImpl({
    int? id,
    String? name,
    String? value,
    String? intro,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          name: name,
          value: value,
          intro: intro,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  @override
  DictType copyWith({
    Object? id = _Undefined,
    String? name,
    String? value,
    String? intro,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return DictType(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      intro: intro ?? this.intro,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}

class DictTypeTable extends _i1.Table {
  DictTypeTable({super.tableRelation}) : super(tableName: 'dict_type') {
    name = _i1.ColumnString(
      'name',
      this,
      hasDefault: true,
    );
    value = _i1.ColumnString(
      'value',
      this,
      hasDefault: true,
    );
    intro = _i1.ColumnString(
      'intro',
      this,
      hasDefault: true,
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

  /// 名称（默认空字符串，唯一约束）
  late final _i1.ColumnString name;

  /// 值（默认空字符串，唯一约束）
  late final _i1.ColumnString value;

  /// 简介（默认空字符串）
  late final _i1.ColumnString intro;

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
        value,
        intro,
        createTime,
        updateTime,
        isDeleted,
      ];
}

class DictTypeInclude extends _i1.IncludeObject {
  DictTypeInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table get table => DictType.t;
}

class DictTypeIncludeList extends _i1.IncludeList {
  DictTypeIncludeList._({
    _i1.WhereExpressionBuilder<DictTypeTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(DictType.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table get table => DictType.t;
}

class DictTypeRepository {
  const DictTypeRepository._();

  Future<List<DictType>> find(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DictTypeTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<DictTypeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictTypeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.find<DictType>(
      where: where?.call(DictType.t),
      orderBy: orderBy?.call(DictType.t),
      orderByList: orderByList?.call(DictType.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<DictType?> findFirstRow(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DictTypeTable>? where,
    int? offset,
    _i1.OrderByBuilder<DictTypeTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<DictTypeTable>? orderByList,
    _i1.Transaction? transaction,
  }) async {
    return session.db.findFirstRow<DictType>(
      where: where?.call(DictType.t),
      orderBy: orderBy?.call(DictType.t),
      orderByList: orderByList?.call(DictType.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
    );
  }

  Future<DictType?> findById(
    _i1.Session session,
    int id, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.findById<DictType>(
      id,
      transaction: transaction,
    );
  }

  Future<List<DictType>> insert(
    _i1.Session session,
    List<DictType> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insert<DictType>(
      rows,
      transaction: transaction,
    );
  }

  Future<DictType> insertRow(
    _i1.Session session,
    DictType row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<DictType>(
      row,
      transaction: transaction,
    );
  }

  Future<List<DictType>> update(
    _i1.Session session,
    List<DictType> rows, {
    _i1.ColumnSelections<DictTypeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<DictType>(
      rows,
      columns: columns?.call(DictType.t),
      transaction: transaction,
    );
  }

  Future<DictType> updateRow(
    _i1.Session session,
    DictType row, {
    _i1.ColumnSelections<DictTypeTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<DictType>(
      row,
      columns: columns?.call(DictType.t),
      transaction: transaction,
    );
  }

  Future<List<DictType>> delete(
    _i1.Session session,
    List<DictType> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<DictType>(
      rows,
      transaction: transaction,
    );
  }

  Future<DictType> deleteRow(
    _i1.Session session,
    DictType row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<DictType>(
      row,
      transaction: transaction,
    );
  }

  Future<List<DictType>> deleteWhere(
    _i1.Session session, {
    required _i1.WhereExpressionBuilder<DictTypeTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<DictType>(
      where: where(DictType.t),
      transaction: transaction,
    );
  }

  Future<int> count(
    _i1.Session session, {
    _i1.WhereExpressionBuilder<DictTypeTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<DictType>(
      where: where?.call(DictType.t),
      limit: limit,
      transaction: transaction,
    );
  }
}
