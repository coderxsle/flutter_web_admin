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

/// 中药品种主数据
abstract class ZhongyiMedicine implements _is.TableRow<int?>, _is.ProtocolSerialization {
  ZhongyiMedicine._({
    this.id,
    int? tenantId,
    required this.medicineCode,
    this.prefix,
    required this.name,
    this.pinyin,
    this.category,
    this.subcategory,
    this.originPlace,
    this.propertiesJson,
    this.functions,
    this.indications,
    this.commonDosageMin,
    this.commonDosageMax,
    this.dosageWarning,
    this.toxicity,
    this.pregnancyCategory,
    bool? isSpecialManagement,
    this.storageRequirements,
    this.shelfLifeMonths,
    this.description,
    int? status,
    bool? deleted,
    this.creator,
    DateTime? createTime,
    this.updater,
    DateTime? updateTime,
  }) : tenantId = tenantId ?? 0,
       isSpecialManagement = isSpecialManagement ?? false,
       status = status ?? 0,
       deleted = deleted ?? false,
       createTime = createTime ?? DateTime.now(),
       updateTime = updateTime ?? DateTime.now();

  factory ZhongyiMedicine({
    int? id,
    int? tenantId,
    required String medicineCode,
    String? prefix,
    required String name,
    String? pinyin,
    String? category,
    String? subcategory,
    String? originPlace,
    String? propertiesJson,
    String? functions,
    String? indications,
    double? commonDosageMin,
    double? commonDosageMax,
    double? dosageWarning,
    String? toxicity,
    String? pregnancyCategory,
    bool? isSpecialManagement,
    String? storageRequirements,
    int? shelfLifeMonths,
    String? description,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) = _ZhongyiMedicineImpl;

  factory ZhongyiMedicine.fromJson(Map<String, dynamic> jsonSerialization) {
    return ZhongyiMedicine(
      id: jsonSerialization['id'] as int?,
      tenantId: jsonSerialization['tenantId'] as int?,
      medicineCode: jsonSerialization['medicineCode'] as String,
      prefix: jsonSerialization['prefix'] as String?,
      name: jsonSerialization['name'] as String,
      pinyin: jsonSerialization['pinyin'] as String?,
      category: jsonSerialization['category'] as String?,
      subcategory: jsonSerialization['subcategory'] as String?,
      originPlace: jsonSerialization['originPlace'] as String?,
      propertiesJson: jsonSerialization['propertiesJson'] as String?,
      functions: jsonSerialization['functions'] as String?,
      indications: jsonSerialization['indications'] as String?,
      commonDosageMin: (jsonSerialization['commonDosageMin'] as num?)?.toDouble(),
      commonDosageMax: (jsonSerialization['commonDosageMax'] as num?)?.toDouble(),
      dosageWarning: (jsonSerialization['dosageWarning'] as num?)?.toDouble(),
      toxicity: jsonSerialization['toxicity'] as String?,
      pregnancyCategory: jsonSerialization['pregnancyCategory'] as String?,
      isSpecialManagement: jsonSerialization['isSpecialManagement'] == null
          ? null
          : _is.BoolJsonExtension.fromJson(jsonSerialization['isSpecialManagement']),
      storageRequirements: jsonSerialization['storageRequirements'] as String?,
      shelfLifeMonths: jsonSerialization['shelfLifeMonths'] as int?,
      description: jsonSerialization['description'] as String?,
      status: jsonSerialization['status'] as int?,
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

  static final t = ZhongyiMedicineTable();

  static const db = ZhongyiMedicineRepository._();

  @override
  int? id;

  int tenantId;

  String medicineCode;

  String? prefix;

  String name;

  String? pinyin;

  String? category;

  String? subcategory;

  String? originPlace;

  String? propertiesJson;

  String? functions;

  String? indications;

  double? commonDosageMin;

  double? commonDosageMax;

  double? dosageWarning;

  String? toxicity;

  String? pregnancyCategory;

  bool isSpecialManagement;

  String? storageRequirements;

  int? shelfLifeMonths;

  String? description;

  int status;

  bool deleted;

  String? creator;

  DateTime createTime;

  String? updater;

  DateTime updateTime;

  @override
  _is.Table<int?> get table => t;

  /// Returns a shallow copy of this [ZhongyiMedicine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  ZhongyiMedicine copyWith({
    int? id,
    int? tenantId,
    String? medicineCode,
    String? prefix,
    String? name,
    String? pinyin,
    String? category,
    String? subcategory,
    String? originPlace,
    String? propertiesJson,
    String? functions,
    String? indications,
    double? commonDosageMin,
    double? commonDosageMax,
    double? dosageWarning,
    String? toxicity,
    String? pregnancyCategory,
    bool? isSpecialManagement,
    String? storageRequirements,
    int? shelfLifeMonths,
    String? description,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ZhongyiMedicine',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'medicineCode': medicineCode,
      if (prefix != null) 'prefix': prefix,
      'name': name,
      if (pinyin != null) 'pinyin': pinyin,
      if (category != null) 'category': category,
      if (subcategory != null) 'subcategory': subcategory,
      if (originPlace != null) 'originPlace': originPlace,
      if (propertiesJson != null) 'propertiesJson': propertiesJson,
      if (functions != null) 'functions': functions,
      if (indications != null) 'indications': indications,
      if (commonDosageMin != null) 'commonDosageMin': commonDosageMin,
      if (commonDosageMax != null) 'commonDosageMax': commonDosageMax,
      if (dosageWarning != null) 'dosageWarning': dosageWarning,
      if (toxicity != null) 'toxicity': toxicity,
      if (pregnancyCategory != null) 'pregnancyCategory': pregnancyCategory,
      'isSpecialManagement': isSpecialManagement,
      if (storageRequirements != null) 'storageRequirements': storageRequirements,
      if (shelfLifeMonths != null) 'shelfLifeMonths': shelfLifeMonths,
      if (description != null) 'description': description,
      'status': status,
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
      '__className__': 'ZhongyiMedicine',
      if (id != null) 'id': id,
      'tenantId': tenantId,
      'medicineCode': medicineCode,
      if (prefix != null) 'prefix': prefix,
      'name': name,
      if (pinyin != null) 'pinyin': pinyin,
      if (category != null) 'category': category,
      if (subcategory != null) 'subcategory': subcategory,
      if (originPlace != null) 'originPlace': originPlace,
      if (propertiesJson != null) 'propertiesJson': propertiesJson,
      if (functions != null) 'functions': functions,
      if (indications != null) 'indications': indications,
      if (commonDosageMin != null) 'commonDosageMin': commonDosageMin,
      if (commonDosageMax != null) 'commonDosageMax': commonDosageMax,
      if (dosageWarning != null) 'dosageWarning': dosageWarning,
      if (toxicity != null) 'toxicity': toxicity,
      if (pregnancyCategory != null) 'pregnancyCategory': pregnancyCategory,
      'isSpecialManagement': isSpecialManagement,
      if (storageRequirements != null) 'storageRequirements': storageRequirements,
      if (shelfLifeMonths != null) 'shelfLifeMonths': shelfLifeMonths,
      if (description != null) 'description': description,
      'status': status,
      'deleted': deleted,
      if (creator != null) 'creator': creator,
      'createTime': createTime.toJson(),
      if (updater != null) 'updater': updater,
      'updateTime': updateTime.toJson(),
    };
  }

  static ZhongyiMedicineInclude include() {
    return ZhongyiMedicineInclude._();
  }

  static ZhongyiMedicineIncludeList includeList({
    _is.WhereExpressionBuilder<ZhongyiMedicineTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiMedicineTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicineTable>? orderByList,
    ZhongyiMedicineInclude? include,
  }) {
    return ZhongyiMedicineIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiMedicine.t),
      orderByList: orderByList?.call(ZhongyiMedicine.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _is.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ZhongyiMedicineImpl extends ZhongyiMedicine {
  _ZhongyiMedicineImpl({
    int? id,
    int? tenantId,
    required String medicineCode,
    String? prefix,
    required String name,
    String? pinyin,
    String? category,
    String? subcategory,
    String? originPlace,
    String? propertiesJson,
    String? functions,
    String? indications,
    double? commonDosageMin,
    double? commonDosageMax,
    double? dosageWarning,
    String? toxicity,
    String? pregnancyCategory,
    bool? isSpecialManagement,
    String? storageRequirements,
    int? shelfLifeMonths,
    String? description,
    int? status,
    bool? deleted,
    String? creator,
    DateTime? createTime,
    String? updater,
    DateTime? updateTime,
  }) : super._(
         id: id,
         tenantId: tenantId,
         medicineCode: medicineCode,
         prefix: prefix,
         name: name,
         pinyin: pinyin,
         category: category,
         subcategory: subcategory,
         originPlace: originPlace,
         propertiesJson: propertiesJson,
         functions: functions,
         indications: indications,
         commonDosageMin: commonDosageMin,
         commonDosageMax: commonDosageMax,
         dosageWarning: dosageWarning,
         toxicity: toxicity,
         pregnancyCategory: pregnancyCategory,
         isSpecialManagement: isSpecialManagement,
         storageRequirements: storageRequirements,
         shelfLifeMonths: shelfLifeMonths,
         description: description,
         status: status,
         deleted: deleted,
         creator: creator,
         createTime: createTime,
         updater: updater,
         updateTime: updateTime,
       );

  /// Returns a shallow copy of this [ZhongyiMedicine]
  /// with some or all fields replaced by the given arguments.
  @_is.useResult
  @override
  ZhongyiMedicine copyWith({
    Object? id = _Undefined,
    int? tenantId,
    String? medicineCode,
    Object? prefix = _Undefined,
    String? name,
    Object? pinyin = _Undefined,
    Object? category = _Undefined,
    Object? subcategory = _Undefined,
    Object? originPlace = _Undefined,
    Object? propertiesJson = _Undefined,
    Object? functions = _Undefined,
    Object? indications = _Undefined,
    Object? commonDosageMin = _Undefined,
    Object? commonDosageMax = _Undefined,
    Object? dosageWarning = _Undefined,
    Object? toxicity = _Undefined,
    Object? pregnancyCategory = _Undefined,
    bool? isSpecialManagement,
    Object? storageRequirements = _Undefined,
    Object? shelfLifeMonths = _Undefined,
    Object? description = _Undefined,
    int? status,
    bool? deleted,
    Object? creator = _Undefined,
    DateTime? createTime,
    Object? updater = _Undefined,
    DateTime? updateTime,
  }) {
    return ZhongyiMedicine(
      id: id is int? ? id : this.id,
      tenantId: tenantId ?? this.tenantId,
      medicineCode: medicineCode ?? this.medicineCode,
      prefix: prefix is String? ? prefix : this.prefix,
      name: name ?? this.name,
      pinyin: pinyin is String? ? pinyin : this.pinyin,
      category: category is String? ? category : this.category,
      subcategory: subcategory is String? ? subcategory : this.subcategory,
      originPlace: originPlace is String? ? originPlace : this.originPlace,
      propertiesJson: propertiesJson is String? ? propertiesJson : this.propertiesJson,
      functions: functions is String? ? functions : this.functions,
      indications: indications is String? ? indications : this.indications,
      commonDosageMin: commonDosageMin is double? ? commonDosageMin : this.commonDosageMin,
      commonDosageMax: commonDosageMax is double? ? commonDosageMax : this.commonDosageMax,
      dosageWarning: dosageWarning is double? ? dosageWarning : this.dosageWarning,
      toxicity: toxicity is String? ? toxicity : this.toxicity,
      pregnancyCategory: pregnancyCategory is String? ? pregnancyCategory : this.pregnancyCategory,
      isSpecialManagement: isSpecialManagement ?? this.isSpecialManagement,
      storageRequirements: storageRequirements is String? ? storageRequirements : this.storageRequirements,
      shelfLifeMonths: shelfLifeMonths is int? ? shelfLifeMonths : this.shelfLifeMonths,
      description: description is String? ? description : this.description,
      status: status ?? this.status,
      deleted: deleted ?? this.deleted,
      creator: creator is String? ? creator : this.creator,
      createTime: createTime ?? this.createTime,
      updater: updater is String? ? updater : this.updater,
      updateTime: updateTime ?? this.updateTime,
    );
  }
}

class ZhongyiMedicineUpdateTable extends _is.UpdateTable<ZhongyiMedicineTable> {
  ZhongyiMedicineUpdateTable(super.table);

  _is.ColumnValue<int, int> tenantId(int value) => _is.ColumnValue(table.tenantId, value);

  _is.ColumnValue<String, String> medicineCode(String value) => _is.ColumnValue(table.medicineCode, value);

  _is.ColumnValue<String, String> prefix(String? value) => _is.ColumnValue(table.prefix, value);

  _is.ColumnValue<String, String> name(String value) => _is.ColumnValue(table.name, value);

  _is.ColumnValue<String, String> pinyin(String? value) => _is.ColumnValue(table.pinyin, value);

  _is.ColumnValue<String, String> category(String? value) => _is.ColumnValue(table.category, value);

  _is.ColumnValue<String, String> subcategory(String? value) => _is.ColumnValue(table.subcategory, value);

  _is.ColumnValue<String, String> originPlace(String? value) => _is.ColumnValue(table.originPlace, value);

  _is.ColumnValue<String, String> propertiesJson(String? value) => _is.ColumnValue(table.propertiesJson, value);

  _is.ColumnValue<String, String> functions(String? value) => _is.ColumnValue(table.functions, value);

  _is.ColumnValue<String, String> indications(String? value) => _is.ColumnValue(table.indications, value);

  _is.ColumnValue<double, double> commonDosageMin(double? value) => _is.ColumnValue(table.commonDosageMin, value);

  _is.ColumnValue<double, double> commonDosageMax(double? value) => _is.ColumnValue(table.commonDosageMax, value);

  _is.ColumnValue<double, double> dosageWarning(double? value) => _is.ColumnValue(table.dosageWarning, value);

  _is.ColumnValue<String, String> toxicity(String? value) => _is.ColumnValue(table.toxicity, value);

  _is.ColumnValue<String, String> pregnancyCategory(String? value) => _is.ColumnValue(table.pregnancyCategory, value);

  _is.ColumnValue<bool, bool> isSpecialManagement(bool value) => _is.ColumnValue(table.isSpecialManagement, value);

  _is.ColumnValue<String, String> storageRequirements(String? value) =>
      _is.ColumnValue(table.storageRequirements, value);

  _is.ColumnValue<int, int> shelfLifeMonths(int? value) => _is.ColumnValue(table.shelfLifeMonths, value);

  _is.ColumnValue<String, String> description(String? value) => _is.ColumnValue(table.description, value);

  _is.ColumnValue<int, int> status(int value) => _is.ColumnValue(table.status, value);

  _is.ColumnValue<bool, bool> deleted(bool value) => _is.ColumnValue(table.deleted, value);

  _is.ColumnValue<String, String> creator(String? value) => _is.ColumnValue(table.creator, value);

  _is.ColumnValue<DateTime, DateTime> createTime(DateTime value) => _is.ColumnValue(table.createTime, value);

  _is.ColumnValue<String, String> updater(String? value) => _is.ColumnValue(table.updater, value);

  _is.ColumnValue<DateTime, DateTime> updateTime(DateTime value) => _is.ColumnValue(table.updateTime, value);
}

class ZhongyiMedicineTable extends _is.Table<int?> {
  ZhongyiMedicineTable({super.tableRelation}) : super(tableName: 'zhongyi_medicine') {
    updateTable = ZhongyiMedicineUpdateTable(this);
    tenantId = _is.ColumnInt('tenantId', this, hasDefault: true);
    medicineCode = _is.ColumnString('medicineCode', this);
    prefix = _is.ColumnString('prefix', this);
    name = _is.ColumnString('name', this);
    pinyin = _is.ColumnString('pinyin', this);
    category = _is.ColumnString('category', this);
    subcategory = _is.ColumnString('subcategory', this);
    originPlace = _is.ColumnString('originPlace', this);
    propertiesJson = _is.ColumnString('propertiesJson', this);
    functions = _is.ColumnString('functions', this);
    indications = _is.ColumnString('indications', this);
    commonDosageMin = _is.ColumnDouble('commonDosageMin', this);
    commonDosageMax = _is.ColumnDouble('commonDosageMax', this);
    dosageWarning = _is.ColumnDouble('dosageWarning', this);
    toxicity = _is.ColumnString('toxicity', this);
    pregnancyCategory = _is.ColumnString('pregnancyCategory', this);
    isSpecialManagement = _is.ColumnBool('isSpecialManagement', this, hasDefault: true);
    storageRequirements = _is.ColumnString('storageRequirements', this);
    shelfLifeMonths = _is.ColumnInt('shelfLifeMonths', this);
    description = _is.ColumnString('description', this);
    status = _is.ColumnInt('status', this, hasDefault: true);
    deleted = _is.ColumnBool('deleted', this, hasDefault: true);
    creator = _is.ColumnString('creator', this);
    createTime = _is.ColumnDateTime('createTime', this, hasDefault: true);
    updater = _is.ColumnString('updater', this);
    updateTime = _is.ColumnDateTime('updateTime', this, hasDefault: true);
  }

  late final ZhongyiMedicineUpdateTable updateTable;

  late final _is.ColumnInt tenantId;

  late final _is.ColumnString medicineCode;

  late final _is.ColumnString prefix;

  late final _is.ColumnString name;

  late final _is.ColumnString pinyin;

  late final _is.ColumnString category;

  late final _is.ColumnString subcategory;

  late final _is.ColumnString originPlace;

  late final _is.ColumnString propertiesJson;

  late final _is.ColumnString functions;

  late final _is.ColumnString indications;

  late final _is.ColumnDouble commonDosageMin;

  late final _is.ColumnDouble commonDosageMax;

  late final _is.ColumnDouble dosageWarning;

  late final _is.ColumnString toxicity;

  late final _is.ColumnString pregnancyCategory;

  late final _is.ColumnBool isSpecialManagement;

  late final _is.ColumnString storageRequirements;

  late final _is.ColumnInt shelfLifeMonths;

  late final _is.ColumnString description;

  late final _is.ColumnInt status;

  late final _is.ColumnBool deleted;

  late final _is.ColumnString creator;

  late final _is.ColumnDateTime createTime;

  late final _is.ColumnString updater;

  late final _is.ColumnDateTime updateTime;

  @override
  List<_is.Column> get columns => [
    id,
    tenantId,
    medicineCode,
    prefix,
    name,
    pinyin,
    category,
    subcategory,
    originPlace,
    propertiesJson,
    functions,
    indications,
    commonDosageMin,
    commonDosageMax,
    dosageWarning,
    toxicity,
    pregnancyCategory,
    isSpecialManagement,
    storageRequirements,
    shelfLifeMonths,
    description,
    status,
    deleted,
    creator,
    createTime,
    updater,
    updateTime,
  ];
}

class ZhongyiMedicineInclude extends _is.IncludeObject {
  ZhongyiMedicineInclude._();

  @override
  Map<String, _is.Include?> get includes => {};

  @override
  _is.Table<int?> get table => ZhongyiMedicine.t;
}

class ZhongyiMedicineIncludeList extends _is.IncludeList {
  ZhongyiMedicineIncludeList._({
    _is.WhereExpressionBuilder<ZhongyiMedicineTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(ZhongyiMedicine.t);
  }

  @override
  Map<String, _is.Include?> get includes => include?.includes ?? {};

  @override
  _is.Table<int?> get table => ZhongyiMedicine.t;
}

class ZhongyiMedicineRepository {
  const ZhongyiMedicineRepository._();

  /// Returns a list of [ZhongyiMedicine]s matching the given query parameters.
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
  Future<List<ZhongyiMedicine>> find(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiMedicineTable>? where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiMedicineTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicineTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<ZhongyiMedicine>(
      where: where?.call(ZhongyiMedicine.t),
      orderBy: orderBy?.call(ZhongyiMedicine.t),
      orderByList: orderByList?.call(ZhongyiMedicine.t),
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [ZhongyiMedicine] matching the given query parameters.
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
  Future<ZhongyiMedicine?> findFirstRow(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiMedicineTable>? where,
    int? offset,
    _is.OrderByBuilder<ZhongyiMedicineTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicineTable>? orderByList,
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<ZhongyiMedicine>(
      where: where?.call(ZhongyiMedicine.t),
      orderBy: orderBy?.call(ZhongyiMedicine.t),
      orderByList: orderByList?.call(ZhongyiMedicine.t),
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [ZhongyiMedicine] by its [id] or null if no such row exists.
  Future<ZhongyiMedicine?> findById(
    _is.DatabaseSession session,
    int id, {
    _is.Transaction? transaction,
    _is.LockMode? lockMode,
    _is.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<ZhongyiMedicine>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [ZhongyiMedicine]s in the list and returns the inserted rows.
  ///
  /// The returned [ZhongyiMedicine]s will have their `id` fields set.
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
  Future<List<ZhongyiMedicine>> insert(
    _is.DatabaseSession session,
    List<ZhongyiMedicine> rows, {
    _is.Transaction? transaction,
    bool ignoreConflicts = false,
    bool noReturn = false,
  }) async {
    return session.db.insert<ZhongyiMedicine>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
      noReturn: noReturn,
    );
  }

  /// Inserts a single [ZhongyiMedicine] and returns the inserted row.
  ///
  /// The returned [ZhongyiMedicine] will have its `id` field set.
  Future<ZhongyiMedicine> insertRow(
    _is.DatabaseSession session,
    ZhongyiMedicine row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.insertRow<ZhongyiMedicine>(row, transaction: transaction);
  }

  /// Upserts all [ZhongyiMedicine]s in the list and returns the resulting rows.
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
  /// The returned [ZhongyiMedicine]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails,
  /// none of the rows will be affected.
  ///
  /// If [noReturn] is set to `true`, the resulting rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiMedicine>> upsert(
    _is.DatabaseSession session,
    List<ZhongyiMedicine> rows, {
    required _is.ColumnSelections<ZhongyiMedicineTable> conflictColumns,
    _is.ColumnSelections<ZhongyiMedicineTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiMedicineTable>? updateWhere,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.upsert<ZhongyiMedicine>(
      rows,
      conflictColumns: conflictColumns(ZhongyiMedicine.t),
      updateColumns: updateColumns?.call(ZhongyiMedicine.t),
      updateWhere: updateWhere?.call(ZhongyiMedicine.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Upserts a single [ZhongyiMedicine] and returns the resulting row.
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
  /// The returned [ZhongyiMedicine] will have its `id` field set.
  Future<ZhongyiMedicine?> upsertRow(
    _is.DatabaseSession session,
    ZhongyiMedicine row, {
    required _is.ColumnSelections<ZhongyiMedicineTable> conflictColumns,
    _is.ColumnSelections<ZhongyiMedicineTable>? updateColumns,
    _is.WhereExpressionBuilder<ZhongyiMedicineTable>? updateWhere,
    _is.Transaction? transaction,
  }) async {
    return session.db.upsertRow<ZhongyiMedicine>(
      row,
      conflictColumns: conflictColumns(ZhongyiMedicine.t),
      updateColumns: updateColumns?.call(ZhongyiMedicine.t),
      updateWhere: updateWhere?.call(ZhongyiMedicine.t),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiMedicine]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiMedicine>> update(
    _is.DatabaseSession session,
    List<ZhongyiMedicine> rows, {
    _is.ColumnSelections<ZhongyiMedicineTable>? columns,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.update<ZhongyiMedicine>(
      rows,
      columns: columns?.call(ZhongyiMedicine.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Updates a single [ZhongyiMedicine]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<ZhongyiMedicine> updateRow(
    _is.DatabaseSession session,
    ZhongyiMedicine row, {
    _is.ColumnSelections<ZhongyiMedicineTable>? columns,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateRow<ZhongyiMedicine>(
      row,
      columns: columns?.call(ZhongyiMedicine.t),
      transaction: transaction,
    );
  }

  /// Updates a single [ZhongyiMedicine] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<ZhongyiMedicine?> updateById(
    _is.DatabaseSession session,
    int id, {
    required _is.ColumnValueListBuilder<ZhongyiMedicineUpdateTable> columnValues,
    _is.Transaction? transaction,
  }) async {
    return session.db.updateById<ZhongyiMedicine>(
      id,
      columnValues: columnValues(ZhongyiMedicine.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [ZhongyiMedicine]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  ///
  /// If [noReturn] is set to `true`, the updated rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiMedicine>> updateWhere(
    _is.DatabaseSession session, {
    required _is.ColumnValueListBuilder<ZhongyiMedicineUpdateTable> columnValues,
    required _is.WhereExpressionBuilder<ZhongyiMedicineTable> where,
    int? limit,
    int? offset,
    _is.OrderByBuilder<ZhongyiMedicineTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicineTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.updateWhere<ZhongyiMedicine>(
      columnValues: columnValues(ZhongyiMedicine.t.updateTable),
      where: where(ZhongyiMedicine.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(ZhongyiMedicine.t),
      orderByList: orderByList?.call(ZhongyiMedicine.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes all [ZhongyiMedicine]s in the list and returns the deleted rows.
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
  Future<List<ZhongyiMedicine>> delete(
    _is.DatabaseSession session,
    List<ZhongyiMedicine> rows, {
    _is.OrderByBuilder<ZhongyiMedicineTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicineTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.delete<ZhongyiMedicine>(
      rows,
      orderBy: orderBy?.call(ZhongyiMedicine.t),
      orderByList: orderByList?.call(ZhongyiMedicine.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Deletes a single [ZhongyiMedicine].
  Future<ZhongyiMedicine> deleteRow(
    _is.DatabaseSession session,
    ZhongyiMedicine row, {
    _is.Transaction? transaction,
  }) async {
    return session.db.deleteRow<ZhongyiMedicine>(row, transaction: transaction);
  }

  /// Deletes all rows matching the [where] expression.
  ///
  /// To specify the order of the returned rows use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// If [noReturn] is set to `true`, the deleted rows are not read back from
  /// the database and an empty list is returned. This avoids the overhead of
  /// transferring and deserializing the rows when the result is not needed.
  Future<List<ZhongyiMedicine>> deleteWhere(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiMedicineTable> where,
    _is.OrderByBuilder<ZhongyiMedicineTable>? orderBy,
    _is.OrderByListBuilder<ZhongyiMedicineTable>? orderByList,
    _is.Transaction? transaction,
    bool noReturn = false,
  }) async {
    return session.db.deleteWhere<ZhongyiMedicine>(
      where: where(ZhongyiMedicine.t),
      orderBy: orderBy?.call(ZhongyiMedicine.t),
      orderByList: orderByList?.call(ZhongyiMedicine.t),
      transaction: transaction,
      noReturn: noReturn,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _is.DatabaseSession session, {
    _is.WhereExpressionBuilder<ZhongyiMedicineTable>? where,
    int? limit,
    _is.Transaction? transaction,
  }) async {
    return session.db.count<ZhongyiMedicine>(
      where: where?.call(ZhongyiMedicine.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [ZhongyiMedicine] rows matching the [where] expression.
  Future<void> lockRows(
    _is.DatabaseSession session, {
    required _is.WhereExpressionBuilder<ZhongyiMedicineTable> where,
    required _is.LockMode lockMode,
    required _is.Transaction transaction,
    _is.LockBehavior lockBehavior = _is.LockBehavior.wait,
  }) async {
    return session.db.lockRows<ZhongyiMedicine>(
      where: where(ZhongyiMedicine.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
