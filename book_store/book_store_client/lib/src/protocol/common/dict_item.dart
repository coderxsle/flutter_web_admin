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

/// 用于存储数据字典的条目信息
abstract class DictItem implements _i1.SerializableModel {
  DictItem._({
    this.id,
    String? name,
    String? value,
    int? sn,
    int? disabled,
    int? typeId,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : name = name ?? '',
        value = value ?? '',
        sn = sn ?? 0,
        disabled = disabled ?? 0,
        typeId = typeId ?? 0,
        createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory DictItem({
    int? id,
    String? name,
    String? value,
    int? sn,
    int? disabled,
    int? typeId,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _DictItemImpl;

  factory DictItem.fromJson(Map<String, dynamic> jsonSerialization) {
    return DictItem(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      value: jsonSerialization['value'] as String,
      sn: jsonSerialization['sn'] as int,
      disabled: jsonSerialization['disabled'] as int,
      typeId: jsonSerialization['typeId'] as int,
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

  /// 名称（默认空字符串）
  String name;

  /// 值（默认空字符串）
  String value;

  /// 排列顺序，默认0。值越大，就排在越前面
  int sn;

  /// 是否禁用。0代表不禁用（启用），1代表禁用
  int disabled;

  /// 所属的类型
  int typeId;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  DictItem copyWith({
    int? id,
    String? name,
    String? value,
    int? sn,
    int? disabled,
    int? typeId,
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
      'sn': sn,
      'disabled': disabled,
      'typeId': typeId,
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

class _DictItemImpl extends DictItem {
  _DictItemImpl({
    int? id,
    String? name,
    String? value,
    int? sn,
    int? disabled,
    int? typeId,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          name: name,
          value: value,
          sn: sn,
          disabled: disabled,
          typeId: typeId,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  @override
  DictItem copyWith({
    Object? id = _Undefined,
    String? name,
    String? value,
    int? sn,
    int? disabled,
    int? typeId,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return DictItem(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      value: value ?? this.value,
      sn: sn ?? this.sn,
      disabled: disabled ?? this.disabled,
      typeId: typeId ?? this.typeId,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
