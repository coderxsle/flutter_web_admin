import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../common/gi_space.dart';

/// Gi 头像单元格组件
/// 
/// 用于在表格中显示用户头像和姓名，支持点击事件
/// 
/// 使用示例：
/// ```dart
/// // 基本使用
/// GiCellAvatar(
///   avatar: 'https://example.com/avatar.jpg',
///   name: '张三',
/// )
/// 
/// // 可点击的头像
/// GiCellAvatar(
///   avatar: 'https://example.com/avatar.jpg',
///   name: '张三',
///   isLink: true,
///   onTap: () => print('点击了用户'),
/// )
/// 
/// // 自定义尺寸
/// GiCellAvatar(
///   name: '李四',
///   size: 32.0,
///   backgroundColor: Colors.blue,
/// )
/// ```
class GiCellAvatar extends StatelessWidget {
  /// 头像图片 URL
  final String? avatar;
  
  /// 用户姓名
  final String name;
  
  /// 头像尺寸
  final double size;
  
  /// 是否可点击
  final bool isLink;
  
  /// 点击回调
  final VoidCallback? onTap;
  
  /// 头像背景色（当没有头像图片时使用）
  final Color? backgroundColor;
  
  /// 文字颜色
  final Color? textColor;
  
  /// 间距
  final double spacing;
  
  /// 文字样式
  final TextStyle? textStyle;

  const GiCellAvatar({
    Key? key,
    this.avatar,
    required this.name,
    this.size = 24.0,
    this.isLink = false,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.spacing = 8.0,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GiSpace(
      spacing: spacing,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildAvatar(context),
        _buildName(context),
      ],
    );
  }

  /// 构建头像
  Widget _buildAvatar(BuildContext context) {
    final radius = size / 2;
    
    if (avatar != null && avatar!.isNotEmpty) {
      // 网络图片头像
      return CircleAvatar(
        radius: radius,
        backgroundColor: backgroundColor ?? Colors.grey[200],
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: avatar!,
            width: size,
            height: size,
            fit: BoxFit.cover,
            placeholder: (context, url) => _buildPlaceholderAvatar(radius),
            errorWidget: (context, url, error) => _buildPlaceholderAvatar(radius),
          ),
        ),
      );
    } else {
      // 文字头像
      return _buildPlaceholderAvatar(radius);
    }
  }
  
  /// 构建占位头像（显示姓名首字母）
  Widget _buildPlaceholderAvatar(double radius) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor ?? _getDefaultBackgroundColor(),
      child: Text(
        _getInitials(),
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontSize: size * 0.4,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  /// 构建姓名
  Widget _buildName(BuildContext context) {
    final nameWidget = Text(
      name,
      style: textStyle ?? TextStyle(
        color: textColor,
        fontSize: 14.0,
      ),
    );
    
    if (isLink && onTap != null) {
      return GestureDetector(
        onTap: onTap,
        child: Text(
          name,
          style: (textStyle ?? TextStyle(fontSize: 14.0)).copyWith(
            color: Theme.of(context).primaryColor,
            decoration: TextDecoration.underline,
          ),
        ),
      );
    }
    
    return nameWidget;
  }

  /// 获取姓名首字母
  String _getInitials() {
    if (name.isEmpty) return '?';
    
    // 处理中文姓名（取最后一个字符）
    if (name.length == 1) return name;
    
    // 处理英文姓名（取首字母）
    final words = name.trim().split(' ');
    if (words.length >= 2) {
      return '${words[0][0]}${words[1][0]}'.toUpperCase();
    }
    
    // 中文姓名取最后一个字
    return name.substring(name.length - 1);
  }

  /// 获取默认背景色（根据姓名生成）
  Color _getDefaultBackgroundColor() {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.indigo,
      Colors.pink,
    ];
    
    final hash = name.hashCode;
    return colors[hash.abs() % colors.length];
  }
}
