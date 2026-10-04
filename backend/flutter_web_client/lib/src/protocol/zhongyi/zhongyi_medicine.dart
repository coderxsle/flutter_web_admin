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
import 'package:serverpod_client/serverpod_client.dart' as _isc;

/// 中药品种主数据
abstract class ZhongyiMedicine implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isSpecialManagement']),
      storageRequirements: jsonSerialization['storageRequirements'] as String?,
      shelfLifeMonths: jsonSerialization['shelfLifeMonths'] as int?,
      description: jsonSerialization['description'] as String?,
      status: jsonSerialization['status'] as int?,
      deleted: jsonSerialization['deleted'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['deleted']),
      creator: jsonSerialization['creator'] as String?,
      createTime: jsonSerialization['createTime'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updater: jsonSerialization['updater'] as String?,
      updateTime: jsonSerialization['updateTime'] == null
          ? null
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
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

  /// Returns a shallow copy of this [ZhongyiMedicine]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
