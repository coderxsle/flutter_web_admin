import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../button/gi_arco_button.dart';
import 'package:flutter/foundation.dart' show debugPrint;

/// Arco Design 风格的分页组件
/// 100% 复刻 gi-demo 项目中 table/base 页面的分页组件
class GiPagination extends StatefulWidget {
  /// 当前页码（从1开始）
  final int current;
  
  /// 每页显示条数
  final int pageSize;
  
  /// 数据总数
  final int total;
  
  /// 是否显示每页条数选择器
  final bool showPageSize;
  
  /// 是否显示总数
  final bool showTotal;
  
  /// 是否使用简单模式（移动端）
  final bool simple;
  
  /// 每页条数选择项
  final List<int> pageSizeOptions;
  
  /// 页码变化回调
  final Function(int page)? onPageChange;
  
  /// 每页条数变化回调
  final Function(int pageSize)? onPageSizeChange;
  
  /// 是否禁用
  final bool disabled;

  const GiPagination({
    super.key,
    required this.current,
    required this.pageSize,
    required this.total,
    this.showPageSize = true,
    this.showTotal = true,
    this.simple = false,
    this.pageSizeOptions = const [10, 20, 50, 100],
    this.onPageChange,
    this.onPageSizeChange,
    this.disabled = false,
  });

  @override
  State<GiPagination> createState() => _GiPaginationState();
}

class _GiPaginationState extends State<GiPagination> {
  late TextEditingController _jumpController;
  final GlobalKey _pageSizeFieldKey = GlobalKey();
  OverlayEntry? _pageSizeOverlay;
  bool _isPageSizeOpen = false;
  
  @override
  void initState() {
    super.initState();
    _jumpController = TextEditingController();
    debugPrint('GiPagination.initState: current=${widget.current}, pageSize=${widget.pageSize}, total=${widget.total}');
  }
  
