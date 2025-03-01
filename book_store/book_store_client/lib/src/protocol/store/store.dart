/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

/// 店铺基本信息表，用于存储店铺的基本信息
abstract class Store implements _i1.SerializableModel {
  Store._({
    this.id,
    required this.name,
    this.logo,
    this.address,
    this.contact,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory Store({
    int? id,
    required String name,
    String? logo,
    String? address,
    String? contact,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _StoreImpl;

  factory Store.fromJson(Map<String, dynamic> jsonSerialization) {
    return Store(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      logo: jsonSerialization['logo'] as String?,
      address: jsonSerialization['address'] as String?,
      contact: jsonSerialization['contact'] as String?,
      createTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createTime']),
      updateTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updateTime']),
      isDeleted: jsonSerialization['isDeleted'] as bool,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// 店铺的名称（必填）
  String name;

  /// 店铺的logo
  String? logo;

  /// 店铺的地址
  String? address;

  /// 店铺的联系方式
  String? contact;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否已删除（默认值：false）
  bool isDeleted;

  Store copyWith({
    int? id,
    String? name,
    String? logo,
    String? address,
    String? contact,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      if (logo != null) 'logo': logo,
      if (address != null) 'address': address,
      if (contact != null) 'contact': contact,
      'createTime': createTime.toJson(),
      'updateTime': updateTime.toJson(),
      'isDeleted': isDeleted,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StoreImpl extends Store {
  _StoreImpl({
    int? id,
    required String name,
    String? logo,
    String? address,
    String? contact,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          name: name,
          logo: logo,
          address: address,
          contact: contact,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  @override
  Store copyWith({
    Object? id = _Undefined,
    String? name,
    Object? logo = _Undefined,
    Object? address = _Undefined,
    Object? contact = _Undefined,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return Store(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      logo: logo is String? ? logo : this.logo,
      address: address is String? ? address : this.address,
      contact: contact is String? ? contact : this.contact,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
