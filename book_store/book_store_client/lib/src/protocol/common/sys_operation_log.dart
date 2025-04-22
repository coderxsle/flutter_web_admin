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

/// 用于记录系统中的数据操作日志
abstract class SysOperationLog implements _i1.SerializableModel {
  SysOperationLog._({
    this.id,
    String? tableNameStr,
    int? operationType,
    this.recordId,
    String? oldData,
    String? newData,
    int? operatorId,
    DateTime? operationTime,
  })  : tableNameStr = tableNameStr ?? '',
        operationType = operationType ?? 0,
        oldData = oldData ?? '',
        newData = newData ?? '',
        operatorId = operatorId ?? 0,
        operationTime = operationTime ?? DateTime.now();

  factory SysOperationLog({
    int? id,
    String? tableNameStr,
    int? operationType,
    int? recordId,
    String? oldData,
    String? newData,
    int? operatorId,
    DateTime? operationTime,
  }) = _SysOperationLogImpl;

  factory SysOperationLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return SysOperationLog(
      id: jsonSerialization['id'] as int?,
      tableNameStr: jsonSerialization['tableNameStr'] as String,
      operationType: jsonSerialization['operationType'] as int,
      recordId: jsonSerialization['recordId'] as int?,
      oldData: jsonSerialization['oldData'] as String,
      newData: jsonSerialization['newData'] as String,
      operatorId: jsonSerialization['operatorId'] as int,
      operationTime: _i1.DateTimeJsonExtension.fromJson(
          jsonSerialization['operationTime']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  /// 被操作的表名（默认空字符串）
  String tableNameStr;

  /// 表示操作类型（1插入、2删除、3更新）
  int operationType;

  /// 被操作的记录的唯一标识符（通常是该表的主键）
  int? recordId;

  /// 在更新或删除时，记录被修改前的旧数据，使用 JSON 格式存储
  String oldData;

  /// 在更新或插入时，记录被修改后的新数据，使用 JSON 格式存储
  String newData;

  /// 记录执行操作的用户，可以是用户名或用户的 ID
  int operatorId;

  /// 记录操作发生的时间，默认为当前时间
  DateTime operationTime;

  /// Returns a shallow copy of this [SysOperationLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SysOperationLog copyWith({
    int? id,
    String? tableNameStr,
    int? operationType,
    int? recordId,
    String? oldData,
    String? newData,
    int? operatorId,
    DateTime? operationTime,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'tableNameStr': tableNameStr,
      'operationType': operationType,
      if (recordId != null) 'recordId': recordId,
      'oldData': oldData,
      'newData': newData,
      'operatorId': operatorId,
      'operationTime': operationTime.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SysOperationLogImpl extends SysOperationLog {
  _SysOperationLogImpl({
    int? id,
    String? tableNameStr,
    int? operationType,
    int? recordId,
    String? oldData,
    String? newData,
    int? operatorId,
    DateTime? operationTime,
  }) : super._(
          id: id,
          tableNameStr: tableNameStr,
          operationType: operationType,
          recordId: recordId,
          oldData: oldData,
          newData: newData,
          operatorId: operatorId,
          operationTime: operationTime,
        );

  /// Returns a shallow copy of this [SysOperationLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SysOperationLog copyWith({
    Object? id = _Undefined,
    String? tableNameStr,
    int? operationType,
    Object? recordId = _Undefined,
    String? oldData,
    String? newData,
    int? operatorId,
    DateTime? operationTime,
  }) {
    return SysOperationLog(
      id: id is int? ? id : this.id,
      tableNameStr: tableNameStr ?? this.tableNameStr,
      operationType: operationType ?? this.operationType,
      recordId: recordId is int? ? recordId : this.recordId,
      oldData: oldData ?? this.oldData,
      newData: newData ?? this.newData,
      operatorId: operatorId ?? this.operatorId,
      operationTime: operationTime ?? this.operationTime,
    );
  }
}
