import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'virtual_scroll_controller.dart';

/// 虚拟列表视图
class VirtualListView extends StatefulWidget {
  /// 虚拟滚动控制器
  final VirtualScrollController controller;
  
  /// 项目数量
  final int itemCount;
  
  /// 项目构建器
  final Widget Function(BuildContext context, int index) itemBuilder;
  
  /// 是否启用虚拟滚动
  final bool enableVirtualScroll;

  const VirtualListView({
    super.key,
    required this.controller,
    required this.itemCount,
    required this.itemBuilder,
    this.enableVirtualScroll = true,
  });

  @override
  State<VirtualListView> createState() => _VirtualListViewState();
}

class _VirtualListViewState extends State<VirtualListView> {
  @override
  void initState() {
    super.initState();
    widget.controller.setTotalItemCount(widget.itemCount);
  }

  @override
  void didUpdateWidget(VirtualListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.itemCount != oldWidget.itemCount) {
      widget.controller.setTotalItemCount(widget.itemCount);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enableVirtualScroll) {
      // 不启用虚拟滚动时，使用普通 ListView
      return ListView.builder(
        controller: widget.controller.scrollController,
        itemCount: widget.itemCount,
        itemBuilder: widget.itemBuilder,
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // 设置视口高度
        WidgetsBinding.instance.addPostFrameCallback((_) {
          widget.controller.setViewportHeight(constraints.maxHeight);
        });

        return Obx(() {
          return CustomScrollView(
            controller: widget.controller.scrollController,
            slivers: [
              // 顶部占位
              if (widget.controller.renderStartIndex > 0)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: widget.controller.renderStartIndex * 
                           widget.controller.itemHeight,
                  ),
                ),
              
              // 可见项
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final actualIndex = 
                        widget.controller.renderStartIndex + index;
                    return SizedBox(
                      height: widget.controller.itemHeight,
                      child: widget.itemBuilder(context, actualIndex),
                    );
                  },
                  childCount: widget.controller.renderEndIndex - 
                             widget.controller.renderStartIndex,
                ),
              ),
              
              // 底部占位
              if (widget.controller.renderEndIndex < widget.itemCount)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: (widget.itemCount - 
                            widget.controller.renderEndIndex) * 
                           widget.controller.itemHeight,
                  ),
                ),
            ],
          );
        });
      },
    );
  }
}

