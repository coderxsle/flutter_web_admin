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

/// 用于存储数据字典的类型信息
abstract class DictType implements _i1.SerializableModel {
  DictType._({
    this.id,
    String? name,
    String? value,
    String? intro,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : name = name ?? '',
        value = value ?? '',
        intro = intro ?? '',
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory DictType({
    int? id,
    String? name,
    String? value,
    String? intro,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _DictTypeImpl;

  factory DictType.fromJson(Map<String, dynamic> jsonSerialization) {
    return DictType(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      value: jsonSerialization['value'] as String,
      intro: jsonSerialization['intro'] as String,
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

  /// 名称（默认空字符串，唯一约束）
  String name;

  /// 值（默认空字符串，唯一约束）
  String value;

  /// 简介（默认空字符串）
  String intro;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  DictType copyWith({
    int? id,
    String? name,
    String? value,
    String? intro,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'value': value,
      'intro': intro,
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

class _DictTypeImpl extends DictType {
  _DictTypeImpl({
    int? id,
    String? name,
    String? value,
    String? intro,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          name: name,
          value: value,
          intro: intro,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  @override
  DictType copyWith({
    Object? id = _Undefined,
    String? name,
    String? value,
    String? intro,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return DictType(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      intro: intro ?? this.intro,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
