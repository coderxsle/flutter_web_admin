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

/// 中医门诊患者档案
abstract class ZhongyiPatient implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.DateTimeJsonExtension.fromJson(jsonSerialization['birthDate']),
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

  /// Returns a shallow copy of this [ZhongyiPatient]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
