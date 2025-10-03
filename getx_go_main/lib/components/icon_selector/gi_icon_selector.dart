import 'package:flutter/material.dart';
import 'package:getx_go_main/components/svg_icon/gi_svg_icon.dart';
import 'material_icons.g.dart';

enum IconType {
  material,
  custom,
}

/// GiIconSelector 图标选择器组件
/// 
/// 用于选择图标的组件，支持Arco图标和自定义图标
class GiIconSelector extends StatefulWidget {
  /// 当前选中的图标
  final String? value;
  
  /// 图标类型：'material' 或 'custom'
  final IconType type;
  
  /// 占位符文本
  final String placeholder;
  
  /// 是否启用复制功能
  final bool enableCopy;
  
  /// 选择回调
  final Function(String)? onSelect;
  
  /// 值改变回调
  final Function(String)? onChanged;

  const GiIconSelector({
    super.key,
    this.value,
    this.type = IconType.material,
    this.placeholder = '请选择图标',
    this.enableCopy = false,
    this.onSelect,
    this.onChanged,
  });

  @override
  State<GiIconSelector> createState() => _GiIconSelectorState();
}

class _GiIconSelectorState extends State<GiIconSelector> {
  String? _selectedIcon;
  final GlobalKey _fieldKey = GlobalKey();
  OverlayEntry? _overlayEntry;
  bool _isOpen = false;
  
  // Arco图标列表（由生成文件提供的完整集合）
  late final List<String> _arcoIcons;
  
  // 自定义图标列表（真实的SVG图标）
  final List<String> _customIcons = [
    'alipay', 'arco', 'avatar_man', 'avatar_woman', 'backtop',
    'file_close', 'file_css', 'file_dir', 'file_excel', 'file_exe',
    'file_html', 'file_image', 'file_js', 'file_json', 'file_music',
    'file_open', 'file_other', 'file_pdf', 'file_ppt', 'file_rar',
    'file_txt', 'file_video', 'file_wps', 'file_zip', 'file',
    'icon_msg', 'icon_notice', 'icon_num', 'icon_user', 'icon_wait',
    'item_angular', 'item_github', 'item_html5', 'item_js', 'item_react', 'item_vue',
    'menu_about', 'menu_chart', 'menu_data', 'menu_detail', 'menu_document',
    'menu_error', 'menu_example', 'menu_file', 'menu_form', 'menu_gitee',
    'menu_home', 'menu_layout', 'menu_multi', 'menu_nav', 'menu_result',
    'menu_system', 'menu_table', 'menu_test', 'time', 'upload_file',
    'upload_folder', 'vite', 'vue', 'wechat'
  ];

