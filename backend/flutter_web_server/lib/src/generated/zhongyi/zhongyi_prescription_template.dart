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

/// 中医门诊处方模板
abstract class ZhongyiPrescriptionTemplate implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ZhongyiPrescriptionTemplate._({
    this.id,
    int? tenantId,
    required this.name,
    required this.scope,
    this.category,
    this.sourceType,
    this.sourceId,
    this.doctorId,
    this.syndrome,
    this.efficacy,
    int? doses,
    required this.itemsJson,
    this.dailyFrequency,
    this.administrationMethod,
    this.decoctionInstruction,
    this.dietRestrictions,
    this.notes,
    bool? isActive,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : tenantId = tenantId ?? 0,
       doses = doses ?? 1,
       isActive = isActive ?? true,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ZhongyiPrescriptionTemplate({
    int? id,
    int? tenantId,
    required String name,
    required String scope,
    String? category,
    String? sourceType,
    int? sourceId,
    int? doctorId,
    String? syndrome,
    String? efficacy,
    int? doses,
    required String itemsJson,
    String? dailyFrequency,
    String? administrationMethod,
    String? decoctionInstruction,
    String? dietRestrictions,
    String? notes,
    bool? isActive,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiPrescriptionTemplateImpl;

  factory ZhongyiPrescriptionTemplate.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiPrescriptionTemplate(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      name: jsonSerialization['name'] as String,
      scope: jsonSerialization['scope'] as String,
      category: jsonSerialization['category'] as String?,
      sourceType: jsonSerialization['sourceType'] as String?,
      sourceId: jsonSerialization['sourceId'] as int?,
      doctorId: jsonSerialization['doctorId'] as int?,
      syndrome: jsonSerialization['syndrome'] as String?,
      efficacy: jsonSerialization['efficacy'] as String?,
      doses: jsonSerialization['doses'] as int?,
      itemsJson: jsonSerialization['itemsJson'] as String,
      dailyFrequency: jsonSerialization['dailyFrequency'] as String?,
      administrationMethod: jsonSerialization['administrationMethod'] as String?,
      decoctionInstruction: jsonSerialization['decoctionInstruction'] as String?,
      dietRestrictions: jsonSerialization['dietRestrictions'] as String?,
      notes: jsonSerialization['notes'] as String?,
      isActive: jsonSerialization['isActive'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
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

  static final t = ZhongyiPrescriptionTemplateTable();

  static const db = ZhongyiPrescriptionTemplateRepository._();

  @override
  int? id;

  int tenantId;

  String name;

  String scope;

  String? category;

  String? sourceType;

  int? sourceId;

  int? doctorId;

  String? syndrome;

  String? efficacy;

  int doses;

  String itemsJson;

  String? dailyFrequency;

  String? administrationMethod;

  String? decoctionInstruction;

  String? dietRestrictions;

  String? notes;

  bool isActive;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ZhongyiPrescriptionTemplate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ZhongyiPrescriptionTemplate copyWith({
    int? id,
    int? tenantId,
    String? name,
    String? scope,
    String? category,
    String? sourceType,
    int? sourceId,
    int? doctorId,
    String? syndrome,
    String? efficacy,
    int? doses,
    String? itemsJson,
    String? dailyFrequency,
    String? administrationMethod,
    String? decoctionInstruction,
    String? dietRestrictions,
    String? notes,
    bool? isActive,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ZhongyiPrescriptionTemplate',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'scope': scope,
      if (category != null) 'category': category,
      if (sourceType != null) 'sourceType': sourceType,
      if (sourceId != null) 'sourceId': sourceId,
      if (doctorId != null) 'doctorId': doctorId,
      if (syndrome != null) 'syndrome': syndrome,
      if (efficacy != null) 'efficacy': efficacy,
      'doses': doses,
      'itemsJson': itemsJson,
      if (dailyFrequency != null) 'dailyFrequency': dailyFrequency,
      if (administrationMethod != null) 'administrationMethod': administrationMethod,
      if (decoctionInstruction != null) 'decoctionInstruction': decoctionInstruction,
      if (dietRestrictions != null) 'dietRestrictions': dietRestrictions,
      if (notes != null) 'notes': notes,
      'isActive': isActive,
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
      '__className__': 'ZhongyiPrescriptionTemplate',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'scope': scope,
      if (category != null) 'category': category,
      if (sourceType != null) 'sourceType': sourceType,
      if (sourceId != null) 'sourceId': sourceId,
      if (doctorId != null) 'doctorId': doctorId,
      if (syndrome != null) 'syndrome': syndrome,
      if (efficacy != null) 'efficacy': efficacy,
      'doses': doses,
      'itemsJson': itemsJson,
      if (dailyFrequency != null) 'dailyFrequency': dailyFrequency,
      if (administrationMethod != null) 'administrationMethod': administrationMethod,
      if (decoctionInstruction != null) 'decoctionInstruction': decoctionInstruction,
      if (dietRestrictions != null) 'dietRestrictions': dietRestrictions,
      if (notes != null) 'notes': notes,
      'isActive': isActive,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static ZhongyiPrescriptionTemplateInclude include() {
    return ZhongyiPrescriptionTemplateInclude._();
  }

  static ZhongyiPrescriptionTemplateIncludeList includeList({
    _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiPrescriptionTemplateTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPrescriptionTemplateTable>? orderByList,
    ZhongyiPrescriptionTemplateInclude? include,
  }) {
    return ZhongyiPrescriptionTemplateIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiPrescriptionTemplate.t),
      orderByList: orderByList?.call(ZhongyiPrescriptionTemplate.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ZhongyiPrescriptionTemplateImpl extends ZhongyiPrescriptionTemplate {
  _ZhongyiPrescriptionTemplateImpl({
    int? id,
    int? tenantId,
    required String name,
    required String scope,
    String? category,
    String? sourceType,
    int? sourceId,
    int? doctorId,
    String? syndrome,
    String? efficacy,
    int? doses,
    required String itemsJson,
    String? dailyFrequency,
    String? administrationMethod,
    String? decoctionInstruction,
    String? dietRestrictions,
    String? notes,
    bool? isActive,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         name: name,
         scope: scope,
         category: category,
         sourceType: sourceType,
         sourceId: sourceId,
         doctorId: doctorId,
         syndrome: syndrome,
         efficacy: efficacy,
         doses: doses,
         itemsJson: itemsJson,
         dailyFrequency: dailyFrequency,
         administrationMethod: administrationMethod,
         decoctionInstruction: decoctionInstruction,
         dietRestrictions: dietRestrictions,
         notes: notes,
         isActive: isActive,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiPrescriptionTemplate]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ZhongyiPrescriptionTemplate copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? name,
    String? scope,
    Object? category = _Undefined,
    Object? sourceType = _Undefined,
    Object? sourceId = _Undefined,
    Object? doctorId = _Undefined,
    Object? syndrome = _Undefined,
    Object? efficacy = _Undefined,
    int? doses,
    String? itemsJson,
    Object? dailyFrequency = _Undefined,
    Object? administrationMethod = _Undefined,
    Object? decoctionInstruction = _Undefined,
    Object? dietRestrictions = _Undefined,
    Object? notes = _Undefined,
    bool? isActive,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiPrescriptionTemplate(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      scope: scope ?? this.scope,
      category: category is String? ? category : this.category,
      sourceType: sourceType is String? ? sourceType : this.sourceType,
      sourceId: sourceId is int? ? sourceId : this.sourceId,
      doctorId: doctorId is int? ? doctorId : this.doctorId,
      syndrome: syndrome is String? ? syndrome : this.syndrome,
      efficacy: efficacy is String? ? efficacy : this.efficacy,
      doses: doses ?? this.doses,
      itemsJson: itemsJson ?? this.itemsJson,
      dailyFrequency: dailyFrequency is String? ? dailyFrequency : this.dailyFrequency,
      administrationMethod: administrationMethod is String? ? administrationMethod : this.administrationMethod,
      decoctionInstruction: decoctionInstruction is String? ? decoctionInstruction : this.decoctionInstruction,
      dietRestrictions: dietRestrictions is String? ? dietRestrictions : this.dietRestrictions,
      notes: notes is String? ? notes : this.notes,
      isActive: isActive ?? this.isActive,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class ZhongyiPrescriptionTemplateUpdateTable extends _is.UpdateTable<ZhongyiPrescriptionTemplateTable> {
  ZhongyiPrescriptionTemplateUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) => _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> scope(String value) => _is.ColumnValue(table.scope, value);

  _is.ColumnValue<String, String> category(String? value) => _is.ColumnValue(table.category, value);

  _is.ColumnValue<String, String> sourceType(String? value) => _is.ColumnValue(table.sourceType, value);

  _is.ColumnValue<int, int> sourceId(int? value) => _is.ColumnValue(table.sourceId, value);

  _is.ColumnValue<int, int> doctorId(int? value) => _is.ColumnValue(table.doctorId, value);

  _is.ColumnValue<String, String> syndrome(String? value) => _is.ColumnValue(table.syndrome, value);

  _is.ColumnValue<String, String> efficacy(String? value) => _is.ColumnValue(table.efficacy, value);

  _is.ColumnValue<int, int> doses(int value) => _is.ColumnValue(table.doses, value);

  _is.ColumnValue<String, String> itemsJson(String value) => _is.ColumnValue(table.itemsJson, value);

  _is.ColumnValue<String, String> dailyFrequency(String? value) => _is.ColumnValue(table.dailyFrequency, value);

  _is.ColumnValue<String, String> administrationMethod(String? value) =>
      _is.ColumnValue(table.administrationMethod, value);

  _is.ColumnValue<String, String> decoctionInstruction(String? value) =>
      _is.ColumnValue(table.decoctionInstruction, value);

  _is.ColumnValue<String, String> dietRestrictions(String? value) => _is.ColumnValue(table.dietRestrictions, value);

  _is.ColumnValue<String, String> notes(String? value) => _is.ColumnValue(table.notes, value);

  _is.ColumnValue<bool, bool> isActive(bool value) => _is.ColumnValue(table.isActive, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);
}

class ZhongyiPrescriptionTemplateTable extends _is.Table<int?> {
  ZhongyiPrescriptionTemplateTable({super.tableRelation}) : super(tableName: 'zhongyi_prescription_template') {
    updateTable = ZhongyiPrescriptionTemplateUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    name = _is.ColumnString('name', this);
    scope = _is.ColumnString('scope', this);
    category = _is.ColumnString('category', this);
    sourceType = _is.ColumnString('sourceType', this);
    sourceId = _is.ColumnInt('sourceId', this);
    doctorId = _is.ColumnInt('doctorId', this);
    syndrome = _is.ColumnString('syndrome', this);
    efficacy = _is.ColumnString('efficacy', this);
    doses = _is.ColumnInt('doses', this, hasDefault: true);
    itemsJson = _is.ColumnString('itemsJson', this);
    dailyFrequency = _is.ColumnString('dailyFrequency', this);
    administrationMethod = _is.ColumnString('administrationMethod', this);
    decoctionInstruction = _is.ColumnString('decoctionInstruction', this);
    dietRestrictions = _is.ColumnString('dietRestrictions', this);
    notes = _is.ColumnString('notes', this);
    isActive = _is.ColumnBool('isActive', this, hasDefault: true);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final ZhongyiPrescriptionTemplateUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnString name;

  late final _is.ColumnString scope;

  late final _is.ColumnString category;

  late final _is.ColumnString sourceType;

  late final _is.ColumnInt sourceId;

  late final _is.ColumnInt doctorId;

  late final _is.ColumnString syndrome;

  late final _is.ColumnString efficacy;

  late final _is.ColumnInt doses;

  late final _is.ColumnString itemsJson;

  late final _is.ColumnString dailyFrequency;

  late final _is.ColumnString administrationMethod;

  late final _is.ColumnString decoctionInstruction;

  late final _is.ColumnString dietRestrictions;

  late final _is.ColumnString notes;

  late final _is.ColumnBool isActive;

  late final _is.ColumnBool deleted;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    name,
    scope,
    category,
    sourceType,
    sourceId,
    doctorId,
    syndrome,
    efficacy,
    doses,
    itemsJson,
    dailyFrequency,
    administrationMethod,
    decoctionInstruction,
    dietRestrictions,
    notes,
    isActive,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class ZhongyiPrescriptionTemplateInclude extends _is.IncludeObject {
  ZhongyiPrescriptionTemplateInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ZhongyiPrescriptionTemplate.t;
}

class ZhongyiPrescriptionTemplateIncludeList extends _is.IncludeList {
  ZhongyiPrescriptionTemplateIncludeList._({
    _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ZhongyiPrescriptionTemplate.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ZhongyiPrescriptionTemplate.t;
}

class ZhongyiPrescriptionTemplateRepository {
  const ZhongyiPrescriptionTemplateRepository._();

  /// Returns a list of [ZhongyiPrescriptionTemplate]s matching the given query parameters.
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
  Future<List<ZhongyiPrescriptionTemplate>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiPrescriptionTemplateTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPrescriptionTemplateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ZhongyiPrescriptionTemplate>(
      where: where?.call(ZhongyiPrescriptionTemplate.t),
      orderBy: orderBy?.call(ZhongyiPrescriptionTemplate.t),
      orderByList: orderByList?.call(ZhongyiPrescriptionTemplate.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ZhongyiPrescriptionTemplate] matching the given query parameters.
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
  Future<ZhongyiPrescriptionTemplate?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateTable>? where,
    int? offset,
    _is.OrderByBuilder<ZhongyiPrescriptionTemplateTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPrescriptionTemplateTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ZhongyiPrescriptionTemplate>(
      where: where?.call(ZhongyiPrescriptionTemplate.t),
      orderBy: orderBy?.call(ZhongyiPrescriptionTemplate.t),
      orderByList: orderByList?.call(ZhongyiPrescriptionTemplate.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ZhongyiPrescriptionTemplate] by its [id] or null if no such row exists.
  Future<ZhongyiPrescriptionTemplate?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ZhongyiPrescriptionTemplate>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ZhongyiPrescriptionTemplate]s in the list and returns the inserted rows.
  ///
  /// The returned [ZhongyiPrescriptionTemplate]s will have their `id` fields set.
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
  Future<List<ZhongyiPrescriptionTemplate>> insert(
    _is.DatabaseSession session,
    List<ZhongyiPrescriptionTemplate> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ZhongyiPrescriptionTemplate>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ZhongyiPrescriptionTemplate] and returns the inserted row.
  ///
  /// The returned [ZhongyiPrescriptionTemplate] will have its `id` field set.
  Future<ZhongyiPrescriptionTemplate> insertRow(
    _is.DatabaseSession session,
    ZhongyiPrescriptionTemplate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ZhongyiPrescriptionTemplate>(row, transaction: transaction);
  }

  /// Upserts all [ZhongyiPrescriptionTemplate]s in the list and returns the resulting rows.
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
  /// The returned [ZhongyiPrescriptionTemplate]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPrescriptionTemplate>> upsert(
    _is.DatabaseSession session,
    List<ZhongyiPrescriptionTemplate> rows, {
    required _is.ColumnSelections<ZhongyiPrescriptionTemplateTable> conflictColumns,
    _is.ColumnSelections<ZhongyiPrescriptionTemplateTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ZhongyiPrescriptionTemplate>(
      rows,
      conflictColumns: conflictColumns(ZhongyiPrescriptionTemplate.t),
      updateColumns: updateColumns?.call(ZhongyiPrescriptionTemplate.t),
      updateWhere: updateWhere?.call(ZhongyiPrescriptionTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ZhongyiPrescriptionTemplate] and returns the resulting row.
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
  /// The returned [ZhongyiPrescriptionTemplate] will have its `id` field set.
  Future<ZhongyiPrescriptionTemplate?> upsertRow(
    _is.DatabaseSession session,
    ZhongyiPrescriptionTemplate row, {
    required _is.ColumnSelections<ZhongyiPrescriptionTemplateTable> conflictColumns,
    _is.ColumnSelections<ZhongyiPrescriptionTemplateTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ZhongyiPrescriptionTemplate>(
      row,
      conflictColumns: conflictColumns(ZhongyiPrescriptionTemplate.t),
      updateColumns: updateColumns?.call(ZhongyiPrescriptionTemplate.t),
      updateWhere: updateWhere?.call(ZhongyiPrescriptionTemplate.t),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiPrescriptionTemplate]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPrescriptionTemplate>> update(
    _is.DatabaseSession session,
    List<ZhongyiPrescriptionTemplate> rows, {
    _is.ColumnSelections<ZhongyiPrescriptionTemplateTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ZhongyiPrescriptionTemplate>(
      rows,
      columns: columns?.call(ZhongyiPrescriptionTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ZhongyiPrescriptionTemplate]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ZhongyiPrescriptionTemplate> updateRow(
    _is.DatabaseSession session,
    ZhongyiPrescriptionTemplate row, {
    _is.ColumnSelections<ZhongyiPrescriptionTemplateTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ZhongyiPrescriptionTemplate>(
      row,
      columns: columns?.call(ZhongyiPrescriptionTemplate.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ZhongyiPrescriptionTemplate] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ZhongyiPrescriptionTemplate?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ZhongyiPrescriptionTemplateUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ZhongyiPrescriptionTemplate>(
      id,
      columnValues: columnValues(ZhongyiPrescriptionTemplate.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiPrescriptionTemplate]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPrescriptionTemplate>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ZhongyiPrescriptionTemplateUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiPrescriptionTemplateTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPrescriptionTemplateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ZhongyiPrescriptionTemplate>(
      columnValues: columnValues(ZhongyiPrescriptionTemplate.t.updateTable),
      where: where(ZhongyiPrescriptionTemplate.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiPrescriptionTemplate.t),
      orderByList: orderByList?.call(ZhongyiPrescriptionTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ZhongyiPrescriptionTemplate]s in the list and returns the deleted rows.
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
  Future<List<ZhongyiPrescriptionTemplate>> delete(
    _is.DatabaseSession session,
    List<ZhongyiPrescriptionTemplate> rows, {
    _is.OrderByBuilder<ZhongyiPrescriptionTemplateTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPrescriptionTemplateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ZhongyiPrescriptionTemplate>(
      rows,
      orderBy: orderBy?.call(ZhongyiPrescriptionTemplate.t),
      orderByList: orderByList?.call(ZhongyiPrescriptionTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ZhongyiPrescriptionTemplate].
  Future<ZhongyiPrescriptionTemplate> deleteRow(
    _is.DatabaseSession session,
    ZhongyiPrescriptionTemplate row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ZhongyiPrescriptionTemplate>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPrescriptionTemplate>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateTable> where,
    _is.OrderByBuilder<ZhongyiPrescriptionTemplateTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPrescriptionTemplateTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ZhongyiPrescriptionTemplate>(
      where: where(ZhongyiPrescriptionTemplate.t),
      orderBy: orderBy?.call(ZhongyiPrescriptionTemplate.t),
      orderByList: orderByList?.call(ZhongyiPrescriptionTemplate.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ZhongyiPrescriptionTemplate>(
      where: where?.call(ZhongyiPrescriptionTemplate.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ZhongyiPrescriptionTemplate] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiPrescriptionTemplateTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ZhongyiPrescriptionTemplate>(
      where: where(ZhongyiPrescriptionTemplate.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
