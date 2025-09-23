import 'package:flutter/material.dart';

/// 性别配置类
class GiGenderConfig {
  final String text;
  final Color color;
  final Color? backgroundColor;
  final IconData icon;

  const GiGenderConfig({
    required this.text,
    required this.color,
    this.backgroundColor,
    required this.icon,
  });
}

/// Gi 性别单元格组件
/// 
/// 用于在表格中显示性别信息，支持自定义样式
/// 
/// 使用示例：
/// ```dart
/// // 基本使用
/// GiCellGender(gender: 1) // 男
/// GiCellGender(gender: 2) // 女
/// GiCellGender(gender: 3) // 保密
/// 
/// // 自定义配置
/// GiCellGender(
///   gender: 1,
///   genderConfig: {
///     1: GiGenderConfig(text: 'Male', color: Colors.blue, icon: Icons.male),
///     2: GiGenderConfig(text: 'Female', color: Colors.pink, icon: Icons.female),
///   },
/// )
/// 
/// // 自定义样式
/// GiCellGender(
///   gender: 2,
///   size: GiGenderSize.large,
///   showIcon: false,
///   round: true,
/// )
/// ```
class GiCellGender extends StatelessWidget {
  /// 性别值（1: 男, 2: 女, 3: 保密）
  final int gender;
  
  /// 性别配置映射
  final Map<int, GiGenderConfig>? genderConfig;
  
  /// 尺寸
  final GiGenderSize size;
  
  /// 是否显示图标
  final bool showIcon;
  
  /// 是否圆角
  final bool round;
  
  /// 自定义文字样式
  final TextStyle? textStyle;
  
  /// 背景色透明度
  final double backgroundOpacity;

  const GiCellGender({
    Key? key,
    required this.gender,
    this.genderConfig,
    this.size = GiGenderSize.small,
    this.showIcon = true,
    this.round = true,
    this.textStyle,
    this.backgroundOpacity = 0.1,
  }) : super(key: key);

  /// 默认性别配置
  static const Map<int, GiGenderConfig> _defaultGenderConfig = {
    1: GiGenderConfig(
      text: '男',
      color: Colors.blue,
      icon: Icons.male,
    ),
    2: GiGenderConfig(
      text: '女',
      color: Color(0xFFE91E63), // 粉色
      icon: Icons.female,
    ),
    3: GiGenderConfig(
      text: '保密',
      color: Colors.grey,
      icon: Icons.lock_outline,
    ),
  };

  @override
  Widget build(BuildContext context) {
    final config = genderConfig?[gender] ?? _defaultGenderConfig[gender];
    
    if (config == null) {
      return Text(
        '未知',
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
        borderRadius: BorderRadius.circular(round ? 20.0 : 4.0),
        border: Border.all(
          color: config.color.withOpacity(0.3),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
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
      case GiGenderSize.mini:
        return const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0);
      case GiGenderSize.small:
        return const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0);
      case GiGenderSize.medium:
        return const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0);
      case GiGenderSize.large:
        return const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0);
    }
  }

  /// 获取字体大小
  double _getFontSize() {
    switch (size) {
      case GiGenderSize.mini:
        return 10.0;
      case GiGenderSize.small:
        return 12.0;
      case GiGenderSize.medium:
        return 14.0;
      case GiGenderSize.large:
        return 16.0;
    }
  }

  /// 获取图标大小
  double _getIconSize() {
    switch (size) {
      case GiGenderSize.mini:
        return 12.0;
      case GiGenderSize.small:
        return 14.0;
      case GiGenderSize.medium:
        return 16.0;
      case GiGenderSize.large:
        return 18.0;
    }
  }

  /// 获取图标间距
  double _getIconSpacing() {
    switch (size) {
      case GiGenderSize.mini:
        return 2.0;
      case GiGenderSize.small:
        return 3.0;
      case GiGenderSize.medium:
        return 4.0;
      case GiGenderSize.large:
        return 5.0;
    }
  }
}

/// 性别尺寸枚举
enum GiGenderSize {
  mini,
  small,
  medium,
  large,
}

/// 性别配置预设
class GiGenderPresets {
  /// 中文性别配置
  static const Map<int, GiGenderConfig> chinese = {
    1: GiGenderConfig(text: '男', color: Colors.blue, icon: Icons.male),
    2: GiGenderConfig(text: '女', color: Color(0xFFE91E63), icon: Icons.female),
    3: GiGenderConfig(text: '保密', color: Colors.grey, icon: Icons.lock_outline),
  };

  /// 英文性别配置
  static const Map<int, GiGenderConfig> english = {
    1: GiGenderConfig(text: 'Male', color: Colors.blue, icon: Icons.male),
    2: GiGenderConfig(text: 'Female', color: Color(0xFFE91E63), icon: Icons.female),
    3: GiGenderConfig(text: 'Secret', color: Colors.grey, icon: Icons.lock_outline),
  };

  /// 简写性别配置
  static const Map<int, GiGenderConfig> short = {
    1: GiGenderConfig(text: 'M', color: Colors.blue, icon: Icons.male),
    2: GiGenderConfig(text: 'F', color: Color(0xFFE91E63), icon: Icons.female),
    3: GiGenderConfig(text: '?', color: Colors.grey, icon: Icons.lock_outline),
  };

  /// 符号性别配置（仅图标）
  static const Map<int, GiGenderConfig> symbol = {
    1: GiGenderConfig(text: '', color: Colors.blue, icon: Icons.male),
    2: GiGenderConfig(text: '', color: Color(0xFFE91E63), icon: Icons.female),
    3: GiGenderConfig(text: '', color: Colors.grey, icon: Icons.lock_outline),
  };
}
