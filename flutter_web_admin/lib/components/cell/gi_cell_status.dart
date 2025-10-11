import 'package:flutter/material.dart';

/// 状态配置类
class GiStatusConfig {
  final String text;
  final Color color;
  final Color? backgroundColor;
  final IconData? icon;

  const GiStatusConfig({
    required this.text,
    required this.color,
    this.backgroundColor,
    this.icon,
  });
}

/// Gi 状态单元格组件
/// 
/// 用于在表格中显示状态信息，支持自定义状态配置
/// 
/// 使用示例：
/// ```dart
/// // 基本使用（默认配置）
/// GiCellStatus(status: 1) // 正常
/// GiCellStatus(status: 0) // 禁用
/// 
/// // 自定义状态配置
/// GiCellStatus(
///   status: 2,
///   statusConfig: {
///     0: GiStatusConfig(text: '待审核', color: Colors.orange, icon: Icons.pending),
///     1: GiStatusConfig(text: '已通过', color: Colors.green, icon: Icons.check_circle),
///     2: GiStatusConfig(text: '已拒绝', color: Colors.red, icon: Icons.cancel),
///   },
/// )
/// 
/// // 自定义样式
/// GiCellStatus(
///   status: 1,
///   size: GiStatusSize.large,
///   showIcon: false,
/// )
/// ```
class GiCellStatus extends StatelessWidget {
  /// 状态值
  final int status;
  
  /// 状态配置映射
  final Map<int, GiStatusConfig>? statusConfig;
  
  /// 尺寸
  final GiStatusSize size;
  
  /// 是否显示图标
  final bool showIcon;
  
  /// 自定义样式
  final TextStyle? textStyle;
  
  /// 自定义背景色透明度
  final double backgroundOpacity;

  const GiCellStatus({
    Key? key,
    required this.status,
    this.statusConfig,
    this.size = GiStatusSize.small,
    this.showIcon = true,
    this.textStyle,
    this.backgroundOpacity = 0.1,
  }) : super(key: key);

  /// 默认状态配置
  static const Map<int, GiStatusConfig> _defaultStatusConfig = {
    0: GiStatusConfig(
      text: '禁用',
      color: Colors.red,
      icon: Icons.cancel,
    ),
    1: GiStatusConfig(
      text: '正常',
      color: Colors.blue,
      icon: Icons.check_circle,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final config = statusConfig?[status] ?? _defaultStatusConfig[status];
    
    if (config == null) {
      return Text(
        '未知状态',
        style: TextStyle(
          color: Colors.grey,
          fontSize: _getFontSize(),
        ),
      );
    }

    return Container(
      padding: _getPadding(),
      decoration: BoxDecoration(
        color: (config.backgroundColor ?? config.color).withOpacity(backgroundOpacity),
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          color: config.color.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon && config.icon != null) ...[
            Icon(
              config.icon,
              size: _getIconSize(),
              color: config.color,
            ),
            SizedBox(width: _getIconSpacing()),
          ],
          Text(
            config.text,
            style: (textStyle ?? TextStyle(
              fontSize: _getFontSize(),
              fontWeight: FontWeight.w500,
            )).copyWith(
              color: config.color,
            ),
          ),
        ],
      ),
    );
  }

  /// 获取内边距
  EdgeInsets _getPadding() {
    switch (size) {
      case GiStatusSize.mini:
        return const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0);
      case GiStatusSize.small:
        return const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0);
      case GiStatusSize.medium:
        return const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0);
      case GiStatusSize.large:
        return const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0);
    }
  }

  /// 获取字体大小
  double _getFontSize() {
    switch (size) {
      case GiStatusSize.mini:
        return 10.0;
      case GiStatusSize.small:
        return 12.0;
      case GiStatusSize.medium:
        return 14.0;
      case GiStatusSize.large:
        return 16.0;
    }
  }

  /// 获取图标大小
  double _getIconSize() {
    switch (size) {
      case GiStatusSize.mini:
        return 12.0;
      case GiStatusSize.small:
        return 14.0;
      case GiStatusSize.medium:
        return 16.0;
      case GiStatusSize.large:
        return 18.0;
    }
  }

  /// 获取图标间距
  double _getIconSpacing() {
    switch (size) {
      case GiStatusSize.mini:
        return 2.0;
      case GiStatusSize.small:
        return 3.0;
      case GiStatusSize.medium:
        return 4.0;
      case GiStatusSize.large:
        return 5.0;
    }
  }
}

/// 状态尺寸枚举
enum GiStatusSize {
  mini,
  small,
  medium,
  large,
}

/// 常用状态配置预设
class GiStatusPresets {
  /// 启用/禁用状态
  static const Map<int, GiStatusConfig> enableDisable = {
    0: GiStatusConfig(text: '禁用', color: Colors.red, icon: Icons.block),
    1: GiStatusConfig(text: '启用', color: Colors.green, icon: Icons.check_circle),
  };

  /// 审核状态
  static const Map<int, GiStatusConfig> audit = {
    0: GiStatusConfig(text: '待审核', color: Colors.orange, icon: Icons.pending),
    1: GiStatusConfig(text: '已通过', color: Colors.green, icon: Icons.check_circle),
    2: GiStatusConfig(text: '已拒绝', color: Colors.red, icon: Icons.cancel),
  };

  /// 订单状态
  static const Map<int, GiStatusConfig> order = {
    0: GiStatusConfig(text: '待支付', color: Colors.orange, icon: Icons.payment),
    1: GiStatusConfig(text: '已支付', color: Colors.blue, icon: Icons.check_circle),
    2: GiStatusConfig(text: '已发货', color: Colors.purple, icon: Icons.local_shipping),
    3: GiStatusConfig(text: '已完成', color: Colors.green, icon: Icons.done_all),
    4: GiStatusConfig(text: '已取消', color: Colors.red, icon: Icons.cancel),
  };

  /// 用户状态
  static const Map<int, GiStatusConfig> user = {
    0: GiStatusConfig(text: '未激活', color: Colors.grey, icon: Icons.person_outline),
    1: GiStatusConfig(text: '正常', color: Colors.green, icon: Icons.person),
    2: GiStatusConfig(text: '锁定', color: Colors.red, icon: Icons.lock),
    3: GiStatusConfig(text: '注销', color: Colors.grey, icon: Icons.person_off),
  };
}
