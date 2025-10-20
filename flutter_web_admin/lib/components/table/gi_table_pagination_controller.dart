import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// GiTable 分页控制器
/// 用于管理 GiTable 的分页状态
class GiTablePaginationController extends ChangeNotifier {
  /// 当前页码
  int _current = 1;
  
  /// 每页条数
  int _pageSize;
  
  /// 总数据量
  int _total = 0;

  GiTablePaginationController({
    int pageSize = 10,
  }) : _pageSize = pageSize;

  /// 当前页码
  int get current => _current;
  
  /// 每页条数
  int get pageSize => _pageSize;
  
  /// 总数据量
  int get total => _total;
  
  /// 总页数
  int get totalPages => (_total / _pageSize).ceil();

  /// 设置总数据量
  void setTotal(int total) {
    if (_total != total) {
      _total = total;
      // 如果当前页超出范围，调整到最后一页
      if (_current > totalPages && totalPages > 0) {
        _current = totalPages;
      }
      notifyListeners();
    }
  }

  /// 页码变化
  void onPageChange(int page) {
    if (page >= 1 && page <= totalPages && page != _current) {
      _current = page;
      notifyListeners();
    }
  }

  /// 每页条数变化
  void onPageSizeChange(int pageSize) {
    if (pageSize != _pageSize) {
      _pageSize = pageSize;
      _current = 1; // 重置到第一页
      notifyListeners();
    }
  }

  /// 搜索（重置到第一页）
  void search() {
    if (_current != 1) {
      _current = 1;
      notifyListeners();
    }
  }

  /// 刷新（保持当前页）
  void refresh() {
    notifyListeners();
  }

  /// 重置所有状态
  void reset() {
    _current = 1;
    _total = 0;
    notifyListeners();
  }
}

