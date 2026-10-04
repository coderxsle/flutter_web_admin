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
import 'package:serverpod/serverpod.dart' as _is;

/// 中医门诊处方模板明细
abstract class ZhongyiPrescriptionTemplateItem implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ZhongyiPrescriptionTemplateItem._({
    this.id,
    required this.templateId,
    required this.medicineId,
    int? sortOrder,
    this.role,
    required this.dosageGrams,
    String? dosageUnit,
    this.dosageText,
    this.usageMethod,
    bool? isSubstitute,
    this.substituteForId,
    this.notes,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : sortOrder = sortOrder ?? 0,
       dosageUnit = dosageUnit ?? 'g',
       isSubstitute = isSubstitute ?? false,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ZhongyiPrescriptionTemplateItem({
    int? id,
    required int templateId,
    required int medicineId,
    int? sortOrder,
    String? role,
    required double dosageGrams,
    String? dosageUnit,
    String? dosageText,
    String? usageMethod,
    bool? isSubstitute,
    int? substituteForId,
    String? notes,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiPrescriptionTemplateItemImpl;

  factory ZhongyiPrescriptionTemplateItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiPrescriptionTemplateItem(
      id: jsonSerialization['id'] as int?,
      templateId: jsonSerialization['templateId'] as int,
      medicineId: jsonSerialization['medicineId'] as int,
      sortOrder: jsonSerialization['sortOrder'] as int?,
      role: jsonSerialization['role'] as String?,
      dosageGrams: (jsonSerialization['dosageGrams'] as num).toDouble(),
      dosageUnit: jsonSerialization['dosageUnit'] as String?,
      dosageText: jsonSerialization['dosageText'] as String?,
      usageMethod: jsonSerialization['usageMethod'] as String?,
      isSubstitute: jsonSerialization['isSubstitute'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isSubstitute']),
      substituteForId: jsonSerialization['substituteForId'] as int?,
      notes: jsonSerialization['notes'] as String?,
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  static final t = ZhongyiPrescriptionTemplateItemTable();

  static const db = ZhongyiPrescriptionTemplateItemRepository._();

  @override
  int? id;

  int templateId;

  int medicineId;

  int sortOrder;

  String? role;

  double dosageGrams;

  String dosageUnit;

  String? dosageText;

  String? usageMethod;

  bool isSubstitute;

  int? substituteForId;

  String? notes;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ZhongyiPrescriptionTemplateItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ZhongyiPrescriptionTemplateItem copyWith({
    int? id,
    int? templateId,
    int? medicineId,
    int? sortOrder,
    String? role,
    double? dosageGrams,
    String? dosageUnit,
    String? dosageText,
    String? usageMethod,
    bool? isSubstitute,
    int? substituteForId,
    String? notes,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ZhongyiPrescriptionTemplateItem',
      if (id != null) 'id': id,
      'templateId': templateId,
      'medicineId': medicineId,
      'sortOrder': sortOrder,
      if (role != null) 'role': role,
      'dosageGrams': dosageGrams,
      'dosageUnit': dosageUnit,
      if (dosageText != null) 'dosageText': dosageText,
      if (usageMethod != null) 'usageMethod': usageMethod,
      'isSubstitute': isSubstitute,
      if (substituteForId != null) 'substituteForId': substituteForId,
      if (notes != null) 'notes': notes,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'ZhongyiPrescriptionTemplateItem',
      if (id != null) 'id': id,
      'templateId': templateId,
      'medicineId': medicineId,
      'sortOrder': sortOrder,
      if (role != null) 'role': role,
      'dosageGrams': dosageGrams,
      'dosageUnit': dosageUnit,
      if (dosageText != null) 'dosageText': dosageText,
      if (usageMethod != null) 'usageMethod': usageMethod,
      'isSubstitute': isSubstitute,
      if (substituteForId != null) 'substituteForId': substituteForId,
      if (notes != null) 'notes': notes,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static ZhongyiPrescriptionTemplateItemInclude include() {
    return ZhongyiPrescriptionTemplateItemInclude._();
  }

  static ZhongyiPrescriptionTemplateItemIncludeList includeList({
    _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiPrescriptionTemplateItemTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPrescriptionTemplateItemTable>? orderByList,
    ZhongyiPrescriptionTemplateItemInclude? include,
  }) {
    return ZhongyiPrescriptionTemplateItemIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiPrescriptionTemplateItem.t),
      orderByList: orderByList?.call(ZhongyiPrescriptionTemplateItem.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ZhongyiPrescriptionTemplateItemImpl extends ZhongyiPrescriptionTemplateItem {
  _ZhongyiPrescriptionTemplateItemImpl({
    int? id,
    required int templateId,
    required int medicineId,
    int? sortOrder,
    String? role,
    required double dosageGrams,
    String? dosageUnit,
    String? dosageText,
    String? usageMethod,
    bool? isSubstitute,
    int? substituteForId,
    String? notes,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         templateId: templateId,
         medicineId: medicineId,
         sortOrder: sortOrder,
         role: role,
         dosageGrams: dosageGrams,
         dosageUnit: dosageUnit,
         dosageText: dosageText,
         usageMethod: usageMethod,
         isSubstitute: isSubstitute,
         substituteForId: substituteForId,
         notes: notes,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiPrescriptionTemplateItem]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ZhongyiPrescriptionTemplateItem copyWith({
    Object? id = _Undefined,
    int? templateId,
    int? medicineId,
    int? sortOrder,
    Object? role = _Undefined,
    double? dosageGrams,
    String? dosageUnit,
    Object? dosageText = _Undefined,
    Object? usageMethod = _Undefined,
    bool? isSubstitute,
    Object? substituteForId = _Undefined,
    Object? notes = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiPrescriptionTemplateItem(
      id: id is int? ? id : this.id,
      templateId: templateId ?? this.templateId,
      medicineId: medicineId ?? this.medicineId,
      sortOrder: sortOrder ?? this.sortOrder,
      role: role is String? ? role : this.role,
      dosageGrams: dosageGrams ?? this.dosageGrams,
      dosageUnit: dosageUnit ?? this.dosageUnit,
      dosageText: dosageText is String? ? dosageText : this.dosageText,
      usageMethod: usageMethod is String? ? usageMethod : this.usageMethod,
      isSubstitute: isSubstitute ?? this.isSubstitute,
      substituteForId: substituteForId is int? ? substituteForId : this.substituteForId,
      notes: notes is String? ? notes : this.notes,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class ZhongyiPrescriptionTemplateItemUpdateTable extends _is.UpdateTable<ZhongyiPrescriptionTemplateItemTable> {
  ZhongyiPrescriptionTemplateItemUpdateTable(super.table);

  _is.ColumnValue<int, int> templateId(int value) => _is.ColumnValue(table.templateId, value);

  _is.ColumnValue<int, int> medicineId(int value) => _is.ColumnValue(table.medicineId, value);

  _is.ColumnValue<int, int> sortOrder(int value) => _is.ColumnValue(table.sortOrder, value);

  _is.ColumnValue<String, String> role(String? value) => _is.ColumnValue(table.role, value);

  _is.ColumnValue<double, double> dosageGrams(double value) => _is.ColumnValue(table.dosageGrams, value);

  _is.ColumnValue<String, String> dosageUnit(String value) => _is.ColumnValue(table.dosageUnit, value);

  _is.ColumnValue<String, String> dosageText(String? value) => _is.ColumnValue(table.dosageText, value);

  _is.ColumnValue<String, String> usageMethod(String? value) => _is.ColumnValue(table.usageMethod, value);

  _is.ColumnValue<bool, bool> isSubstitute(bool value) => _is.ColumnValue(table.isSubstitute, value);

  _is.ColumnValue<int, int> substituteForId(int? value) => _is.ColumnValue(table.substituteForId, value);

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(table.notes, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);
}

class ZhongyiPrescriptionTemplateItemTable extends _is.Table<int?> {
  ZhongyiPrescriptionTemplateItemTable({super.tableRelation}) : super(tableName: 'zhongyi_prescription_template_item') {
    updateTable = ZhongyiPrescriptionTemplateItemUpdateTable(this);
    templateId = _is.ColumnInt('templateId', this);
    medicineId = _is.ColumnInt('medicineId', this);
    sortOrder = _is.ColumnInt('sortOrder', this, hasDefault: true);
    role = _is.ColumnString('role', this);
    dosageGrams = _is.ColumnDouble('dosageGrams', this);
    dosageUnit = _is.ColumnString('dosageUnit', this, hasDefault: true);
    dosageText = _is.ColumnString('dosageText', this);
    usageMethod = _is.ColumnString('usageMethod', this);
    isSubstitute = _is.ColumnBool('isSubstitute', this, hasDefault: true);
    substituteForId = _is.ColumnInt('substituteForId', this);
    notes = _is.ColumnString('notes', this);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final ZhongyiPrescriptionTemplateItemUpdateTable updateTable;

  late final _is.ColumnInt templateId;

  late final _is.ColumnInt medicineId;

  late final _is.ColumnInt sortOrder;

  late final _is.ColumnString role;

  late final _is.ColumnDouble dosageGrams;

  late final _is.ColumnString dosageUnit;

  late final _is.ColumnString dosageText;

  late final _is.ColumnString usageMethod;

  late final _is.ColumnBool isSubstitute;

  late final _is.ColumnInt substituteForId;

  late final _is.ColumnString notes;

  late final _is.ColumnBool deleted;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  @override
  List<_is.Column> get columns => [
    id,
    templateId,
    medicineId,
    sortOrder,
    role,
    dosageGrams,
    dosageUnit,
    dosageText,
    usageMethod,
    isSubstitute,
    substituteForId,
    notes,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class ZhongyiPrescriptionTemplateItemInclude extends _is.IncludeObject {
  ZhongyiPrescriptionTemplateItemInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ZhongyiPrescriptionTemplateItem.t;
}

class ZhongyiPrescriptionTemplateItemIncludeList extends _is.IncludeList {
  ZhongyiPrescriptionTemplateItemIncludeList._({
    _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateItemTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ZhongyiPrescriptionTemplateItem.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ZhongyiPrescriptionTemplateItem.t;
}

class ZhongyiPrescriptionTemplateItemRepository {
  const ZhongyiPrescriptionTemplateItemRepository._();

  /// Returns a list of [ZhongyiPrescriptionTemplateItem]s matching the given query parameters.
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
  Future<List<ZhongyiPrescriptionTemplateItem>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateItemTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiPrescriptionTemplateItemTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPrescriptionTemplateItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ZhongyiPrescriptionTemplateItem>(
      where: where?.call(ZhongyiPrescriptionTemplateItem.t),
      orderBy: orderBy?.call(ZhongyiPrescriptionTemplateItem.t),
      orderByList: orderByList?.call(ZhongyiPrescriptionTemplateItem.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ZhongyiPrescriptionTemplateItem] matching the given query parameters.
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
  Future<ZhongyiPrescriptionTemplateItem?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateItemTable>? where,
    int? offset,
    _is.OrderByBuilder<ZhongyiPrescriptionTemplateItemTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPrescriptionTemplateItemTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ZhongyiPrescriptionTemplateItem>(
      where: where?.call(ZhongyiPrescriptionTemplateItem.t),
      orderBy: orderBy?.call(ZhongyiPrescriptionTemplateItem.t),
      orderByList: orderByList?.call(ZhongyiPrescriptionTemplateItem.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ZhongyiPrescriptionTemplateItem] by its [id] or null if no such row exists.
  Future<ZhongyiPrescriptionTemplateItem?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ZhongyiPrescriptionTemplateItem>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ZhongyiPrescriptionTemplateItem]s in the list and returns the inserted rows.
  ///
  /// The returned [ZhongyiPrescriptionTemplateItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  ///
  /// If [noReturn] is set to `true`, the inserted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPrescriptionTemplateItem>> insert(
    _is.DatabaseSession session,
    List<ZhongyiPrescriptionTemplateItem> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ZhongyiPrescriptionTemplateItem>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ZhongyiPrescriptionTemplateItem] and returns the inserted row.
  ///
  /// The returned [ZhongyiPrescriptionTemplateItem] will have its `id` field set.
  Future<ZhongyiPrescriptionTemplateItem> insertRow(
    _is.DatabaseSession session,
    ZhongyiPrescriptionTemplateItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ZhongyiPrescriptionTemplateItem>(row, transaction: transaction);
  }

  /// Upserts all [ZhongyiPrescriptionTemplateItem]s in the list and returns the resulting rows.
  ///
  /// If a row conflicts on the given [conflictColumns], the existing row is
  /// updated with the new values. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies to rows matching the
  /// given expression. Conflicting rows that don't match are skipped and not
  /// returned, so the resulting list may be shorter than [rows].
  ///
  /// The returned [ZhongyiPrescriptionTemplateItem]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPrescriptionTemplateItem>> upsert(
    _is.DatabaseSession session,
    List<ZhongyiPrescriptionTemplateItem> rows, {
    required _is.ColumnSelections<ZhongyiPrescriptionTemplateItemTable> conflictColumns,
    _is.ColumnSelections<ZhongyiPrescriptionTemplateItemTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateItemTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ZhongyiPrescriptionTemplateItem>(
      rows,
      conflictColumns: conflictColumns(ZhongyiPrescriptionTemplateItem.t),
      updateColumns: updateColumns?.call(ZhongyiPrescriptionTemplateItem.t),
      updateWhere: updateWhere?.call(ZhongyiPrescriptionTemplateItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ZhongyiPrescriptionTemplateItem] and returns the resulting row.
  ///
  /// If the row conflicts on the given [conflictColumns], the existing row is
  /// updated. Otherwise, a new row is inserted.
  ///
  /// If [updateColumns] is provided, only those columns will be updated on
  /// conflict. If null, all non-conflict, non-id columns are updated.
  ///
  /// If [updateWhere] is provided, the update only applies when the existing
  /// row matches the expression. Returns `null` if no row was affected — for
  /// example when [updateWhere] does not match the conflicting row.
  ///
  /// The returned [ZhongyiPrescriptionTemplateItem] will have its `id` field set.
  Future<ZhongyiPrescriptionTemplateItem?> upsertRow(
    _is.DatabaseSession session,
    ZhongyiPrescriptionTemplateItem row, {
    required _is.ColumnSelections<ZhongyiPrescriptionTemplateItemTable> conflictColumns,
    _is.ColumnSelections<ZhongyiPrescriptionTemplateItemTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateItemTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ZhongyiPrescriptionTemplateItem>(
      row,
      conflictColumns: conflictColumns(ZhongyiPrescriptionTemplateItem.t),
      updateColumns: updateColumns?.call(ZhongyiPrescriptionTemplateItem.t),
      updateWhere: updateWhere?.call(ZhongyiPrescriptionTemplateItem.t),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiPrescriptionTemplateItem]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPrescriptionTemplateItem>> update(
    _is.DatabaseSession session,
    List<ZhongyiPrescriptionTemplateItem> rows, {
    _is.ColumnSelections<ZhongyiPrescriptionTemplateItemTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ZhongyiPrescriptionTemplateItem>(
      rows,
      columns: columns?.call(ZhongyiPrescriptionTemplateItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ZhongyiPrescriptionTemplateItem]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ZhongyiPrescriptionTemplateItem> updateRow(
    _is.DatabaseSession session,
    ZhongyiPrescriptionTemplateItem row, {
    _is.ColumnSelections<ZhongyiPrescriptionTemplateItemTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ZhongyiPrescriptionTemplateItem>(
      row,
      columns: columns?.call(ZhongyiPrescriptionTemplateItem.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ZhongyiPrescriptionTemplateItem] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ZhongyiPrescriptionTemplateItem?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ZhongyiPrescriptionTemplateItemUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ZhongyiPrescriptionTemplateItem>(
      id,
      columnValues: columnValues(ZhongyiPrescriptionTemplateItem.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiPrescriptionTemplateItem]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPrescriptionTemplateItem>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ZhongyiPrescriptionTemplateItemUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateItemTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiPrescriptionTemplateItemTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPrescriptionTemplateItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ZhongyiPrescriptionTemplateItem>(
      columnValues: columnValues(ZhongyiPrescriptionTemplateItem.t.updateTable),
      where: where(ZhongyiPrescriptionTemplateItem.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiPrescriptionTemplateItem.t),
      orderByList: orderByList?.call(ZhongyiPrescriptionTemplateItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ZhongyiPrescriptionTemplateItem]s in the list and returns the deleted rows.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPrescriptionTemplateItem>> delete(
    _is.DatabaseSession session,
    List<ZhongyiPrescriptionTemplateItem> rows, {
    _is.OrderByBuilder<ZhongyiPrescriptionTemplateItemTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPrescriptionTemplateItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ZhongyiPrescriptionTemplateItem>(
      rows,
      orderBy: orderBy?.call(ZhongyiPrescriptionTemplateItem.t),
      orderByList: orderByList?.call(ZhongyiPrescriptionTemplateItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ZhongyiPrescriptionTemplateItem].
  Future<ZhongyiPrescriptionTemplateItem> deleteRow(
    _is.DatabaseSession session,
    ZhongyiPrescriptionTemplateItem row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ZhongyiPrescriptionTemplateItem>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPrescriptionTemplateItem>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateItemTable> where,
    _is.OrderByBuilder<ZhongyiPrescriptionTemplateItemTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPrescriptionTemplateItemTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ZhongyiPrescriptionTemplateItem>(
      where: where(ZhongyiPrescriptionTemplateItem.t),
      orderBy: orderBy?.call(ZhongyiPrescriptionTemplateItem.t),
      orderByList: orderByList?.call(ZhongyiPrescriptionTemplateItem.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateItemTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ZhongyiPrescriptionTemplateItem>(
      where: where?.call(ZhongyiPrescriptionTemplateItem.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ZhongyiPrescriptionTemplateItem] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateItemTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ZhongyiPrescriptionTemplateItem>(
      where: where(ZhongyiPrescriptionTemplateItem.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