  @override
  void initState() {
    super.initState();
    _selectedIcon = widget.value;
    // 使用构建期生成的完整 Material Icons 名称列表
    _arcoIcons = kMaterialIconNames;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePopover,
      child: Container(
        key: _fieldKey,
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: _selectedIcon != null && _selectedIcon!.isNotEmpty
                ? _buildIcon(_selectedIcon!, 16)
                : const Icon(Icons.search, size: 16, color: Colors.grey),
            ),
            Expanded(
              child: Text(
                (_selectedIcon != null && _selectedIcon!.isNotEmpty) ? _selectedIcon! : widget.placeholder,
                style: TextStyle(
                  color: (_selectedIcon != null && _selectedIcon!.isNotEmpty) ? Colors.black87 : Colors.grey,
                ),
              ),
            ),
            if (_selectedIcon != null && _selectedIcon!.isNotEmpty)
              GestureDetector(
                onTap: _clearSelection,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(Icons.clear, size: 16, color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 显示图标选择器
  void _showIconSelector() {
    if (_overlayEntry != null) return;
    final RenderBox box = _fieldKey.currentContext!.findRenderObject() as RenderBox;
    final Offset position = box.localToGlobal(Offset.zero);
    final Size size = box.size;

    _overlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: _removePopover,
                child: const SizedBox(),
              ),
            ),
            Positioned(
              left: position.dx,
              top: position.dy + size.height + 6,
              width: size.width,
              child: Material(
                elevation: 8,
                borderRadius: BorderRadius.circular(8),
                clipBehavior: Clip.antiAlias,
                child: _IconSelectorPanel(
                  type: widget.type,
                  selectedIcon: _selectedIcon,
                  arcoIcons: _arcoIcons,
                  customIcons: _customIcons,
                  onSelect: (icon) {
                    setState(() {
                      _selectedIcon = icon;
                    });
                    widget.onSelect?.call(icon);
                    widget.onChanged?.call(icon);
                    _removePopover();
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
    Overlay.of(context).insert(_overlayEntry!);
    _isOpen = true;
  }

  void _removePopover() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    _isOpen = false;
  }

  void _togglePopover() {
    if (_isOpen) {
      _removePopover();
    } else {
      _showIconSelector();
    }
  }

  /// 清除选择
  void _clearSelection() {
    setState(() {
      _selectedIcon = null;
    });
    widget.onChanged?.call('');
  }

  /// 构建图标
  Widget _buildIcon(String iconName, double size) {
    if (widget.type == IconType.material) {
      // 根据图标名称映射到Flutter的Material Icons
      IconData? iconData = getIconData(iconName);
      return Icon(iconData ?? Icons.help_outline, size: size);
    } else {
      // 自定义SVG图标
      return GiSvgIcon(
        name: iconName,
        size: size,
      );
    }
  }


}

/// 图标选择器对话框
class _IconSelectorPanel extends StatefulWidget {
  final IconType type;
  final String? selectedIcon;
  final List<String> arcoIcons;
  final List<String> customIcons;
  final Function(String) onSelect;

  const _IconSelectorPanel({
    required this.type,
    required this.selectedIcon,
    required this.arcoIcons,
    required this.customIcons,
    required this.onSelect,
  });

  @override
  State<_IconSelectorPanel> createState() => _IconSelectorPanelState();
}

class _IconSelectorPanelState extends State<_IconSelectorPanel> {
  bool _isGridView = true;
  int _currentPage = 1;
  final int _pageSize = 50;
  List<String> _filteredIcons = [];
  final Set<int> _hoveredGrid = <int>{};
  final Set<int> _hoveredList = <int>{};

  @override
  void initState() {
    super.initState();
    _filteredIcons = widget.type == IconType.material ? widget.arcoIcons : widget.customIcons;
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (_filteredIcons.length / _pageSize).ceil();
    final startIndex = (_currentPage - 1) * _pageSize;
    final endIndex = (startIndex + _pageSize).clamp(0, _filteredIcons.length);
    final currentPageIcons = _filteredIcons.sublist(startIndex, endIndex);

    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 420,
        minHeight: 220,
        minWidth: 260,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 2, 12),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 搜索和视图切换
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: '搜索图标名称',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                    onChanged: _onSearchChanged,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isGridView = !_isGridView;
                    });
                  },
                  icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // 图标列表
            Expanded(
              child: _isGridView ? _buildGridView(currentPageIcons) : _buildListView(currentPageIcons),
            ),
            
            // 分页
            if (totalPages > 1) ...[
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _currentPage > 1 ? () => _changePage(_currentPage - 1) : null,
                    icon: const Icon(Icons.chevron_left),
                  ),
                  Text('$_currentPage / $totalPages'),
                  IconButton(
                    onPressed: _currentPage < totalPages ? () => _changePage(_currentPage + 1) : null,
                    icon: const Icon(Icons.chevron_right),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// 构建网格视图
  Widget _buildGridView(List<String> icons) {
    return GridView.builder(
      padding: const EdgeInsets.only(right: 16), // GridView内部右边距
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        mainAxisSpacing: 6,
        crossAxisSpacing: 6,
        childAspectRatio: 1,
      ),
      itemCount: icons.length,
      itemBuilder: (context, index) {
        final icon = icons[index];
        final isSelected = widget.selectedIcon == icon;
        
        return MouseRegion(
          onEnter: (_) => setState(() => _hoveredGrid.add(index)),
          onExit: (_) => setState(() => _hoveredGrid.remove(index)),
          child: GestureDetector(
            onTap: () => widget.onSelect(icon),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.transparent,
                      style: BorderStyle.solid,
                    ),
                    color: isSelected ? Colors.blue.withValues(alpha: 0.08) : null,
                  ),
                  padding: const EdgeInsets.all(8), 
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: _buildIcon(icon, 40),
                    ),
                  ),
                ),
                if (!isSelected && _hoveredGrid.contains(index))
                  Positioned.fill(
                    child: IgnorePointer(
                      child: CustomPaint(
                        painter: _DashedRectPainter(
                          color: Colors.grey.shade400,
                          strokeWidth: 1,
                          dashWidth: 4,
                          gapWidth: 3,
                          radius: 6,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 构建列表视图（3列）
  Widget _buildListView(List<String> icons) {
    return GridView.builder(
      padding: const EdgeInsets.only(right: 16), // GridView内部右边距
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 10,
        crossAxisSpacing: 2,
        childAspectRatio: 3.5, // 宽:高，保证行高接近30且内容横向
      ),
      itemCount: icons.length,
      itemBuilder: (context, index) {
        final icon = icons[index];
        final isSelected = widget.selectedIcon == icon;

        return MouseRegion(
          onEnter: (_) => setState(() => _hoveredList.add(index)),
          onExit: (_) => setState(() => _hoveredList.remove(index)),
          child: GestureDetector(
            onTap: () => widget.onSelect(icon),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected ? Colors.blue : Colors.transparent,
                    ),
                    color: isSelected ? Colors.blue.withValues(alpha: 0.05) : null,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                  child: Row(
                    children: [
                      Center(
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: _buildIcon(icon, 40),
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          icon,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isSelected && _hoveredList.contains(index))
                  Positioned.fill(
                    child: IgnorePointer(
                      child: CustomPaint(
                        painter: _DashedRectPainter(
                          color: Colors.grey.shade400,
                          strokeWidth: 1,
                          dashWidth: 4,
                          gapWidth: 3,
                          radius: 6, // 与网格一致的圆角
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// 构建图标
  Widget _buildIcon(String iconName, double size) {
    if (widget.type == IconType.material) {
      IconData? iconData = getIconData(iconName);
      return Icon(iconData ?? Icons.help_outline, size: size);
    } else {
      return GiSvgIcon(
        name: iconName,
        size: size,
      );
    }
  }

  /// 搜索改变
  void _onSearchChanged(String value) {
    setState(() {
      _currentPage = 1;
      
      if (value.isEmpty) {
        _filteredIcons = widget.type == IconType.material ? widget.arcoIcons : widget.customIcons;
      } else {
        final icons = widget.type == IconType.material ? widget.arcoIcons : widget.customIcons;
        _filteredIcons = icons.where((icon) => 
          icon.toLowerCase().contains(value.toLowerCase())
        ).toList();
      }
    });
  }

  /// 改变页码
  void _changePage(int page) {
    setState(() {
      _currentPage = page;
    });
  }
}

/// 虚线矩形绘制器
class _DashedRectPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double gapWidth;
  final double radius;

  _DashedRectPainter({
    required this.color,
    required this.strokeWidth,
    required this.dashWidth,
    required this.gapWidth,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0.5, 0.5, size.width - 1, size.height - 1),
      Radius.circular(radius),
    );

    final Path path = Path()..addRRect(rrect);
    final metrics = path.computeMetrics();

    for (final metric in metrics) {
      double distance = 0.0;
      while (distance < metric.length) {
        final double next = distance + dashWidth;
        final Path extractPath = metric.extractPath(distance, next);
        canvas.drawPath(extractPath, paint);
        distance = next + gapWidth;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedRectPainter oldDelegate) {
    return color != oldDelegate.color ||
        strokeWidth != oldDelegate.strokeWidth ||
        dashWidth != oldDelegate.dashWidth ||
        gapWidth != oldDelegate.gapWidth ||
        radius != oldDelegate.radius;
  }
}
