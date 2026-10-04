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

/// 中医门诊员工档案
abstract class ZhongyiStaff implements _isc.SerializableModel, _isc.ProtocolSerialization {
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
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isDoctor']),
      isPharmacist: jsonSerialization['isPharmacist'] == null
          ? null
          : _isc.BoolJsonExtension.fromJson(jsonSerialization['isPharmacist']),
      consultationFee: (jsonSerialization['consultationFee'] as num?)?.toDouble(),
      introduction: jsonSerialization['introduction'] as String?,
      description: jsonSerialization['description'] as String?,
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

  /// Returns a shallow copy of this [ZhongyiStaff]
  /// with some or all fields replaced by the given arguments.
  @_isc.useResult
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

  @override
  String toString() {
    return _isc.SerializationManager.encode(this);
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
  @_isc.useResult
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
