import 'package:flutter/material.dart';

/// 标签类型枚举
enum GiTagType {
  light,        /// 浅色背景
  dark,         /// 深色背景
  outline,      /// 边框样式
  lightOutline, /// 浅色边框
}

/// 标签状态枚举
enum GiTagStatus {
  primary,  /// 主要
  success,  /// 成功
  warning,  /// 警告
  danger,   /// 危险
  info,     /// 信息
}

/// 标签尺寸枚举
enum GiTagSize {
  mini,   /// 迷你尺寸
  small,  /// 小尺寸
  large,  /// 大尺寸
}

/// Gi 标签组件
/// 
/// 提供多样化的标签展示，支持多种样式类型、状态、颜色和大小
/// 
/// 使用示例：
/// ```dart
/// GiTag(
///   text: '标签',
///   type: GiTagType.light,
///   status: GiTagStatus.primary,
///   size: GiTagSize.small,
///   closable: true,
///   onClose: () => print('关闭标签'),
/// )
/// ```
class GiTag extends StatelessWidget {
  final String text;                    /// 标签文本
  final GiTagType type;                 /// 标签类型
  final GiTagStatus status;             /// 标签状态
  final String? color;                  /// 自定义颜色
  final GiTagSize size;                 /// 标签尺寸
  final bool closable;                  /// 是否可关闭
  final VoidCallback? onTap;            /// 点击回调
  final VoidCallback? onClose;          /// 关闭回调

  const GiTag({
    super.key,
    required this.text,
    this.type = GiTagType.light,
    this.status = GiTagStatus.primary,
    this.color,
    this.size = GiTagSize.small,
    this.closable = false,
    this.onTap,
    this.onClose,
  });

  /// 基础颜色映射表
  static const Map<String, Color> _baseColors = {
    'red': Color(0xFFFF0000),
    'orangered': Color(0xFFf77234),
    'orange': Color(0xFFff7d00),
    'gold': Color(0xFFf7ba1e),
    'lime': Color(0xFF9fdb1d),
    'green': Color(0xFF00b42a),
    'cyan': Color(0xFF14c9c9),
    'blue': Color(0xFF3491fa),
    'purple': Color(0xFF722ed1),
    'pink': Color(0xFFf5319d),
    'gray': Color(0xFF86909c),
  };

  /// 状态颜色映射表
  static const Map<GiTagStatus, Color> _statusColors = {
    GiTagStatus.primary: Color(0xFF3491fa),
    GiTagStatus.success: Color(0xFF00b42a),
    GiTagStatus.warning: Color(0xFFff7d00),
    GiTagStatus.danger: Color(0xFFFF0000),
    GiTagStatus.info: Color(0xFF86909c),
  };

  /// 获取尺寸配置
  Map<String, double> get _sizeConfig {
    switch (size) {
      case GiTagSize.mini:
        return {'height': 20.0, 'padding': 6.0, 'fontSize': 12.0};
      case GiTagSize.small:
        return {'height': 22.0, 'padding': 8.0, 'fontSize': 12.0};
      case GiTagSize.large:
        return {'height': 24.0, 'padding': 10.0, 'fontSize': 12.0};
    }
  }

  /// 获取颜色值
  Color get _tagColor {
    if (color != null) {
      // 如果是预设颜色名
      if (_baseColors.containsKey(color)) {
        return _baseColors[color]!;
      }
      // 如果是十六进制颜色值
      if (color!.startsWith('#')) {
        final hex = color!.replaceFirst('#', '');
        return Color(int.parse('FF$hex', radix: 16));
      }
    }
    return _statusColors[status]!;
  }

  /// 获取样式配置
  Map<String, dynamic> get _styleConfig {
    final tagColor = _tagColor;
    final Map<String, dynamic> config = {};

    switch (type) {
      case GiTagType.light:
        config['textColor'] = tagColor;
        config['backgroundColor'] = tagColor.withOpacity(0.1);
        config['borderColor'] = Colors.transparent;
        config['borderWidth'] = 0.0;
        break;
      case GiTagType.dark:
        config['textColor'] = Colors.white;
        config['backgroundColor'] = tagColor;
        config['borderColor'] = Colors.transparent;
        config['borderWidth'] = 0.0;
        break;
      case GiTagType.outline:
        config['textColor'] = tagColor;
        config['backgroundColor'] = Colors.transparent;
        config['borderColor'] = tagColor;
        config['borderWidth'] = 1.0;
        break;
      case GiTagType.lightOutline:
        config['textColor'] = tagColor;
        config['backgroundColor'] = tagColor.withOpacity(0.1);
        config['borderColor'] = tagColor.withOpacity(0.2);
        config['borderWidth'] = 1.0;
        break;
    }

    return config;
  }

