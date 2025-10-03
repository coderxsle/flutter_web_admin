import 'package:flutter/material.dart';
import '../common/gi_space.dart';

/// Gi 标签单元格组件
/// 
/// 用于在表格中显示多个标签，支持溢出显示和弹窗展示
/// 
/// 使用示例：
/// ```dart
/// // 基本使用
/// GiCellTags(
///   data: ['Flutter', 'Dart', 'Mobile'],
/// )
/// 
/// // 限制显示数量
/// GiCellTags(
///   data: ['Java', 'Spring', 'MySQL', 'Redis', 'Docker'],
///   maxVisible: 3,
/// )
/// 
/// // 自定义样式
/// GiCellTags(
///   data: ['前端', '后端', '全栈'],
///   tagColor: Colors.blue,
///   size: GiTagSize.medium,
/// )
/// 
/// // 自定义标签构建器
/// GiCellTags(
///   data: ['重要', '紧急', '待办'],
///   tagBuilder: (context, tag, index) => Container(
///     padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
///     decoration: BoxDecoration(
///       color: Colors.red.withOpacity(0.1),
///       borderRadius: BorderRadius.circular(12),
///     ),
///     child: Text(tag, style: TextStyle(color: Colors.red)),
///   ),
/// )
/// ```
class GiCellTags extends StatelessWidget {
  /// 标签数据
  final List<String> data;
  
  /// 最大可见标签数量
  final int maxVisible;
  
  /// 标签尺寸
  final GiTagSize size;
  
  /// 标签颜色
  final Color? tagColor;
  
  /// 标签背景色
  final Color? tagBackgroundColor;
  
  /// 溢出标签颜色
  final Color? overflowTagColor;
  
  /// 标签间距
  final double spacing;
  
  /// 是否显示溢出提示
  final bool showOverflow;
  
  /// 自定义标签构建器
  final Widget Function(BuildContext context, String tag, int index)? tagBuilder;
  
  /// 溢出标签点击回调
  final VoidCallback? onOverflowTap;

  const GiCellTags({
    Key? key,
    required this.data,
    this.maxVisible = 3,
    this.size = GiTagSize.small,
    this.tagColor,
    this.tagBackgroundColor,
    this.overflowTagColor,
    this.spacing = 4.0,
    this.showOverflow = true,
    this.tagBuilder,
    this.onOverflowTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const SizedBox.shrink();
    }

    // 如果数据量小于等于最大可见数量，直接显示所有标签
    if (data.length <= maxVisible) {
      return _buildTagList(context, data);
    }

    // 显示部分标签和溢出提示
    final visibleTags = data.take(maxVisible).toList();
    final overflowCount = data.length - maxVisible;

    return GiSpace(
      spacing: spacing,
      wrap: true,
      children: [
        ..._buildTags(context, visibleTags),
        if (showOverflow && overflowCount > 0)
          _buildOverflowTag(context, overflowCount),
      ],
    );
  }

  /// 构建标签列表
  Widget _buildTagList(BuildContext context, List<String> tags) {
    return GiSpace(
      spacing: spacing,
      wrap: true,
      children: _buildTags(context, tags),
    );
  }

  /// 构建标签组件列表
  List<Widget> _buildTags(BuildContext context, List<String> tags) {
    return tags.asMap().entries.map((entry) {
      final index = entry.key;
      final tag = entry.value;
      
      if (tagBuilder != null) {
        return tagBuilder!(context, tag, index);
      }
      
      return _buildDefaultTag(context, tag);
    }).toList();
  }

  /// 构建默认标签
  Widget _buildDefaultTag(BuildContext context, String tag) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Container(
      padding: _getTagPadding(),
      decoration: BoxDecoration(
        color: tagBackgroundColor ?? colorScheme.primaryContainer.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: (tagColor ?? colorScheme.primary).withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: tagColor ?? colorScheme.primary,
          fontSize: _getFontSize(),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// 构建溢出标签
  Widget _buildOverflowTag(BuildContext context, int overflowCount) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    final overflowTag = Container(
      padding: _getTagPadding(),
      decoration: BoxDecoration(
        color: (overflowTagColor ?? colorScheme.secondary).withOpacity(0.1),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: (overflowTagColor ?? colorScheme.secondary).withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Text(
        '+$overflowCount',
        style: TextStyle(
          color: overflowTagColor ?? colorScheme.secondary,
          fontSize: _getFontSize(),
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    // 如果有点击回调或者需要显示详情，包装为可点击的组件
    if (onOverflowTap != null) {
      return GestureDetector(
        onTap: onOverflowTap,
        child: overflowTag,
      );
    }

    // 默认显示弹窗
    return GestureDetector(
      onTap: () => _showOverflowDialog(context),
      child: overflowTag,
    );
  }

  /// 显示溢出标签弹窗
  void _showOverflowDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('所有标签'),
        content: Container(
          width: double.maxFinite,
          constraints: const BoxConstraints(maxHeight: 300),
          child: SingleChildScrollView(
            child: GiSpace(
              spacing: spacing,
              runSpacing: spacing,
              wrap: true,
              children: _buildTags(context, data),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  /// 获取标签内边距
  EdgeInsets _getTagPadding() {
    switch (size) {
      case GiTagSize.mini:
        return const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0);
      case GiTagSize.small:
        return const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0);
      case GiTagSize.medium:
        return const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);
      case GiTagSize.large:
        return const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0);
    }
  }

  /// 获取字体大小
  double _getFontSize() {
    switch (size) {
      case GiTagSize.mini:
        return 10.0;
      case GiTagSize.small:
        return 12.0;
      case GiTagSize.medium:
        return 14.0;
      case GiTagSize.large:
        return 16.0;
    }
  }
}

/// 标签尺寸枚举
enum GiTagSize {
  mini,
  small,
  medium,
  large,
}

/// 标签样式预设
class GiTagPresets {
  /// 技能标签样式
  static Widget skillTag(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade400, Colors.blue.shade600],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        skill,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// 状态标签样式
  static Widget statusTag(String status, {Color? color}) {
    final tagColor = color ?? _getStatusColor(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: tagColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: tagColor.withOpacity(0.5)),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: tagColor,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  /// 根据状态文本获取颜色
  static Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case '重要':
      case 'important':
        return Colors.red;
      case '紧急':
      case 'urgent':
        return Colors.orange;
      case '正常':
      case 'normal':
        return Colors.blue;
      case '完成':
      case 'completed':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }
}
