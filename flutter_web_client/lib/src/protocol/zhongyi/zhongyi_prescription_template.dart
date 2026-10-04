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

/// 中医门诊处方模板
abstract class ZhongyiPrescriptionTemplate implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isActive']),
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

  /// Returns a shallow copy of this [ZhongyiPrescriptionTemplate]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