  @override
  Widget build(BuildContext context) {
    final sizeConfig = _sizeConfig;
    final styleConfig = _styleConfig;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: sizeConfig['height'],
        padding: EdgeInsets.symmetric(horizontal: sizeConfig['padding']!),
        decoration: BoxDecoration(
          color: styleConfig['backgroundColor'],
          border: styleConfig['borderWidth'] > 0
              ? Border.all(
                  color: styleConfig['borderColor'],
                  width: styleConfig['borderWidth'],
                )
              : null,
          borderRadius: BorderRadius.circular(3.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: styleConfig['textColor'],
                fontSize: sizeConfig['fontSize'],
                height: 1.0,
              ),
            ),
            if (closable) ...[
              const SizedBox(width: 4),
              _buildCloseButton(styleConfig),
            ],
          ],
        ),
      ),
    );
  }

  /// 构建关闭按钮
  Widget _buildCloseButton(Map<String, dynamic> styleConfig) {
    final iconSize = size == GiTagSize.mini ? 10.0 : 12.0;
    final buttonSize = size == GiTagSize.mini ? 14.0 : 16.0;

    return GestureDetector(
      onTap: () {
        onClose?.call();
      },
      child: Container(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(buttonSize / 2),
        ),
        child: Icon(
          Icons.close,
          size: iconSize,
          color: styleConfig['textColor'],
        ),
      ),
    );
  }
}

/// Gi 标签工厂类
/// 
/// 提供快速创建不同类型标签的静态方法
class GiTagFactory {
  /// 创建主要标签
  static GiTag primary(
    String text, {
    GiTagType type = GiTagType.light,
    GiTagSize size = GiTagSize.small,
    bool closable = false,
    VoidCallback? onTap,
    VoidCallback? onClose,
  }) {
    return GiTag(
      text: text,
      type: type,
      status: GiTagStatus.primary,
      size: size,
      closable: closable,
      onTap: onTap,
      onClose: onClose,
    );
  }

  /// 创建成功标签
  static GiTag success(
    String text, {
    GiTagType type = GiTagType.light,
    GiTagSize size = GiTagSize.small,
    bool closable = false,
    VoidCallback? onTap,
    VoidCallback? onClose,
  }) {
    return GiTag(
      text: text,
      type: type,
      status: GiTagStatus.success,
      size: size,
      closable: closable,
      onTap: onTap,
      onClose: onClose,
    );
  }

  /// 创建警告标签
  static GiTag warning(
    String text, {
    GiTagType type = GiTagType.light,
    GiTagSize size = GiTagSize.small,
    bool closable = false,
    VoidCallback? onTap,
    VoidCallback? onClose,
  }) {
    return GiTag(
      text: text,
      type: type,
      status: GiTagStatus.warning,
      size: size,
      closable: closable,
      onTap: onTap,
      onClose: onClose,
    );
  }

  /// 创建危险标签
  static GiTag danger(
    String text, {
    GiTagType type = GiTagType.light,
    GiTagSize size = GiTagSize.small,
    bool closable = false,
    VoidCallback? onTap,
    VoidCallback? onClose,
  }) {
    return GiTag(
      text: text,
      type: type,
      status: GiTagStatus.danger,
      size: size,
      closable: closable,
      onTap: onTap,
      onClose: onClose,
    );
  }

  /// 创建信息标签
  static GiTag info(
    String text, {
    GiTagType type = GiTagType.light,
    GiTagSize size = GiTagSize.small,
    bool closable = false,
    VoidCallback? onTap,
    VoidCallback? onClose,
  }) {
    return GiTag(
      text: text,
      type: type,
      status: GiTagStatus.info,
      size: size,
      closable: closable,
      onTap: onTap,
      onClose: onClose,
    );
  }

  /// 创建自定义颜色标签
  static GiTag color(
    String text,
    String color, {
    GiTagType type = GiTagType.light,
    GiTagSize size = GiTagSize.small,
    bool closable = false,
    VoidCallback? onTap,
    VoidCallback? onClose,
  }) {
    return GiTag(
      text: text,
      type: type,
      color: color,
      size: size,
      closable: closable,
      onTap: onTap,
      onClose: onClose,
    );
  }
}