  @override
  void didUpdateWidget(GiPagination oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.current != widget.current || 
        oldWidget.pageSize != widget.pageSize || 
        oldWidget.total != widget.total) {
      debugPrint('GiPagination.didUpdateWidget: current ${oldWidget.current} -> ${widget.current}, pageSize ${oldWidget.pageSize} -> ${widget.pageSize}, total ${oldWidget.total} -> ${widget.total}');
    }
  }
  
  @override
  void dispose() {
    _removePageSizePopover();
    _jumpController.dispose();
    super.dispose();
  }

  /// 计算总页数
  int get totalPages => (widget.total / widget.pageSize).ceil();

  /// 构建总数显示
  Widget _buildTotalText() {
    if (!widget.showTotal || widget.simple) return const SizedBox.shrink();
    
    // final start = (widget.current - 1) * widget.pageSize + 1;
    // final end = (widget.current * widget.pageSize).clamp(0, widget.total);
    
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Text(
        // '共 ${widget.total} 条，第 $start-$end 条',
        '共 ${widget.total} 条',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  /// 构建每页条数选择器
  Widget _buildPageSizeSelector() {
    if (!widget.showPageSize || widget.simple) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(width: 8),
          GestureDetector(
            onTap: widget.disabled ? null : _togglePageSizePopover,
            child: Container(
              key: _pageSizeFieldKey,
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(6),
                color: Colors.white,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${widget.pageSize} 条/页',
                    style: TextStyle(fontSize: 14, color: widget.disabled ? Colors.grey[400] : Colors.black87),
                  ),
                  const SizedBox(width: 6),
                  Icon(_isPageSizeOpen ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, size: 16, color: Colors.grey[600]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 构建页码按钮
  Widget _buildPageButton({
    required String text,
    required bool isActive,
    required VoidCallback? onPressed,
    bool isEllipsis = false,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 2),
      child: isEllipsis
          ? Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            )
          : GiArcoButton(
              type: isActive ? GiArcoButtonType.primary : GiArcoButtonType.normal,
              status: GiArcoButtonStatus.normal,
              shape: GiArcoButtonShape.rect,
              size: GiArcoButtonSize.small,
              disabled: widget.disabled,
              onPressed: onPressed,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                ),
              ),
            ),
    );
  }

  /// 构建页码列表
  List<Widget> _buildPageNumbers() {
    final List<Widget> pages = [];
    
    if (totalPages <= 7) {
      // 总页数小于等于7页，全部显示
      for (int i = 1; i <= totalPages; i++) {
        pages.add(_buildPageButton(
          text: '$i',
          isActive: i == widget.current,
          onPressed: () => widget.onPageChange?.call(i),
        ));
      }
    } else {
      // 总页数大于7页，使用省略号
      pages.add(_buildPageButton(
        text: '1',
        isActive: widget.current == 1,
        onPressed: () => widget.onPageChange?.call(1),
      ));
      
      if (widget.current > 4) {
        pages.add(_buildPageButton(
          text: '...',
          isActive: false,
          onPressed: null,
          isEllipsis: true,
        ));
      }
      
      int start = (widget.current - 2).clamp(2, totalPages - 1);
      int end = (widget.current + 2).clamp(2, totalPages - 1);
      
      if (widget.current <= 4) {
        start = 2;
        end = 5.clamp(2, totalPages - 1);
      }
      if (widget.current >= totalPages - 3) {
        start = (totalPages - 4).clamp(2, totalPages - 1);
        end = totalPages - 1;
      }
      
      for (int i = start; i <= end; i++) {
        pages.add(_buildPageButton(
          text: '$i',
          isActive: i == widget.current,
          onPressed: () => widget.onPageChange?.call(i),
        ));
      }
      
      if (widget.current < totalPages - 3) {
        pages.add(_buildPageButton(
          text: '...',
          isActive: false,
          onPressed: null,
          isEllipsis: true,
        ));
      }
      
      pages.add(_buildPageButton(
        text: '$totalPages',
        isActive: widget.current == totalPages,
        onPressed: () => widget.onPageChange?.call(totalPages),
      ));
    }
    
    return pages;
  }

  /// 构建跳转输入框
  Widget _buildJumpInput() {
    if (widget.simple) return const SizedBox.shrink();
    
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '跳至',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 50,
            height: 32,
            child: TextField(
              controller: _jumpController,
              enabled: !widget.disabled,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(color: Color(0xFF165DFF)),
                ),
              ),
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                final page = int.tryParse(value);
                if (page != null && page >= 1 && page <= totalPages) {
                  widget.onPageChange?.call(page);
                }
                _jumpController.clear();
              },
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '页',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  /// 构建简单模式
  Widget _buildSimpleMode() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: widget.disabled || widget.current <= 1
              ? null
              : () => widget.onPageChange?.call(widget.current - 1),
          icon: const Icon(Icons.chevron_left),
          iconSize: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '${widget.current} / $totalPages',
            style: const TextStyle(fontSize: 14),
          ),
        ),
        IconButton(
          onPressed: widget.disabled || widget.current >= totalPages
              ? null
              : () => widget.onPageChange?.call(widget.current + 1),
          icon: const Icon(Icons.chevron_right),
          iconSize: 20,
        ),
      ],
    );
  }

  /// 构建上一页、下一页按钮
  Widget _buildPageUpDownButton({IconData? icon, bool? disabled, required VoidCallback? onPressed}) {
    return GiArcoButton(
      type: GiArcoButtonType.normal,
      shape: GiArcoButtonShape.rect,
      size: GiArcoButtonSize.small,
      disabled: disabled ?? false,
      onPressed: onPressed,
      child: Icon(icon, size: 16),
    );
  }

  /// 显示/隐藏 每页条数 弹层（与 GiIconSelector 风格一致的 Overlay）
  void _togglePageSizePopover() {
    if (_isPageSizeOpen) {
      _removePageSizePopover();
    } else {
      _showPageSizePopover();
    }
  }

  void _showPageSizePopover() {
    if (_pageSizeOverlay != null) return;
    final RenderBox box = _pageSizeFieldKey.currentContext!.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);
    final Size size = box.size;
    final double panelHeight = math.min((widget.pageSizeOptions.length * 36.0) + 12.0, 240.0);

    _pageSizeOverlay = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _removePageSizePopover,
                child: const SizedBox(),
              ),
            ),
            Positioned(
              left: position.dx,
              top: position.dy - panelHeight - 6,
              width: size.width,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                clipBehavior: Clip.antiAlias,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 120, maxHeight: 240),
                  child: Container(
                    color: Colors.white,
                    child: SizedBox(
                      width: size.width,
                      height: panelHeight,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        shrinkWrap: true,
                        children: [
                          for (final sizeOption in widget.pageSizeOptions)
                            _buildPageSizeItem(sizeOption),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
    Overlay.of(context).insert(_pageSizeOverlay!);
    setState(() => _isPageSizeOpen = true);
  }

  void _removePageSizePopover() {
    _pageSizeOverlay?.remove();
    _pageSizeOverlay = null;
    if (_isPageSizeOpen) setState(() => _isPageSizeOpen = false);
  }

  Widget _buildPageSizeItem(int sizeOption) {
    final bool selected = sizeOption == widget.pageSize;
    return InkWell(
      onTap: widget.disabled
          ? null
          : () {
              if (sizeOption != widget.pageSize) {
                widget.onPageSizeChange?.call(sizeOption);
              }
              _removePageSizePopover();
            },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFEFF5FF) : Colors.white,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (selected) ...[
              const Icon(Icons.check, size: 14, color: Color(0xFF165DFF)),
              const SizedBox(width: 6),
            ],
            Text(
              '$sizeOption 条/页',
              style: TextStyle(
                fontSize: 14,
                color: selected ? const Color(0xFF165DFF) : Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建完整模式
  Widget _buildFullMode() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildTotalText(),
        _buildPageSizeSelector(),
        // 上一页按钮
        _buildPageUpDownButton(
          icon: Icons.chevron_left,
          disabled: widget.disabled || widget.current <= 1,
          onPressed: widget.current <= 1
              ? null
              : () => widget.onPageChange?.call(widget.current - 1),
        ),
        // 页码按钮
        ...(_buildPageNumbers()),
        // 下一页按钮
        _buildPageUpDownButton(
          icon: Icons.chevron_right,
          disabled: widget.disabled || widget.current >= totalPages,
          onPressed: widget.current >= totalPages
              ? null
              : () => widget.onPageChange?.call(widget.current + 1),
        ),
        _buildJumpInput(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (totalPages <= 1) return const SizedBox.shrink();
    return Container(
      height: 65,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget.simple ? _buildSimpleMode() : _buildFullMode(),
        ],
      ),
    );
  }
}
