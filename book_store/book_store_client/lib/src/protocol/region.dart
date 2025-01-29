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

/// 用于存储区域信息，如省市区等
abstract class Region implements _i1.SerializableModel {
  Region._({
    this.id,
    String? name,
    String? pinyin,
    int? parentId,
  })  : name = name ?? '',
        pinyin = pinyin ?? '',
        parentId = parentId ?? 0;

  factory Region({
    int? id,
    String? name,
    String? pinyin,
    int? parentId,
  }) = _RegionImpl;

  factory Region.fromJson(Map<String, dynamic> jsonSerialization) {
    return Region(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      pinyin: jsonSerialization['pinyin'] as String,
      parentId: jsonSerialization['parentId'] as int,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// 名称（默认空字符串）
  String name;

  /// 拼音（默认空字符串）
  String pinyin;

  /// 父级主键，无父级为 0
  int parentId;

  Region copyWith({
    int? id,
    String? name,
    String? pinyin,
    int? parentId,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'pinyin': pinyin,
      'parentId': parentId,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RegionImpl extends Region {
  _RegionImpl({
    int? id,
    String? name,
    String? pinyin,
    int? parentId,
  }) : super._(
          id: id,
          name: name,
          pinyin: pinyin,
          parentId: parentId,
        );

  @override
  Region copyWith({
    Object? id = _Undefined,
    String? name,
    String? pinyin,
    int? parentId,
  }) {
    return Region(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      pinyin: pinyin ?? this.pinyin,
      parentId: parentId ?? this.parentId,
    );
  }
}
