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

/// 中医门诊处方模板明细
abstract class ZhongyiPrescriptionTemplateItem implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isSubstitute']),
      substituteForId: jsonSerialization['substituteForId'] as int?,
      notes: jsonSerialization['notes'] as String?,
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

  /// Returns a shallow copy of this [ZhongyiPrescriptionTemplateItem]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
