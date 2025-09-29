import 'package:flutter/material.dart';

/// 通用按钮组件集合
/// 使用 InkWell 封装的各种常用按钮样式

/// 主要按钮 - 用于重要操作
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;

  const PrimaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height = 48,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = onPressed != null && !isLoading;
    
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: backgroundColor ?? theme.primaryColor,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: isEnabled 
                ? null 
                : Border.all(color: Colors.grey.withOpacity(0.3)),
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          textColor ?? Colors.white,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(
                            icon,
                            size: 18,
                            color: textColor ?? Colors.white,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          text,
                          style: TextStyle(
                            color: isEnabled 
                              ? (textColor ?? Colors.white)
                              : Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 次要按钮 - 用于次要操作
class SecondaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final double height;
  final Color? borderColor;
  final Color? textColor;
  final Color? backgroundColor;
  final double borderRadius;

  const SecondaryButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height = 48,
    this.borderColor,
    this.textColor,
    this.backgroundColor,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = onPressed != null && !isLoading;
    
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: (borderColor ?? theme.primaryColor).withOpacity(0.1),
          highlightColor: (borderColor ?? theme.primaryColor).withOpacity(0.05),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: isEnabled 
                  ? (borderColor ?? theme.primaryColor)
                  : Colors.grey.withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          textColor ?? theme.primaryColor,
                        ),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(
                            icon,
                            size: 18,
                            color: isEnabled 
                              ? (textColor ?? theme.primaryColor)
                              : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          text,
                          style: TextStyle(
                            color: isEnabled 
                              ? (textColor ?? theme.primaryColor)
                              : Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 文本按钮 - 用于链接样式操作
class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? textColor;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsets padding;

  const CustomTextButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.textColor,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = onPressed != null;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(4),
        splashColor: (textColor ?? theme.primaryColor).withOpacity(0.1),
        highlightColor: (textColor ?? theme.primaryColor).withOpacity(0.05),
        child: Padding(
          padding: padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: fontSize,
                  color: isEnabled 
                    ? (textColor ?? theme.primaryColor)
                    : Colors.grey,
                ),
                const SizedBox(width: 4),
              ],
              Text(
                text,
                style: TextStyle(
                  color: isEnabled 
                    ? (textColor ?? theme.primaryColor)
                    : Colors.grey,
                  fontSize: fontSize,
                  fontWeight: fontWeight,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 图标按钮 - 用于工具栏或操作栏
class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? iconColor;
  final Color? backgroundColor;
  final double size;
  final double borderRadius;
  final EdgeInsets padding;

  const CustomIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.iconColor,
    this.backgroundColor,
    this.size = 40,
    this.borderRadius = 8,
    this.padding = const EdgeInsets.all(8),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = onPressed != null;
    
    Widget button = Material(
      color: backgroundColor ?? Colors.transparent,
      borderRadius: BorderRadius.circular(borderRadius),
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(borderRadius),
        splashColor: (iconColor ?? theme.primaryColor).withOpacity(0.1),
        highlightColor: (iconColor ?? theme.primaryColor).withOpacity(0.05),
        child: Container(
          width: size,
          height: size,
          padding: padding,
          child: Icon(
            icon,
            size: size * 0.5,
            color: isEnabled 
              ? (iconColor ?? theme.primaryColor)
              : Colors.grey,
          ),
        ),
      ),
    );

    if (tooltip != null && isEnabled) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}

/// 危险按钮 - 用于删除等危险操作
class DangerButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final double height;
  final double borderRadius;

  const DangerButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height = 48,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;
    
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: isEnabled ? Colors.red : Colors.red.withOpacity(0.3),
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(borderRadius),
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: isEnabled 
                ? null 
                : Border.all(color: Colors.grey.withOpacity(0.3)),
            ),
            child: Center(
              child: isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(
                            icon,
                            size: 18,
                            color: isEnabled ? Colors.white : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                        ],
                        Text(
                          text,
                          style: TextStyle(
                            color: isEnabled ? Colors.white : Colors.grey,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

/// 浮动操作按钮 - 用于主要操作
class CustomFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? iconColor;
  final double size;

  const CustomFloatingActionButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.tooltip,
    this.backgroundColor,
    this.iconColor,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnabled = onPressed != null;
    
    Widget button = Material(
      color: backgroundColor ?? theme.primaryColor,
      shape: const CircleBorder(),
      elevation: 6,
      shadowColor: Colors.black26,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(size / 2),
        splashColor: Colors.white.withOpacity(0.2),
        highlightColor: Colors.white.withOpacity(0.1),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isEnabled 
              ? (backgroundColor ?? theme.primaryColor)
              : Colors.grey.withOpacity(0.3),
          ),
          child: Icon(
            icon,
            size: size * 0.4,
            color: isEnabled 
              ? (iconColor ?? Colors.white)
              : Colors.grey,
          ),
        ),
      ),
    );

    if (tooltip != null && isEnabled) {
      return Tooltip(
        message: tooltip!,
        child: button,
      );
    }

    return button;
  }
}