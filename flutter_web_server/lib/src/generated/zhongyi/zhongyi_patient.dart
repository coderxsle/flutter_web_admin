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

/// 中医门诊患者档案
abstract class ZhongyiPatient implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ZhongyiPatient._({
    this.id,
    int? tenantId,
    required this.name,
    int? gender,
    this.birthDate,
    this.phone,
    this.idCard,
    this.address,
    this.occupation,
    this.bloodType,
    this.emergencyContact,
    this.emergencyPhone,
    this.allergyHistory,
    this.medicalHistory,
    this.familyHistory,
    this.constitution,
    this.source,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : tenantId = tenantId ?? 0,
       gender = gender ?? 3,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ZhongyiPatient({
    int? id,
    int? tenantId,
    required String name,
    int? gender,
    DateTime? birthDate,
    String? phone,
    String? idCard,
    String? address,
    String? occupation,
    String? bloodType,
    String? emergencyContact,
    String? emergencyPhone,
    String? allergyHistory,
    String? medicalHistory,
    String? familyHistory,
    String? constitution,
    String? source,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiPatientImpl;

  factory ZhongyiPatient.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiPatient(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      name: jsonSerialization['name'] as String,
      gender: jsonSerialization['gender'] as int?,
      birthDate: jsonSerialization['birthDate'] == null
          ? null
          : _is.DateTimeJsonExtension.fromJson(jsonSerialization['birthDate']),
      phone: jsonSerialization['phone'] as String?,
      idCard: jsonSerialization['idCard'] as String?,
      address: jsonSerialization['address'] as String?,
      occupation: jsonSerialization['occupation'] as String?,
      bloodType: jsonSerialization['bloodType'] as String?,
      emergencyContact: jsonSerialization['emergencyContact'] as String?,
      emergencyPhone: jsonSerialization['emergencyPhone'] as String?,
      allergyHistory: jsonSerialization['allergyHistory'] as String?,
      medicalHistory: jsonSerialization['medicalHistory'] as String?,
      familyHistory: jsonSerialization['familyHistory'] as String?,
      constitution: jsonSerialization['constitution'] as String?,
      source: jsonSerialization['source'] as String?,
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

  static final t = ZhongyiPatientTable();

  static const db = ZhongyiPatientRepository._();

  @override
  int? id;

  /// 租户ID
  int tenantId;

  /// 患者姓名
  String name;

  /// 用户性别（1=男，2=女，3=保密）
  int gender;

  /// 出生日期
  DateTime? birthDate;

  /// 联系电话
  String? phone;

  /// 敏感个人信息（PHI）：身份证号码；不得写入操作审计字段或普通日志。
  String? idCard;

  /// 敏感个人信息（PHI）：联系地址；不得写入操作审计字段或普通日志。
  String? address;

  String? occupation;

  String? bloodType;

  String? emergencyContact;

  String? emergencyPhone;

  /// 敏感健康信息（PHI）：过敏史；不得复制到审计字段或普通日志。
  String? allergyHistory;

  /// 敏感健康信息（PHI）：既往病史；不得复制到审计字段或普通日志。
  String? medicalHistory;

  /// 敏感健康信息（PHI）：家族病史；不得复制到审计字段或普通日志。
  String? familyHistory;

  String? constitution;

  String? source;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ZhongyiPatient]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ZhongyiPatient copyWith({
    int? id,
    int? tenantId,
    String? name,
    int? gender,
    DateTime? birthDate,
    String? phone,
    String? idCard,
    String? address,
    String? occupation,
    String? bloodType,
    String? emergencyContact,
    String? emergencyPhone,
    String? allergyHistory,
    String? medicalHistory,
    String? familyHistory,
    String? constitution,
    String? source,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ZhongyiPatient',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'gender': gender,
      if (birthDate != null) 'birthDate': birthDate?.toJson(),
      if (phone != null) 'phone': phone,
      if (idCard != null) 'idCard': idCard,
      if (address != null) 'address': address,
      if (occupation != null) 'occupation': occupation,
      if (bloodType != null) 'bloodType': bloodType,
      if (emergencyContact != null) 'emergencyContact': emergencyContact,
      if (emergencyPhone != null) 'emergencyPhone': emergencyPhone,
      if (allergyHistory != null) 'allergyHistory': allergyHistory,
      if (medicalHistory != null) 'medicalHistory': medicalHistory,
      if (familyHistory != null) 'familyHistory': familyHistory,
      if (constitution != null) 'constitution': constitution,
      if (source != null) 'source': source,
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
      '__className__': 'ZhongyiPatient',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'name': name,
      'gender': gender,
      if (birthDate != null) 'birthDate': birthDate?.toJson(),
      if (phone != null) 'phone': phone,
      if (idCard != null) 'idCard': idCard,
      if (address != null) 'address': address,
      if (occupation != null) 'occupation': occupation,
      if (bloodType != null) 'bloodType': bloodType,
      if (emergencyContact != null) 'emergencyContact': emergencyContact,
      if (emergencyPhone != null) 'emergencyPhone': emergencyPhone,
      if (allergyHistory != null) 'allergyHistory': allergyHistory,
      if (medicalHistory != null) 'medicalHistory': medicalHistory,
      if (familyHistory != null) 'familyHistory': familyHistory,
      if (constitution != null) 'constitution': constitution,
      if (source != null) 'source': source,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static ZhongyiPatientInclude include() {
    return ZhongyiPatientInclude._();
  }

  static ZhongyiPatientIncludeList includeList({
    _is.WhereExpressionBuilder<ZhongyiPatientTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiPatientTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPatientTable>? orderByList,
    ZhongyiPatientInclude? include,
  }) {
    return ZhongyiPatientIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiPatient.t),
      orderByList: orderByList?.call(ZhongyiPatient.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ZhongyiPatientImpl extends ZhongyiPatient {
  _ZhongyiPatientImpl({
    int? id,
    int? tenantId,
    required String name,
    int? gender,
    DateTime? birthDate,
    String? phone,
    String? idCard,
    String? address,
    String? occupation,
    String? bloodType,
    String? emergencyContact,
    String? emergencyPhone,
    String? allergyHistory,
    String? medicalHistory,
    String? familyHistory,
    String? constitution,
    String? source,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         name: name,
         gender: gender,
         birthDate: birthDate,
         phone: phone,
         idCard: idCard,
         address: address,
         occupation: occupation,
         bloodType: bloodType,
         emergencyContact: emergencyContact,
         emergencyPhone: emergencyPhone,
         allergyHistory: allergyHistory,
         medicalHistory: medicalHistory,
         familyHistory: familyHistory,
         constitution: constitution,
         source: source,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiPatient]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ZhongyiPatient copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? name,
    int? gender,
    Object? birthDate = _Undefined,
    Object? phone = _Undefined,
    Object? idCard = _Undefined,
    Object? address = _Undefined,
    Object? occupation = _Undefined,
    Object? bloodType = _Undefined,
    Object? emergencyContact = _Undefined,
    Object? emergencyPhone = _Undefined,
    Object? allergyHistory = _Undefined,
    Object? medicalHistory = _Undefined,
    Object? familyHistory = _Undefined,
    Object? constitution = _Undefined,
    Object? source = _Undefined,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiPatient(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      birthDate: birthDate is DateTime? ? birthDate : this.birthDate,
      phone: phone is String? ? phone : this.phone,
      idCard: idCard is String? ? idCard : this.idCard,
      address: address is String? ? address : this.address,
      occupation: occupation is String? ? occupation : this.occupation,
      bloodType: bloodType is String? ? bloodType : this.bloodType,
      emergencyContact: emergencyContact is String? ? emergencyContact : this.emergencyContact,
      emergencyPhone: emergencyPhone is String? ? emergencyPhone : this.emergencyPhone,
      allergyHistory: allergyHistory is String? ? allergyHistory : this.allergyHistory,
      medicalHistory: medicalHistory is String? ? medicalHistory : this.medicalHistory,
      familyHistory: familyHistory is String? ? familyHistory : this.familyHistory,
      constitution: constitution is String? ? constitution : this.constitution,
      source: source is String? ? source : this.source,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class ZhongyiPatientUpdateTable extends _is.UpdateTable<ZhongyiPatientTable> {
  ZhongyiPatientUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) => _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(table.name, value);

  _is.ColumnValue<int, int> gender(int value) => _is.ColumnValue(table.gender, value);

  _is.ColumnValue<DateTime, DateTime> birthDate(DateTime? value) => _is.ColumnValue(table.birthDate, value);

  _is.ColumnValue<String, String> phone(String? value) => _is.ColumnValue(table.phone, value);

  _is.ColumnValue<String, String> idCard(String? value) => _is.ColumnValue(table.idCard, value);

  _is.ColumnValue<String, String> address(String? value) => _is.ColumnValue(table.address, value);

  _is.ColumnValue<String, String> occupation(String? value) => _is.ColumnValue(table.occupation, value);

  _is.ColumnValue<String, String> bloodType(String? value) => _is.ColumnValue(table.bloodType, value);

  _is.ColumnValue<String, String> emergencyContact(String? value) => _is.ColumnValue(table.emergencyContact, value);

  _is.ColumnValue<String, String> emergencyPhone(String? value) => _is.ColumnValue(table.emergencyPhone, value);

  _is.ColumnValue<String, String> allergyHistory(String? value) => _is.ColumnValue(table.allergyHistory, value);

  _is.ColumnValue<String, String> medicalHistory(String? value) => _is.ColumnValue(table.medicalHistory, value);

  _is.ColumnValue<String, String> familyHistory(String? value) => _is.ColumnValue(table.familyHistory, value);

  _is.ColumnValue<String, String> constitution(String? value) => _is.ColumnValue(table.constitution, value);

  _is.ColumnValue<String, String> source(String? value) => _is.ColumnValue(table.source, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);
}

class ZhongyiPatientTable extends _is.Table<int?> {
  ZhongyiPatientTable({super.tableRelation}) : super(tableName: 'zhongyi_patient') {
    updateTable = ZhongyiPatientUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    name = _is.ColumnString('name', this);
    gender = _is.ColumnInt('gender', this, hasDefault: true);
    birthDate = _is.ColumnDateTime('birthDate', this);
    phone = _is.ColumnString('phone', this);
    idCard = _is.ColumnString('idCard', this);
    address = _is.ColumnString('address', this);
    occupation = _is.ColumnString('occupation', this);
    bloodType = _is.ColumnString('bloodType', this);
    emergencyContact = _is.ColumnString('emergencyContact', this);
    emergencyPhone = _is.ColumnString('emergencyPhone', this);
    allergyHistory = _is.ColumnString('allergyHistory', this);
    medicalHistory = _is.ColumnString('medicalHistory', this);
    familyHistory = _is.ColumnString('familyHistory', this);
    constitution = _is.ColumnString('constitution', this);
    source = _is.ColumnString('source', this);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final ZhongyiPatientUpdateTable updateTable;

  /// 租户ID
  late final _is.ColumnInt tenantId;

  /// 患者姓名
  late final _is.ColumnString name;

  /// 用户性别（1=男，2=女，3=保密）
  late final _is.ColumnInt gender;

  /// 出生日期
  late final _is.ColumnDateTime birthDate;

  /// 联系电话
  late final _is.ColumnString phone;

  /// 敏感个人信息（PHI）：身份证号码；不得写入操作审计字段或普通日志。
  late final _is.ColumnString idCard;

  /// 敏感个人信息（PHI）：联系地址；不得写入操作审计字段或普通日志。
  late final _is.ColumnString address;

  late final _is.ColumnString occupation;

  late final _is.ColumnString bloodType;

  late final _is.ColumnString emergencyContact;

  late final _is.ColumnString emergencyPhone;

  /// 敏感健康信息（PHI）：过敏史；不得复制到审计字段或普通日志。
  late final _is.ColumnString allergyHistory;

  /// 敏感健康信息（PHI）：既往病史；不得复制到审计字段或普通日志。
  late final _is.ColumnString medicalHistory;

  /// 敏感健康信息（PHI）：家族病史；不得复制到审计字段或普通日志。
  late final _is.ColumnString familyHistory;

  late final _is.ColumnString constitution;

  late final _is.ColumnString source;

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
    gender,
    birthDate,
    phone,
    idCard,
    address,
    occupation,
    bloodType,
    emergencyContact,
    emergencyPhone,
    allergyHistory,
    medicalHistory,
    familyHistory,
    constitution,
    source,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class ZhongyiPatientInclude extends _is.IncludeObject {
  ZhongyiPatientInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ZhongyiPatient.t;
}

class ZhongyiPatientIncludeList extends _is.IncludeList {
  ZhongyiPatientIncludeList._({
    _is.WhereExpressionBuilder<ZhongyiPatientTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ZhongyiPatient.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ZhongyiPatient.t;
}

class ZhongyiPatientRepository {
  const ZhongyiPatientRepository._();

  /// Returns a list of [ZhongyiPatient]s matching the given query parameters.
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
  Future<List<ZhongyiPatient>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiPatientTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiPatientTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPatientTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ZhongyiPatient>(
      where: where?.call(ZhongyiPatient.t),
      orderBy: orderBy?.call(ZhongyiPatient.t),
      orderByList: orderByList?.call(ZhongyiPatient.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ZhongyiPatient] matching the given query parameters.
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
  Future<ZhongyiPatient?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiPatientTable>? where,
    int? offset,
    _is.OrderByBuilder<ZhongyiPatientTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPatientTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ZhongyiPatient>(
      where: where?.call(ZhongyiPatient.t),
      orderBy: orderBy?.call(ZhongyiPatient.t),
      orderByList: orderByList?.call(ZhongyiPatient.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ZhongyiPatient] by its [id] or null if no such row exists.
  Future<ZhongyiPatient?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ZhongyiPatient>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ZhongyiPatient]s in the list and returns the inserted rows.
  ///
  /// The returned [ZhongyiPatient]s will have their `id` fields set.
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
  Future<List<ZhongyiPatient>> insert(
    _is.DatabaseSession session,
    List<ZhongyiPatient> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ZhongyiPatient>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ZhongyiPatient] and returns the inserted row.
  ///
  /// The returned [ZhongyiPatient] will have its `id` field set.
  Future<ZhongyiPatient> insertRow(
    _is.DatabaseSession session,
    ZhongyiPatient row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ZhongyiPatient>(row, transaction: transaction);
  }

  /// Upserts all [ZhongyiPatient]s in the list and returns the resulting rows.
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
  /// The returned [ZhongyiPatient]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPatient>> upsert(
    _is.DatabaseSession session,
    List<ZhongyiPatient> rows, {
    required _is.ColumnSelections<ZhongyiPatientTable> conflictColumns,
    _is.ColumnSelections<ZhongyiPatientTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiPatientTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ZhongyiPatient>(
      rows,
      conflictColumns: conflictColumns(ZhongyiPatient.t),
      updateColumns: updateColumns?.call(ZhongyiPatient.t),
      updateWhere: updateWhere?.call(ZhongyiPatient.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ZhongyiPatient] and returns the resulting row.
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
  /// The returned [ZhongyiPatient] will have its `id` field set.
  Future<ZhongyiPatient?> upsertRow(
    _is.DatabaseSession session,
    ZhongyiPatient row, {
    required _is.ColumnSelections<ZhongyiPatientTable> conflictColumns,
    _is.ColumnSelections<ZhongyiPatientTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiPatientTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ZhongyiPatient>(
      row,
      conflictColumns: conflictColumns(ZhongyiPatient.t),
      updateColumns: updateColumns?.call(ZhongyiPatient.t),
      updateWhere: updateWhere?.call(ZhongyiPatient.t),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiPatient]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPatient>> update(
    _is.DatabaseSession session,
    List<ZhongyiPatient> rows, {
    _is.ColumnSelections<ZhongyiPatientTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ZhongyiPatient>(
      rows,
      columns: columns?.call(ZhongyiPatient.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ZhongyiPatient]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ZhongyiPatient> updateRow(
    _is.DatabaseSession session,
    ZhongyiPatient row, {
    _is.ColumnSelections<ZhongyiPatientTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ZhongyiPatient>(
      row,
      columns: columns?.call(ZhongyiPatient.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ZhongyiPatient] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ZhongyiPatient?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ZhongyiPatientUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ZhongyiPatient>(
      id,
      columnValues: columnValues(ZhongyiPatient.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiPatient]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPatient>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ZhongyiPatientUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ZhongyiPatientTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiPatientTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPatientTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ZhongyiPatient>(
      columnValues: columnValues(ZhongyiPatient.t.updateTable),
      where: where(ZhongyiPatient.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiPatient.t),
      orderByList: orderByList?.call(ZhongyiPatient.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ZhongyiPatient]s in the list and returns the deleted rows.
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
  Future<List<ZhongyiPatient>> delete(
    _is.DatabaseSession session,
    List<ZhongyiPatient> rows, {
    _is.OrderByBuilder<ZhongyiPatientTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPatientTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ZhongyiPatient>(
      rows,
      orderBy: orderBy?.call(ZhongyiPatient.t),
      orderByList: orderByList?.call(ZhongyiPatient.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ZhongyiPatient].
  Future<ZhongyiPatient> deleteRow(
    _is.DatabaseSession session,
    ZhongyiPatient row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ZhongyiPatient>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiPatient>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiPatientTable> where,
    _is.OrderByBuilder<ZhongyiPatientTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiPatientTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ZhongyiPatient>(
      where: where(ZhongyiPatient.t),
      orderBy: orderBy?.call(ZhongyiPatient.t),
      orderByList: orderByList?.call(ZhongyiPatient.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiPatientTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ZhongyiPatient>(
      where: where?.call(ZhongyiPatient.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ZhongyiPatient] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiPatientTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ZhongyiPatient>(
      where: where(ZhongyiPatient.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
