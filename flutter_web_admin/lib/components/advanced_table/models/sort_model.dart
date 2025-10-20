/// 排序方向枚举
enum SortDirection {
  none,
  ascending,
  descending,
}

/// 排序模型
class SortModel {
  /// 列键
  final String columnKey;
  
  /// 排序方向
  final SortDirection direction;
  
  /// 自定义排序函数
  final int Function(dynamic a, dynamic b)? sorter;

  const SortModel({
    required this.columnKey,
    required this.direction,
    this.sorter,
  });

  /// 复制并修改
  SortModel copyWith({
    String? columnKey,
    SortDirection? direction,
    int Function(dynamic a, dynamic b)? sorter,
  }) {
    return SortModel(
      columnKey: columnKey ?? this.columnKey,
      direction: direction ?? this.direction,
      sorter: sorter ?? this.sorter,
    );
  }

  /// 切换排序方向
  SortModel toggleDirection() {
    SortDirection newDirection;
    switch (direction) {
      case SortDirection.none:
        newDirection = SortDirection.ascending;
        break;
      case SortDirection.ascending:
        newDirection = SortDirection.descending;
        break;
      case SortDirection.descending:
        newDirection = SortDirection.none;
        break;
    }
    return copyWith(direction: newDirection);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SortModel &&
        other.columnKey == columnKey &&
        other.direction == direction;
  }

  @override
  int get hashCode => columnKey.hashCode ^ direction.hashCode;
}

