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

/// 中医门诊员工档案
abstract class ZhongyiStaff implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ZhongyiStaff._({
    this.id,
    int? tenantId,
    required this.userId,
    this.departmentId,
    required this.employeeCode,
    this.professionalTitle,
    this.licenseNumber,
    this.specialization,
    bool? isDoctor,
    bool? isPharmacist,
    double? consultationFee,
    this.introduction,
    this.description,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : tenantId = tenantId ?? 0,
       isDoctor = isDoctor ?? false,
       isPharmacist = isPharmacist ?? false,
       consultationFee = consultationFee ?? 0.0,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ZhongyiStaff({
    int? id,
    int? tenantId,
    required int userId,
    int? departmentId,
    required String employeeCode,
    String? professionalTitle,
    String? licenseNumber,
    String? specialization,
    bool? isDoctor,
    bool? isPharmacist,
    double? consultationFee,
    String? introduction,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiStaffImpl;

  factory ZhongyiStaff.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiStaff(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      userId: jsonSerialization['userId'] as int,
      departmentId: jsonSerialization['departmentId'] as int?,
      employeeCode: jsonSerialization['employeeCode'] as String,
      professionalTitle: jsonSerialization['professionalTitle'] as String?,
      licenseNumber: jsonSerialization['licenseNumber'] as String?,
      specialization: jsonSerialization['specialization'] as String?,
      isDoctor: jsonSerialization['isDoctor'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isDoctor']),
      isPharmacist: jsonSerialization['isPharmacist'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isPharmacist']),
      consultationFee: (jsonSerialization['consultationFee'] as num?)?.toDouble(),
      introduction: jsonSerialization['introduction'] as String?,
      description: jsonSerialization['description'] as String?,
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

  static final t = ZhongyiStaffTable();

  static const db = ZhongyiStaffRepository._();

  @override
  int? id;

  int tenantId;

  int userId;

  int? departmentId;

  String employeeCode;

  String? professionalTitle;

  String? licenseNumber;

  String? specialization;

  bool isDoctor;

  bool isPharmacist;

  double consultationFee;

  String? introduction;

  String? description;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ZhongyiStaff]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ZhongyiStaff copyWith({
    int? id,
    int? tenantId,
    int? userId,
    int? departmentId,
    String? employeeCode,
    String? professionalTitle,
    String? licenseNumber,
    String? specialization,
    bool? isDoctor,
    bool? isPharmacist,
    double? consultationFee,
    String? introduction,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ZhongyiStaff',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'userId': userId,
      if (departmentId != null) 'departmentId': departmentId,
      'employeeCode': employeeCode,
      if (professionalTitle != null) 'professionalTitle': professionalTitle,
      if (licenseNumber != null) 'licenseNumber': licenseNumber,
      if (specialization != null) 'specialization': specialization,
      'isDoctor': isDoctor,
      'isPharmacist': isPharmacist,
      'consultationFee': consultationFee,
      if (introduction != null) 'introduction': introduction,
      if (description != null) 'description': description,
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
      '__className__': 'ZhongyiStaff',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'userId': userId,
      if (departmentId != null) 'departmentId': departmentId,
      'employeeCode': employeeCode,
      if (professionalTitle != null) 'professionalTitle': professionalTitle,
      if (licenseNumber != null) 'licenseNumber': licenseNumber,
      if (specialization != null) 'specialization': specialization,
      'isDoctor': isDoctor,
      'isPharmacist': isPharmacist,
      'consultationFee': consultationFee,
      if (introduction != null) 'introduction': introduction,
      if (description != null) 'description': description,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static ZhongyiStaffInclude include() {
    return ZhongyiStaffInclude._();
  }

  static ZhongyiStaffIncludeList includeList({
    _is.WhereExpressionBuilder<ZhongyiStaffTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiStaffTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiStaffTable>? orderByList,
    ZhongyiStaffInclude? include,
  }) {
    return ZhongyiStaffIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiStaff.t),
      orderByList: orderByList?.call(ZhongyiStaff.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ZhongyiStaffImpl extends ZhongyiStaff {
  _ZhongyiStaffImpl({
    int? id,
    int? tenantId,
    required int userId,
    int? departmentId,
    required String employeeCode,
    String? professionalTitle,
    String? licenseNumber,
    String? specialization,
    bool? isDoctor,
    bool? isPharmacist,
    double? consultationFee,
    String? introduction,
    String? description,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         userId: userId,
         departmentId: departmentId,
         employeeCode: employeeCode,
         professionalTitle: professionalTitle,
         licenseNumber: licenseNumber,
         specialization: specialization,
         isDoctor: isDoctor,
         isPharmacist: isPharmacist,
         consultationFee: consultationFee,
         introduction: introduction,
         description: description,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiStaff]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ZhongyiStaff copyWith({
    Object? id = _Undefined,
    int? tenantId,
    int? userId,
    Object? departmentId = _Undefined,
    String? employeeCode,
    Object? professionalTitle = _Undefined,
    Object? licenseNumber = _Undefined,
    Object? specialization = _Undefined,
    bool? isDoctor,
    bool? isPharmacist,
    double? consultationFee,
    Object? introduction = _Undefined,
    Object? description = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiStaff(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      userId: userId ?? this.userId,
      departmentId: departmentId is int? ? departmentId : this.departmentId,
      employeeCode: employeeCode ?? this.employeeCode,
      professionalTitle: professionalTitle is String? ? professionalTitle : this.professionalTitle,
      licenseNumber: licenseNumber is String? ? licenseNumber : this.licenseNumber,
      specialization: specialization is String? ? specialization : this.specialization,
      isDoctor: isDoctor ?? this.isDoctor,
      isPharmacist: isPharmacist ?? this.isPharmacist,
      consultationFee: consultationFee ?? this.consultationFee,
      introduction: introduction is String? ? introduction : this.introduction,
      description: description is String? ? description : this.description,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class ZhongyiStaffUpdateTable extends _is.UpdateTable<ZhongyiStaffTable> {
  ZhongyiStaffUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) => _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<int, int> userId(int value) => _is.ColumnValue(table.userId, value);

  _is.ColumnValue<int, int> departmentId(int? value) => _is.ColumnValue(table.departmentId, value);

  _is.ColumnValue<String, String> employeeCode(String value) => _is.ColumnValue(table.employeeCode, value);

  _is.ColumnValue<String, String> professionalTitle(String? value) => _is.ColumnValue(table.professionalTitle, value);

  _is.ColumnValue<String, String> licenseNumber(String? value) => _is.ColumnValue(table.licenseNumber, value);

  _is.ColumnValue<String, String> specialization(String? value) => _is.ColumnValue(table.specialization, value);

  _is.ColumnValue<bool, bool> isDoctor(bool value) => _is.ColumnValue(table.isDoctor, value);

  _is.ColumnValue<bool, bool> isPharmacist(bool value) => _is.ColumnValue(table.isPharmacist, value);

  _is.ColumnValue<double, double> consultationFee(double value) => _is.ColumnValue(table.consultationFee, value);

  _is.ColumnValue<String, String> introduction(String? value) => _is.ColumnValue(table.introduction, value);

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(table.description, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);
}

class ZhongyiStaffTable extends _is.Table<int?> {
  ZhongyiStaffTable({super.tableRelation}) : super(tableName: 'zhongyi_staff') {
    updateTable = ZhongyiStaffUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    userId = _is.ColumnInt('userId', this);
    departmentId = _is.ColumnInt('departmentId', this);
    employeeCode = _is.ColumnString('employeeCode', this);
    professionalTitle = _is.ColumnString('professionalTitle', this);
    licenseNumber = _is.ColumnString('licenseNumber', this);
    specialization = _is.ColumnString('specialization', this);
    isDoctor = _is.ColumnBool('isDoctor', this, hasDefault: true);
    isPharmacist = _is.ColumnBool('isPharmacist', this, hasDefault: true);
    consultationFee = _is.ColumnDouble('consultationFee', this, hasDefault: true);
    introduction = _is.ColumnString('introduction', this);
    description = _is.ColumnString('description', this);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final ZhongyiStaffUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnInt userId;

  late final _is.ColumnInt departmentId;

  late final _is.ColumnString employeeCode;

  late final _is.ColumnString professionalTitle;

  late final _is.ColumnString licenseNumber;

  late final _is.ColumnString specialization;

  late final _is.ColumnBool isDoctor;

  late final _is.ColumnBool isPharmacist;

  late final _is.ColumnDouble consultationFee;

  late final _is.ColumnString introduction;

  late final _is.ColumnString description;

  late final _is.ColumnBool deleted;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    userId,
    departmentId,
    employeeCode,
    professionalTitle,
    licenseNumber,
    specialization,
    isDoctor,
    isPharmacist,
    consultationFee,
    introduction,
    description,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class ZhongyiStaffInclude extends _is.IncludeObject {
  ZhongyiStaffInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ZhongyiStaff.t;
}

class ZhongyiStaffIncludeList extends _is.IncludeList {
  ZhongyiStaffIncludeList._({
    _is.WhereExpressionBuilder<ZhongyiStaffTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ZhongyiStaff.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ZhongyiStaff.t;
}

class ZhongyiStaffRepository {
  const ZhongyiStaffRepository._();

  /// Returns a list of [ZhongyiStaff]s matching the given query parameters.
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
  Future<List<ZhongyiStaff>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiStaffTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiStaffTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiStaffTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ZhongyiStaff>(
      where: where?.call(ZhongyiStaff.t),
      orderBy: orderBy?.call(ZhongyiStaff.t),
      orderByList: orderByList?.call(ZhongyiStaff.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ZhongyiStaff] matching the given query parameters.
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
  Future<ZhongyiStaff?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiStaffTable>? where,
    int? offset,
    _is.OrderByBuilder<ZhongyiStaffTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiStaffTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ZhongyiStaff>(
      where: where?.call(ZhongyiStaff.t),
      orderBy: orderBy?.call(ZhongyiStaff.t),
      orderByList: orderByList?.call(ZhongyiStaff.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ZhongyiStaff] by its [id] or null if no such row exists.
  Future<ZhongyiStaff?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ZhongyiStaff>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ZhongyiStaff]s in the list and returns the inserted rows.
  ///
  /// The returned [ZhongyiStaff]s will have their `id` fields set.
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
  Future<List<ZhongyiStaff>> insert(
    _is.DatabaseSession session,
    List<ZhongyiStaff> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ZhongyiStaff>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ZhongyiStaff] and returns the inserted row.
  ///
  /// The returned [ZhongyiStaff] will have its `id` field set.
  Future<ZhongyiStaff> insertRow(_is.DatabaseSession session, ZhongyiStaff row, {_is.Transaction? transaction}) async {
    return session.db.insertRow<ZhongyiStaff>(row, transaction: transaction);
  }

  /// Upserts all [ZhongyiStaff]s in the list and returns the resulting rows.
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
  /// The returned [ZhongyiStaff]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiStaff>> upsert(
    _is.DatabaseSession session,
    List<ZhongyiStaff> rows, {
    required _is.ColumnSelections<ZhongyiStaffTable> conflictColumns,
    _is.ColumnSelections<ZhongyiStaffTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiStaffTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ZhongyiStaff>(
      rows,
      conflictColumns: conflictColumns(ZhongyiStaff.t),
      updateColumns: updateColumns?.call(ZhongyiStaff.t),
      updateWhere: updateWhere?.call(ZhongyiStaff.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ZhongyiStaff] and returns the resulting row.
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
  /// The returned [ZhongyiStaff] will have its `id` field set.
  Future<ZhongyiStaff?> upsertRow(
    _is.DatabaseSession session,
    ZhongyiStaff row, {
    required _is.ColumnSelections<ZhongyiStaffTable> conflictColumns,
    _is.ColumnSelections<ZhongyiStaffTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiStaffTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ZhongyiStaff>(
      row,
      conflictColumns: conflictColumns(ZhongyiStaff.t),
      updateColumns: updateColumns?.call(ZhongyiStaff.t),
      updateWhere: updateWhere?.call(ZhongyiStaff.t),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiStaff]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiStaff>> update(
    _is.DatabaseSession session,
    List<ZhongyiStaff> rows, {
    _is.ColumnSelections<ZhongyiStaffTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ZhongyiStaff>(
      rows,
      columns: columns?.call(ZhongyiStaff.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ZhongyiStaff]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ZhongyiStaff> updateRow(
    _is.DatabaseSession session,
    ZhongyiStaff row, {
    _is.ColumnSelections<ZhongyiStaffTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ZhongyiStaff>(row, columns: columns?.call(ZhongyiStaff.t), transaction: transaction);
  }

  /// Updates a single [ZhongyiStaff] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ZhongyiStaff?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ZhongyiStaffUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ZhongyiStaff>(
      id,
      columnValues: columnValues(ZhongyiStaff.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiStaff]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiStaff>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ZhongyiStaffUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ZhongyiStaffTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiStaffTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiStaffTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ZhongyiStaff>(
      columnValues: columnValues(ZhongyiStaff.t.updateTable),
      where: where(ZhongyiStaff.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiStaff.t),
      orderByList: orderByList?.call(ZhongyiStaff.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ZhongyiStaff]s in the list and returns the deleted rows.
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
  Future<List<ZhongyiStaff>> delete(
    _is.DatabaseSession session,
    List<ZhongyiStaff> rows, {
    _is.OrderByBuilder<ZhongyiStaffTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiStaffTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ZhongyiStaff>(
      rows,
      orderBy: orderBy?.call(ZhongyiStaff.t),
      orderByList: orderByList?.call(ZhongyiStaff.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ZhongyiStaff].
  Future<ZhongyiStaff> deleteRow(_is.DatabaseSession session, ZhongyiStaff row, {_is.Transaction? transaction}) async {
    return session.db.deleteRow<ZhongyiStaff>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiStaff>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiStaffTable> where,
    _is.OrderByBuilder<ZhongyiStaffTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiStaffTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ZhongyiStaff>(
      where: where(ZhongyiStaff.t),
      orderBy: orderBy?.call(ZhongyiStaff.t),
      orderByList: orderByList?.call(ZhongyiStaff.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiStaffTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ZhongyiStaff>(where: where?.call(ZhongyiStaff.t), limit: limit, transaction: transaction);
  }

  /// Acquires row-level locks on [ZhongyiStaff] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiStaffTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ZhongyiStaff>(
      where: where(ZhongyiStaff.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
