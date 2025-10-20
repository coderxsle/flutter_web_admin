import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 虚拟滚动控制器
class VirtualScrollController extends GetxController {
  /// 滚动控制器
  final ScrollController scrollController = ScrollController();
  
  /// 项目高度
  final double itemHeight;
  
  /// 缓冲区项目数量
  final int bufferItemCount;
  
  /// 总项目数量
  final RxInt _totalItemCount = 0.obs;
  
  /// 可见区域的起始索引
  final RxInt _firstVisibleIndex = 0.obs;
  
  /// 可见区域的结束索引
  final RxInt _lastVisibleIndex = 0.obs;
  
  /// 视口高度
  final RxDouble _viewportHeight = 0.0.obs;

  VirtualScrollController({
    required this.itemHeight,
    this.bufferItemCount = 5,
  }) {
    scrollController.addListener(_onScroll);
  }

  /// 获取总项目数量
  int get totalItemCount => _totalItemCount.value;
  
  /// 获取第一个可见项索引
  int get firstVisibleIndex => _firstVisibleIndex.value;
  
  /// 获取最后一个可见项索引
  int get lastVisibleIndex => _lastVisibleIndex.value;
  
  /// 获取视口高度
  double get viewportHeight => _viewportHeight.value;
  
  /// 获取总高度
  double get totalHeight => totalItemCount * itemHeight;
  
  /// 获取渲染起始索引（包含缓冲区）
  int get renderStartIndex => 
      (firstVisibleIndex - bufferItemCount).clamp(0, totalItemCount);
  
  /// 获取渲染结束索引（包含缓冲区）
  int get renderEndIndex => 
      (lastVisibleIndex + bufferItemCount).clamp(0, totalItemCount);
  
  /// 获取可见项数量
  int get visibleItemCount => 
      (viewportHeight / itemHeight).ceil() + 1;

  /// 设置总项目数量
  void setTotalItemCount(int count) {
    _totalItemCount.value = count;
    _updateVisibleRange();
  }

  /// 设置视口高度
  void setViewportHeight(double height) {
    _viewportHeight.value = height;
    _updateVisibleRange();
  }

  /// 滚动到指定索引
  void scrollToIndex(int index, {bool animate = true}) {
    final offset = index * itemHeight;
    if (animate) {
      scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      scrollController.jumpTo(offset);
    }
  }

  /// 滚动监听
  void _onScroll() {
    _updateVisibleRange();
  }

  /// 更新可见范围
  void _updateVisibleRange() {
    if (itemHeight <= 0 || viewportHeight <= 0) return;
    
    final scrollOffset = scrollController.hasClients 
        ? scrollController.offset 
        : 0.0;
    
    _firstVisibleIndex.value = (scrollOffset / itemHeight).floor();
    _lastVisibleIndex.value = 
        ((scrollOffset + viewportHeight) / itemHeight).ceil()
            .clamp(0, totalItemCount);
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

