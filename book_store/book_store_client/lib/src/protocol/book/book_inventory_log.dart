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

/// 用于记录每本书库存变动的详细信息，便于审计和管理
abstract class InventoryLog implements _i1.SerializableModel {
  InventoryLog._({
    this.id,
    required this.bookId,
    required this.quantity,
    required this.changeType,
    required this.changeTime,
    this.description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  })  : createTime = createTime ?? DateTime.now(),
        updateTime = updateTime ?? DateTime.now(),
        isDeleted = isDeleted ?? false;

  factory InventoryLog({
    int? id,
    required int bookId,
    required int quantity,
    required int changeType,
    required DateTime changeTime,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) = _InventoryLogImpl;

  factory InventoryLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return InventoryLog(
      id: jsonSerialization['id'] as int?,
      bookId: jsonSerialization['bookId'] as int,
      quantity: jsonSerialization['quantity'] as int,
      changeType: jsonSerialization['changeType'] as int,
      changeTime:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['changeTime']),
      description: jsonSerialization['description'] as String?,
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

  /// 图书ID，用于标识是哪本书
  int bookId;

  /// 变动数量，可以为正（增加库存）或负（减少库存）
  int quantity;

  /// 变动类型，0=进货，1=售出，2=退货，3=损耗，4=库存调整
  int changeType;

  /// 变动发生的时间
  DateTime changeTime;

  /// 变动的原因或描述，提供额外的说明
  String? description;

  /// 记录创建时间
  DateTime createTime;

  /// 记录最后更新时间
  DateTime updateTime;

  /// 是否删除
  bool isDeleted;

  InventoryLog copyWith({
    int? id,
    int? bookId,
    int? quantity,
    int? changeType,
    DateTime? changeTime,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'bookId': bookId,
      'quantity': quantity,
      'changeType': changeType,
      'changeTime': changeTime.toJson(),
      if (description != null) 'description': description,
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

class _InventoryLogImpl extends InventoryLog {
  _InventoryLogImpl({
    int? id,
    required int bookId,
    required int quantity,
    required int changeType,
    required DateTime changeTime,
    String? description,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) : super._(
          id: id,
          bookId: bookId,
          quantity: quantity,
          changeType: changeType,
          changeTime: changeTime,
          description: description,
          createTime: createTime,
          updateTime: updateTime,
          isDeleted: isDeleted,
        );

  @override
  InventoryLog copyWith({
    Object? id = _Undefined,
    int? bookId,
    int? quantity,
    int? changeType,
    DateTime? changeTime,
    Object? description = _Undefined,
    DateTime? createTime,
    DateTime? updateTime,
    bool? isDeleted,
  }) {
    return InventoryLog(
      id: id is int? ? id : this.id,
      bookId: bookId ?? this.bookId,
      quantity: quantity ?? this.quantity,
      changeType: changeType ?? this.changeType,
      changeTime: changeTime ?? this.changeTime,
      description: description is String? ? description : this.description,
      createTime: createTime ?? this.createTime,
      updateTime: updateTime ?? this.updateTime,
      isDeleted: isDeleted ?? this.isDeleted,
    );
  }
}
